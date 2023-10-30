Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138537DB517
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 09:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjJ3I2Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 04:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjJ3I2Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 04:28:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2C3AB
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 01:28:22 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39U63Yqt006822;
        Mon, 30 Oct 2023 08:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ixZh+eIbdHoJaWNN+NS3RAujvvs+h42kb1oCjsNDURI=;
 b=Yx+2qxLFxJu+g/NkwdtWgExN0M8zLUJdkEkWLjIWFbfSBIxym6321gGpWsli6NXG3dVV
 u5cbCIka1/T8zuQ6IgEjVFwWdIM5d5PmjVRhnY3qwUvQZ6KnLZsY6sNiiM58tAnJrYbz
 KJRk3M663iNWMwhcxRbzezKwVuK/h6sakcaatVfMPrLOvgIe/mYJrurwanMlOdtAqs4f
 IE0E+HbL0EV7I+LNKpXlwIhWIKCE2XpO7u4OXW1NGvi6SIBkNCFzdlzgPmMsC+ntAVVy
 xSQcZlHsuk5Wg7y0KD124nGYGS2dfQ6Y6tLhzZFJz2BRJDY4oFy8HjZv7W1z+Bea0A4R iA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u0smrkcag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 08:28:19 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39U8SI2A011034
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 08:28:18 GMT
Received: from aarasahu-linux.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 30 Oct 2023 01:28:15 -0700
From:   Aaradhana Sahu <quic_aarasahu@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Rajat Soni <quic_rajson@quicinc.com>,
        Aaradhana Sahu <quic_aarasahu@quicinc.com>
Subject: [PATCH 4/4] wifi: ath12k: Fill pdev id for fw test cmd
Date:   Mon, 30 Oct 2023 13:57:49 +0530
Message-ID: <20231030082749.17855-5-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231030082749.17855-1-quic_aarasahu@quicinc.com>
References: <20231030082749.17855-1-quic_aarasahu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _sIhYD0vLRnxnrcRG3IMQBqb5ucgLsC6
X-Proofpoint-GUID: _sIhYD0vLRnxnrcRG3IMQBqb5ucgLsC6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_06,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310300063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rajat Soni <quic_rajson@quicinc.com>

Currently pdev id is not set properly that can cause crash
if pdev id is not equal to the pdev id when firmware test
command is run during AP bring up or ping.

Set pdev id in function ath12k_tm_cmd_wmi to resolve this
issue.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00126-QCAHKSWPL_SILICONZ-1

Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/testmode.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/testmode.c b/drivers/net/wireless/ath/ath12k/testmode.c
index cc5e482049a5..64f76e87064d 100644
--- a/drivers/net/wireless/ath/ath12k/testmode.c
+++ b/drivers/net/wireless/ath/ath12k/testmode.c
@@ -318,9 +318,10 @@ static int ath12k_tm_cmd_wmi(struct ath12k *ar, struct nlattr *tb[])
 {
 	struct ath12k_wmi_pdev *wmi = ar->wmi;
 	struct sk_buff *skb;
-	u32 cmd_id, buf_len;
-	int ret;
+	struct wmi_pdev_set_param_cmd *cmd;
+	int ret, tag;
 	void *buf;
+	u32 cmd_id, buf_len;
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -345,6 +346,12 @@ static int ath12k_tm_cmd_wmi(struct ath12k *ar, struct nlattr *tb[])
 
 	cmd_id = nla_get_u32(tb[ATH_TM_ATTR_WMI_CMDID]);
 
+	cmd = buf;
+	tag = le32_get_bits(cmd->tlv_header, WMI_TLV_TAG);
+
+	if (tag == WMI_TAG_PDEV_SET_PARAM_CMD)
+		cmd->pdev_id = cpu_to_le32(ar->pdev->pdev_id);
+
 	ath12k_dbg(ar->ab, ATH12K_DBG_TESTMODE,
 		   "testmode cmd wmi cmd_id %d  buf length %d\n",
 		   cmd_id, buf_len);
-- 
2.17.1

