Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893BB455949
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 11:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245711AbhKRKpN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 05:45:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:36642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244339AbhKRKpK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 05:45:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19F84613D0;
        Thu, 18 Nov 2021 10:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637232131;
        bh=GTzsWnWgXA4ksajmJgxtwvAbO73k0A+idtwpO7QRibY=;
        h=From:To:Cc:Subject:Date:From;
        b=qoMQT92qc8qqob23enXR7xfIGTR4SHxDGJ6PMHT9QV2Ey//mowynrKhFL92Cm+2Jx
         RCD35LS+C3dqMDn1iaqt79G+oJoIqAfTGiNjgayiR+tt08ziaopjy34qrn+tDo+kfg
         2oMXZDUPTNQX/bF7u7P4fJp4hRwldw0FnFWqFH5wuInZ7hMlEz16DiMdEy8NntETij
         y56Jm5uPESfcn3bpKnKwpWlvunyU0iPKHiLLKbI5ZBknTAg5b15NllyHbe1L7qL09f
         HVb9E/ajFWJFf8M+AuiG7Hn0ukVFfV/4uy4aTuiB66fCgqWfCpJg+I7U2Tv0RipBj5
         KShJElUE9z5Yg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: fix possible OOB issue in mt76_calculate_default_rate
Date:   Thu, 18 Nov 2021 11:42:06 +0100
Message-Id: <6ea38b50cf9d3d3ad36aa371c8c66da2dfa5fac6.1637232098.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Cap max offset value to ARRAY_SIZE(mt76_rates) - 1 in
mt76_calculate_default_rate routine in order to avoid possible Out Of
Bound accesses.

Fixes: 33920b2bf0483 ("mt76: add support for setting mcast rate")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 62807dc311c1..b0869ff86c49 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1494,7 +1494,6 @@ EXPORT_SYMBOL_GPL(mt76_init_queue);
 u16 mt76_calculate_default_rate(struct mt76_phy *phy, int rateidx)
 {
 	int offset = 0;
-	struct ieee80211_rate *rate;
 
 	if (phy->chandef.chan->band != NL80211_BAND_2GHZ)
 		offset = 4;
@@ -1503,9 +1502,11 @@ u16 mt76_calculate_default_rate(struct mt76_phy *phy, int rateidx)
 	if (rateidx < 0)
 		rateidx = 0;
 
-	rate = &mt76_rates[offset + rateidx];
+	rateidx += offset;
+	if (rateidx >= ARRAY_SIZE(mt76_rates))
+		rateidx = offset;
 
-	return rate->hw_value;
+	return mt76_rates[rateidx].hw_value;
 }
 EXPORT_SYMBOL_GPL(mt76_calculate_default_rate);
 
-- 
2.31.1

