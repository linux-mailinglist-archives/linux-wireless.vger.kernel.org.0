Return-Path: <linux-wireless+bounces-20118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A891A5A453
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 21:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F30447A491D
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 20:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC531CAA8A;
	Mon, 10 Mar 2025 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RH+a65gf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321A41C5D40
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636985; cv=none; b=X2vnaZS3ypdq82qT9LM6z7pwRJ+sMH0dAdf1wyTXqDZ6V6uO74mKfvhgvPKXogqXymbYLWI3yCiXp0mwB34qMO/tb/j9IlIZuRB/nQ9Sm8LKT+OlBBc7fh/2gEF6GfuP9ETgaQ3cXoskW5T0FJ4SiQPUqiPQJ7bSgV0b3zsV5yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636985; c=relaxed/simple;
	bh=mQoafSNJB5Y5HEOClyQOX9wjI8Q/en+Jt45gSH4/81g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=crE1lWcEKglqBuU9fOqiXToiXmX5wd1p0MwBHLvDkKn97cMut3V4EVPL4uUmP/yQLoNQD5t14dPRX713R+letkY6wM+scl4lJKdQn9CsmJYBNi4QharE3JLhoLrLKftx0bgmlasHmo3HY3NyHBtiOhMceetVyUbclPcFhg97N5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RH+a65gf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A9Ysab002995
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 20:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CxCnj6Zj5VR
	O/FPhZdIDI/wmFlKcODkCa+QWZkj1+Zw=; b=RH+a65gf3igh27enEED6eEC6Jof
	GqB21+cIFcdQ4pfSxzMCXNCWzqRRwJE3jMP9ifyvv+XE/xGRCmDtGS4ByumoLA6N
	urPZK73JxJ5pJVItFgdLdUYCOcSVBFk9UG8GKqJHlFE7X4sU6zG/u9RvQTzsqqQe
	kyRk5J4AXAYkF7ExdbFacvUIFeuNDc+SMv9WEhcUvXp7j4O8IZZajgo+2/0Y4c/z
	RaI+821MltoW3VpwBjTQHoiF5zeBQI6cd6EPN9buCAIxkbWjfKpr3w5SBbwR0a4u
	JnaBxb4mUroFEtXu7Fjn4gQsPV6yV57fHTADq4cjCJBK0E/OqoMIHAguLuw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f0pwykr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 20:03:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2240fea0482so120722985ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 13:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741636964; x=1742241764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxCnj6Zj5VRO/FPhZdIDI/wmFlKcODkCa+QWZkj1+Zw=;
        b=PvBjAbXrJgNw2seH1lexR3Y+6oDAU9kfR7dCQ76gYhfno3lpEjg0//+fVAKWFsoKwp
         LPQt+rclxXAA5LlKLsHNUIIXZt6Ggai65pDUYpCMYYTL6y7/xfnqxvCgOLOL7tHhty5w
         U43/mncNNWX4Z1MkTg+jySNDhf9qigQTQ+qr9//9REuil3v1WML3W/HlD5Uu4x8Q1pVb
         ClFxXjvWuBPAzcmfYeMiAu8QZCz9P5X4uZP3tBJ7VVIV4VgBM6bEtoDUvap6LDMkYRKR
         x9ZFYNtBF+K2fKSL8WxCBkcosH8wood8nPgCsAzfd/txsHpy+Hj96hOaJWPqjbz1IR2+
         apUg==
X-Gm-Message-State: AOJu0YyytKFftikkGaBpWe/EDFBR/lzw1buIEzU4rowbISnQv4rdNxfc
	wv2h4FzTWn2LE/ESjfWQHn9ns5QorIgjS1DdtsKBa5lmK/Y0G0RD1X6OzMNzDHEpnvLZTzC303D
	nMe5jwcINjuamkS5B0lZzJ67uCOxMdYCgn815ioVJqPN1qHNs6NpN965mebmxw4PKFabKEiydYw
	==
X-Gm-Gg: ASbGnctPKQhIJOUBHiVqQVRg+EWlse0m22IszMT3MwTWBsDG8Qwmtr9eWq6mVKNFyIb
	/UngWSF0et1OOVadWqwqPtDavpRAoFMDXMb5WUQGE2ypTWhwDOU8XwkjQm881Hzvkg8dG9iyx4j
	mndC8x1zr/yfT7iwMpwshgXcRYzSYQatL6PFXGJZiiCdec0/y1Us56Nq0G9E3CoQHsFM4D6jqg4
	1HDMjjBwZFNEYWtgkD8vNueSy73lTq6K4/XU6tFOpO7Q8MSpYHK8bEzNjnh9edlQexsUnFCMAS4
	gnxh+AwkV/5ID53fQiShIIrbxNuqefq25lNjAGoPwViY+DLCylePD9+xDTQSSAuXBIWQ3TQ=
X-Received: by 2002:a05:6a00:4b11:b0:736:42a8:a742 with SMTP id d2e1a72fcca58-736aa9fe534mr21641346b3a.11.1741636964178;
        Mon, 10 Mar 2025 13:02:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvidx5KJkTSjAEJB9ZDmQS2NOn+ARs6ZuQieF+UAKqF8f27/e5SRU3C4Z9miHp/2u6CPhRxQ==
X-Received: by 2002:a05:6a00:4b11:b0:736:42a8:a742 with SMTP id d2e1a72fcca58-736aa9fe534mr21641314b3a.11.1741636963771;
        Mon, 10 Mar 2025 13:02:43 -0700 (PDT)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736cbe3fb3fsm3730419b3a.83.2025.03.10.13.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:02:43 -0700 (PDT)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        ath11k@lists.infradead.org
Cc: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v4 3/3] wifi: ath12k: pass link_conf for tx_arvif retrieval
Date: Mon, 10 Mar 2025 13:02:37 -0700
Message-Id: <20250310200237.652950-4-aloka.dixit@oss.qualcomm.com>
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
X-Proofpoint-GUID: 9wpbqbkoCw41RSD9FUirr6MGuQAnuBiE
X-Authority-Analysis: v=2.4 cv=KK2gDEFo c=1 sm=1 tr=0 ts=67cf4576 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=66aBALrjW5AsI7a0044A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 9wpbqbkoCw41RSD9FUirr6MGuQAnuBiE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=787
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100155

Three out of four callers to ath12k_mac_get_tx_arvif() have
link_conf pointer already set for other operations. Pass it
as a parameter. Modify ath12k_control_beaconing() to set
link_conf first.

Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 31 +++++++++++++++------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 84da77bf245b..200a2a8ff166 100644
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
@@ -1729,7 +1723,7 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_link_vif *arvif)
 		return -ENOLINK;
 	}
 
-	tx_arvif = ath12k_mac_get_tx_arvif(arvif);
+	tx_arvif = ath12k_mac_get_tx_arvif(arvif, link_conf);
 	if (tx_arvif) {
 		if (tx_arvif != arvif && arvif->is_up)
 			return 0;
@@ -1799,6 +1793,7 @@ static void ath12k_control_beaconing(struct ath12k_link_vif *arvif,
 {
 	struct ath12k_wmi_vdev_up_params params = {};
 	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ieee80211_bss_conf *link_conf;
 	struct ath12k_link_vif *tx_arvif;
 	struct ath12k *ar = arvif->ar;
 	int ret;
@@ -1831,7 +1826,15 @@ static void ath12k_control_beaconing(struct ath12k_link_vif *arvif,
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
@@ -7868,7 +7871,7 @@ static int ath12k_mac_setup_vdev_params_mbssid(struct ath12k_link_vif *arvif,
 		return -ENOLINK;
 	}
 
-	tx_arvif = ath12k_mac_get_tx_arvif(arvif);
+	tx_arvif = ath12k_mac_get_tx_arvif(arvif, link_conf);
 	if (!tx_arvif)
 		return 0;
 
@@ -9322,7 +9325,7 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 		params.aid = ahvif->aid;
 		params.bssid = arvif->bssid;
 
-		tx_arvif = ath12k_mac_get_tx_arvif(arvif);
+		tx_arvif = ath12k_mac_get_tx_arvif(arvif, link_conf);
 		if (tx_arvif) {
 			params.tx_bssid = tx_arvif->bssid;
 			params.nontx_profile_idx = link_conf->bssid_index;
-- 
2.34.1


