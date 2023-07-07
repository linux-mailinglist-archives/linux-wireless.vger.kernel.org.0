Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A6E74AEEA
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jul 2023 12:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjGGKrq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jul 2023 06:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjGGKrc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jul 2023 06:47:32 -0400
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE75C1725
        for <linux-wireless@vger.kernel.org>; Fri,  7 Jul 2023 03:47:29 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:c83:0:640:84f9:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id D00546003F;
        Fri,  7 Jul 2023 13:47:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id QlSXXAOWp0U0-9LrQxIxU;
        Fri, 07 Jul 2023 13:47:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1688726846;
        bh=X03PZEGyOlJUStvc5FVgbUoZ8zqRvoqEPTPhNtvXIPU=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=HmuDjr8HIRNR4rNy2tvy6nwSdwvGnFPmnWn9iWhjhFZUB0LQFEG1IidiTUfJ4PoH0
         Z4G1c2Cb83lPIkp8L/lpIZLp7gZjvOUiOMuC/SG1F5BqmSyLsr2hpGE8/qRNSjw0CZ
         /9iTvhqMFCNFRauzl8k/f9qzdF3BmudKoWI3IKCU=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Rakesh Pillai <pillair@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath10k: fix memory leak in WMI management
Date:   Fri,  7 Jul 2023 13:45:12 +0300
Message-ID: <20230707104517.22427-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 'mgmt_pending_tx' of 'struct ath10k_wmi' contains pointers
to dynamically allocated 'struct ath10k_mgmt_tx_pkt_addr' objects,
these objects should be explicitly freed when removing from idr
or when the whole idr is destroyed.

Fixes: dc405152bb64 ("ath10k: handle mgmt tx completion event")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 11 +++++++++--
 drivers/net/wireless/ath/ath10k/wmi.c     |  5 +++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 6b6aa3c36744..45a445c5f1df 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -3038,11 +3038,18 @@ ath10k_wmi_tlv_op_cleanup_mgmt_tx_send(struct ath10k *ar,
 				       struct sk_buff *msdu)
 {
 	struct ath10k_skb_cb *cb = ATH10K_SKB_CB(msdu);
+	struct ath10k_mgmt_tx_pkt_addr *pkt_addr;
 	struct ath10k_wmi *wmi = &ar->wmi;
 
-	idr_remove(&wmi->mgmt_pending_tx, cb->msdu_id);
+	pkt_addr = idr_find(&wmi->mgmt_pending_tx, cb->msdu_id);
+	if (pkt_addr) {
+		idr_remove(&wmi->mgmt_pending_tx, cb->msdu_id);
+		kfree(pkt_addr);
+		return 0;
+	}
 
-	return 0;
+	ath10k_warn(ar, "invalid msdu_id: %d\n", cb->msdu_id);
+	return -ENOENT;
 }
 
 static int
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 05fa7d4c0e1a..20534a7d6551 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -2433,9 +2433,9 @@ wmi_process_mgmt_tx_comp(struct ath10k *ar, struct mgmt_tx_compl_params *param)
 	ieee80211_tx_status_irqsafe(ar->hw, msdu);
 
 	ret = 0;
-
-out:
 	idr_remove(&wmi->mgmt_pending_tx, param->desc_id);
+	kfree(pkt_addr);
+out:
 	spin_unlock_bh(&ar->data_lock);
 	return ret;
 }
@@ -9539,6 +9539,7 @@ static int ath10k_wmi_mgmt_tx_clean_up_pending(int msdu_id, void *ptr,
 	dma_unmap_single(ar->dev, pkt_addr->paddr,
 			 msdu->len, DMA_TO_DEVICE);
 	ieee80211_free_txskb(ar->hw, msdu);
+	kfree(pkt_addr);
 
 	return 0;
 }
-- 
2.41.0

