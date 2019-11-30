Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB8510DE16
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfK3Pa6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:30:58 -0500
Received: from nbd.name ([46.4.11.11]:56060 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbfK3Pat (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Y4hqfi3LMQlFClJ8spFqoqGNWKLikI1pWuNcue96x1Y=; b=hX18s3Zvrgo5MdrJwYwpbqPIaG
        WibmruXm4IeON0Jgafv/y0aih3Kr7ZbZzUId9j5WVjPyrfGMdvZuIGhpEkm73KuPQO/IxU5ayWBAp
        xJrZf1O841mH9EIoHTi8al9V4wnsHsPAJ/H5c+QhTgRVZSTge/E8eZxHcOMYAOqEMAa8=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hr-0006iI-Pp
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:47 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 0B414721EBE4; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 25/29] mt76: mt7615: initialize dbdc settings on interface add
Date:   Sat, 30 Nov 2019 16:30:41 +0100
Message-Id: <20191130153045.28105-25-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use the first two WMM slots for the primary phy and the second two for the
secondary phy.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 12 +++-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 59 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   | 13 ++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  9 +++
 5 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 4b23998957ca..f80fa045f549 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -121,7 +121,11 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	mvif->omac_idx = idx;
 
 	mvif->band_idx = ext_phy;
-	mvif->wmm_idx = mvif->idx % MT7615_MAX_WMM_SETS;
+	if (mt7615_ext_phy(dev))
+		mvif->wmm_idx = ext_phy * (MT7615_MAX_WMM_SETS / 2) +
+				mvif->idx % (MT7615_MAX_WMM_SETS / 2);
+	else
+		mvif->wmm_idx = mvif->idx % MT7615_MAX_WMM_SETS;
 
 	ret = mt7615_mcu_set_dev_info(dev, vif, 1);
 	if (ret)
@@ -129,6 +133,10 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 
 	dev->vif_mask |= BIT(mvif->idx);
 	dev->omac_mask |= BIT(mvif->omac_idx);
+	phy->omac_mask |= BIT(mvif->omac_idx);
+
+	mt7615_mcu_set_dbdc(dev);
+
 	idx = MT7615_WTBL_RESERVED - mvif->idx;
 
 	INIT_LIST_HEAD(&mvif->sta.poll_list);
@@ -155,6 +163,7 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt7615_sta *msta = &mvif->sta;
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 	int idx = msta->wcid.idx;
 
 	/* TODO: disable beacon for the bss */
@@ -167,6 +176,7 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 	mutex_lock(&dev->mt76.mutex);
 	dev->vif_mask &= ~BIT(mvif->idx);
 	dev->omac_mask &= ~BIT(mvif->omac_idx);
+	phy->omac_mask &= ~BIT(mvif->omac_idx);
 	mutex_unlock(&dev->mt76.mutex);
 
 	spin_lock_bh(&dev->sta_poll_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index a19c406c2231..9b09f2e742df 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -717,6 +717,65 @@ int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int band, int enter)
 				   &req, sizeof(req), true);
 }
 
+int mt7615_mcu_set_dbdc(struct mt7615_dev *dev)
+{
+	struct mt7615_phy *ext_phy = mt7615_ext_phy(dev);
+	struct dbdc_entry {
+		u8 type;
+		u8 index;
+		u8 band;
+		u8 _rsv;
+	};
+	struct {
+		u8 enable;
+		u8 num;
+		u8 _rsv[2];
+		struct dbdc_entry entry[64];
+	} req = {
+		.enable = !!ext_phy,
+	};
+	int i;
+
+	if (!ext_phy)
+		goto out;
+
+#define ADD_DBDC_ENTRY(_type, _idx, _band)		\
+	do { \
+		req.entry[req.num].type = _type;		\
+		req.entry[req.num].index = _idx;		\
+		req.entry[req.num++].band = _band;		\
+	} while (0)
+
+	for (i = 0; i < 4; i++) {
+		bool band = !!(ext_phy->omac_mask & BIT(i));
+
+		ADD_DBDC_ENTRY(DBDC_TYPE_BSS, i, band);
+	}
+
+	for (i = 0; i < 14; i++) {
+		bool band = !!(ext_phy->omac_mask & BIT(0x11 + i));
+
+		ADD_DBDC_ENTRY(DBDC_TYPE_MBSS, i, band);
+	}
+
+	ADD_DBDC_ENTRY(DBDC_TYPE_MU, 0, 1);
+
+	for (i = 0; i < 3; i++)
+		ADD_DBDC_ENTRY(DBDC_TYPE_BF, i, 1);
+
+	ADD_DBDC_ENTRY(DBDC_TYPE_WMM, 0, 0);
+	ADD_DBDC_ENTRY(DBDC_TYPE_WMM, 1, 0);
+	ADD_DBDC_ENTRY(DBDC_TYPE_WMM, 2, 1);
+	ADD_DBDC_ENTRY(DBDC_TYPE_WMM, 3, 1);
+
+	ADD_DBDC_ENTRY(DBDC_TYPE_MGMT, 0, 0);
+	ADD_DBDC_ENTRY(DBDC_TYPE_MGMT, 1, 1);
+
+out:
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_DBDC_CTRL,
+				   &req, sizeof(req), true);
+}
+
 int mt7615_mcu_set_dev_info(struct mt7615_dev *dev,
 			    struct ieee80211_vif *vif, bool enable)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index f4781477fc9b..8d057c72366a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -148,6 +148,7 @@ enum {
 	MCU_EXT_CMD_WTBL_UPDATE = 0x32,
 	MCU_EXT_CMD_SET_RDD_CTRL = 0x3a,
 	MCU_EXT_CMD_PROTECT_CTRL = 0x3e,
+	MCU_EXT_CMD_DBDC_CTRL = 0x45,
 	MCU_EXT_CMD_MAC_INIT_CTRL = 0x46,
 	MCU_EXT_CMD_BCN_OFFLOAD = 0x49,
 	MCU_EXT_CMD_SET_RX_PATH = 0x4e,
@@ -202,6 +203,18 @@ enum {
 	DEV_INFO_MAX_NUM
 };
 
+enum {
+	DBDC_TYPE_WMM,
+	DBDC_TYPE_MGMT,
+	DBDC_TYPE_BSS,
+	DBDC_TYPE_MBSS,
+	DBDC_TYPE_REPEATER,
+	DBDC_TYPE_MU,
+	DBDC_TYPE_BF,
+	DBDC_TYPE_PTA,
+	__DBDC_TYPE_MAX,
+};
+
 struct bss_info_omac {
 	__le16 tag;
 	__le16 len;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 64c8ad64733b..3323baa7cc0c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -88,6 +88,7 @@ struct mt7615_phy {
 	struct mt7615_dev *dev;
 
 	u32 rxfilter;
+	u32 omac_mask;
 
 	unsigned long last_cca_adj;
 	int false_cca_ofdm, false_cca_cck;
@@ -285,6 +286,7 @@ int mt7615_mac_wtbl_set_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 			    struct ieee80211_key_conf *key,
 			    enum set_key_cmd cmd);
 
+int mt7615_mcu_set_dbdc(struct mt7615_dev *dev);
 int mt7615_mcu_set_eeprom(struct mt7615_dev *dev);
 int mt7615_mcu_init_mac(struct mt7615_dev *dev);
 int mt7615_mcu_set_rts_thresh(struct mt7615_phy *phy, u32 val);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index d0602a3b0ac1..cece061b1108 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -121,6 +121,15 @@
 #define MT_CFG_CCR_MAC_D1_2X_GC_EN	BIT(30)
 #define MT_CFG_CCR_MAC_D0_2X_GC_EN	BIT(31)
 
+#define MT_DBDC_CTRL0			MT_WF_CFG(0x050)
+#define MT_DBDC_CTRL0_OMAC_00_04	GENMASK(4, 0)
+#define MT_DBDC_CTRL0_OMAC_11_1F	GENMASK(19, 5)
+#define MT_DBDC_CTRL0_MGMT		GENMASK(21, 20)
+#define MT_DBDC_CTRL0_WMM		GENMASK(25, 22)
+#define MT_DBDC_CTRL0_DBDC_EN		BIT(31)
+
+#define MT_DBDC_CTRL1			MT_WF_CFG(0x054)
+
 #define MT_WF_AGG_BASE			0x20a00
 #define MT_WF_AGG(ofs)			(MT_WF_AGG_BASE + (ofs))
 
-- 
2.24.0

