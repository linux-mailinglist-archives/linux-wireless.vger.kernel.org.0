Return-Path: <linux-wireless+bounces-15792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132929DBB87
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 17:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8363EB2314F
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 16:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CB619923C;
	Thu, 28 Nov 2024 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMiU9HRf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B841C07E3
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732812633; cv=none; b=ogOAC5cW9G/5+FJvjs+S6YwDMo3tMG/3rB0mC+U52lsI/GWZA2foSYNpOBFJenU9UyDdjLSQIkp5ZLQ0z7EQFF0bY+iu8oyumqBr3wHMyyQbm/BfXsdt8FOxT2AZK9HHlv2/ntcYc6x8bDLVySoCEKE67FoG04tW9e9aGSZsfkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732812633; c=relaxed/simple;
	bh=BoFTlv8IYSdceKXzWgSlOIIQHGJO4tWrQfVL0fVBu14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HbJlKoEWPm/cXbUF4PJEaU85bUnUeMq/mKGJp08nfkFPY55gvKLC73n16lOuR3Zo5o6pxYljxYtPwcD27K9TGb6buaMkO8kOYzI8mhyxiIasHU2N+GZY+UgVrvBSw/EowcPpuibsPTcsTczNxFUFe6+6cwh9nkNdMKk6mQ9HOxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMiU9HRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1761C4CED4;
	Thu, 28 Nov 2024 16:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732812633;
	bh=BoFTlv8IYSdceKXzWgSlOIIQHGJO4tWrQfVL0fVBu14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kMiU9HRfG6J+G1qIhA7wFe0kxZVHV+2KdEkYtP5dO0DjdpT9A8liCu32/k0NW4ELL
	 x+SgyxBTKjFse1qBSpEmHfEvDoXB1NnJb5VhVuQd0rwEeQhPs2COfnq9rTC6PN7nDo
	 2MLAt4rQ4o53zcRHY1yrvLOSt9Kol1Z/cY8o5dVQOJouXsTAh7b0ym7IMOkcvSATlZ
	 vp5cMjaBfZtLKWDOn06e2xztOs+Z3/4Q2T88z5pwNR1cob09s0qs9ZRfPpnjo/Bi8J
	 MX3YGn40XRj2xgUFxtgT82qK07YziYKRu+Hjh6VAq+D6xQR4U5C5CG8sp7b35cej+c
	 7eB7JqJ/qtn+g==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 4/4] wifi: ath12k: introduce QMI firmware ready flag
Date: Thu, 28 Nov 2024 18:50:26 +0200
Message-Id: <20241128165026.2618331-5-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241128165026.2618331-1-kvalo@kernel.org>
References: <20241128165026.2618331-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

When hardware device group abstraction is introduced, the QMI firmware ready
event of different devices in a group can be received simultaneously. To
indicate the firmware ready event is completed for a particular device in a
group set a flag (ATH12K_FLAG_QMI_FW_READY_COMPLETE). This helps the upcoming
hardware recovery implementation for hardware device group abstraction.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  2 +-
 drivers/net/wireless/ath/ath12k/core.h |  1 +
 drivers/net/wireless/ath/ath12k/qmi.c  | 12 +++++++++---
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 386d42db29ac..4da147f7bfac 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1145,7 +1145,7 @@ static void ath12k_core_reset(struct work_struct *work)
 	int reset_count, fail_cont_count;
 	long time_left;
 
-	if (!(test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags))) {
+	if (!(test_bit(ATH12K_FLAG_QMI_FW_READY_COMPLETE, &ab->dev_flags))) {
 		ath12k_warn(ab, "ignore reset dev flags 0x%lx\n", ab->dev_flags);
 		return;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 4bfc7a7cc894..9ddced140056 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -228,6 +228,7 @@ enum ath12k_dev_flags {
 	ATH12K_FLAG_HTC_SUSPEND_COMPLETE,
 	ATH12K_FLAG_CE_IRQ_ENABLED,
 	ATH12K_FLAG_EXT_IRQ_ENABLED,
+	ATH12K_FLAG_QMI_FW_READY_COMPLETE,
 };
 
 struct ath12k_tx_conf {
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index f5388eae01dc..77d8ee14bf33 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -3033,6 +3033,8 @@ void ath12k_qmi_firmware_stop(struct ath12k_base *ab)
 {
 	int ret;
 
+	clear_bit(ATH12K_FLAG_QMI_FW_READY_COMPLETE, &ab->dev_flags);
+
 	ret = ath12k_qmi_wlanfw_mode_send(ab, ATH12K_FIRMWARE_MODE_OFF);
 	if (ret < 0) {
 		ath12k_warn(ab, "qmi failed to send wlan mode off\n");
@@ -3336,7 +3338,7 @@ static void ath12k_qmi_driver_event_work(struct work_struct *work)
 			break;
 		case ATH12K_QMI_EVENT_FW_READY:
 			clear_bit(ATH12K_FLAG_QMI_FAIL, &ab->dev_flags);
-			if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags)) {
+			if (test_bit(ATH12K_FLAG_QMI_FW_READY_COMPLETE, &ab->dev_flags)) {
 				if (ab->is_reset)
 					ath12k_hal_dump_srng_stats(ab);
 				queue_work(ab->workqueue, &ab->restart_work);
@@ -3346,8 +3348,12 @@ static void ath12k_qmi_driver_event_work(struct work_struct *work)
 			clear_bit(ATH12K_FLAG_CRASH_FLUSH,
 				  &ab->dev_flags);
 			clear_bit(ATH12K_FLAG_RECOVERY, &ab->dev_flags);
-			ath12k_core_qmi_firmware_ready(ab);
-			set_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
+			ret = ath12k_core_qmi_firmware_ready(ab);
+			if (!ret) {
+				set_bit(ATH12K_FLAG_QMI_FW_READY_COMPLETE,
+					&ab->dev_flags);
+				set_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
+			}
 
 			break;
 		default:
-- 
2.39.5


