Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB916CF6BB
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 01:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjC2XMS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 19:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjC2XML (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 19:12:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BDC5272
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 16:12:09 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TMHZjP023568;
        Wed, 29 Mar 2023 23:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=g2CfjHZDMFcBVGzeGytEVLaiLOV2hc7DuOgF+v6OgXk=;
 b=imJmGG62zKu0GA1sE+qNa3/JeRAZXzNJ5jfphWpd1KpQlYRVz6WQpQjLFQHYAepKGj/b
 UkPVwCYllpjh1giRUee7MsyozxLBtDcVuEFj/YZYOG/7GUD3D47NMj6ZTOJ/0682sNQj
 Q8MJpJUZeieD4/zpUrjVjm5CK2IOOWaSgsrFrAsuciIDfIn219KKKjlazAO6tb1moopF
 TlQcPls+/yU3CpEGCnEzRrRJ8TNbSJxrhALFRY2cVQXI4R2+H8VSbJcLWMiUFCPpUCIk
 8tsgWfNMp8IA/6P2WUu7aEhWEh8Zf1MorQnO/98imQ8G2mHUxoBS5eCsuU4WvwcESLCO IA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pmbs8ax3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 23:12:06 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32TNC3x4028077
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 23:12:03 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 29 Mar 2023 16:12:01 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH 09/11] wifi: ath12k: add MLO header in peer association
Date:   Wed, 29 Mar 2023 16:11:43 -0700
Message-ID: <20230329231145.20171-10-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230329231145.20171-1-quic_alokad@quicinc.com>
References: <20230329231145.20171-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: g7VF3WB-IFkuvE_3If6KwkT487hP49rq
X-Proofpoint-GUID: g7VF3WB-IFkuvE_3If6KwkT487hP49rq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_14,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303290173
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>

Add tags with length 0 for MLO header and partner links,
witout these the peer association fails.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index e5513e979d78..319a2def5529 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1901,7 +1901,8 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 	      TLV_HDR_SIZE + (peer_ht_rates_align * sizeof(u8)) +
 	      sizeof(*mcs) + TLV_HDR_SIZE +
 	      (sizeof(*he_mcs) * arg->peer_he_mcs_count) +
-	      TLV_HDR_SIZE + (sizeof(*eht_mcs) * arg->peer_eht_mcs_count);
+	      TLV_HDR_SIZE + (sizeof(*eht_mcs) * arg->peer_eht_mcs_count) +
+	      TLV_HDR_SIZE + TLV_HDR_SIZE;
 
 	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
@@ -2040,6 +2041,18 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 		ptr += sizeof(*eht_mcs);
 	}
 
+	/* MLO header tag with 0 length */
+	len = 0;
+	tlv = ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT, len);
+	ptr += TLV_HDR_SIZE;
+
+	/* ML partner links tag with 0 length */
+	len = 0;
+	tlv = ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT, len);
+	ptr += TLV_HDR_SIZE;
+
 	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
 		   "wmi peer assoc vdev id %d assoc id %d peer mac %pM peer_flags %x rate_caps %x peer_caps %x listen_intval %d ht_caps %x max_mpdu %d nss %d phymode %d peer_mpdu_density %d vht_caps %x he cap_info %x he ops %x he cap_info_ext %x he phy %x %x %x peer_bw_rxnss_override %x peer_flags_ext %x eht mac_cap %x %x eht phy_cap %x %x %x\n",
 		   cmd->vdev_id, cmd->peer_associd, arg->peer_mac,
-- 
2.39.0

