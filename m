Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5831A5B6730
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Sep 2022 07:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiIMFPu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 01:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiIMFPp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 01:15:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68BB4BA6C
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 22:15:43 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D1vU4u004182;
        Tue, 13 Sep 2022 05:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=q+HHoG+om8SqUjcuIAeqLqqgqpRgdF2U1dqsfOpZ7yc=;
 b=U2AfZUrvdlWXgDVCzjZvA/q4FCa8S0CZQrUbWx4MiYlDntASAYW/PZ4ho2E93vLtct7E
 bz/89dHT/YSUe7uZX+xsknAHqj2L7PIUVQ6yojjuK3+BSTQc+fQFVmay6Qc+BYMEPeZ7
 djgASFci8KlDMOehoLJb5TnfIl+WMFdB87o/dcNWQvEuzw9nj3/0yXWZdnFGzKZ8iNqG
 bjLlk0eG33PtjcDf2XvFN4OKSUo5b5MzXCKVn2Q2w0KMUMahR9isEBppCRy7QxRfQO4P
 QB5t9zIQ2bn0765NetsZNGIi2SSH23gIpHBkSKQVl2i191ZAOk499I9nJhSO1WNCqYPq oQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgkrsy4eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 05:15:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28D5FcLM011536
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 05:15:38 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 12 Sep 2022 22:15:37 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v3 03/15] wifi: ath11k: allow only one interface up simultaneously for WCN6855
Date:   Tue, 13 Sep 2022 01:15:06 -0400
Message-ID: <20220913051518.23051-4-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220913051518.23051-1-quic_wgong@quicinc.com>
References: <20220913051518.23051-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aAahq9iB91TtTBBeN5Op5EjcO3gesYvR
X-Proofpoint-ORIG-GUID: aAahq9iB91TtTBBeN5Op5EjcO3gesYvR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_02,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501 mlxlogscore=684
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209130023
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently ath11k support both station/AP mode for WCN6855, and it is
configured with single_pdev_only, it means it has only one ath11k
and one ieee80211_hw which registered in mac80211 and one wiphy
registered in cfg80211. Now it does not have requirement to start
up both station and AP interface simultaneously for WCN6855, this
is to disable station and AP concurrency mode.

After this patch, when station interface is up, then AP interface
can not start up. AP interface can start up after station interface
down. Also when AP interface is up, station interface can not start
up. station interface can start up after AP interface down.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/hw.c  |  5 +++++
 drivers/net/wireless/ath/ath11k/hw.h  |  1 +
 drivers/net/wireless/ath/ath11k/mac.c | 17 ++++++++++++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index d503e8a73d32..712818edb4ca 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -807,6 +807,11 @@ bool ath11k_hw_supports_cc_ext(struct ath11k_base *ab)
 		test_bit(WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT, ab->wmi_ab.svc_map);
 }
 
+bool ath11k_hw_supports_6g_cc_ext(struct ath11k *ar)
+{
+	return ath11k_hw_supports_cc_ext(ar->ab) && ar->supports_6ghz;
+}
+
 const struct ath11k_hw_ops ipq8074_ops = {
 	.get_hw_mac_from_pdev_id = ath11k_hw_ipq8074_mac_from_pdev_id,
 	.wmi_init_config = ath11k_init_wmi_config_ipq8074,
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index b57cab2b0c7b..969d29aaee6a 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -278,6 +278,7 @@ static inline int ath11k_hw_mac_id_to_srng_id(struct ath11k_hw_params *hw,
 }
 
 bool ath11k_hw_supports_cc_ext(struct ath11k_base *ab);
+bool ath11k_hw_supports_6g_cc_ext(struct ath11k *ar);
 
 struct ath11k_fw_ie {
 	__le32 id;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 07f499d5ec92..7180ac37b327 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8218,7 +8218,22 @@ static int ath11k_mac_setup_iface_combinations(struct ath11k *ar)
 
 	combinations[0].limits = limits;
 	combinations[0].n_limits = n_limits;
-	combinations[0].max_interfaces = 16;
+
+	/* When single pdev is set, there is only one ieee80211_hw/wiphy
+	 * of mac80211/cfg80211, and it has only one reg rules stored
+	 * The reg rules of 6 GHz is different for station and AP, please
+	 * refer WMI_REG_CHAN_LIST_CC_EXT_EVENTID handler.
+	 * When start station/AP simultaneously, there is not more
+	 * struct to store the second reg rules in cfg80211.
+	 * Also it does not have requirement for station/AP concurrency
+	 * for WCN6855, so disable it currently.
+	 */
+	if (ab->hw_params.single_pdev_only &&
+	    ath11k_hw_supports_6g_cc_ext(ar))
+		combinations[0].max_interfaces = 1;
+	else
+		combinations[0].max_interfaces = 16;
+
 	combinations[0].num_different_channels = 1;
 	combinations[0].beacon_int_infra_match = true;
 	combinations[0].beacon_int_min_gcd = 100;
-- 
2.31.1

