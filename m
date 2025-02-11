Return-Path: <linux-wireless+bounces-18787-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5318A31885
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 23:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F848168887
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 22:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D61C268FEF;
	Tue, 11 Feb 2025 22:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYq5yneP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC9F268FF5
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739312503; cv=none; b=d7vvC6AAFvcEWgI4qjHZNRHFWwM0Nx+feZI2QAq/tRl+uhJrtcX4j3cq65TtE3DN8SCQyA2vMOukwsX9JvjAHcp9NO0E0A41NRizkLY18HJ3pxu+se8ADkotjbC24gu+5+uBWSC3ThG+0QK79qEseHZ1Qk+MP4Ge6RNx+8qsxNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739312503; c=relaxed/simple;
	bh=aXKJtbUk9vQ7G2sk7UlLFqubvcA//KP5R/ZE2ETlL0M=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=l1OWyx3qWMG07n0QLOqJZyes/1zFuv8Zy/daoUkwc2ElInndx1cV4xqVGRoBEvdT2slBUdBAqtZS/3vKt/2Lbssd2Sues1rR3JYes4Mp+5YJGZC3lTvLQ4QTwoKXRbL1coQm2tngEOXHMNG16GirXsgfINsWGQcgEH2iqf5AYMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYq5yneP; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab7b7250256so465183866b.0
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 14:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739312500; x=1739917300; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4J9ZKf2ZlezeB+RVYDmiHlxUn3IE6af9sglL2slrqpw=;
        b=CYq5ynePBMpN3M+EqlcrF3lY6QtC00VkhoL+UJ0cdQHmrZNmBR/Kc8ddvgJhlaplXk
         iTTuty2ssOAjOO8RHDZnC3ePL/JVmSEPbaMoBTsiadvR/jJjWAKrD6e9mlCklozVqxGV
         smUNWtsPnY8GlX7MujV+G3eQyHQ4F90ZUJYP/1U5QMDM2VUQT019g1y+DRSgpP2xEzez
         8S6+pXIJggAr0ptZQWDVw4IBFV4km5PjeM9zycrapL717x+AjV3waG//+0xPaFqiY8xv
         ETYWOLYDtemBKCoU8xIpWYapdJ0ozBKxw0nxUQpSzXRlMuy9N4rHAT9iB+lzGEnJg8DV
         90cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739312500; x=1739917300;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4J9ZKf2ZlezeB+RVYDmiHlxUn3IE6af9sglL2slrqpw=;
        b=tgCogsnDKOrG4za2l8Lkls0Hp20EX0wsAQdz4SY3Vm1G87fdr8+c9jfF2rVgC+d644
         Ttzs+KS78P5VAgDXSMqNlZ7DYDPS+fN89Hp9CtanwXQV6hZA7eprE5Z7o7Mwuzgy0Y2u
         LacJIhbkXVV0g4XlZIaKeXWhLqka2tSvjYrRtY8l3VjVxAi9Iy7rCNIGFo1ZHErgv1v9
         b7jSBpiT7Ny0SOrlToqlDBDlx4yklmXCWS2jblVE2jt9dyZd/TF1KyOy/ylxYYgyiAlk
         MB572ttpS6/ez1loILwgyUuQ24Q3RgWiJX9xnpwx2itQGWLLHp1HLJF8XNpHrB7dMrlT
         S6OQ==
X-Gm-Message-State: AOJu0YwpgGBj1FlbNAt77SfoCIxsnVjxT5utQiUZcrcoKAPk3umV+kEF
	D+nNyPtRra6c8lugx4dg7XlFRyADvR9g5WoWeFO2G+qjj2ETsHeUCy/HdQ==
X-Gm-Gg: ASbGncsqbFoHV6ERnFMdtyex7re6D7ORG2FA+yJK/REbay3oddbnbnDvOYzNUCEtUob
	AXNYWZ9LxuJKzYvH0p28UAlPXKP79dFbrhUOSYLntdaQOIUKvEhAgNBYD9FZTHyy5UXwyCzlVNR
	N6e0X1IGd6ox/WKW88Od5+aMV8dtUs4/9fmui4OQpZG7kU/WHVIW5ykgEngGWtGQ6uim6ih0Xq5
	WlbNDrk9pubEeeeHFQJ4YJn6YJKqn4LySM3xDPJjkP4ok/yWGye63T1rSP/zkzFWm5xmEErzI80
	xhA6M8yvghL+fobg1gzaSRYs
X-Google-Smtp-Source: AGHT+IHJf267fknzDJF7j+ezX+m4/Q7yh9to8aGddjlmlR6sdz8hVo0XW2+eukt/K/cGFEn0XhpdHw==
X-Received: by 2002:a17:906:fe49:b0:ab6:ef94:6054 with SMTP id a640c23a62f3a-ab7f33d70a0mr56799066b.33.1739312499927;
        Tue, 11 Feb 2025 14:21:39 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7d18e006csm329370866b.52.2025.02.11.14.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 14:21:39 -0800 (PST)
Message-ID: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
Date: Wed, 12 Feb 2025 00:21:37 +0200
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
Subject: [PATCH 0/8] wifi: rtw88: Prepare to support RTL8814AU (part 2/2)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A few more changes for RTL8814AU. Fix power on/off, the HT/VHT
capabilities advertised to mac80211, RX statistics, TX power tracking
stuff, debugfs stuff.

Part 1 was here:
https://lore.kernel.org/all/9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com/

Part 3 will be mostly the new files for RTL8814AU.

Part 4 will improve performance.

Bitterblue Smith (8):
  wifi: rtw88: Fix rtw_mac_power_switch() for RTL8814AU
  wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle MCS16-31
  wifi: rtw88: Fix rtw_init_ht_cap() for RTL8814AU
  wifi: rtw88: Fix rtw_init_vht_cap() for RTL8814AU
  wifi: rtw88: Fix rtw_rx_phy_stat() for RTL8814AU
  wifi: rtw88: Extend rtw_phy_config_swing_table() for RTL8814AU
  wifi: rtw88: Extend rtw_debugfs_get_phy_info() for RTL8814AU
  wifi: rtw88: Extend rtw_debugfs_get_tx_pwr_tbl() for RTL8814AU

 drivers/net/wireless/realtek/rtw88/debug.c | 47 +++++++++++++---------
 drivers/net/wireless/realtek/rtw88/mac.c   |  3 +-
 drivers/net/wireless/realtek/rtw88/main.c  | 40 +++++++-----------
 drivers/net/wireless/realtek/rtw88/main.h  |  7 ++++
 drivers/net/wireless/realtek/rtw88/phy.c   | 24 +++++++++++
 drivers/net/wireless/realtek/rtw88/rx.c    |  6 +++
 drivers/net/wireless/realtek/rtw88/util.c  |  2 +-
 7 files changed, 83 insertions(+), 46 deletions(-)

-- 
2.48.1


