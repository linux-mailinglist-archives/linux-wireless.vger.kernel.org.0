Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B471B322F9E
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Feb 2021 18:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhBWR33 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Feb 2021 12:29:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:47542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233005AbhBWR32 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Feb 2021 12:29:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8BC564E83;
        Tue, 23 Feb 2021 17:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614101327;
        bh=OTNMa3RnnY7THMRvveRfbTIS74jmKulc1mNDa42zAAE=;
        h=From:To:Cc:Subject:Date:From;
        b=dZaEdQf0AsaiU4HhLDGiOGMEsp/V73ADoHY9+7fKOaKS3vfjpVJj2i2zS3BbvG3GE
         TogMlM8E7rbaEPItT1qD14UOSkKZhMTfcTo0mlec6bsICFIn+2FaVrGV2YoHw1GuSy
         jjldj8n7zVA97mceG8m3HJYatwt5JMakw7sOnLSWQbmZWg/543gm6P4WpuScxsMl2v
         fAAsg7alK98YTK0NMr8mz6OnmJk7PpMicR5jYsgYtL76pi5AW5p5YQOIJIwgXgPG/B
         5ohnDcEOIgHaZDk5bQKpgMuRK0FtHjAmN7GoTMxR//15LcnKsLxQxcN0wv5tcV/QLi
         sEVcetl3Qd4aw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com
Subject: [PATCH] mt76: connac: fix kernel warning adding monitor interface
Date:   Tue, 23 Feb 2021 18:28:43 +0100
Message-Id: <b0224f7c7385b34346016fc32fe0e96db49a8543.1614101281.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following kernel warning adding a monitor interface in
mt76_connac_mcu_uni_add_dev routine.

[  507.984882] ------------[ cut here ]------------
[  507.989515] WARNING: CPU: 1 PID: 3017 at mt76_connac_mcu_uni_add_dev+0x178/0x190 [mt76_connac_lib]
[  508.059379] CPU: 1 PID: 3017 Comm: ifconfig Not tainted 5.4.98 #0
[  508.065461] Hardware name: MT7622_MT7531 RFB (DT)
[  508.070156] pstate: 80000005 (Nzcv daif -PAN -UAO)
[  508.074939] pc : mt76_connac_mcu_uni_add_dev+0x178/0x190 [mt76_connac_lib]
[  508.081806] lr : mt7921_eeprom_init+0x1288/0x1cb8 [mt7921e]
[  508.087367] sp : ffffffc013a33930
[  508.090671] x29: ffffffc013a33930 x28: ffffff801e628ac0
[  508.095973] x27: ffffff801c7f1200 x26: ffffff801c7eb008
[  508.101275] x25: ffffff801c7eaef0 x24: ffffff801d025610
[  508.106577] x23: ffffff801d022990 x22: ffffff801d024de8
[  508.111879] x21: ffffff801d0226a0 x20: ffffff801c7eaee8
[  508.117181] x19: ffffff801d0226a0 x18: 000000005d00b000
[  508.122482] x17: 00000000ffffffff x16: 0000000000000000
[  508.127785] x15: 0000000000000080 x14: ffffff801d704000
[  508.133087] x13: 0000000000000040 x12: 0000000000000002
[  508.138389] x11: 000000000000000c x10: 0000000000000000
[  508.143691] x9 : 0000000000000020 x8 : 0000000000000001
[  508.148992] x7 : 0000000000000000 x6 : 0000000000000000
[  508.154294] x5 : ffffff801c7eaee8 x4 : 0000000000000006
[  508.159596] x3 : 0000000000000001 x2 : 0000000000000000
[  508.164898] x1 : ffffff801c7eac08 x0 : ffffff801d0226a0
[  508.170200] Call trace:
[  508.172640]  mt76_connac_mcu_uni_add_dev+0x178/0x190 [mt76_connac_lib]
[  508.179159]  mt7921_eeprom_init+0x1288/0x1cb8 [mt7921e]
[  508.184394]  drv_add_interface+0x34/0x88 [mac80211]
[  508.189271]  ieee80211_add_virtual_monitor+0xe0/0xb48 [mac80211]
[  508.195277]  ieee80211_do_open+0x86c/0x918 [mac80211]
[  508.200328]  ieee80211_do_open+0x900/0x918 [mac80211]
[  508.205372]  __dev_open+0xcc/0x150
[  508.208763]  __dev_change_flags+0x134/0x198
[  508.212937]  dev_change_flags+0x20/0x60
[  508.216764]  devinet_ioctl+0x3e8/0x748
[  508.220503]  inet_ioctl+0x1e4/0x350
[  508.223983]  sock_do_ioctl+0x48/0x2a0
[  508.227635]  sock_ioctl+0x310/0x4f8
[  508.231116]  do_vfs_ioctl+0xa4/0xac0
[  508.234681]  ksys_ioctl+0x44/0x90
[  508.237985]  __arm64_sys_ioctl+0x1c/0x48
[  508.241901]  el0_svc_common.constprop.1+0x7c/0x100
[  508.246681]  el0_svc_handler+0x18/0x20
[  508.250421]  el0_svc+0x8/0x1c8
[  508.253465] ---[ end trace c7b90fee13d72c39 ]---
[  508.261278] ------------[ cut here ]------------

Fixes: d0e274af2f2e4 ("mt76: mt76_connac: create mcu library")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index fb0554cf1fad..b301fa35b390 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -949,6 +949,7 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_AP:
 		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_AP);
 		break;
-- 
2.29.2

