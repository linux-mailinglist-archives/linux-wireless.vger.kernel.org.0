Return-Path: <linux-wireless+bounces-15488-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B089D1F3C
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 05:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE4E281890
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 04:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2623C153BFC;
	Tue, 19 Nov 2024 04:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YDKK7SA3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A991531E3;
	Tue, 19 Nov 2024 04:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990514; cv=none; b=he3YvRnc+rduGSvWchN8wGo45vJmHYTJ9DoL5WpJj5Rwrc/TLaBhJfnHfSBFDgdSsVeoIcEMJE84fnZ/5lMhHgNH2MQxP/6O4785pV+/3aDF7RPMuwOlOIxZl7GbHCyBWZ7qCdFCwWB0tfYX6awM9LemB5/gAAbTvXNNCHrIHew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990514; c=relaxed/simple;
	bh=PVKmyw1pfkqmWRGrbj/gBaapGsdmj4pLdvWT/mjE8Iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fwPvdYDBJ/Hr6cvXhFQXUG5cTc5G3b44JbbrrkcuSv7DFOcsPwzFvgroNS58CaXYRFdD5jYmq6YJ2Q7QyLd141sS0kNVIaF2qz+1pTnRqiBYV7FAZFUaleGYwGWsDki0jwnxIY/zfaDCrEKlrJjkmqgqmbI1jBvDcjmWmNjCKIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YDKK7SA3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGGc83028399;
	Tue, 19 Nov 2024 04:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yvTvXDAmXT0/yN+YO9GRlMqfcas1ATeBqekaoQGm2X8=; b=YDKK7SA3WZBaHZeT
	c1e45FZooSKhx/nTt2jEfWz5larhmaO53Sog2bnZsTe0wl3azmWIiP+nOZngXbM6
	EqPWcQiRDI5kvaN6UHqJQfV4szbUF58hBCHy8lzyOhlvzjTP7+76f/pPXtG+Z5i5
	MGt7lTq8NlnmJqEPWEeIYSd8kmiEs0Wd7XVXZzbmEtIo2CrzFaDjFQ59b/HZdJFU
	J/9qmqhySIV4DF95AdNT6OpVT55lfhsXQgMzVGat1IUwHUp4t3TtnvzvcQ+YG4dz
	FzZT9+iuNe5s29YEBH3TeoSaVAF8voViIa3xSMgSJ4298pYVagYKCoAhcmLez7dH
	fHOgqw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y5sd55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 04:28:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ4SOAm028549
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 04:28:25 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 18 Nov 2024 20:28:22 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Tue, 19 Nov 2024 09:58:00 +0530
Subject: [PATCH 2/2] wifi: mac80211_hwsim: add 6 GHz EHT Mesh capabilities
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241119-mesh_320mhz_support-v1-2-f9463338d584@quicinc.com>
References: <20241119-mesh_320mhz_support-v1-0-f9463338d584@quicinc.com>
In-Reply-To: <20241119-mesh_320mhz_support-v1-0-f9463338d584@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>, Kalle Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Aditya
 Kumar Singh" <quic_adisi@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XJw8HiFzE1FRKYujE54mM4uZ6X_036QD
X-Proofpoint-ORIG-GUID: XJw8HiFzE1FRKYujE54mM4uZ6X_036QD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411190034

To facilitate testing of mesh EHT 320 MHz, add support for advertising
this capability.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 39 +++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 347a15544afedb238680068088487eefe24524c3..cf6a331d404271141f3e9a736feba1ad8cfead5a 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -5048,6 +5048,45 @@ static const struct ieee80211_sband_iftype_data sband_capa_6ghz[] = {
 				.tx_mcs_80p80 = cpu_to_le16(0xfffa),
 			},
 		},
+		.eht_cap = {
+			.has_eht = true,
+			.eht_cap_elem = {
+				.mac_cap_info[0] = IEEE80211_EHT_MAC_CAP0_OM_CONTROL |
+						   IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1,
+				.phy_cap_info[0] = IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ,
+				/* Leave all the other PHY capability bytes
+				 * unset, as DCM, beam forming, RU and PPE
+				 * threshold information are not supported
+				 */
+			},
+			/* For all MCS and bandwidth, set 8 NSS for both Tx and
+			 * Rx
+			 */
+			.eht_mcs_nss_supp = {
+				/* As B1 and B2 are set in the supported
+				 * channel width set field in the HE PHY
+				 * capabilities information field and 320MHz in
+				 * 6GHz is supported include all the following
+				 * MCS/NSS.
+				 */
+				.bw._80 = {
+					.rx_tx_mcs9_max_nss = 0x88,
+					.rx_tx_mcs11_max_nss = 0x88,
+					.rx_tx_mcs13_max_nss = 0x88,
+				},
+				.bw._160 = {
+					.rx_tx_mcs9_max_nss = 0x88,
+					.rx_tx_mcs11_max_nss = 0x88,
+					.rx_tx_mcs13_max_nss = 0x88,
+				},
+				.bw._320 = {
+					.rx_tx_mcs9_max_nss = 0x88,
+					.rx_tx_mcs11_max_nss = 0x88,
+					.rx_tx_mcs13_max_nss = 0x88,
+				},
+			},
+			/* PPE threshold information is not supported */
+		},
 	},
 #endif
 };

-- 
2.34.1


