Return-Path: <linux-wireless+bounces-23922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D85AAD32D4
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 11:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8285C3A2493
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 09:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FAC28B7C7;
	Tue, 10 Jun 2025 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kaf4OpXi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B834928AB00
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749549308; cv=none; b=npe1wrS6u341EjtZkRswge8Lpx6X+pFhfVoryTDx/m6OyYPCCBZP0CTq4d/fdJn8DMmqWpbCi3Rhr/KbfoLO1DGSLv8tYbZaw3l60KzPADO+2SLVBTshcmMXpO2176KYCUtXhWfTa6kZ9GebYL6MCqBhp9WAznSQHdcQsaqkoYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749549308; c=relaxed/simple;
	bh=5jSWyT1nFmAwe9i4PRzWjtl0fgv4g7Af3UKC2oM4ikU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PfTtPbjyRKe1yU+6O7cB5LcuQTirHeRPc7N/BT/PbBxkgR5G8M3tq4J/hzdtyZus9TYThEck6GLAJ9GbDqgLOO5phsROI0owW5o2BZqKVmmTVXYW7rTk9/MGpVboT2zXmV4N35r+hh+Lrt9c474VrhtRqVcABEP+de9MdqMXEFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kaf4OpXi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A9HoEt012049
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 09:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=rwM6K9FwSFnupKLaninX8B07kLQ2nLSTQ9j
	4rNbLFi0=; b=Kaf4OpXi4t8PatruiINgPj6DTkODJDn/a+jgAOUk9FUFkWvA3OV
	Fwrv92elAb501L6E5akHmpzvLiWMMonKh4GfE4wifspbjSiSjyHc1Yry8bMNZ1ZR
	09PYRj0my89NbyzlKFtoxjIDJ+V1J0HXA3ExbHj1u+9JI6B/97Sh0ucLSthXHSQd
	V4tk9Jk7MgqTHbtMpLn6H6vbzvZEoa3CT+Z+jGhW3kodMyZS0Q5nRHanH04Xwuuj
	Vjc0t5VufTPNW3KZcTedqSDirPDhmAewg5eyiFwVFORXF95dg0Id9gSTuUYmRH/t
	MfsT/hXowMqlEETrbVNvsDfrkVpfdc9jfRA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474ekprp4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 09:55:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2349fe994a9so38566635ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 02:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749549304; x=1750154104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwM6K9FwSFnupKLaninX8B07kLQ2nLSTQ9j4rNbLFi0=;
        b=SPr/GvsrPTks943fMwoObq0kXK6LAiPJEELdoQ6Cc2/aCUDkiJnBzinarFvhHCTzCX
         qM1Dd6PhVn+32RaEG3vraaxSVshMMH/TKs9m8tl+lc+Iz9ieJUKdn6DDYX14UBwj9VwN
         uaqlAklyi/cB3intFp+2nIkkC1cAospN8pzcq1ps5yiLCWssJu5cwnulbb2GR6Q2jtsX
         OeA+rSXN30BbwFTbjeHzQh7mhfq6SKcqmxSaLUZY4TwQk4MXQdbi5MNjY0z2sr9aMeeG
         NKoiKqBb1SwSGV6Ts1qsqqydAGgGxcf6dfzTi5pEUBz3zRlIj3/kDpyB4VWZrhNZ7Dg7
         NO/w==
X-Gm-Message-State: AOJu0Yx5jDmCpaD1BGrqMcB4xgFkOLsEPqf7k9g766UEx8fAX7pcQ4mA
	MVdynFpP33ouDH8tNpmwzdVwenRvU9ILkmzQyT6LDSJLDGDKnp5xG80qfRRb6AJvJgkAz9eHHCT
	LDqjZr7zA9XPGwJv5ITwgRB002eM6omB0OFJ1oRYASO9UylqYL/BCgEkEsIjgvLP9DY6xCA==
X-Gm-Gg: ASbGnctbJhXKiSsDTnGd0D/a8HIABI17zprp6os3tfXZR6tTpkUuhlNxMsmCA8yZFcl
	jfqhomsnvgegRzfQlAta0MLn0wEXAdhy9LQIIkPPTofYAjTmER2ltWxiXZm+b6p0TQASuLBp3q/
	S3/EMPK3FAlNWQvWjYQiWOPVuMAvf6AqHY20Z5ZiZsd01KiaEbB9JyZ/Lk8Bt94HkP2L3oto+ZJ
	RiA9dWIH4K+XeoRmEwdPC8fQA25cLW0sycaKfIXf18BlAASwupJthdPZMQh94eOh31gjcml+cLa
	e2MyxMSsBtsQrn9SrxrGH8V2ZtzxGxfy9+jQfvOfG8Tzoc/ctp0JQTXNYk1C9ag/8tilfPKA0JP
	hfMN3bCQSuRrlp9Lea8JFCOunrr5jUbx+VS/v
X-Received: by 2002:a17:902:ec92:b0:235:f298:cbb3 with SMTP id d9443c01a7336-23601d05c8bmr192831395ad.18.1749549303524;
        Tue, 10 Jun 2025 02:55:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENJTPj0+87IAYLb+lQKvUeL/bTfrMDZHWh6+Kba3duXAIV/pJxFEnE7OEu9edJ/PV8brjM1Q==
X-Received: by 2002:a17:902:ec92:b0:235:f298:cbb3 with SMTP id d9443c01a7336-23601d05c8bmr192831125ad.18.1749549303042;
        Tue, 10 Jun 2025 02:55:03 -0700 (PDT)
Received: from QCOM-kZLYnuwaz1.na.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603410974sm67303355ad.201.2025.06.10.02.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 02:55:02 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath10k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next] wifi: ath10k: shutdown driver when hardware is unreliable
Date: Tue, 10 Jun 2025 17:54:55 +0800
Message-ID: <20250610095455.1443-1-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JcO8rVKV c=1 sm=1 tr=0 ts=684800f8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=_pHpjG28dqLtJ1xko5AA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA3NiBTYWx0ZWRfX1eGFEyUxR/Tx
 fwFS04duSm0on1+rhvm14BKmOj18UHiBfSpuvsVJmEU4ajHpYE1FlzDp45mchi832ZGE0PQwOu+
 uPUlaow3PwRgie9xHRqStPkGEcuo2uOTJZIIyhf1y1iBSMLVxHbHfJtSTxIBndG7qhoK4B9U1A0
 pOEtsiDdswHgoDMIgHM9cwMjJpy1UHecuk96gBA4OoD9c9IT8z5uftzt6eDq60WQDBU8j9NWSh3
 dHUaURPCQ5XqvPn+RlWe93Ajdvn10CfeXPa98NgfhGB8Cegqebixfg0H50eCPeKdP6hMXsg0iPt
 Qe3C4P2paTx99Zypunexb0OKrkT5/rNpoGj+UJaWjBSLZn3Wj72el1XHJlKgMcp8WcJlIXwZRKF
 1YcKzK7rTf2f9AwwDWexot2RJSKnlyOH1QzaupcgGTHRtGERwUGqkE6hQWpqbja+Hn/CgbJv
X-Proofpoint-GUID: Gg-S6p17emRKAgvzmi0A-1i3SkQgNFYV
X-Proofpoint-ORIG-GUID: Gg-S6p17emRKAgvzmi0A-1i3SkQgNFYV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_04,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506100076

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
 drivers/net/wireless/ath/ath10k/core.c | 50 +++++++++++++++++++++++---
 drivers/net/wireless/ath/ath10k/core.h | 11 ++++--
 drivers/net/wireless/ath/ath10k/mac.c  |  7 +++-
 drivers/net/wireless/ath/ath10k/wmi.c  |  6 ++++
 4 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index fe3a8f4a1cc1..f925a3cf9ebd 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
  * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/module.h>
@@ -2491,12 +2492,51 @@ static int ath10k_init_hw_params(struct ath10k *ar)
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
+	ath10k_dbg(ar, ATH10K_DBG_BOOT, "total recovery count: %d",
+		   ++ar->recovery_count);
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
@@ -2532,6 +2572,8 @@ static void ath10k_core_restart(struct work_struct *work)
 	struct ath10k *ar = container_of(work, struct ath10k, restart_work);
 	int ret;
 
+	reinit_completion(&ar->driver_recovery);
+
 	set_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags);
 
 	/* Place a barrier to make sure the compiler doesn't reorder
@@ -2596,8 +2638,6 @@ static void ath10k_core_restart(struct work_struct *work)
 	if (ret)
 		ath10k_warn(ar, "failed to send firmware crash dump via devcoredump: %d",
 			    ret);
-
-	complete(&ar->driver_recovery);
 }
 
 static void ath10k_core_set_coverage_class_work(struct work_struct *work)
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 446dca74f06a..06ac95707531 100644
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
+	u8 recovery_count;
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
 

base-commit: 2b404d0c06adaeeebd355bd727ef600706b28197
-- 
2.34.1


