Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64CF6B20B3
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Mar 2023 10:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjCIJx5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Mar 2023 04:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjCIJxk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Mar 2023 04:53:40 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EC342BDA
        for <linux-wireless@vger.kernel.org>; Thu,  9 Mar 2023 01:53:31 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3296WNkc023504;
        Thu, 9 Mar 2023 09:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=y/Cn/2xo01c+aPLThtrSQCJLfhOgxXonABwstlzf6E0=;
 b=M1h+C19uDDxK5Bx1cM9NkzT5o2TOQDtb4WfJzIfCifCxM9ULLDYYAY3r9AsPkEGKT0DD
 ntxd/Hzd3lakpGpnfw/GXDVI34aQIkFa2VktdleBTfwXxsLODLXiRZQRoYHaqYGQTFrc
 Jv+bSXPMPTotb/mPt0poJysXezgkcnLgAegtfAHx4epIRq3Upr0XbVQWXQRotMRso4ES
 VXST8RcHEubioucA70x55uphC/7Qy4T8RLfjUsT/84tr55MU0XTyEKS4UUEBJrB8oF8d
 8k1+YmuibO0o39iHSPlF4hJBc9DrkAbAjQyZxt4aVoUdxClxwOzlPwYxknJAaC55vYQB 3Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6wcmjb3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 09:53:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3299rOAe023923
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Mar 2023 09:53:24 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 9 Mar 2023 01:53:22 -0800
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH] wifi: ath11k: fix deinitialization of firmware resources
Date:   Thu, 9 Mar 2023 15:23:08 +0530
Message-ID: <20230309095308.24937-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: O45KQiP010-f4vFbbH1CxPqU41WKtAOp
X-Proofpoint-ORIG-GUID: O45KQiP010-f4vFbbH1CxPqU41WKtAOp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_06,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090077
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, in ath11k_ahb_fw_resources_init(), iommu domain
mapping is done only for the chipsets having fixed firmware
memory. Also, for such chipsets, mapping is done only if it
does not have TrustZone support.

During deinitialization, only if TrustZone support is not there,
iommu is unmapped back. However, for non fixed firmware memory
chipsets, TrustZone support is not there and this makes the
condition check to true and it tries to unmap the memory which
was not mapped during initialization.

This leads to the following trace -

[   83.198790] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
[   83.259537] Modules linked in: ath11k_ahb ath11k qmi_helpers
.. snip ..
[   83.280286] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   83.287228] pc : __iommu_unmap+0x30/0x140
[   83.293907] lr : iommu_unmap+0x5c/0xa4
[   83.298072] sp : ffff80000b3abad0
.. snip ..
[   83.369175] Call trace:
[   83.376282]  __iommu_unmap+0x30/0x140
[   83.378541]  iommu_unmap+0x5c/0xa4
[   83.382360]  ath11k_ahb_fw_resource_deinit.part.12+0x2c/0xac [ath11k_ahb]
[   83.385666]  ath11k_ahb_free_resources+0x140/0x17c [ath11k_ahb]
[   83.392521]  ath11k_ahb_shutdown+0x34/0x40 [ath11k_ahb]
[   83.398248]  platform_shutdown+0x20/0x2c
[   83.403455]  device_shutdown+0x16c/0x1c4
[   83.407621]  kernel_restart_prepare+0x34/0x3c
[   83.411529]  kernel_restart+0x14/0x74
[   83.415781]  __do_sys_reboot+0x1c4/0x22c
[   83.419427]  __arm64_sys_reboot+0x1c/0x24
[   83.423420]  invoke_syscall+0x44/0xfc
[   83.427326]  el0_svc_common.constprop.3+0xac/0xe8
[   83.430974]  do_el0_svc+0xa0/0xa8
[   83.435659]  el0_svc+0x1c/0x44
[   83.438957]  el0t_64_sync_handler+0x60/0x144
[   83.441910]  el0t_64_sync+0x15c/0x160
[   83.446343] Code: aa0103f4 f9400001 f90027a1 d2800001 (f94006a0)
[   83.449903] ---[ end trace 0000000000000000 ]---

This can be reproduced by probing an AHB chipset which is not
having a fixed memory region. During reboot (or rmmod) trace
can be seen.

Fix this issue by adding a condition check on firmware fixed memory
hw_param as done in the counter initialization function.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Fixes: f9eec4947add ("ath11k: Add support for targets without trustzone")
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 6b6059d5dc38..957db8a7db45 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1078,6 +1078,12 @@ static int ath11k_ahb_fw_resource_deinit(struct ath11k_base *ab)
 	struct iommu_domain *iommu;
 	size_t unmapped_size;
 
+	/* Chipsets not requiring MSA would have not initialized
+	 * MSA resources, return success in such cases.
+	 */
+	if (!ab->hw_params.fixed_fw_mem)
+		return 0;
+
 	if (ab_ahb->fw.use_tz)
 		return 0;
 

base-commit: 1a304987a22c9f383f163f93beb47e89080d1cee
-- 
2.17.1

