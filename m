Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00393EAC30
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Aug 2021 23:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhHLVE7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Aug 2021 17:04:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55474 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229655AbhHLVE7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Aug 2021 17:04:59 -0400
X-UUID: d6c08a5d03b24f2782fc66b00a1bd806-20210813
X-UUID: d6c08a5d03b24f2782fc66b00a1bd806-20210813
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 946320826; Fri, 13 Aug 2021 05:04:31 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 13 Aug 2021 05:04:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 Aug 2021 05:04:29 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 3/3] mt76: mt7915: rework debugfs fixed-rate knob
Date:   Fri, 13 Aug 2021 05:04:26 +0800
Message-ID: <9286919a9098d3ce3d77fbf3df8fb408670dc7d9.1628799602.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <1c3fc7ff6d5ab129a58160cd878787d9fbeba9c2.1628799602.git.ryder.lee@mediatek.com>
References: <1c3fc7ff6d5ab129a58160cd878787d9fbeba9c2.1628799602.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Switch to use new mt7915_mcu_set_fixed_rate_ctrl().

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
@Felix, please ignore the following one 
https://patchwork.kernel.org/project/linux-wireless/patch/c3fd9c4ea692f28e2eb78073fd8da7753199ba60.1628301616.git.ryder.lee@mediatek.com/
[3/4] mt76: mt7915: add HE-LTF into fixed rate command
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 68 ++++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 48 +------------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 -
 3 files changed, 61 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index d9d18f662039..e1cdfbe52199 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -365,19 +365,71 @@ int mt7915_init_debugfs(struct mt7915_dev *dev)
 #ifdef CONFIG_MAC80211_DEBUGFS
 /** per-station debugfs **/
 
-static int mt7915_sta_fixed_rate_set(void *data, u64 rate)
+static ssize_t mt7915_sta_fixed_rate_set(struct file *file,
+					 const char __user *user_buf,
+					 size_t count, loff_t *ppos)
 {
-	struct ieee80211_sta *sta = data;
+	struct ieee80211_sta *sta = file->private_data;
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
-
-	/* usage: <he ltf> <tx mode> <ldpc> <stbc> <bw> <gi> <nss> <mcs>
-	 * <tx mode>: see enum mt76_phy_type
+	struct mt7915_dev *dev = msta->vif->phy->dev;
+	struct ieee80211_vif *vif;
+	struct sta_phy phy = {};
+	char buf[100];
+	int ret;
+	u32 field;
+	u8 i, gi, he_ltf;
+
+	if (count >= sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+
+	if (count && buf[count - 1] == '\n')
+		buf[count - 1] = '\0';
+	else
+		buf[count] = '\0';
+
+	/* Mode: CCK:0, OFDM:1, HT:2, GF:3, VHT:4, HE_SU:8, HE_ER:9
+	 * BW: BW20:0, BW40:1, BW80:2, BW160:3
+	 * NSS: VHT:1~4, HE:1~4, Others:Ignore
+	 * MCS: CCK:0~4, OFDM:0~7, HT:0~32, VHT:0~9, HE_SU:0~11, HE_ER:0~2
+	 * GI: (HT/VHT) LGI:0, SGI:1; (HE) 0.8us:0, 1.6us:1, 3.2us:2
+	 * LDPC: Off:0, On:1
+	 * STBC: Off:0, On:1
+	 * HE_LTF: 1xLTF:0, 2xLTF:1, 4xLTF:2
 	 */
-	return mt7915_mcu_set_fixed_rate(msta->vif->phy->dev, sta, rate);
+	if (sscanf(buf, "%hhu %hhu %hhu %hhu %hhu %hhu %hhu %hhu",
+		   &phy.type, &phy.bw, &phy.nss, &phy.mcs, &gi,
+		   &phy.ldpc, &phy.stbc, &he_ltf) != 8) {
+		dev_warn(dev->mt76.dev,
+			 "format: Mode BW NSS MCS (HE)GI LDPC STBC HE_LTF\n");
+		field = RATE_PARAM_AUTO;
+		goto out;
+	}
+
+	phy.ldpc = (phy.bw || phy.ldpc) * GENMASK(2, 0);
+	for (i = 0; i <= phy.bw; i++) {
+		phy.sgi |= gi << (i << sta->he_cap.has_he);
+		phy.he_ltf |= he_ltf << (i << sta->he_cap.has_he);
+	}
+	field = RATE_PARAM_FIXED;
+
+out:
+	vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
+	ret = mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, &phy, field);
+	if (ret)
+		return -EFAULT;
+
+	return count;
 }
 
-DEFINE_DEBUGFS_ATTRIBUTE(fops_fixed_rate, NULL,
-			 mt7915_sta_fixed_rate_set, "%llx\n");
+static const struct file_operations fops_fixed_rate = {
+	.write = mt7915_sta_fixed_rate_set,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
 
 void mt7915_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta, struct dentry *dir)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index dfe9b47c8f4e..5f4cab743f56 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2065,6 +2065,7 @@ int mt7915_mcu_set_fixed_rate_ctrl(struct mt7915_dev *dev,
 	switch (field) {
 	case RATE_PARAM_AUTO:
 		break;
+	case RATE_PARAM_FIXED:
 	case RATE_PARAM_FIXED_MCS:
 	case RATE_PARAM_FIXED_GI:
 	case RATE_PARAM_FIXED_HE_LTF:
@@ -2416,53 +2417,6 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 				     MCU_EXT_CMD(STA_REC_UPDATE), true);
 }
 
-int mt7915_mcu_set_fixed_rate(struct mt7915_dev *dev,
-			      struct ieee80211_sta *sta, u32 rate)
-{
-	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
-	struct mt7915_vif *mvif = msta->vif;
-	struct sta_rec_ra_fixed *ra;
-	struct sk_buff *skb;
-	struct tlv *tlv;
-	int len = sizeof(struct sta_req_hdr) + sizeof(*ra);
-
-	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta, len);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	tlv = mt7915_mcu_add_tlv(skb, STA_REC_RA_UPDATE, sizeof(*ra));
-	ra = (struct sta_rec_ra_fixed *)tlv;
-
-	if (!rate) {
-		ra->field = cpu_to_le32(RATE_PARAM_AUTO);
-		goto out;
-	}
-
-	ra->field = cpu_to_le32(RATE_PARAM_FIXED);
-	ra->phy.type = FIELD_GET(RATE_CFG_PHY_TYPE, rate);
-	ra->phy.bw = FIELD_GET(RATE_CFG_BW, rate);
-	ra->phy.nss = FIELD_GET(RATE_CFG_NSS, rate);
-	ra->phy.mcs = FIELD_GET(RATE_CFG_MCS, rate);
-	ra->phy.stbc = FIELD_GET(RATE_CFG_STBC, rate);
-
-	if (ra->phy.bw)
-		ra->phy.ldpc = 7;
-	else
-		ra->phy.ldpc = FIELD_GET(RATE_CFG_LDPC, rate) * 7;
-
-	/* HT/VHT - SGI: 1, LGI: 0; HE - SGI: 0, MGI: 1, LGI: 2 */
-	if (ra->phy.type > MT_PHY_TYPE_VHT) {
-		ra->phy.he_ltf = FIELD_GET(RATE_CFG_HE_LTF, rate) * 85;
-		ra->phy.sgi = FIELD_GET(RATE_CFG_GI, rate) * 85;
-	} else {
-		ra->phy.sgi = FIELD_GET(RATE_CFG_GI, rate) * 15;
-	}
-
-out:
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD(STA_REC_UPDATE), true);
-}
-
 int mt7915_mcu_add_dev_info(struct mt7915_phy *phy,
 			    struct ieee80211_vif *vif, bool enable)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 477a8621550a..c0da97f2774c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -331,8 +331,6 @@ int mt7915_set_channel(struct mt7915_phy *phy);
 int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd);
 int mt7915_mcu_set_tx(struct mt7915_dev *dev, struct ieee80211_vif *vif);
 int mt7915_mcu_update_edca(struct mt7915_dev *dev, void *req);
-int mt7915_mcu_set_fixed_rate(struct mt7915_dev *dev,
-			      struct ieee80211_sta *sta, u32 rate);
 int mt7915_mcu_set_fixed_rate_ctrl(struct mt7915_dev *dev,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta,
-- 
2.29.2

