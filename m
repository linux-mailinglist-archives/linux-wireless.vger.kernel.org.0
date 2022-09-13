Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB775B6738
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Sep 2022 07:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiIMFQ0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 01:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiIMFPy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 01:15:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0DF4BD3C
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 22:15:52 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D4xnU3011422;
        Tue, 13 Sep 2022 05:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=wm5Gy5EIebvjmzQY3uRpZlEgOE4uePRk12Ca/cscefk=;
 b=puzQ2aGH2RlyaPkE/aTPbcYgsQqeWsIkdz37NjXfpey1It3hrYz3XWps7y//TdNpW77v
 1Kvr/o32s3YkoHRV4tWxq2JuF8YdM4h2PqSo5o9J7MHLsXORk7JvGeC7030IHlAZFVQA
 uzvYOvX1l/Pw0wcYlyOcaScFBQ5iOKNasVGMsPdT+nu6GwJ6DvS9Q00t63Zie1HwFlE+
 qqtuTU4rlUN2s+549SOEXuaGkms06mZlVRNonisBbW3IOaBAWxsGm2c9yHARzN5zquRR
 7T1md6BoerxpzVtPNeisrf5BZo4DuEggVbihX8k+e/NUWq516+rG6zMgqgxy2CxecOQg hQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgkgpe22d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 05:15:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28D5FmT5028533
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 05:15:48 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 12 Sep 2022 22:15:47 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v3 10/15] wifi: ath11k: save max tx power in vdev start response event from firmware
Date:   Tue, 13 Sep 2022 01:15:13 -0400
Message-ID: <20220913051518.23051-11-quic_wgong@quicinc.com>
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
X-Proofpoint-GUID: w3boJVZXIOnCobcXDOIjP9fRqIaDpUJ7
X-Proofpoint-ORIG-GUID: w3boJVZXIOnCobcXDOIjP9fRqIaDpUJ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_02,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130023
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Save the max tx power received in the vdev start response event from
firmware. A subsequent patch will use this to calculate the final power
value for WMI_VDEV_SET_TPC_POWER_CMDID.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h | 1 +
 drivers/net/wireless/ath/ath11k/wmi.c  | 3 ++-
 drivers/net/wireless/ath/ath11k/wmi.h  | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 506829febad7..01909035017d 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -641,6 +641,7 @@ struct ath11k {
 	struct completion finish_11d_ch_list;
 	bool pending_11d;
 	bool regdom_set_by_user;
+	s8 max_allowed_tx_power;
 };
 
 struct ath11k_band_cap {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 8187b644078b..7d7751fd6a8e 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -4688,6 +4688,7 @@ static int ath11k_pull_vdev_start_resp_tlv(struct ath11k_base *ab, struct sk_buf
 	vdev_rsp->mac_id = ev->mac_id;
 	vdev_rsp->cfgd_tx_streams = ev->cfgd_tx_streams;
 	vdev_rsp->cfgd_rx_streams = ev->cfgd_rx_streams;
+	vdev_rsp->max_allowed_tx_power = ev->max_allowed_tx_power;
 
 	kfree(tb);
 	return 0;
@@ -7115,7 +7116,7 @@ static void ath11k_vdev_start_resp_event(struct ath11k_base *ab, struct sk_buff
 	}
 
 	ar->last_wmi_vdev_start_status = 0;
-
+	ar->max_allowed_tx_power = vdev_start_resp.max_allowed_tx_power;
 	status = vdev_start_resp.status;
 
 	if (WARN_ON_ONCE(status)) {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 754fef933cc7..2c50dc8c3834 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4076,6 +4076,7 @@ struct wmi_vdev_start_resp_event {
 	};
 	u32 cfgd_tx_streams;
 	u32 cfgd_rx_streams;
+	s32 max_allowed_tx_power;
 } __packed;
 
 /* VDEV start response status codes */
-- 
2.31.1

