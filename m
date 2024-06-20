Return-Path: <linux-wireless+bounces-9278-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5746C90FFB7
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 10:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E570E2834D6
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 08:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740983BB50;
	Thu, 20 Jun 2024 08:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsJnUvN4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A6322611
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873943; cv=none; b=I1H3VytrVktPqcJeC+MzXsXM8hOFpKX+RJxACcaDiSIJLMyOfW/6iz4CbzBX7XgwYjESh4QUbbxM4vv+Yahc34+JBHl7aOvDhs8oDd1evCANw+81T9ojkTY0iyyGu4CuSkaL+T0gIdLBNtXtZ6ibxvih0z5o2cYg07LR/8g5zVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873943; c=relaxed/simple;
	bh=IbUeNxa6Ztg9ggQC8IhtjLkEjkCroZ9PYPXXCxGKkUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIQ3kXs44krrxY7V13EpzfaNmg1L/EOxgREnlaO64mY8UQV/aGXWVWQwj2lWAuHyNWePNwptKNcvobLbVJTKc/nwl5f+g0s41uke6kkMnKT1DhsdnF5xMlCZm0SZDqd4myuYLY6N91sFXBTrKaXTA4WGGtZpz1FACurn8bRGUPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsJnUvN4; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec0f3b9cfeso6151831fa.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 01:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718873940; x=1719478740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A0c4GWBmK6OfKPLjq+HRXk5iadfQq+qlk0GGJwyE53g=;
        b=HsJnUvN44zC//yXOE2EjzASQuhvYZVIPDul7qZl6z1OxxheYSLP9jZEh9Yd3NkhnPa
         eQC5ItiaaL4v8uWZZYgk5yEYpoeQ3W6rWYDYI2e94aFAlPMB8OcV2s7rYpOoYqSnvlBc
         xAo/Cem0gB6Y3Q9P+UPMvWvHu+PWCnMgQ1krH4L8gQHA7pRYK6RV1AkHD8Hi+7C3V+XD
         Wdpdhmw0anaZbdkOP6tlz8uWj2rbV+cpm4x7X9r7Lep8kNXT6fN99SIQOWdPJUA+fpJk
         f+lptuzGuo/0qamC4yCr9+PtwmKABlw6hh5J/3egge9y04t9ZqPm3fUTyBw7wz1dWBcQ
         QMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718873940; x=1719478740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A0c4GWBmK6OfKPLjq+HRXk5iadfQq+qlk0GGJwyE53g=;
        b=Ljh6r0SLgDYuXugzQeVsuasBsNiiGG48RiUcHD3kIKCPGukTIrVnk75lyySEoT/bJ2
         Cl5iCe5RkiYjRbAV8t0cmyXwVIVw7CIEyBRvu/5vi2zUh+CerVHnnSJp7pgBIwEA5yrg
         6qqnQQzpuuUHIBS15q1Y9YpL4CrD/tBjqoxmFGXluSDTk9dmzG1FAd5tU8tPolYKRV21
         Nbtiy323jgxHIyWXaBwSH3ZyATrfJQBsKyxL3SGVND/DKSXkSyzcGyPepDdWh6Uqnc2e
         f0EAF8dgbg0WNdngDeWUBtAbQfcpQ0LgpKcdluX/cgheVsa2h7x2WpBg1e9ujsuAlsvD
         Mymw==
X-Forwarded-Encrypted: i=1; AJvYcCUdwD8DB+c02I4IPHs8wuMeEuWs7qlNv4yashEAGRpGmt6Dc6+GecW0Oq+/4DdX3pFD+1N4mKJgo7i+rMkybIvcSKDF/D2WHEsUzcjwS1s=
X-Gm-Message-State: AOJu0YweL6b86zoq01KvaxdwK1wjqmljtOqiekoCgiWITPq/T9PXzyGY
	5f0xrO4HBeF7qAKJxrO/PoW12EUjnq/tdHJW9inAuZpVSb932qovu6GHMSIWkRrqxtGs4gIeiN7
	ACys5zBfyG+aO/JwwHPiyKZ/Ze8F9GE5i
X-Google-Smtp-Source: AGHT+IEMeEW1RufKZNUSAOVIeyM7M4gDXxUTXMXwz7ODyibLtgvSe4Vr204B98C7MQEgxk5UxQTUQeP54Re0d/0jTnY=
X-Received: by 2002:a2e:9612:0:b0:2ec:2ccb:8efb with SMTP id
 38308e7fff4ca-2ec3cfe8a75mr26594501fa.38.1718873939728; Thu, 20 Jun 2024
 01:58:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617122609.349582-1-arend.vanspriel@broadcom.com>
In-Reply-To: <20240617122609.349582-1-arend.vanspriel@broadcom.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 20 Jun 2024 09:58:48 +0100
Message-ID: <CALeDE9O7DCPhoxdMyHmYFOjwdkPRepiaaC92QorzSTXCduZ+xQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmsmac: advertise MFP_CAPABLE to enable WPA3
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Arend,

> After being asked about support for WPA3 for BCM43224 chipset it
> was found that all it takes is setting the MFP_CAPABLE flag and
> mac80211 will take care of all that is needed [1].

Testing this on a Raspberry Pi 4 [1] against a UniFi U6Pro AP I can't
connect to my WPA3 only SSID, it works fine with the SSID that's
WPA2/WPA3 on the same AP. It doesn't connect and I get a whole lot of
the following errors while it tries:

[  155.988865] brcmfmac: brcmf_set_channel: set chanspec 0xd02e fail, reason -52
[  156.100906] brcmfmac: brcmf_set_channel: set chanspec 0xd034 fail, reason -52
[  156.108597] brcmfmac: brcmf_set_channel: set chanspec 0xd038 fail, reason -52
[  156.116317] brcmfmac: brcmf_set_channel: set chanspec 0xd03c fail, reason -52

I also have a RPi3 (BCM43430/1) and a Rock960 (BCM4356/2) with working
brcmfmac WiFi I can test if that's useful.

[1] The upstream linux-firmware FW: BCM4345/6 wl0: Apr 15 2021
03:03:20 version 7.45.234 (4ca95bb CY) FWID 01-996384e2

> [1] https://lore.kernel.org/linux-wireless/20200526155909.5807-2-Larry.Finger@lwfinger.net/
>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
> index 860ef9c11c46..a5aa58047d39 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
> @@ -1090,6 +1090,7 @@ static int ieee_hw_init(struct ieee80211_hw *hw)
>         ieee80211_hw_set(hw, AMPDU_AGGREGATION);
>         ieee80211_hw_set(hw, SIGNAL_DBM);
>         ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
> +       ieee80211_hw_set(hw, MFP_CAPABLE);
>
>         hw->extra_tx_headroom = brcms_c_get_header_len();
>         hw->queues = N_TX_QUEUES;
>
> base-commit: a2ead3445a6317c5d2b53711cf9a98e54c395223
> --
> 2.32.0
>

