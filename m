Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF5F2A02B4
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Oct 2020 11:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgJ3KUs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Oct 2020 06:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgJ3KUs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Oct 2020 06:20:48 -0400
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340CCC0613D7
        for <linux-wireless@vger.kernel.org>; Fri, 30 Oct 2020 03:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1604053245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FvizhSNK+uh+rIKRB7Bavqq6BcTSN6HK4548HqRc0Po=;
        b=gEPJy0lAFOYkk8eRrITLiEEG01hEFsg0oBaZvbUOA0uZyALlKGVQaDSsH71q58HVOavqee
        eLS8bgSbYC/Z8lMza1GT2bPlO0umo1PmhXGqlciismPT2EUz8rz6DLqsHgF5SjzqB1cZm+
        qPg0t6BMvyKiA+dIgdjV5H5I0qDmkMg=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] ath11k: Fix number of rules in filtered ETSI regdomain
Date:   Fri, 30 Oct 2020 11:19:40 +0100
Message-Id: <20201030101940.2387952-1-sven@narfation.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The ath11k code will try to insert wheather rader related limits when the
DFS region is set to ETSI. For this reason, it will add two more entries in
the array of reg_rules. But the 2.4.0.1 firmware is prefiltering the list
of reg rules it returns for 2.4GHz PHYs. They will then not contain the
list of 5GHz rules and thus no wheather radar band rules were inserted by
this code.

But the code didn't fix the n_reg_rules for this regulatory domain and PHY
when this happened. This resulted in a rejection by is_valid_rd because it
found rules which start and end at 0khz. This resulted in a splat like:

  Invalid regulatory domain detected
  ------------[ cut here ]------------
  WARNING: at backports-20200628-4.4.60-9a94b73e75/net/wireless/reg.c:3721
  [...]
  ath11k c000000.wifi1: failed to perform regd update : -22

The number of rules must therefore be saved after they were converted from
the ath11k format to the ieee80211_regdomain format and not before.

Tested with IPQ8074 WLAN.HK.2.4.0.1.r1-00019-QCAHKSWPL_SILICONZ-1

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 drivers/net/wireless/ath/ath11k/reg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index f6a1f0352989..26e7e75191c7 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -584,7 +584,6 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 	if (!tmp_regd)
 		goto ret;
 
-	tmp_regd->n_reg_rules = num_rules;
 	memcpy(tmp_regd->alpha2, reg_info->alpha2, REG_ALPHA2_LEN + 1);
 	memcpy(alpha2, reg_info->alpha2, REG_ALPHA2_LEN + 1);
 	alpha2[2] = '\0';
@@ -597,7 +596,7 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 	/* Update reg_rules[] below. Firmware is expected to
 	 * send these rules in order(2G rules first and then 5G)
 	 */
-	for (; i < tmp_regd->n_reg_rules; i++) {
+	for (; i < num_rules; i++) {
 		if (reg_info->num_2g_reg_rules &&
 		    (i < reg_info->num_2g_reg_rules)) {
 			reg_rule = reg_info->reg_rules_2g_ptr + i;
@@ -652,6 +651,8 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 			   flags);
 	}
 
+	tmp_regd->n_reg_rules = i;
+
 	if (intersect) {
 		default_regd = ab->default_regd[reg_info->phy_id];
 
-- 
2.28.0

