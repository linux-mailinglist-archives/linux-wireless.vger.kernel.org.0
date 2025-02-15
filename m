Return-Path: <linux-wireless+bounces-18961-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C67EA370EF
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2025 22:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11FC3ACEA8
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2025 21:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E361F416D;
	Sat, 15 Feb 2025 21:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai+q4pbK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42443E56C
	for <linux-wireless@vger.kernel.org>; Sat, 15 Feb 2025 21:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739656661; cv=none; b=GgZ166k9IbcW/x6ydZ7eB5ws/k6MPGQh8YeCCkdofnfvAebdHtUEAAddyQIeekN53agnqxq2xcQ7TPIINGPRV90av359aRpABtJ9y+YJWcPO6asM9Mxeyn29z0AoIoqWnMjbxYBF69lLLkIURbHAiUIZnbMR5OKgHhDJ9ddjE/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739656661; c=relaxed/simple;
	bh=IBDJpAMbQaoTeaWB9L+UeBgVKDvJr90XoyQktSgKayc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=rOmluVo0pHaqk7DMT557+0oAQFzXznbHBDd7a/f0vQZjLSD1s7kDo4ASEDUNjLWYovk4FYpVkf6Jhyg8eJrmEbyg+i5UsJGshSKIQn48C4gU0sA3KlfJWbuADujxzUbJj4fBR2tyvk/kdrBsMmAN1C/mtmPm4a/DMZ7w4aMsVkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ai+q4pbK; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abb8e405640so12238766b.0
        for <linux-wireless@vger.kernel.org>; Sat, 15 Feb 2025 13:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739656658; x=1740261458; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwttdV5p+BCxtEVazybxyyErhkw9LQF/724Iv5cOIO8=;
        b=Ai+q4pbKW+xIY1J+LmqAjYXFBrv0ZuHdAtLpYPLcaQiSOD0nH5ZF/yJ28juUz9YUpN
         toRJ+8Hvg6utEJgkpewcjcRiw3EoCKQL5aEa+xu+y3ULQ3Hf4RRiI3UY9N+C8MbO6Yz2
         l4unSEOXp01bLYA5QqVnJXoWMPxGLE3ahNoCgUPwXZN8/w45J2HhV58Y4licMzy4t1e7
         VZs8EMfmTszGr0Tr7VW2xVLbpgs1xLhYrb25aYfMJp9RRUWh2LYCHhPaxp1c6tSH6BRX
         rMBZRJgBJKpwy2Cr36L+a9PVQArRDvOc27Kh3+mK8fslYSCJc94DpWGYTYHE8gPJ7a/2
         oUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739656658; x=1740261458;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rwttdV5p+BCxtEVazybxyyErhkw9LQF/724Iv5cOIO8=;
        b=gGjB1bcUIx7eWmNJJP1772ycXrNi5olB9TND/DVGVRohjEPGn2i88+QvH9o9ja6t5t
         +XMBbNZKWCbcDzZQd6VDj6JgMmdDmDwnYSfqCPPXzn4dDUpH6Z9mf0UOSDkvw/aT0CIT
         H5yJqqrwtP62P8muHCZsVidf4Ir9GG7+8D6oC2K4u+GNHcOk3kNbwUnzww4pkjUbEQTz
         DQ/+68LH9czaEKueBVbji737NwzTahjbfS1IJU8jn2p87+Wacg795dA+K6Y/+tX6j2h3
         T5no4ZqodH5Ou4Lc22GVG8TyXvuRGjfxuNysGlx8NlAnkuqgvEfgmwY3UEqp265EoeF2
         2C1A==
X-Gm-Message-State: AOJu0Yz9NhScZ7F4iobIVMKWz/R9M9OdCi23Z3OnD0nFVNFSBaQGkbAw
	Trnoscu1M7dA/tPPB036Bipq5ZqXZxTtt75v8J3/MC1X6m7E6vYFCtvWBg==
X-Gm-Gg: ASbGnctUyINTTVFQhUPLJ2ZrbrDNHIZabZ6Mm82ge8nr3h5UQMqgdMhZYhhD94LyAJs
	yNVRv99R9PJnhsh5F3q7Qk7wQZ8MWg4j8YVsTN1uHEfpMALjgCnyJ9Ty4MLCU624kdaviDymQeA
	jfcjs12kTw5QVMKnQnwPEx9r+gZGcOKURz0bglsjZIP9YyXSwc1vY36EdIpv9vATmD9lcbOWFPY
	L8klWlIXCe7kH04iRzQkc2Qx5vK7B/K/M+HS0PwWvi3V03W3J6KmBFpfTM4A+/i4ky5Chrp4Cxu
	i/j0pjJobnHDItQAUwaeNzTR
X-Google-Smtp-Source: AGHT+IH/fJNoOoqO7h460gWE3sSTTHFJISPmPL5huNyFoMSAB3u8mvBEeJTAlueliIjCR06cXYSz1g==
X-Received: by 2002:a17:907:d08f:b0:ab7:da56:af95 with SMTP id a640c23a62f3a-abb70921219mr381479866b.2.1739656658187;
        Sat, 15 Feb 2025 13:57:38 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8fef1332sm9793066b.69.2025.02.15.13.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 13:57:37 -0800 (PST)
Message-ID: <12ab9180-45e9-40e5-98e0-6ef7b6c463d5@gmail.com>
Date: Sat, 15 Feb 2025 23:57:36 +0200
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
Subject: [PATCH v2 0/8] wifi: rtw88: Prepare to support RTL8814AU (part 2/2)
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

 drivers/net/wireless/realtek/rtw88/debug.c | 57 +++++++++++++++-------
 drivers/net/wireless/realtek/rtw88/mac.c   |  1 +
 drivers/net/wireless/realtek/rtw88/main.c  | 40 ++++++---------
 drivers/net/wireless/realtek/rtw88/main.h  |  7 +++
 drivers/net/wireless/realtek/rtw88/phy.c   | 24 +++++++++
 drivers/net/wireless/realtek/rtw88/rx.c    |  6 +++
 drivers/net/wireless/realtek/rtw88/util.c  |  3 +-
 7 files changed, 94 insertions(+), 44 deletions(-)

-- 
2.48.1


