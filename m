Return-Path: <linux-wireless+bounces-26307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F17B225AE
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 13:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4977188F2B7
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 11:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33A62ED15D;
	Tue, 12 Aug 2025 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MjxvzBA0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3923A2ECEB8
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997445; cv=none; b=VKMOxOnT1cGwbtUXRJBYpuZULk7yz/IWhVpJRX+SVCMhSdYzfpZi9p9Hjg6CboRIfpc2FFORfQuF0XLuSNex+YRnlYo2RmKPSGejY6Huz54ZqPfnQQK+G/P+bH+LXNgOCfeNPt+KPfvywpM2AQu9SnwHoAuiAHxK14u7wF6ePw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997445; c=relaxed/simple;
	bh=nSGu1nIlclf04CNasQZDRvZCU0HSdbZfhYeT6TpUYKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RFqVGAgJHuAUCUFv76fbjziMAmpP9LZlPyLjvgzM4E07q5JJp5ZfzFGHKFAyqzwGzwtXJ2a6o8RZQT6Uz2pfaUo4pmc4SAbJ/2OdQrzK/ctxIxRwfTk1l4RMrLglIipnQhmm7oHdJrhMuAYC7TMz1aSX0sEfCjc9K2tLxnNHgcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MjxvzBA0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAvf3I020372
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 11:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=+gaxpLs05l9kYZ2jejuyprZBJK2egG1VMc4675dTbj8=; b=Mj
	xvzBA0D0pki1jutul8YJVTcoyaURX1sOzgdcXZsgGS4tf0cWIpRro/DP+oNYUi17
	aw1ATYbMuqmUl8ggn6qEJrGrBqYoy9z1UyrUzbZArFe0aapubwhwbP0KQ58FXJOa
	mPyg/GPpwpYXtKEE7PQKeii/Q3cBsuQaO5lNqSpDs38bvDUn6fehfJA/ieS3FxmP
	ULv/HBo3ZOGBOnI1oYGU4Op1O5Uljqu+8DyfU8GRN1Wtug3PoQpUvGep8B8U/yWr
	AaGqMp+D/miew9M+tTkyl5uMrIBOWBOJc0O/2+BXuuR5EicQWyLHUNxjycHd8CEC
	WxAtTHYjt5GUnz7BWKpw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhx62tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 11:17:22 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-242fe34add1so7581765ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 04:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754997442; x=1755602242;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gaxpLs05l9kYZ2jejuyprZBJK2egG1VMc4675dTbj8=;
        b=MB9zgkVLI3QKpQASwwovyglkdmfUHaymi5nrMHxbRiRw+h7dXhfG9ULpM3AEq/iYn+
         WyaiFPekaXbyi/4uUk1UES0LK/rybQuMUVo3skNc/tjuEYkpqik+dIZhJCnG32WQitwe
         9nO00kgViPMVTkp7rHD78JzxCYz8w3CvLZNUiCcxeA9/adBpFpcB9bsDIfoko2FiquHQ
         PWoMAsgjccyDJDwt4HPIhxRqDePOHAuAclPlbPvAhW/lZgdTmW5y2fJT6rCOy8VgDqTe
         A9QV4PUYZNMVOLXzqStv9SaRKHYWYgf5yyGhzK6wyfTSxtFfBXxoc3DUNaLpGB6XyAzS
         m3kA==
X-Gm-Message-State: AOJu0YxjES2zdBPCbtH3P/xu/pkjudMqFf9GqyP227NeWX3SOZypVAFD
	6HewgU5jqHudEovsbo+WKIAKDosDgXAmeOiab3zuBZWYBCRVJROhcTf68AGujSMrdH2nXt8uPZ4
	uYYoEAbcSdn7ax9Bx3wK1HiPB42UoR/EpV0sCwxrG9TBr8OxLcGG/o5MiJkNcSTp4sAJZnA==
X-Gm-Gg: ASbGnctFhA9REciDTsW3AbEfZVQ5j5DHDGShtv+tE+X5MGRnHj0Hgt7mEwlizGhbMLc
	+IqnN8j9i4X1N4mYVSklVjuvikEgnG7FI2AQQH0UmwDmorCtAJFEBKA06MFXGJIccx6Lr6lD9Dv
	CqBV0bH1NADdiaZTQvZN0BIrhJ2apeimmcRC61TaO9a0pJSKppFepAWJM0VrXfocz73KqI5ROTB
	1M2k8tn3KlY90zaYu9If5d7I5bzEwrP8aXal8HLSiNAW1CMbyILxedRlspI7ZBQGEkq3QrM+zHc
	kFxmcWZsntXkJBYxFicjjZpfU//z0FcWLWsJPVKFhy9bQI9r6sJTsCrBvN2KcLeGCTYXeG5EkEJ
	g4dehAMA=
X-Received: by 2002:a17:903:1b70:b0:242:fe99:eb20 with SMTP id d9443c01a7336-242fe99eeafmr34563855ad.9.1754997441597;
        Tue, 12 Aug 2025 04:17:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPq0dStUkPx4cTX88OhK3zqVQL4Wzn9gJ3/yYPkTrkianwgxlmegZz8QKD0a+E8z7sGcB19g==
X-Received: by 2002:a17:903:1b70:b0:242:fe99:eb20 with SMTP id d9443c01a7336-242fe99eeafmr34563305ad.9.1754997440985;
        Tue, 12 Aug 2025 04:17:20 -0700 (PDT)
Received: from che-ventolnx02.qualcomm.com ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f1ebc1sm296048935ad.67.2025.08.12.04.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 04:17:20 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Arulanbu Balusamy <quic_abalusam@quicinc.com>,
        Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH ath-next 2/3] wifi: ath12k: Add support to handle reason inactivity STA kickout event for QCN9274/IPQ5332
Date: Tue, 12 Aug 2025 16:47:07 +0530
Message-Id: <20250812111708.3686-3-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250812111708.3686-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250812111708.3686-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfX/+qpfRsPsOrj
 C9yMpsBGixizPrwB8GNBWrpRbt7WhiTUQIeEFcDt5Og5bYcUUtAUqHc16MzpTg9feEbLiUWFEIh
 rhUjSfw2yt7kPDAU+0XwkNFIKwjfRpXFdZHlSET9kovIeT8eU7bbk2xkA+/hknKUhT/xOl521Tt
 q4c3z7I95XWgHIlz2tGLH9h46obW2GEWcaG8fZCA0pRzzEsYwBXika62AiGeDzGRaqRB9XB9zqO
 BQyVDimnhGCyeA8xHgGj9MHNdHkB+nHubitqKJmwXwNulOa1FFvaa4k3mlf8WmJJqfnoCGZdctg
 dF+yCJf7TGI41Cq58z0F4w5BeBUMWwEffNKgXoEO0IGQBdBoGKKvyKWDOuX6I367e0J/uJIBJop
 KN0yMblW
X-Proofpoint-GUID: q28IBUjTeeB6daNN8i3k1MMXxHlewUwn
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689b22c3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pF2EGbSXpo1r09cqILgA:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: q28IBUjTeeB6daNN8i3k1MMXxHlewUwn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

From: Arulanbu Balusamy <quic_abalusam@quicinc.com>

Currently, when the non-AP STA connected to the AP STA, and the AP STA goes
down or becomes inactive without indication, firmware detects the beacon
miss and sends the WMI event WMI_PEER_STA_KICKOUT_EVENTID with reason as
INACTIVITY. The host driver handles this event as low ACK and reports it to
the mac80211 driver.

However, the expectation is that non-AP STA should be disconnected from
AP STA instantly once it receives the STA kickout event with reason of
inactivity.

Trigger a disconnect from AP STA through beacon miss handling upon
receiving non-AP STA peer kickout event with reason code inactivity.

Replace the helper function ath12k_mac_get_ar_by_vdev_id() with
ath12k_mac_get_arvif_by_vdev_id() due to the following reasons.

1. Check the station VIF type for handling the beacon miss.

2. Retrieve the proper ar from the arvif by checking the vdev_id with
   vdev_map and link_map lookup which is needed for the MLO case in the
   following patch.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Co-developed-by: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
Signed-off-by: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
Signed-off-by: Arulanbu Balusamy <quic_abalusam@quicinc.com>
Co-developed-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index cb686c68987a..113ce1390eb1 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7299,6 +7299,7 @@ static void ath12k_scan_event(struct ath12k_base *ab, struct sk_buff *skb)
 static void ath12k_peer_sta_kickout_event(struct ath12k_base *ab, struct sk_buff *skb)
 {
 	struct wmi_peer_sta_kickout_arg arg = {};
+	struct ath12k_link_vif *arvif;
 	struct ieee80211_sta *sta;
 	struct ath12k_peer *peer;
 	struct ath12k *ar;
@@ -7320,13 +7321,15 @@ static void ath12k_peer_sta_kickout_event(struct ath12k_base *ab, struct sk_buff
 		goto exit;
 	}
 
-	ar = ath12k_mac_get_ar_by_vdev_id(ab, peer->vdev_id);
-	if (!ar) {
+	arvif = ath12k_mac_get_arvif_by_vdev_id(ab, peer->vdev_id);
+	if (!arvif) {
 		ath12k_warn(ab, "invalid vdev id in peer sta kickout ev %d",
 			    peer->vdev_id);
 		goto exit;
 	}
 
+	ar = arvif->ar;
+
 	sta = ieee80211_find_sta_by_ifaddr(ath12k_ar_to_hw(ar),
 					   arg.mac_addr, NULL);
 	if (!sta) {
@@ -7339,7 +7342,16 @@ static void ath12k_peer_sta_kickout_event(struct ath12k_base *ab, struct sk_buff
 		   "peer sta kickout event %pM reason: %d rssi: %d\n",
 		   arg.mac_addr, arg.reason, arg.rssi);
 
-	ieee80211_report_low_ack(sta, 10);
+	switch (arg.reason) {
+	case WMI_PEER_STA_KICKOUT_REASON_INACTIVITY:
+		if (arvif->ahvif->vif->type == NL80211_IFTYPE_STATION) {
+			ath12k_mac_handle_beacon_miss(ar, peer->vdev_id);
+			break;
+		}
+		fallthrough;
+	default:
+		ieee80211_report_low_ack(sta, 10);
+	}
 
 exit:
 	spin_unlock_bh(&ab->base_lock);
-- 
2.17.1


