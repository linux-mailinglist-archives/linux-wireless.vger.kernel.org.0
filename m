Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCD541A426E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2020 08:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgDJGPE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Apr 2020 02:15:04 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:37984 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725858AbgDJGPE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Apr 2020 02:15:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586499304; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Xvr4viw8itlTmm9bsn4GkktOs8HCTMS4TA715gXjWhA=; b=nL9LIG/TTYvz5s76SlGmbdpr5TxhVHjT6DxpgdcSMbZhYRLI2J0xMSpbeQg50TmIG8+cWI0x
 UvaxTNkVHJ2/lGPeuJgVNu1UsVyv8iksT46pA1aczSYi+gcr+qwhe1Yaog/sgDtPfJd6w31S
 L+OexizbLjPuOQRia4L9GObykaA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e900ed7.7f59af1a3c70-smtp-out-n03;
 Fri, 10 Apr 2020 06:14:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 486CDC432C2; Fri, 10 Apr 2020 06:14:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 000A4C433CB;
        Fri, 10 Apr 2020 06:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 000A4C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v10 2/2] ath10k: enable alt data of TX path for sdio
Date:   Fri, 10 Apr 2020 14:14:00 +0800
Message-Id: <20200410061400.14231-3-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200410061400.14231-1-wgong@codeaurora.org>
References: <20200410061400.14231-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The default credit size is 1792 bytes, but the IP mtu is 1500 bytes,
then it has about 290 bytes's waste for each data packet on sdio
transfer path for TX bundle, it will reduce the transmission utilization
ratio for data packet.

This patch enable the small credit size in firmware, firmware will use
the new credit size 1556 bytes, it will increase the transmission
utilization ratio for data packet on TX patch. It results in significant
performance improvement on TX path.

This patch only effect sdio chip, it will not effect PCI, SNOC etc.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00017-QCARMSWP-1.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.c |  8 ++++----
 drivers/net/wireless/ath/ath10k/htc.c  | 12 ++++++++++--
 drivers/net/wireless/ath/ath10k/htc.h  | 13 +++++++++++--
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index edb53ddfa90e..27323bff4d43 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -725,10 +725,10 @@ static int ath10k_init_sdio(struct ath10k *ar, enum ath10k_firmware_mode mode)
 
 	param |= HI_ACS_FLAGS_SDIO_REDUCE_TX_COMPL_SET;
 
-	/* Alternate credit size of 1544 as used by SDIO firmware is
-	 * not big enough for mac80211 / native wifi frames. disable it
-	 */
-	param &= ~HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE;
+	if (mode == ATH10K_FIRMWARE_MODE_NORMAL)
+		param |= HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE;
+	else
+		param &= ~HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE;
 
 	if (mode == ATH10K_FIRMWARE_MODE_UTF)
 		param &= ~HI_ACS_FLAGS_SDIO_SWAP_MAILBOX_SET;
diff --git a/drivers/net/wireless/ath/ath10k/htc.c b/drivers/net/wireless/ath/ath10k/htc.c
index ed4e0add997e..58ceba75d20a 100644
--- a/drivers/net/wireless/ath/ath10k/htc.c
+++ b/drivers/net/wireless/ath/ath10k/htc.c
@@ -957,12 +957,16 @@ int ath10k_htc_wait_target(struct ath10k_htc *htc)
 	 */
 	if (htc->control_resp_len >=
 	    sizeof(msg->hdr) + sizeof(msg->ready_ext)) {
+		htc->alt_data_credit_size =
+			__le16_to_cpu(msg->ready_ext.reserved) &
+			ATH10K_HTC_MSG_READY_EXT_ALT_DATA_MASK;
 		htc->max_msgs_per_htc_bundle =
 			min_t(u8, msg->ready_ext.max_msgs_per_htc_bundle,
 			      HTC_HOST_MAX_MSG_PER_RX_BUNDLE);
 		ath10k_dbg(ar, ATH10K_DBG_HTC,
-			   "Extended ready message. RX bundle size: %d\n",
-			   htc->max_msgs_per_htc_bundle);
+			   "Extended ready message RX bundle size %d alt size %d\n",
+			   htc->max_msgs_per_htc_bundle,
+			   htc->alt_data_credit_size);
 	}
 
 	INIT_WORK(&ar->bundle_tx_work, ath10k_htc_bundle_tx_work);
@@ -1114,6 +1118,10 @@ int ath10k_htc_connect_service(struct ath10k_htc *htc,
 	ep->tx_credits = tx_alloc;
 	ep->tx_credit_size = htc->target_credit_size;
 
+	if (conn_req->service_id == ATH10K_HTC_SVC_ID_HTT_DATA_MSG &&
+	    htc->alt_data_credit_size != 0)
+		ep->tx_credit_size = htc->alt_data_credit_size;
+
 	/* copy all the callbacks */
 	ep->ep_ops = conn_req->ep_ops;
 
diff --git a/drivers/net/wireless/ath/ath10k/htc.h b/drivers/net/wireless/ath/ath10k/htc.h
index d045dbc42158..0d180faf3b77 100644
--- a/drivers/net/wireless/ath/ath10k/htc.h
+++ b/drivers/net/wireless/ath/ath10k/htc.h
@@ -119,6 +119,8 @@ enum ath10k_htc_conn_flags {
 #define ATH10K_HTC_CONN_FLAGS_RECV_ALLOC_LSB  8
 };
 
+#define ATH10K_HTC_MSG_READY_EXT_ALT_DATA_MASK 0xFFF
+
 enum ath10k_htc_conn_svc_status {
 	ATH10K_HTC_CONN_SVC_STATUS_SUCCESS      = 0,
 	ATH10K_HTC_CONN_SVC_STATUS_NOT_FOUND    = 1,
@@ -155,8 +157,14 @@ struct ath10k_htc_ready_extended {
 	struct ath10k_htc_ready base;
 	u8 htc_version; /* @enum ath10k_htc_version */
 	u8 max_msgs_per_htc_bundle;
-	u8 pad0;
-	u8 pad1;
+	union {
+		__le16 reserved;
+		struct {
+			u8 pad0;
+			u8 pad1;
+		} __packed;
+	} __packed;
+
 } __packed;
 
 struct ath10k_htc_conn_svc {
@@ -393,6 +401,7 @@ struct ath10k_htc {
 	int total_transmit_credits;
 	int target_credit_size;
 	u8 max_msgs_per_htc_bundle;
+	int alt_data_credit_size;
 };
 
 int ath10k_htc_init(struct ath10k *ar);
-- 
2.23.0
