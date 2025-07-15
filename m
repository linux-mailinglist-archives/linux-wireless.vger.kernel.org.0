Return-Path: <linux-wireless+bounces-25459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75309B05609
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 11:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1EF03AC7F1
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 09:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF18F27700C;
	Tue, 15 Jul 2025 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="ebkQ5u+D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548F22459FA
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570923; cv=none; b=NzTG8JDgvaTsqd7rBBbQ28I3cty8gj6jWTTMBPk0eVCTgc1kLPVO8GXZDlhXKT18FNAwoNcGGAAsujiC0jxyXmRWiDbNtw5Xo2lVPzc+rupo7VP5CyAAJhn/PZdCRVnQLhOj5G1hUcet5YQC5jpJcqw0ZRmmmNDBEwUiz85EtoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570923; c=relaxed/simple;
	bh=Svfvuk8Xfky+LRJIJxfgDKHtVEFqLsNmGRjCkFLpju8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7zd0g7Ed1luHFnHN7JD40vuIR05yMh7l+hVCaWKh0GaIJYeWOjPLkp3xZt0/qdO9x8HQJ8TMybO55MqjLbcJph8oyewLzgInlNkcSx9d/4aK71drbIwkGbMSc76V+nSl5AHBLuDSFUxTshy0kte5WBK3gYou1Gvm/Z3hFRsaDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=ebkQ5u+D; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-313a001d781so4118983a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 02:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1752570921; x=1753175721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cUwrvjTiQS/rvacYbBz7ePVkydY0+vJautFL+dC3n70=;
        b=ebkQ5u+Da0y0HGlbVE5CaGd1YCFDRjNQqfckubHMj+HdGQTAzJnPq8an5EIsq8D1CC
         NvDhYgXxSN931t1sDk/M1ipQiiY39SKKWzdoghyzXqydwnk48mWoIwMX+auY18kLtVnL
         fnYgTNJFsX2SaIA0Ah960iua3GEZVZjSEdxoU9BvsQi5VEWeiajgDbpxPzeTX1MrzlOb
         Ixijm7AFTU8BYjPItHWcFSTXyIAI6qcQfVe7EsigvkIi+8rkkhfSmTZ3NmwY8AeQM4j0
         CPmP+NKbCty+jUIJfAADIP3JzQB5FgT6oX/NXZHpOKWGzMydwr1yE6cTEGf00Wmkt9R2
         3mkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752570921; x=1753175721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUwrvjTiQS/rvacYbBz7ePVkydY0+vJautFL+dC3n70=;
        b=AUqTQod9+cSV0jhoa/GJ3Y2LykIgcmoL++ocPz2xo9iP+/FmY+TUXxRJWlkPpY/Uig
         tALY1BCsxBnajaCwBbgTgKpUz87gvPz/dfIPWqs3vKIIvf7MyY2dAh1OmoR96BOauKGg
         zGMyJLEzT0ZFIpz9SIneQX5zrUZaIgshxRAfqW9/3WQM3/maInUub1z9m+EHcv9pth8d
         hkEZWbQ1kCR6djbDHW3YNjiaeOrXLwHUycCVxk6eO8rVn4ydh8IrlTt+iVU7ZoVsXSWr
         U67QnJAtyzqEtYLU1KRFBKSEbMgIiqnXvXQNDxEviNnJQ+MzO4QA0V+xeUJxwyOvSICd
         +Nog==
X-Gm-Message-State: AOJu0YysZ98gC0VCKRatSt1MPBBoV5kmONBaaYbyHpvkqdzUG0oXrOiH
	Yi8wnxdHy5Jq5pr91B0d1etfh0CXPqYzhDQqS+w9y/HU0fKwtZOTqSya6kudrK9bgP0=
X-Gm-Gg: ASbGncsw0Gmi9iIGyIENh1VHRdFkKyLzqM6zp8g05rD5cbtPFbcByOwyM2OSb17NbL4
	3v1zBGqE2nbktHxcnpf2qBLJKvDMjzvFSqDP8cFKfb3Ue9ZNaIz5auJc76wlVdDXYQgCMEuzfig
	TpCrgqE+njInanpLYkM5ZdRy587PLF+Sl/YfMIGRjzwjkgTC+5NABuiG13pcxaLTPCdrGRLjIR/
	NqU1m/Ab9NNJICVn1wbpB+egzqOAsbzUhHDBjJL5Q7k1RueOsygH1juTaXfqTCkprf43deUcrc/
	KUurDwQ90PCpvt50Ny4kdY0l1Xtog7FfZ+3/B77n8jCC5F+izsFd4V2NgB/us8WoPDWy3FhyLxK
	04YAIe1ff/OSHtB67W1oz4MFSZXc=
X-Google-Smtp-Source: AGHT+IEiZjqCoh7DyLSuse9zt++QEwlsgAueErkQHX2+4HvBW7AJNwrc2A9nt4cswESfDwassZnJpw==
X-Received: by 2002:a17:90b:1b50:b0:318:f0cb:5a50 with SMTP id 98e67ed59e1d1-31c4ccf3240mr23495072a91.26.1752570921400;
        Tue, 15 Jul 2025 02:15:21 -0700 (PDT)
Received: from localhost ([1.145.89.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3008a610sm14558766a91.20.2025.07.15.02.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:15:20 -0700 (PDT)
Date: Tue, 15 Jul 2025 19:15:16 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [RFC 2/5] wifi: mac80211: support initialising an S1G short
 beaconing BSS
Message-ID: <cvujiaajawtnzv36twq7c25f6gdq5e33ukoqb5wzm43ogn4gqi@at5whn3oj6zt>
References: <20250714051403.597090-1-lachlan.hodges@morsemicro.com>
 <20250714051403.597090-3-lachlan.hodges@morsemicro.com>
 <3bf402034b4a975a603e22b8acf9c8974c47c237.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bf402034b4a975a603e22b8acf9c8974c47c237.camel@sipsolutions.net>

On Mon, Jul 14, 2025 at 03:03:44PM +0200, Johannes Berg wrote:
> On Mon, 2025-07-14 at 15:14 +1000, Lachlan Hodges wrote:
> > 
> > @@ -758,6 +760,16 @@ struct ieee80211_parsed_tpe {
> >   *	be updated to 1, even if bss_param_ch_cnt didn't change. This allows
> >   *	the link to know that it heard the latest value from its own beacon
> >   *	(as opposed to hearing its value from another link's beacon).
> > + * @s1g_short_beaconing: determines if short beaconing is enabled for an S1G
> > + *	BSS.
> > + * @s1g_short_beacon_int: short beacon interval in TUs. When short beaconing is
> > + *	enabled beacon transmission times are computed using this value as
> > + *	opposed to beacon_int as per IEEE80211-2024 11.1.2.1.
> > + * @s1g_short_beacon_dtim_period: number of short beacon intervals that elapse
> > + *	between each beacon with a TIM element whose DTIM count is 0. When
> > + *	short beaconing is enabled, this value is used as opposed to
> > + *	dtim_period as per IEEE80211-2024 9.4.2.5.1.
> > + * @s1g_short_beacon_period: number of short beacons sent per long beacon.
> >   */
> >  struct ieee80211_bss_conf {
> >  	struct ieee80211_vif *vif;
> > @@ -857,6 +869,11 @@ struct ieee80211_bss_conf {
> >  
> >  	u8 bss_param_ch_cnt;
> >  	u8 bss_param_ch_cnt_link_id;
> > +
> > +	bool s1g_short_beaconing;
> > +	u16 s1g_short_beacon_int;
> > +	u8 s1g_short_beacon_dtim_period;
> > +	u16 s1g_short_beacon_period;
> 
> Does the driver even need to know? For hwsim this is just additional
> complexity - mac80211 could set the beacon interval to the short beacon
> interval, and simply return the long beacon every
> "s1g_short_beacon_period" (which perhaps should be called
> "s1g_long_beacon_period")?
> 
> But depends on how your driver works I guess. Given these parameters
> though, you can't really offload it entirely either since there's no way
> to get a short beacon template now.

So this is something I forgot to mention in the cover letter, since yes
it simply adds code bloat (mentioned here and in the other patch). I
guess my intention was the "follow the standard" but maybe a bit too
much :). Without these new parameters the patchset is much leaner
and probably makes more sense anyway since at the end of the day,
the beacon interval is still the beacon interval and same for the
DTIM period. New patchset will exclude these new parameters, which
definitely cleans up much of the code.

lachlan.

