Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E61C096628
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 18:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbfHTQUp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 12:20:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbfHTQUo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 12:20:44 -0400
Received: from localhost.localdomain (unknown [151.66.62.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B68F22DD6;
        Tue, 20 Aug 2019 16:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566318044;
        bh=H5G6UKQkBFQgl0vJVDL8g573eISyQHuogp77cbpAZRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oU/CgOvGZgdyK609pDaMpCJtUUsTjVzqc8ZqgW8A/c4CaYJXSIZ451V27Q3vP0Wrc
         hL0sVKsSrD8eTdIOx0JK1y87hauAZipdll+4GfxvOtcEn0g844c4i+Mw6NBn6ZXyRQ
         d53cnfMwjh6ietjy+uuzs5wcIlq4MX5607WfzzqA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@codeaurora.org
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        koen.vandeputte@ncentric.com
Subject: [PATCH 1/4] ath9k: dyanck: introduce ath_dynack_set_timeout routine
Date:   Tue, 20 Aug 2019 18:20:19 +0200
Message-Id: <4d64a2f91fcb8dbadaad8fef2e693abde47e6b5c.1566317488.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1566317488.git.lorenzo@kernel.org>
References: <cover.1566317488.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce ath_dynack_set_timeout routine to configure slottime/ack/cts
timeouts and remove duplicated code

Tested-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/ath/ath9k/dynack.c | 37 ++++++++++++++-----------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/dynack.c b/drivers/net/wireless/ath/ath9k/dynack.c
index 1ccf20d8c160..c244dd15dce4 100644
--- a/drivers/net/wireless/ath/ath9k/dynack.c
+++ b/drivers/net/wireless/ath/ath9k/dynack.c
@@ -78,6 +78,24 @@ static inline bool ath_dynack_bssidmask(struct ath_hw *ah, const u8 *mac)
 	return true;
 }
 
+/**
+ * ath_dynack_set_timeout - configure timeouts/slottime registers
+ * @ah: ath hw
+ * @to: timeout value
+ *
+ */
+static void ath_dynack_set_timeout(struct ath_hw *ah, int to)
+{
+	struct ath_common *common = ath9k_hw_common(ah);
+	int slottime = (to - 3) / 2;
+
+	ath_dbg(common, DYNACK, "ACK timeout %u slottime %u\n",
+		to, slottime);
+	ath9k_hw_setslottime(ah, slottime);
+	ath9k_hw_set_ack_timeout(ah, to);
+	ath9k_hw_set_cts_timeout(ah, to);
+}
+
 /**
  * ath_dynack_compute_ackto - compute ACK timeout as the maximum STA timeout
  * @ah: ath hw
@@ -86,7 +104,6 @@ static inline bool ath_dynack_bssidmask(struct ath_hw *ah, const u8 *mac)
  */
 static void ath_dynack_compute_ackto(struct ath_hw *ah)
 {
-	struct ath_common *common = ath9k_hw_common(ah);
 	struct ath_dynack *da = &ah->dynack;
 	struct ath_node *an;
 	int to = 0;
@@ -96,15 +113,8 @@ static void ath_dynack_compute_ackto(struct ath_hw *ah)
 			to = an->ackto;
 
 	if (to && da->ackto != to) {
-		u32 slottime;
-
-		slottime = (to - 3) / 2;
+		ath_dynack_set_timeout(ah, to);
 		da->ackto = to;
-		ath_dbg(common, DYNACK, "ACK timeout %u slottime %u\n",
-			da->ackto, slottime);
-		ath9k_hw_setslottime(ah, slottime);
-		ath9k_hw_set_ack_timeout(ah, da->ackto);
-		ath9k_hw_set_cts_timeout(ah, da->ackto);
 	}
 }
 
@@ -198,10 +208,7 @@ void ath_dynack_sample_tx_ts(struct ath_hw *ah, struct sk_buff *skb,
 		    ieee80211_is_assoc_resp(hdr->frame_control) ||
 		    ieee80211_is_auth(hdr->frame_control)) {
 			ath_dbg(common, DYNACK, "late ack\n");
-
-			ath9k_hw_setslottime(ah, (LATEACK_TO - 3) / 2);
-			ath9k_hw_set_ack_timeout(ah, LATEACK_TO);
-			ath9k_hw_set_cts_timeout(ah, LATEACK_TO);
+			ath_dynack_set_timeout(ah, LATEACK_TO);
 			if (sta) {
 				struct ath_node *an;
 
@@ -340,9 +347,7 @@ void ath_dynack_reset(struct ath_hw *ah)
 	da->ack_rbf.h_rb = 0;
 
 	/* init acktimeout */
-	ath9k_hw_setslottime(ah, (ackto - 3) / 2);
-	ath9k_hw_set_ack_timeout(ah, ackto);
-	ath9k_hw_set_cts_timeout(ah, ackto);
+	ath_dynack_set_timeout(ah, ackto);
 }
 EXPORT_SYMBOL(ath_dynack_reset);
 
-- 
2.21.0

