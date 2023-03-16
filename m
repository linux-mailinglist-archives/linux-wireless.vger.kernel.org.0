Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C63D6BC521
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Mar 2023 05:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjCPEMC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Mar 2023 00:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCPEMB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Mar 2023 00:12:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ABAAA72A
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 21:12:00 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G243aK026548;
        Thu, 16 Mar 2023 04:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=WUJqB4wblkKMmtLI4SCICjgalhUJvzmuMeH314QVpjk=;
 b=R7x8u7o3duCbIRm+VLNMf4YXc+/UBcujwMnaW0NU76GmW8DvMCR+bQBIcAh6oNhcbppA
 zKcp3ogfnuwrsTvUewttwVpX8JoSKoEzBgf9iF38jmVF3vilRK+mlz7kfASCudZNN9R8
 mmeAVj9/RSbkFPgNK8JTqh9wR4KNIGJhfduJtJEED1s9S5Kmp/ZRQ4QA9rkDG9gvQ9fR
 +ld/J+5+6GdpiJq+3RR8mQfUCvVVdabn6RWNhpmqarjckkygaORtRz6uYoGsTBoFrW65
 vbScsLBIPSfL8ioQFpDasTHwMH0BQmpnn27e4g9WcEhqW5/J+RlZ5S0Cd5jtzmrk0drQ fw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbpxjrn3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 04:11:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32G4Bv3T000462
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 04:11:57 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 15 Mar 2023 21:11:55 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: ath12k: Identify DFS channel when sending scan channel list command
Date:   Thu, 16 Mar 2023 12:11:44 +0800
Message-ID: <20230316041144.7770-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fZb-VRYzW3DOSFJs02Ulc-mpHv0gYnLC
X-Proofpoint-ORIG-GUID: fZb-VRYzW3DOSFJs02Ulc-mpHv0gYnLC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_02,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303160035
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

WMI_CHAN_INFO_DFS flag should be set when configuring a DFS channel
included in scan channel list. Without it, firmware will not send a
probe request frame which is needed in connection to an AP configured
with hidden SSID/network_id. So fix this to allow probe request frames
to be sent in cases where a beacon frame has been seen on the channel
first.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 3e6991120e53..af910296c41e 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2438,6 +2438,9 @@ int ath12k_wmi_send_scan_chan_list_cmd(struct ath12k *ar,
 			if (channel_arg->psc_channel)
 				chan_info->info |= cpu_to_le32(WMI_CHAN_INFO_PSC);
 
+			if (channel_arg->dfs_set)
+				chan_info->info |= cpu_to_le32(WMI_CHAN_INFO_DFS);
+
 			chan_info->info |= le32_encode_bits(channel_arg->phy_mode,
 							    WMI_CHAN_INFO_MODE);
 			*reg1 |= le32_encode_bits(channel_arg->minpower,

base-commit: 3df3715e556027e94246b2cb30986563362a65f4
-- 
2.25.1

