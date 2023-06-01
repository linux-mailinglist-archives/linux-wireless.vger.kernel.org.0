Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3259871A013
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 16:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjFAOcq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 10:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjFAOcp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 10:32:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495C3D1
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 07:32:44 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351A83ia011454;
        Thu, 1 Jun 2023 14:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=o+c8AeKmJiMLSsaLrBv858IYbfUAvPdo/g6VIV6fl0o=;
 b=GHQ4tuzCAHu76GNBdbjT39+nptdIYJ0jQm/x72xjduWttyxuoSnuqZyWhubKLWAqrCQf
 YZJs+4nK6qmzWB4jjeHs6C1ZV8UuxBoHyh8q1K3zDFcl+A9I90p7B39ng1MNSWdEZO+S
 72J0NOOCksR1qvzPfEsV3JmtV0FR3HRLkfCtDtV73qJ8RaZiAyvMdgCsvHWI81JqM07a
 PWK2aspwPCahJfib9iSz0B2f/BSsmZXikdCdCFh88Iy8dGQi/FnXZGT6VVE1TI6PvNMZ
 vSy2H27q/Ek2CtY5spbA/KIVfPzmSfHLGEpUOkx4tyBsjQi9wn2170vW8zTRZEXnzKmL hQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxs9grqtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 14:32:38 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351EWb6W030229
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 14:32:37 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 1 Jun 2023 07:32:35 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v3] wifi: ath11k: update proper pdev/vdev id for testmode command
Date:   Thu, 1 Jun 2023 20:02:14 +0530
Message-ID: <20230601143214.13006-1-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 73Zeq50z6H-qEXnIKJoZOm_N6qZ577CI
X-Proofpoint-GUID: 73Zeq50z6H-qEXnIKJoZOm_N6qZ577CI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010128
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
v3:
- Rebased and validated in latest ToT.

v2:
- Rebased and validated on latest version (v4) of dependency patch.
---
 drivers/net/wireless/ath/ath11k/testmode.c | 37 ++++++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/testmode.c b/drivers/net/wireless/ath/ath11k/testmode.c
index 3611b6ec39c6..8fc5cddb28bd 100644
--- a/drivers/net/wireless/ath/ath11k/testmode.c
+++ b/drivers/net/wireless/ath/ath11k/testmode.c
@@ -297,13 +297,16 @@ static int ath11k_tm_cmd_testmode_start(struct ath11k *ar, struct nlattr *tb[])
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
 
@@ -327,6 +330,34 @@ static int ath11k_tm_cmd_wmi(struct ath11k *ar, struct nlattr *tb[])
 
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
 		   "cmd wmi cmd_id %d buf length %d\n",
 		   cmd_id, buf_len);
@@ -460,7 +491,7 @@ int ath11k_tm_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case ATH11K_TM_CMD_GET_VERSION:
 		return ath11k_tm_cmd_get_version(ar, tb);
 	case ATH11K_TM_CMD_WMI:
-		return ath11k_tm_cmd_wmi(ar, tb);
+		return ath11k_tm_cmd_wmi(ar, tb, vif);
 	case ATH11K_TM_CMD_TESTMODE_START:
 		return ath11k_tm_cmd_testmode_start(ar, tb);
 	case ATH11K_TM_CMD_WMI_FTM:

base-commit: a4756ac34a7002861c9bdf8cf45aec53a77fb78d
-- 
2.17.1

