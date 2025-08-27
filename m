Return-Path: <linux-wireless+bounces-26707-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE6EB387FE
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 18:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3A6685EFA
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 16:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59672D192B;
	Wed, 27 Aug 2025 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSlfR7rz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206E62C3250
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313294; cv=none; b=QxD6oJPYs4FVQhQOCTlpRd7iMaF59zKQjqNo0ggHe2ODV8HMsOh8xw62uoW7AEY1XKnN8SmEDLhLT3ELWfGNkplleO6T3weJTNak587sNodnCueRfEeBhCthkaao1E5zbKIbX1ZeqKk7Z/gHQ5T881YnvsY/WO0almNxjivWn4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313294; c=relaxed/simple;
	bh=ZEt5sQACmcmGj6HYsmE+C754Q1U3gyns2aMeNjk6ID8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=HA9gT7CuqnvApxZI6gbc2qzAwD8Jldz6Gbfduv0nprytGFl9SPZ2xcy96QKuPd/uvRd5jDJMtSuBGD4vUv987+LQ41XSbvHwSL+kjnmoWM1e9RenYaSXUn+L413EjprWeKaDiTLQIUl6Fk+tFfBjlxWJvNcPnN5kJsZHb3n5bwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSlfR7rz; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3c7ba0f6983so51878f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 09:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756313291; x=1756918091; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpwITSA8/LyvLGQhYgV8c0xvdP5oPyCopUJtWYhldGs=;
        b=kSlfR7rzPJcOVVxesNwyKIOLFBKdMhS0FIpgBk/Ci5GTosENhHucg99lnVRfjW6uHe
         Pv2jUji/lOePPx8G7pblzseSeO+kMqv0GdPLm7KQZHnKhrMh9WXaqjnCoTZyWFlQC3DF
         EpS05dFQdkzv+Af0ITlRatzbKjcIZBpR+dliZvvwDzzRkH9ODn1mE6ZApVVu8fI2DZ4x
         iBIUvgPcf3JB2DjxtYhgAd3KUJ1rwPS8kh9SdeQ4em49up9oOwbYXpdkoRey4ZmPWned
         v4Ia/5DFpG+j15436Z1jXCZzP/bWO/0csKttTlXmYm2axUfLceIcfMbbt/wo3M09QheZ
         iIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756313291; x=1756918091;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QpwITSA8/LyvLGQhYgV8c0xvdP5oPyCopUJtWYhldGs=;
        b=lH+gbDMSeLseDRkfnM+c2LqFvUcMPYZvLRjMFPMGxLdPoqhY1M/2ohHa4nI8cQR7Zq
         QK6FvypfNqd8EE94KcAC+U09M3vGvokARa7UOXikD9bJQGZngSuLivldTDTCOoFZiLrw
         KLh8JO/ptuqdzbgGMdoiI/1WwQwHXN9bvPnkiuOhkUPKLECN4iKMqzrr3GA4RCLlpgib
         cr0UQN44JB4Xdf8AN8OgNV3DtY3fZVnxliGj8imJXQI3FJYxeu1XUiLyrE5v1fDAwmXR
         OHHtQNH2lIcBZWah81SbwAcZAKpm6eClFmfy0o4Ny8BrtRUL2QCN1s1l8gTwN2e0zwGJ
         dq8Q==
X-Gm-Message-State: AOJu0Yx0NcUVzRBR8y16yavDWw5PeaCGcClsguvtvOrlZN3/cSCaOwcJ
	g3aSjDMSJmvX+Oom4ppA2pgzgK30TzCuXnnUf42DPpl1KWpB2YZO/YzsOsXsPQ==
X-Gm-Gg: ASbGnctyAfutqwB1jnK/0MZ7x84a/eI2Evxmm9ClcCi5eJeUCNto44n7F83FAfb60M/
	960hKmyV/XHHHtWaU6G8GlPAIperH7KbJa9/JvHTiaM/4pRDcuRIicM1aRGRt6lEPT7iMY1DoIY
	Y17W6U+zPJWhyV8fWU3KZr/edvWt+8oS2BrAEDnqAo9Avnf1rK38fnPOldRo0976RZoUU5+KHQD
	tRTgFHalljsc9NR/vkVdg4LvEb08UCSc21Z+Re8ls2gmIAB/LiyqoaLVTu3B7J8m+TbQtIul5Vq
	SabuqL/w79ku8BCRb6TKukoP2m0WkW88ol/aafOv5Hr+nqE2rIStDGAxeq+fvWlcZxJU3H1Mz1x
	sn3zUH1QBGVDbmebHVF3Uj9PQbtfevg==
X-Google-Smtp-Source: AGHT+IFKGzo8D9UPt0eVOSRbjn5VyH5KLADItHCpw8VfakcuC/MLqhT9c1+D0j/lKO6ai188NZR/UQ==
X-Received: by 2002:a05:6000:3107:b0:3c6:4cab:4935 with SMTP id ffacd0b85a97d-3cbb15c94demr4974009f8f.30.1756313291104;
        Wed, 27 Aug 2025 09:48:11 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cbf1f5fc1bsm6202346f8f.54.2025.08.27.09.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 09:48:10 -0700 (PDT)
Message-ID: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
Date: Wed, 27 Aug 2025 19:48:08 +0300
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
Subject: [PATCH rtw-next v3 00/11] wifi: rtw89: Add support for RTL8852CU
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

These patches depend on another set:
https://lore.kernel.org/linux-wireless/20250826085152.28164-1-pkshih@realtek.com/T/#t

Bitterblue Smith (11):
  wifi: rtw89: Add rtw89_core_get_ch_dma_v2()
  wifi: rtw89: usb: Move bulk out map to new struct rtw89_usb_info
  wifi: rtw89: usb: Prepare rtw89_usb_ops_mac_pre_init() for RTL8852CU
  wifi: rtw89: usb: Prepare rtw89_usb_ops_mac_post_init() for RTL8852CU
  wifi: rtw89: Fix rtw89_mac_dmac_func_pre_en_ax() for USB/SDIO
  wifi: rtw89: 8852c: Fix rtw8852c_pwr_{on,off}_func() for USB
  wifi: rtw89: Add rtw8852c_dle_mem_usb{2,3}
  wifi: rtw89: Add rtw8852c_hfc_param_ini_usb
  wifi: rtw89: 8852c: Accept USB devices and load their MAC address
  wifi: rtw89: Add rtw8852cu.c
  wifi: rtw89: Enable the new rtw89_8852cu module

 drivers/net/wireless/realtek/rtw89/Kconfig    |  11 ++
 drivers/net/wireless/realtek/rtw89/Makefile   |   3 +
 drivers/net/wireless/realtek/rtw89/core.c     |  19 +++
 drivers/net/wireless/realtek/rtw89/core.h     |   7 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |  31 ++++-
 drivers/net/wireless/realtek/rtw89/mac.h      |  10 ++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   4 +-
 .../net/wireless/realtek/rtw89/rtw8851bu.c    |  22 +++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   4 +-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   4 +-
 .../net/wireless/realtek/rtw89/rtw8852bu.c    |  22 +++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 128 +++++++++++++++---
 drivers/net/wireless/realtek/rtw89/rtw8852c.h |   2 +-
 .../net/wireless/realtek/rtw89/rtw8852cu.c    |  69 ++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   4 +-
 drivers/net/wireless/realtek/rtw89/usb.c      |  45 ++----
 drivers/net/wireless/realtek/rtw89/usb.h      |  11 ++
 18 files changed, 341 insertions(+), 59 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852cu.c

-- 
2.50.1


