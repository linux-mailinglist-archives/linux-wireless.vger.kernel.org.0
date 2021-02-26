Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CD13261E2
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Feb 2021 12:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhBZLSQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Feb 2021 06:18:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230124AbhBZLSM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Feb 2021 06:18:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BBE964EBA;
        Fri, 26 Feb 2021 11:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614338252;
        bh=b3UuRimThtySXP0S16xTaIzHBNXT+8ZxJ1WAwJvTpHQ=;
        h=From:To:Cc:Subject:Date:From;
        b=FjrhKhNvCT22UockjFevlqjL1H+IMCVLkNJv9Ng4Gsum6/TTt0CR8RpmvN7qqI5ZC
         9hIXzT6grcU+mh42/dtWKpr9qAYPNrfJ+W0YNfDpfRJGVHcwqDxg1sbUUOaN9FiNQS
         oiOL1Xx2mD3shtOiN4i6zfGTlsSKcuki0uJFtNjawkLtY9xpp7GiwUPJC7ScpRjDTJ
         5Wg/NhwWRZRHRwnlcrsu6JwGRrvPmhifXqP9uNOY4O/BeFbnXe/dZQvnGjPjAuD+5A
         yE8ZYMb1+9rQUMzZ5sW8EW60I29+SzuIs/4AJaV9sXJWuNahteHlhPNVPR8eoN/O0H
         PxGSA72DiW71w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7921: check mcu returned values in mt7921_start
Date:   Fri, 26 Feb 2021 12:17:23 +0100
Message-Id: <0fe54e045204d54a9dbcb4325efc13d24938eeee.1614338015.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Properly check returned values from mcu utility routines in
mt7921_start.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index cdb474ff370a..409bae30b8d9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -173,22 +173,31 @@ static int mt7921_start(struct ieee80211_hw *hw)
 {
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	int err;
 
 	mt7921_mutex_acquire(dev);
 
-	mt76_connac_mcu_set_mac_enable(&dev->mt76, 0, true, false);
-	mt76_connac_mcu_set_channel_domain(phy->mt76);
+	err = mt76_connac_mcu_set_mac_enable(&dev->mt76, 0, true, false);
+	if (err)
+		goto out;
+
+	err = mt76_connac_mcu_set_channel_domain(phy->mt76);
+	if (err)
+		goto out;
+
+	err = mt7921_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
+	if (err)
+		goto out;
 
-	mt7921_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
 	mt7921_mac_reset_counters(phy);
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
 	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
 				     MT7921_WATCHDOG_TIME);
-
+out:
 	mt7921_mutex_release(dev);
 
-	return 0;
+	return err;
 }
 
 static void mt7921_stop(struct ieee80211_hw *hw)
-- 
2.29.2

