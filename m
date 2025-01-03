Return-Path: <linux-wireless+bounces-17058-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 906E0A00E30
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 20:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642A53A3EAC
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 19:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DAC1FC7CD;
	Fri,  3 Jan 2025 19:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YapCH2Cx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3218F66;
	Fri,  3 Jan 2025 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735930934; cv=none; b=Jg+kY9m4jQcoC29E4r8pOazaBhPX/Y5F/pJgd/+U1vuNrotHuM5qCfBXZLMUnwpWWZxpfikSrObuGQWduF1hKeKoNnn00PTxr+AckNq7Vq0Kh1W1ZWKLhWZ5tm4lwsdiWv5wvEiB7YjMHYd/VIN8ZMlq2Gu1MhW4MTSoL3Ksrz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735930934; c=relaxed/simple;
	bh=qnfTPGIKnBWHHYVVhovkU9kh2o62thYs9X1ISyMphaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O28bBNjnzCgvLBrQPH84R9sTdmSd4KuA+jP7k+hHn8p2UT3nlcJSuYSOYRJvY9DktEReemdCmTtaZG+OORCrQW1vwSE8qP54k/i3x6t/NppW9l0OuLlfD+4aMZyC8YZvMU69ELSaqlg5bXWGngMu1iPa1vijyPxvIvtNEPApkTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YapCH2Cx; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3003c0c43c0so143423091fa.1;
        Fri, 03 Jan 2025 11:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735930930; x=1736535730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1KgHCiRi9nWy1Z/TrZ1Jux7HqNSuzzybGFVrnwV11Y=;
        b=YapCH2Cx5xN9nPx9ugxb+3NAe5C8Vq0dSP7cq12dqCltzEFdoov8LrKXv3dajixA/3
         p4UJffdZ+um689TRZ3j3TgGh9c/B94qiFLxJY4UJkjGA7zgw4uWmV1IY/RuPP6Gg9Trd
         5rCxgXqpxYXByGiEwIoUt4iA+74ZSXrh0HdiDn7vVysb3yQTa8Ay3fdQCP5CROAIwNii
         VsFIfszkjfp9/aF4382ekTRBqcMSowToVybC+lIO3m7Dai/kpin/uGrdHa+3NOX7nAWn
         HvhQtL7V8dtPSBpgobxDa97oOSXdcs3zGXma6cgU2vKLsJ3Ayq/WnpLWB3bskOQCsHd8
         aBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735930930; x=1736535730;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1KgHCiRi9nWy1Z/TrZ1Jux7HqNSuzzybGFVrnwV11Y=;
        b=RMIJS02giCNkYy2LKsGMrwjMjxPNiPZVOutSLnrGC0zp/6yx6L+2G0ihx71KgE7kDZ
         gqeI52+PwH3QSJAK12pXE8XbqpJdaKKp2ZWzGf0By7JvvHfwPXSWmvQVf9xCeOIEAIS9
         TQo2GWdACsyV/YOt13BN0KRRfmLhShFjsNsKDu8jM57mX3HDpcp5Z71X3dF+qM9P9zGz
         eYsiPogruDSW9RjQtcP77cDya9ndQvIlRZPSDtIDQnFmvBQk6d6PV6n8jN1J3hSRwtqc
         BoRhDveZxgMRn0Joue/32VzSFu0bVstUqfcY1Rfecmd2Oo2q05muYbeGrXArGeUOjTbm
         4G6g==
X-Forwarded-Encrypted: i=1; AJvYcCV+atjtDSlYMs6qjwY158AkeLD9hqxixs18lF47CzFW4B3DvgDwxSEnISw1zukWVN/w3sY0woP6ATYgzC0=@vger.kernel.org, AJvYcCVoUHP8Oxm1WO9yY+SiAfqQ6rq2SuDdyMhZSsyG1y9PUSR/Bp7HqhVqIlW9IuZTk62QU7ak9428DDIIqZgwe5c=@vger.kernel.org, AJvYcCWKeuvxvIFCX9XNVihELkCENh3Plyvs9+tg44FIzzn4ULOBfGm5WyznRvXZXKfSpQD4iypLM3I5@vger.kernel.org
X-Gm-Message-State: AOJu0YyfE/RM8WxhgMyFcXvN7aYPE+GXQFSTtm98Tkb3uLgdc9fOfCCa
	tkX5eGYBX9tWdga6Ce6yA4esUZQt/+4TyBU2r/+dnwmgyi2aspqZ
X-Gm-Gg: ASbGncsZ7o5VBuVy567RbaC9507jJleXPvNP1C4Dc2Il80blhTcyJWBIB46A2h1ZSSb
	8Nroay9v671h21ZT5zUP4cS9BBnsElLExr5ybewI8qTyQ2uPCIWf2rjfJ0QpxGqzfg1GqWddOA2
	YPnCJLv9sYbzH2IuxuLz2fUSLC3Lq6HBbbGW26DfwRn5O0s+pqm5zSY+5HZRelbTK+u4YCvVcIV
	MmND93c/L+Yfk6cO9bSxuN6Y5F4FV88AJyi3Lvb2xjxzEtLZEV81Z0vVxso
X-Google-Smtp-Source: AGHT+IF2Wq5yCLKJQvhdC3sub9aFSiSYE3bjXBhXs9pq8nUJx9uxG8wEwrzyBRUCCaufRG7Hopsv+Q==
X-Received: by 2002:a05:6512:1582:b0:542:63a8:3939 with SMTP id 2adb3069b0e04-54263a83a69mr2350158e87.8.1735930929776;
        Fri, 03 Jan 2025 11:02:09 -0800 (PST)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542236006f4sm4281644e87.98.2025.01.03.11.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 11:02:08 -0800 (PST)
Date: Fri, 3 Jan 2025 22:02:08 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
	Fiona Klute <fiona.klute@gmx.de>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: rtw88: 8703b: Fix RX/TX issues
Message-ID: <Z3g0MLOJlLsPnF1m@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
	Fiona Klute <fiona.klute@gmx.de>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20250103075107.1337533-1-anarsoul@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250103075107.1337533-1-anarsoul@gmail.com>

On 25-01-02 23:50, Vasily Khoruzhick wrote:
> Fix 3 typos in 8703b driver. 2 typos in calibration routines are not
> fatal and do not seem to have any impact, just fix them to match vendor
> driver.
> 
> However the last one in rtw8703b_set_channel_bb() clears too many bits
> in REG_OFDM0_TX_PSD_NOISE, causing TX and RX issues (neither rate goes
> above MCS0-MCS1). Vendor driver clears only 2 most significant bits.
> 
> With the last typo fixed, the driver is able to reach MCS7 on Pinebook
> 
> Cc: stable@vger.kernel.org
> Fixes: 9bb762b3a957 ("wifi: rtw88: Add definitions for 8703b chip")
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Tested-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

Thank you, Vasily, for fixing that. Performance is much better with
the fix. Here are iperf results made on PinePhone:

1. without the patch using rtw88 driver
  1.98 Mbits/sec

2. with the patch using rtw88 driver
  14.0 Mbits/sec

3. using old vendor 8723cs driver
  23.6 Mbits/sec

 
-- 
Best regards,
Andrey Skvortsov

