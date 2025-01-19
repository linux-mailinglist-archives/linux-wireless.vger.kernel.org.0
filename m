Return-Path: <linux-wireless+bounces-17686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB2CA16054
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 06:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FA03A6D1C
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 05:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7F56BB5B;
	Sun, 19 Jan 2025 05:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UYUuPU9Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D118318A6AB
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 05:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737264185; cv=none; b=rwt3bW38EgsBEqa0r6PfvoLMY2220F+xC+eucKk77bSb9AFQ376Lxf6uQJgH6KsNiMR6hOdnEztg58UUM0VCxIrciGF7aseTRlYJYHlmijnqaaFpKAzDWzSlBbNG+YVU9OFdXVnIPuDs3J2rzwW7UNAL86E8rt9TZ4nOxMf3QMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737264185; c=relaxed/simple;
	bh=bk9qEEoPMlF+79agH2HZ7adS0CDmzxcpcwx7UALwfoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vx8aH4/yNaNKNqL00DuaWW/SJbf4J4ds+NCoKHsu6Wnux+1Xu5L1lTlW/8nddYc1e3YzoIVSzJpdea0R2EfgEkVuuEl3ajHIfw9ZqAC4K8plooR7V2j9aR6lL04f5RYqJ1zvIZSwmKddiTuhLARy0BMS8uZ9HDm6yDWA1+1m/tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UYUuPU9Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50J5BndD013509
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 05:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bWF2AYasCMg
	5uCMhaNoiBso1sId8vJR61mxzZj14q9M=; b=UYUuPU9Q3OofOf9goAdh2P9CoAz
	uZFsEGS2pXWC22tfMDg/HDLjj4+iLS5bVCmU76w8PZDazM8XJjsgb56wH3BgeMQi
	kuJfCloOxeh48Ixjj54SfocvIu4r+xNNEpYwV5CAvmCMKM7tPZ019wlw8hvuKZzA
	F1A3Fi0sfn9TVCHbt0ZQSw1gkOYOYpSpkp47j1JMHGkIIXLgIwzGCpxh8EwrnP2E
	+oJiUlOcNlYC36h+4CggBKUg2JFKKrpZ3c/1UIlwfFA9w/lRKEot2noaR0tQFKjI
	0YC8m1huvlfQku21M3wQHhYa9rrd80HDQnWkwUWWgcvTRaqyEyKqsvdD4xA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4485k7sgh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 05:23:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef35de8901so6341838a91.3
        for <linux-wireless@vger.kernel.org>; Sat, 18 Jan 2025 21:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737264182; x=1737868982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWF2AYasCMg5uCMhaNoiBso1sId8vJR61mxzZj14q9M=;
        b=Cv+D3Nw4w6vaSglE5/kjss0vBLRgjF9D4Dn4YCHvhf++QuN1zrJ/rJPtUU+Dy6T7hz
         okvmihLR1T8+DaeHEtxgr0AxCdW7hyPeXo90bH8t3iPmoRz1vUkrjXUoTPlsvCZy/IQp
         Ov2uPwGm0ChnbVYz4lSEYf4uI1++40Ok2E/17/j9id208z/MNl3ZHEIro4x8eKA45cBb
         pJqiVV3au0vmjgidovHTMbHyW5lv0EvYyvhIBT8pCT7y6gXxAXWYN8YjpWsDpQ5rTWYK
         1h/rho87zCMYYmI9H0DsLOf4jZHBcOaepHIto1+EqgfUiLe4ETkynBpfvSGLvvikrPHC
         3KPw==
X-Forwarded-Encrypted: i=1; AJvYcCU0bnKKAs3Nob3AdOnG4gG3YFN7Q2ZyLOo0MbvTul6/D2DSqH3Kttf0YRmgs1JYUKuvzy+rnIf39PzgnFaBfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhy+CE3FnQU+vp8Pd4e3JBug8s4eAKzUYjcixiLwwNWpG3I241
	SELleEv0dM8i61m8bejj71uAn8tj1hUAEZNolzRpZYsnn6QBgiNjZ36JMvHrLOiBDPVvP+uIvWB
	r85uUjZz1f4PZ+KrT54BO5IhTVCkdLO2YpkTzIQeaeKkn9Nz8Pjpx6nXZDnmWvxBjwuTLeWsawA
	==
X-Gm-Gg: ASbGnctm/GEv5/MmYNSf2uv3Ob+3rdHkDMMLQCpvtzX8VHQA8X3pZryDbxlCouM9Op5
	68uFvCBNpYA8+aXj8ny+XJFQQL2+ib6AcpjCPqB+7kHxi31gHSQO8YtsbKTnda3fm3MqooMoosa
	x8WtI5u2g82Ek9sQxs+L4gbdBHzxLHQ1rJsdIrT2n9iQH6WRXlQ/vnj2xQ1oj02otiojuiBWkz4
	e39IvJbFO73d21XUp4tkXPpTh7AxvffZF4QXyfaTSgaIrK490qTjF+W4FzI44FP9V7QOXFDeDv1
	J/bF0PcQsVXKfr0/0BByKmMk6SrwwC3H1cqSChXLDk99ww1WoQ==
X-Received: by 2002:a17:90b:3d47:b0:2ee:cdea:ad91 with SMTP id 98e67ed59e1d1-2f782c9cb29mr12805279a91.15.1737264181684;
        Sat, 18 Jan 2025 21:23:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF46jJvNdu6YUYpU2g2VsKnzXDiiDvWlUcaQ9i4OcqEH1lgmDFUeIsxaU2CLgHGUCdIzvTh5A==
X-Received: by 2002:a17:90b:3d47:b0:2ee:cdea:ad91 with SMTP id 98e67ed59e1d1-2f782c9cb29mr12805259a91.15.1737264181270;
        Sat, 18 Jan 2025 21:23:01 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77611a295sm5062553a91.7.2025.01.18.21.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 21:23:00 -0800 (PST)
From: aloka.dixit@oss.qualcomm.com
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v2 5/5] wifi: ath12k: pass BSSID index as input for EMA
Date: Sat, 18 Jan 2025 21:22:50 -0800
Message-Id: <20250119052250.3488343-6-aloka.dixit@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250119052250.3488343-1-aloka.dixit@oss.qualcomm.com>
References: <20250119052250.3488343-1-aloka.dixit@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xdo3ohdDnVGF7m742-pXttu2vUL8Skha
X-Proofpoint-GUID: xdo3ohdDnVGF7m742-pXttu2vUL8Skha
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-18_10,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501190042

From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>

Function ath12k_mac_setup_bcn_tmpl_ema() retrieves 'bss_conf'
only to get BSSID index which is an overhead because the
caller ath12k_mac_setup_bcn_tmpl() has already stored this
locally. Pass the index as an input instead.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8a856cc1d801..05a0a6f0dc9b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1563,24 +1563,15 @@ static void ath12k_mac_set_arvif_ies(struct ath12k_link_vif *arvif, struct sk_bu
 }
 
 static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif,
-					 struct ath12k_link_vif *tx_arvif)
+					 struct ath12k_link_vif *tx_arvif,
+					 u8 bssid_index)
 {
-	struct ath12k_vif *ahvif = arvif->ahvif;
-	struct ieee80211_bss_conf *bss_conf;
 	struct ath12k_wmi_bcn_tmpl_ema_arg ema_args;
 	struct ieee80211_ema_beacons *beacons;
 	bool nontx_profile_found = false;
 	int ret = 0;
 	u8 i;
 
-	bss_conf = ath12k_mac_get_link_bss_conf(arvif);
-	if (!bss_conf) {
-		ath12k_warn(arvif->ar->ab,
-			    "failed to get link bss conf to update bcn tmpl for vif %pM link %u\n",
-			    ahvif->vif->addr, arvif->link_id);
-		return -ENOLINK;
-	}
-
 	beacons = ieee80211_beacon_get_template_ema_list(ath12k_ar_to_hw(tx_arvif->ar),
 							 tx_arvif->ahvif->vif,
 							 tx_arvif->link_id);
@@ -1596,7 +1587,7 @@ static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif,
 	for (i = 0; i < beacons->cnt; i++) {
 		if (tx_arvif != arvif && !nontx_profile_found)
 			ath12k_mac_set_arvif_ies(arvif, beacons->bcn[i].skb,
-						 bss_conf->bssid_index,
+						 bssid_index,
 						 &nontx_profile_found);
 
 		ema_args.bcn_cnt = beacons->cnt;
@@ -1615,7 +1606,7 @@ static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif,
 	if (tx_arvif != arvif && !nontx_profile_found)
 		ath12k_warn(arvif->ar->ab,
 			    "nontransmitted bssid index %u not found in beacon template\n",
-			    bss_conf->bssid_index);
+			    bssid_index);
 
 	ieee80211_beacon_free_ema_list(beacons);
 	return ret;
@@ -1650,7 +1641,8 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_link_vif *arvif)
 			return 0;
 
 		if (link_conf->ema_ap)
-			return ath12k_mac_setup_bcn_tmpl_ema(arvif, tx_arvif);
+			return ath12k_mac_setup_bcn_tmpl_ema(arvif, tx_arvif,
+							     link_conf->bssid_index);
 	} else {
 		tx_arvif = arvif;
 	}
-- 
2.34.1


