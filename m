Return-Path: <linux-wireless+bounces-26082-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 849E5B18830
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 22:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E941889D8D
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 20:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA26A1F4628;
	Fri,  1 Aug 2025 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJyhJBqP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C4C15539A
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 20:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080553; cv=none; b=fdnzdObJFfEXdFWqo0AIZ1lCqBd1Uu51rrqtifD0/OgJbTZeOVZlQMha+fKWY6U1/7QhM2OUwzDhHKopxDdN4EzBpB5Mus0MpkwUevDVIkVHRPrdPtvJqFCZoHL0pYlXekxuHkRUn/YWdBq6jVg3yjFEyV7UFw3qhAE6VagGhCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080553; c=relaxed/simple;
	bh=gBIb4R4iB093ZNxWj8LXv/kNWAoxEPFpi20C7kv8tHY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=a/BO4uQ9w+ntboiEfjvfem4i2AHKduOyCepTE5fxbIschyi+DHTR8o2OOjTPSEzi5r5tV02hhJcBs4txTvdrGB7szjCv8Lj8dyp2eEw9rBw9+xVG0laQiIwOAiyfrjDKhRlkFjr+m73IcKyJY5XdkKNyGZTH6QqNt7WWhoGT0Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJyhJBqP; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-615d0b11621so1848988a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 13:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754080550; x=1754685350; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pL03MWVaeQPYhDEKs35119FfHkhO1pMuWMLJ3VzrH9g=;
        b=AJyhJBqPfplP6qwT0Nlb6JC3foxlNqw/QG+DeUDBXqHgWLRYtsruvYxKmzW9txDOTJ
         XDUKUQ1xbpogSNd0J3at80HaTRhdQvkwfUbL+T8ps3iq3WluCzDLF/UIwx9Mvr/qQLRg
         BggLoLYpi7kvfjY8tJ/YFrkQ7rsSe90Tm3JN54r0dwbvsnkp0gBz2sePdfnJ446LJKp/
         pnWpSENsH/sXdBj//Z7JfDB+V72q8tunLQT19E2j0P5PiVj6xtEcowcCLYlQC8jx4567
         1O9C8HSOVisKfePW7/flu1cF+TpzJ2Ph/ti2SJw2k85+8SB5ED0Ji5tVsDhNhrkjwAvr
         j3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754080550; x=1754685350;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pL03MWVaeQPYhDEKs35119FfHkhO1pMuWMLJ3VzrH9g=;
        b=TguzX7GEVSXnjCqvv5O7yDOqA2wkSRjkJWlSIhuz09dSwySG2xYvt40UBl6tshTXYs
         A1NCqJgY6wXjd6Rv6V9NTCWI+u7tAE7MI+21Fvr4qz4o8YdUgK6FaiLUY5PgF/V4htLS
         mLmjE1++/alh+zd1qhNObUGV1o54Oz6PKn9r0XHOP2JSqkmDw90wpVMwBLT7WG7wmyB7
         80Wg05Y3BepLfpHVFdVMSVT/GQvYYKaWruvV1KpMTg22NgO7xHFvAwLYmSsqyGqoYHQk
         6IjqbY2NmdjWF4Ste3DOqgYS2GbOGw6PRzBIAbPn0dg6haD0H6QGLKiugZreKGRLSowF
         AIrA==
X-Gm-Message-State: AOJu0YznzYE72oSKzjInE77GB/NXXIO65l28ojbokDNcRgKmnOylFIZ4
	AKZnx8n1QoC9duhjDiEGmkvcvhD5SGOc3R9lMiG8SbYIFsg0yxZkf6n5lyyzZw==
X-Gm-Gg: ASbGncvekCutBUF7tq0qfHpD/qni+DsQmjL7KEjvaRYmI+WmKDLvhbmxqOZFmT5k4MF
	CJwEBEMDN6jhbY/ZgNQSsdTXLTxw4rdtMEen+IqxXYBknlGmEJsTQ92miuVFkp0MivCfCQrVD1Q
	v/0C+Zf2d0aANdlO6460KqIKZ+RIBe69NzcnN6J4KVaF2yoftCC0P5n7GW6VZmfNJPtX2KjdAZU
	BE24VUyu40kEz4Vxjmd9v2v2k3e5mC6AVJfWJy4PVLxbgn1CHhf2d/NWlHIkSAdprLn3ibJx4Rh
	q1hqyBRKpv5dQY3OutYkXK04Rz/AYDZ400OmvxTbhK+GnFEFu3rK1a+7wexv4TrgWEiPGtXyybU
	HWRdcKUjrhnITe1u8gUIwn7lUPA23DQ==
X-Google-Smtp-Source: AGHT+IEQpbgMe6rW+PWdhkN7LdN9x5ogiToftpEidAGw1ys/qGjj1AEh6OwaR8RJNJOcztAYdBZcEw==
X-Received: by 2002:a17:907:2d28:b0:ae9:c8f6:bd3 with SMTP id a640c23a62f3a-af91bc55e14mr869317266b.7.1754080550471;
        Fri, 01 Aug 2025 13:35:50 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a38b5sm332432766b.45.2025.08.01.13.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 13:35:50 -0700 (PDT)
Message-ID: <2527e1be-3121-4f29-8539-72f4bfb225a6@gmail.com>
Date: Fri, 1 Aug 2025 23:35:48 +0300
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
Subject: [PATCH rtw-next 00/11] wifi: rtw89: Add support for RTL8852CU
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


