Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75EA35B9E4
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 07:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhDLFk7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 01:40:59 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:45567 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229482AbhDLFk5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 01:40:57 -0400
X-UUID: 9960d2fd3ab348f689aec1fd36679da1-20210412
X-UUID: 9960d2fd3ab348f689aec1fd36679da1-20210412
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 530089586; Mon, 12 Apr 2021 13:40:36 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 12 Apr 2021 13:40:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Apr 2021 13:40:33 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 1/3] mt76: testmode: add support to send larger packet
Date:   Mon, 12 Apr 2021 13:39:52 +0800
Message-ID: <20210412053954.23544-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B06D6AABF5C66E688E12ADA12917E35FAD1AD601A5712D22514C95723DE744E62000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support to send larger packet in testmode to meet requirements
of some test cases.
The limit of max packet size is determined based on tx rate mode setting.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |   3 +-
 drivers/net/wireless/mediatek/mt76/testmode.c | 159 ++++++++++++++----
 drivers/net/wireless/mediatek/mt76/testmode.h |   2 +-
 drivers/net/wireless/mediatek/mt76/tx.c       |   2 +-
 4 files changed, 131 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4571f0e..bf049fb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -539,7 +539,7 @@ struct mt76_testmode_data {
 	struct sk_buff *tx_skb;
 
 	u32 tx_count;
-	u16 tx_msdu_len;
+	u16 tx_mpdu_len;
 
 	u8 tx_rate_mode;
 	u8 tx_rate_idx;
@@ -1082,6 +1082,7 @@ int mt76_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 int mt76_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *skb,
 		       struct netlink_callback *cb, void *data, int len);
 int mt76_testmode_set_state(struct mt76_phy *phy, enum mt76_testmode_state state);
+int mt76_testmode_alloc_skb(struct mt76_phy *phy, u32 len);
 
 static inline void mt76_testmode_reset(struct mt76_phy *phy, bool disable)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index cc76964..001d0ba 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -62,36 +62,83 @@ void mt76_testmode_tx_pending(struct mt76_phy *phy)
 	spin_unlock_bh(&q->lock);
 }
 
+static u32
+mt76_testmode_max_mpdu_len(struct mt76_phy *phy, u8 tx_rate_mode)
+{
+	switch (tx_rate_mode) {
+	case MT76_TM_TX_MODE_HT:
+		return IEEE80211_MAX_MPDU_LEN_HT_7935;
+	case MT76_TM_TX_MODE_VHT:
+	case MT76_TM_TX_MODE_HE_SU:
+	case MT76_TM_TX_MODE_HE_EXT_SU:
+	case MT76_TM_TX_MODE_HE_TB:
+	case MT76_TM_TX_MODE_HE_MU:
+		if (phy->sband_5g.sband.vht_cap.cap &
+		    IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991)
+			return IEEE80211_MAX_MPDU_LEN_VHT_7991;
+		return IEEE80211_MAX_MPDU_LEN_VHT_11454;
+	case MT76_TM_TX_MODE_CCK:
+	case MT76_TM_TX_MODE_OFDM:
+	default:
+		return IEEE80211_MAX_FRAME_LEN;
+	}
+}
 
-static int
-mt76_testmode_tx_init(struct mt76_phy *phy)
+static void
+mt76_testmode_free_skb(struct mt76_phy *phy)
 {
 	struct mt76_testmode_data *td = &phy->test;
-	struct ieee80211_tx_info *info;
-	struct ieee80211_hdr *hdr;
-	struct sk_buff *skb;
+	struct sk_buff *skb = td->tx_skb;
+
+	if (!skb)
+		return;
+
+	if (skb_has_frag_list(skb)) {
+		kfree_skb_list(skb_shinfo(skb)->frag_list);
+		skb_shinfo(skb)->frag_list = NULL;
+	}
+
+	dev_kfree_skb(skb);
+	td->tx_skb = NULL;
+}
+
+int mt76_testmode_alloc_skb(struct mt76_phy *phy, u32 len)
+{
+#define MT_TXP_MAX_LEN	4095
 	u16 fc = IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA |
 		 IEEE80211_FCTL_FROMDS;
-	struct ieee80211_tx_rate *rate;
-	u8 max_nss = hweight8(phy->antenna_mask);
+	struct mt76_testmode_data *td = &phy->test;
 	bool ext_phy = phy != &phy->dev->phy;
+	struct sk_buff **frag_tail, *head;
+	struct ieee80211_tx_info *info;
+	struct ieee80211_hdr *hdr;
+	u32 max_len, head_len;
+	int nfrags, i;
 
-	if (td->tx_antenna_mask)
-		max_nss = min_t(u8, max_nss, hweight8(td->tx_antenna_mask));
+	max_len = mt76_testmode_max_mpdu_len(phy, td->tx_rate_mode);
+	if (len > max_len)
+		len = max_len;
+	else if (len < sizeof(struct ieee80211_hdr))
+		len = sizeof(struct ieee80211_hdr);
 
-	skb = alloc_skb(td->tx_msdu_len, GFP_KERNEL);
-	if (!skb)
+	nfrags = len / MT_TXP_MAX_LEN;
+	head_len = nfrags ? MT_TXP_MAX_LEN : len;
+
+	if (len > IEEE80211_MAX_FRAME_LEN)
+		fc |= IEEE80211_STYPE_QOS_DATA;
+
+	head = alloc_skb(head_len, GFP_KERNEL);
+	if (!head)
 		return -ENOMEM;
 
-	dev_kfree_skb(td->tx_skb);
-	td->tx_skb = skb;
-	hdr = __skb_put_zero(skb, td->tx_msdu_len);
+	hdr = __skb_put_zero(head, head_len);
 	hdr->frame_control = cpu_to_le16(fc);
 	memcpy(hdr->addr1, phy->macaddr, sizeof(phy->macaddr));
 	memcpy(hdr->addr2, phy->macaddr, sizeof(phy->macaddr));
 	memcpy(hdr->addr3, phy->macaddr, sizeof(phy->macaddr));
+	skb_set_queue_mapping(head, IEEE80211_AC_BE);
 
-	info = IEEE80211_SKB_CB(skb);
+	info = IEEE80211_SKB_CB(head);
 	info->flags = IEEE80211_TX_CTL_INJECTED |
 		      IEEE80211_TX_CTL_NO_ACK |
 		      IEEE80211_TX_CTL_NO_PS_BUFFER;
@@ -99,9 +146,60 @@ mt76_testmode_tx_init(struct mt76_phy *phy)
 	if (ext_phy)
 		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
 
+	frag_tail = &skb_shinfo(head)->frag_list;
+
+	for (i = 0; i < nfrags; i++) {
+		struct sk_buff *frag;
+		u16 frag_len;
+
+		if (i == nfrags - 1)
+			frag_len = len % MT_TXP_MAX_LEN;
+		else
+			frag_len = MT_TXP_MAX_LEN;
+
+		frag = alloc_skb(frag_len, GFP_KERNEL);
+		if (!frag)
+			return -ENOMEM;
+
+		__skb_put_zero(frag, frag_len);
+		head->len += frag->len;
+		head->data_len += frag->len;
+
+		if (*frag_tail) {
+			(*frag_tail)->next = frag;
+			frag_tail = &frag;
+		} else {
+			*frag_tail = frag;
+		}
+	}
+
+	mt76_testmode_free_skb(phy);
+	td->tx_skb = head;
+
+	return 0;
+}
+EXPORT_SYMBOL(mt76_testmode_alloc_skb);
+
+static int
+mt76_testmode_tx_init(struct mt76_phy *phy)
+{
+	struct mt76_testmode_data *td = &phy->test;
+	struct ieee80211_tx_info *info;
+	struct ieee80211_tx_rate *rate;
+	u8 max_nss = hweight8(phy->antenna_mask);
+	int ret;
+
+	ret = mt76_testmode_alloc_skb(phy, td->tx_mpdu_len);
+	if (ret)
+		return ret;
+
 	if (td->tx_rate_mode > MT76_TM_TX_MODE_VHT)
 		goto out;
 
+	if (td->tx_antenna_mask)
+		max_nss = min_t(u8, max_nss, hweight8(td->tx_antenna_mask));
+
+	info = IEEE80211_SKB_CB(td->tx_skb);
 	rate = &info->control.rates[0];
 	rate->count = 1;
 	rate->idx = td->tx_rate_idx;
@@ -171,8 +269,6 @@ mt76_testmode_tx_init(struct mt76_phy *phy)
 		}
 	}
 out:
-	skb_set_queue_mapping(skb, IEEE80211_AC_BE);
-
 	return 0;
 }
 
@@ -203,8 +299,7 @@ mt76_testmode_tx_stop(struct mt76_phy *phy)
 	wait_event_timeout(dev->tx_wait, td->tx_done == td->tx_queued,
 			   MT76_TM_TIMEOUT * HZ);
 
-	dev_kfree_skb(td->tx_skb);
-	td->tx_skb = NULL;
+	mt76_testmode_free_skb(phy);
 }
 
 static inline void
@@ -224,10 +319,10 @@ mt76_testmode_init_defaults(struct mt76_phy *phy)
 {
 	struct mt76_testmode_data *td = &phy->test;
 
-	if (td->tx_msdu_len > 0)
+	if (td->tx_mpdu_len > 0)
 		return;
 
-	td->tx_msdu_len = 1024;
+	td->tx_mpdu_len = 1024;
 	td->tx_count = 1;
 	td->tx_rate_mode = MT76_TM_TX_MODE_OFDM;
 	td->tx_rate_nss = 1;
@@ -345,16 +440,6 @@ int mt76_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (tb[MT76_TM_ATTR_TX_COUNT])
 		td->tx_count = nla_get_u32(tb[MT76_TM_ATTR_TX_COUNT]);
 
-	if (tb[MT76_TM_ATTR_TX_LENGTH]) {
-		u32 val = nla_get_u32(tb[MT76_TM_ATTR_TX_LENGTH]);
-
-		if (val > IEEE80211_MAX_FRAME_LEN ||
-		    val < sizeof(struct ieee80211_hdr))
-			goto out;
-
-		td->tx_msdu_len = val;
-	}
-
 	if (tb[MT76_TM_ATTR_TX_RATE_IDX])
 		td->tx_rate_idx = nla_get_u8(tb[MT76_TM_ATTR_TX_RATE_IDX]);
 
@@ -375,6 +460,16 @@ int mt76_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			   &td->tx_power_control, 0, 1))
 		goto out;
 
+	if (tb[MT76_TM_ATTR_TX_LENGTH]) {
+		u32 val = nla_get_u32(tb[MT76_TM_ATTR_TX_LENGTH]);
+
+		if (val > mt76_testmode_max_mpdu_len(phy, td->tx_rate_mode) ||
+		    val < sizeof(struct ieee80211_hdr))
+			goto out;
+
+		td->tx_mpdu_len = val;
+	}
+
 	if (tb[MT76_TM_ATTR_TX_IPG])
 		td->tx_ipg = nla_get_u32(tb[MT76_TM_ATTR_TX_IPG]);
 
@@ -506,7 +601,7 @@ int mt76_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
 		goto out;
 
 	if (nla_put_u32(msg, MT76_TM_ATTR_TX_COUNT, td->tx_count) ||
-	    nla_put_u32(msg, MT76_TM_ATTR_TX_LENGTH, td->tx_msdu_len) ||
+	    nla_put_u32(msg, MT76_TM_ATTR_TX_LENGTH, td->tx_mpdu_len) ||
 	    nla_put_u8(msg, MT76_TM_ATTR_TX_RATE_MODE, td->tx_rate_mode) ||
 	    nla_put_u8(msg, MT76_TM_ATTR_TX_RATE_NSS, td->tx_rate_nss) ||
 	    nla_put_u8(msg, MT76_TM_ATTR_TX_RATE_IDX, td->tx_rate_idx) ||
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.h b/drivers/net/wireless/mediatek/mt76/testmode.h
index e0c706c..d32a765 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.h
+++ b/drivers/net/wireless/mediatek/mt76/testmode.h
@@ -21,7 +21,7 @@
  * @MT76_TM_ATTR_TX_COUNT: configured number of frames to send when setting
  *	state to MT76_TM_STATE_TX_FRAMES (u32)
  * @MT76_TM_ATTR_TX_PENDING: pending frames during MT76_TM_STATE_TX_FRAMES (u32)
- * @MT76_TM_ATTR_TX_LENGTH: packet tx msdu length (u32)
+ * @MT76_TM_ATTR_TX_LENGTH: packet tx mpdu length (u32)
  * @MT76_TM_ATTR_TX_RATE_MODE: packet tx mode (u8, see &enum mt76_testmode_tx_mode)
  * @MT76_TM_ATTR_TX_RATE_NSS: packet tx number of spatial streams (u8)
  * @MT76_TM_ATTR_TX_RATE_IDX: packet tx rate/MCS index (u8)
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 451ed60..04e4725 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -213,7 +213,7 @@ void mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *sk
 		if (phy->test.tx_queued == phy->test.tx_done)
 			wake_up(&dev->tx_wait);
 
-		ieee80211_free_txskb(hw, skb);
+		dev_kfree_skb_any(skb);
 		return;
 	}
 #endif
-- 
2.18.0

