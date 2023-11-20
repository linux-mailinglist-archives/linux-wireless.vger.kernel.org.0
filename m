Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685587F116C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Nov 2023 12:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjKTLMh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 06:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjKTLMe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 06:12:34 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C11A0
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 03:12:23 -0800 (PST)
X-UUID: aa849b50879511eea33bb35ae8d461a2-20231120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OV8s5wCvnPXepXNDZfhDStlrcZJfc8V8KOxPfWMOlBQ=;
        b=h/ZU3OKUoEC8r6eZLyQdYAmyeCBSHKtZC9r8A/Ch3aXqAhF3Vmep7p+qGHc7uvPIufyZS9woqViHJCotbT2zDQRrFzAV5SObRjYSC7DMTu0XAf+rxM8SKmGiRzPgUemE3hFII5dYVUK44TiCLwGc3HphpctLO381hPXaupyhFE4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:596d4f74-aa05-41b8-8ad2-14e77a2bbe98,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:3984db72-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: aa849b50879511eea33bb35ae8d461a2-20231120
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <mingyen.hsieh@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 611086345; Mon, 20 Nov 2023 19:12:17 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 20 Nov 2023 19:12:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 20 Nov 2023 19:12:15 +0800
From:   Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo@kernel.org>
CC:     <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
        <Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>,
        <Ryder.Lee@mediatek.com>, <Shayne.Chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH 3/3] wifi: mt76: mt7921: fix wrong 6Ghz power type
Date:   Mon, 20 Nov 2023 19:12:12 +0800
Message-ID: <20231120111212.4478-4-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231120111212.4478-1-mingyen.hsieh@mediatek.com>
References: <20231120111212.4478-1-mingyen.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.369800-8.000000
X-TMASE-MatchedRID: wYuucKnWdZKg1DExZSWfTbMsPmSZxbpkKx5ICGp/WtEJ3+GAlbGRqAqu
        sGnv+h2ZtYR/uNxnStF+dfwnt/TnE4UAIpgcoJ8i4pdq9sdj8LVYN1akkye0qPNhzIgXtFJVgSk
        lFxt6Wp2H28JBgchGjm9GkFdCqJAxP7LjmHZ8wWoSEYfcJF0pRf+UEb65dgmQ6T1ArrMwNVo24Y
        TX/Id5m+LzNWBegCW2wgn7iDBesS3CttcwYNipX/oJlcuVXWZJ7jyjm1f34QZJ6hNgdZiMhcGwO
        w4TdvP2jibUVL84QmPfrB7j8MNpHdTADK205/2/CrWTGf5pYzFTvu037c9oG2HPe5i7P4xgdmtR
        sRmKkASJZPT2ZDPuzPD2QfzMDLjho65UufHcDvg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.369800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: BF0AABC720A9DE1C6F18CD7511A24874FD237868D08DC61C8EAE41FE2093A96B2000:8
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

To avoid using incorrect 6g power settings after disconnection,
it should to update back to the default state when disconnected.

Fixes: 51ba0e3a15eb ("wifi: mt76: mt7921: add 6GHz power type support for clc")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 38 +++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 510a575a973b..0645417e0582 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -683,17 +683,45 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 }
 
 static void
-mt7921_regd_set_6ghz_power_type(struct ieee80211_vif *vif)
+mt7921_calc_vif_num(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	u32 *num = priv;
+
+	if (!priv)
+		return;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_P2P_CLIENT:
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+		*num += 1;
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+mt7921_regd_set_6ghz_power_type(struct ieee80211_vif *vif, bool is_add)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_phy *phy = mvif->phy;
 	struct mt792x_dev *dev = phy->dev;
+	u32 valid_vif_num = 0;
+
+	ieee80211_iterate_active_interfaces(mt76_hw(dev),
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7921_calc_vif_num, &valid_vif_num);
 
-	if (hweight64(dev->mt76.vif_mask) > 1) {
+	if (valid_vif_num > 1) {
 		phy->power_type = MT_AP_DEFAULT;
 		goto out;
 	}
 
+	if (!is_add)
+		vif->bss_conf.power_type = IEEE80211_REG_UNSET_AP;
+
 	switch (vif->bss_conf.power_type) {
 	case IEEE80211_REG_SP_AP:
 		phy->power_type = MT_AP_SP;
@@ -705,6 +733,8 @@ mt7921_regd_set_6ghz_power_type(struct ieee80211_vif *vif)
 		phy->power_type = MT_AP_LPI;
 		break;
 	case IEEE80211_REG_UNSET_AP:
+		phy->power_type = MT_AP_UNSET;
+		break;
 	default:
 		phy->power_type = MT_AP_DEFAULT;
 		break;
@@ -749,7 +779,7 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (ret)
 		return ret;
 
-	mt7921_regd_set_6ghz_power_type(vif);
+	mt7921_regd_set_6ghz_power_type(vif, true);
 
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 
@@ -811,6 +841,8 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		list_del_init(&msta->wcid.poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
+	mt7921_regd_set_6ghz_power_type(vif, false);
+
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 }
 EXPORT_SYMBOL_GPL(mt7921_mac_sta_remove);
-- 
2.18.0

