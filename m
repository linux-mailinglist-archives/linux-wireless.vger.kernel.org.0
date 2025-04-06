Return-Path: <linux-wireless+bounces-21175-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50795A7D111
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 00:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26CEE16F301
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Apr 2025 22:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887DF22154D;
	Sun,  6 Apr 2025 22:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCgHd3s2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB746191461;
	Sun,  6 Apr 2025 22:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743979047; cv=none; b=EC02aKT+SHINmx3mFLn+pN++f5tev2g3rbUaUDVHe3W5A6yjfLCA0QuktCmZX7C698uahWlHryAUNq0tjpuoriZ+ZAzBdf/+kQVqveLtn7SZECgki39o/g3BD2Qm8L11NRGPCGiJOjRSybu1T9YzRrZ7HCsQHMl6bDTN24W1CWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743979047; c=relaxed/simple;
	bh=BEZuxW/tPkj0TNRpDw+niTh+GANp78QImBZ+kCA3ghE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ir3rcOt+u/lWGy/lSwDFRLMMCQS7M8cd/5//vjFunNV+3DgzRkjGGj/fdg8O/l0YPGQ9tfs0nCzDov5zZfsuuHrPdRGzrA6gPd0+jX74j/0Hv4VTj06lAuhfmnCJ0FZLFzqy4sVJkcqB7rAS8vAv5D2rBqye+TiuEYMYYB7Jhrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCgHd3s2; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac73723b2d5so790810966b.3;
        Sun, 06 Apr 2025 15:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743979043; x=1744583843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WHqUPfV6WMZ2X/rA9+CQ7dYZUn1Zy97wM7iX0HT+Yec=;
        b=DCgHd3s28Vvnh+c9coJWRoHifVeGW0XquS/eDLC3+67SpGB8SxZoyENSFvBuSuVCoh
         xJTHs1I/I3t4nxtKQ22ML4PUqMk6wSQWbkNKThLjmZpWV2sC4Y61AWIAoifAj4rL9LOi
         UiBYQwbGIhrVcP4lAaMRSIa/v7OuMhAXUO8ZPoDevkpxo+g5K34QbuyASYj42YMuoyzU
         YzF0VXW/X5vKhdIVtVNRFG1c+wM+QjHgXt+k2PSnqqIBDKmYaZvhFQXnGV+xk1v06Oi9
         OY+VbtFQrRwvcZAw3arEjXzj84myXPkl2alQv5TCs0tPmzro6zgOOJvQgDfXmfbmSoCo
         0Aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743979043; x=1744583843;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHqUPfV6WMZ2X/rA9+CQ7dYZUn1Zy97wM7iX0HT+Yec=;
        b=FJsmo8JSW3Xg9Gaouvocu57KM1AzB7Xk6dWj2vR5VydtE58KBxhcge8Xt9hZSxkd0Z
         CTZKPfSXvun0QcqsOKij0SD8Tz5Y+kd9nFQe6ys13j9HnJW6LTsXbmkpGx7T6d33+PJ7
         kXxrlz1UwQfBYbc7yiCIgsZBejY2/IC/HTOI90qBedUTsjHQUxqiunt9PuDigH9wH+4K
         ZgD1cAwT0RdaM/jFsB/cQThrq9X/5xxqTStEbyZtmucCNc33L8EOz0xbik4u77y9Nf/t
         Kb7m58MvecxJsJkDW/dVFBYiVTtoBVqkVE2zoIGBnGqs1zURDWIPszCErnKS64GkdU0b
         AzQw==
X-Forwarded-Encrypted: i=1; AJvYcCVjAcJuoqJpcQet9hVzDsnpRYiqGqTzjllSZsHbzxvt05fkF/hlZ4XYYQ6xzXHBo9Hu7kHIS7+846u3Bqyv@vger.kernel.org, AJvYcCWQEBJj8DCLwvv27d+TFslkmLdUV55rUnSZyNjNuD8I1anqslh33Ks2yk/D+ckYg2o92YN35euxbXcK@vger.kernel.org, AJvYcCXF/w/73U+Ibh3d8TRWHI2uiQkw/+Qe1hOKb8WQOngqqTrfgHatLRtB+KRVAoZb1nF/e4oWRxfH1SELwyibJV0=@vger.kernel.org, AJvYcCXZdXf7/S43yyVfs5C4f/mt4G7SV/FfQ9GzCsMs5xPEKCBk5BotlNRvrn47T0b2GYtJW3L9cNLM/+Rh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0kNv1mGo/KTgkmUWC/pub/wZc7aiEgn26v5AqtxJsKRLnnvPe
	N4Nln0y0yjfIk4Kbr8sjzqTsG5K1gKIiDlwKuXWLzA2yg64ZhI4j
X-Gm-Gg: ASbGncs5eLSiyCje8etqDpdiid0mOE+VDXOg6b9XsQyhsDC3QSousVKelhowGF9FPnL
	Jp+g98ono87On/p0UW7HfD3jb75x7hAOtevXIO2pXW11J6aayF1NTMIxVlxdu19tgXWEbtNSH06
	DXFX3iodpi/RQln0Wx6rzb4bffBLf3NgaJyVoZ0R7P8cluYyfGazJPqPF1/dGtw1TIWzLmbR+Rj
	OxaXIyvEb95XnDmjR9I+TfO+VVZ/858nRWaVzKDQYAiWV1DnJNaI57en90YSKgSexUIo7uvv7wM
	J/R0GbfJRlTYy+2R9ov/QJzqQbNAmg2tqG4GPtwEYwJo5DRhlOi2/Q==
X-Google-Smtp-Source: AGHT+IGH/JCb2haLK8M6Hg83Hl1Ir/URcGcMma3Wfc+3EBUya5WF+wecNHln934OF3SpETZoePDA2Q==
X-Received: by 2002:a17:906:c110:b0:abf:607b:d0d with SMTP id a640c23a62f3a-ac7e71b25e7mr739510166b.16.1743979042671;
        Sun, 06 Apr 2025 15:37:22 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5c804sm649423466b.15.2025.04.06.15.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Apr 2025 15:37:22 -0700 (PDT)
Message-ID: <14513d89-1ee3-4d90-bd26-1d761714a8a9@gmail.com>
Date: Mon, 7 Apr 2025 01:37:17 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 0/2] Onboard USB device support for RTL8188 2.4GHz USB
 WiFi module
To: j.ne@posteo.net, Johannes Berg <johannes@sipsolutions.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?J=2E_Neusch=C3=A4fer?=
 <j.neuschaefer@gmx.net>, Matthias Kaehlcke <mka@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jes Sorensen <Jes.Sorensen@gmail.com>, linux-wireless@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20250403-rtl-onboard-v1-0-10ca9a6a4ee0@posteo.net>
Content-Language: en-US
In-Reply-To: <20250403-rtl-onboard-v1-0-10ca9a6a4ee0@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/04/2025 17:07, J. Neuschäfer via B4 Relay wrote:
> This patchset adds rtl8188 (usbbda,179) to the onboard_usb_dev driver.

RTL8188 could mean at least five different chips (C, E, F, G).
Should you use a more specific name like RTL8188EU?

> It is found in a set-top box called "Fernsehfee 3.0".
> 
> As a side note, this device is currently marked untested in the RTL8XXXU
> driver. In my experience it works (tested with a WPA2 home network).
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> J. Neuschäfer (2):
>       dt-bindings: net: wireless: Add Realtek RTL8188 USB WiFi
>       usb: misc: onboard_dev: Add Realtek RTL8188 WiFi (0bda:0179)
> 
>  .../bindings/net/wireless/realtek,rtl8188.yaml     | 51 ++++++++++++++++++++++
>  drivers/usb/misc/onboard_usb_dev.c                 |  1 +
>  drivers/usb/misc/onboard_usb_dev.h                 |  8 ++++
>  3 files changed, 60 insertions(+)
> ---
> base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
> change-id: 20250403-rtl-onboard-f38354f0b14b
> 
> Best regards,


