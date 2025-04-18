Return-Path: <linux-wireless+bounces-21732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C93A93C32
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 19:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB921189A653
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 17:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9D621CC40;
	Fri, 18 Apr 2025 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="os1ybK+c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7716321CA02
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998530; cv=none; b=HoiO9HOJCVQiJeTt03MuaOvjPfGa5sCIFW34Y+Wn62tu9k4ZqBRIkB3sxuH7QJZOIG8MtMHgcNrFfdreFmn3ePEyAbfGUZfeduVuSd0F9PtaN3rmh0bqC/n16YfQ3Y8rh2cABhEgnhFDIsPr+jWZDRFZxTNQ68VVubW4JXBNLj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998530; c=relaxed/simple;
	bh=iGlpFjRzESfwQ18JCZeNYurBrfaoKCEqAuudeD2B2/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dfrh3DjsZUvfW3Nt5MPP1KKHyE0M861Z5Jn2eo5KwzKlTlGRw4Jfh12kmBRBgUb2kyNe5GARjKA24BRqKlHOt13OyUU944KvAD3lQ2h6u4leM0Jovjt7sDd5Dubmk9JfFawAGOXl+3JKm5yNvWIcEMrBOrMP/3ESWb80CP2ahIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=os1ybK+c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53IEejWl013325;
	Fri, 18 Apr 2025 17:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dxIRfF1GDtIY3jxEhleGHc8NensGdqwPvFzrLftn9LU=; b=os1ybK+cAoZ97Wcg
	0X8L9UjWvw0pqVC2JbXAQi98TB8mrwh/EBChkiZhwAIo1r3G2F6jyz0ingeSdKm+
	SFtBD090hvJjFXc5IDobKr+AzrC/Ol9j74jyBLTRc1UdU6tzt4DSNq/3TNog++Yk
	POMNKYaxv4YH7fYRt5Ud9S+j8HzzxCEy7+2Ws5VlE3tzqzTxSgjf4f7vOKMqtExD
	feWjsMpMhyF8i5Og8LmaRvvnYMMPZpCIEP88DegBd5lvImWz6vFMNZHJkojVOn5M
	+z3UfWqZjgam1oI5n7mw7yja6dFva6rRDk3mwtjF86JHAIzgwfqv0CcKKHgrs8RB
	5ZQ4vw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4628rvfwjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 17:48:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53IHmiVY027808
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 17:48:44 GMT
Received: from ath12k-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 18 Apr 2025 10:48:44 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH V13 5/9] wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
Date: Fri, 18 Apr 2025 10:48:14 -0700
Message-ID: <20250418174818.3336510-6-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250418174818.3336510-1-quic_pradeepc@quicinc.com>
References: <20250418174818.3336510-1-quic_pradeepc@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 5CNS8S85XDK7pk4SNoKfHFKlnbhTMx0I
X-Authority-Analysis: v=2.4 cv=RbSQC0tv c=1 sm=1 tr=0 ts=6802907d cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=mu3tZSmwaZwQUXtd2tAA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 5CNS8S85XDK7pk4SNoKfHFKlnbhTMx0I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180133

Currently, the TX and RX MCS rate configurations per peer are
reversed when sent to the firmware. As a result, RX MCS rates
are configured for TX, and vice versa. This commit rectifies
the configuration to match what the firmware expects.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 4 ++--
 drivers/net/wireless/ath/ath12k/wmi.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ea303dca38b5..6002d4df536a 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2327,8 +2327,8 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 		he_mcs->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_HE_RATE_SET,
 							    sizeof(*he_mcs));
 
-		he_mcs->rx_mcs_set = cpu_to_le32(arg->peer_he_rx_mcs_set[i]);
-		he_mcs->tx_mcs_set = cpu_to_le32(arg->peer_he_tx_mcs_set[i]);
+		he_mcs->rx_mcs_set = cpu_to_le32(arg->peer_he_tx_mcs_set[i]);
+		he_mcs->tx_mcs_set = cpu_to_le32(arg->peer_he_rx_mcs_set[i]);
 		ptr += sizeof(*he_mcs);
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index c661bfa79ea0..d4d0aae70011 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4118,7 +4118,9 @@ struct ath12k_wmi_vht_rate_set_params {
 
 struct ath12k_wmi_he_rate_set_params {
 	__le32 tlv_header;
+	/* MCS at which the peer can receive */
 	__le32 rx_mcs_set;
+	/* MCS at which the peer can transmit */
 	__le32 tx_mcs_set;
 } __packed;
 
-- 
2.34.1


