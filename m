Return-Path: <linux-wireless+bounces-26982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C5FB42DE7
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 02:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CEA75E6261
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 00:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A590F4C83;
	Thu,  4 Sep 2025 00:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="JqamEGg4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8A211CA9
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756944447; cv=none; b=OvJYdw91G5GzLBI0xVvPa5uGw/9fgbNimjzwrv6cvDzGx0EZf4ejMCOPgrVHfKlBHc3HA5VmGfBT/7Jv+ZnQyfTKYPZnvoDp8vYFM7G6cmeDmGiQa5DUZ/AVV9Vk/NBRNwTS0by534QCVMWA9kHrqitoDPBKXDPx5Ch/i3dDLTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756944447; c=relaxed/simple;
	bh=fhGANLSnWLSR65eQwSDeEFgK+qkUFaYQ7mdUZ4HRrmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n5pqGMMkXBdkG31AkJgiy0E+wOYqzgad0Xs8kXTXvAmtTtGxzZh7Ilxg1c9N07onDLb/oK4RwvlD9ZFtRPlxfUtMF6ZZ3fni/WDNNT0Hg+VnJVCavLI7rBMgoIfbbdmVitygEj0Qdz+hNx5LkPcg/f9YijgcMK+UhlxtMM8XVns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=JqamEGg4; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8A10F2800D2;
	Thu,  4 Sep 2025 00:07:16 +0000 (UTC)
Received: from carkeek.candelatech.com (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 3F6BE13C2B0;
	Wed,  3 Sep 2025 17:07:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3F6BE13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1756944433;
	bh=fhGANLSnWLSR65eQwSDeEFgK+qkUFaYQ7mdUZ4HRrmU=;
	h=From:To:Cc:Subject:Date:From;
	b=JqamEGg4LIr1ujJIk/4I/OWLdx3mWHa8s1MbosTcJkZwjF7Sdbcrq0g16MfqmPxU/
	 SQ1RkjbIv4nhqrG17EEvej/69nMDyTE5JKtDyCI34rhdjTp1BVI6PwD0qp0SHqAwzW
	 7jJXzi/+OmjCE86Os+LeA+0EILX9ZiIxHorNHhds=
From: Rory Little <rory@candelatech.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	linux-wireless@vger.kernel.org
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH mt76] wifi: mt76: mt7921: Place upper limit on station AID
Date: Wed,  3 Sep 2025 17:07:11 -0700
Message-ID: <20250904000711.3033860-1-rory@candelatech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1756944437-pgXiVruTZwo0
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1756944437;pgXiVruTZwo0;<rory@candelatech.com>;f49eb8a899f4a60c9b856bf22a60d609
X-PPE-TRUSTED: V=1;DIR=OUT;

Any station configured with an AID over 20 causes a firmware crash.
This situation occurred in our testing using an AP interface on 7922
hardware, with a modified hostapd, sourced from Mediatek's OpenWRT
feeds.

In stock hostapd, station AIDs begin counting at 1, and this
configuration is prevented with an upper limit on associated stations.
However, the modified hostapd began allocation at 65, which caused the
firmware to crash. This fix does not allow these AIDs to work, but will
prevent the firmware crash.

This crash was only seen on IFTYPE_AP interfaces, and the fix does not
appear to have an effect on IFTYPE_STATION behavior.

Signed-off-by: Rory Little <rory@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   | 6 ++++++
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 8818fb1916ad..7b02aaa4dd3c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -807,6 +807,9 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	int ret, idx;
 
+	if (sta->aid > MT7921_MAX_AID)
+		return -ENOENT;
+
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1);
 	if (idx < 0)
 		return -ENOSPC;
@@ -850,6 +853,9 @@ int mt7921_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 
+	if (sta->aid > MT7921_MAX_AID)
+		return -ENOENT;
+
 	if (ev != MT76_STA_EVENT_ASSOC)
 	    return 0;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index c88793fcec64..faa0d9398214 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -7,6 +7,8 @@
 #include "../mt792x.h"
 #include "regs.h"
 
+#define MT7921_MAX_AID                  20
+
 #define MT7921_TX_RING_SIZE		2048
 #define MT7921_TX_MCU_RING_SIZE		256
 #define MT7921_TX_FWDL_RING_SIZE	128
-- 
2.49.0


