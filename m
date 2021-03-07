Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECAD330384
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Mar 2021 19:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhCGR7j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 7 Mar 2021 12:59:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:59968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232065AbhCGR7O (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 7 Mar 2021 12:59:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26A5F650F5;
        Sun,  7 Mar 2021 17:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615139954;
        bh=pkUXhAepp54hgcKyVXZ/4o7VGcce5SlP3XWGz0JIr7s=;
        h=From:To:Cc:Subject:Date:From;
        b=EgRL+h1B1zhIbQ9kIa3vg8Z3R/ByoGXXbVmltRzoCepE8Jj835RxwKRpDMo1EFDby
         sp4xH8LAwMbwJbedB7DVWYvscAKeBznVBt+7DV4yjuYAnQLjr1sv046CXgI6EE/Lvq
         nd68o+ofj03k/QLJdY8HpPYXhdC0n5iBIxY8QDc0bEV3RcN+fes6WwhD4RRWzePBMo
         TVbfoZIcSkgVd2SVTMJDwgt0v4kQXirhbKZ2wYsw6PpIBy83tLWQ7fLJ4Z21Y5sIep
         +TNTVzq2kZ/dcsS+OcAijRi9fy6UKbAFNxxbFNtqSSCUYI1HTFp3fEABL5cTLO/Tl1
         s/i9A2HPQgWeg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: mt7915: simplify mt7915_mac_sta_poll routine
Date:   Sun,  7 Mar 2021 18:59:08 +0100
Message-Id: <db48916a553fee715fc9c0c1f83f363a01218dff.1615139832.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Drop unnecessary lock around sta_poll_list list in mt7915_mac_sta_poll
routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index b3168dd3baed..cde98b86e2bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -117,23 +117,15 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 
 	rcu_read_lock();
 
-	while (true) {
+	while (!list_empty(&sta_poll_list)) {
 		bool clear = false;
 		u32 addr;
-		u16 idx;
 
-		spin_lock_bh(&dev->sta_poll_lock);
-		if (list_empty(&sta_poll_list)) {
-			spin_unlock_bh(&dev->sta_poll_lock);
-			break;
-		}
 		msta = list_first_entry(&sta_poll_list,
 					struct mt7915_sta, poll_list);
 		list_del_init(&msta->poll_list);
-		spin_unlock_bh(&dev->sta_poll_lock);
 
-		idx = msta->wcid.idx;
-		addr = mt7915_mac_wtbl_lmac_addr(dev, idx) + 20 * 4;
+		addr = mt7915_mac_wtbl_lmac_addr(dev, msta->wcid.idx) + 20 * 4;
 
 		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 			u32 tx_last = msta->airtime_ac[i];
@@ -152,7 +144,7 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 		}
 
 		if (clear) {
-			mt7915_mac_wtbl_update(dev, idx,
+			mt7915_mac_wtbl_update(dev, msta->wcid.idx,
 					       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 			memset(msta->airtime_ac, 0, sizeof(msta->airtime_ac));
 		}
-- 
2.29.2

