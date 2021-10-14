Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A1E42DDF6
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Oct 2021 17:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhJNPWJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Oct 2021 11:22:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbhJNPWI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Oct 2021 11:22:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14310610D2;
        Thu, 14 Oct 2021 15:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634224803;
        bh=VYCqIVUVVUsMWzox1bqZVOyNnSKlvQ1a176ODCqXzGU=;
        h=From:To:Cc:Subject:Date:From;
        b=XS+XIa7xbINOL/CylHsEJXYkA9NwZHA4pll5txHXbD+BivBgeZqlJAWrPctwAZ7bp
         sIuJwb+FA3OInWdMQBvcu1ncOl06d1RMSdie9kRPaxG5pTt74v5bCg9unxf81DnvwA
         mNQ9ZjPVQGL0OZOqgmfDscJ0D1Koa6NZ7T0XhF0QUSJD9uQXGAKKsndxnIZ4XnLwrU
         QETVYMZioOGLWK0W6eEXgTjcqWv+IpNjBjjI/4GNWssncqawIhf4vr1KsaiJFOWQVc
         oJEXL972tswMmHWZSBkZpOy4v3/sV8GmXBplUxZAhrWDI7jY2vnl+uZR7D8eMP2so/
         TxEG3rIv3tOKQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: connac: fix possible NULL pointer dereference in mt76_connac_get_phy_mode_v2
Date:   Thu, 14 Oct 2021 17:19:53 +0200
Message-Id: <f8ee5ce0e8f016e235828df2157963e76c6459a1.1634224710.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following NULL pointer dereference in mt76_connac_get_phy_mode_v2
routine triggered on mt7663s device when sta is NULL

[    5.490700] mt7663s mmc0:0001:1: N9 Firmware Version: 3.1.1, Build Time: 20200604161656
[    5.490815] mt7663s mmc0:0001:1: Region number: 0x4
[    5.490868] mt7663s mmc0:0001:1: Parsing tailer Region: 0
[    5.496251] mt7663s mmc0:0001:1: Region 0, override_addr = 0x00118000
[    5.496419] mt7663s mmc0:0001:1: Parsing tailer Region: 1
[    5.624027] mt7663s mmc0:0001:1: Parsing tailer Region: 2
[    5.656999] mt7663s mmc0:0001:1: Parsing tailer Region: 3
[    5.671876] mt7663s mmc0:0001:1: override_addr = 0x00118000, option = 3
[    9.358658] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    9.358775] #PF: supervisor read access in kernel mode
[    9.358831] #PF: error_code(0x0000) - not-present page
[    9.358886] PGD 0 P4D 0
[    9.358917] Oops: 0000 [#1] SMP
[    9.358960] CPU: 0 PID: 235 Comm: NetworkManager Not tainted 5.15.0-rc4-kvm-02151-g39e333d657f4-dirty #769
[    9.359057] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-4.fc34 04/01/2014
[    9.359150] RIP: 0010:mt76_connac_get_phy_mode_v2+0xc9/0x11c
[    9.359473] RAX: 0000000000000013 RBX: 0000000000000000 RCX: 0000000000000027
[    9.359546] RDX: ffff8881f9c17358 RSI: 0000000000000001 RDI: ffff8881f9c17350
[    9.359624] RBP: ffff88810bac1ed4 R08: ffffffff822a4a48 R09: 0000000000000003
[    9.359697] R10: ffffffff82234a60 R11: ffffffff82234a60 R12: ffff88810bac1eec
[    9.359779] R13: 0000000000000000 R14: ffff88810bad1648 R15: ffff88810bac1eb8
[    9.359859] FS:  00007f5f1e45bbc0(0000) GS:ffff8881f9c00000(0000) knlGS:0000000000000000
[    9.359939] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.360003] CR2: 0000000000000000 CR3: 0000000105d5d000 CR4: 00000000000006b0
[    9.360083] Call Trace:
[    9.360116]  mt76_connac_mcu_uni_add_bss.cold+0x21/0x250
[    9.360175]  ? schedule_preempt_disabled+0xa/0x10
[    9.360232]  ? __mutex_lock.constprop.0+0x2ab/0x460
[    9.360286]  mt7615_remove_interface+0x63/0x1d0
[    9.360342]  drv_remove_interface+0x32/0xe0
[    9.360385]  ieee80211_do_stop+0x5da/0x800
[    9.360428]  ? dev_reset_queue+0x30/0x90
[    9.360472]  ieee80211_stop+0x3b/0xb0
[    9.360516]  __dev_close_many+0x7a/0xd0
[    9.360559]  __dev_change_flags+0xd6/0x1f0
[    9.360604]  dev_change_flags+0x21/0x60
[    9.360648]  do_setlink+0x259/0xfb0
[    9.360686]  ? __nla_validate_parse+0x51/0xb80
[    9.360742]  __rtnl_newlink+0x5b3/0x960
[    9.360785]  ? inet6_fill_ifla6_attrs+0x41d/0x470
[    9.360841]  ? __kmalloc_track_caller+0x57/0x3c0
[    9.360905]  ? netlink_trim+0x8a/0xb0
[    9.360949]  ? skb_queue_tail+0x1b/0x50

Fixes: 67aa27431c7f8 ("mt76: mt7921: rely on mt76_connac_mcu common library")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index c569e320f843..9a1af2ba7e8e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -706,7 +706,7 @@ mt76_connac_get_phy_mode_v2(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 		if (ht_cap->ht_supported)
 			mode |= PHY_TYPE_BIT_HT;
 
-		if (he_cap->has_he)
+		if (he_cap && he_cap->has_he)
 			mode |= PHY_TYPE_BIT_HE;
 	} else if (band == NL80211_BAND_5GHZ || band == NL80211_BAND_6GHZ) {
 		mode |= PHY_TYPE_BIT_OFDM;
@@ -717,7 +717,7 @@ mt76_connac_get_phy_mode_v2(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 		if (vht_cap->vht_supported)
 			mode |= PHY_TYPE_BIT_VHT;
 
-		if (he_cap->has_he)
+		if (he_cap && he_cap->has_he)
 			mode |= PHY_TYPE_BIT_HE;
 	}
 
-- 
2.31.1

