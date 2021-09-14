Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1560E40B515
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Sep 2021 18:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhINQny (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 12:43:54 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:47772 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhINQny (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 12:43:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631637756; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=9g90ln5epljHjohWwqm7/A4ZVQ9dSteF76PJngkFhDw=; b=sPEG00Sc8lUphlecI4PfCfZkXPBBjKNXSm8GpcgIjTkToLX4+UDO2qQztP7sZJjhsUk/+Gja
 jOGGi4TPDwudDVDyHgaKki/165ZkkVzlyR0PjfdCNN95oq8vxM6e3pOydtsq8YkDevIkrWEW
 qK+V0OnKCInB++Kk9np+o9wTPVY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6140d0fb648642cc1c61f50e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Sep 2021 16:42:35
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6A5E1C4360C; Tue, 14 Sep 2021 16:42:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-72-211-nat.elisa-mobile.fi [85.76.72.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A6A0C4338F;
        Tue, 14 Sep 2021 16:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 9A6A0C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Wen Gong <wgong@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 3/3] ath11k: indicate to mac80211 scan complete with aborted flag for ATH11K_SCAN_STARTING state
Date:   Tue, 14 Sep 2021 19:42:26 +0300
Message-Id: <20210914164226.38843-3-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210914164226.38843-1-jouni@codeaurora.org>
References: <20210914164226.38843-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <wgong@codeaurora.org>

Scan failure can not be recovered from when running a loop of the
following steps:
1. run scan: "iw wlan scan".
2. run command: echo assert > /sys/kernel/debug/ath11k/qca6490\ hw2.0/simulate_fw_crash
   immediately after step 1.

result:
scan failed and can not recover even when wlan recovery succeeds:
command failed: Device or resource busy (-16)

reason:
When scan arrives, WMI_START_SCAN_CMDID is sent to the firmware and
function ath11k_mac_op_hw_scan() returns, then simulate_fw_crash arrives
and the scan started event does not arrive, and then it starts to do
recovery of wlan. __ath11k_mac_scan_finish() which is called from
ath11k_core_halt() is one step of recovery, it will not call
ieee80211_scan_completed() by logic currently because the scan state is
ATH11K_SCAN_STARTING. Thus it leads the scan not being completed in
mac80211, and leads all consecutive scans failing with -EBUSY in
nl80211_trigger_scan even after wlan recovery success.

Indicate scan complete with aborted flag to mac80211 for
ATH11K_SCAN_STARTING to allow recovery from scan failed with "Device or
resource busy (-16)" after wlan recovery.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <wgong@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 97a2c92b7b9b..e015b22b8dbf 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2985,18 +2985,21 @@ void __ath11k_mac_scan_finish(struct ath11k *ar)
 		break;
 	case ATH11K_SCAN_RUNNING:
 	case ATH11K_SCAN_ABORTING:
+		if (ar->scan.is_roc && ar->scan.roc_notify)
+			ieee80211_remain_on_channel_expired(ar->hw);
+		fallthrough;
+	case ATH11K_SCAN_STARTING:
 		if (!ar->scan.is_roc) {
 			struct cfg80211_scan_info info = {
-				.aborted = (ar->scan.state ==
-					    ATH11K_SCAN_ABORTING),
+				.aborted = ((ar->scan.state ==
+					    ATH11K_SCAN_ABORTING) ||
+					    (ar->scan.state ==
+					    ATH11K_SCAN_STARTING)),
 			};
 
 			ieee80211_scan_completed(ar->hw, &info);
-		} else if (ar->scan.roc_notify) {
-			ieee80211_remain_on_channel_expired(ar->hw);
 		}
-		fallthrough;
-	case ATH11K_SCAN_STARTING:
+
 		ar->scan.state = ATH11K_SCAN_IDLE;
 		ar->scan_channel = NULL;
 		ar->scan.roc_freq = 0;
-- 
2.25.1

