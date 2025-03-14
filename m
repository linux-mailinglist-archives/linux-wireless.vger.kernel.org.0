Return-Path: <linux-wireless+bounces-20385-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD482A61417
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 15:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF671B603A9
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9F120110B;
	Fri, 14 Mar 2025 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ffIofjGM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC71201035
	for <linux-wireless@vger.kernel.org>; Fri, 14 Mar 2025 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963864; cv=none; b=bV7G77sQgQYV+ITUgzv1vTAm54AhbtxcPzoAmhEm613BdMC5a6KeoHJ4L58Seemn0HUCMzL4MXPipxzd/6aTQjOuBK1TgMKunHKM6GGJlIGbfpRSqcZ6snumfwxG66wrIu02anInH6w68UrUZFDc0Ws7+4EZSwK4qwyqYYAQAos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963864; c=relaxed/simple;
	bh=mEOG8Mns/F62n+HBGXmIjMGRcaeh030ULDySRiibrpY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJM1HkSA9VhzqEvmyfhAZrMLZwYVjcuoSBtVGaIN6Vbmc7oRNZ3pEQqf6Q8ylO7FlQRuZ5lRdbhSzijuv3YXiKhLdfAeLqZ3ipKkr11eL6WjDWdxOijc8VwcW11V32hdcq/RomfgqWTqVjBO1OT9YDV9fID0RwRG+mjq1KUafa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ffIofjGM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52E7l4RX026495;
	Fri, 14 Mar 2025 14:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pwW+ZpLzfVrv9qfWlB98Eb/CtnETl3ProiOYNHO7FKA=; b=ffIofjGMT4JOLLit
	OvreTZvehFB8rk4o1Rbrzq5f2Fle3XmhU7dzfoCww8PMZhy7eibzjiKBwfjR9Mn4
	vkXwCaFEca7qLfqHngsk1jEruDv8B5vPjNYHPx/kzYKPkXmjlKr5n613vikx5ZXT
	WV89iVMHYV/eK2N3SvqsWjS4Sh9SnBoXkWG/FerNRkj1yzeWF1W09qMwKI+edTcb
	8Cg+j8PGdXAfaG/NMSN6enutMQDm93vTzx6Ziox0iz+cp3V63Hvkw1YQ5AmzIFfO
	isORWP2b07h78GvATW8iyqRlizSRySYlYk8aX7WHTNEFVtVb6W+ATu3NhlEeLIxl
	AKhwCw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45cgcd9401-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 14:50:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52EEovJW004550
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 14:50:57 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 14 Mar 2025 07:50:54 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Hari Chandrakanthan
	<quic_haric@quicinc.com>,
        Nicolas Escande <nico.escande@gmail.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH v10 1/9] wifi: ath12k: fix link valid field initialization in the monitor Rx
Date: Fri, 14 Mar 2025 20:20:29 +0530
Message-ID: <20250314145037.3678649-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250314145037.3678649-1-quic_periyasa@quicinc.com>
References: <20250314145037.3678649-1-quic_periyasa@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=UJjdHDfy c=1 sm=1 tr=0 ts=67d44252 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=IIkBQuVqd_TcsV77Gt4A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ELDcvnewflDFtr_kF4fuXAYYfDz1SYgM
X-Proofpoint-GUID: ELDcvnewflDFtr_kF4fuXAYYfDz1SYgM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_05,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=797 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140117

From: Hari Chandrakanthan <quic_haric@quicinc.com>

Currently, the link_valid field is not initialized in the monitor Rx path.
This can result in random values for the link_valid and link_id leads to
undefined behaviour in mac80211. Therefore, initialize the link_valid
field in the monitor Rx path.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
Tested-by: Nicolas Escande <nico.escande@gmail.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index d22800e89485..b1350e60e213 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1970,6 +1970,8 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 	bool is_mcbc = rxcb->is_mcbc;
 	bool is_eapol_tkip = rxcb->is_eapol;
 
+	status->link_valid = 0;
+
 	if ((status->encoding == RX_ENC_HE) && !(status->flag & RX_FLAG_RADIOTAP_HE) &&
 	    !(status->flag & RX_FLAG_SKIP_MONITOR)) {
 		he = skb_push(msdu, sizeof(known));
-- 
2.34.1


