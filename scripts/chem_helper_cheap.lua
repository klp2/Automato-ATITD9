
dofile("screen_reader_common.inc");
dofile("ui_utils.inc");

askText = "Due to the vast number of possible combinations that now exist with the new list of Resins, chem_helper has been broken into two scripts.\n\nchem_helper_cheap = Geb & Maat Soltions\n\nchem_helper = Set, Osiris, Thoth & Ra Solutions"

-- Initial values
compound_type = 6;
attrib_reqs = {
	{5,-1},
	{8,1},
	{7,1}
};

max_essences = 5;

compound_reqs = {
--	{"Test",1,15},
	{"Geb",2,4},
	{"Maat",2,7},
	{"Set",3,7},
	{"Osiris",2,10},
	{"Thoth",3,10},
	{"Ra",2,13}
};

mods = {
	[3]={"3",[-1]="-3"},
	[4]={"++",[-1]="--"},
	[6]={"6",[-1]="-6"},
	[7]={"+++",[-1]="---"},
	[9]={"9",[-1]="-9"},
	[10]={"++++",[-1]="----"},
	[12]={"12",[-1]="-12"},
	[13]={"+++++",[-1]="-----"},
	[15]={"15",[-1]="-15"},
};

attribs = {
	"Ar","As","Bi","Sa","So","Sp","Sw","To"
};

resin_list = {
"Anaxi","Arconis","Ash Palm","Beetlenut","Bloodbark","Bottle Tree","Broadleaf Palm","Butterleaf Tree","Cerulean Blue","Chakkanut Tree","Chicory","Cinnar","Coconut Palm","Cricklewood",
"Elephantia","Feather Tree","Fern Palm","Folded Birch","Giant Cricklewood","Hawthorn","Kaeshra","Locust Palm","Mini Palmetto","Miniature Fern Palm","Monkey Palm","Oil Palm","Oleaceae","Orrorin",
"Passam","Phoenix Palm","Pratyeka Tree","Ranyahn","Razor Palm","Red Maple","Royal Palm","Spiked Fishtree","Spindle Tree","Stout Palm","Tapacae Miralis","Tiny Oil Palm","Towering Palm","Trilobellia",
"Umbrella Palm","Windriver Palm"
}
resins = {};
for i=1,#resin_list do
	resins[resin_list[i]] = 1;
end

chem_data = {
{"Anaxi","16","6 Worm, 4 Wood","6","0","-3","1","0","0","3","2","-1"},
{"Arconis","85","1 Mineral, 1 Vegetable, 8 Grey","6","-3","2","0","3","0","-1","0","0"},
{"Ash Palm","41","5 Grain, 4 Vegetable, 1 Worm","6","0","-3","0","0","2","-1","-2","0"},
{"Beetlenut","55","9 Vegetable, 1 Wood","6","2","-2","0","0","0","1","0","-1"},
{"Bloodbark","13","7 Wood, 3 Worm","6","-2","0","2","-1","0","0","-3","3"},
{"Bottle Tree","89","9 Grey, 1 Fish","6","0","0","-3","3","-1","0","1","-2"},
{"Broadleaf Palm","78","8 Fish, 2 Mineral","6","-3","-2","0","1","-1","0","1","0"},
{"Butterleaf Tree","10","10 Wood","6","0","0","0","-1","-2","0","0","-3"},
{"Cerulean Blue","56","9 Vegetable, 1 Worm","6","0","-1","0","0","-3","2","0","1"},
{"Chakkanut Tree","11","9 Wood, 1 Worm","6","0","2","-1","1","0","-3","-2","3"},
{"Chicory","56","9 Vegetable, 1 Worm","6","0","-1","0","3","-3","0","0","1"},
{"Cinnar","67","7 Mineral, 3 Vegetable","6","0","3","0","0","0","1","-3","-1"},
{"Coconut Palm","26","6 Grain, 4 Worm","6","-2","0","-3","1","0","-1","0","0"},
{"Cricklewood","48","6 Vegetable, 4 Grain","6","0","2","-3","0","-1","3","0","-2"},
{"Elephantia","75","5 Fish, 5 Mineral","6","2","0","-1","0","0","3","-2","-3"},
{"Feather Tree","66","9 Mineral, 1 Grain","6","2","3","-1","0","-3","-2","0","1"},
{"Fern Palm","27","7 Grain, 3 Worm","6","-1","2","3","1","0","0","-2","-3"},
{"Folded Birch","20","5 Grain, 5 Wood","6","-1","0","-2","1","0","0","0","2"},
{"Giant Cricklewood","12","9 Wood, 1 Grain","6","0","-1","0","0","0","-3","1","0"},
{"Hawthorn","67","7 Mineral, 3 Vegetable","6","0","0","-2","3","0","0","2","-1"},
{"Kaeshra","71","9 Mineral, 1 Fish","6","0","-1","-3","0","1","0","0","0"},
{"Locust Palm","80","10 Fish","6","-1","0","0","0","-2","-3","0","3"},
{"Mini Palmetto","84","9 Grey, 1 Grain","6","0","-2","-1","0","0","0","-3","1"},
{"Miniature Fern Palm","50","5 Grain, 5 Mineral","6","3","2","-2","0","0","0","0","-1"},
{"Monkey Palm","47","6 Vegetable, 3 Grain, 1 Worm","6","-3","1","-2","0","-1","0","0","0"},
{"Oil Palm","20","5 Grain, 5 Wood","6","0","-1","1","0","-2","0","0","-3"},
{"Oleaceae","39","7 Grain, 3 Vegetable","6","0","-2","1","0","0","0","-1","0"},
{"Orrorin","70","10 Mineral","6","-3","1","0","0","0","-1","0","2"},
{"Passam","51","7 Vegetable, 3 Grain","6","1","-2","-3","-1","0","2","0","0"},
{"Phoenix Palm","62","8 Vegetable, 2 Mineral","6","0","0","3","-2","0","-3","-1","0"},
{"Pratyeka Tree","64","6 Vegetable, 4 Mineral","6","0","-3","1","3","-1","0","-2","0"},
{"Ranyahn","16","6 Worm, 4 Wood","6","-3","1","0","-1","0","0","0","-2"},
{"Razor Palm","28","8 Grain, 2 Worm","6","0","-2","1","0","0","-1","3","0"},
{"Red Maple","29","9 Grain, 1 Worm","6","0","-2","2","1","0","-1","-1","0"},
{"Royal Palm","23","7 Worm, 3 Grain","6","1","-3","0","3","-2","-1","0","0"},
{"Spiked Fishtree","82","10 Fish","6","-1","2","0","-2","0","-3","0","1"},
{"Spindle Tree","39","7 Grain, 3 Vegetable","6","2","0","3","-2","0","-3","-1","0"},
{"Stout Palm","16","6 Worm, 4 Wood","6","0","1","2","0","-1","-1","0","-3"},
{"Tapacae Miralis","77","7 Fish, 3 Mineral","6","-1","-3","0","3","0","0","0","1"},
{"Tiny Oil Palm","22","6 Grain, 4 Wood","6","0","-3","0","0","-2","0","-1","1"},
{"Towering Palm","88","9 Grey, 1 Mineral","6","0","0","-1","3","2","0","-3","0"},
{"Trilobellia","70","10 Mineral","6","-2","-1","1","0","0","2","-3","0"},
{"Umbrella Palm","59","7 Vegetable, 2 Mineral, 1 Grain","6","-1","2","0","3","1","0","-3","-2"},
{"Windriver Palm","35","7 Worm, 3 Mineral","6","2","3","0","1","-1","-2","-3","0"},
};

function color(s)
	if resins[s] then
		return 0xD0D080ff;
	else
		return 0x808080ff;
	end
end

solve_result = {};
solve_tooltip = {};
solve_lists = {};
dp = {};
dp_count = 0;

function addResult(s, tip)
	local index = #solve_result+1;
	solve_result[index] = s;
	solve_tooltip[index] = tip;
end

function key_from_vars(vars)
	local r = 0;
	local i;
	for i=1,#vars do
		r = r*100;
		r = r + vars[i]+50;
	end
	return r;
end

-- value is a list of essence indices
function cache(left, index, key, value)
	if not dp[left] then
		dp[left] = {};
	end
	if not dp[left][index] then
		dp[left][index] = {};
	end
	if not dp[left][index][key] then
		dp[left][index][key] = {};
	end
	dp[left][index][key][#dp[left][index][key]+1] = value;
end

function iscached(left, index, key)
	if not dp[left] then
		return nil;
	end
	if not dp[left][index] then
		return nil;
	end
	return dp[left][index][key];
end
-- returns a list of lists
function getcache(left, index, key)
	if not dp[left] then
		return nil;
	end
	if not dp[left][index] then
		return nil;
	end
	if not dp[left][index][key] then
		return nil;
	end
	if dp[left][index][key][1][1] == 0 then
		return nil;
	end
	return dp[left][index][key];
end


function dodp(left, index, vars)
	if (index > #chem_data) then
		return nil;
	end
	if (left == 0) then
		error 'assert';
	end
	local key=key_from_vars(vars);
	if iscached(left, index, key) then
		--lsPrintln("cached: " .. left .. "," .. index .. "," .. vars[1]);
		return getcache(left, index, key);
	end
	--lsPrintln("uncach: " .. left .. "," .. index .. "," .. vars[1]);
	dp_count = dp_count + 1;
	if (dp_count % 5000) == 0 then
		statusScreen("Solving...  Searched " .. dp_count .. "...");
	end
	local i;
	local j;

	-- Try not using this index	
	local ret = dodp(left, index+1, vars);
	if ret then
		for i=1, #ret do
			-- cache results of not using this one into this index
			cache(left, index, key, ret[i]);
		end
	end
	
	-- Try using this index
	local newvars = {};
	for i=1, compound_reqs[compound_type][2] do
		newvars[i] = vars[i] + chem_data[index][4 + attrib_reqs[i][1]];
	end
	if (left == 1) then
		-- check it
		local good = true;
		for i=1, compound_reqs[compound_type][2] do
			local sign = attrib_reqs[i][2];
			if newvars[i]*sign < compound_reqs[compound_type][3] then
				good = nil;
			end
		end
		if good then
			cache(left, index, key, {index});
		end
	else
		-- Check if possible
		local possible=true;
		for i=1, compound_reqs[compound_type][2] do
			local sign = attrib_reqs[i][2];
			if vars[i]*sign + left*3 < compound_reqs[compound_type][3] then
				possible = nil;
			end		 
		end
		if not possible then
			-- not searching below
		else
			local ret = dodp(left-1, index+1, newvars);
			if ret then
				for i=1, #ret do
					local tail = ret[i];
					local newlist = {index};
					for j=1, #tail do
						newlist[j+1] = tail[j];
					end
					cache(left, index, key, newlist);
				end
			end
		end
	end
	
	if not iscached(left, index, key) then
		cache(left, index, key, {0});
		if not iscached(left, index, key) then
			error 'assert 2';
		end
	end

	return getcache(left, index, key);	
end

function solve()
	local i, j;
	solve_result = {};
	solve_tooltip = {};
	solve_lists = {};
	dp = {};
	dp_count = 0;
	local vars = {};
	for i=1, compound_reqs[compound_type][2] do
		vars[#vars+1] = 0;
	end
	local ret = dodp(max_essences, 1, vars);
	if ret then
		solve_lists = ret;
		addResult("Searched: " .. dp_count .. " Found: " .. #ret, nil);
		local s = "";
		for i=1, compound_reqs[compound_type][2] do
			s = s .. attribs[attrib_reqs[i][1]] .. " " .. mods[compound_reqs[compound_type][3]][attrib_reqs[i][2]];
			if not (i == compound_reqs[compound_type][2]) then
				s = s .. " || ";
			end
		end
		if false then
			local head = s;
			for i=1, #ret do
				local s = "";
				local list = ret[i];
				for j=1, #list do
					local index = list[j];
					s = s .. chem_data[index][1];
					if not (j == #list) then
						s = s .. " || ";
					end
				end
				lsPrintln("| " .. head .. " || " .. s .. " |");
				if false then
					local combined = s;
					local tip = "";
					for j=1, #list do
						local index = list[j];
						s = "    " .. chem_data[index][1] .. " (" .. chem_data[index][3] .. ")";
						tip = tip .. s;
						if not (j == #list) then
							tip = tip .. "\n";
						end
						lsPrintln(s);
					end
					--addResult(combined, tip);
				end
			end
		end
	else
		addResult("Searched: " .. dp_count, nil);
		addResult("No solution was found", nil);
	end
end

function doit()
	askForWindow(askText);
	local selected = {};
	local chem_cache = nil;
	local scale = 25/16.0;
	z = 1;
	tip = "";
	while 1 do
		lsSetCamera(0, 0, lsScreenX*scale, lsScreenY*scale);
		local maxX = lsScreenX*scale;
		local maxY = lsScreenY*scale;
		for i=1,#compound_reqs do
			x = (i-1)*60;
			if compound_type == i then
				lsPrint(x, 5, z, 1, 1, 0xFFFFFFff, compound_reqs[i][1]);
			elseif lsButtonText(x, 5, z, 60, 0xFFFFFFff, compound_reqs[i][1]) then
				compound_type = i
			end
		end
		
		x=10;
		y=32;
		for i=1, compound_reqs[compound_type][2] do
		
			attrib_reqs[i][1] = lsDropdown("ChemDropDown" .. i, x, y, z, 50,
				attrib_reqs[i][1], attribs);
			if lsButtonText(x+50, y, z, 100, 0xFFFFFFff, mods[compound_reqs[compound_type][3]][attrib_reqs[i][2]]) then
				attrib_reqs[i][2] = -attrib_reqs[i][2];
			end

			y=y+26;
		end
		
		y = y+5;
		
		if lsButtonText(0, y, z, 100, 0xFFFFFFff, "Solve") then
			statusScreen("Solving... (this may take a while)");
			statusScreen("Solving... (this may take a while)");
			solve();
			statusScreen("Done solving, generating ingredient browser...");
			statusScreen("Done solving, generating ingredient browser...");
			selected = {};
			chem_cache = nil;
		end
		y=y+30;

		if false then
			if lsButtonText(0, y, z, 400, 0xFFFFFFff, "Generate all to console") then
				statusScreen("Working... (this will take ages");
				for a11=1, 8 do
					attrib_reqs[1][1]=a11;
					for a12=-1,1,2 do
						attrib_reqs[1][2]=a12;
						for a21=attrib_reqs[1][1]+1, 8 do
							attrib_reqs[2][1]=a21;
							for a22=-1,1,2 do
								attrib_reqs[2][2]=a22;
								local s = "";
								for i=1, compound_reqs[compound_type][2] do
									s = s .. attribs[attrib_reqs[i][1]] .. " " .. mods[compound_reqs[compound_type][3]][attrib_reqs[i][2]];
									if not (i == compound_reqs[compound_type][2]) then
										s = s .. ", ";
									end
								end
								statusScreen("Solving " .. s);
								solve();
							end
						end
					end
				end
			end
		end
		
		y=y+45;

		
		local max_solutions = #solve_result;
		if max_solutions > 30 then
			max_solutions = 30;
		end
		
		for i=1, max_solutions do
			if solve_tooltip[i] then
				if lsButtonText(10, y, z, maxX - 12, 0xFFFFFFff, solve_result[i]) then
					tip = solve_tooltip[i];
				end
			else
				lsPrint(10, y, z, 1, 1, 0xFFFFFFff, solve_result[i]);
			end
			y=y+26;
		end

		if tip then
			lsPrintWrapped(150, 32, z+1, maxX - 150, 0.7, 0.7, 0xFFFFFFff, tip);
		end
		
		-- heirarchical display
		for i=#selected, 1, -1 do
			if lsButtonText(165, 32+(i-1)*26, z, maxX - 165, color(chem_data[selected[i]][1]), chem_data[selected[i]][1] .. " (" .. chem_data[selected[i]][3] .. ")") then
				-- remove it
				for j=i, #selected-1 do
					selected[j] = selected[j+1];
				end
				selected[#selected] = nil;
				chem_cache = nil;
			end
		end
		
		local build_cache = false;
		if not chem_cache then
			build_cache = true;
			chem_cache = {};
		end
		lsScrollAreaBegin("ChemDataScrollArea", 5, y, z-1, 318, maxY - y);
		y = 0;
		-- reduce recipes to those that are valid
		local ingredient_recipe_count = {};
		if build_cache then
			for j=1, #solve_lists do
				-- check if recipe matches current list
				local this_valid = true;
				for ii=1, #selected do
					local found=false;
					for k=1, max_essences do
						if selected[ii] == solve_lists[j][k] then
							found = true;
						end
					end
					if not found then
						this_valid = false;
					end
				end
				if this_valid then
					for k=1, max_essences do
						local idx = solve_lists[j][k];
						if ingredient_recipe_count[idx] then
							ingredient_recipe_count[idx] = ingredient_recipe_count[idx] + 1;
						else
							ingredient_recipe_count[idx] = 1;
						end
					end
				end
			end
			for j=1, #selected do
				ingredient_recipe_count[selected[j]] = nil;
			end
		end
		clear_cache = false;
		for i=1, #chem_data do
			if build_cache then
				local skip=false;
				recipe_count = ingredient_recipe_count[i];
				
				if (#solve_lists > 0) and (recipe_count == #solve_lists) then
					selected[#selected+1] = i;
					clear_cache = true;
					recipe_count = nil
				end
				chem_cache[i] = recipe_count;
			else
				recipe_count = chem_cache[i];
			end
			if recipe_count then
				if lsButtonText(0, y, z, 300, color(chem_data[i][1]), chem_data[i][1] .. " (" .. recipe_count .. ")") then
					selected[#selected+1] = i;
					clear_cache = true;
				end
				y = y + 26;
			end
		end
		if clear_cache then
			chem_cache = nil;
		end
		
		lsScrollAreaEnd(y);
		
		if (maxX < 465) or (maxY < 400) then
			lsPrint(10, maxY-30, z+3, 0.7, 0.7, 0x801010ff, "You may need to resize this window to see everything.");
		end
		if lsButtonText(maxX - 72, maxY - 26*3, z, 70, 0xFFFFFFff, "Font +") then
			scale = scale * 4/5;
		end
		if lsButtonText(maxX - 72, maxY - 26*2, z, 70, 0xFFFFFFff, "Font -") then
			scale = scale * 5/4;
		end
		if lsButtonText(maxX - 142, maxY - 26, z, 140, 0xFFFFFFff, "Menu (slow)") then
			error "Clicked End Script button";
		end

		lsDoFrame();
		lsSleep(25);
	end
end