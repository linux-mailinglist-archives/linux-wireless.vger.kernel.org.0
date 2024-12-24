Return-Path: <linux-wireless+bounces-16772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9204A9FBF3F
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 15:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87D11885220
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 14:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BB31B87FF;
	Tue, 24 Dec 2024 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k4bDLbgl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7E41D7E35
	for <linux-wireless@vger.kernel.org>; Tue, 24 Dec 2024 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735050999; cv=none; b=igf6SbTk9DKSDvQdlcrBJjZY013ObNmEt8zDFkoYr4QvHYjo+bAbueStXU/H/FyEpiEsFxiDi8KBuUW6EHHkyvp5H+Gr7SX5u3UGJMRkMSswoWNpGuIkGPR4Mw6892NPjaJ2E9ZN0Uuwmh/lNxAstJcnsdId1srN6AWxqYOdbyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735050999; c=relaxed/simple;
	bh=IhAjZPpG7VLcYW4JiVCxcKavpCiqsm5JyUvpx9ucxx0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwBr9W/3WsadYHRGbWSGKPJ6G35/WXkxl3IkxxvihEyvSOWi+mtGxkAKvvz5OOR4CoE2iOL/q1/Mg0mwDSjl3MK1xoMzkYomL1D/D2eP/yTAB2n3rChiY95VrPsFOqTMyXBtQX47p0y/oDwyG32ix2UW5O1HV9La7MuVUBy4rCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k4bDLbgl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOD3hcb021075;
	Tue, 24 Dec 2024 14:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y0VkCqJ101JZZLJ0WEanHWOAZOCqIBi5TYxy1tkpZ1s=; b=k4bDLbglY7p11qJ4
	WsTGoQzF+vqh0PwrpgUAGP6FvqHY7sYqgAf5ZoltSv9+ZWcj6orSge3kFq2nyvge
	53zjUYYVQv3qjuBFs129ZowfbmB/I0MGdswPaBqP22yx09TRgVV+2mso1fD95vgr
	X354xzgyEDvWFeuXnFylzKY/iXlWGZM07wA7BOW8xDFtAhHXR2lalLtFd1yakpbn
	TTeWSH6JZ6AxZlgUTRoxiWtnk9YzY2rZh3n3/EaoTkb4d67GemqribXm5JCfmNTs
	cpaXMWv0rjkPSIeuiHBJW4V+r7XVkMYMvLeRonMdTGyVDPJGqWkmeuEckvwjDMef
	S2f0mQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43qwgt8emc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 14:36:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BOEaYrI015211
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 14:36:34 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 24 Dec 2024 06:36:32 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v3 3/3] wifi: ath12k: Refactor Rx status TLV parsing procedure argument
Date: Tue, 24 Dec 2024 20:06:13 +0530
Message-ID: <20241224143613.164921-4-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241224143613.164921-1-quic_periyasa@quicinc.com>
References: <20241224143613.164921-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: G0vZTBG1eDEYbcdUZMIbs2S5c8Hvq2cU
X-Proofpoint-ORIG-GUID: G0vZTBG1eDEYbcdUZMIbs2S5c8Hvq2cU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412240126

Currently, ath12k_dp_mon_rx_parse_status_tlv() takes the TLV tag, TLV data
and TLV userid as separate arguments from the caller. In the future, the
TLV length will be needed for parsing the EHT TLV tag. Therefore, instead
of increasing the number of arguments, pass the TLV header and retrieve the
necessary fields from the TLV header itself.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index ae2f6847bc88..53f8e8f8959a 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -565,12 +565,16 @@ static void ath12k_dp_mon_parse_he_sig_su(const struct hal_rx_he_sig_a_su_info *
 static enum hal_rx_mon_status
 ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
 				  struct ath12k_mon_data *pmon,
-				  u32 tlv_tag, const void *tlv_data,
-				  u32 userid)
+				  const struct hal_tlv_64_hdr *tlv)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
-	u32 info[7];
+	const void *tlv_data = tlv->value;
+	u32 info[7], userid;
+	u16 tlv_tag;
+
+	tlv_tag = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_TAG);
+	userid = le64_get_bits(tlv->tl, HAL_TLV_64_USR_ID);
 
 	switch (tlv_tag) {
 	case HAL_RX_PPDU_START: {
@@ -1187,7 +1191,6 @@ ath12k_dp_mon_parse_rx_dest(struct ath12k *ar, struct ath12k_mon_data *pmon,
 	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
 	struct hal_tlv_64_hdr *tlv;
 	enum hal_rx_mon_status hal_status;
-	u32 tlv_userid;
 	u16 tlv_tag, tlv_len;
 	u8 *ptr = skb->data;
 
@@ -1196,9 +1199,6 @@ ath12k_dp_mon_parse_rx_dest(struct ath12k *ar, struct ath12k_mon_data *pmon,
 	do {
 		tlv = (struct hal_tlv_64_hdr *)ptr;
 		tlv_tag = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_TAG);
-		tlv_len = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_LEN);
-		tlv_userid = le64_get_bits(tlv->tl, HAL_TLV_64_USR_ID);
-		ptr += sizeof(*tlv);
 
 		/* The actual length of PPDU_END is the combined length of many PHY
 		 * TLVs that follow. Skip the TLV header and
@@ -1208,10 +1208,11 @@ ath12k_dp_mon_parse_rx_dest(struct ath12k *ar, struct ath12k_mon_data *pmon,
 
 		if (tlv_tag == HAL_RX_PPDU_END)
 			tlv_len = sizeof(struct hal_rx_rxpcu_classification_overview);
+		else
+			tlv_len = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_LEN);
 
-		hal_status = ath12k_dp_mon_rx_parse_status_tlv(ar, pmon,
-							       tlv_tag, ptr, tlv_userid);
-		ptr += tlv_len;
+		hal_status = ath12k_dp_mon_rx_parse_status_tlv(ar, pmon, tlv);
+		ptr += sizeof(*tlv) + tlv_len;
 		ptr = PTR_ALIGN(ptr, HAL_TLV_64_ALIGN);
 
 		if ((ptr - skb->data) >= DP_RX_BUFFER_SIZE)
-- 
2.34.1


