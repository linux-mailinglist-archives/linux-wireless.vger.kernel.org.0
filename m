Return-Path: <linux-wireless+bounces-21574-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B506A8ACB4
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 02:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 436647A3165
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 00:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900051A2643;
	Wed, 16 Apr 2025 00:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="eBxv+f3+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBE01A8418
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 00:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744763308; cv=none; b=S9MSiIAbzbUsLqhE3PBn+mJXZswAukM8yjArpiaQvSifFF28gA2cZYDIVat0m0MjmD77SEAMBi680DtXcBG4Y7m6/29A/ElCAm4dbOYyELTkJxOU9LotCLl1U52G5vmUhVJtP0EDpC7gwnQBuckQzu6Za4G5y3fUNdIj6RedXUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744763308; c=relaxed/simple;
	bh=9hpMUIGnJOb26sAD199jbXKiTyEnhDob93gqCsHRkUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pux9a8dYJZiWRbmNKA4qDPT6ymDW9gdiern1/Qzt2BqpQt4J+pKe9thpvRnYlJwozsW1hGeK6H5L8TegKWID3bqfmIV66TCocS1BYVyzVPOKRNgrXnQJmyR3pvQSImvCtZwAYKjogJnBMst4/JF5S4r/jgF9/P9lOtRE6sxX2I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=eBxv+f3+; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from engine.ppe-hosted.com (unknown [10.110.48.12])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 9C90F600C1;
	Wed, 16 Apr 2025 00:28:20 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 981018C0076;
	Wed, 16 Apr 2025 00:28:18 +0000 (UTC)
Received: from carkeek.lan (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id A5AF413C2B3;
	Tue, 15 Apr 2025 17:28:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A5AF413C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1744763297;
	bh=9hpMUIGnJOb26sAD199jbXKiTyEnhDob93gqCsHRkUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eBxv+f3+gzt3Tz7ZveY6n0ylxbdy0hESr+ytz76Uxun8v6EChG8qVBfSm/5LBKQub
	 ugf6sylfhJFAJqU3XDttoQRDMulxZmykXwpFAg8j7R349Na/YN5RF2UIp6rVhQaack
	 w6vVy2BLyQh/y1kbcllHO+ALnGGtf7VJWfkM9KT8=
From: Rory Little <rory@candelatech.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	Rory Little <rory@candelatech.com>
Subject: [PATCH 2/4] wifi: mt76: mt7996: Add debugfs file for rxfilter.
Date: Tue, 15 Apr 2025 17:26:15 -0700
Message-ID: <20250416002617.1328286-3-rory@candelatech.com>
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
X-MDID: 1744763300-wXmHDsjzTkR9
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1744763300;wXmHDsjzTkR9;<rory@candelatech.com>;f49eb8a899f4a60c9b856bf22a60d609
X-PPE-TRUSTED: V=1;DIR=OUT;

Will report both control registers, and list both the raw u32 value as
well as reporting each flag in plain text.

Signed-off-by: Rory Little <rory@candelatech.com>
---
 .../wireless/mediatek/mt76/mt7996/debugfs.c   | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index d5503cfc0848..c16606792539 100644
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
2.48.1


