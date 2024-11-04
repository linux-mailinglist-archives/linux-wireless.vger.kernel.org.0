Return-Path: <linux-wireless+bounces-14883-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D19779BB82F
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 15:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3051C2175D
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 14:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE801B218E;
	Mon,  4 Nov 2024 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="lfPu/w+8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B92A70839;
	Mon,  4 Nov 2024 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730731476; cv=none; b=VBKacGox5sQscS+RqwxTiU2FfGpioDtZMZk42aKL5WB/9MqE4xbckSfIWhNh2cbDE/S0rYodDBch3P4dS5aKa1w8MAnduonZSDaSEM7wKkMi5WH77qP/GXPJPQTOlBDk5FenE5c9Co8chKVxO12/MumuLw4u38ja7PX16sEPplE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730731476; c=relaxed/simple;
	bh=O0q310ZXS/8hd5zK7hGv/wooSKysaSdt6OHMte7aao0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcotsFACGgTrRw7m2INp5B/RpLWB+7vyD7iL5LpaLR1PEQsyb7Bq6lsBgDLiP+6bksGfvUfyXxNE5RV4V+fH77+wdcGYnLxYF1uZgEh3s0ecwLD9j6y8d4x23UXfdfi2ZYlFEAjsI4wfJyIbHwGfUarOxgrQ9RQfRO0trHwfeuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=lfPu/w+8; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=tHknOMDBUHnACywOrqNmGl+/VByrwWQHN9oBTWQhGhA=; b=lfPu/w+8QvvNKN8m
	3lpiDU38rsV0O3DSdh6xEdFQ3ASuMJTQad9ZwLQYgRGnOR0j1QRKUGAaJ9laBM5pF4fnIXoGBHR8l
	2yynSjwYnCLIs3JxppmZYRvdTufpFO6+bMeVwxyQ/cm8w10YjMIBsv/iuk9TNO6ArptYIs5wkQeO2
	u7GqTHVB7X46MwcMozt9W99UxPFDH04TkD6Ht7nATtg76YyiKydosuxS0ux/5PILYUJoTFu1gfbLZ
	j6vb5xK4HJPRK+U79G1wOKLrtzVJMkWFM9VmQPCiB7CNMDt+IUFRzyUgKh72N73Eo0M2nt5ILOyvh
	a+75EMooi030A78LrQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1t7yJg-00FLns-3C;
	Mon, 04 Nov 2024 14:44:28 +0000
Date: Mon, 4 Nov 2024 14:44:28 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: pkshih@realtek.com, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rtlwifi: Remove more unused functions
Message-ID: <ZyjdzJujaHJekv8Q@gallifrey>
References: <20241103153857.255450-1-linux@treblig.org>
 <20241103153857.255450-3-linux@treblig.org>
 <87y11zxwlr.fsf@kernel.org>
 <ZyjDn0R7gzDQ4jnT@gallifrey>
 <87msif6q4q.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87msif6q4q.fsf@kernel.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 14:43:51 up 180 days,  1:57,  1 user,  load average: 0.10, 0.05,
 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)

* Kalle Valo (kvalo@kernel.org) wrote:
> "Dr. David Alan Gilbert" <linux@treblig.org> writes:
> 
> > * Kalle Valo (kvalo@kernel.org) wrote:
> >> linux@treblig.org writes:
> >> 
> >> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >> >
> >> > exhalbtc_dbg_control(), exhalbtc_stack_update_profile_info(),
> >> > exhalbtc_set_hci_version(), and exhalbtc_set_bt_patch_version() are
> >> > unused since their addition in 2014 by
> >> > commit aa45a673b291 ("rtlwifi: btcoexist: Add new mini driver")
> >> >
> >> > Remove them.
> >> >
> >> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> >> 
> >> 'wifi:' missing.
> >
> > Oops, can add that.
> >
> >> Also in both patches the subject could be more unique.
> >
> > Do you have suggestions? I don't know the code to give good titles.
> > They're both 'btcoexist'; I could merge them into one
> >
> > wifi: wtlwifi: Remove btcoexist deadcode
> 
> No good suggestions really. Usually I add what I'm removing to the
> subject but as this patch is removing several functions the subject
> would be too long. Maybe something like 'wifi: rtlwifi: remove several
> unused exhalbtc_*() functions?' just to throw out some ideas, I'm sure
> you can come with better ones.

OK, I've just merged the two together, and sent it out as a single patch

[PATCH v2] wifi: rtlwifi: Remove some exhalbtc deadcod
message-id: 20241104144331.29262-1-linux@treblig.org

Dave

> 
> -- 
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

