Return-Path: <linux-wireless+bounces-21619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EB6A9126C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 06:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFDB1444736
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 04:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18921DE4F6;
	Thu, 17 Apr 2025 04:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lF3Ra/Nf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632381DE3AF
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 04:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744865858; cv=none; b=QmTZ7Ui6VJiecqpyIkHP6U99xGuwwGtpBGK9COpMA/giqOsNMhMO/71rSo6PB6LejfYtz8USUxO/Gi5WIsAcIjK/JcRsz4j6bhgc1qKAVsTQ8TDxlQFlF59AZs9Kuqyv9WELl3MYpcic1HBZumjCHYD+bULj1TeThYBr+EhBzW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744865858; c=relaxed/simple;
	bh=k/oOP5/Bgpmq2FjlOGGmj7gUDStMDxkH9gUSimOcsCc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDgRU82/RGP3xzo0kjLu8lzYBzMRzBrYhIJ/TksW8+vWqAMOS82fIiZdH8jjbpnnMCCmsohVYYq94HomfhwkzN4ZCGQRS0QpTI9HLaCaV56xPFe+aYxb9n/mTTOLZ2oYgJcbScB3dCsCCgPHQPJREB7FUTP3PnMAldpt5NEwb58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lF3Ra/Nf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GMK2b3022364;
	Thu, 17 Apr 2025 04:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZCj09mrhYiWP/ICVXwbfcaxFOd2mlq2OOC0j5V0N5C8=; b=lF3Ra/NfVR1u+545
	eNd6+b6V2AG0KP3sA2a6RYexA5cVyCSJd7EM9nDVfcVRbzWbp8zC6mT1nEqaVm8A
	/xyuompV5b65UHqnmqrktpWQeNmzQXzWhnBtISgydyDgcYHbZAsgaTwCNvgRBgKh
	zQnwTM7Z+3HxjRsGhFXpwpbUufmAxFstf7gtoL+eGCyyFnlnadOZjQVu7hdg2fTP
	Q8YbbW0NgTsPAPDcMUJiHWz6fOMIASgO1pHY75IbLFF4jozJgncnwHTK1O/T7rX1
	HcH8EYPKdydlCW1h7/vReleoD95SnI+lL+fmlscyPIz00SNyzueid+uZLVyD6v1B
	QbbvlA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygj9dn6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 04:57:33 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53H4vXEd008893
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 04:57:33 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 16 Apr 2025 21:57:31 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH ath-next v5 2/6] wifi: ath12k: correctly fetch arsta for MLO
Date: Thu, 17 Apr 2025 10:27:05 +0530
Message-ID: <20250417045709.770219-3-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417045709.770219-1-quic_sarishar@quicinc.com>
References: <20250417045709.770219-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2S4osqTd_W0lK1n4r5WEFKb1TWhhZEYq
X-Authority-Analysis: v=2.4 cv=PruTbxM3 c=1 sm=1 tr=0 ts=68008a3d cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=W7lknK8chBWqx2lQqA8A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 2S4osqTd_W0lK1n4r5WEFKb1TWhhZEYq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 mlxlogscore=649
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170036

Currently in ath12k_mac_op_sta_statistics(), link sinfo structure
is filled from arsta structure and arsta is fetched from ahsta->deflink.
For both non-ML and multi-link operation (MLO), deflink is used. While
this is correct for non-ML, but the corresponding link_id should be
used for MLO.

Therefore, add support for MLO by taking the link_id from the
link_sinfo structure, fetching arsta from ahsta->link[link_id], and
filling the link_sinfo structure if valid_links.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 10d4a2166915..30643f8db487 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10503,13 +10503,21 @@ static void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
 	struct ath12k_fw_stats_req_params params = {};
 	struct ath12k_link_sta *arsta;
+	int link_id = sinfo->link_id;
 	struct ath12k *ar;
 	s8 signal;
 	bool db2dbm;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	arsta = &ahsta->deflink;
+	if (link_id < 0)
+		arsta = &ahsta->deflink;
+	else
+		arsta = wiphy_dereference(hw->wiphy, ahsta->link[link_id]);
+
+	if (!arsta)
+		return;
+
 	ar = ath12k_get_ar_by_vif(hw, vif, arsta->link_id);
 	if (!ar)
 		return;
-- 
2.34.1


