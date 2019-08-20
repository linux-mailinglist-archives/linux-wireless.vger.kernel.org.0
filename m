Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAFE09662C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 18:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfHTQUx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 12:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbfHTQUx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 12:20:53 -0400
Received: from localhost.localdomain (unknown [151.66.62.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BB1022DD6;
        Tue, 20 Aug 2019 16:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566318052;
        bh=tXKYT723szjHBi1g/o3QzxNt71lwc6D06BrdlXFob9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zaPRUuok7ljOdwyblon0pAdC0VSJ7ZKO87ixeOrL39zvBTuzhsah2LaJ2NHdF6BQb
         EuqUmJgB1/ke/tRGb5fe3p0bgWlIqRwpIhf7bPN4g9mmuLlHygNd8EVA94mjdYwcaB
         ivgBlHXUnGs0CtRmIB6kX24GKaU/JoDjfBkZIupg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@codeaurora.org
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        koen.vandeputte@ncentric.com
Subject: [PATCH 4/4] ath9k: dynack: set ackto to max timeout in ath_dynack_reset
Date:   Tue, 20 Aug 2019 18:20:22 +0200
Message-Id: <b54ba74c2a4d44aad625809d737c9332715afb2e.1566317488.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1566317488.git.lorenzo@kernel.org>
References: <cover.1566317488.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Initialize acktimeout to the maximum configurable value in
ath_dynack_reset in order to not disconnect long distance static links
enabling dynack and even to take care of possible errors configuring
a static timeout. Moreover initialize station timeout value to the current
acktimeout value

Tested-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/ath/ath9k/dynack.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/dynack.c b/drivers/net/wireless/ath/ath9k/dynack.c
index f5acaa577d62..fbeb4a739d32 100644
--- a/drivers/net/wireless/ath/ath9k/dynack.c
+++ b/drivers/net/wireless/ath/ath9k/dynack.c
@@ -321,11 +321,9 @@ EXPORT_SYMBOL(ath_dynack_sample_ack_ts);
  */
 void ath_dynack_node_init(struct ath_hw *ah, struct ath_node *an)
 {
-	/* ackto = slottime + sifs + air delay */
-	u32 ackto = 9 + 16 + 64;
 	struct ath_dynack *da = &ah->dynack;
 
-	an->ackto = ackto;
+	an->ackto = da->ackto;
 
 	spin_lock_bh(&da->qlock);
 	list_add_tail(&an->list, &da->nodes);
@@ -356,20 +354,26 @@ EXPORT_SYMBOL(ath_dynack_node_deinit);
  */
 void ath_dynack_reset(struct ath_hw *ah)
 {
-	/* ackto = slottime + sifs + air delay */
-	u32 ackto = 9 + 16 + 64;
 	struct ath_dynack *da = &ah->dynack;
+	struct ath_node *an;
+
+	spin_lock_bh(&da->qlock);
 
 	da->lto = jiffies + COMPUTE_TO;
-	da->ackto = ackto;
 
 	da->st_rbf.t_rb = 0;
 	da->st_rbf.h_rb = 0;
 	da->ack_rbf.t_rb = 0;
 	da->ack_rbf.h_rb = 0;
 
+	da->ackto = ath_dynack_get_max_to(ah);
+	list_for_each_entry(an, &da->nodes, list)
+		an->ackto = da->ackto;
+
 	/* init acktimeout */
-	ath_dynack_set_timeout(ah, ackto);
+	ath_dynack_set_timeout(ah, da->ackto);
+
+	spin_unlock_bh(&da->qlock);
 }
 EXPORT_SYMBOL(ath_dynack_reset);
 
@@ -386,6 +390,8 @@ void ath_dynack_init(struct ath_hw *ah)
 
 	spin_lock_init(&da->qlock);
 	INIT_LIST_HEAD(&da->nodes);
+	/* ackto = slottime + sifs + air delay */
+	da->ackto = 9 + 16 + 64;
 
 	ah->hw->wiphy->features |= NL80211_FEATURE_ACKTO_ESTIMATION;
 }
-- 
2.21.0

