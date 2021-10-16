Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218674301EE
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Oct 2021 12:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbhJPKYn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Oct 2021 06:24:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232450AbhJPKYm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Oct 2021 06:24:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7702360F11;
        Sat, 16 Oct 2021 10:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634379754;
        bh=3AKYeeLaRO1PCI7ZLk5LsPqfsYpKiDoI8Hkn1KpQNM8=;
        h=From:To:Cc:Subject:Date:From;
        b=scKaX4BNUjPOb4Dbx2RvASMhuKqrmQuIlZuQY1mfO/35vXfqlCE70g44J/Acugtxl
         tY70Uhp8aq9IMQjUowi6g0e73QY9NIRAv3/1yPC6eRuM2TRS/S/RrgtsYetApWUNUJ
         wUdnGpDuQp6TFXvU89qlbiDkUDwORpD7SNfsQHRuGtYHMhLm/yIScGZT23C/EmOb5L
         7oOGS/52o+aOJBfGVYkCWkFl+1d1GmxRms973YuWfcwHH+4x+ErtAhZhWCd+I6A2vz
         s9VHySOdZCoxu7EDudO3G5vmw+3cfsgfJUK1reDY2CTuZNmYCAMRD0TWA6WOmiWSzA
         SeGzv7CAkCD2Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: get rid of unused variable in mt7921_mac_tx_free
Date:   Sat, 16 Oct 2021 12:22:24 +0200
Message-Id: <31b0fee56b0ce1b009b637522197b81b4b269e9a.1634379664.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove unused phy variable in mt7921_mac_tx_free routine

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index ae67e93524c2..0659ff290af9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1119,7 +1119,6 @@ mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
 		 */
 		if (info & MT_TX_FREE_PAIR) {
 			struct mt7921_sta *msta;
-			struct mt7921_phy *phy;
 			struct mt76_wcid *wcid;
 			u16 idx;
 
@@ -1131,7 +1130,6 @@ mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
 				continue;
 
 			msta = container_of(wcid, struct mt7921_sta, wcid);
-			phy = msta->vif->phy;
 			spin_lock_bh(&dev->sta_poll_lock);
 			if (list_empty(&msta->poll_list))
 				list_add_tail(&msta->poll_list, &dev->sta_poll_list);
-- 
2.31.1

