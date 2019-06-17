Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62BFB47B43
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2019 09:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfFQHie (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jun 2019 03:38:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60910 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfFQHid (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jun 2019 03:38:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 892AC6020A; Mon, 17 Jun 2019 07:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560757113;
        bh=4zwy2dPQuSTet8S1EGgrunmmJm4kL4MEEtL33hgHrUM=;
        h=From:To:Cc:Subject:Date:From;
        b=jso8wdaIbYRNrmE1jFazvWo1dUOcY8DogJwSfy7RTtrkpTvfKovU35104/SfEGef5
         OxQimJyRt/znfRF+Opee+NqAYh2TE/tx6RO2B+XEeS8Fgd8zYCtKMTUqErcZD0YhOX
         pUifjJpPI7YhRvt33vLkt3tHHuM1Pirb0+HGG1WI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from localhost.localdomain (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 35CDA606FC;
        Mon, 17 Jun 2019 07:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560757113;
        bh=4zwy2dPQuSTet8S1EGgrunmmJm4kL4MEEtL33hgHrUM=;
        h=From:To:Cc:Subject:Date:From;
        b=jso8wdaIbYRNrmE1jFazvWo1dUOcY8DogJwSfy7RTtrkpTvfKovU35104/SfEGef5
         OxQimJyRt/znfRF+Opee+NqAYh2TE/tx6RO2B+XEeS8Fgd8zYCtKMTUqErcZD0YhOX
         pUifjJpPI7YhRvt33vLkt3tHHuM1Pirb0+HGG1WI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 35CDA606FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: add mic bytes for pmf management packet
Date:   Mon, 17 Jun 2019 15:37:59 +0800
Message-Id: <1560757079-19266-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For PMF case, the action,deauth,disassoc management need to encrypt
by hardware, it need to reserve 8 bytes for encryption, otherwise
the packet will be sent out with error format, then PMF case will
fail.

After add the 8 bytes, it will pass the PMF case.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00005-QCARMSWP-1.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/htt_tx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index d8e9cc0..7bef9d9 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -1236,6 +1236,7 @@ static int ath10k_htt_tx_hl(struct ath10k_htt *htt, enum ath10k_hw_txrx_mode txm
 	struct ath10k *ar = htt->ar;
 	int res, data_len;
 	struct htt_cmd_hdr *cmd_hdr;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)msdu->data;
 	struct htt_data_tx_desc *tx_desc;
 	struct ath10k_skb_cb *skb_cb = ATH10K_SKB_CB(msdu);
 	struct sk_buff *tmp_skb;
@@ -1245,6 +1246,13 @@ static int ath10k_htt_tx_hl(struct ath10k_htt *htt, enum ath10k_hw_txrx_mode txm
 	u8 flags0 = 0;
 	u16 flags1 = 0;
 
+	if ((ieee80211_is_action(hdr->frame_control) ||
+	     ieee80211_is_deauth(hdr->frame_control) ||
+	     ieee80211_is_disassoc(hdr->frame_control)) &&
+	     ieee80211_has_protected(hdr->frame_control)) {
+		skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
+	}
+
 	data_len = msdu->len;
 
 	switch (txmode) {
-- 
1.9.1

