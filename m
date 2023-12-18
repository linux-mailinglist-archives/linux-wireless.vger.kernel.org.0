Return-Path: <linux-wireless+bounces-896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F098168F5
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 09:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6666E282FB5
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 08:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD13111AA;
	Mon, 18 Dec 2023 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="diT+F7bC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E54F10A3E
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI8DBJL025631;
	Mon, 18 Dec 2023 08:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=TYllJSu4I6SULKjXare8uYcCpLdtBQhUFU8TNp/qJ4o=; b=di
	T+F7bCooZqBcaUY/Srm+hM2be5t61lB2HshCf0CUCYlcpuMSS+mPZziaLirZrNfg
	2h8y7C6NHDGaA+DXCc9BbSua1lyC6kRO5cey/D8lJvhGl16KICQd3wIrHBi9Tcm2
	tkWznyzcTpniIMsIC+h/lJRI4yOLz+3ANDT169/RVOJj+VrcY+c9WwVNg3uDyNUo
	WHTpTkYjEvfBHri7K1xdv0vGX5Kl7M2/zNCjgGvoPZrTcO4/YmFyWOdmnJXD48mo
	HDsmIlbE2RN2Rd8p3yoS2U7vCBpwRzMo79RHgUtqFVyVtkLDRnn35uMefHUPJOqq
	ouA/LzeXWmkpwXpu3U4Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v14vjbu87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 08:59:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BI8x1TZ012335
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 08:59:01 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 18 Dec 2023 00:58:59 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v10 04/12] wifi: ath11k: update regulatory rules when interface added
Date: Mon, 18 Dec 2023 16:58:36 +0800
Message-ID: <20231218085844.2658-5-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218085844.2658-1-quic_bqiang@quicinc.com>
References: <20231218085844.2658-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EQCfj9SDYL2DDe5bmahsYYFFluHiyX0L
X-Proofpoint-GUID: EQCfj9SDYL2DDe5bmahsYYFFluHiyX0L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180064

From: Wen Gong <quic_wgong@quicinc.com>

There are two power types for 6 GHz regulatory, one is AP, another
is client.

When wlan boot up, WMI_REG_CHAN_LIST_CC_EXT_EVENTID is sent from
firmware at an early stage, the interface mode is not decided at
this point, then ath11k select reg rules of AP type as default.

After interface is created, it is exactly decided the interface
type such as AP/mesh point/station. Then ath11k need to update
reg rules to the exact power type matched to the interface type.

The client power type is used for station interface, and AP power
type is used for AP/mesh point interface.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
v10:
 no change.
v9:
 1. remove unnecessary parenthesis.
 2. remove irrelevant change w.r.t commit message.
v8:
 no change.
v7:
 1. move ath11k_mac_supports_6ghz_cc_ext() to
    wmi.c and renamed as ath11k_wmi_supports_6ghz_cc_ext().

 drivers/net/wireless/ath/ath11k/mac.c | 8 ++++++++
 drivers/net/wireless/ath/ath11k/wmi.c | 6 ++++++
 drivers/net/wireless/ath/ath11k/wmi.h | 1 +
 3 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index db241589424d..c7e7fef7946f 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6949,6 +6949,14 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 				    ret);
 	}
 
+	if (ath11k_wmi_supports_6ghz_cc_ext(ar)) {
+		struct cur_regulatory_info *reg_info;
+
+		reg_info = &ab->reg_info_store[ar->pdev_idx];
+		ath11k_dbg(ab, ATH11K_DBG_MAC, "mac interface added to change reg rules\n");
+		ath11k_reg_handle_chan_list(ab, reg_info, IEEE80211_REG_LPI_AP);
+	}
+
 	mutex_unlock(&ar->conf_mutex);
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 9f8a62c334b0..717b6c8897ad 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -9861,3 +9861,9 @@ int ath11k_wmi_sta_keepalive(struct ath11k *ar,
 
 	return ath11k_wmi_cmd_send(wmi, skb, WMI_STA_KEEPALIVE_CMDID);
 }
+
+bool ath11k_wmi_supports_6ghz_cc_ext(struct ath11k *ar)
+{
+	return test_bit(WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT,
+			ar->ab->wmi_ab.svc_map) && ar->supports_6ghz;
+}
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index d46c70704774..fa85e6eb4ab4 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -6485,4 +6485,5 @@ void ath11k_reg_reset_info(struct cur_regulatory_info *reg_info);
 int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
 				struct cur_regulatory_info *reg_info,
 				enum ieee80211_ap_reg_power power_type);
+bool ath11k_wmi_supports_6ghz_cc_ext(struct ath11k *ar);
 #endif
-- 
2.25.1


