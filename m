Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1F03534F5
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Apr 2021 19:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbhDCRkJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Apr 2021 13:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236819AbhDCRkJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Apr 2021 13:40:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D1C56124C;
        Sat,  3 Apr 2021 17:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617471606;
        bh=S4dM6+RPKZXERZx50L1tMJIGxsk27JygKtyfxh/aVAc=;
        h=From:To:Cc:Subject:Date:From;
        b=W2o6jCal5Z/Amau22F71QnzZiO5L3kPJ9DmU+MnVySkaCNi3Rpo6wo9pyelagLiMr
         rlQ8MJuPhBWP0MeK+5ezpHnaGOsEjLtM4H/e7/v6cTmvbu8mHeE+/s5ABWyy0v3gIS
         ih/hKgicKmPAUmkBdtsAWL3xiTGVySAbpbHHJuyXjDPrhvpXf9eNW5XRPrnxaRRqNK
         igVxhhkAhHrOV1Wxj91OD/57W72aD6cQbrYo4G1esh39TeBimojjGl5I6s09xnjskD
         Uk7RMKCulxAcxUPD+jIazVNDc3OPcDPxEo6wgsiO0RmBp7V6NvU5prW8Qhmq5NnBIz
         SiRmw1BzVx8eQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: mt7615: always wake the device in mt7615_remove_interface
Date:   Sat,  3 Apr 2021 19:39:58 +0200
Message-Id: <aec7c9b0d76fda57703eaa11d35542060dfff60c.1617471501.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to mt7921 driver, make sure the mcu is not in sleep mode before
sending mcu messages in mt7615_remove_interface routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 740c9a45e21b..57567e35f71d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -257,11 +257,11 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 	int idx = msta->wcid.idx;
 
+	mt7615_mutex_acquire(dev);
+
 	mt7615_mcu_add_bss_info(phy, vif, NULL, false);
 	mt7615_mcu_sta_add(phy, vif, NULL, false);
 
-	mt7615_mutex_acquire(dev);
-
 	mt76_testmode_reset(phy->mt76, true);
 	if (vif == phy->monitor_vif)
 	    phy->monitor_vif = NULL;
-- 
2.30.2

