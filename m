Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49E140B516
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Sep 2021 18:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhINQoD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 12:44:03 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:38957 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhINQoC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 12:44:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631637765; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=RtHeM4fpoSVMko9E/IZR7kw3BPixXMNIElHptLzcLK0=; b=oNKmR19KI99ZZD0fEFzSKa3Ujv4AQfBk4lhAPi7rZTYYEI8sHVtAFkEa0Mr8qecfCc0WcYSf
 sKiJxOUg5+Xi9dnTxp1H1V2/UAUCnz3b+1d1fyGLmSKh9UKP07PgYSw+fUxA1Kkn8rHkU+Wz
 T7RBRJn8Jgrm3j11I3RELEMZlGU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6140d0f9648642cc1c61eee7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Sep 2021 16:42:33
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CC87CC43616; Tue, 14 Sep 2021 16:42:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-72-211-nat.elisa-mobile.fi [85.76.72.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BAEBCC4360D;
        Tue, 14 Sep 2021 16:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org BAEBCC4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Wen Gong <wgong@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 2/3] ath11k: indicate scan complete for scan canceled when scan running
Date:   Tue, 14 Sep 2021 19:42:25 +0300
Message-Id: <20210914164226.38843-2-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210914164226.38843-1-jouni@codeaurora.org>
References: <20210914164226.38843-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <wgong@codeaurora.org>

ath11k prints "Received scan event for unknown vdev" when doing the
following test:
1. trigger scan
2. wait 0.2 second
3. iw reg set or 11d scan complete from firmware

Reason: When iw reg set or 11d scan complete, the new country code will
be set to the firmware, and the new regdomain info indicated to ath11k,
then the new channel list will be sent to the firmware. The firmware
will cancel the current scan after receiving WMI_SCAN_CHAN_LIST_CMDID
which is used for the new channel list, and the state of ath11k is
ATH11K_SCAN_RUNNING, then ath11k_get_ar_on_scan_abort() returns NULL and
ath11k_scan_event() returns at this point and does not indicate scan
completion to mac80211.

Indicate scan completion to mac80211 and get rid of the "Received scan
event for unknown vdev" print for the above case.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <wgong@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index d11022455d97..613362b28d8e 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -6289,8 +6289,9 @@ static void ath11k_mgmt_tx_compl_event(struct ath11k_base *ab, struct sk_buff *s
 	rcu_read_unlock();
 }
 
-static struct ath11k *ath11k_get_ar_on_scan_abort(struct ath11k_base *ab,
-						  u32 vdev_id)
+static struct ath11k *ath11k_get_ar_on_scan_state(struct ath11k_base *ab,
+						  u32 vdev_id,
+						  enum ath11k_scan_state state)
 {
 	int i;
 	struct ath11k_pdev *pdev;
@@ -6302,7 +6303,7 @@ static struct ath11k *ath11k_get_ar_on_scan_abort(struct ath11k_base *ab,
 			ar = pdev->ar;
 
 			spin_lock_bh(&ar->data_lock);
-			if (ar->scan.state == ATH11K_SCAN_ABORTING &&
+			if (ar->scan.state == state &&
 			    ar->scan.vdev_id == vdev_id) {
 				spin_unlock_bh(&ar->data_lock);
 				return ar;
@@ -6332,10 +6333,15 @@ static void ath11k_scan_event(struct ath11k_base *ab, struct sk_buff *skb)
 	 * aborting scan's vdev id matches this event info.
 	 */
 	if (scan_ev.event_type == WMI_SCAN_EVENT_COMPLETED &&
-	    scan_ev.reason == WMI_SCAN_REASON_CANCELLED)
-		ar = ath11k_get_ar_on_scan_abort(ab, scan_ev.vdev_id);
-	else
+	    scan_ev.reason == WMI_SCAN_REASON_CANCELLED) {
+		ar = ath11k_get_ar_on_scan_state(ab, scan_ev.vdev_id,
+						 ATH11K_SCAN_ABORTING);
+		if (!ar)
+			ar = ath11k_get_ar_on_scan_state(ab, scan_ev.vdev_id,
+							 ATH11K_SCAN_RUNNING);
+	} else {
 		ar = ath11k_mac_get_ar_by_vdev_id(ab, scan_ev.vdev_id);
+	}
 
 	if (!ar) {
 		ath11k_warn(ab, "Received scan event for unknown vdev");
-- 
2.25.1

