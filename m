Return-Path: <linux-wireless+bounces-18655-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0983A2DA1B
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 02:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE06918867A7
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 01:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A40243379;
	Sun,  9 Feb 2025 01:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vampirebyte-ro.20230601.gappssmtp.com header.i=@vampirebyte-ro.20230601.gappssmtp.com header.b="CnykWS+j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B79819
	for <linux-wireless@vger.kernel.org>; Sun,  9 Feb 2025 01:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739063991; cv=none; b=S00zKUt13J9lj/+Gs4tMmDm90kSVRezRJUqa2wjI65KmHrnfkLGwYhgcsMwMem4H2ap5smDdLh46HqiGAYulkfs9Bi6uMv8wIzUogli3uwcAlCNIl9/vJPLJp3XaiDaMxU/y0Q+QNNx9TAe9z9GYnutC9JhXx5yl3RLN5VyOQTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739063991; c=relaxed/simple;
	bh=qyR4lu4Vp5Dh2hOT4F5FpKt++Fs2rxkMbfxO+/YX9I0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tkP3A1+Ve4BSmmVE37KZXjSJQV+FnIwnZ1LWJnOez8TqL7ORbS+LHzi0pi7ggPsSHc3pLXzXLoGdCrvdIEMzjtnijQZYxqoKt3xfo7fFaR4YmwBc0b2ov9hCXlCWNTBVcsfNpYPFTDDNW2aYODkCTrjKzQj16fVpCBXu1QQwUWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vampirebyte.ro; spf=pass smtp.mailfrom=vampirebyte.ro; dkim=pass (2048-bit key) header.d=vampirebyte-ro.20230601.gappssmtp.com header.i=@vampirebyte-ro.20230601.gappssmtp.com header.b=CnykWS+j; arc=none smtp.client-ip=209.85.128.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vampirebyte.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vampirebyte.ro
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-43624b2d453so38435925e9.2
        for <linux-wireless@vger.kernel.org>; Sat, 08 Feb 2025 17:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vampirebyte-ro.20230601.gappssmtp.com; s=20230601; t=1739063987; x=1739668787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qwCmp2CYB+j2WRGNYr2WuEiEOsIVgRs8bDTT2ZvcZRo=;
        b=CnykWS+jImp1gGrkzbSXfinCyWrfsyyMQxar9ytnV4t2dkkM2ZV/6sXi2P8T5crq6x
         bTV+Wm9C9tOYAwziexDjvnFenlyeZOqW6Vp+bKRv7rh4+eol0/MQi4gXTFPTzJJtUB/h
         D9/GO7CZi8mtjYpERG+kUECm4cPw66HmlRHOSGEZKoR69Yaq9p1sHZCSXuVPffHyqKOx
         UXH73fus16Oe1EPrxxSVkFxD8RCGp69z33l0yj++03e4F9JpvNav88FhDsytwRj0zl68
         bqVTPa3SWI4vMmy8gJo+t8IM9F3yaxMUJdx5hqviBVZVaeVg5RG8/32yNcCbvL2sUNPn
         ZwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739063987; x=1739668787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwCmp2CYB+j2WRGNYr2WuEiEOsIVgRs8bDTT2ZvcZRo=;
        b=TAsEzDG96JtoPakB6WoIKrTLfVftPNOeG13b15fIYMDvADCI6XZojzHxOqdXcyGbYu
         0rRaCy52rPcvq3USGtDIwHUv6udpMCzan0N+MzAfHc/ZNc2XbAlA7rhnFwH9qxQPscBc
         IlaeTn1KjeENTsmV2HomYHV7OZt1Pk5yXXEnMNDc6gwqCjofHsBbqNnWnPSGcJcgnjDP
         JUBtDiqyEOJMHiTg9L1T5AUC10qsNZ++yyYdisKkW+uLTLytdHfijxmW3qcYTEoJy8kH
         tHKe809LhtqIGs1uCDh16Z2pWV0Ufr2GdDnNilnLvgvsjjhIp8Ri7v8W3Xp4fRO2xy/d
         BG2g==
X-Gm-Message-State: AOJu0YyJqIUqBzilvc16+HmLBKpz1th/sL9J+kYA8GQrPr244HZx1ynN
	gQv7IqelICO67aubl4O0h3CcxSUwtUbL2gnrpnoO8r1BgyWsmzgvZnFOoH17iYDdZjZv7p/Vc22
	q7dmx3ppZBIdqG8KYIKDQI1JwGs0nKBo+WHtolu0g
X-Gm-Gg: ASbGnct5yPBKpNEPUjbLjQUETGYjLTp8ry/RVRiTSZkVmy2cqTgJvKovQ7VsDMFld9j
	LDcLcL+2aPFxc8duqcJ95uhQLpZDj8+PIgJSLkV4fdhSkaMj0momisLZEDhOh3iZikd2INP+ML3
	+6LuTH4XmYmRIzQDxpRQOWrKsTMnK30YkCIS5yR2InCm0v/5NzJsqlu81UjXaIwirgznQ9AdC6j
	u0aMdVr9zqEa9YCSGqSpGSZj3rzdHTZioCeZigQxv7/AuGTjTZ7Nhe4tpaM47J1nt+L5P/GZjAT
	GDwOsZN157AISqUKIyAjPxceb9kizA==
X-Google-Smtp-Source: AGHT+IGCewGMNIs+RmMOsviLQ0Yf/HsAZYYDLl1VhcSv7wt0dfNPBIQ5a6Dav5BGOHN2qAPGORO82HlTRyer
X-Received: by 2002:a05:600c:510c:b0:436:e86e:e4ab with SMTP id 5b1f17b1804b1-439249bd35amr85208945e9.30.1739063987232;
        Sat, 08 Feb 2025 17:19:47 -0800 (PST)
Received: from orin60.vampirebyte.net ([82.77.132.211])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-38dd6880056sm149536f8f.16.2025.02.08.17.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 17:19:47 -0800 (PST)
X-Relaying-Domain: vampirebyte.ro
From: Razvan Grigore <razvan.grigore@vampirebyte.ro>
To: linux-wireless@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Razvan Grigore <razvan.grigore@vampirebyte.ro>
Subject: [PATCH 0/4] wifi: mt76: fix returned txpower for mt7921 and mt7925
Date: Sun,  9 Feb 2025 01:18:52 +0000
Message-Id: <20250209011856.6726-1-razvan.grigore@vampirebyte.ro>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reading the txpower with `iw dev wlan1` the returned value is
always 3.00 dBm, no matter what reg domain is set or if one changes the
txpower manually.

This bug was discovered by me and confirmed by many people using this
chipset on openwrt: https://github.com/openwrt/mt76/issues/783

I tracked the code for this and it seems that for those 2 chipsets
particularly, the mt76_phy->txpower_cur is never set, in contrast to
other chipsets like mt7603, mt7615, mt76x0, mt7915, etc.

Added some debug logs in the mt76_get_txpower function and I got:

[   26.816227] mt7921u 2-1:1.3: mt76_get_txpower: phy->txpower_cur = 0
[   26.816234] mt7921u 2-1:1.3: mt76_get_txpower: n_chains = 2
[   26.816236] mt7921u 2-1:1.3: mt76_get_txpower: delta = 6
[   26.816237] mt7921u 2-1:1.3: mt76_get_txpower: *dbm = 3

So the driver is correctly calculating the TX power adjustment based on
the number of antennas. However, the base TX power (phy->txpower_cur)
is not being properly initialized or set to a meaningful value.
It's starting at 0, so the final result is just the antenna
gain compensation divided by 2.

While investigating this I found commit ff94604 that adds a separate
function for _get_power_bound so decided to reuse it for all 3 chipsets,
might be needed in the future as well.

Tested-on: Alfa Network AWUS036AXML
... and it also reacts to manual txpower changes now.

Thank you in advance for looking into this!
R

Razvan Grigore (4):
  wifi: mt76: add mt76_get_power_bound helper function
  wifi: mt76: mt7921: fix returned txpower
  wifi: mt76: mt7925: fix returned txpower
  wifi: mt76: mt7915: cleanup mt7915_get_power_bound

 drivers/net/wireless/mediatek/mt76/mac80211.c       | 11 +++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h           |  2 ++
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c |  8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c     |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h     | 12 ------------
 drivers/net/wireless/mediatek/mt76/mt7921/main.c    |  7 +++++++
 drivers/net/wireless/mediatek/mt76/mt7925/main.c    |  7 +++++++
 7 files changed, 33 insertions(+), 18 deletions(-)

-- 
2.34.1


