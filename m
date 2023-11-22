Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1D27F3E47
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Nov 2023 07:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbjKVGkH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Nov 2023 01:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjKVGkE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Nov 2023 01:40:04 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB8D97
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 22:40:01 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM5bW2O029251;
        Wed, 22 Nov 2023 06:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=rqo2Whlexu3ociMnXsGIWZTe/YO9aRIVkp6UF+VOdvI=;
 b=goabLxOghmElNNXId+AJuT5KhAznFK7SxM4ePfVYqlGwvvtQBRu3rQ/v7UfFx48fFQ1Q
 VNzfhFCerSjsETjz1gpuKA0TvEVS7MOd419rF7o595lwoRfBzpZF85USNmYAI79EMzy7
 oSb8FJUxCEsb+o49EmpoXKVAAnkWMg/m/iP+z9UBAQMJDFDBpfkpafMahQ87e9mA8T05
 9alGjVBqle3lOVPHkEIeJ9F3y4taCfwkrNql1FBGUjdgr1bawqztezq6hMpW8TIGGjOB
 NZJU8Aky9uS0filbp178HO4nqepcOUMr4wWRUf47TBUGIkLipD+6mmAlsLS4EM0qLGLp jQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uh8mw8evu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 06:39:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AM6dwIh017623
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 06:39:58 GMT
Received: from tamizhr-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 21 Nov 2023 22:39:56 -0800
From:   Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Subject: [PATCH 3/3] wifi: ath12k: Remove unused tcl_*_ring configuration
Date:   Wed, 22 Nov 2023 12:09:32 +0530
Message-ID: <20231122063932.10321-4-quic_tamizhr@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231122063932.10321-1-quic_tamizhr@quicinc.com>
References: <20231122063932.10321-1-quic_tamizhr@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RdE-RINCDmzh4Mje1EvMJQNC1_JJsXVg
X-Proofpoint-ORIG-GUID: RdE-RINCDmzh4Mje1EvMJQNC1_JJsXVg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_04,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxlogscore=851
 adultscore=1 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220047
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently memory allocation for multiple hardware rings
done in host as these memory will be used by firmware/hardware.
But in case of tcl_cmd_ring and tcl_status_ring neither firmware
nor hardware uses host allocated memory and it uses memory allocated
by firmware itself. So avoid tcl_cmd_ring and tcl_status_ring setup
in host.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c | 16 ----------------
 drivers/net/wireless/ath/ath12k/dp.h |  2 --
 2 files changed, 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 6893466f61f0..22e91ecd908f 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -452,8 +452,6 @@ static void ath12k_dp_srng_common_cleanup(struct ath12k_base *ab)
 		ath12k_dp_srng_cleanup(ab, &dp->tx_ring[i].tcl_comp_ring);
 		ath12k_dp_srng_cleanup(ab, &dp->tx_ring[i].tcl_data_ring);
 	}
-	ath12k_dp_srng_cleanup(ab, &dp->tcl_status_ring);
-	ath12k_dp_srng_cleanup(ab, &dp->tcl_cmd_ring);
 	ath12k_dp_srng_cleanup(ab, &dp->wbm_desc_rel_ring);
 }
 
@@ -474,20 +472,6 @@ static int ath12k_dp_srng_common_setup(struct ath12k_base *ab)
 		goto err;
 	}
 
-	ret = ath12k_dp_srng_setup(ab, &dp->tcl_cmd_ring, HAL_TCL_CMD, 0, 0,
-				   DP_TCL_CMD_RING_SIZE);
-	if (ret) {
-		ath12k_warn(ab, "failed to set up tcl_cmd ring :%d\n", ret);
-		goto err;
-	}
-
-	ret = ath12k_dp_srng_setup(ab, &dp->tcl_status_ring, HAL_TCL_STATUS,
-				   0, 0, DP_TCL_STATUS_RING_SIZE);
-	if (ret) {
-		ath12k_warn(ab, "failed to set up tcl_status ring :%d\n", ret);
-		goto err;
-	}
-
 	for (i = 0; i < ab->hw_params->max_tx_ring; i++) {
 		map = ab->hw_params->hal_ops->tcl_to_wbm_rbm_map;
 		tx_comp_ring_num = map[i].wbm_ring_num;
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 61f765432516..5653a1f4964b 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -316,8 +316,6 @@ struct ath12k_dp {
 	struct dp_link_desc_bank link_desc_banks[DP_LINK_DESC_BANKS_MAX];
 	struct dp_srng wbm_idle_ring;
 	struct dp_srng wbm_desc_rel_ring;
-	struct dp_srng tcl_cmd_ring;
-	struct dp_srng tcl_status_ring;
 	struct dp_srng reo_reinject_ring;
 	struct dp_srng rx_rel_ring;
 	struct dp_srng reo_except_ring;
-- 
2.17.1

