Return-Path: <linux-wireless+bounces-21239-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D772A7F491
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 08:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090BA1698B6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 06:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D6025F986;
	Tue,  8 Apr 2025 06:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RjR5P/NC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E7025F96C
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 06:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092409; cv=none; b=P4bY7R4PqJagzYoJgg1sBHZtf8yjwBRBgoTWUMCF5ZUGkgowuJ+OpFFzfc3MMfFnd2qXDJc4QgonFu2qGJCfzXF1q7xvU+zPMPXAY7Ejd03kM78voVpA78L3r6Jl6BY37ETOHt0JDEXpf95zCvTl9mnFYHef+pkoRK+HyJfzd04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092409; c=relaxed/simple;
	bh=up8smwyoeKohrCL41Ryqyh2BJ+BYqb2FoKl0wvhn+pU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbivDfUorZd6Hjo53XnrGoevs8DcG3TMJJo70LCINUNMVbt23dwk0Itr98yAVrjkbpHXhJaunvkFgn/oUDZGkjoFlAjZdaMAdCdqjPFI7D4Yp6YJknt+9Tuff3Jxvv98NGUK3jZWCWuVPTfmzuVMbhQteLD3hC4Sust7bUY2CQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RjR5P/NC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GMw6014970
	for <linux-wireless@vger.kernel.org>; Tue, 8 Apr 2025 06:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZRh4aDWzSVC8Ic0j6UCADc43xdjA1WQ09ueDbR4CgJ4=; b=RjR5P/NCFhe+D0Q5
	2Tx7W4ozMJ116r/3m0wRblUucZXdy/+WMiVyyFIRRdEDexbC/WIAN/CFgSAWhHTb
	0+kjXKs2z2E/5r37/0RfYyIWKqTGGp2+d/cg1XOTMm9ULWjO2oYJ5Haab8yKeDu1
	Xz1SW+FgmwxcgrtBjwDbVw7HxSk2Fqe4uKh0YdpXtcGWUT7fZlAvES1myb6hMvkY
	V7IFZtuqzDPg7c2xDlp3qu/u9XC/33rL4N+7RxsRAD7MYew79DO0LnV5nNAuqSLe
	wwyd80gLJIelh0E0CxfB/4feojWH5zXU3/qSRPqc50VLaBGS6ljvN2fvJlXFySzQ
	ywIGbw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbuepcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 06:06:46 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-736b5f9279cso4802477b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 23:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744092406; x=1744697206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRh4aDWzSVC8Ic0j6UCADc43xdjA1WQ09ueDbR4CgJ4=;
        b=eggncxEYASm6P7HDZiee4TdQgYD1+eBaepWgLAitdWyFLjl47lFALpUYlX74R5lTn7
         SyfG8eW1NEn124zqRjslXa+AFr7PBoZB4wsZ80+RtJNw8agrvSNFavdwSa/8m8CuQYjh
         CnN3W++PEGG0MTkOSHExjSabduG7+gCd532ofndDsjVUvxCfIzPe2HHBC3g85W7ML6qX
         YROX0UsZBGam+Krw6dHOWgZFlPLGYsAZnilgGrEIOR4NgPinEYwRZC8nJuoegqouqMxd
         KMvOGxgh8pGHW0I+yfu2PucOVQbeUvOj/UoLOnW8mTEvHmn9RcFkbUCqVklvrQV9n3vy
         dw9A==
X-Forwarded-Encrypted: i=1; AJvYcCVhy1718j5V7YWbLCA/s3ukieBuP4yZZDDuur1Ig10M5xZG+y4lECELrQePSctPxXqGgR4Iu7QgR5qwfUvGUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnvrS6KpzPnhC/2DwL3wWqxNIpOjaqcnPmoxFkWPUD6qB8StKC
	5Wqy1yzu9UvkMcIVbzm7b20Zn/F/rE1YgK4SFQcXOCDYe7VmnmCPY6BMyl7eglEnk6S+SN3Ov9u
	yAKRBvCj+E/du2D/+7j1a0KiauI7fEXK7qdYaTs568A5i3tXN2j432LTVrHYEQyRoUg==
X-Gm-Gg: ASbGnct4N00mivMCaOZeTkP1mQwQPTU7IoBcj1uSLYMWxtYVNKR6JWQBMpS1JqPSykd
	qbM2k20PInR732Z8aD13sl7mLxZqKyPInXoPjQluhCRSdyagCzhrJZP7ryaT+64G0sKBtE+kTmL
	q7YtLw8OO4PHDrdn0JbYjJxTPa7Y4ANdVlqalopAfecQ8zjB25xLufUViuZgGCaR+8U+aLuX+Y+
	bj/IH1NlqXn8cVVrQ0EdrsuTGoi93tEKIVWGUl60v2Gf7wYI5ql7jXu8vguWymeXmdOBBKWIZ/W
	RLkVrFVN8U32cADGn2Jlpldsr9pNFUT2OFJntGuAzmYCkx2oD1KaV6SXV1grEotp98CNtYVjHbu
	EvZiEKiDtinxwqFDwCPePNKngStbjy5pg700bv281
X-Received: by 2002:a05:6a20:430e:b0:1f5:9aac:64dc with SMTP id adf61e73a8af0-201046669b7mr21491139637.20.1744092405517;
        Mon, 07 Apr 2025 23:06:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE49W85eT/fLzhiTWBG/SxZbu6DecyAqbza+jaSMRXdtL50P/KdWMEi40rhdrIzkfKQ5rqfw==
X-Received: by 2002:a05:6a20:430e:b0:1f5:9aac:64dc with SMTP id adf61e73a8af0-201046669b7mr21491106637.20.1744092405175;
        Mon, 07 Apr 2025 23:06:45 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc35079fsm6863981a12.41.2025.04.07.23.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 23:06:44 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 08 Apr 2025 11:36:29 +0530
Subject: [PATCH ath-next v4 1/9] wifi: ath12k: fix SLUB BUG - Object
 already free in ath12k_reg_free()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-fix_reboot_issues_with_hw_grouping-v4-1-95e7bf048595@oss.qualcomm.com>
References: <20250408-fix_reboot_issues_with_hw_grouping-v4-0-95e7bf048595@oss.qualcomm.com>
In-Reply-To: <20250408-fix_reboot_issues_with_hw_grouping-v4-0-95e7bf048595@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>, Harshitha Prem <quic_hprem@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: vvhXSqQpVQMbgVZ0RSAIZuXX2t_J_Nra
X-Proofpoint-ORIG-GUID: vvhXSqQpVQMbgVZ0RSAIZuXX2t_J_Nra
X-Authority-Analysis: v=2.4 cv=dbeA3WXe c=1 sm=1 tr=0 ts=67f4bcf6 cx=c_pps a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=Qd74P0o9topwJXlKkrcA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_02,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=751 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=20 bulkscore=20 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080042

During rmmod of ath12k module with SLUB debug enabled, following print is
seen -

=============================================================================
BUG kmalloc-1k (Not tainted): Object already free
-----------------------------------------------------------------------------

Allocated in ath12k_reg_build_regd+0x94/0xa20 [ath12k] age=10470 cpu=0 pid=0
 __kmalloc_noprof+0xf4/0x368
 ath12k_reg_build_regd+0x94/0xa20 [ath12k]
 ath12k_wmi_op_rx+0x199c/0x2c14 [ath12k]
 ath12k_htc_rx_completion_handler+0x398/0x554 [ath12k]
 ath12k_ce_per_engine_service+0x248/0x368 [ath12k]
 ath12k_pci_ce_workqueue+0x28/0x50 [ath12k]
 process_one_work+0x14c/0x28c
 bh_worker+0x22c/0x27c
 workqueue_softirq_action+0x80/0x90
 tasklet_action+0x14/0x3c
 handle_softirqs+0x108/0x240
 __do_softirq+0x14/0x20
Freed in ath12k_reg_free+0x40/0x74 [ath12k] age=136 cpu=2 pid=166
 kfree+0x148/0x248
 ath12k_reg_free+0x40/0x74 [ath12k]
 ath12k_core_hw_group_destroy+0x68/0xac [ath12k]
 ath12k_core_deinit+0xd8/0x124 [ath12k]
 ath12k_pci_remove+0x6c/0x130 [ath12k]
 pci_device_remove+0x44/0xe8
 device_remove+0x4c/0x80
 device_release_driver_internal+0x1d0/0x22c
 driver_detach+0x50/0x98
 bus_remove_driver+0x70/0xf4
 driver_unregister+0x30/0x60
 pci_unregister_driver+0x24/0x9c
 ath12k_pci_exit+0x18/0x24 [ath12k]
 __arm64_sys_delete_module+0x1a0/0x2a8
 invoke_syscall+0x48/0x110
 el0_svc_common.constprop.0+0x40/0xe0
Slab 0xfffffdffc0033600 objects=10 used=6 fp=0xffff000000cdcc00 flags=0x3fffe0000000240(workingset|head|node=0|zone=0|lastcpupid=0x1ffff)
Object 0xffff000000cdcc00 @offset=19456 fp=0xffff000000cde400
[...]

This issue arises because in ath12k_core_hw_group_destroy(), each device
calls ath12k_core_soc_destroy() for itself and all its partners within the
same group. Since ath12k_core_hw_group_destroy() is invoked for each
device, this results in a double free condition, eventually causing the
SLUB bug.

To resolve this, set the freed pointers to NULL. And since there could be
a race condition to read these pointers, guard these with the available
mutex lock.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: 6f245ea0ec6c ("wifi: ath12k: introduce device group abstraction")
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/reg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 893650f76fb2d9f24177d524c5a979693b543657..3260df2ad60059117d5340c27a3b82fdcfabd02b 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -817,8 +817,12 @@ void ath12k_reg_free(struct ath12k_base *ab)
 {
 	int i;
 
+	mutex_lock(&ab->core_lock);
 	for (i = 0; i < ab->hw_params->max_radios; i++) {
 		kfree(ab->default_regd[i]);
 		kfree(ab->new_regd[i]);
+		ab->default_regd[i] = NULL;
+		ab->new_regd[i] = NULL;
 	}
+	mutex_unlock(&ab->core_lock);
 }

-- 
2.34.1


