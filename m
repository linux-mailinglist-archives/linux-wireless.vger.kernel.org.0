Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F4E53E969
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jun 2022 19:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbiFFOaL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jun 2022 10:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239965AbiFFOaD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jun 2022 10:30:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F74CBD5D
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jun 2022 07:30:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95060612EA
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jun 2022 14:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8ECC34115;
        Mon,  6 Jun 2022 14:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654525801;
        bh=VEF+MQRX98WvINQNg+niiWNVO20KoeMb8rtD/9lTfAU=;
        h=From:To:Cc:Subject:Date:From;
        b=B4LCmeNXDWs8dx0w/3VahN6gidQ/+bosU6mKZs+OmA4FMjuYtRNWn9S/2NojlMb/j
         0t8Huf0m8hZIHxMf3y6Qvdrx2+WirLMIJkm1+G9a2/PxHOwlx+GRRS3aGgEjRud0q5
         FJky3VsiJhMTJgNU/YdmNSoMMvXzOIVdfSjCCwsukDOyqkbjIFiAjBFzH59tvNbDpw
         MIUqZlQXNVv3hjrD7Ib9YuVcdE7jl8HjtbsBdcNXyGsx9Yxna5SCHhbU/i6eDLyodZ
         g+rzzbVmRMCrxZY+bgHX6yCbRMnZQHko3pZ31E/z2WgbfE/QDfUfoCidO23DchMT9J
         CY06h3UO6PdDg==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: fix recently introduced checkpatch warning
Date:   Mon,  6 Jun 2022 17:29:57 +0300
Message-Id: <20220606142957.23721-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

I updated my checkpatch and saw new warnings:

drivers/net/wireless/ath/ath10k/qmi.c:593: Prefer strscpy over strlcpy - see: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
drivers/net/wireless/ath/ath10k/qmi.c:598: Prefer strscpy over strlcpy - see: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
drivers/net/wireless/ath/ath10k/htt_rx.c:3565: Integer promotion: Using 'h' in '%04hx' is unnecessary

Compile tested only.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 2 +-
 drivers/net/wireless/ath/ath10k/qmi.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index e8727c0b0171..b8461501221a 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -3563,7 +3563,7 @@ static void ath10k_htt_rx_tx_mode_switch_ind(struct ath10k *ar,
 	threshold = MS(info1, HTT_TX_MODE_SWITCH_IND_INFO1_THRESHOLD);
 
 	ath10k_dbg(ar, ATH10K_DBG_HTT,
-		   "htt rx tx mode switch ind info0 0x%04hx info1 0x%04x enable %d num records %zd mode %d threshold %u\n",
+		   "htt rx tx mode switch ind info0 0x%04x info1 0x%04x enable %d num records %zd mode %d threshold %u\n",
 		   info0, info1, enable, num_records, mode, threshold);
 
 	len += sizeof(resp->tx_mode_switch_ind.records[0]) * num_records;
diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index 80fcb917fe4e..d7e406916bc8 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -590,12 +590,12 @@ static int ath10k_qmi_cap_send_sync_msg(struct ath10k_qmi *qmi)
 
 	if (resp->fw_version_info_valid) {
 		qmi->fw_version = resp->fw_version_info.fw_version;
-		strlcpy(qmi->fw_build_timestamp, resp->fw_version_info.fw_build_timestamp,
+		strscpy(qmi->fw_build_timestamp, resp->fw_version_info.fw_build_timestamp,
 			sizeof(qmi->fw_build_timestamp));
 	}
 
 	if (resp->fw_build_id_valid)
-		strlcpy(qmi->fw_build_id, resp->fw_build_id,
+		strscpy(qmi->fw_build_id, resp->fw_build_id,
 			MAX_BUILD_ID_LEN + 1);
 
 	if (!test_bit(ATH10K_SNOC_FLAG_REGISTERED, &ar_snoc->flags)) {

base-commit: 0f4b70f3f15c463222094ac85ec3b6d9e7c6ab77
-- 
2.30.2

