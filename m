Return-Path: <linux-wireless+bounces-21704-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C534AA9303E
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 04:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6E487A4DFE
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 02:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A2226A0DB;
	Fri, 18 Apr 2025 02:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WD8efQFv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC27B26A0B7;
	Fri, 18 Apr 2025 02:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744944982; cv=none; b=sW+RUGmdxShh9SvQitVBXOdkFkVeVxO0H9yq1BFwH4UXdUN69fJIU5PPC1v9d8WyBSGYUzOxuFIQzgpONUkT3CqgYp12mgax4O9l2VElfc1V2SOII7vbUkBNdX7uWWJDa+n28d5cq9JUEH1idBJixXRKPLG+FKh3UsoCkIQ1Mq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744944982; c=relaxed/simple;
	bh=Je/djjMrnBnjdYlyMsrGN8BU+WieWPyrowD5xE1PUvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=sn0Jas1Eqn58ovHx1lk0xy95UQBs8268wO6xmuf7ekrmgAkmno/PqipAzTIL7uNnQ2ffEpx2NaYc/DZOLlleYb3p6uqZXuNLYY10k4w5eaR5DaQ6AShEP3PbSrmnqgfdncKioPobTtuBKo2ylgcFes/COHQedeVV6RQWbIkZvuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WD8efQFv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I2ffrZ004998;
	Fri, 18 Apr 2025 02:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q1/W0syeFBKn0LWQPbz534W0Dka6BfiMduug+/a9GdM=; b=WD8efQFv6UPLtB9Y
	VtyEQefN31lKvGncQ+3pQECvzKnkA2pOYkwr7qca+9xA7LaVtV6s486V0Q1GEYsE
	mx1p+XCr5yGIUGi9WTr8UCeTXq566jrh8wt7j33e8gEbQ6eFBP7WQC9EX9RhebOu
	lJFDh29Qr+q6dClZfOgplIERewGD/bknF0Zr5I2cQkH9wLIhucNMGSnROGezx16w
	n/XrFC7MTO/UWsLuoTe+YfXYrA3KMpL9t1wNdWz3gNlr5LJ+hA10dZ/AzN+Q6rL1
	a01nGqL0Mit89/t/VzoRcHygEVYYuLYlrXDJrlk9upximxe8Z4Xu/FuzKkSK5Q31
	Br4j6w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf6a0tpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 02:56:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53I2uAwr023597
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 02:56:10 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Apr
 2025 19:56:08 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Fri, 18 Apr 2025 10:55:41 +0800
Subject: [PATCH ath-next 08/15] wifi: ath12k: update regulatory rules when
 interface added
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250418-ath12k-6g-lp-vlp-v1-8-c869c86cad60@quicinc.com>
References: <20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com>
In-Reply-To: <20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _P-B6jioBXv0OGXLyOWvN9bErkoLRS2J
X-Authority-Analysis: v=2.4 cv=JNc7s9Kb c=1 sm=1 tr=0 ts=6801bf4b cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=Jf6LXKQdqRjbpVO3btAA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: _P-B6jioBXv0OGXLyOWvN9bErkoLRS2J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180020

There are two power types for 6 GHz regulatory, one is AP, another is
client. The client power type is used for station interface, and AP
power type is used for AP/mesh point interface.

When firmware boots up, WMI_REG_CHAN_LIST_CC_EXT_EVENTID is sent from
firmware at an early stage, the interface mode is not decided at this
point, then ath12k select reg rules of AP type as default.

After interface created, ath12k needs to update reg rules to the exact
power type matching the interface type.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 15 +++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.c |  6 ++++++
 drivers/net/wireless/ath/ath12k/wmi.h |  1 +
 3 files changed, 22 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 165a9bb4378dabdf49e1b3c4c92917eca6386f15..90734136528b55983bdcd56c447c818b889e9404 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8743,7 +8743,10 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_reg_info *reg_info;
 	struct ath12k_link_vif *arvif;
+	struct ath12k_base *ab;
+	struct ath12k *ar;
 	int i;
 
 	lockdep_assert_wiphy(hw->wiphy);
@@ -8765,6 +8768,18 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 
 	ath12k_mac_determine_vdev_type(vif, ahvif);
 
+	for_each_ar(ah, ar, i) {
+		if (!ath12k_wmi_supports_6ghz_cc_ext(ar))
+			continue;
+
+		ab = ar->ab;
+		reg_info = ab->reg_info[ar->pdev_idx];
+		ath12k_dbg(ab, ATH12K_DBG_MAC, "interface added to change reg rules\n");
+		ath12k_reg_handle_chan_list(ab, reg_info, ahvif->vdev_type,
+					    IEEE80211_REG_UNSET_AP);
+		break;
+	}
+
 	/* Defer vdev creation until assign_chanctx or hw_scan is initiated as driver
 	 * will not know if this interface is an ML vif at this point.
 	 */
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 80b8cad5bc78ca0cf27383e594ea6f48887a1910..385f59077050ce89aa9aab19b0ffc9af98e35549 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -9819,3 +9819,9 @@ int ath12k_wmi_mlo_teardown(struct ath12k *ar)
 
 	return 0;
 }
+
+bool ath12k_wmi_supports_6ghz_cc_ext(struct ath12k *ar)
+{
+	return test_bit(WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT,
+			ar->ab->wmi_ab.svc_map) && ar->supports_6ghz;
+}
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 3eb57cc8509de3de8ebf6fc7a3d2f68dd7a6f369..5f0f9f120497c5746ae9175c3fa9e119a61ab91c 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -6132,5 +6132,6 @@ int ath12k_wmi_mlo_teardown(struct ath12k *ar);
 void ath12k_wmi_fw_stats_dump(struct ath12k *ar,
 			      struct ath12k_fw_stats *fw_stats, u32 stats_id,
 			      char *buf);
+bool ath12k_wmi_supports_6ghz_cc_ext(struct ath12k *ar);
 
 #endif

-- 
2.34.1


