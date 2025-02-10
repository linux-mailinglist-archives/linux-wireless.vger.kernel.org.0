Return-Path: <linux-wireless+bounces-18728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9615AA2F6FD
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 19:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2470E1888535
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 18:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D0B257426;
	Mon, 10 Feb 2025 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CVu0v+lM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C702566F9
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 18:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212048; cv=none; b=FGTjrBGz9Ct2RDRHDGmjcnffv44uAjfoHgbO6a0sPw1J70kKEx8P2mJ6wktCkfIKJ17Spg6y/Do451jx0xt1kIjqtCfdITJAXEEzaFCNIhgPd4apaZPyPdpZH1iUX9uiuydkCLX7tQXWlJKwqKBP6MUwRviBzPAMLP18MFiMbx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212048; c=relaxed/simple;
	bh=hIsS3Ehx5jTmk+3BGaJcqL9j81kadTIhUmUYlM2o3M8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=THSt1+eNipcE2V+xJGWlc/hHhfXVxJuU4Yn2cz59FCXiAd3cvO6Sw7fpV52UbA4SSCCU0+EuY3IsXF7zTFuPzHDQUppGPRWMsEx91PtkhVjdNAace9InUgpgGLBHHqJD4m+n3V6eFk9pRp35xcWPXgzyMmMtUatVDQm6CxlnvR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CVu0v+lM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AHvYjT015777
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 18:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=TRldpQYUQvD
	9jkKM217c1U/kKH2mifVb0NoATjuLbvg=; b=CVu0v+lMOXT5Qnw64tY2EIj4Lbb
	jNNYt8dWibWDblAP8tBsqVKvAm1heu5r3V03Wc27zm8N/A1QCFM9jra5wn9dJVge
	AUpx/Lu55SYo7mRL//QWjO/H/tvjMXPHSPgF1jcQGiyBeAJ+EPPXA7M5rclav4f/
	+7aAj4SLxNF4XVaIscdbJZP5coPtZ4rkgkjkUeQmnNJUw41neA1CsHE6KREkijhK
	0akPRfFdlcKE1aGgblsgixFwPNMejMGSqo4smNYgHJqDa7tiAQMYIx73cquXTmdn
	4CwbsQsZmOtlc0PpPaXzcDezGQi3LWVuUiNCEg+I8mMcj8xCL0FjhA7rWlQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qe6nskc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 18:27:26 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2f816a85facso10100546a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 10:27:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739212045; x=1739816845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRldpQYUQvD9jkKM217c1U/kKH2mifVb0NoATjuLbvg=;
        b=qNt3v5o64NO0RwZdp9/YF3HZhWnz0+tDohOOlifwmucwLqd8zvJWQPOzVlkAiEVpAB
         9YQGBfgb4Lr2XXpoSuaysKvPicAl/smvSkSLigDgJv8gNCjF7/mEWMKOXIil8NUb/gwM
         FdksVWTQY34vscoqLbdWLZ6n+dKQpc5BZGd22yQEExZJ+gDzrn3xOYauZJuOAUL6n9Zh
         aTObXEvTPnUJuXec5xC2CwW8AqmcKf9l3sk2Y2l2XS6ukumQkIJoHE67whKH0+6uv4k1
         wbSwODHEQMSDsglmJ591znIKSzt5KLSIfVuHS0OX/DJ8QC2l8gNWZv0NoLPuP4RB7y92
         uoCA==
X-Forwarded-Encrypted: i=1; AJvYcCXS0h2bkc3xO9G8gdKYsVu+UEgEbZvPi48zvPnsn9+sLJoK/5Y02jYt1wAayaDKEsaL7MnwGHeEMkcnyW1Wvw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7isEt6AkOQIKQ8wcdwbt0+76+cmOa6UYT5iy4SgGd3JGuYrUl
	K8bB7e9q5in0XoGA8WIcxB3/7lHjAtcUqsgK193Xj49U1kU6SVeiIcnh8wFavTwlOwN3Mv23UB/
	4XpPxG8Ix6p85WV7lROdrUJuV2vufo+EAFibV5SW3ce6dLz2Roha5fvSJeLu2B+HS6fctPZYzhw
	==
X-Gm-Gg: ASbGnct9AuYuTC/ZmXWvqdeajAB2vzmViiJyM61Qo2V6SgWpxSbFzBc67clE32J81Bp
	35au0Lq+egAIGl9lIuR5ud/Kmhq4RQu0FuaAf4r1UZNaq2dAVNV3UKLjK4dyxAVBTPbgdnkrXNU
	TnFysYbluviMge93y2DJnLY9U8O70mQY9wRmcLAhxbbFVnlWZC9TDYUEkbxbPyUQfamB3oQCOUl
	2kbJeq1wDIJB5rRvehTnZYNLFdE1p6B2JrNu43+zFMPPa1ek6rBL6rmqi8B+zspS2mR+JTc/JhC
	VzyqrPNAf43qLJUI0Wa3R1n2vh3OfDwIXC1T2alZEa3i9+92Ab+Dtgl0ZX3V
X-Received: by 2002:a05:6a00:9a0:b0:730:937f:e838 with SMTP id d2e1a72fcca58-730937fea2amr6447012b3a.22.1739212045339;
        Mon, 10 Feb 2025 10:27:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeBK/mItKMGA0ZEn/2StC1+xoy1tpmMDTSchldtUYmYaQRFa7Vr5lyV+4W3tx9mXCEgZ4diA==
X-Received: by 2002:a05:6a00:9a0:b0:730:937f:e838 with SMTP id d2e1a72fcca58-730937fea2amr6446972b3a.22.1739212044924;
        Mon, 10 Feb 2025 10:27:24 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae8e83sm7948372b3a.84.2025.02.10.10.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:27:24 -0800 (PST)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v4 5/5] wifi: ath12k: pass BSSID index as input for EMA
Date: Mon, 10 Feb 2025 10:27:18 -0800
Message-Id: <20250210182718.408891-6-aloka.dixit@oss.qualcomm.com>
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
X-Proofpoint-GUID: PqLVPNg4QtJXJXSqvIlaSQNa2bvAvh8D
X-Proofpoint-ORIG-GUID: PqLVPNg4QtJXJXSqvIlaSQNa2bvAvh8D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_10,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502100149

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
index 7d9975db5f47..67a4f555f30b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1643,24 +1643,15 @@ static void ath12k_mac_set_arvif_ies(struct ath12k_link_vif *arvif, struct sk_bu
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
@@ -1676,7 +1667,7 @@ static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif,
 	for (i = 0; i < beacons->cnt; i++) {
 		if (tx_arvif != arvif && !nontx_profile_found)
 			ath12k_mac_set_arvif_ies(arvif, beacons->bcn[i].skb,
-						 bss_conf->bssid_index,
+						 bssid_index,
 						 &nontx_profile_found);
 
 		ema_args.bcn_cnt = beacons->cnt;
@@ -1694,7 +1685,7 @@ static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif,
 	if (tx_arvif != arvif && !nontx_profile_found)
 		ath12k_warn(arvif->ar->ab,
 			    "nontransmitted bssid index %u not found in beacon template\n",
-			    bss_conf->bssid_index);
+			    bssid_index);
 
 	ieee80211_beacon_free_ema_list(beacons);
 	return ret;
@@ -1729,7 +1720,8 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_link_vif *arvif)
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


