Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE56F2243
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2019 00:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfKFXCL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Nov 2019 18:02:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:59518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfKFXCK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Nov 2019 18:02:10 -0500
Received: from localhost.localdomain.com (unknown [176.229.194.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5D1D2084C;
        Wed,  6 Nov 2019 23:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573081330;
        bh=LVPkkD29tDtXLsFtHtKN4gf9S/YAsYPK0cpOo8c2ED0=;
        h=From:To:Cc:Subject:Date:From;
        b=jZGFITUsM9+NJQrsaG7kxEvBSAX7X79ammwqJ4v0T156IyXzsZ4fDJft5WD9yVtwk
         rpDfQ3LfGL9I5YeiUbS2Z+hJpVphhs1Pp+PWH6PvBIRbdtiX6wfewWkBRRd38ywW4t
         PA0BEwfu0Po1QE8AZhHVRvKFUzy/mxy+3+Sb8gho=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: fix possible out-of-buond access in mt7615_fill_txs/mt7603_fill_txs
Date:   Thu,  7 Nov 2019 01:01:58 +0200
Message-Id: <e7c2b8b903ed344dd3103edbd57269cb1cdac8bb.1573080592.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix possible out-of-buond access of status rates array in
mt7615_fill_txs/mt7603_fill_txs routines

Fixes: c5211e997eca ("mt76: mt7603: rework and fix tx status reporting")
Fixes: 4af81f02b49c ("mt76: mt7615: sync with mt7603 rate control changes")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c | 4 +++-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 1497d5ec649e..812d081ad943 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1136,8 +1136,10 @@ mt7603_fill_txs(struct mt7603_dev *dev, struct mt7603_sta *sta,
 		if (idx && (cur_rate->idx != info->status.rates[i].idx ||
 			    cur_rate->flags != info->status.rates[i].flags)) {
 			i++;
-			if (i == ARRAY_SIZE(info->status.rates))
+			if (i == ARRAY_SIZE(info->status.rates)) {
+				i--;
 				break;
+			}
 
 			info->status.rates[i] = *cur_rate;
 			info->status.rates[i].count = 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 2b810ba359ae..c77adc5d2552 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1039,8 +1039,10 @@ static bool mt7615_fill_txs(struct mt7615_dev *dev, struct mt7615_sta *sta,
 		if (idx && (cur_rate->idx != info->status.rates[i].idx ||
 			    cur_rate->flags != info->status.rates[i].flags)) {
 			i++;
-			if (i == ARRAY_SIZE(info->status.rates))
+			if (i == ARRAY_SIZE(info->status.rates)) {
+				i--;
 				break;
+			}
 
 			info->status.rates[i] = *cur_rate;
 			info->status.rates[i].count = 0;
-- 
2.21.0

