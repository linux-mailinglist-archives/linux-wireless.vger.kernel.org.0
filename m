Return-Path: <linux-wireless+bounces-27574-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6D2B8F48C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 09:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902114202E8
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 07:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABE42F3C0E;
	Mon, 22 Sep 2025 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BBeqxi6l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB883212578
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 07:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525882; cv=none; b=J5LOY0CeEs0gUgfm9BibTgFCCVv4lrF+vM+FrtgTIl0+gmlFkdVOlCL2xiWAKXBylGl9bqt6RUt6+IfnGExLT5sRvTRvJBV2sy+MVVRrnYUw7wK2C7PD3E2DjGKAaMSs9jmFVI/4ae4CYJz5nqWulbnXnliU+5uhpmmPLoXNBA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525882; c=relaxed/simple;
	bh=GjAQUhMTEOpQrUv+mL692tqGAx6epjwPzEl3I1N0mIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YtHBCbJOOWIdFuN6prwOITlj6IkkvOVRnc8RScT2QifebSk9ktRELvUrcJpcpAFGPJL5a2kQktOeWVZ7tmFHCjuvyfNlRcVI7s+caQi9g9k8dDLhNWZJoP3nTcUknOzZYh0HnmZlNlWNtoLQXPRL1QrcNUaDR1LX/B5NFscxNDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BBeqxi6l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LJR3gW031584
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 06:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=WuWSEjSRKMzPhB9hziIu6w87qOwsQjUbMS6
	R9W6SG6o=; b=BBeqxi6l6zXcnOH3b/EWHAFMGRm8EAaEnEwn2n51dcPK9kxi27D
	ebO5zhNaa9hTU6y27ecg9nkKDALVTXWHx6Q98rwI71IIbQIoKYOYDojfG0f4ubNm
	LBEbQazGJdjg9HF98xOWvRZuI6MqGQ3bqCI06JacSsjfC03wycUrW/Ae+cZ4x6zU
	fo8CL7snk/gcSAfDankjjCCXxVStOQ0/DtO//wC6yqeEzduKTZ8CDLTBABA0B6A3
	vJ0CFx96TkluvzdDx1c1ey0CBHvMUwTK5ETf8SC8e7BLYXgaFQnnQOx52Py/uk1N
	tr0CCL2Wqil+aaSdXoS4rhnsPH4pdFkBRyg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499nj8ug5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 06:31:20 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so3717634a91.2
        for <linux-wireless@vger.kernel.org>; Sun, 21 Sep 2025 23:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758522680; x=1759127480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WuWSEjSRKMzPhB9hziIu6w87qOwsQjUbMS6R9W6SG6o=;
        b=CBGSGMVCdapvR1tNFBD6KIl/+5vjO8/9D6g9JvZ0se2mDeoG8JF8hlFRntT3loC2M+
         aRGPoa0lKAtrx++zfd8kW9kgnVf4TV+vjpxEiTcPxEp3tZq+VzkxdhPbXaUqYzs6sLrQ
         P4UTyUsgHgqG58u387Bz9ucKMV8M64zAm8W8O7rVppzOe+nzI9qQY2Y5spvr7/DAe1My
         p+wlCGqkjxa3C/MaD26Z2l9h6ZvhbP9aG7LlGaFRXHW0MjrDd+z+QlD/6LeMGUtkY9AG
         3c0OSUlNernQVaYx2HY+ivzcfxCZfV+KZdb+uoCDvLZ0wE0jnXcckHFhgIKuMGkfWPFU
         i8lQ==
X-Gm-Message-State: AOJu0YyVqBLKq69OYwRCQBF+8+0HZrwZUmHvO0u3+Wu1JXXJxC90EumS
	zbs4uJZmTQYnJh2+GJ6M/r2W0jRsaeho6WiPYNxg9kvEVqvweBkDfGHp5qy0vl08sncAoZebeLH
	BW0f6Ho8C+7XMp0ZIzWk4ljBoy3OinT//pnPeoXKopc2az9f49S5ceM5ymbGoT9PvJAKMMg==
X-Gm-Gg: ASbGncuYUgtNoz3U6LLmlOSiNvjPGE5jIl8EK5e+n7jiFClBwnK+F4Pvj6ASgBcJnbX
	/H/RrgP3UDfkBXzAhylt60gNtKsseXQKiKMeE72insORf+Dysj3nIVdBMSfPabxRbU9SCee1YXU
	7Po9l10D2ZzgzW32c3sHUDbXkvb2XQlKH/N7wufXZF/alEKMc+XG4S4AXLKP9Yc9GHaVQA2KExE
	OsPzk0A6GrWmkqmBEuurk5OMEYWMOCntXTfk4xoIf/REU7FsbhXd+3kvSUTAwsZq5AzDoMb+VVm
	zAM6uuOoOIslDD2J8Sh9fXJt8sWseVhoVKcqvMSyjnK89yzGs0kYiuQSMKxxAaYkWHwd39FF/vk
	RgC9KoWaRX1LHmRURSLpUbDRHAiIhHsiGJ+QhCeNgk2ZmTZnn1jCNCg==
X-Received: by 2002:a17:90b:498e:b0:32e:2059:ee5a with SMTP id 98e67ed59e1d1-33097fce1b2mr13555942a91.8.1758522679730;
        Sun, 21 Sep 2025 23:31:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPg4Vo2ZWkfT8rcOT5PW8V46H0hIv8TDVTcIxU0I4cjOzErGj0xDFQ04Ve3mdNt4SkOHRCGQ==
X-Received: by 2002:a17:90b:498e:b0:32e:2059:ee5a with SMTP id 98e67ed59e1d1-33097fce1b2mr13555915a91.8.1758522679128;
        Sun, 21 Sep 2025 23:31:19 -0700 (PDT)
Received: from QCOM-kZLYnuwaz1.na.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b5516b997b3sm8344643a12.0.2025.09.21.23.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 23:31:18 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath10k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next] wifi: ath10k: move recovery check logic into a new work
Date: Mon, 22 Sep 2025 14:31:12 +0800
Message-ID: <20250922063112.1324-1-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dZ6A3WXe c=1 sm=1 tr=0 ts=68d0ed38 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Z503FGabStPfIb0gwUgA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: N32Dhxja8kG4_4fXKMZpq6tdSdimvEqG
X-Proofpoint-GUID: N32Dhxja8kG4_4fXKMZpq6tdSdimvEqG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDA0MyBTYWx0ZWRfXyFY0439D+uGi
 OkIwD1x35WJUkt+ErdzO0rZZ+YCRaoXzTufs1LdNLSGEuoIXk+xrOIRsFbPSA/DbjNLoi5Wtvou
 2PiaGwWVmEx5ahowZxGvjOG3eXXE5UM093qmilAaaaj7dDRXNOD2rqo0lNFQc+iVwoUZtWbdpsi
 UfCFSGMrKskCT99Di/uyjN4HW9qlA00NcoyFJqkcpx6R3LZ3VCJ9La8oe3YvrlhYNkFjbdN/cIU
 aGMZIccqJbWLF5H1D+g/6/x6azGz4zlVgv5QbfdjMI7s5AZURFPdd0YcvHNvDOKWWFGgvTtNIgt
 y3oegi+/BmrVWXjG/cdivSj/iaQgAEXhUROtWqk/rRYWwxWDBAzUhuFPwbd6yjCYdsNIj1b9srq
 DXvK6aMt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200043

Currently, ath10k has a recovery check logic. It will wait for the
last recovery to finish by wait_for_completion_timeout();

But in SDIO scenarios, the recovery function may be invoked from
interrupt context, where long blocking waits are undesirable and can
lead to system instability.

To address this, move the recovery check logic into a workqueue.
Fixes: c256a94d1b1b ("wifi: ath10k: shutdown driver when hardware is unreliable")
Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/core.c | 19 ++++++++-----------
 drivers/net/wireless/ath/ath10k/core.h |  2 +-
 drivers/net/wireless/ath/ath10k/mac.c  |  2 +-
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 6f78f1752cd6..991fe8d92297 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2005-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
@@ -2493,8 +2492,9 @@ static int ath10k_init_hw_params(struct ath10k *ar)
 	return 0;
 }
 
-static bool ath10k_core_needs_recovery(struct ath10k *ar)
+static void ath10k_core_recovery_check_work(struct work_struct *work)
 {
+	struct ath10k *ar = container_of(work, struct ath10k, recovery_check_work);
 	long time_left;
 
 	/* Sometimes the recovery will fail and then the next all recovery fail,
@@ -2504,7 +2504,7 @@ static bool ath10k_core_needs_recovery(struct ath10k *ar)
 		ath10k_err(ar, "consecutive fail %d times, will shutdown driver!",
 			   atomic_read(&ar->fail_cont_count));
 		ar->state = ATH10K_STATE_WEDGED;
-		return false;
+		return;
 	}
 
 	ath10k_dbg(ar, ATH10K_DBG_BOOT, "total recovery count: %d", ++ar->recovery_count);
@@ -2518,27 +2518,23 @@ static bool ath10k_core_needs_recovery(struct ath10k *ar)
 							ATH10K_RECOVERY_TIMEOUT_HZ);
 		if (time_left) {
 			ath10k_warn(ar, "previous recovery succeeded, skip this!\n");
-			return false;
+			return;
 		}
 
 		/* Record the continuous recovery fail count when recovery failed. */
 		atomic_inc(&ar->fail_cont_count);
 
 		/* Avoid having multiple recoveries at the same time. */
-		return false;
+		return;
 	}
 
 	atomic_inc(&ar->pending_recovery);
-
-	return true;
+	queue_work(ar->workqueue, &ar->restart_work);
 }
 
 void ath10k_core_start_recovery(struct ath10k *ar)
 {
-	if (!ath10k_core_needs_recovery(ar))
-		return;
-
-	queue_work(ar->workqueue, &ar->restart_work);
+	queue_work(ar->workqueue, &ar->recovery_check_work);
 }
 EXPORT_SYMBOL(ath10k_core_start_recovery);
 
@@ -3734,6 +3730,7 @@ struct ath10k *ath10k_core_create(size_t priv_size, struct device *dev,
 
 	INIT_WORK(&ar->register_work, ath10k_core_register_work);
 	INIT_WORK(&ar->restart_work, ath10k_core_restart);
+	INIT_WORK(&ar->recovery_check_work, ath10k_core_recovery_check_work);
 	INIT_WORK(&ar->set_coverage_class_work,
 		  ath10k_core_set_coverage_class_work);
 
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 8c72ed386edb..859176fcb5a2 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -3,7 +3,6 @@
  * Copyright (c) 2005-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
@@ -1208,6 +1207,7 @@ struct ath10k {
 
 	struct work_struct register_work;
 	struct work_struct restart_work;
+	struct work_struct recovery_check_work;
 	struct work_struct bundle_tx_work;
 	struct work_struct tx_complete_work;
 
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 154ac7a70982..da6f7957a0ae 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2005-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
@@ -5428,6 +5427,7 @@ static void ath10k_stop(struct ieee80211_hw *hw, bool suspend)
 	cancel_work_sync(&ar->set_coverage_class_work);
 	cancel_delayed_work_sync(&ar->scan.timeout);
 	cancel_work_sync(&ar->restart_work);
+	cancel_work_sync(&ar->recovery_check_work);
 }
 
 static int ath10k_config_ps(struct ath10k *ar)
-- 
2.34.1


