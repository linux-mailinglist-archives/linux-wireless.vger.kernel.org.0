Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E6C1B2FA0
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2020 20:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDUS5N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 14:57:13 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:18080 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725870AbgDUS5L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 14:57:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587495431; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=rLICmTBof8eKNqnysvQtRNeSf1lVpHeOKoMNOJQq6dA=; b=SjPXyMWj+9MTbqVT6lb8ksV370REGiG8E5rZzg/6EWBEoqXrXiAkL7b7RWsEn5SZaka+rWVE
 SWHmkOXGCNERf5TzEmr9l1lm/Flg5H4fyvQfrhlldPN60Dx8a7DYkO17LV88THTyy7eV+bug
 suLyZmlM9AhIU1h4b69qEBZS+x8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9f4207.7fe20035b6f8-smtp-out-n02;
 Tue, 21 Apr 2020 18:57:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 08B0EC433F2; Tue, 21 Apr 2020 18:57:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from che-swdbs-01.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 16DD7C433D2;
        Tue, 21 Apr 2020 18:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 16DD7C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkenna@codeaurora.org
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: [PATCH] ath10k: Fix the invalid tx/rx chainmask configuration
Date:   Wed, 22 Apr 2020 00:28:32 +0530
Message-Id: <1587495512-29813-1-git-send-email-mkenna@codeaurora.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The driver is allowing the invalid tx/rx chainmask configuration
(other than 1,3,7,15) set by the user. It causes the firmware
crash due to the invalid chainmask values.

Hence, reject the invalid chainmask values in the driver by not
sending the pdev set command to the firmware.

Tested hardware: QCA9888
Tested firmware: 10.4-3.10-00047

Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index a59a7a5..a9f91a1 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4529,17 +4529,18 @@ static int ath10k_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
 	return 0;
 }
 
-static void ath10k_check_chain_mask(struct ath10k *ar, u32 cm, const char *dbg)
+static bool ath10k_check_chain_mask(struct ath10k *ar, u32 cm, const char *dbg)
 {
 	/* It is not clear that allowing gaps in chainmask
 	 * is helpful.  Probably it will not do what user
 	 * is hoping for, so warn in that case.
 	 */
 	if (cm == 15 || cm == 7 || cm == 3 || cm == 1 || cm == 0)
-		return;
+		return true;
 
-	ath10k_warn(ar, "mac %s antenna chainmask may be invalid: 0x%x.  Suggested values: 15, 7, 3, 1 or 0.\n",
+	ath10k_warn(ar, "mac %s antenna chainmask is invalid: 0x%x.  Suggested values: 15, 7, 3, 1 or 0.\n",
 		    dbg, cm);
+	return false;
 }
 
 static int ath10k_mac_get_vht_cap_bf_sts(struct ath10k *ar)
@@ -4722,11 +4723,15 @@ static void ath10k_mac_setup_ht_vht_cap(struct ath10k *ar)
 static int __ath10k_set_antenna(struct ath10k *ar, u32 tx_ant, u32 rx_ant)
 {
 	int ret;
+	bool is_valid_tx_chain_mask, is_valid_rx_chain_mask;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
-	ath10k_check_chain_mask(ar, tx_ant, "tx");
-	ath10k_check_chain_mask(ar, rx_ant, "rx");
+	is_valid_tx_chain_mask = ath10k_check_chain_mask(ar, tx_ant, "tx");
+	is_valid_rx_chain_mask = ath10k_check_chain_mask(ar, rx_ant, "rx");
+
+	if (!is_valid_tx_chain_mask || !is_valid_rx_chain_mask)
+		return -EINVAL;
 
 	ar->cfg_tx_chainmask = tx_ant;
 	ar->cfg_rx_chainmask = rx_ant;
-- 
1.9.1
