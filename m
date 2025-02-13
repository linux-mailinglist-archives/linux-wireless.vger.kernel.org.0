Return-Path: <linux-wireless+bounces-18949-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE42A351A3
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 23:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3295E3AD018
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 22:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E1522D7AE;
	Thu, 13 Feb 2025 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pe0VNrEq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527632753FE
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 22:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487048; cv=none; b=eveLNuYZ7yEtnAeCL3LAhl27oGMYyP+C20TvMKdIIoL/AW4qRSEMPncChMw2EY2N4u27QQdUTpQvruQM8P1Yj5VViLjfyUCs7En4q0+gU1jkEKy5nwDgpDL24MxxvEfcZOdfRYUMHwufhJQlg8Z4xTd+T8P0nP92u6SQrqFtCkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487048; c=relaxed/simple;
	bh=9Bi1ieSTZsLNhXT7LoinI5BBLV1rLC7hgE/SXTBnlFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WFH6wTom1GrnbtsQgN0ApU1J9UOsYejbsXKrqGpb+cAOCIW67BRKvVjy1GCUFUGsMfTUhAIAVyYlqIdU8nnBSY/QG1Otv72VjrUUVkf3hoNyD/EbgV8wbflXn5E6wmgxeHFdSIp0s/MBgw4AtvpgLOgQ3ZLJMxryJsbswKt51WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pe0VNrEq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DLvfxg015693
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 22:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kVprryafmpL
	Bl0RdThZDeU8bUoRivnxkvDcPyZhYqD8=; b=pe0VNrEq2yWRzhak0c8jpVCvoBD
	xsh6bf4Kzqr/1rrxS0U8KfNe5H9PHFVvFM/Qqti4hyXkWTdjjMepLOV+7S6Peuth
	QqI4GohS/1IhbBkRjEwy+LyQJkrrOZJ+2qTBa6AvS6UnlQCd0jTrqB45708JBnT1
	2s4bHWawIjtD7a8hJIojU/Dug6d3d3HOc4RxwNQFJ4BYaC3zp9gaBUYu3SKjcSCK
	mF1MWaWj49na8G6NvwFa8bsmCxQkuq4NES65pQKnkcjHQdmR5qEDcUU1cQrTFA9R
	gnt/0FuF85ThmuBlZNRtPC4vUWWZ+2BM18xSi6j+JQt2jP7DCrYofoMoznA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44rgpgpgp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 22:50:44 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-220cb5924a4so46383245ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 14:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739487044; x=1740091844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVprryafmpLBl0RdThZDeU8bUoRivnxkvDcPyZhYqD8=;
        b=hUd0GYkFCymzVl1DAzA6EGWZLr6apuDFR3dIvtxTF3+29ZMA1o2LyZu35FuL99X1Ip
         O5FDqDc3NCA8euAl2CZtNZ0j99K2V50xhPfbP03W3tv4ZXIaPWa/+dIxGJwuss3RXboZ
         FeORkqpY88/y2LvuOV70eV0JH/i+6zW4Jxxcc+PhOE38YhMLL5qb11D8XHx0Gamoxeew
         9IQEHgE0KGMxJQmeFJ0ID4lMD8nhi3REilUkNDnAdxPR02LBlKhdYxw9MnJlElxSqPRI
         p0BQeMmj4hb8oCMOQ9jEwYn5+j53gR2RQcyHPrxHQmdNIO6E5z9SrC/BEE1Y1lWmYpbG
         CEtg==
X-Forwarded-Encrypted: i=1; AJvYcCVSsL52bRM/yBFHVvGyLEtedCqWwn93EdLTg6cg1WhEm3Hu9Zx4RFdxGDTX28t4Otg65Tqqn7VJYmSXsICNCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLSsvLmfqWhD6yxlg2xcJwkSu/bzScedyLb8yzJfXK6pSnQRAa
	vftjN+LudSjnMPGmEbw3se8LKsObxJwqpX/Tw2MzEeSJF+fQtr13zf5N3jEXyyrc34JXV/F6nbT
	QR7y8KvCDbg3KRtVzPLSFHJbPq76EtXN+TQd/n6AYfk9BWnE+YjosZOANNz4Yrdrxog==
X-Gm-Gg: ASbGnctIoK+nyKaCOVrGnqM32qMwWedbUjCTYdJHcwgh43EXO5dVePlwtbydAHu+aE6
	pMSjuRyMnZ0bj3jHGneSmBezZh9kVGWgEYSnf5s+OVoENuobw8xBxYiYEuCqn7XTjBPBSPlf92J
	Zs2mWquRGKpPK9xgh9lJ3foYGo4hZyHIzHCCb6OZIe592ta94i8aOGKnI7t19haGlq36BIC+goC
	9/LIi+Yum95k0s1vTQPO0Z6TdE7Z1AVgiiF3/tiAsKvEC4AjOiE8zNtLEv5/P+R7ygqgvDGkMzW
	SXtZ40fnhrt9Te00bfrd14JHSrkT+PlFoVnhmRbWCm1bohbHHF0pNXgAE7Un
X-Received: by 2002:a17:902:f60b:b0:21f:564:80a4 with SMTP id d9443c01a7336-220d213318emr78593525ad.33.1739487043519;
        Thu, 13 Feb 2025 14:50:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWKTFGmHIE8HinG8Y6dQ8qjUC7V9koi8zD9s+lsf22W7d4CuCu2lMUiiAikl/wxRCQQvTNAA==
X-Received: by 2002:a17:902:f60b:b0:21f:564:80a4 with SMTP id d9443c01a7336-220d213318emr78593105ad.33.1739487042979;
        Thu, 13 Feb 2025 14:50:42 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55916c7sm17571665ad.243.2025.02.13.14.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:50:42 -0800 (PST)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Muna Sinada <muna.sinada@oss.qualcomm.com>,
        Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v3 2/3] wifi: mac80211: restructure tx profile retrieval for MLO MBSSID
Date: Thu, 13 Feb 2025 14:50:35 -0800
Message-Id: <20250213225036.3118133-3-aloka.dixit@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213225036.3118133-1-aloka.dixit@oss.qualcomm.com>
References: <20250213225036.3118133-1-aloka.dixit@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xdQ2Vrll3-BNKsYV56Sd5gP_0rr_Uakw
X-Proofpoint-GUID: xdQ2Vrll3-BNKsYV56Sd5gP_0rr_Uakw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502130160

From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

For MBSSID, each vif (struct ieee80211_vif) stores another vif
pointer for the transmitting profile of MBSSID set. This won't
suffice for MLO as there may be multiple links, each of which can
be part of different MBSSID sets. Hence the information needs to
be stored per-link. Additionally, the transmitted profile itself
may be part of an MLD hence storing vif will not suffice either.
Fix MLO by storing an instance of struct ieee80211_bss_conf
for each link.

Modify following operations to reflect the above structure updates:
- channel switch completion
- BSS color change completion
- Removing nontransmitted links in ieee80211_stop_mbssid()
- drivers retrieving the transmitted link for beacon templates.

Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Co-developed-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
Co-developed-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/mac.c         | 20 +++--
 drivers/net/wireless/ath/ath12k/mac.c         | 33 ++++++---
 drivers/net/wireless/virtual/mac80211_hwsim.c |  2 +-
 include/net/mac80211.h                        |  7 +-
 net/mac80211/cfg.c                            | 64 ++++++++++------
 net/mac80211/ieee80211_i.h                    |  2 +
 net/mac80211/iface.c                          | 73 +++++++++++++------
 7 files changed, 136 insertions(+), 65 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 3a0bdede41fc..69155989a87b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1529,10 +1529,16 @@ static int ath11k_mac_set_vif_params(struct ath11k_vif *arvif,
 	return ret;
 }
 
-static struct ath11k_vif *ath11k_mac_get_tx_arvif(struct ath11k_vif *arvif)
+static struct ath11k_vif *ath11k_mac_get_tx_arvif(struct ath11k_vif *arvif,
+						  struct ieee80211_bss_conf *link_conf)
 {
-	if (arvif->vif->mbssid_tx_vif)
-		return ath11k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
+	struct ieee80211_bss_conf *tx_bss_conf;
+
+	lockdep_assert_wiphy(arvif->ar->hw->wiphy);
+
+	tx_bss_conf = wiphy_dereference(arvif->ar->hw->wiphy, link_conf->tx_bss_conf);
+	if (tx_bss_conf)
+		return ath11k_vif_to_arvif(tx_bss_conf->vif);
 
 	return NULL;
 }
@@ -1643,7 +1649,7 @@ static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
 	/* Target does not expect beacon templates for the already up
 	 * non-transmitting interfaces, and results in a crash if sent.
 	 */
-	tx_arvif = ath11k_mac_get_tx_arvif(arvif);
+	tx_arvif = ath11k_mac_get_tx_arvif(arvif, &vif->bss_conf);
 	if (tx_arvif) {
 		if (arvif != tx_arvif && arvif->is_up)
 			return 0;
@@ -1709,7 +1715,7 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 
 	ether_addr_copy(arvif->bssid, info->bssid);
 
-	tx_arvif = ath11k_mac_get_tx_arvif(arvif);
+	tx_arvif = ath11k_mac_get_tx_arvif(arvif, &arvif->vif->bss_conf);
 	ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
 				 arvif->bssid,
 				 tx_arvif ? tx_arvif->bssid : NULL,
@@ -6338,7 +6344,7 @@ static int ath11k_mac_setup_vdev_params_mbssid(struct ath11k_vif *arvif,
 	struct ath11k_vif *tx_arvif;
 
 	*tx_vdev_id = 0;
-	tx_arvif = ath11k_mac_get_tx_arvif(arvif);
+	tx_arvif = ath11k_mac_get_tx_arvif(arvif, &arvif->vif->bss_conf);
 	if (!tx_arvif) {
 		*flags = WMI_HOST_VDEV_FLAGS_NON_MBSSID_AP;
 		return 0;
@@ -7363,7 +7369,7 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 			ath11k_warn(ab, "failed to update bcn tmpl during csa: %d\n",
 				    ret);
 
-		tx_arvif = ath11k_mac_get_tx_arvif(arvif);
+		tx_arvif = ath11k_mac_get_tx_arvif(arvif, &arvif->vif->bss_conf);
 		ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
 					 arvif->bssid,
 					 tx_arvif ? tx_arvif->bssid : NULL,
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 05a0a6f0dc9b..cc25665fecc8 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -502,14 +502,21 @@ static int ath12k_mac_vif_link_chan(struct ieee80211_vif *vif, u8 link_id,
 	return 0;
 }
 
-static struct ath12k_link_vif *ath12k_mac_get_tx_arvif(struct ath12k_link_vif *arvif)
+static struct ath12k_link_vif *
+ath12k_mac_get_tx_arvif(struct ath12k_link_vif *arvif,
+			struct ieee80211_bss_conf *link_conf)
 {
+	struct ieee80211_bss_conf *tx_bss_conf;
 	struct ath12k_vif *tx_ahvif;
 
-	if (arvif->ahvif->vif->mbssid_tx_vif) {
-		tx_ahvif = ath12k_vif_to_ahvif(arvif->ahvif->vif->mbssid_tx_vif);
-		if (tx_ahvif)
-			return &tx_ahvif->deflink;
+	lockdep_assert_wiphy(ath12k_ar_to_hw(arvif->ar)->wiphy);
+
+	tx_bss_conf = wiphy_dereference(ath12k_ar_to_hw(arvif->ar)->wiphy,
+					link_conf->tx_bss_conf);
+	if (tx_bss_conf) {
+		tx_ahvif = ath12k_vif_to_ahvif(tx_bss_conf->vif);
+		return wiphy_dereference(tx_ahvif->ah->hw->wiphy,
+					 tx_ahvif->link[tx_bss_conf->link_id]);
 	}
 
 	return NULL;
@@ -1635,7 +1642,7 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_link_vif *arvif)
 		return -ENOLINK;
 	}
 
-	tx_arvif = ath12k_mac_get_tx_arvif(arvif);
+	tx_arvif = ath12k_mac_get_tx_arvif(arvif, link_conf);
 	if (tx_arvif) {
 		if (tx_arvif != arvif && arvif->is_up)
 			return 0;
@@ -1707,6 +1714,7 @@ static void ath12k_control_beaconing(struct ath12k_link_vif *arvif,
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ath12k_link_vif *tx_arvif;
 	struct ath12k *ar = arvif->ar;
+	struct ieee80211_bss_conf *link_conf;
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(arvif->ar)->wiphy);
@@ -1737,7 +1745,14 @@ static void ath12k_control_beaconing(struct ath12k_link_vif *arvif,
 	params.aid = ahvif->aid;
 	params.bssid = arvif->bssid;
 
-	tx_arvif = ath12k_mac_get_tx_arvif(arvif);
+	link_conf = ath12k_mac_get_link_bss_conf(arvif);
+	if (!link_conf) {
+		ath12k_warn(ar->ab, "unable to access bss link conf to set vdev up params for vif %pM link %u\n",
+			    ahvif->vif->addr, arvif->link_id);
+		return;
+	}
+
+	tx_arvif = ath12k_mac_get_tx_arvif(arvif, link_conf);
 	if (tx_arvif) {
 		params.tx_bssid = tx_arvif->bssid;
 		params.nontx_profile_idx = info->bssid_index;
@@ -7574,7 +7589,7 @@ static int ath12k_mac_setup_vdev_params_mbssid(struct ath12k_link_vif *arvif,
 		return -ENOLINK;
 	}
 
-	tx_arvif = ath12k_mac_get_tx_arvif(arvif);
+	tx_arvif = ath12k_mac_get_tx_arvif(arvif, link_conf);
 	if (!tx_arvif)
 		return 0;
 
@@ -9052,7 +9067,7 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 		params.aid = ahvif->aid;
 		params.bssid = arvif->bssid;
 
-		tx_arvif = ath12k_mac_get_tx_arvif(arvif);
+		tx_arvif = ath12k_mac_get_tx_arvif(arvif, link_conf);
 		if (tx_arvif) {
 			params.tx_bssid = tx_arvif->bssid;
 			params.nontx_profile_idx = link_conf->bssid_index;
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index d0d9dab7f11f..8facbc050dc7 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2290,7 +2290,7 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
 	    vif->type != NL80211_IFTYPE_OCB)
 		return;
 
-	if (vif->mbssid_tx_vif && vif->mbssid_tx_vif != vif)
+	if (rcu_access_pointer(link_conf->mbssid_tx_bss) != link_conf)
 		return;
 
 	if (vif->bss_conf.ema_ap) {
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 22d32419e8a0..d47faf56a515 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -682,6 +682,9 @@ struct ieee80211_parsed_tpe {
  *	responder functionality.
  * @ftmr_params: configurable lci/civic parameter when enabling FTM responder.
  * @nontransmitted: this BSS is a nontransmitted BSS profile
+ * @tx_bss_conf: Pointer to the BSS configuration of transmitting interface
+ *	if MBSSID is enabled. This pointer is RCU-protected due to CSA finish
+ *	and BSS color change flows accessing it.
  * @transmitter_bssid: the address of transmitter AP
  * @bssid_index: index inside the multiple BSSID set
  * @bssid_indicator: 2^bssid_indicator is the maximum number of APs in set
@@ -804,6 +807,7 @@ struct ieee80211_bss_conf {
 	struct ieee80211_ftm_responder_params *ftmr_params;
 	/* Multiple BSSID data */
 	bool nontransmitted;
+	struct ieee80211_bss_conf __rcu *tx_bss_conf;
 	u8 transmitter_bssid[ETH_ALEN];
 	u8 bssid_index;
 	u8 bssid_indicator;
@@ -2023,7 +2027,6 @@ enum ieee80211_neg_ttlm_res {
  * @txq: the multicast data TX queue
  * @offload_flags: 802.3 -> 802.11 enapsulation offload flags, see
  *	&enum ieee80211_offload_flags.
- * @mbssid_tx_vif: Pointer to the transmitting interface if MBSSID is enabled.
  */
 struct ieee80211_vif {
 	enum nl80211_iftype type;
@@ -2052,8 +2055,6 @@ struct ieee80211_vif {
 	bool probe_req_reg;
 	bool rx_mcast_action_reg;
 
-	struct ieee80211_vif *mbssid_tx_vif;
-
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 5785fe30adaa..e54cfc25db04 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -146,8 +146,8 @@ static int ieee80211_set_ap_mbssid_options(struct ieee80211_sub_if_data *sdata,
 					   struct ieee80211_bss_conf *link_conf)
 {
 	struct ieee80211_sub_if_data *tx_sdata;
+	struct ieee80211_bss_conf *old;
 
-	sdata->vif.mbssid_tx_vif = NULL;
 	link_conf->bssid_index = 0;
 	link_conf->nontransmitted = false;
 	link_conf->ema_ap = false;
@@ -156,14 +156,26 @@ static int ieee80211_set_ap_mbssid_options(struct ieee80211_sub_if_data *sdata,
 	if (sdata->vif.type != NL80211_IFTYPE_AP || !params->tx_wdev)
 		return -EINVAL;
 
+	old = sdata_dereference(link_conf->tx_bss_conf, sdata);
+	if (old)
+		return -EALREADY;
+
 	tx_sdata = IEEE80211_WDEV_TO_SUB_IF(params->tx_wdev);
 	if (!tx_sdata)
 		return -EINVAL;
 
 	if (tx_sdata == sdata) {
-		sdata->vif.mbssid_tx_vif = &sdata->vif;
+		rcu_assign_pointer(link_conf->tx_bss_conf, link_conf);
 	} else {
-		sdata->vif.mbssid_tx_vif = &tx_sdata->vif;
+		struct ieee80211_bss_conf *tx_bss_conf;
+
+		tx_bss_conf = sdata_dereference(tx_sdata->vif.link_conf[params->tx_link_id],
+						sdata);
+		if (rcu_access_pointer(tx_bss_conf->tx_bss_conf) != tx_bss_conf)
+			return -EINVAL;
+
+		rcu_assign_pointer(link_conf->tx_bss_conf, tx_bss_conf);
+
 		link_conf->nontransmitted = true;
 		link_conf->bssid_index = params->index;
 	}
@@ -1669,7 +1681,6 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	kfree(link_conf->ftmr_params);
 	link_conf->ftmr_params = NULL;
 
-	sdata->vif.mbssid_tx_vif = NULL;
 	link_conf->bssid_index = 0;
 	link_conf->nontransmitted = false;
 	link_conf->ema_ap = false;
@@ -1683,6 +1694,9 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 		ieee80211_free_key_list(local, &keys);
 	}
 
+	ieee80211_stop_mbssid(sdata);
+	RCU_INIT_POINTER(link_conf->tx_bss_conf, NULL);
+
 	link_conf->enable_beacon = false;
 	sdata->beacon_rate_set = false;
 	sdata->vif.cfg.ssid_len = 0;
@@ -3700,6 +3714,7 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_bss_conf *tx_bss_conf;
 	struct ieee80211_link_data *link_data;
 
 	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
@@ -3713,25 +3728,24 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id)
 		return;
 	}
 
-	/* TODO: MBSSID with MLO changes */
-	if (vif->mbssid_tx_vif == vif) {
+	tx_bss_conf = rcu_dereference(link_data->conf->tx_bss_conf);
+	if (tx_bss_conf == link_data->conf) {
 		/* Trigger ieee80211_csa_finish() on the non-transmitting
 		 * interfaces when channel switch is received on
 		 * transmitting interface
 		 */
-		struct ieee80211_sub_if_data *iter;
-
-		list_for_each_entry_rcu(iter, &local->interfaces, list) {
-			if (!ieee80211_sdata_running(iter))
-				continue;
+		struct ieee80211_link_data *iter;
 
-			if (iter == sdata || iter->vif.mbssid_tx_vif != vif)
+		for_each_sdata_link(local, iter) {
+			if (iter->sdata == sdata ||
+			    rcu_access_pointer(iter->conf->tx_bss_conf) != tx_bss_conf)
 				continue;
 
-			wiphy_work_queue(iter->local->hw.wiphy,
-					 &iter->deflink.csa.finalize_work);
+			wiphy_work_queue(iter->sdata->local->hw.wiphy,
+					 &iter->csa.finalize_work);
 		}
 	}
+
 	wiphy_work_queue(local->hw.wiphy, &link_data->csa.finalize_work);
 
 	rcu_read_unlock();
@@ -4834,17 +4848,19 @@ ieee80211_color_change_bss_config_notify(struct ieee80211_link_data *link,
 
 	ieee80211_link_info_change_notify(sdata, link, changed);
 
-	if (!sdata->vif.bss_conf.nontransmitted && sdata->vif.mbssid_tx_vif) {
-		struct ieee80211_sub_if_data *child;
+	if (!link->conf->nontransmitted &&
+	    rcu_access_pointer(link->conf->tx_bss_conf)) {
+		struct ieee80211_link_data *tmp;
 
-		list_for_each_entry(child, &sdata->local->interfaces, list) {
-			if (child != sdata && child->vif.mbssid_tx_vif == &sdata->vif) {
-				child->vif.bss_conf.he_bss_color.color = color;
-				child->vif.bss_conf.he_bss_color.enabled = enable;
-				ieee80211_link_info_change_notify(child,
-								  &child->deflink,
-								  BSS_CHANGED_HE_BSS_COLOR);
-			}
+		for_each_sdata_link(sdata->local, tmp) {
+			if (tmp->sdata == sdata ||
+			    rcu_access_pointer(tmp->conf->tx_bss_conf) != link->conf)
+				continue;
+
+			tmp->conf->he_bss_color.color = color;
+			tmp->conf->he_bss_color.enabled = enable;
+			ieee80211_link_info_change_notify(tmp->sdata, tmp,
+							  BSS_CHANGED_HE_BSS_COLOR);
 		}
 	}
 }
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index f23be8b5d0d8..7bb739abc5e4 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2794,6 +2794,8 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 
 void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 				      struct ieee80211_mgmt *mgmt, size_t len);
+void ieee80211_stop_mbssid(struct ieee80211_sub_if_data *sdata);
+
 #if IS_ENABLED(CONFIG_MAC80211_KUNIT_TEST)
 #define EXPORT_SYMBOL_IF_MAC80211_KUNIT(sym) EXPORT_SYMBOL_IF_KUNIT(sym)
 #define VISIBLE_IF_MAC80211_KUNIT
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index d8b14ba95ae2..8e4c34e40688 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -724,30 +724,57 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 		ieee80211_add_virtual_monitor(local);
 }
 
-static void ieee80211_stop_mbssid(struct ieee80211_sub_if_data *sdata)
+void ieee80211_stop_mbssid(struct ieee80211_sub_if_data *sdata)
 {
-	struct ieee80211_sub_if_data *tx_sdata, *non_tx_sdata, *tmp_sdata;
-	struct ieee80211_vif *tx_vif = sdata->vif.mbssid_tx_vif;
+	struct ieee80211_sub_if_data *tx_sdata;
+	struct ieee80211_bss_conf *link_conf, *tx_bss_conf;
+	struct ieee80211_link_data *tx_link, *link;
+	unsigned int link_id;
 
-	if (!tx_vif)
-		return;
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
+	/* Check if any of the links of current sdata is an MBSSID. */
+	for_each_vif_active_link(&sdata->vif, link_conf, link_id) {
+		tx_bss_conf = sdata_dereference(link_conf->tx_bss_conf, sdata);
+		if (!tx_bss_conf)
+			continue;
 
-	tx_sdata = vif_to_sdata(tx_vif);
-	sdata->vif.mbssid_tx_vif = NULL;
+		tx_sdata = vif_to_sdata(tx_bss_conf->vif);
+		RCU_INIT_POINTER(link_conf->tx_bss_conf, NULL);
 
-	list_for_each_entry_safe(non_tx_sdata, tmp_sdata,
-				 &tx_sdata->local->interfaces, list) {
-		if (non_tx_sdata != sdata && non_tx_sdata != tx_sdata &&
-		    non_tx_sdata->vif.mbssid_tx_vif == tx_vif &&
-		    ieee80211_sdata_running(non_tx_sdata)) {
-			non_tx_sdata->vif.mbssid_tx_vif = NULL;
-			dev_close(non_tx_sdata->wdev.netdev);
+		/* If we are not tx sdata reset tx sdata's tx_bss_conf to avoid recusrion while
+		 * closing tx sdata at the end of outer loop below.
+		 */
+		if (sdata != tx_sdata) {
+			tx_link = sdata_dereference(tx_sdata->link[tx_bss_conf->link_id], tx_sdata);
+			if (!tx_link)
+				continue;
+
+			RCU_INIT_POINTER(tx_link->conf->tx_bss_conf, NULL);
+		}
+
+		/* loop through sdatas to find if any of their links
+		 * belong to same MBSSID set as the one getting deleted.
+		 */
+		for_each_sdata_link(tx_sdata->local, link) {
+			struct ieee80211_sub_if_data *link_sdata = link->sdata;
+
+			if (link_sdata == sdata || link_sdata == tx_sdata ||
+			    rcu_access_pointer(link->conf->tx_bss_conf) != tx_bss_conf)
+				continue;
+
+			RCU_INIT_POINTER(link->conf->tx_bss_conf, NULL);
+
+			/* Remove all links of matching MLD until dynamic link
+			 * removal can be supported.
+			 */
+			cfg80211_stop_iface(link_sdata->wdev.wiphy, &link_sdata->wdev, GFP_KERNEL);
 		}
-	}
 
-	if (sdata != tx_sdata && ieee80211_sdata_running(tx_sdata)) {
-		tx_sdata->vif.mbssid_tx_vif = NULL;
-		dev_close(tx_sdata->wdev.netdev);
+		/* If we are not tx sdata, remove links of tx sdata and proceed */
+		if (sdata != tx_sdata && ieee80211_sdata_running(tx_sdata))
+			cfg80211_stop_iface(tx_sdata->wdev.wiphy,
+					    &tx_sdata->wdev, GFP_KERNEL);
 	}
 }
 
@@ -755,21 +782,25 @@ static int ieee80211_stop(struct net_device *dev)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 
-	/* close dependent VLAN and MBSSID interfaces before locking wiphy */
+	/* close dependent VLAN interfaces before locking wiphy */
 	if (sdata->vif.type == NL80211_IFTYPE_AP) {
 		struct ieee80211_sub_if_data *vlan, *tmpsdata;
 
 		list_for_each_entry_safe(vlan, tmpsdata, &sdata->u.ap.vlans,
 					 u.vlan.list)
 			dev_close(vlan->dev);
-
-		ieee80211_stop_mbssid(sdata);
 	}
 
 	guard(wiphy)(sdata->local->hw.wiphy);
 
 	wiphy_work_cancel(sdata->local->hw.wiphy, &sdata->activate_links_work);
 
+	/* Close the dependent MBSSID interfaces with wiphy lock as we may be
+	 * terminating its partner links too in case of MLD.
+	 */
+	if (sdata->vif.type == NL80211_IFTYPE_AP)
+		ieee80211_stop_mbssid(sdata);
+
 	ieee80211_do_stop(sdata, true);
 
 	return 0;
-- 
2.34.1


