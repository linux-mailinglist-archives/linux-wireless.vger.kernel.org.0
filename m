Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD04E631F04
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 12:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiKULE2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 06:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKULE0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 06:04:26 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDEB22297
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 03:04:26 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL8SFEp017448;
        Mon, 21 Nov 2022 11:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=lKMXngEBc3eIeWXCu2Kx+xMnPjpxi8v5C4tNX3xXGO8=;
 b=Nfvd2D3Y5PS2yhUpTsiKW8M5h6yEwZN84bLP6I9H4dhbI09VpN7/NPzCx4e4Qi0HmQyw
 O9tInvcTpSvjfgcNbZ0IwE8GEf4Iinlj/Imo6w0mCp1XeoVNpWAzOLiDLNdfzb83iODM
 nTPmdwVhy2oCpq4FHEDTlbDAgCM3bsS2/wcoKON3WcxMrHJsCF0Q45AAtF+1Hqvw3X1A
 bOrV6BSpx19ebKJEd/4I4/iTwtsEVwrx6N2DeRigx0F7Vdi/ze5pFwWMi6oVf+YtgGfW
 rbbnjmPX+FLulqoFbdA7eabDFp+L1w0rLLDQR7Radxk7ymc3/8kLl8CHm+deQx4CvQNb Ug== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxraucasm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 11:04:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ALB4Npd019423
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 11:04:23 GMT
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 21 Nov 2022 03:04:21 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v3 1/3] ath11k: Fix double free issue during SRNG deinit
Date:   Mon, 21 Nov 2022 16:33:57 +0530
Message-ID: <20221121110359.4652-2-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221121110359.4652-1-quic_mpubbise@quicinc.com>
References: <20221121110359.4652-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Bx18R4HoksXDdUuSqchQ6v16G6Jvkr0S
X-Proofpoint-ORIG-GUID: Bx18R4HoksXDdUuSqchQ6v16G6Jvkr0S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=747 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently struct ath11k_hal::srng_config pointer is not assigned
to NULL after freeing the memory in ath11k_hal_srng_deinit().
This could lead to double free issue in a scenario where
ath11k_hal_srng_deinit() is invoked back to back.

In the current code, although the chances are very low, the above
said scenario could happen when hardware recovery has failed and
then there is another FW assert where ath11k_hal_srng_deinit() is
invoked once again as part of recovery. Addressing this issue is
important when low power mode support is enabled in the driver
(will be added by a future patch) where this scenario is likely.

Fix this by assigning the struct ath11k_hal::srng_config pointer
to NULL after freeing the memory.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/hal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 2fd224480d45..e92c741526f8 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1319,6 +1319,7 @@ void ath11k_hal_srng_deinit(struct ath11k_base *ab)
 	ath11k_hal_free_cont_rdp(ab);
 	ath11k_hal_free_cont_wrp(ab);
 	kfree(hal->srng_config);
+	hal->srng_config = NULL;
 }
 EXPORT_SYMBOL(ath11k_hal_srng_deinit);
 
-- 
2.38.0

