Return-Path: <linux-wireless+bounces-23501-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 152D3AC8716
	for <lists+linux-wireless@lfdr.de>; Fri, 30 May 2025 05:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2BC44A3E9F
	for <lists+linux-wireless@lfdr.de>; Fri, 30 May 2025 03:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9640E19C54F;
	Fri, 30 May 2025 03:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dx+E8FAm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD92054652
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 03:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748577427; cv=none; b=A7aPXbSO7Q1TKR25al9NoymfJEYB6I4pDjLUGehDxMMEWpINzAIAb9PNGInLRl1ClNYhV/mKvlG3cfKOc1/dMyBpNp69vrxQ1qJjeBaZRfjg6Sj4kfPdgcgU4B0WS71046ZC8FgDPBItHXSMi4IVayVUVURSW9qDN2iho8KMGX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748577427; c=relaxed/simple;
	bh=9/TRyVWQK4BDkm0WZejkSbA4rxlDbZ3AZGrJjTeyXAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CxwOPMGnp8quoOQ/c0T2MKsDdQJmz4MzYUmqz8mGlU+vfd3duNX78kuU4C9ylzPhWjaNI8Payun8q1bBa9ZRuoOqdDfxmsGSpaKYP7GtiIY31DFs7PX0vybik+7OB2xi4+SCw29cIMGGCNwGyQMF+Sty3veG5VCKsWPYSMwJxy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dx+E8FAm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54U0ePQA004885
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 03:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=O2TvCpip0Cr
	qCqITqzlimsG2guCnMFbygY5osCfo4tw=; b=Dx+E8FAmkWNAJcnz8s28H0spAKy
	Sh85BmRomhx2XUxufrCcHW1lAn58vyPFMKcT/3viiouc4C23pOCHW6E1ltEcIfYX
	An5Y3A9GeN0u+EXiZmu1tcZqRToEmUC4fAP/JymxiFJqgPUVx+hnoMPETBJn0s2X
	DCzR/yUGE5yPKzmUXd3cFypb2iIpIFQSXdv4zjge4U8BW9vPu+4/YDa6luze8b5z
	SFd1dtxEFoMQFna29bMfezto7VH1oRTscyyI1ajOPvT1643+TlPw1vP2CY9Mz2nt
	30E5dGIqoZmdL0cLy2uWxSA6Vp9iOWhKPOsaG+I0X+zsNTXIp6ubD025Wkg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u5ek7hqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 03:57:04 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-745fd5b7b65so1309184b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 29 May 2025 20:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748577423; x=1749182223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2TvCpip0CrqCqITqzlimsG2guCnMFbygY5osCfo4tw=;
        b=aP8UPd2QYfMHjfc3Aw+tncjCNerALXXhcizzsdHPkgDrPC9+oz3qpSZ/MgQimI/0uR
         rtTm9vfHp2xHiZMYBBPSaZXihkenNlmyCeEghzd+Zr7MTYYPeNQy09Pok7czi16wabvd
         nqQxhdm9c9pCiErVqmIug7YqOeF8BFlQlIOOjMwCqUqN6KvfGHKXLsanLLXj85wk1FfM
         DaMDOc+Gsd1V3iQMgsksW+g5XcnD2X1OmOwXZz7Yx+Q75ZQCsgsf/Et7b/5T/HNyHwx1
         2jl5+nlWe/5j7tdSHI7r8ajr2ZB0UIs8Kk9kNr7GSMFskkGG6qEP1oBnAuYpbkh5VcOh
         qV/A==
X-Gm-Message-State: AOJu0YzgkLR5gqMo27KWui+/s0XFUuk0AcmgNCUUkRvx7jMSCuJOT21z
	X/S5W98STWOFmuNvyqXRhUELH6nSQLOvo3mL+DStS4RW/CcRm0c1s5xAkkOwCT2OEn62V6SvsyC
	YehYaCHihK5RgTkqMAwvxsmKeNKINM372CHC4MyTNPH+pxpanr9y6yf8/kUNj5oKa5RTIYDOKad
	v/iw==
X-Gm-Gg: ASbGncuClIJ9BLWgX9pIhzuJCqygHgpXPJrCrF8+hmBPBalAMpdU3l2zIITbZvGoOMT
	1MeBH5uqO+JTvgC+OhfMNym/Ro5Lklpai6etYec4HYg4iqJpZJM5317qDeGaiqVOmcFqG58Sqsn
	7P8b9zCwUK1pGWG+raDiduqSdyXZRq+2moCFZVOK7JaEv+2G+qJ0ckwEK7v8q8CmftPJ8vEAc/X
	bz/KeFWcfUzyHpU+2cSSUVWZftI/ZgtHav3BEPcwo5vEgUpReUJRUj6rJpmxq4w4JO0R+RyAuBq
	EwK14N/wLsDAS0MjFjmmX9s7wn+eNm7/GhzWhJkKwBnjQ7tQ+Z63HL9nFekDGlJMLj+6uKVsDnp
	/hIAmeDYaDeKiSrQRf+he7GUQ3YE52HxkTBCqFF5T
X-Received: by 2002:a05:6a21:164e:b0:1f1:b69:9bdd with SMTP id adf61e73a8af0-21ae00cb8f4mr1353551637.37.1748577422726;
        Thu, 29 May 2025 20:57:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2Ys6z2ZaIbTrs7CD+VukkSzOR1QvFbAFkqlN0+Mh2P+eXY7rsEymMBjaAumbvVPHsjLFu1Q==
X-Received: by 2002:a05:6a21:164e:b0:1f1:b69:9bdd with SMTP id adf61e73a8af0-21ae00cb8f4mr1353516637.37.1748577422315;
        Thu, 29 May 2025 20:57:02 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb96fe8sm705274a12.59.2025.05.29.20.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 20:57:02 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH ath-next 2/2] wifi: ath12k: Fix beacon reception for sta associated to Non-TX AP
Date: Fri, 30 May 2025 09:26:15 +0530
Message-Id: <20250530035615.3178480-3-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250530035615.3178480-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20250530035615.3178480-1-rameshkumar.sundaram@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GIgIEvNK c=1 sm=1 tr=0 ts=68392c90 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=6IJaJU3SOiTWtuUPfpcA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: grYQNeSVhuT2ZP0Pf9Ap71eDLFDIhw-B
X-Proofpoint-GUID: grYQNeSVhuT2ZP0Pf9Ap71eDLFDIhw-B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDAzMCBTYWx0ZWRfXzo8QGQ2BN1e/
 PJCat9QzoxBCHzks/24NAGv/vjvuV8H1Mj5vTovTKnUgEB5cqBqOKhcumErRSdx+ua/dV2G73sK
 nK187fSEeSRFM+oWCDk0v7bGfOap2zhAmGvdZvb9fNk85tO+6K9BcDlQHr/AnkLcNUucTEvqMLq
 Zj87eEH9r57ddn+6VXaHS0F9XcZO0j0z6iBZAyliSDBMYSwm8LGH2HcGCKwmsYB/8/5GZVCJHJT
 tENa42qoaF3dDaS6fO5Ob/tQkiTPxwgl9F8Us3X+Df0mn36mC2HprKd+OpAOE/fnk5E/eB0f0TM
 42e6hVM8/yUS3Ov4PR2Dsf6M3AsVX5bZo2dknWJgygt+fWFJ+Ytw/4bH+bTitds60X31FCR+kR5
 3e+Lq7DyRDIisRZ0BLN367lPDQmvyk1C8ut2kxXTYOu4LwJopCwW6iM8y9VrvrtzdSNka+mb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_01,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505300030

Currently, when a station is associated with a Non-Transmitting BSS of an
MBSSID set, beacons are not frequently received from the firmware. This
results in missing events via beacons, such as channel switches, leading
to the station not switching to new channel as the AP does, eventually
causing a kick out event from the firmware. This issue arises due to
missing configuration of Non-Transmitting BSS information in station's
vdev up command.

Fix this by filling information such as the Transmitting BSSID, profile index
and profile count in vdev up command of station.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 56 ++++++++++++++++++---------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 5183a7e43e51..320ff76f33f7 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -602,6 +602,33 @@ ath12k_mac_get_tx_arvif(struct ath12k_link_vif *arvif,
 	return NULL;
 }
 
+static const u8 *ath12k_mac_get_tx_bssid(struct ath12k_link_vif *arvif)
+{
+	struct ieee80211_bss_conf *link_conf;
+	struct ath12k_link_vif *tx_arvif;
+	struct ath12k *ar = arvif->ar;
+
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	link_conf = ath12k_mac_get_link_bss_conf(arvif);
+	if (!link_conf) {
+		ath12k_warn(ar->ab,
+			    "unable to access bss link conf for link %u required to retrieve transmitting link conf\n",
+			    arvif->link_id);
+		return NULL;
+	}
+	if (link_conf->vif->type == NL80211_IFTYPE_STATION) {
+		if (link_conf->nontransmitted)
+			return link_conf->transmitter_bssid;
+	} else {
+		tx_arvif = ath12k_mac_get_tx_arvif(arvif, link_conf);
+		if (tx_arvif)
+			return tx_arvif->bssid;
+	}
+
+	return NULL;
+}
+
 struct ieee80211_bss_conf *
 ath12k_mac_get_link_bss_conf(struct ath12k_link_vif *arvif)
 {
@@ -1688,8 +1715,6 @@ static void ath12k_control_beaconing(struct ath12k_link_vif *arvif,
 {
 	struct ath12k_wmi_vdev_up_params params = {};
 	struct ath12k_vif *ahvif = arvif->ahvif;
-	struct ieee80211_bss_conf *link_conf;
-	struct ath12k_link_vif *tx_arvif;
 	struct ath12k *ar = arvif->ar;
 	int ret;
 
@@ -1720,18 +1745,8 @@ static void ath12k_control_beaconing(struct ath12k_link_vif *arvif,
 	params.vdev_id = arvif->vdev_id;
 	params.aid = ahvif->aid;
 	params.bssid = arvif->bssid;
-
-	link_conf = ath12k_mac_get_link_bss_conf(arvif);
-	if (!link_conf) {
-		ath12k_warn(ar->ab,
-			    "unable to access bss link conf for link %u required to retrieve transmitting link conf\n",
-			    arvif->link_id);
-		return;
-	}
-
-	tx_arvif = ath12k_mac_get_tx_arvif(arvif, link_conf);
-	if (tx_arvif) {
-		params.tx_bssid = tx_arvif->bssid;
+	params.tx_bssid = ath12k_mac_get_tx_bssid(arvif);
+	if (params.tx_bssid) {
 		params.nontx_profile_idx = info->bssid_index;
 		params.nontx_profile_cnt = 1 << info->bssid_indicator;
 	}
@@ -3261,6 +3276,11 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 	params.vdev_id = arvif->vdev_id;
 	params.aid = ahvif->aid;
 	params.bssid = arvif->bssid;
+	params.tx_bssid = ath12k_mac_get_tx_bssid(arvif);
+	if (params.tx_bssid) {
+		params.nontx_profile_idx = bss_conf->bssid_index;
+		params.nontx_profile_cnt = 1 << bss_conf->bssid_indicator;
+	}
 	ret = ath12k_wmi_vdev_up(ar, &params);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to set vdev %d up: %d\n",
@@ -9585,7 +9605,7 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 			   int n_vifs)
 {
 	struct ath12k_wmi_vdev_up_params params = {};
-	struct ath12k_link_vif *arvif, *tx_arvif;
+	struct ath12k_link_vif *arvif;
 	struct ieee80211_bss_conf *link_conf;
 	struct ath12k_base *ab = ar->ab;
 	struct ieee80211_vif *vif;
@@ -9657,10 +9677,8 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 		params.vdev_id = arvif->vdev_id;
 		params.aid = ahvif->aid;
 		params.bssid = arvif->bssid;
-
-		tx_arvif = ath12k_mac_get_tx_arvif(arvif, link_conf);
-		if (tx_arvif) {
-			params.tx_bssid = tx_arvif->bssid;
+		params.tx_bssid = ath12k_mac_get_tx_bssid(arvif);
+		if (params.tx_bssid) {
 			params.nontx_profile_idx = link_conf->bssid_index;
 			params.nontx_profile_cnt = 1 << link_conf->bssid_indicator;
 		}
-- 
2.34.1


