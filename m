Return-Path: <linux-wireless+bounces-21571-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4268EA8ACB1
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 02:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 510A87A203C
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 00:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74661A23AD;
	Wed, 16 Apr 2025 00:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="gTlDt0bq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC2A1A2622
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 00:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744763302; cv=none; b=I6o1M6NM92owE+N8eC3UfjyTmusD9A96EnIoyun0EC+xZBcumeCRnToD+MkUR6vhufjhc4W5vKY6XkY/k/Rfi0M9DExK+vGc+4RPLec6Nt4K6+ZPIFBe/GzjimIjHOUaZyuQo60c1UuPmSKxRNbUOpj5yxzQoJfC7BWyWK74kwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744763302; c=relaxed/simple;
	bh=5QPxw21qrWVDivUHp4nx5bHdo8jbjf4jxJ0qYd8ZSbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgmMd8OlgE/FMn3JTWSu3iugEPaINxcnMW+Ml1uB4DW0ntUowIHYWRPNf3LW0eaTGQUVtxnfvyOH89aamR5TPesjEggFtLeMyioQmAtepdP4TseKD/y2qMWXYYlmQYDUZdr08w948CMLwAINHz1t/BRTD1oJC7NIthmBazUBFkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=gTlDt0bq; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from engine.ppe-hosted.com (unknown [10.7.64.25])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id DE867600BB;
	Wed, 16 Apr 2025 00:28:19 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B3CD2240061;
	Wed, 16 Apr 2025 00:28:17 +0000 (UTC)
Received: from carkeek.lan (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 9D6AC13C2B1;
	Tue, 15 Apr 2025 17:28:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9D6AC13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1744763296;
	bh=5QPxw21qrWVDivUHp4nx5bHdo8jbjf4jxJ0qYd8ZSbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gTlDt0bqi365oChGKDBn+zckDPkUqlhjAHlJ07tiPyxffG5Iq+6StLj2ytcLlMfEH
	 NGY8ykMKTjlFPzyFVKoO44uw3UVk5J5jd5OXotx+UdilAcio2XmTYmZ/IpQmO0/BuC
	 QdSMYznhIWHH2T983N9FzM6hTAho4PKUZx+EQFaM=
From: Rory Little <rory@candelatech.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	Rory Little <rory@candelatech.com>
Subject: [PATCH 1/4] wifi: mt76: mt7996: Add per-radio phy debugfs directories.
Date: Tue, 15 Apr 2025 17:26:14 -0700
Message-ID: <20250416002617.1328286-2-rory@candelatech.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250416002617.1328286-1-rory@candelatech.com>
References: <20250416002617.1328286-1-rory@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1744763299-Wm2Jv0QenqGw
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1744763299;Wm2Jv0QenqGw;<rory@candelatech.com>;f49eb8a899f4a60c9b856bf22a60d609
X-PPE-TRUSTED: V=1;DIR=OUT;

These can be used instead of reporting just from the first phy, or using
one file for all phys, as has been done previously.

Signed-off-by: Rory Little <rory@candelatech.com>
---
 .../wireless/mediatek/mt76/mt7996/debugfs.c   | 21 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index 4a28db17a287..d5503cfc0848 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -842,9 +842,27 @@ mt7996_rf_regval_set(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_rf_regval, mt7996_rf_regval_get,
 			 mt7996_rf_regval_set, "0x%08llx\n");
 
+static int
+mt7996_init_radio_phy_debugfs(struct mt7996_phy *phy)
+{
+	struct dentry *dir;
+	char fname[12];
+
+	snprintf(fname, sizeof(fname), "radio_phy%d", phy->mt76->band_idx);
+	dir = debugfs_create_dir(fname, phy->dev->debugfs_dir);
+
+	if (IS_ERR_OR_NULL(dir))
+		return -ENOMEM;
+
+	phy->debugfs_dir = dir;
+
+	return 0;
+}
+
 int mt7996_init_debugfs(struct mt7996_dev *dev)
 {
 	struct dentry *dir;
+	struct mt7996_phy *phy;
 
 	dir = mt76_register_debugfs_fops(&dev->mphy, NULL);
 	if (!dir)
@@ -877,6 +895,9 @@ int mt7996_init_debugfs(struct mt7996_dev *dev)
 
 	dev->debugfs_dir = dir;
 
+	mt7996_for_each_phy(dev, phy)
+		mt7996_init_radio_phy_debugfs(phy);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 43e646ed6094..3300b7c8e4d2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -296,6 +296,8 @@ struct mt7996_phy {
 
 	bool has_aux_rx;
 	bool counter_reset;
+
+	struct dentry *debugfs_dir;
 };
 
 struct mt7996_dev {
-- 
2.48.1


