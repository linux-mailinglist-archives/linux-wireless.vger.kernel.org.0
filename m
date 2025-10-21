Return-Path: <linux-wireless+bounces-28119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E739FBF4832
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 05:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8747B4E5377
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 03:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A51157493;
	Tue, 21 Oct 2025 03:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="H3Xn0a12"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0ED1448E0
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 03:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761017773; cv=none; b=HXMh8kzrRdeuWKeWuI8NpTRVdCS1VQzbY/ZFms8IvORZO9HlqlT4C9v4eIPeltsXKZkTUGAek4UgHwt0JmFIUXa2pCPVc3AfELSzh2vVIJFBruf4O0mNckcCxhT9rIHXzO+Epun29WxBWwGRngdbwiZRIC90Zep62uMZpxnsE7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761017773; c=relaxed/simple;
	bh=IQaTk2jFXyFqajbtyC2WIxOV4OhUV2MjE1D8i5vpOBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f149yMZDABF9yoRtR7zJNLKoRbvuh9vwbAPAFQpRo3OJUVj/06kk4oqEBl2Xx8OjxHtiHegfklGMttzKV7WHg/3UREnXmIUq0TOU69w8Qw9CCnnaqKZX2EapqkRMHyjk9YV4c9bUIBwYRSVo2NlapsTg5+Qa0zJ6nHmmVpdpGc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=H3Xn0a12; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27ee41e0798so80993585ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 20:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1761017767; x=1761622567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eUWzCfRMIEouZu2LnNHD7D5uvWqiVgr1OLzZd5iVh4k=;
        b=H3Xn0a12nprTKc98zKosRQ+vsNYMjcEPIazSjg930E9T/Xg/EWEo7nRgWKONFBRTiR
         NV4VkWApK6n86WNH1pHhAb1G8FHU5ANmnz8p4OZEe5i6sjbdKc4ZcK5kuG4F+995Azh7
         gjO3vnagYNxmIz8X5Cnb0pj8TjCpI6KZpYCaDKHGr5ZdaoFh8HXxC5IO5DWF7DvWXL3y
         tGGsl9L4xY8uiCiqxLnVNHBjdoPw4xWbU80CF8wjRxjuz4/zFKUpcu0cViSpu3nquyZc
         D9emSVMCcjG2MOygKHQhdoNVXmAJfg9JxoyY8PbBCSlLodXi0tra56JeaXeZfgVVLXJE
         Xl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761017767; x=1761622567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUWzCfRMIEouZu2LnNHD7D5uvWqiVgr1OLzZd5iVh4k=;
        b=daU09Jr9mt9OrXsqj2PPHcYvrG1c0uirArppp/ZqcfZ3fZoX3f1oUTFmciDQoaICJ+
         +YmFQN17eEigm36be90aUMoccLyvgAjkNg6lN0+ZJ6/Q3KhiL10VtfxO8tLauK5H9AL+
         A7ZPVm2221xYwiTwVkAHNVccB0VkFF4DMPIK02GQ0GbvbM7hW+AQUD250UP8suGknP6B
         J/+fs9Gz4Mi1KX+1rtjKikwnp1wwoS+ttL6v1j7R++IFSJcV/OYZWXUycIotgvOjA4zQ
         4eqiZ9Z5iYbaUaJkZ6X8aHWk9KvKgw0pSstty0cw7gE4ywxg12YVAZzuCvoj8RNLunYq
         mDmQ==
X-Gm-Message-State: AOJu0Yw8F4JqjdamsjzdZkrCrj+dIJq+nu98vWJoY6GdjSELshWyj9Qr
	2zVCTbdpqoAK/7bDJJtFmiz3QWf5Gi1iyMu2+qUNN3XsgKPmi+daKOAoBbVvzXi2jyo=
X-Gm-Gg: ASbGncsmDwO7M0qCTBT8e2CP6L+RLDT433XRUFWiTZSuCEJdDUMBxXGjVtw4+zwjb4p
	bRHYbcr3adEG/rFQNxxbzSjApz3P61xCLefzvMvRjDOlXjOr9JyT2ENfil6oeuTlJniSnMmYqY0
	2yKvcG7K/qPTxKyLXUN8U9Pa6z6bswXb6sfexdeFdLV51qgHZyVqtR9cNncPloWki2/2Ct6B7Xg
	YLpr7S3MUJAF4GfJrTjDH4REHTMwMfioWBoX0s0msz0waaIxcNT8rxYbN2yS7ZG79sQL6VeQM8T
	LCOjgCXtrC6KX1FXN2OIHPrEtDOuhfKzV8S7PjyDk6gEQ2vph0AMKtrpnK/KNAxHON6fU9GwFo+
	aBakmTA0Yf6tJwkDsWXiUTDCSna0byr2XgT7qXq8sgiY0A+g8pYw/ZdXm2p+vaKjY6p3QjUz727
	Zu6aa6gg8hhMk/nfy/H6ztaseZlZ/8qQCLv/Nn4IW1H1B8e/BSyFTi
X-Google-Smtp-Source: AGHT+IG0C1TKVIFUPu+8S6xJ/E9QCxdlevRMhuJigPSMEa5PQHA0bZMHW/ukD//n/TFPlnIEv3XuBg==
X-Received: by 2002:a17:902:d508:b0:28a:2e51:9272 with SMTP id d9443c01a7336-290cbc3f200mr220035715ad.48.1761017766922;
        Mon, 20 Oct 2025 20:36:06 -0700 (PDT)
Received: from localhost ([60.227.210.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5ddf1f7asm9452430a91.1.2025.10.20.20.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 20:36:06 -0700 (PDT)
Date: Tue, 21 Oct 2025 14:36:04 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [PATCH RFC wireless-next] wifi: mac80211_hwsim: dont perform
 rate validation for S1G
Message-ID: <e3fl4s2at6oz5rtvurivxormmndj22l3h2dkqovhnhj5u6fw2q@c65nw3shnxcl>
References: <20251008014006.219605-1-lachlan.hodges@morsemicro.com>
 <0f82718459bc6e31238f1189f8f5bfc859b59a3e.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f82718459bc6e31238f1189f8f5bfc859b59a3e.camel@sipsolutions.net>

> > If an S1G driver is submitted it
> > would be considered a "modern" driver and would probably contain its own
> > rate control. There has been some S1G hostap work recently submitted [1]
> > though it's only STA side though this will need to be fixed in order for
> > proper tests to be run.
> 
> I'm not sure really to be considered "modern" you need driver/firmware
> rate control, but I'd assume a new driver were to do that anyway :)
> 
> So overall it seems reasonable to mostly ignore the rate control issue,
> but maybe it'd make more sense to be "cleaner" about it, maybe
> separating out something like HAS_RATE_CONTROL to be per station, i.e.
> letting drivers somehow (not) set WLAN_STA_RATE_CONTROL?

I do agree - I have some initial rough thoughts -

Separating out HAS_RATE_CONTROL to be per station rather then per wiphy
seems to be a major change for just this single case? Now Im not sure what
Wi-Fi8 entails (heh) but I also understand it's best to do this properly rather
then some S1G specific hack.

It seems that introducing a flags parameter into the ieee80211_link_sta where
drivers can apply the inverse i.e LINK_STA_NO_RATE_CONTROL or something similar
that before drv_link_sta_rc_update() is called the flag can be tested, something
like, for example within rate_control_rate_update():

[...]
	if (sta->uploaded && !(link_sta->pub->flags & LINK_STA_NO_RC))
		drv_link_sta_rc_update(local, sta->sdata, link_sta->pub,
				       changed);
[...]

Then w.r.t setting the flag, we could introduce a new function that gets
called within mac80211_hwsim_sta_add() called mac80211_hwsim_link_sta_set_flags()
or something where it could enumerate the links of the ieee80211_sta and
apply the flag to the link with an S1G band channel context?

The reason for it being driver-facing is that any future upstream S1G drivers
may make use of the .sta_rc_update() callback.

Anyways, I probably need to do a bit more reading to see how best this can
be done.

> And removing the checks here in tx() seems a bit odd, why should that
> even be necessary? Surely _something_ would still need to be done here,
> even if only to generate some sensible radiotap headers for the virtual
> sniffer interface?

I think this can be left as is for now, still need to look into the radiotap
generation for S1G within hwsim.

lachlan

