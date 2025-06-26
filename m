Return-Path: <linux-wireless+bounces-24514-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 150FCAE951E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 07:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB41A189C7B1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 05:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B98220E32B;
	Thu, 26 Jun 2025 05:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b4AzxaZb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E6681724
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 05:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750915218; cv=none; b=M8KaSCwH7a3RelOdDQ1ZjxmvhjtAjLrUXbt/8hDMFh/WgmB2OpMBZXX2OMSLFqew9M2B0F+havccwvQjSZspU1sfuQ3wGymfRBU5IevjSUzz26ftrevv/YnB1uYOMkWC32VyVaJpxZBg/jeGel8kyNGayQzahSvWHslrMBgO5wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750915218; c=relaxed/simple;
	bh=DpTmJWZ18VeKb2Nj+dzk4Ksw6DvHAg3Aggvo2SpFkvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=riCLX/wn6Wq8nXC/k0IMw8/DTj9peXwl4jVK0L+pJ+mPNQ62P+MoLKzn4mLFkJWTcZDkLPf+vJ6PWNjCZUn+ePCELAi8iaFTlbKQnNIGSjVNvuw1+WWq7Bd2guqdYJyjR/OSOB3fu+x4FM2Gn0YVF001YWi8zxjn9hrNPUCTr7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b4AzxaZb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q0DnNT021545
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 05:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6pAx5/ZkLCjLuDmzrc9Yzj
	agLIhF1++aZj4s/ojWJSs=; b=b4AzxaZbRb2WLrMUh4SQhZq38y6W45cka69ETY
	xqOUxEtwBDGc5dRzpGJqSZ6WjjM5MlOKJQrgmBsOHkM4pV0/yziS7zzS3aY/r9Ku
	T0NTc7lgWFPjbOLjoSPPmBQPAy6CnJ5W+aGerDSkp4Rg9+WQjF6QZlt1pb0VVpUX
	BxAjphrN5SE6goz6tmbIC+sL7tPYen82fQzDVXFzlBcloffdR9EswzH5tYL8G88l
	2bUl5vkx4iGkWSaUOnAmlHuOq/0yN62cOyJqEZ8Jrtl07zH0f8J8DwIza2Ect9HT
	2qx/eaohsM6N3p+L+oSy+JIJeJQjtYG2f2FLuAUPTAC4pV4w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fdfx0bbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 05:20:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-315af0857f2so540991a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 22:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750915214; x=1751520014;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pAx5/ZkLCjLuDmzrc9YzjagLIhF1++aZj4s/ojWJSs=;
        b=jLBpPVRy8cz14C1N+dgoTkJO/jeaUd8Ct5/QzBve61NAU+spWJh+JlQKrfa4oFeB2F
         XhFSEzB5YtOu/Wl/bSFV4lQSCWWw31WDrfgelC2MWsol5Safs0uLxwXL3kdwq0fK964h
         YQ1EGDXKW0Yp0DjeuQSPVZgfo2evzyYbAxtzDYcnWRy2lMvXNgU6u2nDTrZYh4bxxno4
         kUMvvuZovOujSiOSG1Z7Bu2PQah4EW5uhQQtSpRdT5nbsawK5uKxZZE2NC+oKGgoToUY
         HRK61Pk7WUKVfst3M/zpXTt/qgMytqOOsPybf0vMjK+3A1eXIJgAQgQtwMJ5+PxYDWrA
         dB2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRyqzypiGXd/vUOJUW5QeRtIhSy6EEo8NVcZ1LNTQv0OkLytchgbGPCihIKDVyGFsCUkj9YPyiD0pU39h6JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9YN9qevZiaXMbJC0Zgz3JQF3sYrwp78em4BDxNj5eRQnBiu3q
	L5uLn/Adryeyjuu/h8PobbxE9JxO79W/Hiy1prfuq+MfZiTDa/TfDQiEVV/4k6izPJT6R1JZ9Rz
	ZH8gNOoCo/74oiGIqF4a4SexMu6mTOBJx1gsUviGj57SVVNwXH5ZFjnDzPSF6xjNzfBimgw==
X-Gm-Gg: ASbGnctNuN6Z9Djj+pjIhMD+usDETfaQucbozpIYlML8GzIW2k57lFCJCb+yGZLDn1E
	40s334jLTXTFKuonLIFB8i34cx8P6sxjKdT5YdzXWjXkTVJF3qHtARYguapaan/JI7eyruTs42r
	6OMhXV8qQk5hSUjBU+T6uEfo6i93aTGSEXUTEetIklUXCQfDyfq/+m882s5Kvj/8pkTP46wRQsj
	7K63LQXnZtp43ytuUZ+gky+z9pvcUz7aaJ/fxqAaIrYw+VT/CVAZe7Q0E0RDaZazj4YRaB32b7x
	tR2kBDEzirwHfibma5JFqvuL0+ISA0d3FwyZzviUXicBrLZwb1O34CR5cfgy7RC8HKBtaXHkipn
	1iDdkDZpGEVdKzx8NFwJgOVy13AMMiUojRcsNLSSWfkwKzxE=
X-Received: by 2002:a17:90b:2ed0:b0:312:def0:e2dc with SMTP id 98e67ed59e1d1-315f25c9b3fmr8638727a91.7.1750915214188;
        Wed, 25 Jun 2025 22:20:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH89OoOzXSimx5HnW6QRCbmh5jHDwsaTiPcchec/GXWmTxIjZHrwzQ00PiGT6UVndyuC4fweA==
X-Received: by 2002:a17:90b:2ed0:b0:312:def0:e2dc with SMTP id 98e67ed59e1d1-315f25c9b3fmr8638690a91.7.1750915213684;
        Wed, 25 Jun 2025 22:20:13 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f53c2f28sm3443612a91.28.2025.06.25.22.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 22:20:13 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 10:49:56 +0530
Subject: [PATCH ath-current] wifi: ath12k: fix timeout while waiting for
 regulatory update during interface creation
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-fix_timeout_during_interface_creation-v1-1-90a7fdc222d4@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHvYXGgC/5VOSwqDMBC9isy6EX+x2lXvUSSEZNSBmrSTKC3i3
 Ru8QTcPHu+7Q0AmDHDLdmDcKJB3iZSXDMys3YSCbOJQFZUs2kqKkT4q0oJ+jcquTG5S5CLyqA0
 qw6hjahAam6ozV1u3XQOp68WYgufOA3SchVmZ0UUYkjhTiJ6/54etPC1/zm2lKIWUdW/7pu4M2
 rsPIX+v+mn8suQJYDiO4wfwV0FB7gAAAA==
X-Change-ID: 20250625-fix_timeout_during_interface_creation-ae428c7d3684
To: Jeff Johnson <jjohnson@kernel.org>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kang Yang <kang.yang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: GAITcWeqZ1vA8cMTz6QClAZBD_GyC698
X-Proofpoint-ORIG-GUID: GAITcWeqZ1vA8cMTz6QClAZBD_GyC698
X-Authority-Analysis: v=2.4 cv=MtZS63ae c=1 sm=1 tr=0 ts=685cd88f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=JrXYcSkjSHDmVXoFp08A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA0MCBTYWx0ZWRfX1pRQtEgi3HCL
 cGvcM1X/E9s55izBr2nxFIR6t1gAq+rfOXTkM2c97N7Xr2MuwCXQ1OGy/s2Cdh7UiZrzRmqyN2q
 CjIcfEY9ix6+0MZnNh1jQH4rUDOrSowmAb8qSveIWWbF9dPYNneqvhRVdUv3SjgQrNfIXrdYNVQ
 T8b2MONa4ZEF7WwD4SHHe3i5k8fqtE/x3XAfsFF0XEOjJLZwr6ZqeUyTwfdAQ6mQukO+e2GZSJ1
 HSY9KXsA7bhGJnUVg94tWbWVk5TLZZZjOf1MzzcU0WuzEzVOynGwCf1oY4lIsoHGiDBKA4VlaLM
 VsBf6fvB2oEuvzjJzw721FU6196Xd6tU6sGrtcPDsKLg/EeCNjG64hdQmX9rph62vZUtwkCaO9N
 HBx5/5oIHjtosoRjbbRkFf6YzlF3X7MTfdnWsa8fzkDLzgyV0RXCpe3CYVlQDMi21vLUgIZf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_02,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260040

During interface creation, following print is observed on the console -

  Timeout while waiting for regulatory update

This occurs due to commit 906619a00967 ("wifi: ath12k: handle regulatory
hints during mac registration"), which introduced a completion mechanism to
synchronize the regulatory update process. The intent behind this change is
to coordinate the timing between when the firmware sends regulatory data to
the driver and when the driver processes that data.

However, during interface addition, if the 6 GHz band is active, the driver
invokes ath12k_regd_update() to apply the appropriate 6 GHz power mode
regulatory settings. At this point, there is no interaction with the
firmware, so the completion object is not reinitialized. As a result,
wait_for_completion() eventually times out, leading to the observed error
log message.

Hence to fix this, move all complete() on regd_update_completed to
complete_all().

The complete() function signals only once, causing any subsequent waits
without reinitialization to timeout. In this scenario, since waiting is
unnecessary, complete_all() can be used instead, ensuring that subsequent
calls to wait without reinitialization will simply bail out and not
actually wait. This approach is ideal because if the firmware is not
involved, there is no need to wait for the completion event. However, if
the firmware is involved, it is guaranteed that the completion will be
reinitialized, and thus, it would wait.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
Tested-by: Kang Yang <kang.yang@oss.qualcomm.com>
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: 906619a00967 ("wifi: ath12k: handle regulatory hints during mac registration")
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 2 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 2 +-
 drivers/net/wireless/ath/ath12k/wmi.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 83caba3104d6c0bca40dd1166de335aabc8b74e5..ffc19a6b948539dddf3f6f21f2799f1b661347f7 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1475,7 +1475,7 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 			complete(&ar->vdev_setup_done);
 			complete(&ar->vdev_delete_done);
 			complete(&ar->bss_survey_done);
-			complete(&ar->regd_update_completed);
+			complete_all(&ar->regd_update_completed);
 
 			wake_up(&ar->dp.tx_empty_waitq);
 			idr_for_each(&ar->txmgmt_idr,
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 32519666632d1877eb48a31e94e5eb47f2b33880..d5f41f0fceee23710d2d775bb4d6f7451e15a55b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -12755,7 +12755,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	 * proceeding with registration.
 	 */
 	for_each_ar(ah, ar, i)
-		complete(&ar->regd_update_completed);
+		complete_all(&ar->regd_update_completed);
 
 	ret = ieee80211_register_hw(hw);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index b38f22118d732aa182f9fd6dda376b0d41de65e2..2fb262d13a586bbf354a74be8e509df2b4905f30 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6764,7 +6764,7 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 	 * before registering the hardware.
 	 */
 	if (ar)
-		complete(&ar->regd_update_completed);
+		complete_all(&ar->regd_update_completed);
 
 	return ret;
 }

---
base-commit: aa555da8266715e52e5dd74360f3b4c866ddcb64
change-id: 20250625-fix_timeout_during_interface_creation-ae428c7d3684


