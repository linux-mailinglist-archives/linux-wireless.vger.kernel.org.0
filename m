Return-Path: <linux-wireless+bounces-623-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102E180C13F
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 07:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED6A1C20941
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 06:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A4C200D8;
	Mon, 11 Dec 2023 06:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UbWBhmQm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76FEF1
	for <linux-wireless@vger.kernel.org>; Sun, 10 Dec 2023 22:22:36 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BB5QmSM022730;
	Mon, 11 Dec 2023 06:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=2/84iWAiZrQSwfScrDoWqtOsudGJJ7rIlaNhSNkbzAQ=; b=Ub
	WBhmQmHlF1mX1Db2nFx6V97RB37ytM4iAOWoDJ2kuxhXx/aJ2lj3yYVqN03SL+8l
	lHhmyris9MaGSiyURwGy+wSlg3jZ/4Of89bDZNXvE/nyILfo/mkqgJE+dx5oxKvt
	LyhaHKXGbgrSLc15MHzQe9GWC0LiHpD7doNZ3ZkKhdqnB3Ga1g6A90xVrDIBwGS2
	Y+WJjkc3RTZ5GXZevR7KuNFceA8Sg4rAdRj/840BrSbdkx0CaUCyQK3TKY66qZFI
	GiJ+4J/dkoW035CqQWFSsElS+NgKi14lNu4CBbePcoanR2qqjWdqaC3wbxeNrVCw
	u9mlteCSgNTycYIWKKbg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uvnyvacaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 06:22:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BB6MVFc029303
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 06:22:31 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 10 Dec 2023 22:22:30 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v9 04/12] wifi: ath11k: update regulatory rules when interface added
Date: Mon, 11 Dec 2023 14:22:08 +0800
Message-ID: <20231211062216.382164-5-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211062216.382164-1-quic_bqiang@quicinc.com>
References: <20231211062216.382164-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: x2mjeFwvkqx4PCnkk0coeQhIeh2yOFpU
X-Proofpoint-ORIG-GUID: x2mjeFwvkqx4PCnkk0coeQhIeh2yOFpU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312110051

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
index 7f7b39817773..1e314fcab41b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6943,6 +6943,14 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
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
index 1d033507a24c..cd879eae6c92 100644
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


