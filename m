Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 954AB17D6B7
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Mar 2020 23:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgCHWJp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Mar 2020 18:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgCHWJp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Mar 2020 18:09:45 -0400
Received: from localhost.localdomain (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 455A72083E;
        Sun,  8 Mar 2020 22:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583705384;
        bh=6kPoHXAvxtMTWDyl/5LgxePh19HAUwHGRKr95Jjy4HQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aQ0WJiw8yweVgyDHj8Pc+XBtR441VBeM2ICFcD/wjxn5NsBVePDu01ypnTnL8XynW
         xuaJrTUoueKPuOmO9B4IkMnendKC4N/xAbJJ3TWSZdZp/If1ZyXLNSGkI2XIYeLzzq
         L8vMX7FQxAzLul0Kf72ui9fALNikubRF10luaiN0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com
Subject: [PATCH v2 23/25] mt76: mt7615: introduce set_ba uni command
Date:   Sun,  8 Mar 2020 23:08:35 +0100
Message-Id: <fdd3986ed7cfdd52d39ca9d5069c0169eff5f18a.1583705012.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1583705012.git.lorenzo@kernel.org>
References: <cover.1583705012.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7615_mcu_uni_set_ba routine in order to add support
for mt7663e driver

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 6ea62959caef..afe192e0c48a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1306,6 +1306,88 @@ mt7615_mcu_uni_add_beacon_offload(struct mt7615_dev *dev,
 				   &req, sizeof(req), true);
 }
 
+static int
+mt7615_mcu_uni_tx_ba(struct mt7615_dev *dev,
+		     struct ieee80211_ampdu_params *params,
+		     bool enable)
+{
+	struct mt7615_sta *msta = (struct mt7615_sta *)params->sta->drv_priv;
+	struct mt7615_vif *mvif = msta->vif;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct tlv *sta_wtbl;
+	struct sk_buff *skb;
+	int err;
+
+	skb = mt7615_mcu_alloc_sta_req(mvif, msta);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL,
+				      sizeof(struct sta_rec_wtbl));
+
+	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(msta, WTBL_SET, sta_wtbl, &skb);
+	if (IS_ERR(wtbl_hdr))
+		return PTR_ERR(wtbl_hdr);
+
+	mt7615_mcu_wtbl_ba_tlv(skb, params, enable, true, sta_wtbl,
+			       wtbl_hdr);
+
+	err =  __mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				       MCU_UNI_CMD_STA_REC_UPDATE, true);
+	if (err < 0)
+		return err;
+
+	skb = mt7615_mcu_alloc_sta_req(mvif, msta);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	mt7615_mcu_sta_ba_tlv(skb, params, enable, true);
+
+	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				       MCU_UNI_CMD_STA_REC_UPDATE, true);
+}
+
+static int
+mt7615_mcu_uni_rx_ba(struct mt7615_dev *dev,
+		     struct ieee80211_ampdu_params *params,
+		     bool enable)
+{
+	struct mt7615_sta *msta = (struct mt7615_sta *)params->sta->drv_priv;
+	struct mt7615_vif *mvif = msta->vif;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct tlv *sta_wtbl;
+	struct sk_buff *skb;
+	int err;
+
+	skb = mt7615_mcu_alloc_sta_req(mvif, msta);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	mt7615_mcu_sta_ba_tlv(skb, params, enable, false);
+
+	err = __mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				      MCU_UNI_CMD_STA_REC_UPDATE, true);
+	if (err < 0 || !enable)
+		return err;
+
+	skb = mt7615_mcu_alloc_sta_req(mvif, msta);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL,
+				      sizeof(struct sta_rec_wtbl));
+
+	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(msta, WTBL_SET, sta_wtbl, &skb);
+	if (IS_ERR(wtbl_hdr))
+		return PTR_ERR(wtbl_hdr);
+
+	mt7615_mcu_wtbl_ba_tlv(skb, params, enable, false, sta_wtbl,
+			       wtbl_hdr);
+
+	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				       MCU_UNI_CMD_STA_REC_UPDATE, true);
+}
+
 static int
 mt7615_mcu_uni_set_state(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			 struct ieee80211_sta *sta, int state)
@@ -1363,6 +1445,8 @@ static const struct mt7615_mcu_ops uni_update_ops = {
 	.set_pm_state = mt7615_mcu_uni_ctrl_pm_state,
 	.add_dev_info = mt7615_mcu_uni_add_dev,
 	.add_bss_info = mt7615_mcu_uni_add_bss,
+	.add_tx_ba = mt7615_mcu_uni_tx_ba,
+	.add_rx_ba = mt7615_mcu_uni_rx_ba,
 	.sta_add = mt7615_mcu_uni_add_sta,
 };
 
-- 
2.24.1

