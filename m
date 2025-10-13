Return-Path: <linux-wireless+bounces-27949-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAA9BD1786
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Oct 2025 07:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F863BBAA7
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Oct 2025 05:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9142DAFC0;
	Mon, 13 Oct 2025 05:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UR/sLGXw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A92C2C11EA
	for <linux-wireless@vger.kernel.org>; Mon, 13 Oct 2025 05:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760333591; cv=none; b=D81lyseVH0egtMeAzgJKU681jkrrKYT2IxOZNCuJw6bJ9dnHzmOMnNAOR/r9lJZXNw6LwZ2rMBaGamVesiWy+UWPK151OWUmmtrVi8wzF977zxEjMcRTcEcYtOrjkakvWrGPs0JZJxGDO3ATeUV/riDNLWY0JMK22r1Q3QrXOmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760333591; c=relaxed/simple;
	bh=geVR38dQfvcy3aP3pZc1q+/X3CBoC/ZFpXnViPLun0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZU84oxWT3HE2qx6kMvXYrPm0ZesCuUG1swRcerMNMKA//Yn/YowpxOvP0B3I0bmGpzHRpqZTF3akt+zGTrBSTAod4cXAAxDzACqIDOIu/FXlJi8v25mmsv50WXuL2bamlPCLBJWw70s7IUNtMhGkQR9tOyECMEHIRNA1BRxyjaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UR/sLGXw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2n5Qb021336
	for <linux-wireless@vger.kernel.org>; Mon, 13 Oct 2025 05:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=+JLPYm/QovvV6JtQrMtLB8zdsqJIh02Rswf
	F6pbMMqM=; b=UR/sLGXwn/fES+VmgbxnEDgsJqjeRbe+j0IH22OTXM8HxGfPQFi
	LaUeurrKa/H4dFOcSf6DUpxq+2zrEe/ewHavudP5JPczqSk3SVVfRwEbRiLG+ABL
	Gd4m+DiB2OMgaMWKO+UMMKagrtWs7rypO12Mf3zmOlhlV5wv36IQc7vE5IHbYLz2
	ZljG+p9HVFW2Qxu0/OFNtaWbL462R3IBYgQEKbBfLna34E4+DHm6pMnt2evMMLtt
	Dk4bkI8c/5mTIxoFZYMedSDiZypfnxK6m54D+iSLvjIf8PkjZ3yBWFQZozjKTRQj
	vBqOJrZAbXMG8WwK7h2+jMq7rMKuKOhduig==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgh6391u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Oct 2025 05:33:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2699ed6d43dso78869005ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 12 Oct 2025 22:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760333588; x=1760938388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+JLPYm/QovvV6JtQrMtLB8zdsqJIh02RswfF6pbMMqM=;
        b=a+PqL/GaCRqIf45ZWgbUPrdsgfpRxO6XD6kcjYYHUxnVWkK9JPZGDa9K47F+5Y6gGx
         TTN/8OLTGLcdiagcpQ4wj+Ka4j5mI9RGjPkIot5MTH+ZBnMnkt8ftrT6pG8C5HDCQJ1x
         JNu4AehmGJqFXpEvF8O/BYYjoVynvDZb5Ii7iatBUooBKMgCcLlNtogRhEM2SCVQ5Q/m
         Rw8IhlwXUUHQFaPJP0vLaVTKSk+Lv5W6bARNqQmN1QOAtkhHemi481Ws/USJ/L0gC2Ux
         fgJFv9ne6I3eoz90ySVDcFhhAncfY9l/Pmh4kemTErougR8/ivjHhcO8+5YcjLNoxwmB
         cAwA==
X-Gm-Message-State: AOJu0YxP1sQgYazhpAV/IXj0LzSKYjvHegTITXuv1at/ZCYNXmJzlbO2
	SatAm5pOrGMJT+vChyX626XgcjTzl2Y03ejqWh+CGkGL0AYqz1NysbLNW4y53Pr3uhnytLucxOL
	Twwckd52ds/Sd7q62NWJG0KoMuAgVyOK9xuYRTNMofC58+wGJXkriRFT1Wssb8gwJAmkPyQ==
X-Gm-Gg: ASbGnctbkxPypfzRrTee+bigpKRLSOFS9sg4NKF4fTk5LMzN8lAhyhQaB0Oi5817Zeu
	z88G7TobpT1QAElUzO0nH0iCyavfuuaoe2MMkAUL9fM147uySpkxdDnQN+V99A8OCKNM5ZeU6vm
	HsIGL0fNr5HJARyGl7ODvsotkIa/mpGZK7CHUxLzzlxpC8NWvhMTWmEyqbaQjCNyEi6XmdQ+n+f
	g8k4zxkgdM35CbsCTUvwURBBsNEJ3+qTmllMBt82Q1nHARXijsl0rf1VwTlhBXe+/zXVbp64Fv0
	gF0K0yZgFAto2O51Tsjp60deX5TKwNSlUjt9o3uaIYEt0Tq+szT5QEEphLkrvwbrOn8DOCiRPVj
	48iqEmemkCEuiaQnw8F924Ji2ohSMq7ob4BWaMypH82IG2RwehnVJHg==
X-Received: by 2002:a17:902:f70b:b0:250:1c22:e78 with SMTP id d9443c01a7336-29027356cdbmr259446435ad.1.1760333587576;
        Sun, 12 Oct 2025 22:33:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEz87qSBroiGBY08Eni3jaBdAgzegz482Dg8A2YXyZTc6yOu87rKcVotECndeKNHO0y9VveQ==
X-Received: by 2002:a17:902:f70b:b0:250:1c22:e78 with SMTP id d9443c01a7336-29027356cdbmr259446285ad.1.1760333587072;
        Sun, 12 Oct 2025 22:33:07 -0700 (PDT)
Received: from QCOM-kZLYnuwaz1.na.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de6c88sm122515365ad.17.2025.10.12.22.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 22:33:06 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath10k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next v2] wifi: ath10k: move recovery check logic into a new work
Date: Mon, 13 Oct 2025 13:32:59 +0800
Message-ID: <20251013053259.546-1-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H/zWAuYi c=1 sm=1 tr=0 ts=68ec8f14 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=JPUmt8VSvV4ADWAhxtYA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNiBTYWx0ZWRfX9F8eAl75sDBZ
 OfAlQXPhvDGPdxtQSx1fHqF4JQMpJoQadjsgz41YLtRmOL/GUDescf9Bd+uzNT1oNJ0D8ASutMU
 orgS5vYk6GUQrUDvOBxanDeiqqjHUWXqHqDjtpnvrypI3uXVhxxvrgAc68mgqbhliIQfF5omqJW
 djqxTntPb/pBHJsfGgOhzJ/F9VbYaUHbBHL4X4Fpa59olUxeCVZt0KMn1CzEbTbx9T4qR++hd+w
 CUrJujLgtPYD8Zrb6ncMQh32JLG0T1c4AuRP0m55Cv6lMUzZi6MANtYEzVGsSZIcL7cej+4+VFy
 PmlrnRcV0/zvYPIpVaGRb1zbKnwCkmVN9L+HBq1X+6RTVLDk9iCyNgTcjEIVvP0yyUeXZXuOlhS
 A9PpflvtOPE34woj4LQhzlLY9YqA6w==
X-Proofpoint-ORIG-GUID: pd18nTku8MorH2riQQfy_x41khHD1Hnw
X-Proofpoint-GUID: pd18nTku8MorH2riQQfy_x41khHD1Hnw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110026

Currently, ath10k has a recovery check logic. It will wait for the
last recovery to finish by wait_for_completion_timeout();

But in SDIO scenarios, the recovery function may be invoked from
interrupt context, where long blocking waits are undesirable and can
lead to system instability.

To address this, move the recovery check logic into a workqueue.

Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00288-QCARMSWPZ-1
Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00189

Fixes: c256a94d1b1b ("wifi: ath10k: shutdown driver when hardware is unreliable")
Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---

v2:
1. use workqueue_aux instead of workqueue for recovery check work.
2. add Test tag.

---
 drivers/net/wireless/ath/ath10k/core.c | 19 ++++++++-----------
 drivers/net/wireless/ath/ath10k/core.h |  2 +-
 drivers/net/wireless/ath/ath10k/mac.c  |  2 +-
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 6f78f1752cd6..8396268baf92 100644
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
+	queue_work(ar->workqueue_aux, &ar->recovery_check_work);
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

base-commit: 38cf754c15eeb0d80fbf52c933da10edb33d7906
-- 
2.34.1


