Return-Path: <linux-wireless+bounces-16376-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0EE9F0C73
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 13:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C1A188E057
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 12:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457051DFE33;
	Fri, 13 Dec 2024 12:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TU4GiY3b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625CD1DF741
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093327; cv=none; b=hhG11aQ1lgSoXuKH3TfhtBwfAqKK0C38TwCIIcCF1d6iWm+HjgnNCGESTlY8IgRBITqb1XZU1OJP0g2WeHEPdd1YuR7gv9DO/es1KzyUWxN30jjx9pSV/u0TyqsJ/RG7XfF9kjf4eBC8qtbVLX5xbhX3zcvCJEgMSh5N0cJsX/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093327; c=relaxed/simple;
	bh=fBosB4b0uMdzr93u3VjSwHXGdBEOVoxZbJfSS1oL2Jk=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=jyVp+x2A6wkPdyb3KV/uG7kUw1ZPNn8F1eYwv8a5jPbo1+rtD3ROqCt+d8i3BcR26z0mbtSa3qjhZccsqWcy6O7vdAaw5cW1vTFZpgWXhars9GD0p7vr4x1eDpcCSHMKK4jErJAkJNvur38uKyVsb+OZZC6Z9zLGHtxk9i1DQ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TU4GiY3b; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa696d3901bso312361466b.1
        for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 04:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734093324; x=1734698124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a01EqQtDAg9WYWg1goNGbAKUKRJX47D19EMOSEaIHM0=;
        b=TU4GiY3bKcMpunHikHp0QpC+A9j3BfMZZw4XPpZmWrVkPiFRXzWuy36W/HSfPnTR+H
         5Mr7aMSjPOekovCjMVLc4iUlU696rIbI8ua76c9SMOr6l4Vs5ypj2E899wZ1DQh8y2qL
         QI87zbf0kljxvJBUvq6JdVkC9Veb3WVGzyLE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734093324; x=1734698124;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a01EqQtDAg9WYWg1goNGbAKUKRJX47D19EMOSEaIHM0=;
        b=eSGJgi3uWVGnHFBoVUTEcgE+1ARsl6rikGGlAPJg3FK+FUjtlZ1MgOq/gf0CL8Fq7z
         8zOdJULRM+pW2mLynE+nqRREg7Zbl6iuEgERjefr7ejFOVjk6SaVGj0AJiL1zguZN01o
         43K9/HJkLJ1FT1+mc/T0nFwnACrDF4GnIQ5YE17PKb/JX+W0o38s5Xn+n6sh43DDVn0/
         wBO7hdnL0h/E29+eGVxt8nP6HmOrBzUf29aqNxdUZvTJQkyrTmV3CqMoOaDLwFa5qcv7
         NzRmD1w8U8sD4qJwTwrxNUxCnj5yg7fCfxHTw66eQGGhz9oi09b66RnjXgqoZ32CDZrq
         8axQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ4/meEPrlwNz3ub2oH6Z3UwtHZKaOnHmsAlCFMgN/3MrMyZhDO8r4EozJs8loWIpQmKQcT1GJJYmXxoL7Dw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzoe2Jr/XT47STBMWu72pPOveea/nqxHM7A6TETFgxMWqsC103
	IaLoOckv8piwANqSGv2qwqqlGZGUaTj2PtDfGc35ERlJjqg7V9vaXYZwXFR68Q==
X-Gm-Gg: ASbGncve1eV7LNHQxPxEKMXfL7K7PGQHmuGTw/N+vZNefYOMddNYNJvfVy1ehHmOote
	JH0229uBcshFypHonPItPhK6w5q7EIqW828pQzlrQwxjGH0BroaBaj+t4/CQCZ8oWirriMaKHrt
	yxROeZwGlv1B3sn3sMWRBFgp5hj1tApKi1Inq9e4muP7hR6w77Is51LSKsiKFDmopssbqoklICN
	HhgKsCk+27T1+CGUU3Aoo6gaYMO8bwzBGamljBVwGzKYmorZBmVi5uk9p6Cz6zhC+Tn1ebOf12t
	A6gY1jsS0XBjIMvBrLM=
X-Google-Smtp-Source: AGHT+IHhynYv2IMD8GWzjweECbYHDZzNMwtZvnshxO4GJOBlYPz9X6fs6H96IRINbFIgXviRF+atJg==
X-Received: by 2002:a17:907:3da7:b0:aa6:79fa:b483 with SMTP id a640c23a62f3a-aab76cedfebmr283848366b.0.1734093323624;
        Fri, 13 Dec 2024 04:35:23 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa65d18510asm923596266b.122.2024.12.13.04.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 04:35:23 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Marcel Hamer <marcel.hamer@windriver.com>
CC: Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
Date: Fri, 13 Dec 2024 13:35:24 +0100
Message-ID: <193c0043af8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20241211133618.2014083-1-marcel.hamer@windriver.com>
References: <20241211133618.2014083-1-marcel.hamer@windriver.com>
User-Agent: AquaMail/1.54.0 (build: 105400535)
Subject: Re: [PATCH] brcmfmac: add missing header include for brcmf_dbg
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On December 11, 2024 2:36:34 PM Marcel Hamer <marcel.hamer@windriver.com> 
wrote:

> Including the fwil.h header file can lead to a build error:
>
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h: \
> In function ‘brcmf_fil_cmd_int_set’:
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h:90:9: error: implicit \
> declaration of function ‘brcmf_dbg’ [-Werror=implicit-function-declaration]
>   90 |         brcmf_dbg(FIL, "ifidx=%d, cmd=%d, value=%d\n", ifp->ifidx, 
>   cmd, data);
>      |         ^~~~~~~~~
>
> The error is often avoided because the debug.h header file is included
> before the fwil.h header file.
>
> This makes sure the header include order is irrelevant by explicitly adding the
> debug.h header.

I understand the change, but not sure if it is actually solving anything. 
Then again there are plenty of include files including others so...

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Fixes: 31343230abb1 ("wifi: brcmfmac: export firmware interface functions")
> Signed-off-by: Marcel Hamer <marcel.hamer@windriver.com>
> ---
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h | 2 ++
> 1 file changed, 2 insertions(+)



