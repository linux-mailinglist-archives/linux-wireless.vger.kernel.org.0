Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE222793727
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Sep 2023 10:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbjIFIaX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Sep 2023 04:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbjIFIaX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Sep 2023 04:30:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F68CFF
        for <linux-wireless@vger.kernel.org>; Wed,  6 Sep 2023 01:30:17 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3865sfdB009282;
        Wed, 6 Sep 2023 08:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=+kNYaxq3THPXlNh14ECUgjW/Xoh3fWn5i2TvTnuTF0A=;
 b=bG5LOqpUWmXH7zNschvNkl84v3oZhu80mXJwNXc5Ual87dArxDe1o65tCPWuoG/h+V7l
 hikgvp8YxLbwBU+waMzfqUtQXD6AdAPfIL2KbJmBiuR62PnyhbdmpBsJAgcLURzn5/4O
 ZJFkDcnWSAW2kSKSYD4y6rCtiwmqGD+k2rEtTfKVzKzEiyxaAhzNLgbK6l/ISdkN2pZK
 neuympug/nAMcd0jTDhkzhVh+kazbAAqn/WaLTZzYWNEdHmkrzq3F0nZEzyT9VKuLjBO
 mdBFVJROfsHFX6XJ7IuS2yqCK2blYse4qpmm0z4xa62xaEv05E7Dy6YJegH1asc3bKZT tw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxhbhgnae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 08:30:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3868UBix021509
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Sep 2023 08:30:11 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 6 Sep 2023 01:30:10 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH 1/4] wifi: ath12k: add configure country code for WCN7850
Date:   Wed, 6 Sep 2023 04:29:45 -0400
Message-ID: <20230906082948.18452-2-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230906082948.18452-1-quic_wgong@quicinc.com>
References: <20230906082948.18452-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c5rjzTbjqNXDY5hsMgYLAMFoHTM3Kunr
X-Proofpoint-ORIG-GUID: c5rjzTbjqNXDY5hsMgYLAMFoHTM3Kunr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_01,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=980 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060070
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add handler to send WMI_SET_CURRENT_COUNTRY_CMDID to firmware which
is used for WCN7850.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 36 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h | 13 ++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 9ed33e2d6da0..aa87b559eff1 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2844,6 +2844,42 @@ int ath12k_wmi_send_init_country_cmd(struct ath12k *ar,
 	return ret;
 }
 
+int ath12k_wmi_send_set_current_country_cmd(struct ath12k *ar,
+					    struct wmi_set_current_country_params *param)
+{
+	struct ath12k_wmi_pdev *wmi = ar->wmi;
+	struct wmi_set_current_country_cmd *cmd;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_set_current_country_cmd *)skb->data;
+	cmd->tlv_header =
+		ath12k_wmi_tlv_cmd_hdr(WMI_TAG_SET_CURRENT_COUNTRY_CMD,
+				       sizeof(*cmd));
+
+	cmd->pdev_id = cpu_to_le32(ar->pdev->pdev_id);
+	memcpy(&cmd->new_alpha2, &param->alpha2, 3);
+	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_SET_CURRENT_COUNTRY_CMDID);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+		   "set current country pdev id %d alpha2 %c%c\n",
+		   ar->pdev->pdev_id,
+		   param->alpha2[0],
+		   param->alpha2[1]);
+
+	if (ret) {
+		ath12k_warn(ar->ab,
+			    "failed to send WMI_SET_CURRENT_COUNTRY_CMDID: %d\n", ret);
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
+
 int
 ath12k_wmi_send_twt_enable_cmd(struct ath12k *ar, u32 pdev_id)
 {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 8c047a9623f9..8940b8154091 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3749,6 +3749,16 @@ struct ath12k_wmi_ap_ps_arg {
 	u32 value;
 };
 
+struct wmi_set_current_country_params {
+	u8 alpha2[3];
+};
+
+struct wmi_set_current_country_cmd {
+	__le32 tlv_header;
+	__le32 pdev_id;
+	__le32 new_alpha2;
+} __packed;
+
 enum set_init_cc_type {
 	WMI_COUNTRY_INFO_TYPE_ALPHA,
 	WMI_COUNTRY_INFO_TYPE_COUNTRY_CODE,
@@ -4879,6 +4889,9 @@ int ath12k_wmi_send_bcn_offload_control_cmd(struct ath12k *ar,
 					    u32 vdev_id, u32 bcn_ctrl_op);
 int ath12k_wmi_send_init_country_cmd(struct ath12k *ar,
 				     struct ath12k_wmi_init_country_arg *arg);
+int
+ath12k_wmi_send_set_current_country_cmd(struct ath12k *ar,
+					struct wmi_set_current_country_params *param);
 int ath12k_wmi_peer_rx_reorder_queue_setup(struct ath12k *ar,
 					   int vdev_id, const u8 *addr,
 					   dma_addr_t paddr, u8 tid,
-- 
2.40.1

