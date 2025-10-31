Return-Path: <linux-wireless+bounces-28443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BFAC2403A
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 10:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD4318992B8
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 09:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B5332E151;
	Fri, 31 Oct 2025 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eDirjt46"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E7632ED41
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901461; cv=none; b=rYGp6I5pVCZpgvrP51ae/6LuuNEBMy8UowIf4on1avBQz67WRQ22qe1j5VfkrVpDjanRP6ecXyGszWIyRKwrunSZydVWCJKZ/N6aEnsKMHaWoyqk4eLClbil7jlcmAUtNhn6Vk+8JNYYNBTUrXcBRWmw7YJ9P4/MhvPHgwDOY4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901461; c=relaxed/simple;
	bh=ibF1jkhjl8AXSQgY+fH1j9TAspirHqiWqHMlTcN5xqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BO+zr8+9ZDKxs6XSr4AJaPmk1jDHI5lyU/+8WC2grS8odJBAgVa4eZ+2Y07c+vWDLievrqiEzgW3uGGblZd+6nrIgUeuiKhC/EBJulDrGopk2IH6SQU08Jn+u2VYjoEeMhXYT3TRTT7FCPXb9HZeVxnL+pCrVlQ4SGuk0B2om1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eDirjt46; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8e97c132b63811f0b33aeb1e7f16c2b6-20251031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xrn3eQw9b1CPQWmhREkiARi/NvjYyZeH2PmBVSuxWCk=;
	b=eDirjt46fgfOUkkYk54Q/GnzSeZceYoiD2qbW+twEceThRY1u7csXUFSOwlUtcu4AkQOeScx/FKJGyHJvstYXKlzZrQ6c+R//mdNMmTE9hrIa9dXIKD2EvOm4d1dcGj1a9l4316BC/uHhfXE8dRh4pqy8eh0EtHuFmjO3VxyVow=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:24237e9b-7e1b-4e96-bb76-832c01707456,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:2e82e46a-d4bd-4ab9-8221-0049857cc502,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8e97c132b63811f0b33aeb1e7f16c2b6-20251031
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 351942811; Fri, 31 Oct 2025 17:04:07 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 31 Oct 2025 17:04:06 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Fri, 31 Oct 2025 17:04:06 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH 5/6] wifi: mt76: mt7925: add auto regdomain switch support
Date: Fri, 31 Oct 2025 17:03:51 +0800
Message-ID: <20251031090352.1400079-6-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251031090352.1400079-1-mingyen.hsieh@mediatek.com>
References: <20251031090352.1400079-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Implement 802.11d-based automatic regulatory domain switching to
dynamically determine the regulatory domain at runtime.

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/init.c  |  2 -
 .../net/wireless/mediatek/mt76/mt7925/mac.c   |  5 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 23 +------
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |  1 +
 .../net/wireless/mediatek/mt76/mt7925/regd.c  | 61 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/regd.h  |  2 +
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  1 +
 7 files changed, 68 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index 741e38b29b77..36f7e98f256c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -91,8 +91,6 @@ int mt7925_mac_init(struct mt792x_dev *dev)
 
 	mt7925_mac_init_basic_rates(dev);
 
-	memzero_explicit(&dev->mt76.alpha2, sizeof(dev->mt76.alpha2));
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt7925_mac_init);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 643ab03ee28e..fa75fb5879ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -6,6 +6,7 @@
 #include <linux/timekeeping.h>
 #include "mt7925.h"
 #include "../dma.h"
+#include "regd.h"
 #include "mac.h"
 #include "mcu.h"
 
@@ -1332,9 +1333,7 @@ void mt7925_mac_reset_work(struct work_struct *work)
 					    mt7925_vif_connect_iter, NULL);
 	mt76_connac_power_save_sched(&dev->mt76.phy, pm);
 
-	mt792x_mutex_acquire(dev);
-	mt7925_mcu_set_clc(dev, "00", ENVIRON_INDOOR);
-	mt792x_mutex_release(dev);
+	mt7925_regd_change(&dev->phy, "00");
 }
 
 void mt7925_coredump_work(struct work_struct *work)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 92d7a6eb4179..62e9c2655749 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1320,20 +1320,6 @@ void mt7925_mlo_pm_work(struct work_struct *work)
 					    mt7925_mlo_pm_iter, dev);
 }
 
-static bool is_valid_alpha2(const char *alpha2)
-{
-	if (!alpha2)
-		return false;
-
-	if (alpha2[0] == '0' && alpha2[1] == '0')
-		return true;
-
-	if (isalpha(alpha2[0]) && isalpha(alpha2[1]))
-		return true;
-
-	return false;
-}
-
 void mt7925_scan_work(struct work_struct *work)
 {
 	struct mt792x_phy *phy;
@@ -1342,7 +1328,6 @@ void mt7925_scan_work(struct work_struct *work)
 						scan_work.work);
 
 	while (true) {
-		struct mt76_dev *mdev = &phy->dev->mt76;
 		struct sk_buff *skb;
 		struct tlv *tlv;
 		int tlv_len;
@@ -1373,13 +1358,7 @@ void mt7925_scan_work(struct work_struct *work)
 			case UNI_EVENT_SCAN_DONE_CHNLINFO:
 				evt = (struct mt7925_mcu_scan_chinfo_event *)tlv->data;
 
-				if (!is_valid_alpha2(evt->alpha2))
-					break;
-
-				if (mdev->alpha2[0] != '0' && mdev->alpha2[1] != '0')
-					break;
-
-				mt7925_mcu_set_clc(phy->dev, evt->alpha2, ENVIRON_INDOOR);
+				mt7925_regd_change(phy, evt->alpha2);
 
 				break;
 			case UNI_EVENT_SCAN_DONE_NLO:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 08013fcf2cdf..fe1a7e386fc7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -808,6 +808,7 @@ static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
 		}
 	}
 
+	ret = mt7925_regd_init(phy);
 out:
 	release_firmware(fw);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regd.c b/drivers/net/wireless/mediatek/mt76/mt7925/regd.c
index 12d8aac16e34..4565e1132b36 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regd.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regd.c
@@ -197,3 +197,64 @@ void mt7925_regd_notifier(struct wiphy *wiphy, struct regulatory_request *req)
 			       req->country_ie_env);
 	return;
 }
+
+static bool
+mt7925_regd_is_valid_alpha2(const char *alpha2)
+{
+	if (!alpha2)
+		return false;
+
+	if (alpha2[0] == '0' && alpha2[1] == '0')
+		return true;
+
+	if (isalpha(alpha2[0]) && isalpha(alpha2[1]))
+		return true;
+
+	return false;
+}
+
+int mt7925_regd_change(struct mt792x_phy *phy, char *alpha2)
+{
+	struct wiphy *wiphy = phy->mt76->hw->wiphy;
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt76_dev *mdev = &dev->mt76;
+
+	if (dev->hw_full_reset)
+		return 0;
+
+	if (!mt7925_regd_is_valid_alpha2(alpha2) ||
+	    !mt7925_regd_clc_supported(dev))
+		return -EINVAL;
+
+	if (mdev->alpha2[0] != '0' && mdev->alpha2[1] != '0')
+		return 0;
+
+	/* do not need to update the same country twice */
+	if (!memcmp(alpha2, mdev->alpha2, 2))
+		return 0;
+
+	if (phy->chip_cap & MT792x_CHIP_CAP_11D_EN) {
+		return regulatory_hint(wiphy, alpha2);
+	} else {
+		return mt7925_mcu_set_clc(dev, alpha2, ENVIRON_INDOOR);
+	}
+}
+EXPORT_SYMBOL_GPL(mt7925_regd_change);
+
+int mt7925_regd_init(struct mt792x_phy *phy)
+{
+	struct wiphy *wiphy = phy->mt76->hw->wiphy;
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt76_dev *mdev = &dev->mt76;
+
+	if (phy->chip_cap & MT792x_CHIP_CAP_11D_EN) {
+		wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_IGNORE |
+					   REGULATORY_DISABLE_BEACON_HINTS;
+	} else {
+		memzero_explicit(&mdev->alpha2, sizeof(mdev->alpha2));
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regd.h b/drivers/net/wireless/mediatek/mt76/mt7925/regd.h
index edcda72b12b0..0767f078862e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regd.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regd.h
@@ -12,6 +12,8 @@ int mt7925_mcu_regd_update(struct mt792x_dev *dev, u8 *alpha2,
 void mt7925_regd_be_ctrl(struct mt792x_dev *dev, u8 *alpha2);
 void mt7925_regd_notifier(struct wiphy *wiphy, struct regulatory_request *req);
 bool mt7925_regd_clc_supported(struct mt792x_dev *dev);
+int mt7925_regd_change(struct mt792x_phy *phy, char *alpha2);
+int mt7925_regd_init(struct mt792x_phy *phy);
 
 #endif
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index da7831f9efec..ed2606e9251a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -28,6 +28,7 @@
 #define MT792x_CHIP_CAP_CLC_EVT_EN BIT(0)
 #define MT792x_CHIP_CAP_RSSI_NOTIFY_EVT_EN BIT(1)
 #define MT792x_CHIP_CAP_WF_RF_PIN_CTRL_EVT_EN BIT(3)
+#define MT792x_CHIP_CAP_11D_EN BIT(4)
 #define MT792x_CHIP_CAP_MLO_EN BIT(8)
 #define MT792x_CHIP_CAP_MLO_EML_EN BIT(9)
 
-- 
2.34.1


