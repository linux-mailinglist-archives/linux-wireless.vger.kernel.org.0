Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F667409BAB
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 20:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346222AbhIMSEb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 14:04:31 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:63645 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346559AbhIMSE2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 14:04:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631556193; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=WrTk85o6jVDyoyJoxKXGeRyBbmUALZxD8Ub4V/fI9HA=; b=jzmujV69AXfMW0EU8CyzPEbHIwAD2XSU396rPZrKn6OlnhDA9BO0XX/esXSh+bn4mgWDVnod
 6F1fjSq8vr9MaXjLVrDQt0pBey4QFB2HCCI5uXtI9Bq3EVBkLUevSFuJSg4LKyCwLOiosBzL
 rAdZ+5uvrg+3xJg9KiWR1cwllKg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 613f9255b585cc7d240f6d85 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Sep 2021 18:03:01
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 984BFC4360C; Mon, 13 Sep 2021 18:03:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-72-211-nat.elisa-mobile.fi [85.76.72.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CDEA1C4360D;
        Mon, 13 Sep 2021 18:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org CDEA1C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 2/5] ath11k: Drop MSDU with length error in DP rx path
Date:   Mon, 13 Sep 2021 21:02:43 +0300
Message-Id: <20210913180246.193388-2-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913180246.193388-1-jouni@codeaurora.org>
References: <20210913180246.193388-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Baochen Qiang <bqiang@codeaurora.org>

There are MSDUs whose length are invalid. For example,
attackers may inject on purpose truncated A-MSDUs with
invalid MSDU length.

Such MSDUs are marked with an err bit set in rx attention
tlvs, so we can check and drop them.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 0c27eead3e02..c50f70913583 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -142,6 +142,18 @@ static u32 ath11k_dp_rx_h_attn_mpdu_err(struct rx_attention *attn)
 	return errmap;
 }
 
+static bool ath11k_dp_rx_h_attn_msdu_len_err(struct ath11k_base *ab,
+					     struct hal_rx_desc *desc)
+{
+	struct rx_attention *rx_attention;
+	u32 errmap;
+
+	rx_attention = ath11k_dp_rx_get_attention(ab, desc);
+	errmap = ath11k_dp_rx_h_attn_mpdu_err(rx_attention);
+
+	return errmap & DP_RX_MPDU_ERR_MSDU_LEN;
+}
+
 static u16 ath11k_dp_rx_h_msdu_start_msdu_len(struct ath11k_base *ab,
 					      struct hal_rx_desc *desc)
 {
@@ -2525,6 +2537,12 @@ static int ath11k_dp_rx_process_msdu(struct ath11k *ar,
 	}
 
 	rx_desc = (struct hal_rx_desc *)msdu->data;
+	if (ath11k_dp_rx_h_attn_msdu_len_err(ab, rx_desc)) {
+		ath11k_warn(ar->ab, "msdu len not valid\n");
+		ret = -EIO;
+		goto free_out;
+	}
+
 	lrx_desc = (struct hal_rx_desc *)last_buf->data;
 	rx_attention = ath11k_dp_rx_get_attention(ab, lrx_desc);
 	if (!ath11k_dp_rx_h_attn_msdu_done(rx_attention)) {
-- 
2.25.1

