Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51669719217
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 07:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjFAFTp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 01:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjFAFTn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 01:19:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB12129
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 22:19:41 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351578ox031911;
        Thu, 1 Jun 2023 05:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Yy3oREs4FT+zq89LduHz1C83zuAHJT623vPqz8MkuEU=;
 b=EOH9VQZAuEUxQfeBTuodKPMomatDtimG66vOo9fbfr10BmTFsSkCUWYkxy4sVIDCV+ha
 XnDK54sq6c8kqBBFYprp92owUoEI38W9MPa2ER/aAN0q4VZbloiUd1QG+oVl2xWDX4Yx
 tsD6EONkRaj9O/h/E7Wqp/6dVHcrepzZy3hTsR1CZK+vsb5vbd8PNUTR+tVa0htcm9VT
 ob0aIUEWBpGTlxmFyF68HIIxk/UM5KaRvVhQ1TFhldYl6tTqehuDS6+wTXVb3jT3IuIW
 i5C5rTV66CxC2193hkJV4eTnX9jNIYA2UQQ2OHZQjr7yroiG/AnpKiiXGYaD+VYdcFNE Zg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxkbu05de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 05:19:32 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3515JVd5011445
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 05:19:31 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 31 May 2023 22:19:28 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v2] wifi: ath11k: update proper pdev/vdev id for testmode command
Date:   Thu, 1 Jun 2023 10:49:07 +0530
Message-ID: <20230601051907.13679-1-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zcGklWjSgGuDuTXtOqyWU9ZXJc-AFfOk
X-Proofpoint-GUID: zcGklWjSgGuDuTXtOqyWU9ZXJc-AFfOk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_02,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010045
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>

User can extend test mode command support to set vdev and pdev params
for debug purpose at run time by sending vdev/pdev param set command
through the testmode command interface.

Fill the proper pdev/vdev id in driver since, pdev/vdev id details may
not be available at user space. It will make sure that the proper
vdev/pdev ids are sent to firmware.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
Depends-On:
	[v4,3/4] wifi: ath11k: factory test mode support
v2:
- Rebased and validated on latest version (v4) of dependency patch.
---

 drivers/net/wireless/ath/ath11k/testmode.c | 37 ++++++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/testmode.c b/drivers/net/wireless/ath/ath11k/testmode.c
index 9dbe88e0546b..c5caa3449751 100644
--- a/drivers/net/wireless/ath/ath11k/testmode.c
+++ b/drivers/net/wireless/ath/ath11k/testmode.c
@@ -290,13 +290,16 @@ static int ath11k_tm_cmd_testmode_start(struct ath11k *ar, struct nlattr *tb[])
 	return ret;
 }
 
-static int ath11k_tm_cmd_wmi(struct ath11k *ar, struct nlattr *tb[])
+static int ath11k_tm_cmd_wmi(struct ath11k *ar, struct nlattr *tb[],
+			     struct ieee80211_vif *vif)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
 	struct sk_buff *skb;
+	struct ath11k_vif *arvif;
 	u32 cmd_id, buf_len;
-	int ret;
+	int ret, tag;
 	void *buf;
+	u32 *ptr;
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -320,6 +323,34 @@ static int ath11k_tm_cmd_wmi(struct ath11k *ar, struct nlattr *tb[])
 
 	cmd_id = nla_get_u32(tb[ATH11K_TM_ATTR_WMI_CMDID]);
 
+	/* Make sure that the buffer length is long enough to
+	 * hold TLV and pdev/vdev id.
+	 */
+	if (buf_len < sizeof(struct wmi_tlv) + sizeof(u32)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ptr = buf;
+	tag = FIELD_GET(WMI_TLV_TAG, *ptr);
+
+	/* pdev/vdev id start after TLV header */
+	ptr++;
+
+	if (tag == WMI_TAG_PDEV_SET_PARAM_CMD)
+		*ptr = ar->pdev->pdev_id;
+
+	if (ar->ab->fw_mode != ATH11K_FIRMWARE_MODE_FTM &&
+	    (tag == WMI_TAG_VDEV_SET_PARAM_CMD || tag == WMI_TAG_UNIT_TEST_CMD)) {
+		if (vif) {
+			arvif = (struct ath11k_vif *)vif->drv_priv;
+			*ptr = arvif->vdev_id;
+		} else {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
 	ath11k_dbg(ar->ab, ATH11K_DBG_TESTMODE,
 		   "testmode cmd wmi cmd_id %d buf length %d\n",
 		   cmd_id, buf_len);
@@ -453,7 +484,7 @@ int ath11k_tm_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case ATH11K_TM_CMD_GET_VERSION:
 		return ath11k_tm_cmd_get_version(ar, tb);
 	case ATH11K_TM_CMD_WMI:
-		return ath11k_tm_cmd_wmi(ar, tb);
+		return ath11k_tm_cmd_wmi(ar, tb, vif);
 	case ATH11K_TM_CMD_TESTMODE_START:
 		return ath11k_tm_cmd_testmode_start(ar, tb);
 	case ATH11K_TM_CMD_WMI_FTM:
-- 
2.17.1

