Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165BB652FFF
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Dec 2022 11:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiLUK4h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Dec 2022 05:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbiLUK4T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Dec 2022 05:56:19 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5321DE
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 02:56:19 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BL9nxXg021669;
        Wed, 21 Dec 2022 10:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=fjIrs5eCGAufFm7GzMSc4H56gYrOm65WIWG+sLqF64s=;
 b=hW1deZTkAN35r0+mpYt89+afpeaJpyQy+AksX/MkQ5fduJtwxvXcqPW+Y8Af0frBPgkj
 ZViAGf1lmspmZoOPxaq8Knt0yQEPpi7pewEGmYsah17jqjV8VCNtefzj4HnJYPu2je1b
 9bCtKCqZxcH7X4bYNjiU519HG4w3RHds3HR9MCVL1X7/J0ZzETC950syXvuuO3mi7z9J
 mO4aD7jonsZa9ccubFKAYUomNEofbGYkdkPQ+WydUCjRwwfnnKO0frQ5kdOBbaXm97EX
 5bP2DjpvzRWlOMoxzKGT51KnvMO591pyZTefnlOx5giYK+rmayEy3Kaw4mJgrd4zZngr 1Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mk39tbqvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 10:56:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BLAuFqC016817
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 10:56:16 GMT
Received: from tmariyap-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 21 Dec 2022 02:56:14 -0800
From:   Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
Subject: [PATCH 2/4] wifi: ath12k: hal_rx: Use memset_startat() for clearing queue descriptors
Date:   Wed, 21 Dec 2022 16:25:27 +0530
Message-ID: <20221221105529.19345-3-quic_tmariyap@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221221105529.19345-1-quic_tmariyap@quicinc.com>
References: <20221221105529.19345-1-quic_tmariyap@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hy2Sy6_8Wh26py4ik7gLTPsVrTZk37c7
X-Proofpoint-GUID: hy2Sy6_8Wh26py4ik7gLTPsVrTZk37c7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_05,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=710 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212210088
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Use memset_startat() so memset() doesn't get confused about writing
beyond the destination member that is intended to be the starting point
of zeroing through the end of the struct and fixes the below clang
warning.

Warning:
include/linux/fortify-string.h:314:4: warning: call to '__write_overflow_field' declared with 'warning' attribute:
detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-03171-QCAHKSWPL_SILICONZ-1
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal_rx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.c b/drivers/net/wireless/ath/ath12k/hal_rx.c
index d47befb83e38..ee61a6462fdc 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.c
@@ -30,8 +30,7 @@ static int ath12k_hal_reo_cmd_queue_stats(struct hal_tlv_64_hdr *tlv,
 		  u32_encode_bits(sizeof(*desc), HAL_TLV_HDR_LEN);
 
 	desc = (struct hal_reo_get_queue_stats *)tlv->value;
-	memset(&desc->queue_addr_lo, 0,
-	       (sizeof(*desc) - sizeof(struct hal_reo_cmd_hdr)));
+	memset_startat(desc, 0, queue_addr_lo);
 
 	desc->cmd.info0 &= ~cpu_to_le32(HAL_REO_CMD_HDR_INFO0_STATUS_REQUIRED);
 	if (cmd->flag & HAL_REO_CMD_FLG_NEED_STATUS)
@@ -64,8 +63,7 @@ static int ath12k_hal_reo_cmd_flush_cache(struct ath12k_hal *hal,
 		  u32_encode_bits(sizeof(*desc), HAL_TLV_HDR_LEN);
 
 	desc = (struct hal_reo_flush_cache *)tlv->value;
-	memset(&desc->cache_addr_lo, 0,
-	       (sizeof(*desc) - sizeof(struct hal_reo_cmd_hdr)));
+	memset_startat(desc, 0, cache_addr_lo);
 
 	desc->cmd.info0 &= ~cpu_to_le32(HAL_REO_CMD_HDR_INFO0_STATUS_REQUIRED);
 	if (cmd->flag & HAL_REO_CMD_FLG_NEED_STATUS)
@@ -103,8 +101,7 @@ static int ath12k_hal_reo_cmd_update_rx_queue(struct hal_tlv_64_hdr *tlv,
 		  u32_encode_bits(sizeof(*desc), HAL_TLV_HDR_LEN);
 
 	desc = (struct hal_reo_update_rx_queue *)tlv->value;
-	memset(&desc->queue_addr_lo, 0,
-	       (sizeof(*desc) - sizeof(struct hal_reo_cmd_hdr)));
+	memset_startat(desc, 0, queue_addr_lo);
 
 	desc->cmd.info0 &= ~cpu_to_le32(HAL_REO_CMD_HDR_INFO0_STATUS_REQUIRED);
 	if (cmd->flag & HAL_REO_CMD_FLG_NEED_STATUS)
-- 
2.17.1

