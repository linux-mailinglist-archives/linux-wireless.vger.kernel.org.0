Return-Path: <linux-wireless+bounces-26093-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0EBB1884B
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 22:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A18AA3DA5
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 20:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084451A5BBF;
	Fri,  1 Aug 2025 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaYNyKLX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6B51EA65
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754081381; cv=none; b=b+TMY/zAuh8zOY3OvgWonzbqyL7zNfeLd90XyNO0nBIMQ7gYcOzGDQ8tHRUilXgfFjf+Ne6MpXJXCwPg1yHdsinPkz2d/ebtkBkVfCNs+svlPs5BW6SVkhb1caR2PkUVYV4AUCt+CrClfaOTrx5TaIrdgR040MqHimoUbVHwiKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754081381; c=relaxed/simple;
	bh=gBIb4R4iB093ZNxWj8LXv/kNWAoxEPFpi20C7kv8tHY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=h7cD6/By3oNEedlKHT2fFUeMOTZS4OFxE3I0Y8Gr87f44lt35mg0ILcPaEjgp6G1HFLvWQAsCGL2eElzFpIDFn10F5aItwL4JL8bMI22bcZ+Qsq8Au50LXrbUreiL4GzFAZsUd+xFW62siOjEbFNsPNgRxBx1YTQle2MaqzAi0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaYNyKLX; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-af93c3bac8fso99450766b.2
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 13:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754081378; x=1754686178; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pL03MWVaeQPYhDEKs35119FfHkhO1pMuWMLJ3VzrH9g=;
        b=PaYNyKLXIqXt7FWwqwv2vvojROshepiWZZ5jYUQxhbTLHPgNEm5qS2xqS+obYybHxt
         lJbw12gn2nAsoUBs73UB35mDhMrg2mChOENlmUtWXg/6rwWnqxXuXyYpqwOW7twEYh9r
         iJ8OSoYwbTI8R46hBASdgnw6MMfShZPqr31bRPv90tkf1NpGm4c64ksJaLT9MjGosJf1
         c/jsKQF98U2F9t2KG04utdxuYS78Ec9GScBFMqVqAthmdvqpeHeBvxs6SkY5EEQw1zyT
         xps3tFYjha6Vdh54qtik91OBxHVM2hZdRUqWTX597/rG1FDn9eHOZvBfROpi1UhkcxXk
         9baQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754081378; x=1754686178;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pL03MWVaeQPYhDEKs35119FfHkhO1pMuWMLJ3VzrH9g=;
        b=ukXFdQDtEIEv+UsNpL/KNi18gULHRyA525z8lv9UD0FrsVFxq1K3FFnytzKyMD98NF
         EHdyPIvRrPhEfDlMg+qLLqnX8UhBBwU/IyYGyqV5VRjeuaQI5Z3RhP6NADYJ4c8Mi9yB
         WdhUa2dlWywH/iYbamVYjwUTa84BGOr0lNH4auvMzprMb/QZdi9Ga/Dulcq88CfB3ft2
         yzQ8KoOVoXRcqI0wX8/YbBYZHae15XaNvSuR+0QsiMAXvLLkTiWrvyYtoIGZJZbku5X3
         tukfvfdw2nmsFHw99tVpnSfUVCGTkIl4E3Oy12MvgsD+bEKvjGRyFknjn4uI867n+brV
         +iVw==
X-Gm-Message-State: AOJu0YyQwaijlcdrTBzOcfc96MCaLYEttV1UvJf/8ebW2u7k890LyYJ7
	vs7rg4BogBtau8lH4RTgYyhbKPHz1/SBqjXLKUSi5/0Jb2xdEFwvrqAyrlJ8Lw==
X-Gm-Gg: ASbGncvaZwzQ42GwpqL5Df3JoRqcmVQbobClpDcAUCQkjv1dLlpi29SRhNDBDt4agA7
	w3Viq5wKmnEYJlXKPUUbqQqzRHcr5jnCQsAzWKN4iq4dWV93rVpysv4SQlX16e7jmvvJYVD4Rvi
	12U7fKhQDHqX8Ln5CdTxkzTYmmtyzR5bGJ54TrQKtKD10qHhkaRNX5592/hq0pMTPpVEVMgmUci
	1ZcPD8msHS765HQ/AJfqB4HA83ogtG7vPXUrY7qlHipwGuHQktApy7ySfZkGPBl+JCmKSAvdQZh
	70VBf791ci/R04laDR4vYciCMZRqo0tYVgADobAmMoRLUF3+mSY/XaAZDG3cTlA3Aec6kVk0sRh
	Osrer28gSxMT5/40paXEF4rIuJAz5Zw==
X-Google-Smtp-Source: AGHT+IHouzJBCHFZvWcgG+1NwDSt37mb22A9vB+ZSuqN2MC/RyZMPBRXCmttket04Egp2EYgamvGbQ==
X-Received: by 2002:a17:907:6d14:b0:ae1:f1e3:ccea with SMTP id a640c23a62f3a-af93ffbfcf7mr126481766b.7.1754081378515;
        Fri, 01 Aug 2025 13:49:38 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a2436easm335636366b.135.2025.08.01.13.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 13:49:38 -0700 (PDT)
Message-ID: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
Date: Fri, 1 Aug 2025 23:49:36 +0300
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
Subject: [PATCH rtw-next v2 00/11] wifi: rtw89: Add support for RTL8852CU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add support for RTL8852CU. It works well but sometimes it loses the
connection:

Jul 04 16:05:56 ideapad2 kernel: wlp3s0f3u4: Connection to AP ... lost
Jul 14 13:45:26 ideapad2 kernel: wlp3s0f3u4: Connection to AP ... lost
Jul 15 17:51:28 ideapad2 kernel: wlp3s0f3u4: Connection to AP ... lost
Jul 18 14:43:30 ideapad2 kernel: wlp3s0f3u4: Connection to AP ... lost
Jul 24 14:58:07 ideapad2 kernel: wlp3s0f3u4: Connection to AP ... lost

When that happens it reconnects immediately.

Bitterblue Smith (11):
  wifi: rtw89: Fix rtw89_core_get_ch_dma() for RTL8852CU
  wifi: rtw89: usb: Fix rtw89_usb_get_bulkout_id() for RTL8852CU
  wifi: rtw89: usb: Fix rtw89_usb_ops_mac_pre_init() for RTL8852CU
  wifi: rtw89: usb: Fix rtw89_usb_ops_mac_post_init() for RTL8852CU
  wifi: rtw89: Fix rtw89_mac_dmac_func_pre_en_ax() for USB/SDIO
  wifi: rtw89: 8852c: Fix rtw8852c_pwr_{on,off}_func() for USB
  wifi: rtw89: Add rtw8852c_dle_mem_usb{2,3}
  wifi: rtw89: Add rtw8852c_hfc_param_ini_usb
  wifi: rtw89: 8852c: Accept USB devices and load their MAC address
  wifi: rtw89: Add rtw8852cu.c
  wifi: rtw89: Enable the new rtw89_8852cu module.

 drivers/net/wireless/realtek/rtw89/Kconfig    |  11 ++
 drivers/net/wireless/realtek/rtw89/Makefile   |   3 +
 drivers/net/wireless/realtek/rtw89/mac.c      |  31 ++++-
 drivers/net/wireless/realtek/rtw89/mac.h      |  10 ++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 124 +++++++++++++++---
 drivers/net/wireless/realtek/rtw89/rtw8852c.h |   2 +-
 .../net/wireless/realtek/rtw89/rtw8852cu.c    |  45 +++++++
 drivers/net/wireless/realtek/rtw89/txrx.h     |  19 +++
 drivers/net/wireless/realtek/rtw89/usb.c      | 118 +++++++++++++----
 9 files changed, 316 insertions(+), 47 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852cu.c

-- 
2.50.0


