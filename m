Return-Path: <linux-wireless+bounces-27924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51944BCAE59
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 23:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4410C1A61B18
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 21:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0968C274B22;
	Thu,  9 Oct 2025 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pIl0SrnS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB1E280325
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 21:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760044639; cv=none; b=HRTXj0uBwHPhBEBg0hkSmZvcm7KY+toLCOslp5jNiQwua49+NukOMUL/H1ntm9ImCSLMArNS6oZT5hcM5C0y6TanDhCrzANP4Q8szOiBLBwhyO4DMvqlHp8aZGrI5QerVaN3rLq1dA5KnctIRDgj2p8b3Kl3BvaUCWP10heDzuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760044639; c=relaxed/simple;
	bh=vKol+cjD8KRawX26PuErUkJ369gdTl9pvY9lmgIyUtM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YUI8FlwrvpdzwcwMJbHGzIwTHgyYD5SFVqFhsDJJaagXJretEYK+OUGvu1UjqHPqVPaTyhm5Z2V8mu0PbVSK0+qqLP7klYBQOXSXGNo9fhhNaUs3cLVGpmPkR43dBu3FzHXimeH6a3l5EbtdQ9HndgmeQhAao7d8cZHDjd/iAzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pIl0SrnS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599Ecfn0012274;
	Thu, 9 Oct 2025 21:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yQyEmfeBw0vC/RSfBZBXIMhXrAf5wyYL8BHTwLNqMYE=; b=pIl0SrnSD5N5XGne
	U1NAdF3HTx4TWzCKQRCGxVbnu+jxo7UPqNi0Ex3nz3UbFVcXIBk03NDNFtofHrrV
	wLh/PAPjMZCh4XfGFquRkaw/064iGoMO9w30MhQpPiuk4iuNT45qNxrFvGCuhN89
	se70Y7F//kywo7Yvh27Nb3OdHCsPSdZdlNoXr9z3O3tgnfh/o0O5Sa9+FFGnxmlv
	DzW9BdwD0uy0uML6Omr9UDgJqsgiJ5nuMjd4c9UdCA/CeTP+MqkbW99rlO5N2sOt
	JZDm79LKFsE4qJoUKTKporje9ptmoZfWu8RbjUUiYvnuwvCqF7sCaLug3e+goRMe
	ywB8Tg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kmapy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 21:17:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 599LHA6x028815
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 21:17:10 GMT
Received: from ath12k-linux2.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 9 Oct 2025 14:17:10 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: [ath-next V17 2/2] wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
Date: Thu, 9 Oct 2025 14:16:56 -0700
Message-ID: <20251009211656.2386085-3-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009211656.2386085-1-quic_pradeepc@quicinc.com>
References: <20251009211656.2386085-1-quic_pradeepc@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=dojWylg4 c=1 sm=1 tr=0 ts=68e82657 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=-WEFs_rbKGq8kVQlx6kA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: EogD7f8ZgkD-YiRX5tN1-bZFAmd7BBDt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXxfBVTj35FRVl
 /R7Lbg1WDk2NOu0jLnswWzPULW1gY/WdNh/9LwZjS4maQOG17PmD3dmvaQ8Lm7FXwFBgsX2h+Mb
 XuncMlJtU6/pHulU9Vx5B7zKT68wf0Gx4YgCZSg25+UUY7cArGTSK4JrbxRYEMOHucaAUleWdLn
 DJVXp+ipSUzT+DinNYVnDxXTv88IXudbNEkZZQ9za+OxSt0x5t3lBrYb7YUJ0OTm1RTbbrIM6nn
 6VtwBWNQzBYv8YSv08x+aYyxeynsSYzRUZMwbh9q9VF8eYKMsUD6i9TsVFxTWJBRxlZibPWH3Y/
 8UfyU+JoSy6yUaT6lReaYuA50ffi4kIEDF3cCUiKzdNfBy1TSdGBgoPTDc7XoGRAAl5iyxN9sEz
 5Ql1AV0krOog/5JVRZgtIHs1wtZxBA==
X-Proofpoint-ORIG-GUID: EogD7f8ZgkD-YiRX5tN1-bZFAmd7BBDt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

Currently, the TX and RX MCS rate configurations per peer are
reversed when sent to the firmware. As a result, RX MCS rates
are configured for TX, and vice versa. This commit rectifies
the configuration to match what the firmware expects.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 0d425a1bc0ab..e0a685a968bd 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2624,9 +2624,10 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 	switch (link_sta->bandwidth) {
 	case IEEE80211_STA_RX_BW_160:
 		v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
+		v = ath12k_peer_assoc_h_he_limit(v, he_mcs_mask);
 		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
 
-		v = ath12k_peer_assoc_h_he_limit(v, he_mcs_mask);
+		v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_160);
 		arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
 
 		arg->peer_he_mcs_count++;
@@ -2636,10 +2637,10 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 
 	default:
 		v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
+		v = ath12k_peer_assoc_h_he_limit(v, he_mcs_mask);
 		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] = v;
 
 		v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_80);
-		v = ath12k_peer_assoc_h_he_limit(v, he_mcs_mask);
 		arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] = v;
 
 		arg->peer_he_mcs_count++;
-- 
2.43.0


