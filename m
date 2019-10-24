Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5D7BE2DF5
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2019 11:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393107AbfJXJyQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Oct 2019 05:54:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57070 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfJXJyQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Oct 2019 05:54:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CE2936119B; Thu, 24 Oct 2019 09:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571910855;
        bh=olhz53eSWn8B+t4e5HJ9Ad44Ha9vyjbjoKXi42voITg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WhZQoLA8i0HpKEx1qRBVAPJPh2YR4fmSmTNe1J2OxpqCvsUAj1oQ8c4blEMNdqp1G
         Mz5/OZWBPhNqlP4uU+6Z608BIhGZVGak+iKjchffUBvQwmPVjSloyjC80ZdMSu2yfP
         h7Oxy2jaGZd+vi7gj6uxmWNXEAnZrcmRAY4rWyeY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (unknown [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DA49B61178;
        Thu, 24 Oct 2019 09:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571910854;
        bh=olhz53eSWn8B+t4e5HJ9Ad44Ha9vyjbjoKXi42voITg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JDfRl5BJj4KZNxrJnHiASCIFw/vDi/ubsXk/J4p4/xAnlvMSWjnnaArjlh5zSm4jU
         0xrnTH9DBW02+f7HzJVvR9yAkY8ReEY4BgApndjyKdZL6gS+Au1NVFV6N+g+eoaEng
         fcS4DV/XoFvxQtUQZ89jsEKNx9FYmzITTo7NR+dU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA49B61178
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] ath10k: sdio: remove struct ath10k_sdio_rx_data::status
Date:   Thu, 24 Oct 2019 12:54:09 +0300
Message-Id: <1571910849-11489-2-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571910849-11489-1-git-send-email-kvalo@codeaurora.org>
References: <1571910849-11489-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It seems to be unused.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 2 --
 drivers/net/wireless/ath/ath10k/sdio.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index ef16b45c18da..ceeee465a73a 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -649,7 +649,6 @@ static int ath10k_sdio_mbox_rx_fetch(struct ath10k *ar)
 
 	htc_hdr = (struct ath10k_htc_hdr *)skb->data;
 	pkt->act_len = le16_to_cpu(htc_hdr->len) + sizeof(*htc_hdr);
-	pkt->status = ret;
 	skb_put(skb, pkt->act_len);
 
 	return ret;
@@ -687,7 +686,6 @@ static int ath10k_sdio_mbox_rx_fetch_bundle(struct ath10k *ar)
 		pkt->act_len = le16_to_cpu(htc_hdr->len) + sizeof(*htc_hdr);
 
 		skb_put_data(pkt->skb, htc_hdr, pkt->act_len);
-		pkt->status = 0;
 		pkt_offset += pkt->alloc_len;
 	}
 
diff --git a/drivers/net/wireless/ath/ath10k/sdio.h b/drivers/net/wireless/ath/ath10k/sdio.h
index 9acaf0229cf2..33195f49acab 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.h
+++ b/drivers/net/wireless/ath/ath10k/sdio.h
@@ -126,7 +126,6 @@ struct ath10k_sdio_rx_data {
 	bool part_of_bundle;
 	bool last_in_bundle;
 	bool trailer_only;
-	int status;
 };
 
 struct ath10k_sdio_irq_proc_regs {
-- 
2.7.4

