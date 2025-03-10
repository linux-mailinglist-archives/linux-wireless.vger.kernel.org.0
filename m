Return-Path: <linux-wireless+bounces-20119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F063A5A454
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 21:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F5018937D6
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 20:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A901D516F;
	Mon, 10 Mar 2025 20:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wooyv9uu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6576A1C5F1B
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636986; cv=none; b=hBov+POUt2/08fnqHTGxot1Y0AxMtr7BaUBs1OR1+N/TG1LtCmyPss7qWLO9xvRW2e9ozNFTOj3bvnUXl+1MfMd4doIWYTyaeXc5DOTPC0gzDKgpsEzZhMtpaPv2LlFG6hkIGGPBGKuGuhe7eIsny/ndMhvSwsfICMsd7v6wMY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636986; c=relaxed/simple;
	bh=pAJ5QKq30G3KiD0Sl+Cq+xTa5UngGfKmfAwe2Bfmgf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pg0gXNJrBUuxC+F4k919UhzQLngX1C8ZP5zj/pMDdkliB2S9+m4y4M0IpCcu4AFZTVU1Bva/9X1kttqjCVDcVdca0RY1IpWHa9CEa2mw4+lirTBhmO2FVjIoC5euT8FxReKtL3IkZqfCoMx1nvddw0lSCizwKDaeo9K2Ji0zLCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wooyv9uu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AJUfZr026807
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 20:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=S79CPSYbAlP
	EM+1hCV8/ZAXzHytaMLVa0S+9cZNXjHs=; b=Wooyv9uuDFPW23hVQUrC0SW7GvL
	rWsaOtGAuauF6RJV+iyzwRfCDz0kg1KxJNDTNO92TyQMjDC/wWQ7XTwuV9dxyzie
	zoc/QJN89tfs+qxGR0O9jDGitLVjCUJw/Fyb95mPhVaHsoC0Hb6o6uyOWU5R4ttP
	HOngnAWoLUKLw/0PD/8Yyz3BeZ2JYEGDmwbGbO2p9P9lzVeIwggaE3B4LDLOl3f5
	51BVMfnKucpZrixTQQ6pL9npH8YtU6+O2/Ne1BX7GNkfxtBNlakX2xodP7lw+51b
	+9DMW1pRD0KDtF7/5tgCnJg7MuCg6H9OBhOYF5NgiR+UqDu+ZO9pXVtlcjw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f0pwykp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 20:03:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-225505d1ca5so33117565ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 13:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741636963; x=1742241763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S79CPSYbAlPEM+1hCV8/ZAXzHytaMLVa0S+9cZNXjHs=;
        b=vY+Iwm/DF7yj3M54qRD0N0JB0Br1pINHDEr6UJ3os7c0Osc56KpNgGLQ4xO1d7CYzw
         uXXPVMGxzXa5W2AC6bZnc53lyVrk4lZJzXrwBHwdG9eAL8t6WSIDLzHVnlqrIlfwMla1
         WL6PLdcP/FvL9bZmwlNhlZciGVjXEp6hSoCbKdzlwML8wKkSzwBOIV6+5V39J+WlV9hl
         nkBL3t73qAwjKoDy0GzuAgpsXqbJLalRQBahNRcj5gsaQNk5zcKwrMUYtQiEh6FQ1EK7
         FmUy8p84rIorHXQjkmmZ4zIS366etqWOXowr4+jjM8/2+ynEtIlf6+mHqEeiAL7kbHmG
         Y1Jw==
X-Gm-Message-State: AOJu0YxrmRD2IKBzmfxT7VVOZCZjE6v0oUTcp2yZ4jGCHoscIPyB22mo
	vsuAtG7hWPJz4KggG/o3mEWWzDEpPTKeaspO9MgdudCgTTQnc0Ypm0V4OBQ7L+OfIcJROd5nW7U
	CAhIz5RAAYM1bLr742FU4+aJJgmMqLC9/QSCRrDy3aRr7bgTvohX+XNK+mbSaFLVTNml9C4g07w
	==
X-Gm-Gg: ASbGncukIRYZB5ftl/Qo51AxgZzd34o3lEb5afCngugaXnXljmk3AijTBJ8LaU1CGfQ
	ESAoOdmYtSEZjnrGRZ74+SnFOzLL5HdwXEmHVtnQNx0xUDme5DjB22lKTrVmhxWtsvu0vT03hFi
	85wOk4zJUT/XvUz9DWdbd9CGPwBw0BSCswedHxzEDgKMXQAfy8L3+PU6H7lsdjGNRiNjn6xEJSO
	w3He3wpNBYEGIq6bOgSzc8nUssbLRM3J0OL1D+ezjDYlHbNDn4WhS9w6iYQa0XB/5BB5NzGxR+y
	UVums0mgYBWc4eUXMhDn70nF5a6edtr7AmmYX7RCjRz3IKFbEsNatz2p/FLEx6+PDA3Lf5o=
X-Received: by 2002:a05:6a00:88f:b0:736:7270:4d18 with SMTP id d2e1a72fcca58-736eb7efd4amr1337209b3a.14.1741636963261;
        Mon, 10 Mar 2025 13:02:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXCq+vRnozdUctoKHLjwxtBxFPJeYy6YJ+VPqL2S9RbIQ2fVffLz0jTXfaYb2+hu27oRfGdw==
X-Received: by 2002:a05:6a00:88f:b0:736:7270:4d18 with SMTP id d2e1a72fcca58-736eb7efd4amr1337176b3a.14.1741636962731;
        Mon, 10 Mar 2025 13:02:42 -0700 (PDT)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736cbe3fb3fsm3730419b3a.83.2025.03.10.13.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:02:42 -0700 (PDT)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        ath11k@lists.infradead.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Muna Sinada <muna.sinada@oss.qualcomm.com>,
        Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v4 2/3] wifi: mac80211: restructure tx profile retrieval for MLO MBSSID
Date: Mon, 10 Mar 2025 13:02:36 -0700
Message-Id: <20250310200237.652950-3-aloka.dixit@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310200237.652950-1-aloka.dixit@oss.qualcomm.com>
References: <20250310200237.652950-1-aloka.dixit@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Iruq0BVvQsaX0d1dx3BH4t5JvXgy7keT
X-Authority-Analysis: v=2.4 cv=KK2gDEFo c=1 sm=1 tr=0 ts=67cf4577 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=X_0Cl_4B8EXWqmMzkNwA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: Iruq0BVvQsaX0d1dx3BH4t5JvXgy7keT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100155

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
 net/mac80211/iface.c                          | 73 +++++++++++++------
 7 files changed, 128 insertions(+), 57 deletions(-)

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
index dfa05f0ee6c9..84da77bf245b 100644
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
index d0d9dab7f11f..40866098b531 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2271,7 +2271,7 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
 {
 	struct mac80211_hwsim_link_data *link_data = arg;
 	u32 link_id = link_data->link_id;
-	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_bss_conf *link_conf, *tx_bss_conf;
 	struct mac80211_hwsim_data *data =
 		container_of(link_data, struct mac80211_hwsim_data,
 			     link_data[link_id]);
@@ -2290,10 +2290,11 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
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
index 09708a060bb7..eeaead57e556 100644
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
index 845888ac3d2c..68c6be894a28 100644
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
index 33c7c62d19f5..540fccb58c1f 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -726,30 +726,57 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
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
 
@@ -757,21 +784,25 @@ static int ieee80211_stop(struct net_device *dev)
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


