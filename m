Return-Path: <linux-wireless+bounces-21280-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBB3A814E8
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 20:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878A11BA7D35
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 18:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF293241691;
	Tue,  8 Apr 2025 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GRIKm0U6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEB923A562
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744137910; cv=none; b=TI3qJeoqaRWedcwOrmoSR+IiSAf6bQVeS8IUo86xRsPUD0vhZJGIqudgHSseaeX9EfzgF0q+IXxE/NuKNsJEmmgPMvWW3PP4nX6VZnbhWxXIjOCMSzR1IFta1v/hIsnitsfUpkqZqDdGkqL+BMolUP7lrWJNUNddzvvJZK/JTho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744137910; c=relaxed/simple;
	bh=mJJqMFRsS0InY4zWDkvjf3oJ4dE9bGjoWuMb+giwdjs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yv3AMhweB+/ME/5622YZ4TRloNn4nzloAusV1s3mtXsdzRGhJbrF05snRxdaFSFJLoa3zgEyhuo+WiCWXID9wr5KrBjHZMJb830fJpgl3sQJ1kXh32quS9o3jRHQrU0JQKnrdiyn90JfX7otfotYzZMe7cV1zF16hs6bEAh1ess=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GRIKm0U6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538BBxRa027678
	for <linux-wireless@vger.kernel.org>; Tue, 8 Apr 2025 18:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=V0zGC39nAfR
	UYoPg3aOmlDwHuUcoNloqjSgKMRMWL4s=; b=GRIKm0U6JijuRPBUjhnrfOzQ0VK
	aYSAHJOesdFcAP3DukJWAx3d4OLhliyckt9HxBLq6U9XOimNSekUWE8euon0BUZX
	iBCQGygWQM2YSnbOipbM7ArrMX++aRB3jZOCRsYoZt97XXAciRivuKvJsH/H3YxB
	JIS+nmT+tzITavQWA76Auwl2iTxSYaed+koqu2sZcfpA+ExFzEfUMqc/Hy/AOfz9
	3F51zwFcRVUjqVqbKwIawBoTA+KSWUpopTW5Vzqnq8aKa8TM6woboQw7EcqAMR6W
	7FqT2Vj77vImqphb+fRo2Co9AfYtrKQzG3gQNfNPOEKx1L212fdPq1sQW/w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twd00x8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 18:45:07 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff69646218so8605917a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 11:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744137906; x=1744742706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0zGC39nAfRUYoPg3aOmlDwHuUcoNloqjSgKMRMWL4s=;
        b=SoqLhsXzHKdhk85eezK7UzYogsD8aLpx+0ZpPvqfVD4JuERx5rMoeuvGpARqsPuook
         ZhKaWz0JX9Hmky+06JAtyaiN/SZpTG6GCTmDDsM44+BZbFePSOq6a7kOsdCVVrIkA1oJ
         73fvwD1258CP/3WN/mkiDMR5kYe9cmdtoJjghv/sbMJQqCPD7qec6cwUT3aa+jlfaDi2
         8nqX4CVHODzP7f59cCSMNXnMJyuZ0y4noYOMLO3U2ufu+TZ0mya6UDPexWeLXou07vWh
         5UcgELDKr3SnWbi6y9h5fF5e6TnWEnujH6/3UM9cGziWW2So+iOBEW1tO6U3OhPaHPuR
         W4aw==
X-Gm-Message-State: AOJu0YxPHiyVCTyQw/CJCVP/idx7ay546ESbXnJDsiYMTmAj1toWOLSq
	52PCjzRT/O29Y0flFEbogc/Wwln2QjNk/PEaJ0cSsb5dsYd1lvAOTPJ5FhKR/TrpMIZKKGIWjhE
	H/dpNrfDNSuMsxT94BJfDWBVxzhyki9eERq3xOsP7bCriGrvoFLM41IaVQjdaVX+fbWXETCTETA
	==
X-Gm-Gg: ASbGnctOLP4hry0Rc1WDTRrxUuWtmdDqMn1E+8fVS/kweBf2qF53Te82UbBvD8m7S/B
	mg4IZHfXK3Lxs2ER8WiymAE8DND7D2pdvjAnE8GieJH3Sfp8g5hrEMiDmctocwWEBX3CHdIc+Yk
	N4oJQwHustCeIY+6L/HZgGMVG/9mUqqecFMizsUcbIgwl07HdnjbHRpQRh+UyEW6KpsCR9E8w4C
	f0EmV3hHePtKlrp49kgvIHijdhcIohjUr/omvDZv3oFdhBov4UfoJHPWdkP8N2Wln40hY7DfkLl
	OOc9B9C3+qPAz9sRz7QLGMzuQSd4mTz6O/kJwm/4xcHD68eoq0JZlsIUzjlUTl1/GDqr+4I=
X-Received: by 2002:a17:90b:270e:b0:305:2d9b:f8d1 with SMTP id 98e67ed59e1d1-306dbc23bcfmr414949a91.24.1744137905984;
        Tue, 08 Apr 2025 11:45:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaU3DhJgD9mFlpz+3pt/knEhqaVCDrmHUL3p4sYGxtpbfvJJ4wuIl+C1Isb4VWBwFOCCpiIA==
X-Received: by 2002:a17:90b:270e:b0:305:2d9b:f8d1 with SMTP id 98e67ed59e1d1-306dbc23bcfmr414917a91.24.1744137905639;
        Tue, 08 Apr 2025 11:45:05 -0700 (PDT)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057cb9500dsm12882212a91.47.2025.04.08.11.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 11:45:05 -0700 (PDT)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        ath11k@lists.infradead.org
Subject: [PATCH ath-next v5 3/3] wifi: ath12k: pass link_conf for tx_arvif retrieval
Date: Tue,  8 Apr 2025 11:45:01 -0700
Message-Id: <20250408184501.3715887-4-aloka.dixit@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408184501.3715887-1-aloka.dixit@oss.qualcomm.com>
References: <20250408184501.3715887-1-aloka.dixit@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iDp3EcTqM1SFZBHNpHMzWI72e_v5wWNY
X-Authority-Analysis: v=2.4 cv=Q4vS452a c=1 sm=1 tr=0 ts=67f56eb3 cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=66aBALrjW5AsI7a0044A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: iDp3EcTqM1SFZBHNpHMzWI72e_v5wWNY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_08,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 mlxlogscore=792 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080128

Three out of four callers to ath12k_mac_get_tx_arvif() have
link_conf pointer already set for other operations. Pass it
as a parameter. Modify ath12k_control_beaconing() to set
link_conf first.

Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 31 +++++++++++++++------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index fe4a22362000..15ee1f4b5193 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -580,22 +580,16 @@ static int ath12k_mac_vif_link_chan(struct ieee80211_vif *vif, u8 link_id,
 	return 0;
 }
 
-static struct ath12k_link_vif *ath12k_mac_get_tx_arvif(struct ath12k_link_vif *arvif)
+static struct ath12k_link_vif *
+ath12k_mac_get_tx_arvif(struct ath12k_link_vif *arvif,
+			struct ieee80211_bss_conf *link_conf)
 {
-	struct ieee80211_bss_conf *link_conf, *tx_bss_conf;
+	struct ieee80211_bss_conf *tx_bss_conf;
 	struct ath12k *ar = arvif->ar;
 	struct ath12k_vif *tx_ahvif;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
-	link_conf = ath12k_mac_get_link_bss_conf(arvif);
-	if (!link_conf) {
-		ath12k_warn(ar->ab,
-			    "unable to access bss link conf for link %u required to retrieve transmitting link conf\n",
-			    arvif->link_id);
-		return NULL;
-	}
-
 	tx_bss_conf = wiphy_dereference(ath12k_ar_to_hw(ar)->wiphy,
 					link_conf->tx_bss_conf);
 	if (tx_bss_conf) {
@@ -1623,7 +1617,7 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_link_vif *arvif)
 		return -ENOLINK;
 	}
 
-	tx_arvif = ath12k_mac_get_tx_arvif(arvif);
+	tx_arvif = ath12k_mac_get_tx_arvif(arvif, link_conf);
 	if (tx_arvif) {
 		if (tx_arvif != arvif && arvif->is_up)
 			return 0;
@@ -1693,6 +1687,7 @@ static void ath12k_control_beaconing(struct ath12k_link_vif *arvif,
 {
 	struct ath12k_wmi_vdev_up_params params = {};
 	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ieee80211_bss_conf *link_conf;
 	struct ath12k_link_vif *tx_arvif;
 	struct ath12k *ar = arvif->ar;
 	int ret;
@@ -1725,7 +1720,15 @@ static void ath12k_control_beaconing(struct ath12k_link_vif *arvif,
 	params.aid = ahvif->aid;
 	params.bssid = arvif->bssid;
 
-	tx_arvif = ath12k_mac_get_tx_arvif(arvif);
+	link_conf = ath12k_mac_get_link_bss_conf(arvif);
+	if (!link_conf) {
+		ath12k_warn(ar->ab,
+			    "unable to access bss link conf for link %u required to retrieve transmitting link conf\n",
+			    arvif->link_id);
+		return;
+	}
+
+	tx_arvif = ath12k_mac_get_tx_arvif(arvif, link_conf);
 	if (tx_arvif) {
 		params.tx_bssid = tx_arvif->bssid;
 		params.nontx_profile_idx = info->bssid_index;
@@ -7938,7 +7941,7 @@ static int ath12k_mac_setup_vdev_params_mbssid(struct ath12k_link_vif *arvif,
 		return -ENOLINK;
 	}
 
-	tx_arvif = ath12k_mac_get_tx_arvif(arvif);
+	tx_arvif = ath12k_mac_get_tx_arvif(arvif, link_conf);
 	if (!tx_arvif)
 		return 0;
 
@@ -9526,7 +9529,7 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 		params.aid = ahvif->aid;
 		params.bssid = arvif->bssid;
 
-		tx_arvif = ath12k_mac_get_tx_arvif(arvif);
+		tx_arvif = ath12k_mac_get_tx_arvif(arvif, link_conf);
 		if (tx_arvif) {
 			params.tx_bssid = tx_arvif->bssid;
 			params.nontx_profile_idx = link_conf->bssid_index;
-- 
2.34.1


