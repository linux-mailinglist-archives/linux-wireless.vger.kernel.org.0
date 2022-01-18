Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B20491955
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jan 2022 03:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351175AbiARCxp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jan 2022 21:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349267AbiARCtT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jan 2022 21:49:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96D7C061765;
        Mon, 17 Jan 2022 18:41:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EE93612E3;
        Tue, 18 Jan 2022 02:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BEBC36AEB;
        Tue, 18 Jan 2022 02:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642473706;
        bh=P/u2NpmukKPSwfMVhe+e+rsd6DvDNxunk45fqI5RjPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ifl+G3shb23vAX8Q72nFzJPLWuOuNYUgwCxNAYXFaxz4gnqgbDVHWjbpXKY5nOoft
         8pEKxSVFe1JseYjBwv7brXXbC/9xjy75CZTkM7ydGih6DLRiGb4M4+qYHO454gmmNF
         C90v9itrJAQrdZKcKAsQHIDX5kmbZQFSvBiJ5WOY6oc0S+gBTKMSDAv1jp1IZ9vbBd
         nRZnyz+X5H85VqOQJ1e8gLUVDfkA1OP2KIMYZ00DWQ3fb2omj10xy/bQM+cf37vokH
         yaKo3QqdsYnyxhXWEC+XyEK5C4bpOGHj9bMc6iaLBlvKUTnJFMsprb2i8W8iEhU/qb
         +gL1bIUe6Ifdg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sriram R <quic_srirrama@quicinc.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        davem@davemloft.net, kuba@kernel.org, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 034/116] ath11k: Avoid NULL ptr access during mgmt tx cleanup
Date:   Mon, 17 Jan 2022 21:38:45 -0500
Message-Id: <20220118024007.1950576-34-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118024007.1950576-1-sashal@kernel.org>
References: <20220118024007.1950576-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sriram R <quic_srirrama@quicinc.com>

[ Upstream commit a93789ae541c7d5c1c2a4942013adb6bcc5e2848 ]

Currently 'ar' reference is not added in skb_cb during
WMI mgmt tx. Though this is generally not used during tx completion
callbacks, on interface removal the remaining idr cleanup callback
uses the ar ptr from skb_cb from mgmt txmgmt_idr. Hence
fill them during tx call for proper usage.

Also free the skb which is missing currently in these
callbacks.

Crash_info:

[19282.489476] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[19282.489515] pgd = 91eb8000
[19282.496702] [00000000] *pgd=00000000
[19282.502524] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[19282.783728] PC is at ath11k_mac_vif_txmgmt_idr_remove+0x28/0xd8 [ath11k]
[19282.789170] LR is at idr_for_each+0xa0/0xc8

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00729-QCAHKSWPL_SILICONZ-3 v2
Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/1637832614-13831-1-git-send-email-quic_srirrama@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 35 +++++++++++++++------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 0924bc8b35205..4a4694ce7dc87 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <net/mac80211.h>
@@ -3878,23 +3879,32 @@ static int __ath11k_set_antenna(struct ath11k *ar, u32 tx_ant, u32 rx_ant)
 	return 0;
 }
 
-int ath11k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx)
+static void ath11k_mac_tx_mgmt_free(struct ath11k *ar, int buf_id)
 {
-	struct sk_buff *msdu = skb;
+	struct sk_buff *msdu;
 	struct ieee80211_tx_info *info;
-	struct ath11k *ar = ctx;
-	struct ath11k_base *ab = ar->ab;
 
 	spin_lock_bh(&ar->txmgmt_idr_lock);
-	idr_remove(&ar->txmgmt_idr, buf_id);
+	msdu = idr_remove(&ar->txmgmt_idr, buf_id);
 	spin_unlock_bh(&ar->txmgmt_idr_lock);
-	dma_unmap_single(ab->dev, ATH11K_SKB_CB(msdu)->paddr, msdu->len,
+
+	if (!msdu)
+		return;
+
+	dma_unmap_single(ar->ab->dev, ATH11K_SKB_CB(msdu)->paddr, msdu->len,
 			 DMA_TO_DEVICE);
 
 	info = IEEE80211_SKB_CB(msdu);
 	memset(&info->status, 0, sizeof(info->status));
 
 	ieee80211_free_txskb(ar->hw, msdu);
+}
+
+int ath11k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx)
+{
+	struct ath11k *ar = ctx;
+
+	ath11k_mac_tx_mgmt_free(ar, buf_id);
 
 	return 0;
 }
@@ -3903,17 +3913,10 @@ static int ath11k_mac_vif_txmgmt_idr_remove(int buf_id, void *skb, void *ctx)
 {
 	struct ieee80211_vif *vif = ctx;
 	struct ath11k_skb_cb *skb_cb = ATH11K_SKB_CB((struct sk_buff *)skb);
-	struct sk_buff *msdu = skb;
 	struct ath11k *ar = skb_cb->ar;
-	struct ath11k_base *ab = ar->ab;
 
-	if (skb_cb->vif == vif) {
-		spin_lock_bh(&ar->txmgmt_idr_lock);
-		idr_remove(&ar->txmgmt_idr, buf_id);
-		spin_unlock_bh(&ar->txmgmt_idr_lock);
-		dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len,
-				 DMA_TO_DEVICE);
-	}
+	if (skb_cb->vif == vif)
+		ath11k_mac_tx_mgmt_free(ar, buf_id);
 
 	return 0;
 }
@@ -3928,6 +3931,8 @@ static int ath11k_mac_mgmt_tx_wmi(struct ath11k *ar, struct ath11k_vif *arvif,
 	int buf_id;
 	int ret;
 
+	ATH11K_SKB_CB(skb)->ar = ar;
+
 	spin_lock_bh(&ar->txmgmt_idr_lock);
 	buf_id = idr_alloc(&ar->txmgmt_idr, skb, 0,
 			   ATH11K_TX_MGMT_NUM_PENDING_MAX, GFP_ATOMIC);
-- 
2.34.1

