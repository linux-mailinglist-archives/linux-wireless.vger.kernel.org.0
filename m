Return-Path: <linux-wireless+bounces-18725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E558A2F701
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 19:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2F63A666D
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 18:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601622566E3;
	Mon, 10 Feb 2025 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dP1oZgKA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CCD255E34
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212046; cv=none; b=g3E7E/+cVHL9pddJhqX5QsQmFhJiqx2K8SJRjb5Ay3tymmoMBs3JuVW87MHEb0qSTweOiMChVva/p74uasEwZiwwBMbCK35eIca044n/IbF0H3kWujxBxr3w1BD+XSt4YJrZZt0TFAT7sKt1hr0k9CAgBMbEIGQ5matoYXubR4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212046; c=relaxed/simple;
	bh=PDoSmfSy/Tg7p5saV5k0b981LVBGMsD9PYdNd9oEhrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=At7TLd4PoHTu7U45d6EuBlRGntFV7Uu6KGdMdSzk3j0kUnF6CgPCd1P2ZUvr1lPtZVgae9nB3fCfYXs3Ifm3fUkF/v008otX68wS6Q8exeQQqkMPHEg4CMADziUnhnSRRVlEpJ2vfgEyrWUzaMTBeJ3Pr4l2KC4Uby2/ES10gns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dP1oZgKA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A9Vtv5008337
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 18:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fAbeSvzzDSR
	fK4FglCkwrWyMnTvLJKDNWwTPCreQNEk=; b=dP1oZgKAZtmQiVKlHICG2oUIMXp
	WRX97QuVLKEujuszqVVLSnLdlGcTq+IBmvaCIHFnhvQqdnnjabp8IOX8/EtcFwis
	NsJQX5iOr4TFPLqQmrk53kHzLm6vI6NijI3VDY0IOR13t6TOg9c8YPXglCKV5tLO
	vD39FZxejQiXwpEHwEFudFmjnkc6d5cIKijpqzs5CFFqfrdht+5jFrPUe5qvVhLJ
	fO1dcbEoR3TEaDWARctqODix+WKpcnfks6vua1Yt9f+50lBRBXTFoaqz/JtjUWEf
	h9AS60rCHAm/iFZWSYe93+F0qlIi5FdTXCJh/gX9pjfYj7kZ0zJKS8c1pyw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qewh1f7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 18:27:23 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fa9bfea46aso660242a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 10:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739212043; x=1739816843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAbeSvzzDSRfK4FglCkwrWyMnTvLJKDNWwTPCreQNEk=;
        b=m5TICZ5wPryHEaSObKJs9dChpekp97OqA6lB8+owHiOiU+1/lP+XNmX/WpEvHmu9RD
         HejO6nT1d+jSsKqb0bf3xbC7GT+C1NQNYJAPU33DG8LnRaL2NTtxbJwOx2XB1WZiQsLD
         O8AWBNoIh+sDel5Vg4l1mI7zeeG5e7mWoV0lfDFXJTKE9B5iEGGJtJQ2Y5sgHePyd0Mx
         qYFISscaVtd1dfx1Nbz1tgbKgXTsqnjfpeCwfv5HNuIrs+M7Djex9i1u1ib9/8B9TvYf
         fttyr8an+kdWajdC8zzoSCnAFYuLWMAgHUIjoys2AQCSIarsPKSRUjx814rxi0xMIt4T
         Qhwg==
X-Forwarded-Encrypted: i=1; AJvYcCX14x2leQBFp9Wyhyrd6yY6Rtj+ZYo4ElBIcH4d952cGOBiok/2I+URcYVxrZTv/fgeehLiYJ1L/MgLQKaiWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YylNcZmPLKZTyNOUqwuYY4xbSpmv/MPfdLfS6poWEmPJpKSsmtp
	/jvibbO78i3e1hSNHe05aAZ/fpaMDZEIk5PETRXRVEXWVb6H7R9Sv+wpC/S+gsoMJ1gjAc74iAg
	PCNVtRndftorzhhc3dz0aK6UUvQ+I/r+gz4N5B7Rjfge+HK5Ed1OzaHGv1smJ1jsiApzwbxTorA
	==
X-Gm-Gg: ASbGncu96iHkMXpcCfpIQB6THJf3CZ0qAOBWpLaQ32Fmv/To8k1Z+k+CzBX9A8EMaBM
	p6W8zEND8VQBGkds75uZCScvBoydfEUxcex9T3y+jbWSq3vYJ3uJer3Ahau0ZQL3NJSIMEcTnW6
	/z+fgx0G3XsNItRMqSD7tYsiUmeRiq41c75Yu+sLpVmIsw4PR4gZ1gxVnn97M77GWq67B3dc8Mn
	cKl9QkuLukdYhpTrxD0LMNOrl1UY7TqpKbQuFTjZn8kQLE2g7X+8F5NmkXUaV+jmruAocolGfWs
	wh3DMCywJJbj4gs3lquUHMRQ2DYnLFOg6FC1whgjPi1VTzROOlt/zdenZdJe
X-Received: by 2002:a05:6a00:f07:b0:730:8e2c:e53b with SMTP id d2e1a72fcca58-7308e2cff04mr7494879b3a.5.1739212042797;
        Mon, 10 Feb 2025 10:27:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEl6HApPA5o/SXwLPe8SFpai7AOw0KUzZ5vMElwGSGjqDBkSWO7oTOcmETRxasiZPyDWmGWUQ==
X-Received: by 2002:a05:6a00:f07:b0:730:8e2c:e53b with SMTP id d2e1a72fcca58-7308e2cff04mr7494841b3a.5.1739212042353;
        Mon, 10 Feb 2025 10:27:22 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae8e83sm7948372b3a.84.2025.02.10.10.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:27:22 -0800 (PST)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v4 2/5] wifi: ath11k: pass tx arvif for MBSSID and EMA beacon generation
Date: Mon, 10 Feb 2025 10:27:15 -0800
Message-Id: <20250210182718.408891-3-aloka.dixit@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: NMUgCSNcLB9_EedIw5BgJG7E_2N-8gSp
X-Proofpoint-GUID: NMUgCSNcLB9_EedIw5BgJG7E_2N-8gSp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_10,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100149

Function ath11k_mac_setup_bcn_tmpl() retrieves tx_arvif only for
a sanity check and then calls ath11k_mac_setup_bcn_tmpl_mbssid()
or ath11k_mac_setup_bcn_tmpl_ema() both of which again retrieve
the same pointer. Instead store the pointer and pass it to the
latter two functions. Compile tested only.

Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 32 +++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 466a314b938b..97816916abac 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1537,17 +1537,15 @@ static struct ath11k_vif *ath11k_mac_get_tx_arvif(struct ath11k_vif *arvif)
 	return NULL;
 }
 
-static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
+static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif,
+					 struct ath11k_vif *tx_arvif)
 {
-	struct ath11k_vif *tx_arvif;
 	struct ieee80211_ema_beacons *beacons;
 	int ret = 0;
 	bool nontx_vif_params_set = false;
 	u32 params = 0;
 	u8 i = 0;
 
-	tx_arvif = ath11k_mac_get_tx_arvif(arvif);
-
 	beacons = ieee80211_beacon_get_template_ema_list(tx_arvif->ar->hw,
 							 tx_arvif->vif, 0);
 	if (!beacons || !beacons->cnt) {
@@ -1593,25 +1591,22 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
 	return ret;
 }
 
-static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif)
+static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif,
+					    struct ath11k_vif *tx_arvif)
 {
 	struct ath11k *ar = arvif->ar;
 	struct ath11k_base *ab = ar->ab;
-	struct ath11k_vif *tx_arvif;
 	struct ieee80211_hw *hw = ar->hw;
 	struct ieee80211_vif *vif = arvif->vif;
 	struct ieee80211_mutable_offsets offs = {};
 	struct sk_buff *bcn;
 	int ret;
 
-	tx_arvif = ath11k_mac_get_tx_arvif(arvif);
-	if (tx_arvif && tx_arvif != arvif) {
+	if (tx_arvif != arvif) {
 		ar = tx_arvif->ar;
 		ab = ar->ab;
 		hw = ar->hw;
 		vif = tx_arvif->vif;
-	} else {
-		tx_arvif = arvif;
 	}
 
 	bcn = ieee80211_beacon_get_template(hw, vif, &offs, 0);
@@ -1640,6 +1635,7 @@ static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif)
 static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
 {
 	struct ieee80211_vif *vif = arvif->vif;
+	struct ath11k_vif *tx_arvif;
 
 	if (arvif->vdev_type != WMI_VDEV_TYPE_AP)
 		return 0;
@@ -1647,14 +1643,18 @@ static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
 	/* Target does not expect beacon templates for the already up
 	 * non-transmitting interfaces, and results in a crash if sent.
 	 */
-	if (vif->mbssid_tx_vif &&
-	    arvif != ath11k_vif_to_arvif(vif->mbssid_tx_vif) && arvif->is_up)
-		return 0;
+	tx_arvif = ath11k_mac_get_tx_arvif(arvif);
+	if (tx_arvif) {
+		if (arvif != tx_arvif && arvif->is_up)
+			return 0;
 
-	if (vif->bss_conf.ema_ap && vif->mbssid_tx_vif)
-		return ath11k_mac_setup_bcn_tmpl_ema(arvif);
+		if (vif->bss_conf.ema_ap)
+			return ath11k_mac_setup_bcn_tmpl_ema(arvif, tx_arvif);
+	} else {
+		tx_arvif = arvif;
+	}
 
-	return ath11k_mac_setup_bcn_tmpl_mbssid(arvif);
+	return ath11k_mac_setup_bcn_tmpl_mbssid(arvif, tx_arvif);
 }
 
 void ath11k_mac_bcn_tx_event(struct ath11k_vif *arvif)
-- 
2.34.1


