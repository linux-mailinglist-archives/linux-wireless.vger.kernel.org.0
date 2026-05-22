Return-Path: <linux-wireless+bounces-36784-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOVvBH7jD2rGRAYAu9opvQ
	(envelope-from <linux-wireless+bounces-36784-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 07:02:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8755AEDE8
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 07:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAE8B301E94C
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 04:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0649235F5E1;
	Fri, 22 May 2026 04:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbeIv5MT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6127D357D02
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 04:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779425727; cv=none; b=hQAGYO1vYm+BVHSoh4/v2BUYlx2auu8qFatXQW83RFK2C4CUlTRyP53mp2OBa72LCbKfbQSPyjfTvHKvNEMQvZYdzf06BHiEwIBioT8Z1p1hTityb8GBXhTEyM3sUfVSYvXanYDPpefLuWyiW6VKJO0zMTO6TIUbrofh2GjfM/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779425727; c=relaxed/simple;
	bh=B9CAhNAdGTp5Zt5LCmbUDLKXezoz9dQvKZMGvVbfxrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9+gCVj4IoPXGGKmhNTXcSI9mQSHhoVm54Rd4TQuHpE2sT+01IouSh4gDBjXkET8B4afYhAs2jlOEXHxazUf3yxdclCc7kraeRGUOuykgP0sCYNfFnfa7ViXsP9C3PvuctTBtacOyC/bvLa7GDWc77AmlMdLplIUYRL/Lyh+oQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbeIv5MT; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a8891febd2so9480499e87.1
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 21:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779425724; x=1780030524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2uaBSQpnXDZ0Lr2vqL2X8w5SaBUCpNSkuNqugybr2/A=;
        b=GbeIv5MTw2u/PaO2jrKBK2QR0+f6vbEfqatUpYeF/bCRKRhpq6G8Yn6bHVqyKbI1nO
         6aflGJoaJ4FzfLZN2vCoCXevRZkYXwZ0ohRvtIJXvxt2FB4+k9M4FpvxB9W3y197bLcX
         jzZOqcdFQ6HV/axNzl0q6d65TSOGZM1FYwEzSzmHuAQfon6HxozChLLd9/L69PZ6wO+o
         BkUjjOuiW5GpBTuadz6fKqNuP3bZ2aGwkn2/iHq1LfFsfqp/JKOnGWjKayLekJ9Bk1L2
         iKO/ICx3ULCTvLSVIqiJXbMEUeDgTJ6tlBe24etov6zbxICSiBCXgQ+LB7PjnK3fwgt5
         V9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779425724; x=1780030524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uaBSQpnXDZ0Lr2vqL2X8w5SaBUCpNSkuNqugybr2/A=;
        b=G/jZ9Nu7sno6KFfcCM2aSSUrBeR8ASmUxLANN58bdUjtR3/TDpAw0zLP5iB9rBoNiv
         smWJFg8zsVctiWQ4MzYwzG5ZVYcyGUt4CQlpGMVFZ59k4ghoAuLi3yIl5eiNOeXCMdeX
         qogIvHsdkvk3zd576fs2CloMhJD0E9R+Yb2oRMLkjwJ50sthduD5ZOUn4QxR0XH4GmcW
         O5Vgi9tHKQ3TXED8MNPq96fvbAOdw0I6v85oArfI6LCgmi3K/uN0fxFr4qyWjOdFPlHa
         eQ8IECBJPqHWFEv5tViiZJcaI4DIR9Q6WDNKFTMqDsGFVGQKhMaaVI6hsIXE1q/hjhvL
         Rn7w==
X-Forwarded-Encrypted: i=1; AFNElJ9WrfD9c4sCvxaJeDdW1jdhxM9Z8aS5Jx0l7bk6e0X3U9rGL7lsgcdr2GS03NkPmck8QAysVTa/O4LW2dV8yA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy624dxuXUGIlOA3s28QEBaIQhtNFZ169C33I+03VJSuxMcspwr
	fx/yuj/bU2fNoRwGmivCpWvB7RQSYmJMerPdu+tEDPGODxJOF1TOW/s6
X-Gm-Gg: Acq92OFwa742RAUFQmWIlzwPoplDgKM4XShlCj4TZyCFCDfxqry3wAJlmF8Z++ZB1Y6
	lZx3EQsz5qumFKNgrHWcr2hKeTBNghguB1wDgw1My2gCkC1U3wCK3xdJuocVA7hFf/UhrlMXCqP
	44w0rbD3kJAGz9SadPV91xccO5QeWr+gv6f3KsG155EoIdi7I/oNPRZsNPVRWIsS4bxA+HTW4p6
	j5+N+iCtNouf99fBycY8UC0UQMc26PyPQHXZWp40AMp6st2yUMR/z+ubMTzsOvu3jBghxeNEf8F
	tXW35TnRn3WPvRhzcRiMOWmw1pQy7DU5Y/OcKDFiWT25xCcoSG/1yuNraQHPUkr70atw/2Ag+wa
	hHfHt26PCdz7OhDK3anRK68sbqHRFbCqwjaWesXMh5XwwY+yDYQ4WgqqCq5OlmQ2c/RA3Gvziab
	oCR2fC2PusWqqI8hfq9BwFDXQoR93Z1jIWyJ+XesTX+zx1OKU5iErXzyJ618CJgex2VSPq5U9h4
	3NZHANGO4e2X1VC4dE=
X-Received: by 2002:a05:6512:2552:b0:5a8:9988:f1d5 with SMTP id 2adb3069b0e04-5aa323bc03emr387730e87.24.1779425723236;
        Thu, 21 May 2026 21:55:23 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32cb36d2sm144533e87.13.2026.05.21.21.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 21:55:22 -0700 (PDT)
Message-ID: <b79d8ad9-f36e-4769-9dc2-58baefe23000@gmail.com>
Date: Fri, 22 May 2026 07:55:19 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] [v3] input: gpio-keys: make legacy gpiolib optional
To: Arnd Bergmann <arnd@kernel.org>, linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Christian Lamparter <chunkeey@googlemail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, netdev@vger.kernel.org
References: <20260520183815.2510387-1-arnd@kernel.org>
 <20260520183815.2510387-3-arnd@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260520183815.2510387-3-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36784-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,googlemail.com,sipsolutions.net,iki.fi,kemnade.info,baylibre.com,kernel.org,atomide.com,alpha.franken.de,physik.fu-berlin.de,redhat.com,alien8.de,linux.intel.com,zytor.com,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,lists.infradead.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[40];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mazziesaccount@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5F8755AEDE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 20/05/2026 21:38, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Most users of gpio-keys and gpio-keys-polled use modern gpiolib
> interfaces, but there are still number of ancient sh, arm32 and x86
> machines that have never been converted.
> 
> Add an #ifdef block for the parts of the driver that are only used on
> those legacy machines.
> 
> The two Rohm PMIC drivers use a gpio-keys device without an actual GPIO,
> passing an IRQ number instead. In order to keep this working both with
> and with CONFIG_GPIOLIB_LEGACY, change the gpio-keys driver to ignore
> the gpio number if an IRQ is passed.
> 
> Link: https://lore.kernel.org/all/b3c94552-c104-42e3-be15-7e8362e8039e@gmail.com/
> Link: https://lore.kernel.org/all/afJXG4_rtaj3l2Dk@google.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v3: resend
> v2: skip the fake GPIO number passing from mfd
> 
> The removal of the arm platforms using this is not yet going to happen
> for 7.2, and Dmitry's changes for the Rohm drivers have not yet
> made it into linux-next as of 2026-05-20, so for the moment I
> would still like to see this patch get merged, even if we are
> closing in on completely removing the legacy gpio support in
> the gpio_keys driver, so we can make CONFIG_GPIOLIB_LEGACY
> default-disabled sooner.

I am (still) all fine with this, even though I like Dmitry's set. I 
suppose you already have a plan for merging this, but I still have to 
ask - why the MFD changes aren't in own patch? I feel it would have 
simplified merging, backporting, reviewing and reverting if needed.

Well, other than that:

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	-- Matti

---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

