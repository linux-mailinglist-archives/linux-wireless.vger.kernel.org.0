Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE191B710A
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 11:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgDXJge (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 05:36:34 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:59904 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbgDXJge (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 05:36:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587720994; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=UaUhKnh/etjN1ULoQ6mXaxCMIuT8zG7kqspNDI4dDP4=; b=vjGml9Vb2vDOLRfmJi20WEScp+ZNqbJxqP2FQS9YDUdM8BQMowrXTXorlFdDSWUfac3G6bah
 FTxDc1kue2/kYCRfu58ocu7Pvck5MGMXpzMdojPXXd10L3Tn8PDf0jbWeqk+vEG6r7eugmR1
 8bzeMMk1jFzIhuYp9lLAJRAH3ck=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea2b30f.7f1cb0b14c38-smtp-out-n01;
 Fri, 24 Apr 2020 09:36:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 07A0DC433F2; Fri, 24 Apr 2020 09:36:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from murugana-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: murugana)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82F02C433D2;
        Fri, 24 Apr 2020 09:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82F02C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=murugana@codeaurora.org
From:   Sathishkumar Muruganandam <murugana@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Sathishkumar Muruganandam <murugana@codeaurora.org>
Subject: [PATCH 2/2] ath11k: add 802.3 undecap support to fix TKIP MIC error reporting
Date:   Fri, 24 Apr 2020 15:05:51 +0530
Message-Id: <1587720951-9222-3-git-send-email-murugana@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587720951-9222-1-git-send-email-murugana@codeaurora.org>
References: <1587720951-9222-1-git-send-email-murugana@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently DECAP_TYPE_8023 frames with TKIP MIC error is not undecaped
and hence fails to do TKIP MIC error reporting in ieee80211_rx_napi()
path.

Fix this by adding undecap support for ieee80211_rx_napi() to process
these frames and perform TKIP counter-measures when there is MIC error
reported.

Tested with STA triggering TKIP MIC error frames (using debugfs
"tkip_mic_test" in SW encryption mode) twice within a minute and
verify TKIP counter-measures are performed as expected.

Signed-off-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 39 ++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index bbd7da48518f..8db42a3d4a1f 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1986,6 +1986,42 @@ static void ath11k_dp_rx_h_undecap_eth(struct ath11k *ar,
 	ether_addr_copy(ieee80211_get_SA(hdr), sa);
 }
 
+static void ath11k_dp_rx_h_undecap_snap(struct ath11k *ar,
+					struct sk_buff *msdu,
+					u8 *first_hdr,
+					enum hal_encrypt_type enctype,
+					struct ieee80211_rx_status *status)
+{
+	struct ieee80211_hdr *hdr;
+	size_t hdr_len;
+	u8 l3_pad_bytes;
+	struct hal_rx_desc *rx_desc;
+
+	/* Delivered decapped frame:
+	 * [amsdu header] <-- replaced with 802.11 hdr
+	 * [rfc1042/llc]
+	 * [payload]
+	 */
+
+	rx_desc = (void *)msdu->data - sizeof(*rx_desc);
+	l3_pad_bytes = ath11k_dp_rx_h_msdu_end_l3pad(rx_desc);
+
+	skb_put(msdu, l3_pad_bytes);
+	skb_pull(msdu, sizeof(struct ath11k_dp_amsdu_subframe_hdr) + l3_pad_bytes);
+
+	hdr = (struct ieee80211_hdr *)first_hdr;
+	hdr_len = ieee80211_hdrlen(hdr->frame_control);
+
+	if (!(status->flag & RX_FLAG_IV_STRIPPED)) {
+		memcpy(skb_push(msdu,
+				ath11k_dp_rx_crypto_param_len(ar, enctype)),
+		       (void *)hdr + hdr_len,
+			ath11k_dp_rx_crypto_param_len(ar, enctype));
+	}
+
+	memcpy(skb_push(msdu, hdr_len), hdr, hdr_len);
+}
+
 static void ath11k_dp_rx_h_undecap(struct ath11k *ar, struct sk_buff *msdu,
 				   struct hal_rx_desc *rx_desc,
 				   enum hal_encrypt_type enctype,
@@ -2013,7 +2049,8 @@ static void ath11k_dp_rx_h_undecap(struct ath11k *ar, struct sk_buff *msdu,
 					   enctype, status);
 		break;
 	case DP_RX_DECAP_TYPE_8023:
-		/* TODO: Handle undecap for these formats */
+		ath11k_dp_rx_h_undecap_snap(ar, msdu, first_hdr,
+					    enctype, status);
 		break;
 	}
 }
-- 
2.7.4
