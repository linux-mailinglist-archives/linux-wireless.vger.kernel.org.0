Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CD47A75CA
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 10:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjITIYb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 04:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjITIY2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 04:24:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCFDA3
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 01:24:22 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K6dDkM013733;
        Wed, 20 Sep 2023 08:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=BR0+Fi4audrCAycmPUcnFmcFqb3cA/lsUVmfAacu/T4=;
 b=HlDW2AvyxhQPkoAlbUBJ2BmLkzM07zeKweIBebtlgV8ekbqT3j8W9YvHROEYqoaLuCyu
 hmQaR1VJYNehUqphrJEgs2alO7jRl0viKKv7F0SYO6nj+LmLCJsTiyuZyDE+a/gsW5ds
 PdPeL47XNAH8SbddVGgRQz1QKhzIxptLRx+SrnMuhZmNZZM50PEnkqtie9EQx3X4oOEB
 zN7miVk2N66gk0Szg7RCqpeNT56FnIMIhv7kk6xzOPfvdyEZ8Us0zn8tQV92hJBgWLYh
 GmJO2xvu9lfX45gXc0uBs7WfCbebgEQRGH2+0FRJRgVfAn+ryxd4HBBBIYf7+2WqWIYx 1g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t7s2r0f4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 08:24:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38K8OG2s018809
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 08:24:16 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 20 Sep 2023 01:24:14 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>,
        <quic_jjohnson@quicinc.com>, <quic_wgong@quicinc.com>
Subject: [PATCH v6 05/13] wifi: ath11k: update regulatory rules when connect to AP on 6 GHz band for station
Date:   Wed, 20 Sep 2023 04:23:41 -0400
Message-ID: <20230920082349.29111-6-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230920082349.29111-1-quic_wgong@quicinc.com>
References: <20230920082349.29111-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5cV5qEYHl0zfXdbrS6BtosE-LzQr_-pQ
X-Proofpoint-ORIG-GUID: 5cV5qEYHl0zfXdbrS6BtosE-LzQr_-pQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_02,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When station connect to AP on 6 GHz band, it needs switch the regulatory
rules according to the regulatory info sub field in HE operation element.
Switch to the power type which AP used for station interface.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 0512c8b0661c..bc4ae3002322 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7613,6 +7613,8 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	int ret;
 	struct peer_create_params param;
+	struct cur_regulatory_info *reg_info;
+	enum ieee80211_ap_reg_power power_type;
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -7620,6 +7622,18 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		   "chanctx assign ptr %p vdev_id %i\n",
 		   ctx, arvif->vdev_id);
 
+	if (ath11k_mac_supports_6ghz_cc_ext(ar) &&
+	    ctx->def.chan->band == NL80211_BAND_6GHZ &&
+	    arvif->vdev_type == WMI_VDEV_TYPE_STA) {
+		reg_info = &ab->reg_info_store[ar->pdev_idx];
+		power_type = vif->bss_conf.power_type;
+		ath11k_dbg(ab, ATH11K_DBG_MAC, "mac chanctx power type %d\n",
+			   power_type);
+		if (power_type == IEEE80211_REG_UNSET_AP)
+			power_type = IEEE80211_REG_LPI_AP;
+		ath11k_reg_handle_chan_list(ab, reg_info, power_type);
+	}
+
 	/* for QCA6390 bss peer must be created before vdev_start */
 	if (ab->hw_params.vdev_start_delay &&
 	    arvif->vdev_type != WMI_VDEV_TYPE_AP &&
-- 
2.40.1

