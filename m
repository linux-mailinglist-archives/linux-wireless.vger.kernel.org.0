Return-Path: <linux-wireless+bounces-21086-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AB0A7921C
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 17:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6A51705FB
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 15:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95A023C8D7;
	Wed,  2 Apr 2025 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mgXBAuIc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B9623BCEC
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743607567; cv=none; b=PPdRw9snegAlY783LLnz20AfE2m/exJpa+q90pEfaThjGPzr3VXgN5ANAleq3kjclPoLqt4UjToJXnb4thrm+PNFQIOwEn3GNo6Y1GQQDpng+vJBD0NxP+bGDWrLLWPfPjHReWq0DoZowxXCXTuGM6vfpEjGcCEDw2P4yiS0ug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743607567; c=relaxed/simple;
	bh=ZEUX8Rtn2u0flAEcIs1UHuzpVqwrTUpwNmrY7CMg+pQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1P+DtyPLQgNl2fPlVYXqPa3drRiTuE14cmOOiwTAeHt2K/99OLIDCE8rCNOnhegC+qC4JjFgCQRtu3QdwH19OvdJPjSEcKkW7u8KLhe6I5oM1vOuBI3gsnQt+gk7banpgf2072t9xZPa8TCDb09WtJxT2MF8Q8aWplIMHes+VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mgXBAuIc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532D60R6024515;
	Wed, 2 Apr 2025 15:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RXckf7qpqy+iKR9NQcsjI5qx
	y3oCDe+Reqn+kdgNQRA=; b=mgXBAuIc1weKhls4FQXwLt/mzrLhIItwlm2ys5I0
	KX1uzhZ00Wx6T3CIZ+4XZVGI3yKLNbGJBcvxH+/tgOVWPXc3lYKq3C5CBnn86Reb
	OGODA/h+4gRdlPHQTzVVAnXoZstlQNFWQJzQDQs4JHtPLTW4C4vMtfCHzconFFI3
	ipOGtnNj8ISY65E8/31jm/oe5r9Ubb0AueKbON7N3DT+QuUhgMQSBh6wLcIw982q
	NweNZbGpwp2eY/KHirfLe8t6TcNFsNERSgdU0n7ESgZNSAvGFNO/Vz+lcK6u+8NW
	VnYZcqBqy6TVA+a7if0p+3QymLEHmCDCKVLsZy0rPbO0cQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45rbpyvxwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 15:26:03 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 532FQ3Db013293
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Apr 2025 15:26:03 GMT
Received: from hu-nithp-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 2 Apr 2025 08:26:01 -0700
From: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Nithyanantham Paramasivam
	<quic_nithp@quicinc.com>
Subject: [PATCH ath-next v4 3/3] wifi: ath12k: Enable REO queue lookup table feature on QCN9274
Date: Wed, 2 Apr 2025 20:55:29 +0530
Message-ID: <20250402152529.1649402-4-quic_nithp@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250402152529.1649402-1-quic_nithp@quicinc.com>
References: <20250402152529.1649402-1-quic_nithp@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IBa21SbHH_n4WrDaMkrxUrHrPvQuLEpJ
X-Proofpoint-ORIG-GUID: IBa21SbHH_n4WrDaMkrxUrHrPvQuLEpJ
X-Authority-Analysis: v=2.4 cv=ZNLXmW7b c=1 sm=1 tr=0 ts=67ed570c cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=VG1Z7HIe-OYZGDrRaVgA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_06,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=966
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020098

Enable the REO queue lookup table feature for QCN9274 by setting the
reoq_lut_support flag.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 1d1a59819bbe..20f04f5c6b5b 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1288,7 +1288,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.download_calib = true,
 		.supports_suspend = false,
 		.tcl_ring_retry = true,
-		.reoq_lut_support = false,
+		.reoq_lut_support = true,
 		.supports_shadow_regs = false,
 
 		.num_tcl_banks = 48,
-- 
2.17.1


