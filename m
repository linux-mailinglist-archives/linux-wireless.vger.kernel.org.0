Return-Path: <linux-wireless+bounces-31631-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO6dDZ/2hmkvSgQAu9opvQ
	(envelope-from <linux-wireless+bounces-31631-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Feb 2026 09:23:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D870105372
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Feb 2026 09:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBD213033514
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Feb 2026 08:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C290C30E0D1;
	Sat,  7 Feb 2026 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="lThDZRbp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C67130C619
	for <linux-wireless@vger.kernel.org>; Sat,  7 Feb 2026 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770452606; cv=none; b=MYDNPxkFPg7l6xB9jVZMKglmHsu0Dju89SS37tRW43WdOfxTWKjB5Z6NnVRSySdx+Me7jkgcG11SXOq38HrSUq5aIQ5Eh7rCHEpzbKQK/WOqpIxGSGAPXucR3qD9wGfKQY8o98RXwcq6FJQeNrKpH/DxGNudX/k0rBgZ88lWxCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770452606; c=relaxed/simple;
	bh=UsLybWCgQewlhEUgzD1E2KA/SK3QyEI1n+rfOEW0l84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iluczqHFmCiR60hLSxJz+7q0q+4YjzsSWyFJ1ZTut1nKiCXHVF87zEHczAv+OXkUaCpyDlaBwOEC0T5BpztQe4ehJDIhJuUWcH/WYMz7MHz1uoQ0oD3AhKMKlhFT5C+FY1+7yjdhjsnEo8+FdSLHZATQ8oSGwumibGNuZfRHrZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=lThDZRbp; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c6c67bc8b9eso1120618a12.1
        for <linux-wireless@vger.kernel.org>; Sat, 07 Feb 2026 00:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1770452606; x=1771057406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BtiYdv4XfnvKPL+kXBAbt9Y7tkrZbs7LvZT7tB6CBoo=;
        b=lThDZRbpG12wrVJ+Dp0JVH1LpxVVukR3Eg47ToNUNEMEG+Timfi5sYR7seV0DQ1Q0+
         UdIzbUzXXpnXuZkNOmeMFp2MqjSyGPHhN+MTfcoPJLgzUfUWK/2tJ+5J1LiCk+xJNLtT
         TnRE8KfB1teRvB0jqDeNUKDj7U3xcIhfhvXL4iyqYFryc3skitHzWEZzkTFrTJWS5c/F
         IX2RBIOQ4gEf8KGlYAmK7W+LJuayTKM+QdTyhmfixubA8nDbnMVWUZoshlyxcPfZEy3j
         I5vqaXQp/yMZnNozUN/KchA3NMwhv6L+x62PLfPVIifvHweLohUf3pjffo6NMdx7qKJT
         JemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770452606; x=1771057406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtiYdv4XfnvKPL+kXBAbt9Y7tkrZbs7LvZT7tB6CBoo=;
        b=Vo+ZH+Ui0trPYO5JT7OCijEySlIl94MvQSxR/1LMQA59z4CzBktp34bee5PB7dePXQ
         MlLf/oSxcL8G5cYfIZ/HNZ/7uMoqGhuYyIPcAEjmpUXTi02rIUuSUi008bnAEMx/WVlS
         8h4iRgMrcyZDiJL/iz3v1jDheKfhgfpuT/zi31uyjRD2+94G+2Pzyk4WfOFZbpxOjIkz
         Vkqe7JlJDlZZzS8uhnt72FkO/SgEbx3nU0G4FRcUOxUpZvhHeufBJohlmVQlxfJ4yVEv
         ++v2ftyMZiUZE50x1dsUE4kxpzXZpjRIjkGJbOtslEtLX9arotGUvDBJGtFlKHl8oRx4
         mTnA==
X-Forwarded-Encrypted: i=1; AJvYcCW83Cfuu2PewmdG6lCY0mXAK9VYNVYBeKu4Li/iZZAypNsmrsCRZezTz66vHZteWJmQsMCb/u6emDua/Xdo9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwD6sHKNdUBYq5MaZ7kCMV/a0OI9mzMcRFhS0sw95m3beu6OokV
	DLq2FIJe3j+51w4+sHh2mM5T5rXWDh0ENe2nk5b7dbBaLWcIOnlR8XLo5zqFhm4U1fw=
X-Gm-Gg: AZuq6aKZGVIWh2dL/+a6wCyGPKqTBsgh2AlYiZ41PtUDo9LGkd/iUmBNtSySNwNmSK/
	4++YkJXZ47ykXyLRyLwKDh7GvTvD2mU4410Zm6+LEI5MNg486KOi7Pa3YkA9rsbu1UdsIOotpNV
	ph+VbhMRoxdshEXWwapBozOaeHjN/TMMPG1N6FiWtMD/41TTotWkbhgF8Jni5RVry5yV6b49hXd
	m94iQScCgmxs4njVfw4CsytOtYxp4SPQcf3LS3S1BqDcYKuq9kj+iE3mpgLUVmiakMJLR5EP9Zc
	vZp2StGzG3PCS2iO3vnZ2Je13VGIKJwZubmEB1Qc7DWC8a4B4Su8ifgzhm1V+/ijI4izQUxxxuq
	vknrKqvxm3T+H49DZrEtG6Ct7SrXyns2C3YdSlPVg72hhI63Fuxjjvu+tYUyoRb8Zr05YYUDxq0
	MWk2rXI1UyObk+BQDrZp/vkqDWEEmGcGtodBR247NdnNHvWDMZ5Fk=
X-Received: by 2002:a17:902:d4c4:b0:2a0:d629:903c with SMTP id d9443c01a7336-2a9516f888amr58958385ad.30.1770452605597;
        Sat, 07 Feb 2026 00:23:25 -0800 (PST)
Received: from localhost ([60.227.133.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82457ef1000sm997466b3a.34.2026.02.07.00.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 00:23:25 -0800 (PST)
Date: Sat, 7 Feb 2026 19:23:20 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Dhyan K Prajapati <dhyan19022009@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dhyan K Prajapati <dhyaan19022009@gmail.com>
Subject: Re: [PATCH] wifi: mac80211: skip BSS_CHANGED_TXPOWER notification
 for monitor mode
Message-ID: <t4wwuq3l6duzhgoslrs63534ygm5nziokyme56y6iscvdkbvd7@qegdbvx5sk3j>
References: <20260207050035.6720-1-dhyan19022009@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207050035.6720-1-dhyan19022009@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31631-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sipsolutions.net,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D870105372
X-Rspamd-Action: no action

Hi,

On Sat, Feb 07, 2026 at 10:30:35AM +0530, Dhyan K Prajapati wrote:
> From: Dhyan K Prajapati <dhyaan19022009@gmail.com>
> 
> Monitor mode interfaces don't maintain BSS context. The BSS_CHANGED_TXPOWER notification
> indicates transmit power constrains recieved from an associated access point which isn't really
> applicable to monitor mode as it does not associate with any BSS
> 
> after a commit back in july 2025,("wifi: mac80211: fix WARN_ON for monitor mode
> on some devices") monitor interfaces with WANT_MONITOR_VIF began recieving link
> change notifications during ieee_add_virtual_monitor(), when ieee_link_use_channel()
> assigns a channel context it triggers ieee_recalc_power() which sends BSS_CHANGED_TXPOWER
> notifications to driver, driver using legacy bss_info_changed callbeack recieve
> link->conf as the bss_conf parameter for monitor mode that points to vif.bss_conf which is not fully initialised
> in monitor interfaces, so drivers like iwldvm dereference null and crash
> since BSS_CHANGED_TXPOWER notifications are meaningless for monitor mode, we can skip
> the notification entirely,monitor mode transmit power remains configurable via
> nl80211

You should try and limit the line length of the commit message to
72 lines. Also, there's a few spelling errors - these can be caught
by running checkpatch [1] on your patch before submission (and you
should run this everytime before any patch you submit). Also it
looks like the 'Signed-off-by' tag doesn't match.

> Hardware: Dell Latitude E6430
> Device: Intel Centrino Advanced-N 6205 [Taylor Peak]
> 
> Crash trace:
>   BUG: kernel NULL pointer dereference at 0000000000000000
>   RIP: iwlagn_bss_info_changed+0x19d/0x640 [iwldvm]
>   Call Trace:
>    drv_link_info_changed+0x2b5/0x2c0
>    ieee80211_link_info_change_notify+0x13d/0x160
>    __ieee80211_recalc_txpower+0x44/0xd0
>    ieee80211_recalc_txpower+0x5c/0x60
>    ieee80211_assign_link_chanctx+0x182/0x410
>    ieee80211_link_use_channel+0x413/0x450
>    ieee80211_add_virtual_monitor+0x17c/0x2b0
> 
> Tested-by: Dhyan K Prajapati <dhyan19022009@gmail.com>
> Signed-off-by: Dhyan K Prajapati <dhyan19022009@gmail.com>

If this is indeed a bug (I haven't really reviewed the change in
depth), you should find the commit you are fixing (assuming the
one mentioned above) and format as follows:

Fixes: c57e5b9819df ("wifi: mac80211: fix WARN_ON for monitor mode on some devices")

Then place it above the Tested-by tags and so on [2]. Don't worry
about the length of the fixes tag if the commit message is too long,
just keep it in its entirety. You can add this to your git config to
easily format this line which I stole from Johannes:

[...]
[pretty]
        fixes = Fixes: %h (\"%s\")
[alias]
        fixes = show -q --format=fixes
[...]

Then just run, for example "git fixes c57e5b9819df" to generate the
correct format for your patch. Additionally you should target the
'wireless' if it's fixing a bug such that it can get into the next
RC. You can do so by prefixing the subject like so:

[PATCH wireless] wifi: mac80211: skip BSS_...

>  	if (__ieee80211_recalc_txpower(link) ||
> -	    (update_bss && ieee80211_sdata_running(link->sdata)))
> +	    (update_bss && ieee80211_sdata_running(link->sdata))) {
> +		if (sdata->vif.type == NL80211_IFTYPE_MONITOR)
> +			return;
> +

Could you just include that statement inside the original if?

lachlan

[1] https://docs.kernel.org/dev-tools/checkpatch.html
[2] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

