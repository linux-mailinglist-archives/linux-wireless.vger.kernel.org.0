Return-Path: <linux-wireless+bounces-38620-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3ozWHwRcSWq80gAAu9opvQ
	(envelope-from <linux-wireless+bounces-38620-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 21:16:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B612670839C
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 21:16:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Wvh/VKVn";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38620-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38620-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80A273019F36
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jul 2026 19:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F3837649A;
	Sat,  4 Jul 2026 19:16:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB302857C7
	for <linux-wireless@vger.kernel.org>; Sat,  4 Jul 2026 19:16:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783192575; cv=none; b=Ib/xsIzEt/hCy1KHT5pAOoJ+zdQH5thdugppzJWBE5fcS2BCeLcc7B886xfabiDLWkbye91/kFEIkrq2OgUKcLtdS5gzaSogMAzkeao64CL38ScPEkenOQJonkGRjbG9OhxgrDfsOiTk1MvyjFvqcPXrVsotA/tr/wk5vnyShtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783192575; c=relaxed/simple;
	bh=C4wxHpCv+5YXsQAc3k/V5kDkh4ZcF5yvwGrfhqZ3d1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0OfyvKuFGGn1Vs55pv00i2vERuUwNt72ooFp7o2iuIcjt5Lpj7eoJrtRuwGXxjqmSlQ0g+2TUGf5GgAo5FjhElazxpxFr7dfEkmTmzX01flOVMl8+b54Kx4UKJ0MU7dOnI5MjUKUoKitqvtJfUMYQq2QYI++YNR7lsckXRFSLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wvh/VKVn; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so10638355e9.1
        for <linux-wireless@vger.kernel.org>; Sat, 04 Jul 2026 12:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783192572; x=1783797372; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NUuNU9pUEVWjF8FhXupVqhD/EoAh21KVdQG86X8m/M4=;
        b=Wvh/VKVnMK8rssjUpTQtP3jr7/otE7WrHAJNchYWLO7HPM3olAVKJVVGuih+kAaZ0K
         Dr3nq4FvXZ2iAyGhaviBa2R3gJrxcInpYjUC1c9J84yHcCH1uRDohuCljsi1t6TBLxVP
         NfxawSKxwovRIc5Pn+l3B4ArzRTcfpXMM1FKA40Ph+dP29ISyvkkhBHCcaARYqoGNYnY
         5EJxRRGENzLFHA56dKtOZBWwNAzueoABvvBgyFYnxmgrBwuO+aVlMr+ApKnO/5cez2xZ
         lB15wV1wSdOqfWgacXcMPbQ/6WRTl8PuX6GapnwpkDs6BD8CU8jkmYh2B7YlQAPuS0ah
         xCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783192572; x=1783797372;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NUuNU9pUEVWjF8FhXupVqhD/EoAh21KVdQG86X8m/M4=;
        b=IyUQd5+3o+FQeMU1QN87/rj/DNrB1RYxXNHCEFVmX/5ka3ngXjqyBzTqP7Z3+UmL3k
         MSYn3WnZManOsxCXZvUzOEve3AtrHEuuIuuKXAObGAaio5zrweoafX7fnQXEGhN217FQ
         aXxUz93ytheo5EnSzBbtFRI18zDPv7F4RKn/iRcDWLgpo9KBdwc10tk2NTTfo/QZ6pJy
         wuPBCXTQMqTlHhyQR+WFiqlx/F8rT7h5xrq68wpYzjs0yC0kLJP5bMbTZ0LSdUpFPSai
         XkwR6MK/QgrZxARSI4qp9T8sLImA+LmwDTUsLTPpfzEDcWUpLRHHBr2ZPNWWWW4zQI13
         JMAw==
X-Forwarded-Encrypted: i=1; AFNElJ+4fUck3x2I38gWYOLwpIXOLpun+bE2HmcOOx1FA4Z/S+uWbBcJESnoGAOLpPi5FsdHbKj8YuhQKd8na+51MA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzALie+NgkLfS/qixUrqY6BPCO0DfYJOhXXWNKdX+XZZscO4Vwe
	e9ElaAzWbuNcrqpUzM0dPSzoz6FWPiYuOlalApsxRZcC7wx1Rm9WBKFw
X-Gm-Gg: AfdE7cmso8cWOGJ9jIordseYdX6jWozLfcx0xlvTcBrLIsagB/I8BTvhkuFCeNUTLl/
	vQPTvtHwOjN3wPkulK5B+7Kx3vuf+f7csyEd52/a2umPm4XRFBIAkcoq0TXdl7RJRG7byp+YQ41
	VTGkE/DLYdT9nhxyp+5G9yezPBpN3Ki+SFXSkkst2WqMWTLf2MiGaERLJaXQPpIpxv4LdYD0V/B
	m86aR+6+hPzOEG9omsSIAploM3vjRMMIhmbCo2sDw3Yds5tp/eBYu2/Z3d13R5KmUMcQculsqwP
	FVst979zWYso2g2ULII/luOhLXyu+eed1wen2ENMZajmLQRjhti62PzJWBu5cCpQadwrkMwsHTm
	BVdOVJp684VhQ4PeFn+xvzAJdYNvHN6yg5ClJXZuuBTMGGkoy6zk2Y1ON5+iJ5kcQx8um4r6YbQ
	gWt739nqK+6+H1f1ZweQ8OXj9BkBnvOcwLuWfvlWrLh+bt7IsfeIvViMj+vPZnRJ/u0vKqyNLzp
	XCZNvk/GZt71BaAYSHEvg==
X-Received: by 2002:a05:600c:3222:b0:493:bc4a:fb55 with SMTP id 5b1f17b1804b1-493d11fe625mr30410675e9.38.1783192571784;
        Sat, 04 Jul 2026 12:16:11 -0700 (PDT)
Received: from shift (p200300d5ff229f0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff22:9f00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce03fa1sm142182245e9.11.2026.07.04.12.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 12:16:11 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift with esmtp (Exim 4.99.4)
	(envelope-from <chunkeey@gmail.com>)
	id 1wg5qU-00000000J4d-2IKj;
	Sat, 04 Jul 2026 21:16:10 +0200
Message-ID: <9b20652f-2195-4593-a24b-2f222e4e3ba5@gmail.com>
Date: Sat, 4 Jul 2026 21:16:10 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: p54: update stale wireless wiki URLs
To: Anas Khan <anxkhn28@gmail.com>
Cc: Kees Cook <kees@kernel.org>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260702102325.63955-1-anxkhn28@gmail.com>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20260702102325.63955-1-anxkhn28@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38620-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:anxkhn28@gmail.com,m:kees@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B612670839C

On 7/2/26 12:23 PM, Anas Khan wrote:
> The p54 wireless wiki links (wireless.wiki.kernel.org) return 404; the
> content moved to the Sphinx documentation site. Point them at the
> current wireless.docs.kernel.org pages.
> 

Yes, Thank you. I clicked on the new links, they all work.

Acked-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Anas Khan <anxkhn28@gmail.com>
> ---
>   drivers/net/wireless/intersil/p54/Kconfig  | 6 +++---
>   drivers/net/wireless/intersil/p54/fwio.c   | 4 +---
>   drivers/net/wireless/intersil/p54/p54usb.c | 2 +-
>   3 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/intersil/p54/Kconfig b/drivers/net/wireless/intersil/p54/Kconfig
> index 003c378ed131..44b0f1a724aa 100644
> --- a/drivers/net/wireless/intersil/p54/Kconfig
> +++ b/drivers/net/wireless/intersil/p54/Kconfig
> @@ -10,7 +10,7 @@ config P54_COMMON
>   	  also need to be enabled in order to support any devices.
>   
>   	  These devices require softmac firmware which can be found at
> -	  <http://wireless.wiki.kernel.org/en/users/Drivers/p54>
> +	  <https://wireless.docs.kernel.org/en/latest/en/users/drivers/p54.html>
>   
>   	  If you choose to build a module, it'll be called p54common.
>   
> @@ -22,7 +22,7 @@ config P54_USB
>   	  This driver is for USB isl38xx based wireless cards.
>   
>   	  These devices require softmac firmware which can be found at
> -	  <http://wireless.wiki.kernel.org/en/users/Drivers/p54>
> +	  <https://wireless.docs.kernel.org/en/latest/en/users/drivers/p54.html>
>   
>   	  If you choose to build a module, it'll be called p54usb.
>   
> @@ -36,7 +36,7 @@ config P54_PCI
>   	  supported by the fullmac driver/firmware.
>   
>   	  This driver requires softmac firmware which can be found at
> -	  <http://wireless.wiki.kernel.org/en/users/Drivers/p54>
> +	  <https://wireless.docs.kernel.org/en/latest/en/users/drivers/p54.html>
>   
>   	  If you choose to build a module, it'll be called p54pci.
>   
> diff --git a/drivers/net/wireless/intersil/p54/fwio.c b/drivers/net/wireless/intersil/p54/fwio.c
> index 3baf8ab01e22..a3d9053f043c 100644
> --- a/drivers/net/wireless/intersil/p54/fwio.c
> +++ b/drivers/net/wireless/intersil/p54/fwio.c
> @@ -131,9 +131,7 @@ int p54_parse_firmware(struct ieee80211_hw *dev, const struct firmware *fw)
>   
>   	if (priv->fw_var < 0x500)
>   		wiphy_info(priv->hw->wiphy,
> -			   "you are using an obsolete firmware. "
> -			   "visit http://wireless.wiki.kernel.org/en/users/Drivers/p54 "
> -			   "and grab one for \"kernel >= 2.6.28\"!\n");
> +			   "you are using an obsolete firmware. visit https://wireless.docs.kernel.org/en/latest/en/users/drivers/p54.html and grab one for \"kernel >= 2.6.28\"!\n");
>   
>   	if (priv->fw_var >= 0x300) {
>   		/* Firmware supports QoS, use it! */
> diff --git a/drivers/net/wireless/intersil/p54/p54usb.c b/drivers/net/wireless/intersil/p54/p54usb.c
> index c0d3b5329f4e..b88a3dadddc0 100644
> --- a/drivers/net/wireless/intersil/p54/p54usb.c
> +++ b/drivers/net/wireless/intersil/p54/p54usb.c
> @@ -36,7 +36,7 @@ static struct usb_driver p54u_driver;
>    * Note:
>    *
>    * Always update our wiki's device list (located at:
> - * http://wireless.wiki.kernel.org/en/users/Drivers/p54/devices ),
> + * https://wireless.docs.kernel.org/en/latest/en/users/drivers/p54/devices.html ),
>    * whenever you add a new device.
>    */
>   


