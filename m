Return-Path: <linux-wireless+bounces-360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6084802CDC
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 09:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137761C209C2
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 08:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94BAF9DE;
	Mon,  4 Dec 2023 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QMeHU0ih"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733D7FE
	for <linux-wireless@vger.kernel.org>; Mon,  4 Dec 2023 00:13:47 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B45cNwX012861;
	Mon, 4 Dec 2023 08:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ATDEmY2B3+GjprCrJApdgZv0pUFr4aj/Ln73DEyH+Zw=;
 b=QMeHU0ihc0ELtDNAlxg/PI0sLFswmetzp4+etPOU+BzXkHt1KI279gN44hn/EOVaCdhv
 tWZdec2anh8VMqF6Ur8QVnMQr8sVzC+TqPPBqvxrI00lIxQeNMRg9rwZWcKyZnWeKYvf
 a0Dp+i9LHfGl/cukg+nicaf0jQ8sbdjSLtuYT+PVbS110+1/rkmVxQKhAoyqRXU7ESDT
 Yra+hbUPG0hxiEv05LwbyuSMqCKLxPXG6WCJ1VxODG/E9wROozREfUn1LJ22Fg+ejIR/
 CyPL/pxZOWW3R2rdlmXxPXKMVgX3VbN98PbsmLuYXQ9C3BEIKGAIzjY3I4OsGYqKjpq6 LA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uqvp13cep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 08:13:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B48DgFC002091
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Dec 2023 08:13:42 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Dec 2023 00:13:41 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v8 05/12] wifi: ath11k: update regulatory rules when connect to AP on 6 GHz band for station
Date: Mon, 4 Dec 2023 16:13:16 +0800
Message-ID: <20231204081323.5582-6-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204081323.5582-1-quic_bqiang@quicinc.com>
References: <20231204081323.5582-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: M9DCVURfF_z4ELkZlqtcxM7xnnWWa6Rm
X-Proofpoint-ORIG-GUID: M9DCVURfF_z4ELkZlqtcxM7xnnWWa6Rm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_06,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040061

From: Wen Gong <quic_wgong@quicinc.com>

When station connect to AP on 6 GHz band, it needs switch the regulatory
rules according to the regulatory info sub field in HE operation element.
Switch to the power type which AP used for station interface.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
v8:
 no change.
v7:
 1. return -EINVAL for IEEE80211_REG_UNSET_AP.

 drivers/net/wireless/ath/ath11k/mac.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 1e314fcab41b..b6ca6fb801f8 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7613,6 +7613,8 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	int ret;
 	struct peer_create_params param;
+	struct cur_regulatory_info *reg_info;
+	enum ieee80211_ap_reg_power power_type;
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -7620,6 +7622,20 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		   "chanctx assign ptr %p vdev_id %i\n",
 		   ctx, arvif->vdev_id);
 
+	if (ath11k_wmi_supports_6ghz_cc_ext(ar) &&
+	    ctx->def.chan->band == NL80211_BAND_6GHZ &&
+	    arvif->vdev_type == WMI_VDEV_TYPE_STA) {
+		reg_info = &ab->reg_info_store[ar->pdev_idx];
+		power_type = vif->bss_conf.power_type;
+		ath11k_dbg(ab, ATH11K_DBG_MAC, "mac chanctx power type %d\n",
+			   power_type);
+		if (power_type == IEEE80211_REG_UNSET_AP) {
+			ret = -EINVAL;
+			goto out;
+		}
+		ath11k_reg_handle_chan_list(ab, reg_info, power_type);
+	}
+
 	/* for QCA6390 bss peer must be created before vdev_start */
 	if (ab->hw_params.vdev_start_delay &&
 	    arvif->vdev_type != WMI_VDEV_TYPE_AP &&
-- 
2.25.1


