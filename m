Return-Path: <linux-wireless+bounces-21578-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58042A8ADC9
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 04:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBB23B25B7
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 02:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33E715667D;
	Wed, 16 Apr 2025 02:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bT4HNkKg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87CE1537DA
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 02:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744768909; cv=none; b=W1xDXiyewQBw1eqqJ0OVg7ZARjDODj0vUzNTUpBD5GDgd/YEqI2f+/lBAmBkR2Cd4i3fBR+rvlkqbLNmvHggdGI8uTChYTzDDIuzH0mZdYNauvIR2aqe3NUqmY1tCd1ZOuGgoUcDU9Y9jfeCXzVt973O+3iQLQOnxvZ/duu3jbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744768909; c=relaxed/simple;
	bh=9gsCBqEVsy73ij5c+s7Z5DwcoV3NtwwWcuN5NgE5DGg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XFXDDwQ+mFFjGrpA5mVrsod8hjhWTITaQoozmFCIklPFSXRlB4Ki8SxHipscFY05x7UMa0+lNdsrHEqSl5+vA2jCx4LdeKwAxGPlZ/Aw9i7o0vz96sjNTh+gSBYqyPpSlTVjGQZtiiiHdVjrwfZRwWD0B+Jh5sSfy4n3/iIUpaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bT4HNkKg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FIHvRK022965
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 02:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=idDGPAqDhmx2
	tJ8Bjnk98i01+XNduU/w2CW2GcoML0w=; b=bT4HNkKgqqvbPPjOho/DfK+lo1Z9
	658q7AWXBf73+Ux5eXY1x+qrXCT17UeRldCeEtA4GlcME/0LuWQg6tw53kF2xMhe
	MZhQDI0BOaudVxRUpb9pKHSA6mX/KkvlMqoDdkoKPdrfnlXaWvbHP2xHO29TvmIf
	CPqK9N1W03N5Cq5G27Z1SfgHZFd6uHP8BxEAHtE0KvoPJTyMhOFXRhyh6t6lL0EJ
	72zfUEZokzztGbPXT7pi/3ylnJ75nr2ctrMrra3AojITJsMQEzMzeymmR1iWMsEi
	ZgVajzPsLYv/tbv6aptDZoe6afydWZzdyntKLrs08fg09oKmbbCe258dcA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygj99wva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 02:01:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-229668c8659so45264855ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 19:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744768905; x=1745373705;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idDGPAqDhmx2tJ8Bjnk98i01+XNduU/w2CW2GcoML0w=;
        b=OH94cLG+SGhLt3QIZHjdjNV/ZhFhoqCz/2H7BeJ+tWZ/A5snoU+VidlZxBpT63Anmq
         pfWb0n8c6GTS907exGrAf1Vr1+zU/YhzHqSa0pGCNiA6cUh23ONhEpMK5mojWsKj2whM
         cA6VG6Gz9piGjiu+GK9GViyNNQcFycBosk1N9r3Ij1HVl5r+FFXk1BOYH5PcXnajQ4D/
         44MUfZW0E4IAXvDQtOSnDzhNDrnWvq3HBzFDMTFFQLeFF4AsP7oQVuKKpjknpJbq505U
         fxOIWNytQ0tlvkyPce9ZWRuBLc3EMz2Y5q6kaXex83ncPvOZlusb8d0jteXDkZQYQxoQ
         SxWg==
X-Gm-Message-State: AOJu0YxVxx9mEosEWOAYzMkvtKCtnfgKSZGl8accByY1Bt64ZdSCMgLL
	vgk3ZlYsakdvpItulH6e48MkGG9sCM4NQen3VgwPF9veMiYcACoh1Qw0+LHTAGId6Onft4yc3bJ
	SMNgM+ZL6MfPAvPX4ecKrrPg+5F9nCDk6Pqy7cf5qBlB1GOpfscdZHOrOJolnq0kPpw==
X-Gm-Gg: ASbGncsdNor0Z4eHFz4odqxaMdbjFL8mO75hmL7VpbHtElBWx1Gs00zyH2Rga80YLWn
	j5p1fnRT8RT4dijx4dOY2V2riHX6UvUgWHydoRs54O2MD0hG+LJZEugW0PC3Q9Z6OvqSK1JAjID
	mVSGbc+vyb5WqHrYKSWkXcuczRsQXJNK8kd7ZpNHIW8R3lcOOFqXXW98exVNNjAKhqoZujDmjJK
	FXBviLJjTg4ieUs2ZNSPp3wPoSQxhvlMl6u7tqanfzE84jYBzX4irFdTUJFAnXgfgCYLiQRPlch
	eSQEizHNTWu1cHOaU9/NL2CaANM9DzNbHlBhbWFkWlUcCOeXwnQW3nZogsVgtTfrgW73FZlnrp+
	nprhBP5ykrPZU5pEr3URA/CALcc2z813q4X7lnb1dhkrMgg==
X-Received: by 2002:a17:902:fc86:b0:224:11fc:40c0 with SMTP id d9443c01a7336-22c358c509cmr846145ad.11.1744768904790;
        Tue, 15 Apr 2025 19:01:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCbgAet0uemXl+73aKIuaic3aOU9FUrkIc08337Evt5XcSbofxrA2Vo7u/s5HsDCTDfQTJAw==
X-Received: by 2002:a17:902:fc86:b0:224:11fc:40c0 with SMTP id d9443c01a7336-22c358c509cmr845745ad.11.1744768904319;
        Tue, 15 Apr 2025 19:01:44 -0700 (PDT)
Received: from che-siroccolnx03.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fcbf4bsm2332195ad.195.2025.04.15.19.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 19:01:43 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH] wifi: ath12k: Prevent sending WMI commands to firmware during firmware crash
Date: Wed, 16 Apr 2025 07:31:38 +0530
Message-Id: <20250416020138.2161484-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-ORIG-GUID: NHEmObWORrU9nFMobh_rAVzMxFlLSDU2
X-Authority-Analysis: v=2.4 cv=PruTbxM3 c=1 sm=1 tr=0 ts=67ff0f8a cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=0aF2uJ-tSyx87ITvGwcA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: NHEmObWORrU9nFMobh_rAVzMxFlLSDU2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160015
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


