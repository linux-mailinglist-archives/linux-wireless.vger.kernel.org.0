Return-Path: <linux-wireless+bounces-17891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFC4A1B04D
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 07:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502E21884AC4
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 06:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32931DA2F1;
	Fri, 24 Jan 2025 06:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eGOR4Rbz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1641D9A6F;
	Fri, 24 Jan 2025 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737699421; cv=none; b=FG4swCYXizOQXcb0eehLBpQydfL6ZM383UGpbG2M1Qxyl+nJSCxS9k5Jq7y6U4vupQfEVLK+MPu+xEtq9zorHVc+x+ezMHLkAeZxwUrP+tFQTJW3GThO/b6v0ItQl95w13yDoSKbQ+ut3WFuTYOSfqWokH4Y//qprpxZHlnE1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737699421; c=relaxed/simple;
	bh=/K2i7q9Cl4UUDIaZNWVxoi0E6zF7OmLuu5GWpfuwVMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Di+hyigc5tivQM/B6mS9DYAMVDK3bcigEYa+xHYYX5ZrCmYM+qinAiIRAFv6X/JxeMrIIK5mQkPX1j3+DFII6bDOdbgsqUhlrn6DSKjxKRbcfPYEKMv4GH7FRYqHIR4mZaRf6skLjPCttGyjlKEcZLK5UVA7y2aXDQQ2FAM3ThU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eGOR4Rbz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O4XKR0009269;
	Fri, 24 Jan 2025 06:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f+nbDCXNIETLhiWSpLZKQfbVPhDQD1DzRLQ9qrZ2IYE=; b=eGOR4RbzyfSHkUj1
	YTZ4xyVrG5UYvYQ0NNTVvY3DDZRtmTGmHCngPp8xJeuH7ywI6b2vv1h4kRyB9PaX
	VQjYzzPo7hI3QOJACm08PU00M/Vj0/3RtgVAgeps+C9Zbc+RrX/4RcIwffsLtHmk
	OI5m/rLI3Wb3J2iVkYpp7ZQ/ysiOIL8HbGW2eOcPxeoffgIeOmkg6w95V7cGxujz
	Fojiix5/WKVobQrVXG2o1oYwuG89imC/2buIr/0pldpHC4HMGWBUmFeZ9irc3MaT
	S/IJwilh7wvLfaZewwFgyuo/rhj+3AcedkglAN67L3TlTFKS5zNgl2s3zhEYCXN7
	gefsgg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c3xa864s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 06:16:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50O6GrqP005398
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 06:16:53 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 23 Jan 2025 22:16:51 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Fri, 24 Jan 2025 11:46:35 +0530
Subject: [PATCH v2 1/4] wifi: ath12k: update beacon template function to
 use arvif structure
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250124-ath12k_mlo_csa-v2-1-420c42fcfecf@quicinc.com>
References: <20250124-ath12k_mlo_csa-v2-0-420c42fcfecf@quicinc.com>
In-Reply-To: <20250124-ath12k_mlo_csa-v2-0-420c42fcfecf@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: k3jgpHJ9Xn4C1l5VgOa0IW84mqci1jFL
X-Proofpoint-ORIG-GUID: k3jgpHJ9Xn4C1l5VgOa0IW84mqci1jFL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_02,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501240043

The current code has ath12k_wmi_bcn_tmpl() accepting separate ar and
vdev_id parameters. However, ath12k_link_vif structure can be used to
derive both of these.

Hence, simplify the function signature.

Later change needs arvif pointer access within the function hence it is
better if arvif is directly passed now.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 5 ++---
 drivers/net/wireless/ath/ath12k/wmi.c | 4 +++-
 drivers/net/wireless/ath/ath12k/wmi.h | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 329c050037219567239610d94fd60358be959b2c..417d53dd9c79d15b69642793c6846005a9da4cf3 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1595,8 +1595,7 @@ static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif)
 
 		ema_args.bcn_cnt = beacons->cnt;
 		ema_args.bcn_index = i;
-		ret = ath12k_wmi_bcn_tmpl(tx_arvif->ar, tx_arvif->vdev_id,
-					  &beacons->bcn[i].offs,
+		ret = ath12k_wmi_bcn_tmpl(tx_arvif, &beacons->bcn[i].offs,
 					  beacons->bcn[i].skb, &ema_args);
 		if (ret) {
 			ath12k_warn(tx_arvif->ar->ab,
@@ -1690,7 +1689,7 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_link_vif *arvif)
 		}
 	}
 
-	ret = ath12k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn, NULL);
+	ret = ath12k_wmi_bcn_tmpl(arvif, &offs, bcn, NULL);
 
 	if (ret)
 		ath12k_warn(ab, "failed to submit beacon template command: %d\n",
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index a7625a3d1a3a9b1bbcf90cee30d3c707de03c439..c129dce5832aa76e0c084548c5019dfd63386186 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1889,14 +1889,16 @@ int ath12k_wmi_p2p_go_bcn_ie(struct ath12k *ar, u32 vdev_id,
 	return ret;
 }
 
-int ath12k_wmi_bcn_tmpl(struct ath12k *ar, u32 vdev_id,
+int ath12k_wmi_bcn_tmpl(struct ath12k_link_vif *arvif,
 			struct ieee80211_mutable_offsets *offs,
 			struct sk_buff *bcn,
 			struct ath12k_wmi_bcn_tmpl_ema_arg *ema_args)
 {
+	struct ath12k *ar = arvif->ar;
 	struct ath12k_wmi_pdev *wmi = ar->wmi;
 	struct wmi_bcn_tmpl_cmd *cmd;
 	struct ath12k_wmi_bcn_prb_info_params *bcn_prb_info;
+	u32 vdev_id = arvif->vdev_id;
 	struct wmi_tlv *tlv;
 	struct sk_buff *skb;
 	u32 ema_params = 0;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 38aed18b99f4239e40d369181549b4bc78faa862..64c8357740167f44f13585eb87b938ecedbf4546 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -5660,7 +5660,7 @@ int ath12k_wmi_mgmt_send(struct ath12k *ar, u32 vdev_id, u32 buf_id,
 			 struct sk_buff *frame);
 int ath12k_wmi_p2p_go_bcn_ie(struct ath12k *ar, u32 vdev_id,
 			     const u8 *p2p_ie);
-int ath12k_wmi_bcn_tmpl(struct ath12k *ar, u32 vdev_id,
+int ath12k_wmi_bcn_tmpl(struct ath12k_link_vif *arvif,
 			struct ieee80211_mutable_offsets *offs,
 			struct sk_buff *bcn,
 			struct ath12k_wmi_bcn_tmpl_ema_arg *ema_args);

-- 
2.34.1


