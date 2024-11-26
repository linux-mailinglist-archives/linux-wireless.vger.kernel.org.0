Return-Path: <linux-wireless+bounces-15711-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6299D960B
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 12:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B76FCB24EB2
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 11:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7621CD215;
	Tue, 26 Nov 2024 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fwuhfsOV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565861CACE2
	for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2024 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732619633; cv=none; b=Y7nm5VC7FGd345GMQyhzXzBdS67qr+eoFWRnNMXpQvt9HLThnvNBTVnv/8wBDy3CSq4WwK3Nc+HhFxJuKff8qWYqNlJZoKTi1QRZmULt75fWbXKqer0jd2ZjSvc4S3S7KN7ylw1zQ2amy1E0GtcgpqqasKIIxzRcfRJzAU2ltSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732619633; c=relaxed/simple;
	bh=P+f4x4cp34/QK2b5aXO1a6r0IdOJPje9zK6YfmUgAng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYrRl72v5CjxvnXUQpytt4HTnUbzvBx3DvCKW25/b2kwru1MGxY70OrbrGPxapuJyi0OJxjSvueMbaGE9yiQ7AHrzxfT6l9DV98N20zSeKxHa9GiXFW0aRR9AwLpvRMsPwGlz8eJ/24mtdvya2KF/XrdSfvlMjaAI5s817jzEZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fwuhfsOV; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ea2dd09971so4683673a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2024 03:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732619631; x=1733224431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WaedEROScXbmZLW2dLxh5VEj9F18yKa88b9QQRbmaog=;
        b=fwuhfsOVJ1c7p5BuMrgBoVe20N4T+CdHU20hCnWx1FqAVCsDkh8FWJVaDYV6qHDQQE
         7GpulNq/8TSEFdbVAunQYG9DCHRu0CLNbqGulMVsXnADjtOCCKlNknyO1KpjN27Lev1B
         UBvOvC7i0XRXFJNTV3qbCIQtaTEO6K36/ukWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732619631; x=1733224431;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaedEROScXbmZLW2dLxh5VEj9F18yKa88b9QQRbmaog=;
        b=vaXtwmKX7MCZtWbzkYJlUrI8TWuFFE5KyONlZ9/I9XjXewTEdOAdX2KPqmjzrMJb0q
         AWWBkauSMaSl+6edfXAnt3rDCyBTh46OYPmyxA154i9uFrGehPO5LZ4fVi6TR3rzvUf/
         GfxB0IXF70fKDjlrCu1a1hexkFUs3rk7uY+c9RkkFdoK56lgDgO8mHJ/uXGtBeA8YZRK
         PVtnTyit3mW1TQBmAscj+b6s0WyDkQE1l0kKQUMYunpwRkka6MCjtJcg0EuJmCSyPbWV
         pkyIPhYRx+S8uXNc5Ac9J9OdT9Ugzv3VvcJKMsktaFHOEprosXfpH1/AqdSeuLrWw2PU
         SpbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUUc+VeZYeCRT96F3GJDj6NKKLMs5uS5nxdcpN+LHjrBySCM443Qt6qBQAegCtbPaliBbzzXIV0cAhFua4TA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb1grzCtK2roiguHhxpnsZ4rM2Zn/IXvs5B5HHsBfP4Aeo6Itm
	pAqAS3OKQDKTljIuBKks8hCQVckiU3DwxarHzvMoOTzAjgsHwDnAGmUc7v1JJA==
X-Gm-Gg: ASbGncsjb0jwg9H3AcvU9PBmlJWy7R0IEUnMl6fSdr4OSKZd72aUJTJZqVnz43h+V25
	xSla3jsyaIKA7xkMviS/NYo6N/+pKEa4/SdGNMygIx+3Ek3grmg8SuH/wOlZj76CUAjAFNDIZXI
	BgVRWcsZFr0efFizDmkx4BrJ7Y4MIATuNI4alTtQUX+nKqWV02LFc8ajlna9RL+N7FlivtzpXZt
	Q+o5GLaxjng/krQkJw5+Kdsg12OXtj78VZqajQr+ZWEoL7J3Yhda4P2w1KIcC/N/FX4mkcMzysU
	Hw==
X-Google-Smtp-Source: AGHT+IEx0dge3AH0eYaowfAlKd02/aR04hcx31QrPIxtxydsY8h2mdiB4Ia2A2kz1H2Z+4+2qJx63A==
X-Received: by 2002:a17:90b:4c89:b0:2ea:97b6:c466 with SMTP id 98e67ed59e1d1-2eb0e22f524mr25752876a91.12.1732619631574;
        Tue, 26 Nov 2024 03:13:51 -0800 (PST)
Received: from [10.176.68.139] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0cff9c88sm8541644a91.19.2024.11.26.03.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 03:13:51 -0800 (PST)
Message-ID: <980c5cee-2dc3-4d26-b749-6ba00b9c2091@broadcom.com>
Date: Tue, 26 Nov 2024 12:13:44 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] brcmfmac: fix RSSI report in AP mode
To: Alex Shumsky <alexthreed@gmail.com>, linux-wireless@vger.kernel.org
Cc: Alexey Berezhok <a@bayrepo.ru>, =?UTF-8?Q?Alvin_=C5=A0ipraga?=
 <ALSI@bang-olufsen.dk>, Hector Martin <marcan@marcan.st>,
 Janne Grunau <j@jannau.net>, Kalle Valo <kvalo@kernel.org>,
 Kees Cook <kees@kernel.org>, Neal Gompa <neal@gompa.dev>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241122210346.2848578-1-alexthreed@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20241122210346.2848578-1-alexthreed@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/2024 10:03 PM, Alex Shumsky wrote:
> After commit 9a1590934d9a ("brcmfmac: correctly report average RSSI in
> station info") it is required from firmware to provide rx_lastpkt_rssi.
> If this field is not provided brcmfmac doesn't report any RSSI at all.
> Unfortunately some firmwares doesn't provide it. One example is firmware
> for BCM43455 found in Raspbberry Pi.
> See https://github.com/raspberrypi/linux/issues/4574
> 
> Fix it by falling back to rssi field if rx_lastpkt_rssi is not provided
> (like it was before 9a1590934d9a).

Sounds like a reasonable approach. However, I would like to learn more 
about the issue. Maybe it is a per-vendor issue so I am interested what 
the sta_info version is that we get from firmware. It is printed in 
brcmf_cfg80211_get_station() with brcmf_dbg(). You can make it a 
bphy_err() call instead or enable TRACE level debug messages in the driver.

Also would be good to know the firmware version and kernel version of 
the BCM43455.

Regards,
Arend

