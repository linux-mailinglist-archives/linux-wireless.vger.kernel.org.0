Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EE92CF799
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Dec 2020 00:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgLDXhy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Dec 2020 18:37:54 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:51671 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726111AbgLDXhy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Dec 2020 18:37:54 -0500
X-UUID: dbcf439a5eb94733840aadda579dcfb0-20201205
X-UUID: dbcf439a5eb94733840aadda579dcfb0-20201205
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1608178693; Sat, 05 Dec 2020 07:37:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Dec 2020 07:37:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Dec 2020 07:37:16 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 1/2] mt76: mt7915: add vif check in mt7915_update_vif_beacon()
Date:   Sat, 5 Dec 2020 07:37:14 +0800
Message-ID: <65336148b5d440dceb967a401488b119e14b9c5a.1607124652.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To avoid the warn_on() calltrace in station mode.

[ 4522.024382]  ieee80211_tx_dequeue+0x1258/0x1298 [mac80211]
[ 4522.029868]  ieee80211_beacon_get_template+0x10/0x18 [mac80211]
[ 4522.035780]  mt7915_mcu_add_beacon+0x2c/0x208 [mt7915e]
[ 4522.040997]  mt7915_mcu_get_rx_rate+0x304/0x878 [mt7915e]
[ 4522.046394]  ieee80211_delayed_tailroom_dec+0x158/0x180 [mac80211]
[ 4522.052573]  ieee80211_iterate_interfaces+0x48/0x68 [mac80211]
[ 4522.058398]  mt7915_mac_reset_work+0x3b4/0x630 [mt7915e]
[ 4522.063704]  process_one_work+0x1fc/0x390
[ 4522.067703]  worker_thread+0x48/0x4d0
[ 4522.071356]  kthread+0x120/0x128

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
change since v2: add default:
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index a7fa6fffffff..7f08c88d3282 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1407,7 +1407,15 @@ mt7915_update_vif_beacon(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
 	struct ieee80211_hw *hw = priv;
 
-	mt7915_mcu_add_beacon(hw, vif, vif->bss_conf.enable_beacon);
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_ADHOC:
+	case NL80211_IFTYPE_AP:
+		mt7915_mcu_add_beacon(hw, vif, vif->bss_conf.enable_beacon);
+		break;
+	default:
+		break;
+	}
 }
 
 static void
-- 
2.18.0

