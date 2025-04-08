Return-Path: <linux-wireless+bounces-21279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73231A814E7
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 20:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293DA1BA7C94
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 18:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AB9241107;
	Tue,  8 Apr 2025 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GTNWXkjQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19D1217704
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744137910; cv=none; b=o6t0kJ4LaNqE4YhqC5Toasoo318ZK5YzJ4tZrOapnStMYPTYNCNw62kbNSwQujDLxoHnZpMeQMrcrMgEwSf9xM72UykaPWTgk3QLjLtYjYBBKgyKgB6Fv7ABUKcGDzCtxPm8NHxF7z0noPaMpskQ+jyDUDDyXvRRSlhNqB/TRqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744137910; c=relaxed/simple;
	bh=syHFjId8VHTFPnAv25x9djm7qq0JKYRBvacOoXPrrvY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H0WTNJnqoYQD8Snp+7+8cnLf85Tmc6SadktDFPS/SxmVGLESUDDzn3kxj8MidbMucPhvm32x1eTjIry7S7MmQTDEkq8FWiCMMKYUKEP3wLMFSqKs+TIU9iLt4MWqRuxiANliF7dzVQBzlFMU/4ihbFS7rutH0aZNrwWGXT0duxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GTNWXkjQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538B78TA008168
	for <linux-wireless@vger.kernel.org>; Tue, 8 Apr 2025 18:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=C+rkt+O/whA
	xBRt3fe3llX2/G76XT4W2u/reGxZ80m8=; b=GTNWXkjQRtB9KTZeLSv5LeebnRa
	qOBlhwigvo9/XOozCbEWiT4/oPsIk6BjXH27J+U3X3Lm0gAUvjpS6WqLWwZQ+pcw
	YE4uvto+85IOHv9YjdQ8GEg8Tig0mGIPbfjUPJVu94X5Z0E44bAgi9ftDUqP46wr
	ZVNHpBf4oJupFCR/nV9p97RClfhyE+jfOlxMSU4YT1/H+kfH2my6k8lDtyamjumk
	100AGp/yz+Wv8hjHl7+cqWzfN86y/4QD/RGtZ4mMU/cKuwgETtmt6V9SAzeSNNIL
	Q+RKmS7WA0HMlreowTv1pT6W1PF/PQm7Wdp+TEHD9VuiFN/Z4InIfe9A1VA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twtb0yfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 18:45:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff8a2c7912so4734927a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 11:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744137905; x=1744742705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+rkt+O/whAxBRt3fe3llX2/G76XT4W2u/reGxZ80m8=;
        b=rdxxpJaMqG6CR7nx/Oyv6WNxPG3YRvVlrKE76IUXQ6OrGkHksWG9+9F4PRSM45YMte
         Cxuj3vlO97wTzupv8msdcuuCDk2WqcSiAXq0YlzpiGQxtnomX+QhtRkSSvMvqhuG9YDK
         0Yy719jt9UzJJTl47Lps5UZtr9rcxBOmrRaIBBML0s07RZQ/Mh9D2wn48WSBrZyp4Cc5
         4PLlg6WdcaMXmJLYJxDbGuiRSvLX/YQLrz177dJ6xGwIeNRguF6k4w3iG2RTfgNYl11i
         C5nhZ34WGo7fXQX30txH9DNVgvWbAIqxOniXGV+o2DN0+aPDuaTRBUWA0Tak7WLgbzF/
         dXIA==
X-Gm-Message-State: AOJu0YxXeoz4YJMfgH+0AyJ7RVHknIJxEnDk1EL+EsSyuh8EC4xd+sE/
	B+1Qxkn6E+iuYOTJun5ODdGMe22LLXvhuEYNOtm4farIMZ5v0c4swYDBAhMqeRTL/eBI+kQXkdj
	KhKiTiWqxXErHLutxkrTGHQKPwmraT3YMNzR4rhhFcE/xpauE1QQYDKmbrgNUQFxG/wpwPsoLlw
	==
X-Gm-Gg: ASbGncssIWPO965dyn56gB8Fy2Lcy4YuL8Yz8WcGACy4RgPx2ND6nMTKbNBEw31wOkB
	CjuPPgxgxRJBD/dTY+2GXoD7qiPn7TIjyGAwE8P1IXvVr1cd5xUJOzhZe1ouWAD6dZ0lq3/T5Ej
	ZECd6/BSQ0nRy1JnRd6k/KLVHZW0znDbjaDBvRfs+/pFpahsECVC82zEf4GQnuUqjFFKv7FdZWn
	0Z8DkFPULgRgQlIqv7cE2FlP6mONPoKugfv5fjnoA8/88mPkvqiBHiHjDkEUavzFYjMsDbPcHzf
	XQj3Rkos+W1Ny8KR7ZLdQyuWv4Fe4YMfk8ckDQJHxnu4oVyBAqymsFI6JEv2XJW5Y8/7Dy8=
X-Received: by 2002:a17:90a:f944:b0:2ff:53d6:2b82 with SMTP id 98e67ed59e1d1-306d0d1d6e8mr6172351a91.11.1744137905289;
        Tue, 08 Apr 2025 11:45:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq2vjIj7N/n0y+l2ChpHZWdwrF9q19tRe7lt9VniGlfydGnTMCeQwD+qfr2VnNMUu+ZqcvKg==
X-Received: by 2002:a17:90a:f944:b0:2ff:53d6:2b82 with SMTP id 98e67ed59e1d1-306d0d1d6e8mr6172303a91.11.1744137904725;
        Tue, 08 Apr 2025 11:45:04 -0700 (PDT)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057cb9500dsm12882212a91.47.2025.04.08.11.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 11:45:04 -0700 (PDT)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        ath11k@lists.infradead.org
Subject: [PATCH wireless-next v5 2/3] wifi: mac80211: restructure tx profile retrieval for MLO MBSSID
Date: Tue,  8 Apr 2025 11:45:00 -0700
Message-Id: <20250408184501.3715887-3-aloka.dixit@oss.qualcomm.com>
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
X-Proofpoint-GUID: o1N2ugrfgYYl439EdQPL7EU3sEHdgGCT
X-Authority-Analysis: v=2.4 cv=LLlmQIW9 c=1 sm=1 tr=0 ts=67f56eb2 cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=X_0Cl_4B8EXWqmMzkNwA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: o1N2ugrfgYYl439EdQPL7EU3sEHdgGCT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_08,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080129

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
 drivers/net/wireless/ath/ath11k/mac.c         | 10 ++-
 drivers/net/wireless/ath/ath12k/mac.c         | 22 +++++-
 drivers/net/wireless/virtual/mac80211_hwsim.c |  7 +-
 include/net/mac80211.h                        |  7 +-
 net/mac80211/cfg.c                            | 64 ++++++++++------
 net/mac80211/ieee80211_i.h                    |  2 +
 net/mac80211/iface.c                          | 75 +++++++++++++------
 7 files changed, 130 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 97816916abac..8191ee14a1fd 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1531,8 +1531,14 @@ static int ath11k_mac_set_vif_params(struct ath11k_vif *arvif,
 
 static struct ath11k_vif *ath11k_mac_get_tx_arvif(struct ath11k_vif *arvif)
 {
-	if (arvif->vif->mbssid_tx_vif)
-		return ath11k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
+	struct ieee80211_bss_conf *link_conf, *tx_bss_conf;
+
+	lockdep_assert_wiphy(arvif->ar->hw->wiphy);
+
+	link_conf = &arvif->vif->bss_conf;
+	tx_bss_conf = wiphy_dereference(arvif->ar->hw->wiphy, link_conf->tx_bss_conf);
+	if (tx_bss_conf)
+		return ath11k_vif_to_arvif(tx_bss_conf->vif);
 
 	return NULL;
 }
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2b6bdc3d2b11..fe4a22362000 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -582,12 +582,26 @@ static int ath12k_mac_vif_link_chan(struct ieee80211_vif *vif, u8 link_id,
 
 static struct ath12k_link_vif *ath12k_mac_get_tx_arvif(struct ath12k_link_vif *arvif)
 {
+	struct ieee80211_bss_conf *link_conf, *tx_bss_conf;
+	struct ath12k *ar = arvif->ar;
 	struct ath12k_vif *tx_ahvif;
 
-	if (arvif->ahvif->vif->mbssid_tx_vif) {
-		tx_ahvif = ath12k_vif_to_ahvif(arvif->ahvif->vif->mbssid_tx_vif);
-		if (tx_ahvif)
-			return &tx_ahvif->deflink;
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	link_conf = ath12k_mac_get_link_bss_conf(arvif);
+	if (!link_conf) {
+		ath12k_warn(ar->ab,
+			    "unable to access bss link conf for link %u required to retrieve transmitting link conf\n",
+			    arvif->link_id);
+		return NULL;
+	}
+
+	tx_bss_conf = wiphy_dereference(ath12k_ar_to_hw(ar)->wiphy,
+					link_conf->tx_bss_conf);
+	if (tx_bss_conf) {
+		tx_ahvif = ath12k_vif_to_ahvif(tx_bss_conf->vif);
+		return wiphy_dereference(tx_ahvif->ah->hw->wiphy,
+					 tx_ahvif->link[tx_bss_conf->link_id]);
 	}
 
 	return NULL;
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index cf3e976471c6..74d037cfccca 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2273,7 +2273,7 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
 {
 	struct mac80211_hwsim_link_data *link_data = arg;
 	u32 link_id = link_data->link_id;
-	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_bss_conf *link_conf, *tx_bss_conf;
 	struct mac80211_hwsim_data *data =
 		container_of(link_data, struct mac80211_hwsim_data,
 			     link_data[link_id]);
@@ -2292,10 +2292,11 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
 	    vif->type != NL80211_IFTYPE_OCB)
 		return;
 
-	if (vif->mbssid_tx_vif && vif->mbssid_tx_vif != vif)
+	tx_bss_conf = rcu_access_pointer(link_conf->tx_bss_conf);
+	if (tx_bss_conf && tx_bss_conf != link_conf)
 		return;
 
-	if (vif->bss_conf.ema_ap) {
+	if (link_conf->ema_ap) {
 		struct ieee80211_ema_beacons *ema;
 		u8 i = 0;
 
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c498f685d01f..f7ceba974749 100644
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
index 9f683f838431..8d2ded7fecae 100644
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
@@ -4833,17 +4847,19 @@ ieee80211_color_change_bss_config_notify(struct ieee80211_link_data *link,
 
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
index fb05f3cd37ec..bbc8c2502862 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2795,6 +2795,8 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 
 void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 				      struct ieee80211_mgmt *mgmt, size_t len);
+void ieee80211_stop_mbssid(struct ieee80211_sub_if_data *sdata);
+
 #if IS_ENABLED(CONFIG_MAC80211_KUNIT_TEST)
 #define EXPORT_SYMBOL_IF_MAC80211_KUNIT(sym) EXPORT_SYMBOL_IF_KUNIT(sym)
 #define VISIBLE_IF_MAC80211_KUNIT
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index f0f4a250b10e..79a441f91c91 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -726,30 +726,59 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
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
+		/* If we are not tx sdata reset tx sdata's tx_bss_conf to avoid recusrion
+		 * while closing tx sdata at the end of outer loop below.
+		 */
+		if (sdata != tx_sdata) {
+			tx_link = sdata_dereference(tx_sdata->link[tx_bss_conf->link_id],
+						    tx_sdata);
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
+			cfg80211_stop_iface(link_sdata->wdev.wiphy, &link_sdata->wdev,
+					    GFP_KERNEL);
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
 
@@ -757,21 +786,25 @@ static int ieee80211_stop(struct net_device *dev)
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


