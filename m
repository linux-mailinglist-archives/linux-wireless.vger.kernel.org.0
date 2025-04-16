Return-Path: <linux-wireless+bounces-21581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E07A8ADCF
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 04:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D1F1903E0C
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 02:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0C3176ADB;
	Wed, 16 Apr 2025 02:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="euBGayx7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D8A15E96
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 02:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744769064; cv=none; b=ZNX6IAwPT9Bnvj3BeeUuOgfxCWP5BhqJVGaJVBINiHSfjFOgTUrfAZ7YxooauFgolPgggbIVSQxnsqY/IlEynZAFS/XYmPGTya5Y4TQHLoA5jl4g+Nd/sswmqbF4KMARznrPPkl3ajwwiNJjCEsGeFpTc4jVvBBYaGM8j56NAlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744769064; c=relaxed/simple;
	bh=TslQbk0aBbL6Cj7PD+lixbgFgHHzgW2JsLjf0VDO/mE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Wr7dtFpfBXxgURUUreKXbEwdCyuLdc8TOtAZoxRRDypa6MCmxTHYXacKhO1Hy+oHcXN9tOXKGz4TwC4VWYqWmmcvSbRUd12bdgPUxbbWqDFHhTY3Ew+1++ZIV15A0L2RrQmtgToKwyB/Dr2+ramLDL83ylbhGCvLaIeDRvOfoTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=euBGayx7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FJ3CjN031756
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 02:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=McLdTTvXb1l9
	bjmpzpBcXmwL7POQ7Rnxj+nHgweb3tg=; b=euBGayx7iwqPn8dr9HtclXoHc9Yv
	+VGK4yN42O7GO7F4UXNfmvRoCNV4Q4X9zJowvNE+QF/wFxqFhKakyPhZVm7lMCak
	6bNMN332816UmXW9GCgC4EHeYN5KB78MIymZF4bJSDKwPUEAimzDwxgn+oUNT96L
	aAUxI4m/7TymgauJb/NKuraTM9d/+DskWU1QnKttFgH8ORxQltDmAuLgPMWOTKBT
	o7deoYY/vIH8+HFD5dKb85eXV1yLnV8UfpsI0uIj6uwdScUtf662IgFypl8LumhH
	IYLOwvalqZZJ9G7BArFgKIw6nTKs6ctdkIDJUDmuvF2vILCZ2LOhz+ZH8A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfs19y0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 02:04:21 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2242f3fd213so50440555ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 19:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744769060; x=1745373860;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McLdTTvXb1l9bjmpzpBcXmwL7POQ7Rnxj+nHgweb3tg=;
        b=qNqZ24QILnGtXmqTi98EG+5p0G7tVcJ9yGTzfdTA1ES8qVjhvUVZ/nGFUoXmbR4dNi
         eDOzdIM6QydqP6QwpfXF/GRAqhRf0m0B/skWo93ih9hOIWNWVjqzaxC7BymUiWnr2Ohm
         96x18K1WkHbqh35VUmW6QryMFwxh0FgXMNGPTvmOvkvy2CclcDelhf3fSvBmY11kN0Pd
         lopDiv9yBkvSEgql7l78CfZd18cUT86tQoqB87KtEmJI1dra8brEDiRyEc2nceXaUkuR
         6GybRa6EjtYtqu/mh0x2b7Omzj+TcM8SfBx6dOsZ9UmY4AntzVaIomXKf3AIm4HivOrg
         xS6g==
X-Gm-Message-State: AOJu0YwO2FNzzR5fsT9FJzaugxPGPvDb0IM0Ts7BO0k9PcsT0mbsdGW0
	nObjEkdvCkNe5izqhKq8dahOB6LjNnv8SWqgtA2xBCGJLpeEpCCBc9hmQUsLkEhoyEz3khSMFkL
	w1CzFr01neJDj2dzB+DavIsoRgz66mR3F+D6TPCyjH/NLcJ7pP/xxAM92n7lWiektGQ==
X-Gm-Gg: ASbGncuTctv1Op4KE7axGSUGSLq2BgJA0j/9G/DByySckenggXFdjbquDRlxiWTUtEr
	/caAodwdRTFnzy6Hu+VqIaX76yWo/qH3dIEDFoIw1Ppafr9YLk5pfenGTCEOiJOsm10gRPI1J67
	A6xFsKjPb8eJ5o1IAf0SJtAIGZA2BskumsY4dTESQI1YDKWe9uezYWubWIo0B8va4m+EaDN56H0
	2UVlt01/OH+jVBXqvhDY3dm5LwJoipM1Lw9BV7fKYsOPp5lWU64Dm+5vHDdgqjBvrIRB+mbsEss
	AqO9NXfMkRNmkdSXe3JfAFA9ViHjQVeOcZU2IJzAaky71swXrXqJyzNdA6qjFbVmhfoUTyyARDB
	YBJJRfYo4TdQvvl7ESnZayMcoriRf4w6H/R9a+W7EolRZ7A==
X-Received: by 2002:a17:903:2411:b0:223:4341:a994 with SMTP id d9443c01a7336-22c358c60famr894605ad.9.1744769059670;
        Tue, 15 Apr 2025 19:04:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNSyHL4nlUreSQMoD0Q3SLW1GH83ootC65W0rrfzfdVDfwAICBeEBcvfddha3iR1aCuyQWGg==
X-Received: by 2002:a17:903:2411:b0:223:4341:a994 with SMTP id d9443c01a7336-22c358c60famr894345ad.9.1744769059309;
        Tue, 15 Apr 2025 19:04:19 -0700 (PDT)
Received: from che-siroccolnx03.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fc6503sm2316175ad.171.2025.04.15.19.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 19:04:18 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH ath-next v2] wifi: ath12k: Prevent sending WMI commands to firmware during firmware crash
Date: Wed, 16 Apr 2025 07:34:14 +0530
Message-Id: <20250416020414.2161545-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Authority-Analysis: v=2.4 cv=P9I6hjAu c=1 sm=1 tr=0 ts=67ff1025 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=0aF2uJ-tSyx87ITvGwcA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 9H3K0vsaDruYnF9bf1Y03y7wH9TP076B
X-Proofpoint-ORIG-GUID: 9H3K0vsaDruYnF9bf1Y03y7wH9TP076B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160014
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Currently, we encounter the following kernel call trace when a firmware
crash occurs. This happens because the host sends WMI commands to the
firmware while it is in recovery, causing the commands to fail and
resulting in the kernel call trace.

Set the ATH12K_FLAG_CRASH_FLUSH and ATH12K_FLAG_RECOVERY flags when the
host driver receives the firmware crash notification from MHI. This
prevents sending WMI commands to the firmware during recovery.

Call Trace:
 <TASK>
 dump_stack_lvl+0x75/0xc0
 register_lock_class+0x6be/0x7a0
 ? __lock_acquire+0x644/0x19a0
 __lock_acquire+0x95/0x19a0
 lock_acquire+0x265/0x310
 ? ath12k_ce_send+0xa2/0x210 [ath12k]
 ? find_held_lock+0x34/0xa0
 ? ath12k_ce_send+0x56/0x210 [ath12k]
 _raw_spin_lock_bh+0x33/0x70
 ? ath12k_ce_send+0xa2/0x210 [ath12k]
 ath12k_ce_send+0xa2/0x210 [ath12k]
 ath12k_htc_send+0x178/0x390 [ath12k]
 ath12k_wmi_cmd_send_nowait+0x76/0xa0 [ath12k]
 ath12k_wmi_cmd_send+0x62/0x190 [ath12k]
 ath12k_wmi_pdev_bss_chan_info_request+0x62/0xc0 [ath1
 ath12k_mac_op_get_survey+0x2be/0x310 [ath12k]
 ieee80211_dump_survey+0x99/0x240 [mac80211]
 nl80211_dump_survey+0xe7/0x470 [cfg80211]
 ? kmalloc_reserve+0x59/0xf0
 genl_dumpit+0x24/0x70
 netlink_dump+0x177/0x360
 __netlink_dump_start+0x206/0x280
 genl_family_rcv_msg_dumpit.isra.22+0x8a/0xe0
 ? genl_family_rcv_msg_attrs_parse.isra.23+0xe0/0xe0
 ? genl_op_lock.part.12+0x10/0x10
 ? genl_dumpit+0x70/0x70
 genl_rcv_msg+0x1d0/0x290
 ? nl80211_del_station+0x330/0x330 [cfg80211]
 ? genl_get_cmd_both+0x50/0x50
 netlink_rcv_skb+0x4f/0x100
 genl_rcv+0x1f/0x30
 netlink_unicast+0x1b6/0x260
 netlink_sendmsg+0x31a/0x450
 __sock_sendmsg+0xa8/0xb0
 ____sys_sendmsg+0x1e4/0x260
 ___sys_sendmsg+0x89/0xe0
 ? local_clock_noinstr+0xb/0xc0
 ? rcu_is_watching+0xd/0x40
 ? kfree+0x1de/0x370
 ? __sys_sendmsg+0x7a/0xc0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Fixes: a9b46dd2e483 ("wifi: ath12k: Add firmware coredump collection support")
Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---

v2: Added the tag in the commit title.

 drivers/net/wireless/ath/ath12k/mhi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index 9c929c4ad8a8..08f44baf182a 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/msi.h>
@@ -285,8 +285,11 @@ static void ath12k_mhi_op_status_cb(struct mhi_controller *mhi_cntrl,
 			break;
 		}
 
-		if (!(test_bit(ATH12K_FLAG_UNREGISTERING, &ab->dev_flags)))
+		if (!(test_bit(ATH12K_FLAG_UNREGISTERING, &ab->dev_flags))) {
+			set_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags);
+			set_bit(ATH12K_FLAG_RECOVERY, &ab->dev_flags);
 			queue_work(ab->workqueue_aux, &ab->reset_work);
+		}
 		break;
 	default:
 		break;

base-commit: 176f3009ae598d0523b267db319fe16f69577231
-- 
2.17.1


