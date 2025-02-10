Return-Path: <linux-wireless+bounces-18724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C1CA2F700
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 19:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436FB3A639A
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 18:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE0B255E59;
	Mon, 10 Feb 2025 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ngL4R8SX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40D420487F
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212045; cv=none; b=axN6dzVOicpGX1hF9+xFkNaviLkXsDgLldRoqdHTLeij6gljOpCfoHPeuH+matWAeNsV/zbgQGbmRpkuWHZUndAnmBDZs5GYJJKrU+GDKWDVt0JuJEA2pn/FxN6otLlit6FOQSESqMbRsJqit0TivsQq2HpEUyT4fr3MqLegw24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212045; c=relaxed/simple;
	bh=dD0f2L69r4lbNnT1O9ztNGnNGcxMHFEl6sZEUfN1vx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uqxhwqmNADkGcoPK9Q37mRGpfwugZchTa80sZgJ54UFAj4kkUXpsuyMxofa+X1Mr9RzH+IP4T3nha5cwNvcxfcPbXJoQN2Id35EDntnOs3o0KpuFkGxLko8lsWRZIvNrXGjyObq/zhzphR6BfyYaPVK2MGT2xXMPSnTB2EIR3dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ngL4R8SX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AFq10j015701
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 18:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YS0ZCnpU003
	2ewMQjAnzpro93E+rCTYfGMOjixjaM4E=; b=ngL4R8SX4Hox42L9fRtmpEBk7Pw
	ew3bMpKK8K42VXh8+t766HoAtis1WN2ZDsWG7YwWLzWpWO9Btq9jQJA1jwgEAk5U
	cczpLuh+KHbdI0qoTUDgMdjc8v6n1ak8n/0AcbhwtvRWoMjUpYutmgfLyGN/9XEW
	/QAMKtQQiTyp6a07ze6ptDBjsk2P5nfSPBCHjrOfTy68RO3ALPHEGwSLI87YDquW
	TXxaRNT+a4gdX+W9Yf6fjI0mgqSO53D+igzOydHy2aXEITKYFV7Dj8a7Pao+Z1st
	9JEuTVIJODOfSfraZxAUtqNsTY3baGWZ8BtBK70QM/5mRsrqvXUAO9A58Sg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qe6nskc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 18:27:23 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2f816a85facso10100397a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 10:27:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739212042; x=1739816842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YS0ZCnpU0032ewMQjAnzpro93E+rCTYfGMOjixjaM4E=;
        b=vscXE35Ar/BBRZVI2AIoC/yUSU0+hMXF9OSGlvqzl/uZEFeyzSrHF4P1R+FHt/ivmO
         4Fc2B+C3beqRFdw5xWXsPOEVnhDFC7Z5rPx6644n8S0y+i6jFXatczxMzOka4Fe0t75x
         m/9QKl+OkksSxZZedtF5b+FnxsY1kaNSNTAnNkWkpfshN1+uSlEmlLwAdG53YKx5Gn3x
         ue8gVI+jmCNyHtvpHpQ6UDHyLZF+AmjD2EXTF0gGOcCE+C5003SJqNgCOZGpz01x0gIz
         Hj6RD9Mp85Xudlz+eaLcD2xnpXaWa2vxKnw7txkSexszQjklee7oGotCW4Z+g75Dycut
         AHNw==
X-Forwarded-Encrypted: i=1; AJvYcCX8fJ7S1Ie9FRqXYx4oi1/RTMOth7TUWs+LyK5zBYc2pOcCyi7CcH6+4NC5Kr9ArFds5n2OV7Bpzh/ulN68YQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxK5VhEeIquZk3FeJbyIBdyqJdtnaaCY1aPEgd3u2d493aXrhUt
	zqmI1zS6qeVrQvuse63N3hsz3vTBtJsCVWAOVDuO5npe09gkcptELGDO9xuaiFS8vKW9fOSiSb9
	i1qT5KnahBWcba0PfDKKCiIbYeckfzHr9CZMAa6GvVugT8x+pMCZDPw8vrbiWbq36sbP4LGqD3A
	==
X-Gm-Gg: ASbGnctoFJOTcLv4GEF7wtf3PFbZmGSLgLL7RS06W/jFgeGk7Ld6f5XEKhbhXNGOeRj
	EJH+9nlCur4pD1wNc8Se9otTuww5atAunc8bX3T5oJk/NS4NV7iAfMZMu7DdTGMAwIHHsFPCVgz
	B9zWSBnX/MjcgBQVTPtLwfolOUuLt82lVloNDq/5OML0c1u4hpNs8tqFg+vgWPl8pAe7v99nf6u
	BxzOXUb0rA57Q+ISkAFQn8JOjLdEnTJbO/0lxQdtY9ojrK152vF79jGsnXiC9duE6U6Fmx3k8oC
	ubVWGj01ox5sl2E2Ws5sdvYmc9YSOH68cU88lndE/BCrLoliQ+y6NSWinLaO
X-Received: by 2002:a05:6a21:1394:b0:1ed:a4ae:3b80 with SMTP id adf61e73a8af0-1ee03a23e9dmr24386868637.6.1739212042046;
        Mon, 10 Feb 2025 10:27:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjy5laiiBdq36IQJpPuZtXJaWXF9jBvHkUSZ40R6JY7aV8/MptL4xA8ZePCFex81rCp7YnZw==
X-Received: by 2002:a05:6a21:1394:b0:1ed:a4ae:3b80 with SMTP id adf61e73a8af0-1ee03a23e9dmr24386805637.6.1739212041491;
        Mon, 10 Feb 2025 10:27:21 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae8e83sm7948372b3a.84.2025.02.10.10.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:27:21 -0800 (PST)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v4 1/5] wifi: ath11k: refactor transmitted arvif retrieval
Date: Mon, 10 Feb 2025 10:27:14 -0800
Message-Id: <20250210182718.408891-2-aloka.dixit@oss.qualcomm.com>
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
X-Proofpoint-GUID: rfSZqdbnvPxHgwRTZW3B1HCTEimm0qNF
X-Proofpoint-ORIG-GUID: rfSZqdbnvPxHgwRTZW3B1HCTEimm0qNF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_10,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 mlxlogscore=939 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502100149

Create a new function ath11k_mac_get_tx_arvif() to retrieve 'arvif'
for the transmitted interface of the MBSSID set. This will help
modifying the same code path to reflect mac80211 data structure
changes to support MLO. This also fixes an issue in
ath11k_mac_update_vif_chan() where tx_arvif is not reset to NULL
inside for loop during each iteration. Compile tested only.

Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 53 +++++++++++++--------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 14ed53836589..466a314b938b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1529,6 +1529,14 @@ static int ath11k_mac_set_vif_params(struct ath11k_vif *arvif,
 	return ret;
 }
 
+static struct ath11k_vif *ath11k_mac_get_tx_arvif(struct ath11k_vif *arvif)
+{
+	if (arvif->vif->mbssid_tx_vif)
+		return ath11k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
+
+	return NULL;
+}
+
 static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
 {
 	struct ath11k_vif *tx_arvif;
@@ -1538,7 +1546,7 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
 	u32 params = 0;
 	u8 i = 0;
 
-	tx_arvif = ath11k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
+	tx_arvif = ath11k_mac_get_tx_arvif(arvif);
 
 	beacons = ieee80211_beacon_get_template_ema_list(tx_arvif->ar->hw,
 							 tx_arvif->vif, 0);
@@ -1589,21 +1597,21 @@ static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif)
 {
 	struct ath11k *ar = arvif->ar;
 	struct ath11k_base *ab = ar->ab;
-	struct ath11k_vif *tx_arvif = arvif;
+	struct ath11k_vif *tx_arvif;
 	struct ieee80211_hw *hw = ar->hw;
 	struct ieee80211_vif *vif = arvif->vif;
 	struct ieee80211_mutable_offsets offs = {};
 	struct sk_buff *bcn;
 	int ret;
 
-	if (vif->mbssid_tx_vif) {
-		tx_arvif = ath11k_vif_to_arvif(vif->mbssid_tx_vif);
-		if (tx_arvif != arvif) {
-			ar = tx_arvif->ar;
-			ab = ar->ab;
-			hw = ar->hw;
-			vif = tx_arvif->vif;
-		}
+	tx_arvif = ath11k_mac_get_tx_arvif(arvif);
+	if (tx_arvif && tx_arvif != arvif) {
+		ar = tx_arvif->ar;
+		ab = ar->ab;
+		hw = ar->hw;
+		vif = tx_arvif->vif;
+	} else {
+		tx_arvif = arvif;
 	}
 
 	bcn = ieee80211_beacon_get_template(hw, vif, &offs, 0);
@@ -1674,7 +1682,7 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 				     struct ieee80211_bss_conf *info)
 {
 	struct ath11k *ar = arvif->ar;
-	struct ath11k_vif *tx_arvif = NULL;
+	struct ath11k_vif *tx_arvif;
 	int ret = 0;
 
 	lockdep_assert_held(&arvif->ar->conf_mutex);
@@ -1701,9 +1709,7 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 
 	ether_addr_copy(arvif->bssid, info->bssid);
 
-	if (arvif->vif->mbssid_tx_vif)
-		tx_arvif = ath11k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
-
+	tx_arvif = ath11k_mac_get_tx_arvif(arvif);
 	ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
 				 arvif->bssid,
 				 tx_arvif ? tx_arvif->bssid : NULL,
@@ -6385,23 +6391,20 @@ static int ath11k_mac_setup_vdev_params_mbssid(struct ath11k_vif *arvif,
 {
 	struct ath11k *ar = arvif->ar;
 	struct ath11k_vif *tx_arvif;
-	struct ieee80211_vif *tx_vif;
 
 	*tx_vdev_id = 0;
-	tx_vif = arvif->vif->mbssid_tx_vif;
-	if (!tx_vif) {
+	tx_arvif = ath11k_mac_get_tx_arvif(arvif);
+	if (!tx_arvif) {
 		*flags = WMI_HOST_VDEV_FLAGS_NON_MBSSID_AP;
 		return 0;
 	}
 
-	tx_arvif = ath11k_vif_to_arvif(tx_vif);
-
 	if (arvif->vif->bss_conf.nontransmitted) {
-		if (ar->hw->wiphy != ieee80211_vif_to_wdev(tx_vif)->wiphy)
+		if (ar->hw->wiphy != tx_arvif->ar->hw->wiphy)
 			return -EINVAL;
 
 		*flags = WMI_HOST_VDEV_FLAGS_NON_TRANSMIT_AP;
-		*tx_vdev_id = ath11k_vif_to_arvif(tx_vif)->vdev_id;
+		*tx_vdev_id = tx_arvif->vdev_id;
 	} else if (tx_arvif == arvif) {
 		*flags = WMI_HOST_VDEV_FLAGS_TRANSMIT_AP;
 	} else {
@@ -7361,8 +7364,7 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 			   int n_vifs)
 {
 	struct ath11k_base *ab = ar->ab;
-	struct ath11k_vif *arvif, *tx_arvif = NULL;
-	struct ieee80211_vif *mbssid_tx_vif;
+	struct ath11k_vif *arvif, *tx_arvif;
 	int ret;
 	int i;
 	bool monitor_vif = false;
@@ -7416,10 +7418,7 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 			ath11k_warn(ab, "failed to update bcn tmpl during csa: %d\n",
 				    ret);
 
-		mbssid_tx_vif = arvif->vif->mbssid_tx_vif;
-		if (mbssid_tx_vif)
-			tx_arvif = ath11k_vif_to_arvif(mbssid_tx_vif);
-
+		tx_arvif = ath11k_mac_get_tx_arvif(arvif);
 		ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
 					 arvif->bssid,
 					 tx_arvif ? tx_arvif->bssid : NULL,
-- 
2.34.1


