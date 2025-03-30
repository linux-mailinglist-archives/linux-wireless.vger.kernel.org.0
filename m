Return-Path: <linux-wireless+bounces-20976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EA6A75A67
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 16:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5056168564
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 14:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86211B87EE;
	Sun, 30 Mar 2025 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoEBCD5L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2B91EA65
	for <linux-wireless@vger.kernel.org>; Sun, 30 Mar 2025 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743346504; cv=none; b=Fm4jZYo3KwkAQffh2QSvZ/nYYAEqhjYabYTx2lROxyRKNm2KKzyPbFQ27+Uwt4wDJuWQHEybxogGu/6eGmPoev1PV+LkwGb1YPQeaBIlC2FyBw/McVl/FTpvzur8O0LQ/3F9GgSHILFtwMUEk8MwD7OLlcCu+MR4LPlf8binddY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743346504; c=relaxed/simple;
	bh=ju2ytygFokd+VclZudSM/AJg88N+rEOTxh4oZJQ4UKc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=SUkbp8Ke/JI9twNthyJh95w3nHSV8OPPxHev0EP65kBlkp5rid7CWkyHWP62/dwn6dXLBUFRnGX3YtGLnHFS1YS1c8hInfzUlCbKgU1yubAZYenfNEI1Yi9xJ3LiijQtPINeAkpyIX+3Sqv0z9XTjaYZPYY0aoMO+F5qnEluhq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoEBCD5L; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so545325866b.0
        for <linux-wireless@vger.kernel.org>; Sun, 30 Mar 2025 07:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743346501; x=1743951301; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSAh12/TWNYy1kUvblJKRoo+aLbv+mT8BOT8WuL+pZ4=;
        b=YoEBCD5LVFc4WxoMWdIEjCdZ04aoGNtLyz5lA2O/5Tk0XggY5cVPtVJox1q7b4IW9h
         9KlckWTWN7RhRedfryM2PJheHuXppJTq/AqXk8xZWn09YkJWjPejBzw+JoyF9EAbxSTL
         3Vx/SCv4+n9oDiGsT3RTn7rhVyg89M+gto9OgWIfA8/TVfoLtWSgm7ZIwPzU8cu4wUwK
         JKkG9t1hGXN88wHAkXFAE07MkrQwyGhOBHIxixU/0Wgh9UuWTFnqO2c43IjjOgzrd3gG
         z09+33E7zRJMbS53KBAe7s59G+NRMYj5SfO50M9MJX1+HWItzQkG7TD72lIYc7udFiXS
         EhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743346501; x=1743951301;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vSAh12/TWNYy1kUvblJKRoo+aLbv+mT8BOT8WuL+pZ4=;
        b=ZVy54whkEuPDpuvyGr6kGNq27LSylGgK3c2dWTtUtlJAq1/FG+ZQ5cBpwmBPxLYbsq
         Y8WP6j/ZyeW6AkNPTF9lZ6rL5AZkv/aBh4tQr8C9pw/8blbQxNjlix7l3oxvwHAPzUC7
         zcYvxjYJK0oHTF/+a3Jl+2BDOBXe9glCVYIIKxTOCGLpJqcr3zjUdcjb4vYkusxNiVrX
         7R3EV2/1FxaCLCCOxa+L/XF/3RWvo94yJlS5JhWvBCiXdyme0zQtF2GiwfqW36adpJEv
         ldbN4vvnPEDONvhcDXkfFqGhUv8xbM4MvRHOJfuJSuFFCfKEL0Ky3e5UQjv8WGF1LkpZ
         XJmg==
X-Gm-Message-State: AOJu0YwoZWRZK88wGxDpexXQexrhV/rRreDFJ/La/GTShGJpLX0EugSm
	qKyjZZdwH3dVwa/9jfywq/Nh/7zr+6sXl5rBnP46I8olzS2aASrA+sa7kA==
X-Gm-Gg: ASbGnctwedcGO5hG3ZeEDphKEGdPAeCpg7QE+mo36LuHDimyIpdagXBpI0XE8azX2LI
	Nf2kTSilz6snnJrubf55NUGU5KjytJmVaJp0WH+8Une8kejdM9YX3f9cGMsAZUztNtluJYbJe+1
	7pTG4HEbEmhbHwBqxn8kWeNsDxM+H0hN5uZKbuO65GipwCq5GpbWFVGZ3qzqZPQ+7E4iuhHQQiu
	8Feh4zmJm/YZnKrNlYLrBqtdjdXC/lolwtEJGEsqGBgmTwkkD2dF3+zOJsdArSyfIbixVPOGjRf
	qzgS0WWjjgIaocs1A9l958JE5XUxIz/FTw8jRcqSWKEhOGr1+bP+8g==
X-Google-Smtp-Source: AGHT+IHOf5rQpBXgDnPBZoIsz7ys0SA3Ojmw5px22yIzYgJExyPweJphkUFzFpjO9wJixzq7JvD7yQ==
X-Received: by 2002:a17:907:96a3:b0:ac3:d9db:14bc with SMTP id a640c23a62f3a-ac73864bd6amr396622566b.0.1743346500891;
        Sun, 30 Mar 2025 07:55:00 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71962130dsm481192066b.118.2025.03.30.07.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 07:55:00 -0700 (PDT)
Message-ID: <5ccba1b8-d7de-4158-bc9a-0aa465f1b2df@gmail.com>
Date: Sun, 30 Mar 2025 17:54:57 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next v2 0/4] Improve RTL8814AU performance
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is the last set of patches for RTL8814AU. They make it go faster.

Bitterblue Smith (4):
  wifi: rtw88: usb: Enable switching the RTL8814AU to USB 3
  wifi: rtw88: usb: Enable RX aggregation for RTL8814AU
  wifi: rtw88: Set AMPDU factor to hardware for RTL8814A
  wifi: rtw88: Don't set SUPPORTS_AMSDU_IN_AMPDU for RTL8814AU

 drivers/net/wireless/realtek/rtw88/mac80211.c |  2 ++
 drivers/net/wireless/realtek/rtw88/main.c     | 35 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw88/main.h     |  4 +++
 drivers/net/wireless/realtek/rtw88/rtw8812a.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8814a.c | 12 +++++++
 drivers/net/wireless/realtek/rtw88/rtw8821a.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  1 +
 drivers/net/wireless/realtek/rtw88/usb.c      |  4 ++-
 10 files changed, 60 insertions(+), 2 deletions(-)

-- 
2.49.0


