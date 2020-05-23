Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623041DF74B
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2020 14:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731308AbgEWMti (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 May 2020 08:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgEWMth (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 May 2020 08:49:37 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941BCC061A0E
        for <linux-wireless@vger.kernel.org>; Sat, 23 May 2020 05:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=9QJjL2l7ZFxUKwUP6aBbKYD7S3g0yFZOoUVulvyEesI=; b=mdPgz1MWwTLmLzkzfilrQiXMVe
        ipEVdddys12VkyolZPjMovyi13tDBxmbq6MjVH0QYOLYTGCWYIOKuK/JAvFXgC7hYPnznED5dx65S
        O0IBsWUJk3fJRTdFDKSiWLwbJMWoIuCSlQ05+kHzPZuyeowhjo/+baa3GkFiNB03JMNg=;
Received: from p5b206c3b.dip0.t-ipconnect.de ([91.32.108.59] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jcTao-0004Nz-Ld; Sat, 23 May 2020 14:49:34 +0200
Received: by maeck.lan (Postfix, from userid 501)
        id EABBE87919D6; Sat, 23 May 2020 14:49:17 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: fix wcid allocation issues
Date:   Sat, 23 May 2020 14:49:17 +0200
Message-Id: <20200523124917.79446-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt76 core uses ffs() to find the next free bit. This works well for 32 bit
architectures where BITS_PER_LONG is 32. ffs only checks 32 bit values, so
allocation fails on 64 bit architectures.
Additionally, the wcid mask array was too small in cases where the array
was not a multiple of BITS_PER_LONG.
Fix this by making the wcid mask array u32 instead and use DIV_ROUND_UP
for the size, just in case we ever bump it to a value that's not a multiple
of 32.

Reported-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h |  4 ++--
 drivers/net/wireless/mediatek/mt76/util.c | 12 ++++++------
 drivers/net/wireless/mediatek/mt76/util.h | 14 +++++++-------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 5c9195f59ae1..afb1ccf61b74 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -537,8 +537,8 @@ struct mt76_dev {
 	wait_queue_head_t tx_wait;
 	struct sk_buff_head status_list;
 
-	unsigned long wcid_mask[MT76_N_WCIDS / BITS_PER_LONG];
-	unsigned long wcid_phy_mask[MT76_N_WCIDS / BITS_PER_LONG];
+	u32 wcid_mask[DIV_ROUND_UP(MT76_N_WCIDS, 32)];
+	u32 wcid_phy_mask[DIV_ROUND_UP(MT76_N_WCIDS, 32)];
 
 	struct mt76_wcid global_wcid;
 	struct mt76_wcid __rcu *wcid[MT76_N_WCIDS];
diff --git a/drivers/net/wireless/mediatek/mt76/util.c b/drivers/net/wireless/mediatek/mt76/util.c
index 07cf71242d9e..ecde87465bf6 100644
--- a/drivers/net/wireless/mediatek/mt76/util.c
+++ b/drivers/net/wireless/mediatek/mt76/util.c
@@ -42,17 +42,17 @@ bool __mt76_poll_msec(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
 }
 EXPORT_SYMBOL_GPL(__mt76_poll_msec);
 
-int mt76_wcid_alloc(unsigned long *mask, int size)
+int mt76_wcid_alloc(u32 *mask, int size)
 {
 	int i, idx = 0, cur;
 
-	for (i = 0; i < DIV_ROUND_UP(size, BITS_PER_LONG); i++) {
+	for (i = 0; i < DIV_ROUND_UP(size, 32); i++) {
 		idx = ffs(~mask[i]);
 		if (!idx)
 			continue;
 
 		idx--;
-		cur = i * BITS_PER_LONG + idx;
+		cur = i * 32 + idx;
 		if (cur >= size)
 			break;
 
@@ -74,13 +74,13 @@ int mt76_get_min_avg_rssi(struct mt76_dev *dev, bool ext_phy)
 	rcu_read_lock();
 
 	for (i = 0; i < ARRAY_SIZE(dev->wcid_mask); i++) {
-		unsigned long mask = dev->wcid_mask[i];
-		unsigned long phy_mask = dev->wcid_phy_mask[i];
+		u32 mask = dev->wcid_mask[i];
+		u32 phy_mask = dev->wcid_phy_mask[i];
 
 		if (!mask)
 			continue;
 
-		for (j = i * BITS_PER_LONG; mask; j++, mask >>= 1, phy_mask >>= 1) {
+		for (j = i * 32; mask; j++, mask >>= 1, phy_mask >>= 1) {
 			if (!(mask & 1))
 				continue;
 
diff --git a/drivers/net/wireless/mediatek/mt76/util.h b/drivers/net/wireless/mediatek/mt76/util.h
index 48a71e7479e5..fd1a68820e0a 100644
--- a/drivers/net/wireless/mediatek/mt76/util.h
+++ b/drivers/net/wireless/mediatek/mt76/util.h
@@ -14,24 +14,24 @@
 #define MT76_INCR(_var, _size) \
 	(_var = (((_var) + 1) % (_size)))
 
-int mt76_wcid_alloc(unsigned long *mask, int size);
+int mt76_wcid_alloc(u32 *mask, int size);
 
 static inline bool
-mt76_wcid_mask_test(unsigned long *mask, int idx)
+mt76_wcid_mask_test(u32 *mask, int idx)
 {
-	return mask[idx / BITS_PER_LONG] & BIT(idx % BITS_PER_LONG);
+	return mask[idx / 32] & BIT(idx % 32);
 }
 
 static inline void
-mt76_wcid_mask_set(unsigned long *mask, int idx)
+mt76_wcid_mask_set(u32 *mask, int idx)
 {
-	mask[idx / BITS_PER_LONG] |= BIT(idx % BITS_PER_LONG);
+	mask[idx / 32] |= BIT(idx % 32);
 }
 
 static inline void
-mt76_wcid_mask_clear(unsigned long *mask, int idx)
+mt76_wcid_mask_clear(u32 *mask, int idx)
 {
-	mask[idx / BITS_PER_LONG] &= ~BIT(idx % BITS_PER_LONG);
+	mask[idx / 32] &= ~BIT(idx % 32);
 }
 
 static inline void
-- 
2.24.0

