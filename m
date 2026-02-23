Return-Path: <linux-wireless+bounces-32095-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JjeBGEEnGlG/AMAu9opvQ
	(envelope-from <linux-wireless+bounces-32095-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 08:40:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78183172C51
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 08:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04138303DAA5
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 07:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E11334B1A8;
	Mon, 23 Feb 2026 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="r3yHq4zp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B85834BA4B
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771832350; cv=none; b=Oi+Z5ihN0dTB4i6fdqRy6dhWf8CykksHlHvr99yMJMrL7h5gM3RefHJ26g4Z6oeUv0Tx+kbUYplvC638yuih9imuVaffb8XQNzUoR+Xcx/JV1AkBPDM8kO3xpHd0PZyRbzah9F3zTlie3TZTP+g0NYZA0ebrrveKKa5ybFnY56I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771832350; c=relaxed/simple;
	bh=7jSyTLIY8JAMd7qClsgg+R7CrbPxerSadlZdjPtZSRg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTqQyWMv+JOYc1R5TDSTc7kdMHMDv6dRo4NfbEmKzUiaYLPo/yJj2j3UuUmqfFkjo3/wAIh8DrVijrS71dFxPBudhQO64VJl5kmUPqLmTO1hhFKQhrhj1HLa3pGtqCf1lsP4lreBbtGwJr14pjxIs+hGkvCb1X+zss+gNlW7ebI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=r3yHq4zp; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b8a1b562108a11f1bcd7499a721e883d-20260223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hrL1G1Q7cSomy+9HsfY3RzC2kranmeQGLV3Q0xYRH+A=;
	b=r3yHq4zpuvOLmlHSfr1+5TUOL3zwlWpJOtQYA2tOPJfaAiGiw21YaVe1JNtOBbG66wK4fh+OTRZE6fQAjmJJGJHv9e8c0xTZ8pr52WyliN2hD6tlOWT4qCUXvbGm4ulQCz6wHYSQuR42FS9Y3Ylam+7qcbdoF7dsE7KKUaW00nc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:faa6da26-afc0-4d2c-816b-ccabf313e7dd,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:89c9d04,CLOUDID:21e8e2e9-ef90-4382-9c6f-55f2a0689a6b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b8a1b562108a11f1bcd7499a721e883d-20260223
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <jb.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1133531793; Mon, 23 Feb 2026 15:39:01 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 23 Feb 2026 15:39:00 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 23 Feb 2026 15:39:00 +0800
From: JB Tsai <jb.tsai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Deren.Wu@mediatek.com>, <Sean.Wang@mediatek.com>, <Quan.Zhou@mediatek.com>,
	<Ryder.Lee@mediatek.com>, <Leon.Yen@mediatek.com>,
	<litien.chang@mediatek.com>, <jb.tsai@mediatek.com>
Subject: [PATCH 4/5] wifi: mt76: mt7921: add auto regdomain switch support
Date: Mon, 23 Feb 2026 15:38:53 +0800
Message-ID: <20260223073854.2464232-4-jb.tsai@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260223073854.2464232-1-jb.tsai@mediatek.com>
References: <20260223073854.2464232-1-jb.tsai@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-32095-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:mid,mediatek.com:dkim,mediatek.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78183172C51
X-Rspamd-Action: no action

Implement 802.11d-based automatic regulatory domain switching to
dynamically determine the regulatory domain at runtime.

Signed-off-by: JB Tsai <jb.tsai@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  3 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  3 +
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 12 ++-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  3 +-
 .../net/wireless/mediatek/mt76/mt7921/regd.c  | 81 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7921/regd.h  |  2 +
 6 files changed, 93 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index f44977f9093d..263778be4a34 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1586,7 +1586,7 @@ struct mt76_connac_hw_scan_done {
 	u8 pno_enabled;
 	u8 pad2[3];
 	u8 sparse_channel_valid_num;
-	u8 pad3[3];
+	u8 alpha2[3];
 	u8 channel_num[MT76_CONNAC_SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
 	/* idle format for channel_idle_time
 	 * 0: first bytes: idle time(ms) 2nd byte: dwell time(ms)
@@ -1599,6 +1599,7 @@ struct mt76_connac_hw_scan_done {
 	u8 mdrdy_count[MT76_CONNAC_SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
 	__le32 beacon_2g_num;
 	__le32 beacon_5g_num;
+	__le16 channel_scan_time[MT76_CONNAC_SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
 } __packed;
 
 struct mt76_connac_sched_scan_req {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 03b4960db73f..bcca4b17e8f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -7,6 +7,7 @@
 #include "mt7921.h"
 #include "../dma.h"
 #include "../mt76_connac2_mac.h"
+#include "regd.h"
 #include "mcu.h"
 
 #define MT_WTBL_TXRX_CAP_RATE_OFFSET	7
@@ -697,6 +698,8 @@ void mt7921_mac_reset_work(struct work_struct *work)
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7921_vif_connect_iter, NULL);
 	mt76_connac_power_save_sched(&dev->mt76.phy, pm);
+
+	mt7921_regd_change(&dev->phy, "00");
 }
 
 void mt7921_coredump_work(struct work_struct *work)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 00ca3d3f3ef0..dfe8cbd7dfa5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1027,8 +1027,16 @@ void mt7921_scan_work(struct work_struct *work)
 		rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
 		if (rxd->eid == MCU_EVENT_SCHED_SCAN_DONE) {
 			ieee80211_sched_scan_results(phy->mt76->hw);
-		} else if (test_and_clear_bit(MT76_HW_SCANNING,
-					      &phy->mt76->state)) {
+		} else if (rxd->eid == MCU_EVENT_SCAN_DONE) {
+			struct mt76_connac_hw_scan_done *event = NULL;
+
+			skb_pull(skb, sizeof(*rxd));
+			event = (struct mt76_connac_hw_scan_done *)skb->data;
+			mt7921_regd_change(phy, event->alpha2);
+		}
+
+		if (test_and_clear_bit(MT76_HW_SCANNING,
+				       &phy->mt76->state)) {
 			struct cfg80211_scan_info info = {
 				.aborted = false,
 			};
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 1e2afa736cdf..4e455aad2f4c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -487,7 +487,8 @@ static int mt7921_load_clc(struct mt792x_dev *dev, const char *fw_name)
 			goto out;
 		}
 	}
-	ret = mt7921_mcu_set_clc(dev, "00", ENVIRON_INDOOR);
+
+	ret = mt7921_regd_init(phy);
 out:
 	release_firmware(fw);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regd.c b/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
index f795ee2eb446..b53fa1f5c6db 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
@@ -111,26 +111,93 @@ int mt7921_mcu_regd_update(struct mt792x_dev *dev, u8 *alpha2,
 EXPORT_SYMBOL_GPL(mt7921_mcu_regd_update);
 
 void mt7921_regd_notifier(struct wiphy *wiphy,
-			  struct regulatory_request *request)
+			  struct regulatory_request *req)
 {
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt76_connac_pm *pm = &dev->pm;
+	struct mt76_dev *mdev = &dev->mt76;
+
+	/* do not need to update the same country twice */
+	if (!memcmp(req->alpha2, mdev->alpha2, 2) &&
+	    dev->country_ie_env == req->country_ie_env)
+		return;
 
-	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
-	dev->mt76.region = request->dfs_region;
-	dev->country_ie_env = request->country_ie_env;
+	memcpy(mdev->alpha2, req->alpha2, 2);
+	mdev->region = req->dfs_region;
+	dev->country_ie_env = req->country_ie_env;
 
-	if (request->initiator == NL80211_REGDOM_SET_BY_USER) {
+	if (req->initiator == NL80211_REGDOM_SET_BY_USER) {
 		if (dev->mt76.alpha2[0] == '0' && dev->mt76.alpha2[1] == '0')
 			wiphy->regulatory_flags &= ~REGULATORY_COUNTRY_IE_IGNORE;
 		else
 			wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_IGNORE;
 	}
 
+	dev->regd_change = true;
+
 	if (pm->suspended)
 		return;
 
-	mt7921_mcu_regd_update(dev, request->alpha2,
-			       request->country_ie_env);
+	mt7921_mcu_regd_update(dev, req->alpha2,
+			       req->country_ie_env);
+}
+
+static bool
+mt7921_regd_is_valid_alpha2(const char *alpha2)
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
+int mt7921_regd_change(struct mt792x_phy *phy, char *alpha2)
+{
+	struct wiphy *wiphy = phy->mt76->hw->wiphy;
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt76_dev *mdev = &dev->mt76;
+
+	if (dev->hw_full_reset)
+		return 0;
+
+	if (!mt7921_regd_is_valid_alpha2(alpha2) ||
+	    !mt7921_regd_clc_supported(dev))
+		return -EINVAL;
+
+	if (mdev->alpha2[0] != '0' && mdev->alpha2[1] != '0')
+		return 0;
+
+	/* do not need to update the same country twice */
+	if (!memcmp(alpha2, mdev->alpha2, 2))
+		return 0;
+
+	if (phy->chip_cap & MT792x_CHIP_CAP_11D_EN)
+		return regulatory_hint(wiphy, alpha2);
+	else
+		return mt7921_mcu_set_clc(dev, alpha2, ENVIRON_INDOOR);
+}
+EXPORT_SYMBOL_GPL(mt7921_regd_change);
+
+int mt7921_regd_init(struct mt792x_phy *phy)
+{
+	struct wiphy *wiphy = phy->mt76->hw->wiphy;
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt76_dev *mdev = &dev->mt76;
+
+	if (phy->chip_cap & MT792x_CHIP_CAP_11D_EN)
+		wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_IGNORE |
+					   REGULATORY_DISABLE_BEACON_HINTS;
+	else
+		memzero_explicit(&mdev->alpha2, sizeof(mdev->alpha2));
+
+	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regd.h b/drivers/net/wireless/mediatek/mt76/mt7921/regd.h
index da5bd4450312..f125427192b6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regd.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regd.h
@@ -11,5 +11,7 @@ int mt7921_mcu_regd_update(struct mt792x_dev *dev, u8 *alpha2,
 void mt7921_regd_notifier(struct wiphy *wiphy,
 			  struct regulatory_request *request);
 bool mt7921_regd_clc_supported(struct mt792x_dev *dev);
+int mt7921_regd_change(struct mt792x_phy *phy, char *alpha2);
+int mt7921_regd_init(struct mt792x_phy *phy);
 
 #endif
-- 
2.45.2


