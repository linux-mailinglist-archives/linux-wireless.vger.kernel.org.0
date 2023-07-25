Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C7D7627E1
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 02:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjGZAwF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 20:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGZAwE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 20:52:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB5C1990
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 17:52:03 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PLLU3q007935;
        Tue, 25 Jul 2023 22:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=TpLka8jfmSqR2Nfou7svpWAMKL1ZiYnQ2PjwGfGTVK0=;
 b=Ue4rggbreEBkikCSPj86/clMY5DT8Qu7l+MH1D2qYiPwMYPMoJyzabBF6Qb+wJLtFU3n
 HI8ukHr3JYXeJ7T2JiIT7c2YVWkWAvDz1vQu/hn2C7gv1lS66ebgrbJ0vTk+xPGkgUw5
 HuzeO25fd9Nc/CymqooDftXHM6CfoXZQCuhy/j20p+y2vdUCjSsCiRbUPbog5anYdN7+
 qxWf5aNsMjK3Qp9h3twiC7tcNqcprElk1qEvfq1HhQfCaKuYjtiE3oPl9fCgCd8lqrHa
 rKfPX65SjR6knVK2dPZRj0YEbQ0gjFEYO55BcoFrGmhxaby0vrZVkidGSG3CFKjKUgt1 Jw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2fms1395-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 22:40:49 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36PMemOb028377
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 22:40:48 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 25 Jul 2023 15:40:48 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: [PATCH v5 08/11] wifi: ath12k: peer assoc for 320 MHz
Date:   Tue, 25 Jul 2023 15:40:31 -0700
Message-ID: <20230725224034.14045-9-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230725224034.14045-1-quic_alokad@quicinc.com>
References: <20230725224034.14045-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ysjvr10GIA4s3oS02Y_1JnKeZtNATw_F
X-Proofpoint-ORIG-GUID: Ysjvr10GIA4s3oS02Y_1JnKeZtNATw_F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_12,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250193
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add required peer association definitions and processing if the
bandwidth is 320 MHz.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Signed-off-by: Pradeep Kumar Chitrapu<quic_pradeepc@quicinc.com>
---
v5: No change from v4.
v4: No change from v3.
v3: No change from v2.
v2: No change from v1.

 drivers/net/wireless/ath/ath12k/wmi.c | 2 ++
 drivers/net/wireless/ath/ath12k/wmi.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index db1ff376319e..b0722050206d 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1816,6 +1816,8 @@ static void ath12k_wmi_copy_peer_flags(struct wmi_peer_assoc_complete_cmd *cmd,
 			cmd->peer_flags |= cpu_to_le32(WMI_PEER_80MHZ);
 		if (arg->bw_160)
 			cmd->peer_flags |= cpu_to_le32(WMI_PEER_160MHZ);
+		if (arg->bw_320)
+			cmd->peer_flags |= cpu_to_le32(WMI_PEER_EXT_320MHZ);
 
 		/* Typically if STBC is enabled for VHT it should be enabled
 		 * for HT as well
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 780d589268b0..764ca4947281 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -1169,6 +1169,7 @@ enum wmi_tlv_peer_flags {
 
 enum wmi_tlv_peer_flags_ext {
 	WMI_PEER_EXT_EHT = BIT(0),
+	WMI_PEER_EXT_320MHZ = BIT(1),
 };
 
 /** Enum list of TLV Tags for each parameter structure type. */
@@ -3553,6 +3554,7 @@ struct ath12k_wmi_peer_assoc_arg {
 	bool bw_40;
 	bool bw_80;
 	bool bw_160;
+	bool bw_320;
 	bool stbc_flag;
 	bool ldpc_flag;
 	bool static_mimops_flag;
-- 
2.39.0

