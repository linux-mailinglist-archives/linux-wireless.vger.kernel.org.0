Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6509418E8C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Sep 2021 07:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhI0FBd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Sep 2021 01:01:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43976 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232526AbhI0FBb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Sep 2021 01:01:31 -0400
X-UUID: 1a3fbcf1d32b4d658691b7777f9e5915-20210927
X-UUID: 1a3fbcf1d32b4d658691b7777f9e5915-20210927
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1122861278; Mon, 27 Sep 2021 12:59:51 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 27 Sep 2021 12:59:50 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 27 Sep
 2021 12:59:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 27 Sep 2021 12:59:50 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7615: fix monitor mode tear down crash
Date:   Mon, 27 Sep 2021 12:59:49 +0800
Message-ID: <e99a03b5138f7bb3dfd08a260227a32645572db4.1632718372.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[  103.451600] CPU 3 Unable to handle kernel paging request at virtual address 00000003, epc == 8576591c, ra == 857659f0
[  103.462226] Oops[#1]:
[  103.464499] CPU: 3 PID: 9247 Comm: ifconfig Tainted: G        W         5.4.143 #0
[  103.472031] $ 0   : 00000000 00000001 83be3854 00000000
[  103.477239] $ 4   : 8102a374 8102a374 8102f0b0 00000200
[  103.482444] $ 8   : 0000002d 000001e4 64373765 5d206337
[  103.487647] $12   : 00000000 00000005 00000000 0006d1df
[  103.492853] $16   : 83be3848 853838a8 8743d600 00010000
[  103.498059] $20   : 00000000 00000000 8553dec0 0000007f
[  103.503266] $24   : 00000003 80382084
[  103.508472] $28   : 831d4000 831d5bc0 00000001 857659f0
[  103.513678] Hi    : 00000122
[  103.516543] Lo    : d1768000
[  103.519452] epc   : 8576591c mt7615_mcu_add_bss+0xd0/0x3c0 [mt7615_common]
[  103.526306] ra    : 857659f0 mt7615_mcu_add_bss+0x1a4/0x3c0 [mt7615_common]
[  103.533232] Status: 11007c03 KERNEL EXL IE
[  103.537402] Cause : 40800008 (ExcCode 02)
[  103.541389] BadVA : 00000003
[  103.544253] PrId  : 0001992f (MIPS 1004Kc)
[  103.797086] Call Trace:
[  103.799562] [<8576591c>] mt7615_mcu_add_bss+0xd0/0x3c0 [mt7615_common]
[  103.806082] [<85760a14>] mt7615_remove_interface+0x74/0x1e0 [mt7615_common]
[  103.813280] [<85603fcc>] drv_remove_interface+0x2c/0xa0 [mac80211]
[  103.819612] [<8561a8e4>] ieee80211_del_virtual_monitor.part.22+0x74/0xe8 [mac80211]
[  103.827410] [<8561b7f0>] ieee80211_do_stop+0x4a4/0x8a0 [mac80211]
[  103.833671] [<8561bc00>] ieee80211_stop+0x14/0x24 [mac80211]
[  103.839405] [<8045a328>] __dev_close_many+0x9c/0x10c
[  103.844364] [<80463de4>] __dev_change_flags+0x16c/0x1e4
[  103.849569] [<80463e84>] dev_change_flags+0x28/0x70
[  103.854440] [<80521e54>] devinet_ioctl+0x280/0x774
[  103.859222] [<80526248>] inet_ioctl+0xa4/0x1c8
[  103.863674] [<80436830>] sock_ioctl+0x2d8/0x4bc
[  103.868201] [<801adbb4>] do_vfs_ioctl+0xb8/0x7c0
[  103.872804] [<801ae30c>] ksys_ioctl+0x50/0xb4
[  103.877156] [<80014598>] syscall_common+0x34/0x58

Fixes: 04b8e65922f63 ("mt76: add mac80211 driver for MT7615 PCIe-based chipsets")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c    | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index a39776833efd..2ba730808f3b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -808,7 +808,8 @@ mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int band, int state)
 
 static int
 mt7615_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
-			 struct ieee80211_sta *sta, bool enable)
+			 struct ieee80211_sta *sta, struct mt7615_phy *phy,
+			 bool enable)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	u32 type = vif->p2p ? NETWORK_P2P : NETWORK_INFRA;
@@ -821,6 +822,7 @@ mt7615_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	switch (vif->type) {
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_MONITOR:
 		break;
 	case NL80211_IFTYPE_STATION:
 		/* TODO: enable BSS_INFO_UAPSD & BSS_INFO_PM */
@@ -840,14 +842,19 @@ mt7615_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	}
 
 	bss = (struct bss_info_basic *)tlv;
-	memcpy(bss->bssid, vif->bss_conf.bssid, ETH_ALEN);
-	bss->bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int);
 	bss->network_type = cpu_to_le32(type);
-	bss->dtim_period = vif->bss_conf.dtim_period;
 	bss->bmc_tx_wlan_idx = wlan_idx;
 	bss->wmm_idx = mvif->mt76.wmm_idx;
 	bss->active = enable;
 
+	if (vif->type != NL80211_IFTYPE_MONITOR) {
+		memcpy(bss->bssid, vif->bss_conf.bssid, ETH_ALEN);
+		bss->bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int);
+		bss->dtim_period = vif->bss_conf.dtim_period;
+	} else {
+		memcpy(bss->bssid, phy->mt76->macaddr, ETH_ALEN);
+	}
+
 	return 0;
 }
 
@@ -863,6 +870,7 @@ mt7615_mcu_bss_omac_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
 	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_OMAC, sizeof(*omac));
 
 	switch (vif->type) {
+	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_AP:
 		if (vif->p2p)
@@ -929,7 +937,7 @@ mt7615_mcu_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	if (enable)
 		mt7615_mcu_bss_omac_tlv(skb, vif);
 
-	mt7615_mcu_bss_basic_tlv(skb, vif, sta, enable);
+	mt7615_mcu_bss_basic_tlv(skb, vif, sta, phy, enable);
 
 	if (enable && mvif->mt76.omac_idx >= EXT_BSSID_START &&
 	    mvif->mt76.omac_idx < REPEATER_BSSID_START)
-- 
2.29.2

