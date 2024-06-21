Return-Path: <linux-wireless+bounces-9447-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA0F913095
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jun 2024 00:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651A12886A3
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 22:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E06516D4D8;
	Fri, 21 Jun 2024 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M7wl2ioZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0140A16B3B9
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719010246; cv=none; b=NZPjvpT1Zv6jRAEWvQuh4Xcro8+3ffsJl+IA2mTwUF56YaVmNSa2ZDcauH0C2ezTaKB//8kZA6n9be/2IxWMp9Bu2Tv+tms7yEwczR52rgKpROVCKxYHUB7fCdeZNCVK/2Uw1f719OdLo5utjPc347Bi/hAa32Yb1hqQb1bnicQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719010246; c=relaxed/simple;
	bh=qdXb7h2xSSWEhzC4Qt2mxzTAvZLwyXuoc2FCs8MmEQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCo4+Qjm3ThD9WcoNakmbCYHTz/igfhHUSlA3rL+SwjltHgWaZ9mWJLAMwK51yasy71atrZB7i44fLYlTOOVLayJg8PeI7qNtSPfp3vo2vuvzDL7qwQBvC9H8fl+7MeNc+8aV8SUmDmfghbl0ImDzzx/O1m90kA9T4DjV0ocxTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M7wl2ioZ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7065e31ee3cso611264b3a.0
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 15:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719010244; x=1719615044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IdAX7YqB8PuY9bzTn2bAULXcR/7WVxmcKxOrcis8Hbw=;
        b=M7wl2ioZu9k4qBOb/pQKdlWjY6SrVVVKMam+ns81v0v+oyuuqo5l1z14CxW7/mfAMo
         hZM4i9WpQ91tdDW0hxy8BSycGiCfExUAZ3nCFO88wRp+vlMOOzxy+HC+qBberjCyFsnn
         zoARTQ6c4dAzVtlxkRZtrnJD+3h9XZCl9og08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719010244; x=1719615044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdAX7YqB8PuY9bzTn2bAULXcR/7WVxmcKxOrcis8Hbw=;
        b=hcL5mJ1SpoWD6QHAZ/jJQlLs2nvPJgYyp4uuwHCHK3aUXS4mfIwP9lKYtn1vXSOKWE
         J6jea9iI/RYpD8rgjhJvCGXn+eYVwI/yRdRrNRAwtN6dDfkFtcI133p+0lOAKMlI04Hy
         rd93rtGNtczuDHnHavP76Wsani29ueXM9nuiC+n6fFfajuMEd5fQDpoMmlnsUOhES0js
         oI5rjVuFlJclgmHIuuGiK6PHUqCG23ZQbRIQ40mRY67Np6l09c1i5LrYTDMFvENCiYWU
         0YErl0xq0gShSNNx8pm15Q12ejMwviFtUA2Tw8Q+Abs/120b7g9ccz3L5GL1mH+rdxKr
         pPVg==
X-Forwarded-Encrypted: i=1; AJvYcCXMgSeTVeKcq73iCRmDmGGZzka8rH3GvpMbibk6HLRW3wR0tHOVMkQJQwMCA6BkTZ1nRRItexs8VV+BF4Y+CfnRXs8Vel/eLCb/5lfA+Cc=
X-Gm-Message-State: AOJu0YzE41VFYeiGtyZD2ObJ4Wc3Xx+Qzk+b/PDrPDS3hkXaV6FUOBu8
	IXNHpupRxxpSYLloBxGHaff+jYtxFP2nmF3WbClBqwsfTtkieLTMWJ8TdHB59A==
X-Google-Smtp-Source: AGHT+IEuv038RQes/j90RQdadBEcwu5TtIIxJ+qn0yvSgF9gdxWbw0Z/sDsDE0s4taUdJZXL2g5LOA==
X-Received: by 2002:a05:6a20:b802:b0:1a7:60d8:a6dd with SMTP id adf61e73a8af0-1bcbb60d03fmr9158258637.53.1719010244154;
        Fri, 21 Jun 2024 15:50:44 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:40ba:89b1:5f45:68d8])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-706512e000asm1997743b3a.179.2024.06.21.15.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 15:50:43 -0700 (PDT)
Date: Fri, 21 Jun 2024 15:50:42 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>,
	Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH] [RFC] mwifiex: Fix NULL pointer deref
Message-ID: <ZnYDwjS293Cb8O1f@google.com>
References: <20240619070824.537856-1-s.hauer@pengutronix.de>
 <87wmmll5mf.fsf@kernel.org>
 <ZnSHcZttq79cJS3l@google.com>
 <ZnVCzx3-pvbcYQLm@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnVCzx3-pvbcYQLm@pengutronix.de>

On Fri, Jun 21, 2024 at 11:07:27AM +0200, Sascha Hauer wrote:
> I am running plain wpa_supplicant -i mlan0 with this config:
> 
> network={
>         ssid="somessid"
>         mode=2
>         frequency=2412
>         key_mgmt=WPA-PSK WPA-PSK-SHA256
>         proto=RSN
>         group=CCMP
>         pairwise=CCMP
>         psk="12345678"
> }
> 
> wait for the AP to be established, <ctrl-c> wpa_supplicant and start it
> again.

Thanks. I still can't reproduce, but that's OK. From your fuller
description now, it seems it depends on the particulars of the bss
indices in use, and maybe my device/firmware is behaving differently.
Anyway, your current description and patch below make a lot more sense.

> It doesn't seem to be a locking problem, see the patch below which fixes
> my problem.

Sure. It's probably harder to trigger real issues out of some of these
kinds of race conditions, and the logical problem below sounds a lot
more likely.

> At some point during incoming events the correct adapter->priv[]
> is selected based on bss_num and bss_type. when adapter->priv[0] is used
> for AP mode then an incoming event with type MWIFIEX_BSS_TYPE_STA leads
> to adapter->priv[1] being picked which is unused and doesn't have a
> wiphy attached to it.

Ack, that makes a lot of sense -- although I think it also implies
either you're getting some kind of corrupt event buffer from your device
too, or there's something else logically weird with your firmware when
you're receiving MWIFIEX_BSS_TYPE_STA events for a *_AP interface. (Or
maybe that's also racy, as you're changing the virtual interface from
STA to AP? Not sure.)

It also highlights that I find this fallback code from
mwifiex_process_event() weird:

        /* Get BSS number and corresponding priv */
        priv = mwifiex_get_priv_by_id(adapter, EVENT_GET_BSS_NUM(eventcause),
                                      EVENT_GET_BSS_TYPE(eventcause));
        if (!priv)
                priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
                       ^^ // if we didn't match the right BSS/event
			  // metadata, we'll deliver the event to an
			  // arbitrary interface?

But I don't think that's your problem. And at least so far, I don't
think the AP and STA event IDs collide in any way, so I don't think
we're likely to end up misbehaving even if something is misdelievered.

> 
> -------------------------8<----------------------------
> 
> From 3357963821294ff7de26259a154a1cb5bab760cb Mon Sep 17 00:00:00 2001
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Date: Tue, 18 Jun 2024 12:20:20 +0200
> Subject: [PATCH] mwifiex: Do not return unused priv in
>  mwifiex_get_priv_by_id()
> 
> mwifiex_get_priv_by_id() returns the priv pointer corresponding to the
> bss_num and bss_type, but without checking if the priv is actually
> currently in use.
> Unused priv pointers do not have a wiphy attached to them which can lead
> to NULL pointer dereferences further down the callstack.
> Fix this by returning only used priv pointers which have priv->bss_mode
> set to something else than NL80211_IFTYPE_UNSPECIFIED.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/net/wireless/marvell/mwifiex/main.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
> index 175882485a195..c5164ae41b547 100644
> --- a/drivers/net/wireless/marvell/mwifiex/main.h
> +++ b/drivers/net/wireless/marvell/mwifiex/main.h
> @@ -1287,6 +1287,9 @@ mwifiex_get_priv_by_id(struct mwifiex_adapter *adapter,
>  
>  	for (i = 0; i < adapter->priv_num; i++) {
>  		if (adapter->priv[i]) {
> +			if (adapter->priv[i]->bss_mode == NL80211_IFTYPE_UNSPECIFIED)
> +				continue;
> +
>  			if ((adapter->priv[i]->bss_num == bss_num) &&
>  			    (adapter->priv[i]->bss_type == bss_type))
>  				break;

Acked-by: Brian Norris <briannorris@chromium.org>

Something about this formatting didn't get properly picked up by
patchwork though, so you'll need to resubmit. Feel free to carry the
above tag with it.

Brian

