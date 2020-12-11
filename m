Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65052D7D12
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Dec 2020 18:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405573AbgLKRiI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 12:38:08 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:32449 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395394AbgLKRgy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 12:36:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607708196; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=wsJQEL+Bh3rhfdXnlTE72EeLcpAHku7DALDNWYT74Uw=; b=ZsBY3PkqIAwbEkq/KxIcIH2ByVVaQhcMgckd0vMxn0thW804myA29gfXYWbW6bPjCXiVmB8h
 Q1mHaStaBBwv9WhKH0/0rvVj1vki2i0ibM5aRYGR2mEGLJUxc8D9Klvw+UgoeEQ0MwJHXrMN
 rpZ4yi1C1XvYNOMSMZf/cfTqCx0=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5fd3ae05fa3411972b2dd610 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 11 Dec 2020 17:36:05
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 164A4C433C6; Fri, 11 Dec 2020 17:36:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D507AC43461;
        Fri, 11 Dec 2020 17:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D507AC43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 07/10] ath11k: set credit_update flag for flow controlled ep only
Date:   Fri, 11 Dec 2020 19:35:47 +0200
Message-Id: <1607708150-21066-8-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607708150-21066-1-git-send-email-kvalo@codeaurora.org>
References: <1607708150-21066-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

Firmware will check all the pipes before entering WoW mode during suspend. If
ATH11K_HTC_FLAG_NEED_CREDIT_UPDATE is set, firmware treats this pipe needed to
return credit even though it's actually not required. If any pipe needs to
return credit, the suspend_complete message doesn't send to host but is
dropped.  So host gets time out and WoW suspend failed.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/htc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/htc.c b/drivers/net/wireless/ath/ath11k/htc.c
index 059b48ded5cc..54b1d34724d7 100644
--- a/drivers/net/wireless/ath/ath11k/htc.c
+++ b/drivers/net/wireless/ath/ath11k/htc.c
@@ -60,9 +60,11 @@ static void ath11k_htc_prepare_tx_skb(struct ath11k_htc_ep *ep,
 	memset(hdr, 0, sizeof(*hdr));
 	hdr->htc_info = FIELD_PREP(HTC_HDR_ENDPOINTID, ep->eid) |
 			FIELD_PREP(HTC_HDR_PAYLOADLEN,
-				   (skb->len - sizeof(*hdr))) |
-			FIELD_PREP(HTC_HDR_FLAGS,
-				   ATH11K_HTC_FLAG_NEED_CREDIT_UPDATE);
+				   (skb->len - sizeof(*hdr)));
+
+	if (ep->tx_credit_flow_enabled)
+		hdr->htc_info |= FIELD_PREP(HTC_HDR_FLAGS,
+					    ATH11K_HTC_FLAG_NEED_CREDIT_UPDATE);
 
 	spin_lock_bh(&ep->htc->tx_lock);
 	hdr->ctrl_info = FIELD_PREP(HTC_HDR_CONTROLBYTES1, ep->seq_no++);
-- 
2.7.4

