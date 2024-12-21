Return-Path: <linux-wireless+bounces-16688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0889F9E7E
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 06:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A152716B9FA
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 05:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1481DF248;
	Sat, 21 Dec 2024 05:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kjtrApL0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894571EC4D3
	for <linux-wireless@vger.kernel.org>; Sat, 21 Dec 2024 05:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734758591; cv=none; b=LZLSu5z1BkavunMmvdiu7dKzHlXFFgkPjLYG8un2SXmLl3FpDpDleWem7hMkqPOlQv5yr/Dbtjs6JIXMeXGJV2AaXtj1KBJ/AvBicj9p5z6qTVyYJfuQfSUzDYWlU++7eYt5qCKWHsw56iDvhyIDfn9TcTediKBvi0hLj1JKrgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734758591; c=relaxed/simple;
	bh=EarMm7vctOAnJ1BJao/GPgrgBxqM8pikg1DEZ5q2/c0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZM4ysKtXw7v1cCBxw+Jis/U0KMR8BhYeTpLprF3a43+tcmqlc+hdChg4Nwufkx7gjURRpQb0+8Kj4Adj0ixUcZSLbAHqME3oy/uLNeoiKlSWYpY/W4PSorekjqyxcq5KzuyqmwvFiMzglB+SKCuXr/lM2ifcIn1sIsvCIURRY4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kjtrApL0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BL4BtFa009161;
	Sat, 21 Dec 2024 05:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VSy+Mo3EiRxHkOHxUAgQ6taqcbWW+0i0CvTJtfRtYg8=; b=kjtrApL0WfQxr/ub
	wVZlkKgjWRpOCFDnfs4zZ2MlKz+onKEjcx6WJgDDRPmTOG6PamqMk2hHDXWjZYEH
	GOgBUs5eEvkU3KtMGVJcDypXPundjYCEFJ0sT7Dte/dF7rQjeqR2FZSxZKyk6rGF
	uGV/HkuthJtu4WqtfOp7VJiViLBTAuaMYP+QzKFx/lLXTt2T9Y4LtlLHUsbRkFd6
	q+1TgnO8kaUNzFr8OaYOBFHvNxUlCEohg95+XK+p1ukNOCQlVJ/82RPwQh5G6N5r
	upCHAFHxcf2pfpA54Yf9uH1w++zA+RYeErKouGd4Dq6kCR4U3LkZEcLMkFLpJe00
	2REguA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43npeh86g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Dec 2024 05:23:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BL5N7MW017043
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Dec 2024 05:23:07 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 20 Dec 2024 21:23:05 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH 06/10] wifi: ath12k: fix the ampdu id fetch in the HAL_RX_MPDU_START TLV
Date: Sat, 21 Dec 2024 10:49:15 +0530
Message-ID: <20241221051919.686500-7-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241221051919.686500-1-quic_periyasa@quicinc.com>
References: <20241221051919.686500-1-quic_periyasa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MqDc753q0-wh-YIa-aZgyiuEe7Nx8jv4
X-Proofpoint-ORIG-GUID: MqDc753q0-wh-YIa-aZgyiuEe7Nx8jv4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 priorityscore=1501 mlxlogscore=914 mlxscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412210043

From: P Praneesh <quic_ppranees@quicinc.com>

Currently, ampdu id is update with peer id mask which is incorrect.
Therefore, update the ampdu id with PPDU id mask value. Also move
the ampdu_id field inside the user stats since it is a user id based
statistics.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 12 +++++++-----
 drivers/net/wireless/ath/ath12k/hal_rx.h |  3 ++-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index b98f7a941fa1..68dda1b58cb7 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1538,6 +1538,9 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
 		ppdu_info->peer_id =
 			u32_get_bits(info[0], HAL_RX_PPDU_END_USER_STATS_INFO0_PEER_ID);
 
+		if (ppdu_info->num_mpdu_fcs_ok > 1 || ppdu_info->num_mpdu_fcs_err > 1)
+			ppdu_info->userstats[userid].ampdu_present = true;
+
 		switch (ppdu_info->preamble_type) {
 		case HAL_RX_PREAMBLE_11N:
 			ppdu_info->ht_flags = 1;
@@ -1669,8 +1672,8 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
 		if (userid < HAL_MAX_UL_MU_USERS) {
 			info[0] = __le32_to_cpu(mpdu_start->info0);
 			ppdu_info->userid = userid;
-			ppdu_info->ampdu_id[userid] =
-				u32_get_bits(info[0], HAL_RX_MPDU_START_INFO1_PEERID);
+			ppdu_info->userstats[userid].ampdu_id =
+				u32_get_bits(info[0], HAL_RX_MPDU_START_INFO0_PPDU_ID);
 		}
 
 		break;
@@ -1888,15 +1891,14 @@ static void ath12k_dp_mon_update_radiotap(struct ath12k *ar,
 {
 	struct ieee80211_supported_band *sband;
 	u8 *ptr = NULL;
-	u16 ampdu_id = ppduinfo->ampdu_id[ppduinfo->userid];
 
 	rxs->flag |= RX_FLAG_MACTIME_START;
 	rxs->signal = ppduinfo->rssi_comb + ATH12K_DEFAULT_NOISE_FLOOR;
 	rxs->nss = ppduinfo->nss + 1;
 
-	if (ampdu_id) {
+	if (ppduinfo->userstats[ppduinfo->userid].ampdu_present) {
 		rxs->flag |= RX_FLAG_AMPDU_DETAILS;
-		rxs->ampdu_reference = ampdu_id;
+		rxs->ampdu_reference = ppduinfo->userstats[ppduinfo->userid].ampdu_id;
 	}
 
 	if (ppduinfo->is_eht || ppduinfo->eht_usig) {
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index 5099399a047c..764730c447de 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -148,6 +148,8 @@ struct hal_rx_user_status {
 	u32 mpdu_fcs_ok_bitmap[HAL_RX_NUM_WORDS_PER_PPDU_BITMAP];
 	u32 mpdu_ok_byte_count;
 	u32 mpdu_err_byte_count;
+	bool ampdu_present;
+	u16 ampdu_id;
 };
 
 #define HAL_MAX_UL_MU_USERS	37
@@ -263,7 +265,6 @@ struct hal_rx_mon_ppdu_info {
 	u8 addr4[ETH_ALEN];
 	struct hal_rx_user_status userstats[HAL_MAX_UL_MU_USERS];
 	u8 userid;
-	u16 ampdu_id[HAL_MAX_UL_MU_USERS];
 	bool first_msdu_in_mpdu;
 	bool is_ampdu;
 	u8 medium_prot_type;
-- 
2.34.1


