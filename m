Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67609D096F
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 10:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfJIIS1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 04:18:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51076 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJIIS1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 04:18:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D863561AF9; Wed,  9 Oct 2019 08:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570609105;
        bh=fRlz7tw4YQKX5yIPcojrc6u4Ge2rc8wPk0N36qvbVIM=;
        h=From:To:Cc:Subject:Date:From;
        b=CySRCJjlxGc4zn4Vv6VmXxuPkj4q45h4GwIgVkyi8uWOWjeQd6ZX04MKVGl5l27ij
         pTC0Axp8g/Z5EDkGJAc77yOj27TUALD06T9eD53QrATLI8KVc0ZwqV8qnq3HrJUJaH
         bkSb8CPi0lLCYLXIaQb6NNMiHnbeT/z05mkfUG4g=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from smtp.codeaurora.org (unknown [180.166.53.21])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: miaoqing@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 12DC361A1B;
        Wed,  9 Oct 2019 08:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570609104;
        bh=fRlz7tw4YQKX5yIPcojrc6u4Ge2rc8wPk0N36qvbVIM=;
        h=From:To:Cc:Subject:Date:From;
        b=jZyx0nBW3UFDv/+FquMqXvMlJC2B56+k5tD9YYAPrRt6uaVtZHDPaEFPtx3Hfyt7J
         Y6tvt8gihNnyg88VwAOvhbjZsjR412ux9gthPYTj1UQ/V0LE8gLx84ouuhE74p3JJc
         zmu0Z94HsHygEqw90bRYS33rFOexMdeMeKUQMsJQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12DC361A1B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=miaoqing@codeaurora.org
Received: by smtp.codeaurora.org (sSMTP sendmail emulation); Wed, 09 Oct 2019 16:18:17 +0800
From:   Miaoqing Pan <miaoqing@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Miaoqing Pan <miaoqing@codeaurora.org>
Subject: [PATCH 1/2] ath10k: fix array out-of-bounds access
Date:   Wed,  9 Oct 2019 16:18:08 +0800
Message-Id: <1570609089-22071-1-git-send-email-miaoqing@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If firmware reports rate_max > WMI_TPC_RATE_MAX(WMI_TPC_FINAL_RATE_MAX)
or num_tx_chain > WMI_TPC_TX_N_CHAIN, it will cause array out-of-bounds
access, so print a warning and reset to avoid memory corruption.

Tested HW: QCA9984
Tested FW: 10.4-3.9.0.2-00035

Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/debug.c |  2 +-
 drivers/net/wireless/ath/ath10k/wmi.c   | 49 +++++++++++++++++++++------------
 2 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index bd2b562..40baf25 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -1516,7 +1516,7 @@ static void ath10k_tpc_stats_print(struct ath10k_tpc_stats *tpc_stats,
 	*len += scnprintf(buf + *len, buf_len - *len,
 			  "No.  Preamble Rate_code ");
 
-	for (i = 0; i < WMI_TPC_TX_N_CHAIN; i++)
+	for (i = 0; i < tpc_stats->num_tx_chain; i++)
 		*len += scnprintf(buf + *len, buf_len - *len,
 				  "tpc_value%d ", i);
 
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index f0ab115..4473b13 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -4681,16 +4681,13 @@ static void ath10k_tpc_config_disp_tables(struct ath10k *ar,
 	}
 
 	pream_idx = 0;
-	for (i = 0; i < __le32_to_cpu(ev->rate_max); i++) {
+	for (i = 0; i < tpc_stats->rate_max; i++) {
 		memset(tpc_value, 0, sizeof(tpc_value));
 		memset(buff, 0, sizeof(buff));
 		if (i == pream_table[pream_idx])
 			pream_idx++;
 
-		for (j = 0; j < WMI_TPC_TX_N_CHAIN; j++) {
-			if (j >= __le32_to_cpu(ev->num_tx_chain))
-				break;
-
+		for (j = 0; j < tpc_stats->num_tx_chain; j++) {
 			tpc[j] = ath10k_tpc_config_get_rate(ar, ev, i, j + 1,
 							    rate_code[i],
 							    type);
@@ -4803,7 +4800,7 @@ void ath10k_wmi_tpc_config_get_rate_code(u8 *rate_code, u16 *pream_table,
 
 void ath10k_wmi_event_pdev_tpc_config(struct ath10k *ar, struct sk_buff *skb)
 {
-	u32 num_tx_chain;
+	u32 num_tx_chain, rate_max;
 	u8 rate_code[WMI_TPC_RATE_MAX];
 	u16 pream_table[WMI_TPC_PREAM_TABLE_MAX];
 	struct wmi_pdev_tpc_config_event *ev;
@@ -4819,6 +4816,13 @@ void ath10k_wmi_event_pdev_tpc_config(struct ath10k *ar, struct sk_buff *skb)
 		return;
 	}
 
+	rate_max = __le32_to_cpu(ev->rate_max);
+	if (rate_max > WMI_TPC_RATE_MAX) {
+		ath10k_warn(ar, "number of rate is %d greater than TPC configured rate %d\n",
+			    rate_max, WMI_TPC_RATE_MAX);
+		rate_max = WMI_TPC_RATE_MAX;
+	}
+
 	tpc_stats = kzalloc(sizeof(*tpc_stats), GFP_ATOMIC);
 	if (!tpc_stats)
 		return;
@@ -4835,8 +4839,8 @@ void ath10k_wmi_event_pdev_tpc_config(struct ath10k *ar, struct sk_buff *skb)
 		__le32_to_cpu(ev->twice_antenna_reduction);
 	tpc_stats->power_limit = __le32_to_cpu(ev->power_limit);
 	tpc_stats->twice_max_rd_power = __le32_to_cpu(ev->twice_max_rd_power);
-	tpc_stats->num_tx_chain = __le32_to_cpu(ev->num_tx_chain);
-	tpc_stats->rate_max = __le32_to_cpu(ev->rate_max);
+	tpc_stats->num_tx_chain = num_tx_chain;
+	tpc_stats->rate_max = rate_max;
 
 	ath10k_tpc_config_disp_tables(ar, ev, tpc_stats,
 				      rate_code, pream_table,
@@ -5031,16 +5035,13 @@ void ath10k_wmi_event_pdev_tpc_config(struct ath10k *ar, struct sk_buff *skb)
 	}
 
 	pream_idx = 0;
-	for (i = 0; i < __le32_to_cpu(ev->rate_max); i++) {
+	for (i = 0; i < tpc_stats->rate_max; i++) {
 		memset(tpc_value, 0, sizeof(tpc_value));
 		memset(buff, 0, sizeof(buff));
 		if (i == pream_table[pream_idx])
 			pream_idx++;
 
-		for (j = 0; j < WMI_TPC_TX_N_CHAIN; j++) {
-			if (j >= __le32_to_cpu(ev->num_tx_chain))
-				break;
-
+		for (j = 0; j < tpc_stats->num_tx_chain; j++) {
 			tpc[j] = ath10k_wmi_tpc_final_get_rate(ar, ev, i, j + 1,
 							       rate_code[i],
 							       type, pream_idx);
@@ -5056,7 +5057,7 @@ void ath10k_wmi_event_pdev_tpc_config(struct ath10k *ar, struct sk_buff *skb)
 
 void ath10k_wmi_event_tpc_final_table(struct ath10k *ar, struct sk_buff *skb)
 {
-	u32 num_tx_chain;
+	u32 num_tx_chain, rate_max;
 	u8 rate_code[WMI_TPC_FINAL_RATE_MAX];
 	u16 pream_table[WMI_TPC_PREAM_TABLE_MAX];
 	struct wmi_pdev_tpc_final_table_event *ev;
@@ -5064,12 +5065,24 @@ void ath10k_wmi_event_tpc_final_table(struct ath10k *ar, struct sk_buff *skb)
 
 	ev = (struct wmi_pdev_tpc_final_table_event *)skb->data;
 
+	num_tx_chain = __le32_to_cpu(ev->num_tx_chain);
+	if (num_tx_chain > WMI_TPC_TX_N_CHAIN) {
+		ath10k_warn(ar, "number of tx chain is %d greater than TPC final configured tx chain %d\n",
+			    num_tx_chain, WMI_TPC_TX_N_CHAIN);
+		return;
+	}
+
+	rate_max = __le32_to_cpu(ev->rate_max);
+	if (rate_max > WMI_TPC_FINAL_RATE_MAX) {
+		ath10k_warn(ar, "number of rate is %d greater than TPC final configured rate %d\n",
+			    rate_max, WMI_TPC_FINAL_RATE_MAX);
+		rate_max = WMI_TPC_FINAL_RATE_MAX;
+	}
+
 	tpc_stats = kzalloc(sizeof(*tpc_stats), GFP_ATOMIC);
 	if (!tpc_stats)
 		return;
 
-	num_tx_chain = __le32_to_cpu(ev->num_tx_chain);
-
 	ath10k_wmi_tpc_config_get_rate_code(rate_code, pream_table,
 					    num_tx_chain);
 
@@ -5082,8 +5095,8 @@ void ath10k_wmi_event_tpc_final_table(struct ath10k *ar, struct sk_buff *skb)
 		__le32_to_cpu(ev->twice_antenna_reduction);
 	tpc_stats->power_limit = __le32_to_cpu(ev->power_limit);
 	tpc_stats->twice_max_rd_power = __le32_to_cpu(ev->twice_max_rd_power);
-	tpc_stats->num_tx_chain = __le32_to_cpu(ev->num_tx_chain);
-	tpc_stats->rate_max = __le32_to_cpu(ev->rate_max);
+	tpc_stats->num_tx_chain = num_tx_chain;
+	tpc_stats->rate_max = rate_max;
 
 	ath10k_wmi_tpc_stats_final_disp_tables(ar, ev, tpc_stats,
 					       rate_code, pream_table,
-- 
1.9.1

