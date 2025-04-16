Return-Path: <linux-wireless+bounces-21600-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6D8A8B736
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 12:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3028C1904751
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 10:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBC3221FDC;
	Wed, 16 Apr 2025 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmbF3wXG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961F91EA7DE;
	Wed, 16 Apr 2025 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744801059; cv=none; b=DgG0g6aQcBkYpX4mp/QA09/7fSI2ieVEhNwWoMTjcGPOQKdN7hAK6rzasKMFnqotl827a1Ze1gMSHOCHa/2hgrIsnKfj+uobo2hjwh87tytfrdUuyC45XKr/wgAU04zaeLC+HAm+J4CzISQ1n3hj6m8TOEyzoFeL1k7+hIVgkFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744801059; c=relaxed/simple;
	bh=n5OD57ByKsMWMZb31j1vI0m/8FYMXvRw6Qzyl+XNJwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqVGP+YLOh2iPbnKNIS/Fwnj2Ns9Q/X+EkF4zCSX73reZfZAa8QKqdom+6qhXMqMJfreOH/xZnrfHa8ajheGMbQyekVGFSMnd87ZBrsu/V/hT6aOtTAiQeaqOVZ/qVEm7vH9Rv4/EaHGnShK+4z1TuQBaZ8Z9oIupMAhCqUgtBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmbF3wXG; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54acc0cd458so7589279e87.0;
        Wed, 16 Apr 2025 03:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744801055; x=1745405855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mi2CnsLZ4oCaH+9zge2bT1EWpw3tv543EYCISAVMhSo=;
        b=SmbF3wXGT76Ng8G9sUnrk1BlQ0QbzSwa4/m5lfoXdMGG4/rKP6ke58gddsoMWSaRGM
         7Jsd5a09JZUNqJPvki4ATz9/1qylyiNoZMS9UFUdc15MyxdaW9QuVX1nQurXQCAW1u2y
         nZv2FNIq4U6gDsiBk4iulSIRcKS7s+6I4wOwzf+2r7WvsUBVdR0PNTZeMTpvxtJNXDMu
         4byTPEsJWAhfO2qNJqNhIpY/X7x66Ybkit5XnGYwLbM2OsGXzDNrbNIAlcEGsjGlaXjY
         i7ZID4Sbw9WgcKPKLfiY3/eFkTn/ZamZ/RKdOy7a2vc2nf7yaw273vu88eO+rBev9VbD
         tNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744801055; x=1745405855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi2CnsLZ4oCaH+9zge2bT1EWpw3tv543EYCISAVMhSo=;
        b=okk9axfNseiHhzNigXXd1wgN+1zyVhZ1/ICySzyH0dNWuDLLGXkLLbL/7xHGoR4PxD
         vi+IMA4TlyajkhOzzc3pZoZRv3ySolw4M9knVIT7L3D4XUojQf7dn1AT3BXvyr33B+Qe
         6e+jZhRvZdKttrmXcM+NqPc/rTrjd/EU6B/JQ6N/XVlz7F7Pp9SF7CufLsJUrWctOTZ/
         +TtJHgF2X0+jQxZ7VgYJ/Q7HbKm2oh870SWsvS6KbdUoDR35ng4HdTI/9N4enVqA/XyN
         zOUwnnhRJNSx686XjtCVLpdeYD5fv1qP1d+7xiwDtyABWyrVSy+erhL59Pk6VpmBmGlP
         pRLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+uod46N2pVz2jDA3f0Nkv27jdZ7NOYtdA4Hzje5nTyC0IHmWxpEYdNaltw4OBqYOJPSBwj559o4TjvBo=@vger.kernel.org, AJvYcCXK5pte/fGXPo3iDlZ1ia3k/dA8qsGlIpEtTfbnp61gdCsplpsCyDPKvEft5VS+1xSrdHgX5+3QJbNkgwVf1bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMNpAHe7LKwzoXUBglDwa5RlR6GMnrP3vGvkyKKqAB1OH8wEsY
	M8G1Fiz76Bz8zpSKR9O7ohwnuO8gT1hK1KTothQwL+RhNL3xa06LOEJLvg==
X-Gm-Gg: ASbGncsPkrwbpFOAX4+GYWFnPOxAxwtnMPP/lJ6UpBMGXuA+RBMS6M+e91VODoSmRRP
	r3Ur9T7yWFs0VBvEwc0dmdf0yOe2HerWiyQsZVRXqZciqAMnUiG/n6P5p4KcVatKGEKrEtGKmKs
	qrLiH3IcKcbhkl0syc4ymj6nd6LKlTgaI3kTIphSpxTH0Hqf8G/ZbkqkDgWW64HhUFdXqfkPuZL
	/L3Kd4nLs5LbGR8bZ3okptr/sx1F9nz7/DGev7hYAyejSzv9Us/8xHYAyWDNk0yfbGwtn2xxN5+
	lpqLyDrgteUUg6QqeLgvV23lV1PzAP4JGqWD
X-Google-Smtp-Source: AGHT+IFkYIn0SpLD9wW9p3ju9cW5nmJZDsRM2Bu/b2eAN0jB2Zx7uVRCirtc/l5OFprDkIXaxte3Vg==
X-Received: by 2002:a05:6512:118a:b0:540:2da2:f282 with SMTP id 2adb3069b0e04-54d64aee099mr451692e87.42.1744801055037;
        Wed, 16 Apr 2025 03:57:35 -0700 (PDT)
Received: from localhost ([83.149.199.15])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d5201bfsm1610103e87.240.2025.04.16.03.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:57:34 -0700 (PDT)
Date: Wed, 16 Apr 2025 13:57:33 +0300
From: Fedor Pchelkin <boddah8794@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bernie Huang <phhuang@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Bug report] rtw89: 8852b: IO_PAGE_FAULTs with beacon filter
 feature enabled
Message-ID: <z54thedngt3wnhr5bfer3yg7id2c4uqgw2jjvyausv6p66ys4k@guqol77fpugz>
References: <uidltsdsuujrczrtzgerhh5cw2tztxktfen6yvztnc7gttzgvk@jccomj7f4gul>
 <148ed65c53be4ef29246d372dd0fef8e@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <148ed65c53be4ef29246d372dd0fef8e@realtek.com>

On Wed, 16. Apr 00:49, Ping-Ke Shih wrote:
> As bisection, can I summarize as below table?
> 
>     d56c261e52           firmware             IO_PAGE_FAULT
>    (CQM support)
>   ---------------      -----------          -----------------
>       o                 0.29.29.7                  yes
>       o                 0.29.29.5                  no
>       x                 0.29.29.7                  no
>       x                 0.29.29.5                  no
> 
> If this table is correct, we will check the beacon filter feature in firmware. 
> 

Yes, it correctly describes the situation. My suspicion currently falls on
the beacon filter feature in firmware, too.

