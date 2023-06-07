Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347C7725B09
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jun 2023 11:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbjFGJsu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Jun 2023 05:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238542AbjFGJsq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Jun 2023 05:48:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46F9E47
        for <linux-wireless@vger.kernel.org>; Wed,  7 Jun 2023 02:48:45 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3578QVTG013390;
        Wed, 7 Jun 2023 09:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=YEBhsEscXFVxggAB00hJQmmcjszSLv3zRsbcqlSkrmw=;
 b=oVNOzeGzJlT93RaO+hngFh86y8HFo9X1zTS/1e97vnQG2lAEWSoYiEs7IB4My3Nvu0ea
 az5QURrw08SgwMSN4wyyJo5MU5jPjrJaaDAZGDoc8SyuNz0giFN6wes2pjkat0iGBC1X
 BVcloRPqCWjLZVEdf2zVN3wHACEAbol6XkG42BiHUz/6N27yurSVpVydst6W12FKybWv
 Jp725YwA85ph3PXm38iH5NsoO4NBSiOW3oIOR5H2tLS8pdaWnMUkoToz7syskCUjFDUp
 lyCxxxyI/x2a7jMGa+FLTM4OX3f7RZjwEHAsNGTEi0ZyuB7tlORJjRnXXcmjO1KCXk7i rw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a719hsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 09:48:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3579mgvP017934
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 09:48:42 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 02:48:41 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, Wen Gong <quic_wgong@quicinc.com>
Subject: [PATCH v4 5/5] wifi: ath11k: update regulatory rules when connect to AP on 6 GHz band for station
Date:   Wed, 7 Jun 2023 05:48:10 -0400
Message-ID: <20230607094810.26707-6-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607094810.26707-1-quic_wgong@quicinc.com>
References: <20230607094810.26707-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 88ZOfN8k-allPFny95LY6AmEpKyHfrIs
X-Proofpoint-ORIG-GUID: 88ZOfN8k-allPFny95LY6AmEpKyHfrIs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070079
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When station connect to AP on 6 GHz band, it need switch the regulatory
rules according to the regulatory info subfield in HE operation element.
Swith to the power type of AP for station mode.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index f586b37336b0..a67fa7c1a6aa 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7287,6 +7287,8 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	struct ath11k_vif *arvif = (void *)vif->drv_priv;
 	int ret;
 	struct peer_create_params param;
+	struct cur_regulatory_info *reg_info;
+	enum ieee80211_ap_reg_power power_type;
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -7294,6 +7296,18 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		   "mac chanctx assign ptr %pK vdev_id %i\n",
 		   ctx, arvif->vdev_id);
 
+	if (ath11k_hw_supports_6g_cc_ext(ar) &&
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

