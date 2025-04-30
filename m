Return-Path: <linux-wireless+bounces-22289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C486AA58A1
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 01:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A139C5B4F
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 23:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9264F22A4EF;
	Wed, 30 Apr 2025 23:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="o6ff/JWi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD21C225A29
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 23:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746055376; cv=none; b=WuxDvDeo9P4Q7ALr1Zp8frXu5IB2MRjbVWooMEXJeKGD927UNBtORTliFyzlNS+O0V3X89RVRV1+40NPZn6HiH/Qk2aOxNOrijFAcQpSGpavTUnnwPpdgWcboq8bdBMtwJ1qm8Z8C3Y3iPa32zBDgXU8V4cQ3J1jgoTcVo3TkVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746055376; c=relaxed/simple;
	bh=x2vDTaVTIRoNddYXyG9L97bulEWkZYwXV0RJr1xjdIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FN96kRUHm81CJar9oxPewk52ziydR7eI5X05xaY8QxN4ywJG5lgmtlM4PZk9nQ6JDZRW6hBTdN6p+TGLZy8p4gC7hjj8seTwKPvWk3IJaBPULVceRsE0WkWfY6lVKqf2n1VXS96BRnjRlJNcgjzGLoVUMpC0J0UrHddddSCQV+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=o6ff/JWi; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from engine.ppe-hosted.com (unknown [10.110.50.132])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id B4D63600CB;
	Wed, 30 Apr 2025 23:22:48 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 1E02B800063;
	Wed, 30 Apr 2025 23:22:46 +0000 (UTC)
Received: from carkeek.lan (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 38D5613C2B0;
	Wed, 30 Apr 2025 16:22:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 38D5613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1746055366;
	bh=x2vDTaVTIRoNddYXyG9L97bulEWkZYwXV0RJr1xjdIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o6ff/JWiLJX9zILZusafw5koX2uuoDiRLVt4KkwdtoI9KIcbt5yosi60ADB3SDx5V
	 g04ubDWRhIUOQieL0JAwAcLmkLGforU8b3i6Hb+XmvLMvzqlHFIJhSqvfmNUs/A+aF
	 IE7CXVvMfcI6wIb8ji0TMXGZLGWwMTeKzdjQo+s8=
From: Rory Little <rory@candelatech.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH mt76 v2 2/4] wifi: mt76: mt7996: Add debugfs file for rxfilter.
Date: Wed, 30 Apr 2025 16:22:23 -0700
Message-ID: <20250430232225.3943242-3-rory@candelatech.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250430232225.3943242-1-rory@candelatech.com>
References: <20250430232225.3943242-1-rory@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1746055368-Clo0YGhP_0ux
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1746055368;Clo0YGhP_0ux;<rory@candelatech.com>;f49eb8a899f4a60c9b856bf22a60d609
X-PPE-TRUSTED: V=1;DIR=OUT;

Will report both control registers, and list both the raw u32 value as
well as reporting each flag in plain text.

Signed-off-by: Rory Little <rory@candelatech.com>
---
 .../wireless/mediatek/mt76/mt7996/debugfs.c   | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index 3548b2bd9b72..7703db507fe6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -842,6 +842,48 @@ mt7996_rf_regval_set(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_rf_regval, mt7996_rf_regval_get,
 			 mt7996_rf_regval_set, "0x%08llx\n");
 
+static int
+mt7996_rxfilter_show(struct seq_file *file, void *data)
+{
+	struct mt7996_phy *phy = file->private;
+
+	mutex_lock(&phy->dev->mt76.mutex);
+
+	seq_printf(file, "CR: 0x%08x\n", phy->rxfilter);
+
+#define MT7996_RFCR_PRINT(flag) do {			\
+		if (phy->rxfilter & MT_WF_RFCR_##flag)	\
+			seq_printf(file, #flag "\n");	\
+	} while (0)
+
+	MT7996_RFCR_PRINT(DROP_STBC_MULTI);
+	MT7996_RFCR_PRINT(DROP_FCSFAIL);
+	MT7996_RFCR_PRINT(DROP_PROBEREQ);
+	MT7996_RFCR_PRINT(DROP_MCAST);
+	MT7996_RFCR_PRINT(DROP_BCAST);
+	MT7996_RFCR_PRINT(DROP_MCAST_FILTERED);
+	MT7996_RFCR_PRINT(DROP_A3_MAC);
+	MT7996_RFCR_PRINT(DROP_A3_BSSID);
+	MT7996_RFCR_PRINT(DROP_A2_BSSID);
+	MT7996_RFCR_PRINT(DROP_OTHER_BEACON);
+	MT7996_RFCR_PRINT(DROP_FRAME_REPORT);
+	MT7996_RFCR_PRINT(DROP_CTL_RSV);
+	MT7996_RFCR_PRINT(DROP_CTS);
+	MT7996_RFCR_PRINT(DROP_RTS);
+	MT7996_RFCR_PRINT(DROP_DUPLICATE);
+	MT7996_RFCR_PRINT(DROP_OTHER_BSS);
+	MT7996_RFCR_PRINT(DROP_OTHER_UC);
+	MT7996_RFCR_PRINT(DROP_OTHER_TIM);
+	MT7996_RFCR_PRINT(DROP_NDPA);
+	MT7996_RFCR_PRINT(DROP_UNWANTED_CTL);
+
+	mutex_unlock(&phy->dev->mt76.mutex);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mt7996_rxfilter);
+
 static int
 mt7996_init_radio_phy_debugfs(struct mt7996_phy *phy)
 {
@@ -854,6 +896,8 @@ mt7996_init_radio_phy_debugfs(struct mt7996_phy *phy)
 	if (IS_ERR_OR_NULL(dir))
 		return -ENOMEM;
 
+	debugfs_create_file("rxfilter", 0400, dir, phy, &mt7996_rxfilter_fops);
+
 	phy->debugfs_dir = dir;
 
 	return 0;
-- 
2.45.2


