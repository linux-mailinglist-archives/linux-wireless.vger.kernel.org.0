Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A5B165601
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2020 05:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbgBTEBa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Feb 2020 23:01:30 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:51796 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727515AbgBTEBa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Feb 2020 23:01:30 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582171289; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=hjCwvEXCY+H2ZACPOtBjzPemo157UbrAiuMlfjDqQkw=; b=FCx+rtSFWalwITMHp8gtdM5fn1y6KYYeyqD7M4P3RyUtdRaAKq2M42QdrO2vIF5QlLlNg0mD
 7u2fFnCVweQGN7B5N/j4yGSH/OMjYcN/KblDZTy+dDpiec3uDAOkMvJyL1KK9C02uO5gTsrK
 wVr7Z/EBhUKrxBDmrCNlJwzMYbw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4e047e.7fd9561b8ae8-smtp-out-n02;
 Thu, 20 Feb 2020 04:01:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 252BDC433A2; Thu, 20 Feb 2020 04:01:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from ybzhao-HP-Z230-SFF-Workstation.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: yiboz)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C9CEFC43383;
        Thu, 20 Feb 2020 04:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9CEFC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=yiboz@codeaurora.org
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Yibo Zhao <yiboz@codeaurora.org>
Subject: [PATCH] ath10k: fix not registering airtime of 11a station with WMM disable
Date:   Thu, 20 Feb 2020 12:03:25 +0800
Message-Id: <1582171405-27236-1-git-send-email-yiboz@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The tid of 11a station with WMM disable reported by FW is 0x10 in
tx completion. The tid 16 is mapped to a NULL txq since buffer
MMPDU capbility is not supported. Then 11a station's airtime will
not be registered due to NULL txq check. As a results, airtime of
11a station keeps unchanged in debugfs system.

Mask the tid along with IEEE80211_QOS_CTL_TID_MASK to make it in
the valid range.

Hardwares tested : QCA9984
Firmwares tested : 10.4-3.10-00047

Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 38a5814..f883f2a 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -2744,7 +2744,8 @@ static void ath10k_htt_rx_tx_compl_ind(struct ath10k *ar,
 			continue;
 		}
 
-		tid = FIELD_GET(HTT_TX_PPDU_DUR_INFO0_TID_MASK, info0);
+		tid = FIELD_GET(HTT_TX_PPDU_DUR_INFO0_TID_MASK, info0) &
+						IEEE80211_QOS_CTL_TID_MASK;
 		tx_duration = __le32_to_cpu(ppdu_dur->tx_duration);
 
 		ieee80211_sta_register_airtime(peer->sta, tid, tx_duration, 0);
-- 
1.9.1
