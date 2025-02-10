Return-Path: <linux-wireless+bounces-18726-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ED7A2F6FE
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 19:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD35166BE6
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 18:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8E92566F7;
	Mon, 10 Feb 2025 18:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pvt+3jv2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CED2566C4
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212047; cv=none; b=KcgWmLTSxnZU0lSuPJPGgoQcS8bxvBhNJYX8Jqtr+tJdJIMcEqPUuoUMIGXef43s8NTj3eG3JsZt7aR6EhaKa8OVH1QWwOynycJauXMcAxHdtAvE+Rzh5j7a24WPdZP4XzXoQIUSJQb2WoNuqtC/RTxe+SqapqhgfEOXsrVZ01Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212047; c=relaxed/simple;
	bh=W1/XQcNCOAbLvz7JqeCuxh0SdJ9H8MjPDVqhBacqeRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l7w5OWY6xel22lmKGMAXSO7BxUNVMpSeKXWFPr5QGSjRJe9Fy3JmZ7P05gvoygS+NMeI5QvnU1PX6RN7poM3+WovWUOi2aGM3h37Tz/ZMXF2GNWo6v4ADzxVJW04FsDvOWgkEL0zuE7L7Ikd5disn2wD634GQCGM9d95MTofvig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pvt+3jv2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A9VqQ4008278
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 18:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Yp2/DibRsBy
	Ma+EuVeyCQ+AgsGVeDKcUvGXcO4trUWo=; b=Pvt+3jv2kS1sZP1AiSC7O1I2U34
	TJzFpNEomiQFwOQF67y/ZaTmzSGvPjjKaYnqFAwwRM4Jb66eEdaCFe/3k+Z1Yvpq
	EVx0QA5jGlCLIw9qU+b966vKt3kpabmmBCKZZmwBrFGo2nW8KsrjCfLLGclCGdVZ
	b+qmGrCZZXlneyn3LupBC+8FW3wv2GsewihoHM0h//XxShia0hUCHXYP6m0mULQc
	XK6ZCH8iWMeegZDAOPDDAAfvPj46TSh2cCMY9O4gOzY2cCEYMIwS+ynUGn2galsu
	ocXKAHt2kn2Q0yj0mOsh7Lq2OMVuEEaZr/B/u0VMxdcylnOkbkFO/punh2g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qewh1f7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 18:27:24 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fa6610fe70so3269341a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 10:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739212044; x=1739816844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yp2/DibRsByMa+EuVeyCQ+AgsGVeDKcUvGXcO4trUWo=;
        b=pnE2Vbam2LiHq+P64WjapHccU1wH5JoOG7hdcTauqvT6mw0wcDfcHugcAe7wlLZLcW
         ezT9jbjw0JTIhN7F4+XEd0q6p7Gm0Ws4HudsgmJEbim6TV4+n8511kzusLO0TvFXFLC9
         YtFIlEzrPTUh6zJDY8blKEbWeO1kaj04awiIOW0w2952BIUduLXLxrk7KwJP1vnJtyhr
         PGgW5s0qqjtS6nUNf8s2C4SJC+Vfz6syCjuYoKm1S0AoMuSl5np4JxUBub29P0bIXNnF
         ppB+hSyKYv6ba2SeMu8pgopt0ltsy9npRqr9veL1SWNW2zjWUJphSstmXgifmAwu9gcV
         Y5Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVyBuNo9YpkvpcJwrSNKt/HvcCESiBjsTZvMJdaXg+93NU0KwVe7izP3BUlnfmfJIe7tcW2cQEpBezbBVo6/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmXvR/JMuHvO+1NZU6h+Eo3yU4hHZ/ZROIFPoHKv2L4yWd9cOZ
	avystDrmlmUsP0ajfMk8mlVZeaNXyADSlLpps1QHzauEWeDkjm0fv6YZQffayYCylHnyFjBkdSz
	eSwkgwCsL16ssNB0M1mPuzBGfsiZ32NZZg3YP5UjXtQPCco9SBWl5rKVJkkGpk6rgMQ==
X-Gm-Gg: ASbGncumuXioI6m3HaIZSJNtN7gnfsGOrKH9PQurIyZzh6viy6Qqv06CrERJTHu/375
	iamRpOhBiJJs8KPE1wgUvuEWXJOKZEMHO06OoMidgB76ncYsxYuyWkRhq8rU8hPJHyP2ynTFPjs
	DyDE8jCevz5t6e4e6rn1FhcYt49Jkc3VU2D2QV+M/k+Isg71LFho3xb9lPGHXfqrNmgsZmnmMl8
	XLap6dFYBcET7oCyTJJUUvqK6vULDsYneiMhqfhaa5nbOahJsuWhcEfdJxHKOmDcBhWA1rgGJGz
	xPU+yYuhjBQ+FPLGaXs0gVlWlHUYKw4NNKGsmX+JGf9CGuV8Xz1rUhLyl8mf
X-Received: by 2002:a05:6a00:7491:b0:730:75b1:7218 with SMTP id d2e1a72fcca58-73075b17593mr10741976b3a.16.1739212043789;
        Mon, 10 Feb 2025 10:27:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE91sQYwrJPLIU/e6nitruwQTHgHylPVSviUYoGaKIF8VGT7OcasBjhnPeYpHaknDQwBYfSvw==
X-Received: by 2002:a05:6a00:7491:b0:730:75b1:7218 with SMTP id d2e1a72fcca58-73075b17593mr10741931b3a.16.1739212043231;
        Mon, 10 Feb 2025 10:27:23 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae8e83sm7948372b3a.84.2025.02.10.10.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:27:22 -0800 (PST)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v4 3/5] wifi: ath12k: refactor transmitted arvif retrieval
Date: Mon, 10 Feb 2025 10:27:16 -0800
Message-Id: <20250210182718.408891-4-aloka.dixit@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210182718.408891-1-aloka.dixit@oss.qualcomm.com>
References: <20250210182718.408891-1-aloka.dixit@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7Menk_L8xNm7eNGWRM7QHvvXl6vBryDV
X-Proofpoint-GUID: 7Menk_L8xNm7eNGWRM7QHvvXl6vBryDV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_10,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 mlxlogscore=998 phishscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100149

Create a new function ath12k_mac_get_tx_arvif() to retrieve 'arvif'
for the transmitted interface of the MBSSID set. This clean up will
help modifying the same code path for MLO changes.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 60 +++++++++++++++------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 16e6f2fae943..e642fba2843e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -579,6 +579,19 @@ static int ath12k_mac_vif_link_chan(struct ieee80211_vif *vif, u8 link_id,
 	return 0;
 }
 
+static struct ath12k_link_vif *ath12k_mac_get_tx_arvif(struct ath12k_link_vif *arvif)
+{
+	struct ath12k_vif *tx_ahvif;
+
+	if (arvif->ahvif->vif->mbssid_tx_vif) {
+		tx_ahvif = ath12k_vif_to_ahvif(arvif->ahvif->vif->mbssid_tx_vif);
+		if (tx_ahvif)
+			return &tx_ahvif->deflink;
+	}
+
+	return NULL;
+}
+
 struct ieee80211_bss_conf *
 ath12k_mac_get_link_bss_conf(struct ath12k_link_vif *arvif)
 {
@@ -1637,7 +1650,6 @@ static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif)
 	struct ieee80211_ema_beacons *beacons;
 	struct ath12k_link_vif *tx_arvif;
 	bool nontx_profile_found = false;
-	struct ath12k_vif *tx_ahvif;
 	int ret = 0;
 	u8 i;
 
@@ -1649,10 +1661,9 @@ static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif)
 		return -ENOLINK;
 	}
 
-	tx_ahvif = ath12k_vif_to_ahvif(ahvif->vif->mbssid_tx_vif);
-	tx_arvif = &tx_ahvif->deflink;
+	tx_arvif = ath12k_mac_get_tx_arvif(arvif);
 	beacons = ieee80211_beacon_get_template_ema_list(ath12k_ar_to_hw(tx_arvif->ar),
-							 tx_ahvif->vif,
+							 tx_arvif->ahvif->vif,
 							 tx_arvif->link_id);
 	if (!beacons || !beacons->cnt) {
 		ath12k_warn(arvif->ar->ab,
@@ -1695,11 +1706,10 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_link_vif *arvif)
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
 	struct ieee80211_bss_conf *link_conf;
-	struct ath12k_link_vif *tx_arvif = arvif;
+	struct ath12k_link_vif *tx_arvif;
 	struct ath12k *ar = arvif->ar;
 	struct ath12k_base *ab = ar->ab;
 	struct ieee80211_mutable_offsets offs = {};
-	struct ath12k_vif *tx_ahvif = ahvif;
 	bool nontx_profile_found = false;
 	struct sk_buff *bcn;
 	int ret;
@@ -1714,17 +1724,19 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_link_vif *arvif)
 		return -ENOLINK;
 	}
 
-	if (vif->mbssid_tx_vif) {
-		tx_ahvif = ath12k_vif_to_ahvif(vif->mbssid_tx_vif);
-		tx_arvif = &tx_ahvif->deflink;
+	tx_arvif = ath12k_mac_get_tx_arvif(arvif);
+	if (tx_arvif) {
 		if (tx_arvif != arvif && arvif->is_up)
 			return 0;
 
 		if (link_conf->ema_ap)
 			return ath12k_mac_setup_bcn_tmpl_ema(arvif);
+	} else {
+		tx_arvif = arvif;
 	}
 
-	bcn = ieee80211_beacon_get_template(ath12k_ar_to_hw(tx_arvif->ar), tx_ahvif->vif,
+	bcn = ieee80211_beacon_get_template(ath12k_ar_to_hw(tx_arvif->ar),
+					    tx_arvif->ahvif->vif,
 					    &offs, tx_arvif->link_id);
 	if (!bcn) {
 		ath12k_warn(ab, "failed to get beacon template from mac80211\n");
@@ -1781,6 +1793,7 @@ static void ath12k_control_beaconing(struct ath12k_link_vif *arvif,
 {
 	struct ath12k_wmi_vdev_up_params params = {};
 	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ath12k_link_vif *tx_arvif;
 	struct ath12k *ar = arvif->ar;
 	int ret;
 
@@ -1811,11 +1824,9 @@ static void ath12k_control_beaconing(struct ath12k_link_vif *arvif,
 	params.vdev_id = arvif->vdev_id;
 	params.aid = ahvif->aid;
 	params.bssid = arvif->bssid;
-	if (ahvif->vif->mbssid_tx_vif) {
-		struct ath12k_vif *tx_ahvif =
-			ath12k_vif_to_ahvif(ahvif->vif->mbssid_tx_vif);
-		struct ath12k_link_vif *tx_arvif = &tx_ahvif->deflink;
 
+	tx_arvif = ath12k_mac_get_tx_arvif(arvif);
+	if (tx_arvif) {
 		params.tx_bssid = tx_arvif->bssid;
 		params.nontx_profile_idx = info->bssid_index;
 		params.nontx_profile_cnt = 1 << info->bssid_indicator;
@@ -7673,14 +7684,9 @@ static int ath12k_mac_setup_vdev_params_mbssid(struct ath12k_link_vif *arvif,
 					       u32 *flags, u32 *tx_vdev_id)
 {
 	struct ath12k_vif *ahvif = arvif->ahvif;
-	struct ieee80211_vif *tx_vif = ahvif->vif->mbssid_tx_vif;
 	struct ieee80211_bss_conf *link_conf;
 	struct ath12k *ar = arvif->ar;
 	struct ath12k_link_vif *tx_arvif;
-	struct ath12k_vif *tx_ahvif;
-
-	if (!tx_vif)
-		return 0;
 
 	link_conf = ath12k_mac_get_link_bss_conf(arvif);
 	if (!link_conf) {
@@ -7689,11 +7695,13 @@ static int ath12k_mac_setup_vdev_params_mbssid(struct ath12k_link_vif *arvif,
 		return -ENOLINK;
 	}
 
-	tx_ahvif = ath12k_vif_to_ahvif(tx_vif);
-	tx_arvif = &tx_ahvif->deflink;
+	tx_arvif = ath12k_mac_get_tx_arvif(arvif);
+	if (!tx_arvif)
+		return 0;
 
 	if (link_conf->nontransmitted) {
-		if (ar->ah->hw->wiphy != ieee80211_vif_to_wdev(tx_vif)->wiphy)
+		if (ath12k_ar_to_hw(ar)->wiphy !=
+		    ath12k_ar_to_hw(tx_arvif->ar)->wiphy)
 			return -EINVAL;
 
 		*flags = WMI_VDEV_MBSSID_FLAGS_NON_TRANSMIT_AP;
@@ -9071,9 +9079,9 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 			   int n_vifs)
 {
 	struct ath12k_wmi_vdev_up_params params = {};
+	struct ath12k_link_vif *arvif, *tx_arvif;
 	struct ieee80211_bss_conf *link_conf;
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_link_vif *arvif;
 	struct ieee80211_vif *vif;
 	struct ath12k_vif *ahvif;
 	u8 link_id;
@@ -9141,11 +9149,9 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 		params.vdev_id = arvif->vdev_id;
 		params.aid = ahvif->aid;
 		params.bssid = arvif->bssid;
-		if (vif->mbssid_tx_vif) {
-			struct ath12k_vif *tx_ahvif =
-				ath12k_vif_to_ahvif(vif->mbssid_tx_vif);
-			struct ath12k_link_vif *tx_arvif = &tx_ahvif->deflink;
 
+		tx_arvif = ath12k_mac_get_tx_arvif(arvif);
+		if (tx_arvif) {
 			params.tx_bssid = tx_arvif->bssid;
 			params.nontx_profile_idx = link_conf->bssid_index;
 			params.nontx_profile_cnt = 1 << link_conf->bssid_indicator;
-- 
2.34.1


