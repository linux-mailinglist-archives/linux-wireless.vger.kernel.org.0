Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5333F3A8B1B
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 23:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhFOVd0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 17:33:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51909 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229689AbhFOVd0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 17:33:26 -0400
X-UUID: 19d598751580470d84a2b598ebaf3763-20210616
X-UUID: 19d598751580470d84a2b598ebaf3763-20210616
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1651506827; Wed, 16 Jun 2021 05:31:19 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Jun 2021 05:31:17 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Jun 2021 05:31:11 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <yenlinlai@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mt76: mt7921: fix kernel warning when reset on vif is not sta
Date:   Wed, 16 Jun 2021 05:31:10 +0800
Message-ID: <f2fd5eab61a26c43d668cfc06d943f7bf514db36.1623792576.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

ieee80211_disconnect is only called for the staton mode.

[  714.050429] WARNING: CPU: 1 PID: 382 at net/mac80211/mlme.c:2787
ieee80211_disconnect+0x108/0x118 [mac80211]
[  714.116704] Hardware name: MediaTek Asurada rev1 board (DT)
[  714.122303] Workqueue: mt76 mt7921_mac_reset_work [mt7921e]
[  714.127877] pstate: 20c00009 (nzCv daif +PAN +UAO)
[  714.132761] pc : ieee80211_disconnect+0x108/0x118 [mac80211]
[  714.138430] lr : mt7921_vif_connect_iter+0x28/0x54 [mt7921e]
[  714.144083] sp : ffffffc0107cbbd0
[  714.147394] x29: ffffffc0107cbbd0 x28: ffffffb26c9cb928
[  714.152706] x27: ffffffb26c9cbd98 x26: 0000000000000000
[  714.158017] x25: 0000000000000003 x24: ffffffb26c9c9c38
[  714.163328] x23: ffffffb26c9c9c38 x22: ffffffb26c9c8860
[  714.168639] x21: ffffffb23b940000 x20: ffffffb26c9c8860
[  714.173950] x19: 0000000000000001 x18: 000000000000b67e
[  714.179261] x17: 00000000064dd409 x16: ffffffd739cb28f0
[  714.184571] x15: 0000000000000000 x14: 0000000000000227
[  714.189881] x13: 0000000000000400 x12: ffffffd73a4eb060
[  714.195191] x11: 0000000000000000 x10: 0000000000000000
[  714.200502] x9 : ffffffd703a0a000 x8 : 0000000000000006
[  714.205812] x7 : 2828282828282828 x6 : ffffffb200440396
[  714.211122] x5 : 0000000000000000 x4 : 0000000000000004
[  714.216432] x3 : 0000000000000000 x2 : ffffffb23b940c90
[  714.221743] x1 : 0000000000000001 x0 : ffffffb23b940c90
[  714.227054] Call trace:
[  714.229594]  ieee80211_disconnect+0x108/0x118 [mac80211]
[  714.234913]  mt7921_vif_connect_iter+0x28/0x54 [mt7921e]
[  714.240313]  __iterate_interfaces+0xc4/0xdc [mac80211]
[  714.245541]  ieee80211_iterate_interfaces+0x4c/0x68 [mac80211]
[  714.251381]  mt7921_mac_reset_work+0x410/0x468 [mt7921e]
[  714.256696]  process_one_work+0x208/0x3c8
[  714.260706]  worker_thread+0x23c/0x3e8
[  714.264456]  kthread+0x140/0x17c
[  714.267685]  ret_from_fork+0x10/0x18

Fixes: 0c1ce9884607 ("mt76: mt7921: add wifi reset support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index fb4de73df701..0a2df295596a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1269,7 +1269,8 @@ mt7921_vif_connect_iter(void *priv, u8 *mac,
 	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
 	struct mt7921_dev *dev = mvif->phy->dev;
 
-	ieee80211_disconnect(vif, true);
+	if (vif->type == NL80211_IFTYPE_STATION)
+		ieee80211_disconnect(vif, true);
 
 	mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.wcid, true);
 	mt7921_mcu_set_tx(dev, vif);
-- 
2.25.1

