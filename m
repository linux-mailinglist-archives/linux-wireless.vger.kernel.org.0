Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C08B1B921
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 16:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbfEMOxZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 10:53:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43730 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730696AbfEMOxZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 10:53:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9E84160878; Mon, 13 May 2019 14:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557759203;
        bh=6yDtsLs/LzIcXELg9rNEr50p4OfjLvaGJCnQ5xo9q1Q=;
        h=From:To:Cc:Subject:Date:From;
        b=bvUZj6y2LvdyxVUvxJvygSBymgy5PWpIzFn2YHcOGy5jT0zZz2E4E7/2NKD9bSDIt
         VZmKo7b3HqIcM+eVSKoFnMmdNzkeAx/3dTPFvxTdawIt/XmKIdkRQ+eozu0kWgR5lb
         tJAV4ufOhXIVL+DTwK3wzMIVqNITXU2NDhhiG9xo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from checstex0244823-lin.qca.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bpothuno@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E208760364;
        Mon, 13 May 2019 14:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557759203;
        bh=6yDtsLs/LzIcXELg9rNEr50p4OfjLvaGJCnQ5xo9q1Q=;
        h=From:To:Cc:Subject:Date:From;
        b=bvUZj6y2LvdyxVUvxJvygSBymgy5PWpIzFn2YHcOGy5jT0zZz2E4E7/2NKD9bSDIt
         VZmKo7b3HqIcM+eVSKoFnMmdNzkeAx/3dTPFvxTdawIt/XmKIdkRQ+eozu0kWgR5lb
         tJAV4ufOhXIVL+DTwK3wzMIVqNITXU2NDhhiG9xo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E208760364
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bpothuno@codeaurora.org
From:   Balaji Pothunoori <bpothuno@codeaurora.org>
To:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     Balaji Pothunoori <bpothuno@codeaurora.org>
Subject: [PATCH] ath10k: enabling tx stats support over pktlog
Date:   Mon, 13 May 2019 20:23:07 +0530
Message-Id: <1557759187-23910-1-git-send-email-bpothuno@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For QCA988X target, pktlog gives details of the tx bitrate
which is used in the driver for station info.

Enabling pktlog by default will cause more interrupts
in target to host CE pipe, which can impact more CPU usage
for targets ex:WCN3990 and also not required for all other
platforms (eg: WCN3990), for getting tx bitrate.

Enable pktlog only for QCA988X based on hardware params.

Tested HW : WCN3990
Tested FW : WLAN.HL.3.1-00784-QCAHLSWMTPLZ-1

Fixes: e8123bb74c4e ("ath10k: add per peer tx stats support for 10.2.4")
Signed-off-by: Balaji Pothunoori <bpothuno@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 15 +++++++++++++++
 drivers/net/wireless/ath/ath10k/hw.h   |  3 +++
 drivers/net/wireless/ath/ath10k/mac.c  |  3 ++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 61ef903..252e9af 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -83,6 +83,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = false,
+		.tx_stats_over_pktlog = true,
 	},
 	{
 		.id = QCA988X_HW_2_0_VERSION,
@@ -117,6 +118,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = false,
+		.tx_stats_over_pktlog = true,
 	},
 	{
 		.id = QCA9887_HW_1_0_VERSION,
@@ -152,6 +154,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = false,
+		.tx_stats_over_pktlog = false,
 	},
 	{
 		.id = QCA6174_HW_3_2_VERSION,
@@ -179,6 +182,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.ast_skid_limit = 0x10,
 		.num_wds_entries = 0x20,
 		.uart_pin_workaround = true,
+		.tx_stats_over_pktlog = false,
 	},
 	{
 		.id = QCA6174_HW_2_1_VERSION,
@@ -213,6 +217,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = false,
+		.tx_stats_over_pktlog = false,
 	},
 	{
 		.id = QCA6174_HW_2_1_VERSION,
@@ -247,6 +252,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = false,
+		.tx_stats_over_pktlog = false,
 	},
 	{
 		.id = QCA6174_HW_3_0_VERSION,
@@ -281,6 +287,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = false,
+		.tx_stats_over_pktlog = false,
 	},
 	{
 		.id = QCA6174_HW_3_2_VERSION,
@@ -318,6 +325,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = true,
+		.tx_stats_over_pktlog = false,
 	},
 	{
 		.id = QCA99X0_HW_2_0_DEV_VERSION,
@@ -358,6 +366,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = false,
+		.tx_stats_over_pktlog = false,
 	},
 	{
 		.id = QCA9984_HW_1_0_DEV_VERSION,
@@ -405,6 +414,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = false,
+		.tx_stats_over_pktlog = false,
 	},
 	{
 		.id = QCA9888_HW_2_0_DEV_VERSION,
@@ -449,6 +459,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = false,
+		.tx_stats_over_pktlog = false,
 	},
 	{
 		.id = QCA9377_HW_1_0_DEV_VERSION,
@@ -483,6 +494,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = false,
+		.tx_stats_over_pktlog = false,
 	},
 	{
 		.id = QCA9377_HW_1_1_DEV_VERSION,
@@ -519,6 +531,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = true,
+		.tx_stats_over_pktlog = false,
 	},
 	{
 		.id = QCA4019_HW_1_0_DEV_VERSION,
@@ -560,6 +573,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = false,
+		.tx_stats_over_pktlog = false,
 	},
 	{
 		.id = WCN3990_HW_1_0_DEV_VERSION,
@@ -587,6 +601,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.rri_on_ddr = true,
 		.hw_filter_reset_required = false,
 		.fw_diag_ce_download = false,
+		.tx_stats_over_pktlog = false,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 248cfb4..1e80beb 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -612,6 +612,9 @@ struct ath10k_hw_params {
 	 * firmware bug
 	 */
 	bool uart_pin_workaround;
+
+	/* tx stats support over pktlog */
+	bool tx_stats_over_pktlog;
 };
 
 struct htt_rx_desc;
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index b500fd4..40e7cea 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -7877,7 +7877,8 @@ ath10k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 				    arvif->vdev_id, ret);
 	}
 
-	if (ath10k_peer_stats_enabled(ar)) {
+	if (ath10k_peer_stats_enabled(ar) &&
+	    ar->hw_params.tx_stats_over_pktlog) {
 		ar->pktlog_filter |= ATH10K_PKTLOG_PEER_STATS;
 		ret = ath10k_wmi_pdev_pktlog_enable(ar,
 						    ar->pktlog_filter);
-- 
2.7.4

