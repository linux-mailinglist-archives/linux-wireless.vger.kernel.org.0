Return-Path: <linux-wireless+bounces-18318-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EE2A265F4
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 22:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F004218854FD
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 21:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F2820FA9E;
	Mon,  3 Feb 2025 21:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DN/amMK9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB9220F094
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 21:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738619096; cv=none; b=qZhmL95eoA2cLarot+Ld/pyWaGhIcuSqBKREfBA4vxwHQQjAgZCzQfRRXuoHdwIEx3ooe+YGxHJOCNIvLO9Iue7GU+2atokftZrqXIrQeuG7jarcxJesTDROFO1ypcRqA6vGK7/txAWnEOHJVWskRc/sDd0GfMycKgoODb8g/CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738619096; c=relaxed/simple;
	bh=qHyY+9pcaUEj1r52V7z9DH38erNPx9sa0W9IU6A8F8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hrqz9dv78f4OjxQRaMsFdsEO/g2xCj/NgdcCHATU8NJdCL2upXQM9Xm8Y2/eakaTShKqVSyjdwTXfKvss+YrwOZ/i7WMbErHe8OJkfpZpiMT3HBWjIEuolCBPFPb89BVxqDc5A67LnSZ+Uwq0VtRcgXp9BlViT9zUcVLAwDw8/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DN/amMK9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513KQoRF027105
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 21:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Gkn/KbsZrRP
	P00bPrOxcPIgQ5D81kLJKQ+TUyRg86pk=; b=DN/amMK9/cGuFUb6GUzlMJJ5jg+
	wbZsE/VyRFd/vxMuDZn7pEW5qBIrYJ35/z846wx2zHdHCW0UoTzw6XzXRmXTofs2
	W4/P6msdDsqNpPjS14j4FCQJst2o7bg/cYUbtsoWT9EyuATG0sVd7orwVT/f91B2
	JYJGIEoVziVPmfaM4Sr0Eq2s6EMvtl2hsGrwmXPkFfCLCkEDxDAwGTVrDEtgaUNG
	taY5WkbT6ENYvJbnjmaQHq5w/oI9t4Mhoceri2rCu2p2XN90aGFhe3fJ4YQqVtco
	RFJah+eUPBO2LIiSH7BETGLKQgcoJsLYfPMU1M3y5gQG8sMLR36H1jSf43Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k4ufr4wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 21:44:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21681a2c0d5so92921845ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 13:44:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738619092; x=1739223892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gkn/KbsZrRPP00bPrOxcPIgQ5D81kLJKQ+TUyRg86pk=;
        b=pzKHRAu3ppQ84ZKRXRjgglNXpkv8YzSUTgCb7J2U9SlDcJN0HwN59atkGx/CQtI4Kr
         32xTSie25B4T866uWUHDCw1goIdwSx5ZxSNrfnbmIC6W/t6+Nl1K3hQEa9ug61T9qAbs
         wR9VVdeHcQYyKTMM4QSxBChB22ar9z7yInoP4bZ0GfRubHq38UHvS6TjNJU5/6T2jgBY
         863U5w6tXv/QsT3phX3XOjWj9DrWP3oD6xqCo3iQuXlCyLmxadlq+2A/zDW+84akOwkT
         0f2v8pvWNx4bDCIbQ0PLvHKEN9g0BauVuyBK5ZQh1C31+TcWV7Cng8JcwnTuMLnfNQad
         rBoA==
X-Forwarded-Encrypted: i=1; AJvYcCXowLfOeQ/5INojQ/Td9+0Y/menNDciJPFKu18gk7oEDNQ4GRGvF29vvWo0U06DKm0e3t3JB/0MGsfNOTR8tw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwE8XTJU0s/z2Qy5sZO2ULJ4woVgj8S7HzdykneQ6kmu3Zauhj1
	XwHfRLLTSES+ody2yuESmj8kWavll60ZBeGN+aesZH0WvaF+YWFXuU4InuNQ8OPw1ZbudffvMTr
	0GVrqkXe729smQc8axyaRKRkDgq+50++8yduCqjZG/xcCAEYdW1S2cPYi/9EFqbKOTtv+rW/aXQ
	==
X-Gm-Gg: ASbGncuPVl+oRJPrfEfY5P/la8tTp/Mqm9AcFEFiL+EcublFsqkQTC26nRAaZ0C0PUa
	y0WalLzhEYMLD43hZ1e0Zda8y4n2152WM21wGUsP1FP5CC4JGqI9TqLFpVn9PPzsYBayOswbe/7
	pFEQkdhADWLz/ez64KTXNWfEFi/U5RwU6ElKnpJTnlZfHc4zCpuIGf/pAfFBAWCJAJFXslBlscE
	ke9/rIMAZ8wLcFk05LthN3lub5I8g++Q4ODMjfrLZoyaq9h3RE9bZnLTNk28hC18LJyaYPkI1pJ
	GaRbOk6Y+iBc8eYH9DQb4Z3dMteW36J/Pe0DFNPKW0G2nADq8mclFnx3vKkM
X-Received: by 2002:a17:902:ccc8:b0:215:9894:5679 with SMTP id d9443c01a7336-21dd7b71973mr384991165ad.0.1738619092477;
        Mon, 03 Feb 2025 13:44:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEskV29JE4JQGNqDGNQyNuMsPsH38/NHc5F5JRg6DoAdqV7uysCzJlpYZd14A/hsIMpF95Blg==
X-Received: by 2002:a17:902:ccc8:b0:215:9894:5679 with SMTP id d9443c01a7336-21dd7b71973mr384990895ad.0.1738619092128;
        Mon, 03 Feb 2025 13:44:52 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de331ce6asm82357895ad.209.2025.02.03.13.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 13:44:51 -0800 (PST)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v3 2/5] wifi: ath11k: pass tx arvif for MBSSID and EMA beacon generation
Date: Mon,  3 Feb 2025 13:44:45 -0800
Message-Id: <20250203214448.1978156-3-aloka.dixit@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203214448.1978156-1-aloka.dixit@oss.qualcomm.com>
References: <20250203214448.1978156-1-aloka.dixit@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SGAlCq0V4lOeSOBg8-0cUaiDw35X1ZWu
X-Proofpoint-ORIG-GUID: SGAlCq0V4lOeSOBg8-0cUaiDw35X1ZWu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030157

Function ath11k_mac_setup_bcn_tmpl() retrieves tx_arvif only for
a sanity check and then calls ath11k_mac_setup_bcn_tmpl_mbssid()
or ath11k_mac_setup_bcn_tmpl_ema() both of which again retrieve
the same pointer. Instead store the pointer and pass it to the
latter two functions.

Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 32 +++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 8b81f450a216..67f733aac759 100644
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


