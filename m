Return-Path: <linux-wireless+bounces-28276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D14C0A273
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Oct 2025 05:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2C33B10CF
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Oct 2025 04:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449D41D90DF;
	Sun, 26 Oct 2025 04:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="VHzlGlOE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3C91A9FB8
	for <linux-wireless@vger.kernel.org>; Sun, 26 Oct 2025 04:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761453564; cv=none; b=UrwoKCG1eKWJbDASTAeViJqOm14IvjMd3LBHgUi66BaqlJExnIGBBVk+af7ADn/WrSDlv0UhUvJ0sqHVdvB31kBzl58SjkQj6wvPcGs//NRRhv/kdMLdo9hbZ739ZTYJ17xxlEjiVGnG+wPW3ioUslC6WVLRnT5JUdlBBOgwHb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761453564; c=relaxed/simple;
	bh=vpRlstZrjWA/g76eJhoX6siloy0bZaQblJlsWL+cfKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3JxYBnGpIcYSMu9pMejkSEbXVb930b4h+Wq6PECxygLvzKly858ecmyq3JQcDAB857XXUhuoxYzW61+R5PTjPvHXtd2E4XrEgBY52zsZwUJtk1WL+4USAyEsB46F38wrxagUDe/EuFpx5LggprJk74xkKiuRjfqecQ8v+FFXFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=VHzlGlOE; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a27053843bso4878539b3a.1
        for <linux-wireless@vger.kernel.org>; Sat, 25 Oct 2025 21:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1761453561; x=1762058361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zjI6D36H7gL/KXkAueV2LpMMgkqvIPJuTBJCna1wK3o=;
        b=VHzlGlOEmjCQ/3IVP0Diq69oLA9qENEWtYxdtj+xT27/DI8/lux9vAxefwq1k/DC+V
         VjP9JzG/cWN8iLa7P9SH2ZDoteGaxg1eRy1hPCAInmylDUowBOC9dFiTigm5uYSC9i0E
         L4PMgvG3if87Bb+90BStAJTPthT1XvREKMTQn0aZ0yuzLNwdrlIyO9VOgb2yaZxYErwD
         wZR6GUEdqOAZtvDaUHn52WeasUpo939kHgP/A3Da4To+MCyrXYrObp6g08k6iTNHFSf8
         9QQhNnU/4OxVO4JbLFtK2yY+UMmjfH2hCa6TUqmxWwLd8ZzywEbiYzTRJ41L/Hx2rB4m
         CeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761453561; x=1762058361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjI6D36H7gL/KXkAueV2LpMMgkqvIPJuTBJCna1wK3o=;
        b=gxvFXBJSk7BHvEkuqtKPJIaYa8vY6FwurZ9bOS24mzeiLfgyb/2Rjaxar1iyELRgNt
         kz2aKTOsQnTJbceRdl3aXCx2wzrqZuZ+hA4I+2/cs3fyWc+VTw8y1gDNBosRHSAunNac
         APgb5k3DQy/YPXnclZm5AXhETzKa74Tad9HahotATSoXFLUeEX/b7NV0PFcrdWUo4F4x
         qaYcyxatHP033q9WVjVazNBBJ7Zh6u7aZTe9YPCNY2HYFQXkf2DLVA5hjY8u5OWleCwU
         5Y+Ytwul5DbZhz9uTcj579/oKACfLBVrnVLbBzjRofA50U9mSWWYZlfuz47nTPV0OEzM
         HKJg==
X-Gm-Message-State: AOJu0YxiITkkKwI/7S6UdpL9WRj2f+OOof31+KPhbCHyD9ZoVs4aIV+T
	OY/EGgpXTojoPHa6uj/ubiIDtSwnakTqjIA3s/k/nun3rk8dClJC77NSMPlKkqZU0s0=
X-Gm-Gg: ASbGnctHOx0RHycKDaVSQ71006F/vO1+O7P1sA9W71kGB2q+bmFz2lMbtbKuazFf4su
	PsZdTY3mR6PYcBnfVokkLg6ZCBz4KvwyoTS6i10aNTce8UI+D0KyU4M8rtzMo9KU3Hn9jFXdnP9
	Bq7mFYV6rs3Y/44BFfWMHZmk8IFTZJ3tn+wPbmX7iFLGIvVaz8bHJUQ4OPAxrVuEIKmEW7MgnAN
	Sb+InqpM2mD9dUicljju/R3a12EBLcl/OlZZIj00CXZ2tVpzIgN7HaB08V22zlKAqQQKMHKYe+j
	No7ZNXhWbc6a4yeGkabs2jVgbBs+bbb1DcP/4hJ5KcO/CTytgs0gA/jBgodmhOa8+XF7cgakJ17
	PQ9OQzxlFulN3pcQy4btJn6kczdhi/P6uxbXw1SQnRyc56mjV9VmjwZ7px0jF2rfeOgFR5OsTxP
	+YgBZFi6d8UnpSQVPUYiG/UKTyNf+FbLY9D4/4Gj9WAw==
X-Google-Smtp-Source: AGHT+IFQbnoAIsgvBoSFMQYKcRNNKQeDkK19GzCD1SgtSTgMuu/zLFdxAMJKDkgmqqzMxjgkqqtNQQ==
X-Received: by 2002:a05:6a20:7d8b:b0:33a:f317:58ac with SMTP id adf61e73a8af0-33dece2b1ecmr9099960637.59.1761453561330;
        Sat, 25 Oct 2025 21:39:21 -0700 (PDT)
Received: from localhost ([60.227.210.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012bcesm3987929b3a.8.2025.10.25.21.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 21:39:20 -0700 (PDT)
Date: Sun, 26 Oct 2025 15:39:17 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [PATCH RFC wireless-next] wifi: mac80211_hwsim: dont perform
 rate validation for S1G
Message-ID: <esjs3w3iac4o5p46kw3l56wny5tt65qcr6qhrlq3uimoj7l77f@qkauq6n4vgec>
References: <20251008014006.219605-1-lachlan.hodges@morsemicro.com>
 <0f82718459bc6e31238f1189f8f5bfc859b59a3e.camel@sipsolutions.net>
 <e3fl4s2at6oz5rtvurivxormmndj22l3h2dkqovhnhj5u6fw2q@c65nw3shnxcl>
 <ccef9238eaced219bf7526a30e8ee0acb54ea282.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccef9238eaced219bf7526a30e8ee0acb54ea282.camel@sipsolutions.net>

> > It seems that introducing a flags parameter into the ieee80211_link_sta where
> > drivers can apply the inverse i.e LINK_STA_NO_RATE_CONTROL or something similar
> > that before drv_link_sta_rc_update() is called the flag can be tested, something
> > like, for example within rate_control_rate_update():
> > 
> > [...]
> > 	if (sta->uploaded && !(link_sta->pub->flags & LINK_STA_NO_RC))
> > 		drv_link_sta_rc_update(local, sta->sdata, link_sta->pub,
> > 				       changed);
> > [...]
> > 
> > Then w.r.t setting the flag, we could introduce a new function that gets
> > called within mac80211_hwsim_sta_add() called mac80211_hwsim_link_sta_set_flags()
> > or something where it could enumerate the links of the ieee80211_sta and
> > apply the flag to the link with an S1G band channel context?
> > 
> > The reason for it being driver-facing is that any future upstream S1G drivers
> > may make use of the .sta_rc_update() callback.
> 
> But the .sta_rc_update() call is desired/needed either way (if
> implemented) - the issue is about the _other_ side of this, "if (ref &&
> ref->ops->rate_update)", no?

So doing some reading, when rate control is instantiated every S1G frame
is sent at the low rate. Additionally, data->bw is accurate in this case
within mac80211_hwsim_tx unlike the sta_rc_update callback. Then since
the only rate flags used is IEEE80211_TX_RC_S1G_MCS, the Tx bandwidth
remains at data->bw. So I think for now, we can leave this as-is.

I also have some hwsim tests functioning - testing the various channel
permutations (soon to be hopefully in hostapd =)) and this part seems fine,
the problem is the link sta bandwidth validation which does indeed
cause issues with hwsim association.

> So I'd rather think we need something like
> 
> static int sta_prepare_rate_control(struct ieee80211_local *local,
>                                     struct sta_info *sta, gfp_t gfp)
> {
>         if (ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL))
>                 return 0;
> 
> +	if (something new here)
> +		return 0;
> +
>         sta->rate_ctrl = local->rate_ctrl;
>         sta->rate_ctrl_priv = rate_control_alloc_sta(sta->rate_ctrl,
>                                                      sta, gfp);
>         if (!sta->rate_ctrl_priv)
>                 return -ENOMEM;
> 
>         return 0;
> }

So as mentioned above, I think for now this probably isn't needed? Also same
for the comment w.r.t hwsim manually sending rate_control_send_low() since
the rate subsystem is already doing that?

> However, an issue is that the "something new here" can't check a per-STA
> flag because this happens before the driver is actually told about the
> station.
> 
> I suppose the easiest way, if a bit special to hwsim, would be to add a
> specific flag for S1G, so that "something new here" becomes just
> 
> 	on_s1g && ieee80211_hw_check(&local->hw, HAS_S1G_RATE_CONTROL)
> 
> (where on_s1g needs the sdata passed to the function and the chanctx
> checked)
> 
> Then hwsim can sort it out or even just call rate_control_send_low() for
> that all the time (which has a TODO for S1G buried, but that probably
> needs addressing either way eventually.)

Now with all this said, this still doesn't fix the issue regarding the
link_sta rc update ? Since link_sta->bandwidth will always be 20MHz for an
S1G interface. This is why I brought up the link sta flags which I believe
could actually just go in the STA since MLO is prohibited for carriers < 1GHz.

lachlan

