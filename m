Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3569644F8A9
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Nov 2021 16:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhKNPFt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Nov 2021 10:05:49 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:35100 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229725AbhKNPFp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Nov 2021 10:05:45 -0500
X-UUID: e2dc12364d034cf5a4bf529b4083219b-20211114
X-UUID: e2dc12364d034cf5a4bf529b4083219b-20211114
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1077736703; Sun, 14 Nov 2021 23:02:47 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sun, 14 Nov 2021 23:02:45 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 14 Nov
 2021 23:02:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 14 Nov 2021 23:02:45 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2] mt76: testmode: add support to set MAC
Date:   Sun, 14 Nov 2021 22:59:09 +0800
Message-ID: <20211114145909.24817-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support to set SA/DA/BSSID in testmode.
During mass production stage, some test scripts or test equipments need
to set fixed addresses to detect or parse if a test is passed.
Also, MAC setting is necessary for some tx/rx tests with rx filter,
to make sure rx site only receives expected packets.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
v2: use memcpy() for MAC due to potential alignment problem
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 ++
 drivers/net/wireless/mediatek/mt76/testmode.c | 36 +++++++++++++++++--
 drivers/net/wireless/mediatek/mt76/testmode.h |  4 +++
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index e2da720..e7ced94 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -599,6 +599,8 @@ struct mt76_testmode_data {
 	u8 tx_power[4];
 	u8 tx_power_control;
 
+	u8 addr[3][ETH_ALEN];
+
 	u32 tx_pending;
 	u32 tx_queued;
 	u16 tx_queued_limit;
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index 66afc2b..1a01ad7 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -126,9 +126,9 @@ int mt76_testmode_alloc_skb(struct mt76_phy *phy, u32 len)
 
 	hdr = __skb_put_zero(head, head_len);
 	hdr->frame_control = cpu_to_le16(fc);
-	memcpy(hdr->addr1, phy->macaddr, sizeof(phy->macaddr));
-	memcpy(hdr->addr2, phy->macaddr, sizeof(phy->macaddr));
-	memcpy(hdr->addr3, phy->macaddr, sizeof(phy->macaddr));
+	memcpy(hdr->addr1, td->addr[0], ETH_ALEN);
+	memcpy(hdr->addr2, td->addr[1], ETH_ALEN);
+	memcpy(hdr->addr3, td->addr[2], ETH_ALEN);
 	skb_set_queue_mapping(head, IEEE80211_AC_BE);
 
 	info = IEEE80211_SKB_CB(head);
@@ -318,6 +318,10 @@ mt76_testmode_init_defaults(struct mt76_phy *phy)
 	td->tx_count = 1;
 	td->tx_rate_mode = MT76_TM_TX_MODE_OFDM;
 	td->tx_rate_nss = 1;
+
+	memcpy(td->addr[0], phy->macaddr, ETH_ALEN);
+	memcpy(td->addr[1], phy->macaddr, ETH_ALEN);
+	memcpy(td->addr[2], phy->macaddr, ETH_ALEN);
 }
 
 static int
@@ -493,6 +497,20 @@ int mt76_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		}
 	}
 
+	if (tb[MT76_TM_ATTR_MAC_ADDRS]) {
+		struct nlattr *cur;
+		int idx = 0;
+		int rem;
+
+		nla_for_each_nested(cur, tb[MT76_TM_ATTR_MAC_ADDRS], rem) {
+			if (nla_len(cur) != ETH_ALEN || idx >= 3)
+				goto out;
+
+			memcpy(td->addr[idx], nla_data(cur), ETH_ALEN);
+			idx++;
+		}
+	}
+
 	if (dev->test_ops->set_params) {
 		err = dev->test_ops->set_params(phy, tb, state);
 		if (err)
@@ -635,6 +653,18 @@ int mt76_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
 		nla_nest_end(msg, a);
 	}
 
+	if (mt76_testmode_param_present(td, MT76_TM_ATTR_MAC_ADDRS)) {
+		a = nla_nest_start(msg, MT76_TM_ATTR_MAC_ADDRS);
+		if (!a)
+			goto out;
+
+		for (i = 0; i < 3; i++)
+			if (nla_put(msg, i, ETH_ALEN, td->addr[i]))
+				goto out;
+
+		nla_nest_end(msg, a);
+	}
+
 	err = 0;
 
 out:
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.h b/drivers/net/wireless/mediatek/mt76/testmode.h
index d1f9c03..5e2792d 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.h
+++ b/drivers/net/wireless/mediatek/mt76/testmode.h
@@ -45,6 +45,8 @@
  * @MT76_TM_ATTR_TX_TIME: packet transmission time, in unit of us (u32)
  *
  * @MT76_TM_ATTR_DRV_DATA: driver specific netlink attrs (nested)
+ *
+ * @MT76_TM_ATTR_MAC_ADDRS: array of nested MAC addresses (nested)
  */
 enum mt76_testmode_attr {
 	MT76_TM_ATTR_UNSPEC,
@@ -81,6 +83,8 @@ enum mt76_testmode_attr {
 
 	MT76_TM_ATTR_DRV_DATA,
 
+	MT76_TM_ATTR_MAC_ADDRS,
+
 	/* keep last */
 	NUM_MT76_TM_ATTRS,
 	MT76_TM_ATTR_MAX = NUM_MT76_TM_ATTRS - 1,
-- 
2.25.1

