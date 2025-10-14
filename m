Return-Path: <linux-wireless+bounces-27969-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FC9BD8EE8
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 13:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C578425B75
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 11:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F0214D283;
	Tue, 14 Oct 2025 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hwbhMLpZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A968C2ECD3F
	for <linux-wireless@vger.kernel.org>; Tue, 14 Oct 2025 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760440091; cv=none; b=o5tgygCL1y/TBTqoyWE5OAAlsdEQSaZjWNB2PCSIKfhDm4qFKOPjuksnPm/CddrbMu/omh3dM39u04TOUbjAT44tg6qrL5Uz+yxwrJQLsHBxAJmo/m4nLA7cLzqKEXdAJ5st32QYq6KrNOquYFf0n7zc7tNlFI7TZ7v45u1x9qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760440091; c=relaxed/simple;
	bh=YfcU4J535csoMFIvKB72yU+6do582t3gYUKFu2vSnFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=did31VSslWR/q8ajlUymX3HOZ+K3rGB5RmtIIW54oU4H4JxYaiJu4P5er6pL8DfJkR36celRu7rKyQO3Yvot5BkrkT2ErWVUIkrDwW8K6s6ui51btLRGtvQ/LF2UAzqKSQJA6rFBsQlv03xBlATgyVLAZoiRK9sTuI/K5SvCtqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hwbhMLpZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87JAO018120
	for <linux-wireless@vger.kernel.org>; Tue, 14 Oct 2025 11:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pCPBB3zUKHBvOLezlS3C15
	tJDFsbdM0CKexKKcrYyDY=; b=hwbhMLpZAIfUtYalrW5RxVKhUUDR25K9cKaxK9
	cKClb0tqhYK4z2f+4O9ajrp/yDEwOO2cUU6xOVLXdFzFbSMJmBfvr8jog1lRhhhJ
	x+6Xux7cnOOKFcjvdpQWCQx7QEyBqHdHI3032LvWB3LYcfQel6/NOsdFY46Dzllh
	CKbJLMaGzCZnWkhZIp/70CtQxnEdDiyDdQHr+kLjS3tVQXqFJjig47yu/aoaeL7e
	na22zam/Y6w1FG+GXBEiUyTslXXO4kE/FKePuFfhFI+xpmgCyEIOmH2XUOMnOsHj
	yRr6WxEEi32P1sScvv7q0rhInQZatbvWzJjmp6ybSXaBJUqA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfes06u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Oct 2025 11:08:07 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3305c08d975so9057406a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 14 Oct 2025 04:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760440086; x=1761044886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pCPBB3zUKHBvOLezlS3C15tJDFsbdM0CKexKKcrYyDY=;
        b=ddTEauqfFWEmQ+mimyc7opZttzI86AYRwb3QIqlq5BjnsKMAmjkUdvUsgI31YOIhM9
         HjodZEACj3PPl2PLUT6CpmAuZKfhJ4mfTYvL1kvtF89hFkN0oazWJRySeMLVQxpy0qqT
         Nm4njgfuCIO6JXMB3pL3oQD9253VD586emzkw2MwwIyvOwTmkawtfAzv2k3tlUb4/lnD
         IdBFNNn+LHhCXDaE3tMSXLT4Mov/kqQApa5MU/8MAL3W+9p8htxdnODmxdfYK53I7IBL
         bS8ZiIcS7Jt+UyZLkczK6fv6EfJuQJ1Bhhwur7yDHw5+VkaQDjKEKNhLK+inKmkWik/3
         nBfA==
X-Gm-Message-State: AOJu0Yz+IHP4M2zpOyIJW2tHW+nGwK92nSBeNrjxu0YEE39y0yR654+7
	oh//yKCDyMXDH+jl1DfB7NXEd+CGXofVe2UzDbxqb/iQXraoYO3c+H8uxpK3c6PIqkTCKjrBliP
	vLk1kKzFVjT1ClcTozjaOlw3qx+jRRE1Bj0ODjjydwmGK6iVnJ/dK4BCImjSTOfd4Njuf6LYYIl
	Gi1GgY
X-Gm-Gg: ASbGncsadnVeG34DWr8BPW6HUnw2eGrqPCW5MuiPqjR9/qlC8+u0xI5syU9lYABYTP3
	NHNVC54V0AMQk2Zk88u8ErRhckSUE6IgfKgvZjjZBEinj6yRzheFJQd2xu99F7wbt3Z+C+i+ypm
	D9dquuY+cg3adVBsimXgo0JvtrVOmohqlMGH4i+cNaAmRP6Wpkek+6u1vhwNvBg3Hxsy/rJoD5p
	nQIzN1V2eP2t83fRG2USKrP6RGbUnYkTosGm82ZVGWZGW9PawjNZBrzteanqCqEA+1FadBfpRDo
	IUH0QDinKGv68dU9A+w0QnUZxXzuzo1/N1m0kLOVrtwbynbXfIS4bD2K2tFl6YiQ+mMaqi1hgQO
	scDr8vLsE/2WXX7GdF9SrOYv1ih3U720QJcmuJl9HA6fFUAzWggISLw==
X-Received: by 2002:a17:90b:3911:b0:338:2ef8:14af with SMTP id 98e67ed59e1d1-33b513bee03mr31723221a91.37.1760440086028;
        Tue, 14 Oct 2025 04:08:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYtmlTHZpQQoCSgvxpCwh3BvRw4Elghgfd3Fb3g1hxO1jtjHKkWm25fCgtMhPZaxffu8Ix6w==
X-Received: by 2002:a17:90b:3911:b0:338:2ef8:14af with SMTP id 98e67ed59e1d1-33b513bee03mr31723189a91.37.1760440085476;
        Tue, 14 Oct 2025 04:08:05 -0700 (PDT)
Received: from QCOM-kZLYnuwaz1.na.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b67c6040d23sm5425013a12.38.2025.10.14.04.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:08:05 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath10k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next v3] wifi: ath10k: move recovery check logic into a new work
Date: Tue, 14 Oct 2025 19:07:57 +0800
Message-ID: <20251014110757.155-1-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R64O2NRX c=1 sm=1 tr=0 ts=68ee2f17 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=JPUmt8VSvV4ADWAhxtYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 06x2du830Tqymk7Ooz66S86_B8NJb6nW
X-Proofpoint-ORIG-GUID: 06x2du830Tqymk7Ooz66S86_B8NJb6nW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX3vxO5uSykGPF
 0I2ZCTwEyf++dDx+82E49Q6QHX4VjyIbbH8bVBtnUla3CplR8Qd596JI61nJBuhN3AZNIhcIArE
 takxKEC3FehEx96QsPVaj0P7aRvAk0PkjF3PARjKzAs2uLoAH/9uMQzUJR4KjdsNYz1Tj5OiOrZ
 ONABLn6Rnl8dPuaE2Htor2Fl7W6a1p01i4yJ8nZE6DXWP8l3HDe50fOU9x2r8RVaG3UhE9m97c9
 RXOdIjW4k1sl9b4VQcTBx5kumtw2bqoNn2g37t7DRIbZGRZDOczyeaNazaEiQDRiscYF2ubptra
 E4R9s4D5zTaRnEKIpy7ZQxVSJlw0MDUvMOTgqUMjouMbIgbRF8clDDKYl99fpNIJxI/WObaetVb
 +x4ykzMtivVXGFi6pwX48njBgNywJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

Currently, ath10k has a recovery check logic. It will wait for the
last recovery to finish by wait_for_completion_timeout();

But in SDIO scenarios, the recovery function may be invoked from
interrupt context, where long blocking waits are undesirable and can
lead to system instability.

Additionally, Linux’s ordered workqueue processes one task at a time.
If a previous recovery is still queued or executing, new triggers are
ignored. This prevents accurate tracking of consecutive failures and
delays transition to the WEDGED state.

To address this, move the recovery check logic into a different
workqueue.

Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00288-QCARMSWPZ-1
Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00189

Fixes: c256a94d1b1b ("wifi: ath10k: shutdown driver when hardware is unreliable")
Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---

v3: explain why use different workqueue for recovery_check_work.
v2:
1. use workqueue_aux instead of workqueue for recovery check work.
2. add Test tag.

---
 drivers/net/wireless/ath/ath10k/core.c | 20 +++++++++-----------
 drivers/net/wireless/ath/ath10k/core.h |  2 +-
 drivers/net/wireless/ath/ath10k/mac.c  |  2 +-
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 6f78f1752cd6..9ae3595fb698 100644
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
@@ -2518,27 +2518,24 @@ static bool ath10k_core_needs_recovery(struct ath10k *ar)
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
+	/* Use workqueue_aux to avoid blocking recovery tracking */
+	queue_work(ar->workqueue_aux, &ar->recovery_check_work);
 }
 EXPORT_SYMBOL(ath10k_core_start_recovery);
 
@@ -3734,6 +3731,7 @@ struct ath10k *ath10k_core_create(size_t priv_size, struct device *dev,
 
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


