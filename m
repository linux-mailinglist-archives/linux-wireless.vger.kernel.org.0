Return-Path: <linux-wireless+bounces-24330-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B30D2AE3390
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 04:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47BF2188C8C7
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 02:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A183F433A8;
	Mon, 23 Jun 2025 02:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kg7SeKqe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2F82EAE5
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 02:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750645665; cv=none; b=sxwa8OmMKd3jL5zSLhkjR7u81gkF8SdGDGyuh7pECbDR4LPJPm/TmpzEQEgfyM6Wc9ATLcZ1hy91yWP74sY0WkYtm1w9/tPAiWSWLdj42tjT4TiS0wt+7Am+EsvR6LQv5Rb8RC/C93JP68a9G5GlBMHtXMroG2mbBG8DPh8R2MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750645665; c=relaxed/simple;
	bh=4tIywdXg+V7lz9ibwJa1isr4tU8iBplDAY7FZL8OAuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OD1+mddfGZH4T+fzcOLboNPH95QZc91pHtRwIgvBTa/I9oQMYqeOQPVe00Itye4vSBU6SuiOs26FW0PCulFDMrx4sm1FO+orsJrYDXplq+RMbndRdfH6RtBx+P3FEBI02l33DtksAbSMG6U6SQJsbGr590RoLkGYNSatOnd7Qvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kg7SeKqe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55MNsS90004719
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 02:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=fv+ixPSJtejQRVxtJoz+UfYuX/HmFheUie4
	HGlhLBDg=; b=Kg7SeKqeewMhvDNU7A5q5fAWiBEpUgRBJNELcPfhjrtCFWWxy2d
	Y98T5oU7MowJhAKtgmGNjm+WeQevDJSN3GSdXU7lwIsIcPofeyFnFmVSQAEFA0qL
	BmseGorrcKqUFkyQTzwh1B0kKSwoSh0dt414OngL9xT/hOucgMmYd+uJRMdPpcIL
	T/4Rg9j5885ruWl5XNqU5rduuNFetUbWuKkqBng1cMK6uK5BRFpDcc1F8ZzK46C5
	hZmABr/hfG6wECMQhokFF/bfICZrm24gCSIm3rbdlhOdz9Y1wvD7IA9u0DW3ZKzZ
	vVYUpf+OPltaASeucAA3/SOgTmZbzUFhfow==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ege0rwge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 02:27:41 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-234b133b428so26751745ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jun 2025 19:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750645660; x=1751250460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fv+ixPSJtejQRVxtJoz+UfYuX/HmFheUie4HGlhLBDg=;
        b=OjvFIqwOMu1PenkW0OZWfQDOf4FqSIx7Ux2ZE7/PK+CX03Y5m2udDeYbZvhSNaKdYy
         7kRCQsIHYAw7JuxD5rWFeNYLQzPM/hIYLalwQp87UgcfhAL/dtwMijW+ZabN1GvEDYDb
         r4g23j2Y8HnDBvPbO4tfTWldW1ACfsydkzvy0RP+/NXp9yd7mKtsdB7vFAm7j8AM5Bvj
         AyAkUzNnERfpraTwuQSCKiwBBOOaJgv3ALS4QK+HuSjLWxDrvjJu8rcaW2ctUuTQN583
         Z1W7QYSpCuHK7JQRVCrXdm0CFr5EPHZfc+gTaJVDtntZcHeypQMWyKr55a4NIgGZ+F9j
         3bCg==
X-Gm-Message-State: AOJu0YxkWF1kBf+oZ2/DpP4eBzvLg9yOT3smMkTkvdlo4lLPGjYSjBtK
	wlqFyGRG+tH+0+9XMoF/3FlSG4gxy3tFPj+4Jh2EYSCXx1HSZ+6L4JtY13WMtkGYECCgca7PJ/4
	ec+1A8hHoPAkYrC1M9Z1TqKRrb8MViY1s1dX00rrUvh/oTSSBxhJywgqH/U7Ef6zwNNoiCU0V+N
	gsJg==
X-Gm-Gg: ASbGncstS0/6FZBL6JYTqma2m3m+USAW4F/nK+33OyytBQgRNFp423300jjFVuzZ8qH
	nJOF7ItUfCup/TLdYbeiSKBfrBOTOAHCNXZ8uoW+uqSppNeHQD3Q7Lnj/cR6l1g06+qrLfrWXl5
	WCBpbLndYdCqtT1MSn4AClmnpRcLI4oqyQHpZXP4GYmvarsW+l402NWWGG1nuOaCw8Y8MHDrxXb
	AXu5Ilejl9Rk6+4otWu0Xm24yEKa+9NyKZBIqpWwaf5X+lCeG59dB1qD7jhCqNcH82JCQs8UnVa
	+dLXDsgVFRb22vvZOX7ERH8d9zgyNa6J/wCoM1g/w9K8fC3tF1GYXLmUEtn9gN6nyvyE4JyTudw
	fAG/D5m1Is3R9VwhOKiJ0e8TFzQgmCFjXZBkm
X-Received: by 2002:a17:902:fa4e:b0:234:a033:b711 with SMTP id d9443c01a7336-237dc1d4cafmr113151525ad.50.1750645660362;
        Sun, 22 Jun 2025 19:27:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO3xLwcDfFF+8FdVv1bm8qSft+zUbFnRdWwk8fQS8JrzjoriuMczR2Bh5iYmWDptTaDD+zFQ==
X-Received: by 2002:a17:902:fa4e:b0:234:a033:b711 with SMTP id d9443c01a7336-237dc1d4cafmr113151305ad.50.1750645659810;
        Sun, 22 Jun 2025 19:27:39 -0700 (PDT)
Received: from QCOM-kZLYnuwaz1.na.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83936bdsm70645755ad.21.2025.06.22.19.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 19:27:39 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath10k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next v2] wifi: ath10k: shutdown driver when hardware is unreliable
Date: Mon, 23 Jun 2025 10:27:31 +0800
Message-ID: <20250623022731.509-1-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hr9ynmeritWpmu9vyirEdwA98k2SvQOp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDAxMyBTYWx0ZWRfXxfRzSlLnd6+W
 iUT4TE0rPKdpt4FAKfQf06b0/+g+WsWkK4hM9WIwjp5QY8y4gKAZvqUot+zOi/n0AmiyVahKwHQ
 b0afzgPRXEoMcWOO9gWhy3/A8lx/mPLmgbwoG8Gwy1mGqak+an9EPkjjNSLH6Aa/8/AWEB+8tOw
 zE1Vo4rq/nyVCdDR0tbc1/VRdfWSabQg8eToRUq0uxtHMUK6gxgHMpisH4li2K+APaQ9VcSKzps
 TzdzlRZJ1fPIugexZbSc3LU9yzahdbpzATjCAL9N0cBpM+kf2/StuaFmkl7m0Xz1GIyeFLe9TPu
 3j6AAYAzBcPwGbI/N39+yVbFg0RNnE+gESPu+0hZfoD49lsPsbeULXQTds9ebl2bpOO2O5Ciel+
 5r6WhgGONi93zAFYT9eWBXBfCb5nPTpH+tDbbUgpumptYZo0yS+h2aNd2wYE1UyjxgSPIC9C
X-Authority-Analysis: v=2.4 cv=CesI5Krl c=1 sm=1 tr=0 ts=6858bb9d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=_pHpjG28dqLtJ1xko5AA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: hr9ynmeritWpmu9vyirEdwA98k2SvQOp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_01,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506230013

In rare cases, ath10k may lose connection with the PCIe bus due to
some unknown reasons, which could further lead to system crashes during
resuming due to watchdog timeout:

ath10k_pci 0000:01:00.0: wmi command 20486 timeout, restarting hardware
ath10k_pci 0000:01:00.0: already restarting
ath10k_pci 0000:01:00.0: failed to stop WMI vdev 0: -11
ath10k_pci 0000:01:00.0: failed to stop vdev 0: -11
ieee80211 phy0: PM: **** DPM device timeout ****
Call Trace:
 panic+0x125/0x315
 dpm_watchdog_set+0x54/0x54
 dpm_watchdog_handler+0x57/0x57
 call_timer_fn+0x31/0x13c

At this point, all WMI commands will timeout and attempt to restart
device. So set a threshold for consecutive restart failures. If the
threshold is exceeded, consider the hardware is unreliable and all
ath10k operations should be skipped to avoid system crash.

fail_cont_count and pending_recovery are atomic variables, and
do not involve complex conditional logic. Therefore, even if recovery
check and reconfig complete are executed concurrently, the recovery
mechanism will not be broken.

Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00288-QCARMSWPZ-1

Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---

v2:
1. change u8 to u32 for recovery_count.
2. don't add a new line for debug log.

---
 drivers/net/wireless/ath/ath10k/core.c | 49 +++++++++++++++++++++++---
 drivers/net/wireless/ath/ath10k/core.h | 11 ++++--
 drivers/net/wireless/ath/ath10k/mac.c  |  7 +++-
 drivers/net/wireless/ath/ath10k/wmi.c  |  6 ++++
 4 files changed, 64 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index fe3a8f4a1cc1..7686cf4292e0 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
  * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/module.h>
@@ -2491,12 +2492,50 @@ static int ath10k_init_hw_params(struct ath10k *ar)
 	return 0;
 }
 
+static bool ath10k_core_needs_recovery(struct ath10k *ar)
+{
+	long time_left;
+
+	/* Sometimes the recovery will fail and then the next all recovery fail,
+	 * so avoid infinite recovery.
+	 */
+	if (atomic_read(&ar->fail_cont_count) >= ATH10K_RECOVERY_MAX_FAIL_COUNT) {
+		ath10k_err(ar, "consecutive fail %d times, will shutdown driver!",
+			   atomic_read(&ar->fail_cont_count));
+		ar->state = ATH10K_STATE_WEDGED;
+		return false;
+	}
+
+	ath10k_dbg(ar, ATH10K_DBG_BOOT, "total recovery count: %d", ++ar->recovery_count);
+
+	if (atomic_read(&ar->pending_recovery)) {
+		/* Sometimes it happened another recovery work before the previous one
+		 * completed, then the second recovery work will destroy the previous
+		 * one, thus below is to avoid that.
+		 */
+		time_left = wait_for_completion_timeout(&ar->driver_recovery,
+							ATH10K_RECOVERY_TIMEOUT_HZ);
+		if (time_left) {
+			ath10k_warn(ar, "previous recovery succeeded, skip this!\n");
+			return false;
+		}
+
+		/* Record the continuous recovery fail count when recovery failed. */
+		atomic_inc(&ar->fail_cont_count);
+
+		/* Avoid having multiple recoveries at the same time. */
+		return false;
+	}
+
+	atomic_inc(&ar->pending_recovery);
+
+	return true;
+}
+
 void ath10k_core_start_recovery(struct ath10k *ar)
 {
-	if (test_and_set_bit(ATH10K_FLAG_RESTARTING, &ar->dev_flags)) {
-		ath10k_warn(ar, "already restarting\n");
+	if (!ath10k_core_needs_recovery(ar))
 		return;
-	}
 
 	queue_work(ar->workqueue, &ar->restart_work);
 }
@@ -2532,6 +2571,8 @@ static void ath10k_core_restart(struct work_struct *work)
 	struct ath10k *ar = container_of(work, struct ath10k, restart_work);
 	int ret;
 
+	reinit_completion(&ar->driver_recovery);
+
 	set_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags);
 
 	/* Place a barrier to make sure the compiler doesn't reorder
@@ -2596,8 +2637,6 @@ static void ath10k_core_restart(struct work_struct *work)
 	if (ret)
 		ath10k_warn(ar, "failed to send firmware crash dump via devcoredump: %d",
 			    ret);
-
-	complete(&ar->driver_recovery);
 }
 
 static void ath10k_core_set_coverage_class_work(struct work_struct *work)
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 446dca74f06a..85e16c945b5c 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -4,6 +4,7 @@
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
  * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef _CORE_H_
@@ -87,6 +88,8 @@
 				  IEEE80211_IFACE_SKIP_SDATA_NOT_IN_DRIVER)
 #define ATH10K_ITER_RESUME_FLAGS (IEEE80211_IFACE_ITER_RESUME_ALL |\
 				  IEEE80211_IFACE_SKIP_SDATA_NOT_IN_DRIVER)
+#define ATH10K_RECOVERY_TIMEOUT_HZ			(5 * HZ)
+#define ATH10K_RECOVERY_MAX_FAIL_COUNT			4
 
 struct ath10k;
 
@@ -865,9 +868,6 @@ enum ath10k_dev_flags {
 	/* Per Station statistics service */
 	ATH10K_FLAG_PEER_STATS,
 
-	/* Indicates that ath10k device is during recovery process and not complete */
-	ATH10K_FLAG_RESTARTING,
-
 	/* protected by conf_mutex */
 	ATH10K_FLAG_NAPI_ENABLED,
 };
@@ -1211,6 +1211,11 @@ struct ath10k {
 	struct work_struct bundle_tx_work;
 	struct work_struct tx_complete_work;
 
+	atomic_t pending_recovery;
+	unsigned int recovery_count;
+	/* continuous recovery fail count */
+	atomic_t fail_cont_count;
+
 	/* cycle count is reported twice for each visited channel during scan.
 	 * access protected by data_lock
 	 */
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 07fe05384cdf..9e6f294cd5b6 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -8156,7 +8156,12 @@ static void ath10k_reconfig_complete(struct ieee80211_hw *hw,
 		ath10k_info(ar, "device successfully recovered\n");
 		ar->state = ATH10K_STATE_ON;
 		ieee80211_wake_queues(ar->hw);
-		clear_bit(ATH10K_FLAG_RESTARTING, &ar->dev_flags);
+
+		/* Clear recovery state. */
+		complete(&ar->driver_recovery);
+		atomic_set(&ar->fail_cont_count, 0);
+		atomic_set(&ar->pending_recovery, 0);
+
 		if (ar->hw_params.hw_restart_disconnect) {
 			list_for_each_entry(arvif, &ar->arvifs, list) {
 				if (arvif->is_up && arvif->vdev_type == WMI_VDEV_TYPE_STA)
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index df6a24f8f8d5..cb8ae751eb31 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
  * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/skbuff.h>
@@ -1941,6 +1942,11 @@ int ath10k_wmi_cmd_send(struct ath10k *ar, struct sk_buff *skb, u32 cmd_id)
 	}
 
 	wait_event_timeout(ar->wmi.tx_credits_wq, ({
+		if (ar->state == ATH10K_STATE_WEDGED) {
+			ret = -ESHUTDOWN;
+			ath10k_dbg(ar, ATH10K_DBG_WMI,
+				   "drop wmi command %d, hardware is wedged\n", cmd_id);
+		}
 		/* try to send pending beacons first. they take priority */
 		ath10k_wmi_tx_beacons_nowait(ar);
 
-- 
2.34.1


