
<h2>{$page->title}</h2>


<form class="form pull-right" style="margin-top:-35px;">
	<form name="showsearch" class="navbar-form" action="" method="get">
		<div class="input-append">
			<input class="input-medium" id="title appendedInputButton" type="text" name="title" value="{$showname}" class="span2" placeholder="Search here"/>
			<button type="submit" class="btn">GO</button>
		</div>
	</form>
</form>
<center>
<div class="btn-group" style="margin-top:-65px; margin-left:250px;">
	<a class="btn btn-small" href="{$smarty.const.WWW_TOP}/myshows" title="List my watched shows">My Shows</a>
	<a class="btn btn-small" href="{$smarty.const.WWW_TOP}/myshows/browse" title="browse your shows">Browse My Shows</a>
</div>
</center>

<p>
<b>Jump to</b>:
<div class="pagination">
	<ul>
		{if $seriesletter == '0-9'}{/if}<li><a href="{$smarty.const.WWW_TOP}/series/0-9">0-9</a>{if $seriesletter == '0-9'}</li>{/if}
	</ul>
	{foreach $seriesrange as $range}
		<ul>
			{if $range == $seriesletter}{/if}<li><a href="{$smarty.const.WWW_TOP}/series/{$range}">{$range}</a></li>{if $range == $seriesletter}{/if}
		</ul>
	{/foreach}
</div>
</p>

{$site->adbrowse}

{if $serieslist|@count > 0}

<table style="width:100%;" class="data highlight icons table table-striped" id="browsetable">
	{foreach $serieslist as $sletter => $series}
		<tr>
			<th width="35%">Name</th>
			<th>Country</th>
			<th width="35%">Genre</th>
			<th class="mid">Option</th>
			<th class="mid">View</th>
		</tr>
		{foreach $series as $s}
			<tr class="{cycle values=",alt"}">
				<td><a class="title" title="View series" href="{$smarty.const.WWW_TOP}/series/{$s.id}">{$s.title|escape:"htmlall"}</a>{if $s.prevdate != ''}<br /><span class="label">Last: {$s.previnfo|escape:"htmlall"} aired {$s.prevdate|date_format}</span>{/if}</td>
				<td>{$s.country|escape:"htmlall"}</td>
				<td>{$s.genre|escape:"htmlall"|replace:'|':', '}</td>
				<td class="mid">
					{if $s.userseriesid != ''}
						<div class="btn-group">
							<a href="{$smarty.const.WWW_TOP}/myshows/edit/{$s.id}?from={$smarty.server.REQUEST_URI|escape:"url"}" class="myshows btn btn-mini btn-warning" rel="edit" name="series{$s.id}" title="Edit">Edit</a>&nbsp;&nbsp;
							<a href="{$smarty.const.WWW_TOP}/myshows/delete/{$s.id}?from={$smarty.server.REQUEST_URI|escape:"url"}" class="myshows btn btn-mini btn-danger" rel="remove" name="series{$s.id}" title="Remove from My Shows">Remove</a>
						</div>
					{else}
						<a href="{$smarty.const.WWW_TOP}/myshows/add/{$s.id}?from={$smarty.server.REQUEST_URI|escape:"url"}" class="myshows btn btn-mini btn-success" rel="add" name="series{$s.id}" title="Add to My Shows">Add</a>
					{/if}
				</td>
					<td class="mid">
						<a title="View series" href="{$smarty.const.WWW_TOP}/series/{$s.id}">Series</a><br />
						{if $s.id > 0}
							{if $s.tvdb > 0}
								<a title="View at TVDB" target="_blank" href="{$site->dereferrer_link}http://thetvdb.com/?tab=series&id={$s.tvdb}">TVDB</a>
							{/if}
							{if $s.tvmaze > 0}
								<a title="View at TVMaze" target="_blank" href="{$site->dereferrer_link}http://tvmaze.com/shows/{$s.tvmaze}">TVMaze</a>
							{/if}
							{if $s.trakt > 0}
								<a title="View at Trakt" target="_blank" href="{$site->dereferrer_link}http://www.trakt.tv/shows/{$s.trakt}">Trakt</a>
							{/if}
							{if $s.tvrage > 0}
								<a title="View at TVRage" target="_blank" href="{$site->dereferrer_link}http://www.tvrage.com/shows/id-{$s.tvrage}">TVRage</a>
							{/if}
							<a title="RSS Feed for {$s.title|escape:"htmlall"}" href="{$smarty.const.WWW_TOP}/rss?show={$s.id}&amp;dl=1&amp;i={$userdata.id}&amp;r={$userdata.rsstoken}"><i class="fa fa-rss"></i></a>
						{/if}
					</td>
			</tr>
		{/foreach}
	{/foreach}
</table>

{else}
<div class="alert">
	<button type="button" class="close" data-dismiss="alert">&times;</button>
	<strong>Hmm!</strong> No result on that search term.
</div>
{/if}
