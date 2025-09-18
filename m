Return-Path: <linux-wireless+bounces-27452-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C119B82FC5
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 07:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89A54A3C75
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 05:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B773A281375;
	Thu, 18 Sep 2025 05:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="OPsb3vTK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807CE27FB03
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 05:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172771; cv=none; b=FM/7yAKQYML/VCXKvkYvV3mYHUeHeDySYRCLyGb0C/oLYgfbUbMgmrkm0gcZvwLtxYdx6zkTpaf5FIocjx5ZV9XSr1O8iqMj5cxjUF3A1hh5/HO4BZFIdJd/ssYnLN+QrMGT1ykbJ3eP+ZMhmqcG1vik80MNWTWVWqEUKwvjMt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172771; c=relaxed/simple;
	bh=YVr8gDktQwZBdMWAp15bqnwfqBrLVIQByDYB4w7tmQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y97l/8YtJ35vCJfJRayvUBNnqa3y5WIUsExvpk79tUbaKz5nTG4WQv17p9WsXZeOyW2EXsrUOUjZln0HYgF+adcXhtxna+Q17Ud6+Hm3huee5WeP+r5mfX2NwjO9WufW7cCcwutz4tTofnCaSSdSO2gdy1ZWU7cqXAeIKH7WLnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=OPsb3vTK; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b54f57eb7c9so285793a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 22:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1758172769; x=1758777569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tDWxgwTAun/Ln8ce6/WllbykVverO82KH/jMc9isA6s=;
        b=OPsb3vTKktO06V/1OSXy0Pk8deWyv4vVlgIV+p/G3XHXG3UkIHYvf+Ryb2lE/MYmTh
         0sRAIYiWnGK2B2gHvFNkemGcFAmjbRIMyeFUJAXOA139rsA2x2jYNKN4eNKMPixCHkfF
         2mK7W/tDbGIIwRC/5NlTKsOWjdXGfF5J4GVcLxYY2ZcUu/iDT7m2E3ra7DUrLDXjUkO1
         u2054vF5FdZDBF6Sfie0rd8x6x6VusPMd4vgklHFz55Lz3APkPnGT7TNpg0e/oMiCeeT
         MFCPeiZQfQr7jtcjLVRVY4der0PTuhgMm7N0GImIh+vVGnBsUZLGPx+YZGf1AV7N5Dui
         U8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172769; x=1758777569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDWxgwTAun/Ln8ce6/WllbykVverO82KH/jMc9isA6s=;
        b=j+ZZdkmorLDOo1c3BQOzaSDHTXoWXkL8qI3HJdNN8X0js+N4aUzREGdk2lfSczu4K/
         eOpvFfShGeYiSuIS9I3vESeIHu9BSBwFXBabs9Q/W75xRNruU5CoGwwgPaASDeoDcFR5
         NJN1Yq99w1BxZUPX/sIcTM77jl6F5XLLDJ8qihA1AC55zKjKMw5qF512OHjCmjcEbCv8
         F4kgveSpBihExcClk1rNFkznMJpmcnX8HNFJeXDnuwEvwJsdAvZLnsT9ttL3UEt27g+x
         AvBa9cRuI7XrXmLqt8A+wy9KqaxSKbfxMs6AxPqb6Kg1IIHQ9ZApBohVFukHGoSxMsqb
         53pQ==
X-Gm-Message-State: AOJu0Ywvgw3/DfAN0Lilkt6tFlEa3TSX8Xc60kp564RWI1olt/IU+omm
	a5RNE25dzAWY/kZ1Mrzxe2PVe4mXNVzrVAtWORCX6GOrfRwhuBToyJEnSIVwpD47oaIfu52TaQc
	G6IHFNw0=
X-Gm-Gg: ASbGncvVLe5nbO7hhV8qNVlfQziGEaGIFUDZevNK6Sd8HMj/MUK4nvwVGoyhxjHAH9l
	9fWUQz26EDSIK/4gj/yrqUTOWV6H6RbdjdND6Oz28iJz86rsZDqnOKNS6DAOhfB+DiiXm6Hb6st
	cX4N2xn4qm3I0ltcGliQtvdBGhotJCZilt+X9ku58ZwpbZ7GuBW5fIY3xFRJjSCC/s1iO/d95pB
	BuTISw4Tpii102KUVb9MDnEXtb6Djx23ZXsJLRCm5qTQJhGhHgD0+ZLj5/6XbjqyWBwOJTHtv9n
	Ws3sEPo+faeob8dCJLaCWWmMGJ7TIhdazFv3JpHdsTxAwpx/vjD4duJx9oWlD1daXYnHVnCI8UA
	sF/Ak2xVMVMPvapGpXA4hI+V47MlAvQIHmY2k0IoyQ2+MltQmuw9+0FPRK4TfjOuBOAb1chPx3W
	GNme9+YhVtbdjsGsp3qiaRqvHYuAUq8DMzaGZtu1NQVeq34Q==
X-Google-Smtp-Source: AGHT+IH9q4nvndJgZzzecxsStZtOGQReMYUOtaVHian9bjTmpBDtGfGOSSlgZgtF4rTdR+NDr/vliQ==
X-Received: by 2002:a17:903:1a23:b0:269:74b6:8735 with SMTP id d9443c01a7336-26974b68b87mr35656065ad.24.1758172768616;
        Wed, 17 Sep 2025 22:19:28 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698035cd39sm12624465ad.146.2025.09.17.22.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:19:28 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next v2 0/3] wifi: correctly represent S1G channels
Date: Thu, 18 Sep 2025 15:19:10 +1000
Message-ID: <20250918051913.500781-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset correctly supports S1G channels within cfg80211 and mac80211.
Preliminary discussion can be found in [1] and the v1 RFC can be found in [2].

The goal is to align how S1G channels are represented within the chandef
and validated throughout cfg80211 with how VHT is done. The S1G PHY is based on
the VHT PHY, just at 1/10th the clock rate. There is, however, the introduction
of 2MHz primary channels. This allow S1G interfaces to operate with either a
1MHz or 2MHz primary channel.

Changes since v1:

1. Do not remove the IEEE80211_CHAN_1/2/4... flags, instead add our new flags
   to the end of the enum to ensure we don't break ABI. Same goes for the
   NL80211_FREQUENCY_ATTR_1/2/4... flags.
2. Don't declare local variables within the switch statement in
   cfg80211_chandef_valid() to prevent clang compiler warnings. Also
   rename control_khz to control_freq_khz to make it clearer why we have
   both control_freq and control_freq_khz.
3. Move some variable declarations into the chandef->s1g_primary_2mhz scope
   within cfg80211_s1g_usable()
4. Move brace to end of line when using for_each_s1g_subchan
5. Validate that the s1g_primary_2mhz flag is not set when we aren't an
   S1G interface within cfg80211_chandef_valid()
6. Since we aren't removing the flags anymore, we can remove
   ieee80211_s1g_channel_width() entirely in the last patch. Unfortunately
   removing it beforehand breaks the incremental build process since mac80211
   still uses it in patch 1.
7. use u8_get_bits instead of FIELD_GET
8. If an error occurs when parsing the S1G operation element within
   ieee80211_determine_ap_chan(), ensure we fallback to 1MHz width and
   1MHz primary instead of WARN_ON.

lachlan

[1] https://lore.kernel.org/linux-wireless/xu4ftmpdwwpokw6exaprrv6wleptq7ggleiluiu6x2dzqbqfhv@6s4m3okiohzw/
[2] https://lore.kernel.org/linux-wireless/20250909080758.1004956-1-lachlan.hodges@morsemicro.com/T/#mdb626caa000b7a1585e82856f32b5eecde9e6557

Lachlan Hodges (3):
  wifi: cfg80211: correctly implement and validate S1G chandef
  wifi: mac80211: correctly initialise S1G chandef for STA
  wifi: cfg80211: remove ieee80211_s1g_channel_width

 include/linux/ieee80211.h    |  18 +++++-
 include/net/cfg80211.h       | 105 +++++++++++++++++++++++++++++++----
 include/uapi/linux/nl80211.h |  14 +++++
 net/mac80211/ieee80211_i.h   |   3 +-
 net/mac80211/main.c          |   6 +-
 net/mac80211/mlme.c          |  53 ++++++++++++++++--
 net/mac80211/scan.c          |  13 +++--
 net/mac80211/util.c          |  39 ++++++++++---
 net/wireless/chan.c          | 103 +++++++++++++++++++++++-----------
 net/wireless/nl80211.c       |  38 ++++++++-----
 net/wireless/reg.c           |  76 ++++++++-----------------
 net/wireless/util.c          |  27 ---------
 12 files changed, 334 insertions(+), 161 deletions(-)

-- 
2.43.0


