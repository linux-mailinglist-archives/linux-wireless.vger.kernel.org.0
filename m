Return-Path: <linux-wireless+bounces-18322-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 539DAA265F7
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 22:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C571885769
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 21:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9213211269;
	Mon,  3 Feb 2025 21:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DuJy5I9Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBB6210F76
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738619100; cv=none; b=ooIBepdqIAmpzYZAFm/I98wkS/XIWgN5oEUzOxDdxEOqHD9rFbBeAm6JZ9++AqU9Rz6DoVOblygSiucduJ+YQM/BJ2gjzJR9tVAXCiAJj1M/aXz0Obnlulgj+2NgZgvKyzDVhcJrSUNaeHDlA16Ia1vEwZNA1a7jqZUWVAxr4Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738619100; c=relaxed/simple;
	bh=8/3Y1ezaMkICdwteNoN53d/H/jahvo18dpTSfkup16A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LfFpkhZ2Ht3ZxqIWagRAtTpys7SfFcQ5PAXXH8qp8htf3q7XSonNcF1WNQDK9wn++GN0sw/uhYAwtZRVWkMTF0jqBYfFMmG8prPeLCTCbskRpwaLLNfcQ/blMiwCiZnTE4UWwX2toJKVJ16mH3yJP6LqY+2p91p6qnOiXlijNfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DuJy5I9Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513IpdPl005920
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 21:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=o/NOJiLGgX+
	K66BZwbw+Ol/19603T6IJWbf/Z2BMZNA=; b=DuJy5I9YwsJHWfZxgEl/O6s+xkj
	ZxhVg/uxsOQh4zMnS0XuVE3zU1gDU7dJa5el05TSgU62abEozJDzBZCGqbiZo3AG
	hutiILoZRZM5a/bHjo5Gjj5Qvf7TM2P7J9rrw32n/UeywdncSvLFpXAWkzBSAl1V
	f78uDgKwtpC7IYOclEQ7KVY9eSFNyfGDq+Gix9QgFNPG2ecudEWQeF3FXPC+s8bw
	dBinwCYOJEDNlKQhZvR+LyMaIV62R+l9mrd7D0XcoHpq9a3xARjS4X6cXKjALAWX
	xMH8hRXuO6meXe+BpC471dhxvh1M+kgqrt8+nG8PGp7X2rsBDNcDsx2dR8A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k3ex0b3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 21:44:56 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2efa0eb9cfeso9639348a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 13:44:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738619095; x=1739223895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/NOJiLGgX+K66BZwbw+Ol/19603T6IJWbf/Z2BMZNA=;
        b=sPqq9iOd0HzxvX2ImChECy7X7Sh8g7BNnVm9MSx+ZsasnlrALok31QnsBPXCjgAXN3
         d74gLaVurPBrFuDcAMZGzW3F1JX/5DauXAQ/ih4ctHPGCSB9LxctqfzbBD4HFZYcvTRb
         oiAfNSvKb0qjAHUkkW1Ic56MbQb8XYnI1/XPJ8/NAnanMkacyAvISpQ0TCngtbx2cexW
         GiKsQMR5hf263oyLsu1qwHkmC3VnAIq0S5lYHnXgKdEfSOcYEgdbvEufj9dMwX7VR2Re
         caZQbgBVixjnJSYfWa6xYEC9ZVheRWmFBeJMP/62ksqAfSlIY/Gll8ey3FSJzZat1ViZ
         qZ5A==
X-Forwarded-Encrypted: i=1; AJvYcCXQMpa2PIbPffh+v2/kMsfSIxSMDOskk+cjK+QZ9xr45CgbsPxR1mA76Rr0pdijFHAhF4os2I06QDqv+6+iHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YydQhiIlCjnPgXAzSfBkY+sQFuigA26t9JteXncaLUIdjpqgRvQ
	1x8xPQdlR0XLGmoVX0MR8ha9c2fskDIhXCo8HRJ5UKyosdLE59Fcq+i+Uzh9fyyCWNzOaZ/2gV3
	S/LYmiCtFcQDh1CxmS6XJygAuhuuaPKqbqLNK9hBE3/6tSqrdW/EyP/C3Pb68SztAslioz4HmLA
	==
X-Gm-Gg: ASbGncs04WcpAQKxaaHGJbPBlF/hTmcFlLzLUejh/v/GCuXK+ngarIFZK4Gv/b/BQw8
	9IX10pVQI6aYXSfWDg0MO4qYj9A4mK5yhdVVxF9ntWwaw2eNaFkokXOB75NqO7agF7b3vSWEc3a
	MoaGHQsXzMZcaTlEi7dOcvXkru4fjT+IBz1Xs3OzqWiy94jcnYgNkto4SiZN7SfrhiGLJmKr4w/
	O5Iz3IziZA0Pm4IA5Mnmk6a8p6XQIRs6wUWrcm4kIT8VB1Ns8wcOwGWnMzAWkfLcQxywsnPEwBD
	O8SK9K3ALSjW1w5kQOOOy9lMkghwiNfIXeAy16KNW4vBLGsnv7Bq4/35bjWk
X-Received: by 2002:a17:90b:264e:b0:2ef:2980:4411 with SMTP id 98e67ed59e1d1-2f9ba26b850mr1294629a91.9.1738619093404;
        Mon, 03 Feb 2025 13:44:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvvw9gKRxtbE+OTiyqQ5MXN4t+jAbJiFCRohnw3OPyEk4EXFoSxh4aNnCnAzM+P8mNlyM4Mw==
X-Received: by 2002:a17:90b:264e:b0:2ef:2980:4411 with SMTP id 98e67ed59e1d1-2f9ba26b850mr1294610a91.9.1738619092950;
        Mon, 03 Feb 2025 13:44:52 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de331ce6asm82357895ad.209.2025.02.03.13.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 13:44:52 -0800 (PST)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v3 3/5] wifi: ath12k: refactor transmitted arvif retrieval
Date: Mon,  3 Feb 2025 13:44:46 -0800
Message-Id: <20250203214448.1978156-4-aloka.dixit@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: MhOVMX-d_-V6d5pKlqhBCgZ8fG310iHA
X-Proofpoint-GUID: MhOVMX-d_-V6d5pKlqhBCgZ8fG310iHA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502030156

Create a new function ath12k_mac_get_tx_arvif() to retrieve 'arvif'
for the transmitted interface of the MBSSID set. This clean up will
help modifying the same code path for MLO changes.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 60 +++++++++++++++------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index e9663c6ac72c..efd155031feb 100644
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
 static struct ieee80211_bss_conf *
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
@@ -1696,11 +1707,10 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_link_vif *arvif)
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
@@ -1715,17 +1725,19 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_link_vif *arvif)
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
@@ -1782,6 +1794,7 @@ static void ath12k_control_beaconing(struct ath12k_link_vif *arvif,
 {
 	struct ath12k_wmi_vdev_up_params params = {};
 	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ath12k_link_vif *tx_arvif;
 	struct ath12k *ar = arvif->ar;
 	int ret;
 
@@ -1812,11 +1825,9 @@ static void ath12k_control_beaconing(struct ath12k_link_vif *arvif,
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
@@ -7676,14 +7687,9 @@ static int ath12k_mac_setup_vdev_params_mbssid(struct ath12k_link_vif *arvif,
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
@@ -7692,11 +7698,13 @@ static int ath12k_mac_setup_vdev_params_mbssid(struct ath12k_link_vif *arvif,
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
@@ -9074,9 +9082,9 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
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
@@ -9144,11 +9152,9 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
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


