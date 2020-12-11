Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EA52D6FEE
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Dec 2020 06:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395328AbgLKF5h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 00:57:37 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:42304 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395322AbgLKF5X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 00:57:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607666218; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=llJHorwskmXWrjfo+IOAoxI0Bh3S9VvxGycnIGs2tVg=; b=IHNULY3YCR7FXwhsagPsfuhj8bydzysTCVkdK/Sp3wKBAq3AL7FgYwLxu31clncX0mYtx+is
 /6IMTDFR7flP0lDyUDblWFMdq6hMoimKxsIxjIkDNAvAZH2M7C8H0L6xX7HWzm4XQRBDg3f9
 qbm9l1wBfRKeMnHs5Nlh/BBr/I0=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5fd30a0535a25d1b161bc912 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 11 Dec 2020 05:56:21
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A413FC433ED; Fri, 11 Dec 2020 05:56:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cjhuang-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 772C4C433C6;
        Fri, 11 Dec 2020 05:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 772C4C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cjhuang@codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath11k: fix crash caused by NULL rx_channel
Date:   Fri, 11 Dec 2020 00:56:13 -0500
Message-Id: <20201211055613.9310-1-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

During connect and disconnect stress test, crashed happened
because ar->rx_channel is NULL. Fix it by checking whether
ar->rx_channel is NULL.

Crash stack is as below:
RIP: 0010:ath11k_dp_rx_h_ppdu+0x110/0x230 [ath11k]
[ 5028.808963]  ath11k_dp_rx_wbm_err+0x14a/0x360 [ath11k]
[ 5028.808970]  ath11k_dp_rx_process_wbm_err+0x41c/0x520 [ath11k]
[ 5028.808978]  ath11k_dp_service_srng+0x25e/0x2d0 [ath11k]
[ 5028.808982]  ath11k_pci_ext_grp_napi_poll+0x23/0x80 [ath11k_pci]
[ 5028.808986]  net_rx_action+0x27e/0x400
[ 5028.808990]  __do_softirq+0xfd/0x2bb
[ 5028.808993]  irq_exit+0xa6/0xb0
[ 5028.808995]  do_IRQ+0x56/0xe0
[ 5028.808997]  common_interrupt+0xf/0xf

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 2bcaf23f..17c37e2 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2295,6 +2295,7 @@ static void ath11k_dp_rx_h_ppdu(struct ath11k *ar, struct hal_rx_desc *rx_desc,
 {
 	u8 channel_num;
 	u32 center_freq;
+	struct ieee80211_channel *channel;
 
 	rx_status->freq = 0;
 	rx_status->rate_idx = 0;
@@ -2315,9 +2316,12 @@ static void ath11k_dp_rx_h_ppdu(struct ath11k *ar, struct hal_rx_desc *rx_desc,
 		rx_status->band = NL80211_BAND_5GHZ;
 	} else {
 		spin_lock_bh(&ar->data_lock);
-		rx_status->band = ar->rx_channel->band;
-		channel_num =
-			ieee80211_frequency_to_channel(ar->rx_channel->center_freq);
+		channel = ar->rx_channel;
+		if (channel) {
+			rx_status->band = channel->band;
+			channel_num =
+				ieee80211_frequency_to_channel(channel->center_freq);
+		}
 		spin_unlock_bh(&ar->data_lock);
 		ath11k_dbg_dump(ar->ab, ATH11K_DBG_DATA, NULL, "rx_desc: ",
 				rx_desc, sizeof(struct hal_rx_desc));
-- 
2.7.4

