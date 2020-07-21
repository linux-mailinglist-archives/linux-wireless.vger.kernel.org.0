Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527BB228708
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jul 2020 19:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbgGURPa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jul 2020 13:15:30 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:39508 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730816AbgGURPS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jul 2020 13:15:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595351718; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=PuxwKGt35tpiRMfDgkpJSCtxDJb7QR6bGP5l0QXwvfc=; b=Ik8J7tET8O55cc09LJc6txOcWHF8GMysuoUqSew4l81xBAPTJKzLll3c9QheET2dOAfCGza9
 Stu/Xlb9FxcZq7MqkcqgGPaubJkPOH1TGE4/ZuUtpV+2Rw8CCnSKFMcOmL7rnXOBtnTxo9F6
 SiBgv7fdG6vaENh+QWwInwdGYTY=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5f17229b3dbcb593a96abfda (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 21 Jul 2020 17:15:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5D4D7C433C9; Tue, 21 Jul 2020 17:15:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pillair-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 71AECC433CA;
        Tue, 21 Jul 2020 17:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 71AECC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvalo@codeaurora.org, johannes@sipsolutions.net,
        davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        dianders@chromium.org, evgreen@chromium.org,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: [RFC 6/7] ath10k: Add deliver to stack from thread context
Date:   Tue, 21 Jul 2020 22:44:25 +0530
Message-Id: <1595351666-28193-7-git-send-email-pillair@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595351666-28193-1-git-send-email-pillair@codeaurora.org>
References: <1595351666-28193-1-git-send-email-pillair@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When the receive packets are submitted to the stack
from a thread context, the NAPI handle should be passed
as NULL to the function ieee80211_rx_napi. This will
make sure that the packets are submitted to stack via
non-napi method

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1

Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index becbd56..85c169c 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -1321,7 +1321,10 @@ static void ath10k_process_rx(struct ath10k *ar, struct sk_buff *skb)
 	trace_ath10k_rx_hdr(ar, skb->data, skb->len);
 	trace_ath10k_rx_payload(ar, skb->data, skb->len);
 
-	ieee80211_rx_napi(ar->hw, NULL, skb, &ar->napi);
+	if (in_serving_softirq())
+		ieee80211_rx_napi(ar->hw, NULL, skb, &ar->napi);
+	else
+		ieee80211_rx_napi(ar->hw, NULL, skb, NULL);
 }
 
 static int ath10k_htt_rx_nwifi_hdrlen(struct ath10k *ar,
-- 
2.7.4

