Return-Path: <linux-wireless+bounces-18727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7965A2F6FF
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 19:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0699166B21
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 18:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D452566C4;
	Mon, 10 Feb 2025 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RqKcs9bF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160812566F3
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212048; cv=none; b=qqFbLBjD7mBNQj2FpwCbsi8ewEhhpp2EIEIXEoHNGIuD0neXmnTu6/zhrhEWrdHAqyNcVlW81iw1guc51mDQJbNNWDbuTLVeX+Au3bh43noxTzMzurW7dT62eylF6JF6mx0Gvhp89b4MsNiD8/gpEfSMCtr/fNAT9aMnDaqvCtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212048; c=relaxed/simple;
	bh=eNRBWR8T0387RjnoH0yuhYdQrvfgL24CjDXXhNwzmFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vEKw4CuJ275qX9RWpqvG5G/GWGPxGeQyfhsDIXD3yRnop/zre+j8qIdrNk9HVqfRzPkHdTaZY4NdMksDm6QsV9v16rEbjFLHqZMBdRTmX2q7Q6SOGWoriRnbF4XXdCE10hgrI1BXQmViw8vOHDRkwvyz4v802tzKn8VKvhQ7q+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RqKcs9bF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A9UfVb017425
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 18:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=B0+YrNUgIbC
	dXYFJgnwFHdYOJYWa1zgH2LNCJBsZAp0=; b=RqKcs9bF4q+qPQKJRPwh8AeFIYq
	PeZSqo8vxHoRao9eVgd+MvxTvdKUXnbgVNgf5nrrM6k/Cjqp7tFjgLejFRmeRr3Y
	TNzie9mbSjUqEnjtE3b8kNuMVvEzPZlhqGeM3oLonGUGDvsaG/5LKRpHAyrUM3OF
	ch+zXwYokBOrFVPWD7rJkFEApgZauDPJz7qwYo3y4yLuy/nrZj8Ld4JIzh0wgEog
	dc3w5d9j41q01nYw3xbTu99CBdiHFprUXObJp8UAiBoZxmWINPXQFq3JftBiBflb
	uunU0qWsDVWmCLmoXcQKpAVZMZJukXddukehqtyV2d5mql1uZEUsG2Bzb7w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44p0guw83d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 18:27:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21f6b2d49e3so59255805ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 10:27:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739212044; x=1739816844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0+YrNUgIbCdXYFJgnwFHdYOJYWa1zgH2LNCJBsZAp0=;
        b=jbrGciIk+or5VZs+Xf9A9A6vY3Ba1PR5JJ7eroMgxGT3L0X9k0zvR2/0D2I/5u4YnZ
         moE/F6nfXuIiesrQiyqonE6cCFWfyT4eX59XwZNPxA8u5uMSQpiVCOG0IxEYBlWV3AHB
         5eANF7GYaA0eivnO/jW2Bvw0AWsV1xl6d/ntdncGcHka3FkQIEMbeIh1GHx7C8vSVNs/
         vbNWhJwY/JRlbo3uHCxO/9IGzAkJAF3Isjbly7N5HsUeVqcjt22TdmVG3NfhObRlB78U
         yfpheACTQAQ8AWbEKjPmuRYNcS/m/e5a+j7jVr5T4BOE1aO97kAu5uKpfCt7O7t7dELG
         /C4A==
X-Forwarded-Encrypted: i=1; AJvYcCULaW8V9FLtdx3RPnz1MZcRZ0hfDTT0HkxgfIcbZ3NKECSYQYlwJU4fp8T9rnfqYyr6KiLSUqnx7c0jC2vRlg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy5YYjYoAsm36QRU3/jfugGyCPmsr9hGoG+LYniflW5hA8+86F
	SZPIHA0eiIGmzBvZUnM8WDwuWBPOzZ+5SbIpf/BqQhtBnYEN9+0PnOmgELlUXXMi/dFXbQcKSft
	OyjE817ciD8cIZTg5vbkl4ZpmwEJroCgF37Mio7V+AKZo7RCpRGEc+XFhdyBfj6KaIg==
X-Gm-Gg: ASbGncuIvqbrvCn1COQLWrcn0WfssxuIntMRIy6P0B4jxLtQC1nSYwSnZQmBsHgG2Px
	KtBUGCph63mCuSrGSxMkYt+4MTL0npIwBqVDH0adb/qVusJlxjwVy2fLTCxu+vJwa/kv6U6M/WM
	iUiBgNd1rkeWIKcsYTbKiSlgORWYl58Z7hJxgOUUMPNMqQqoghvjXsbNHKWFXoXQLj7qR+VPhr0
	c7i+IMIfnQR4462+MZGhOjpC2AnWBrGh8tgxZa4xPPc7Gi4brQbHuld4CJ26Zw2SCYj959xb6kv
	HYfMIsyoKavga9hgybgX9emJMuh+LQRvz71I6w9L6tHES9J69hMEhTqUZBrt
X-Received: by 2002:a05:6a21:3386:b0:1e1:c4e4:8898 with SMTP id adf61e73a8af0-1ee038c3d44mr27478646637.0.1739212044464;
        Mon, 10 Feb 2025 10:27:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSzHNPPGnNpkh5hpz0y25jL3Bxofc4K0jGt+mLpYgHZb/NDRO6OjyaDbQpQ9N1Iq+XgaRHMw==
X-Received: by 2002:a05:6a21:3386:b0:1e1:c4e4:8898 with SMTP id adf61e73a8af0-1ee038c3d44mr27478611637.0.1739212044068;
        Mon, 10 Feb 2025 10:27:24 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae8e83sm7948372b3a.84.2025.02.10.10.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:27:23 -0800 (PST)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v4 4/5] wifi: ath12k: pass tx arvif for MBSSID and EMA beacon generation
Date: Mon, 10 Feb 2025 10:27:17 -0800
Message-Id: <20250210182718.408891-5-aloka.dixit@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: gmNINCvw6_DKzHr6c9VM-UpzqzYuh2Gl
X-Proofpoint-GUID: gmNINCvw6_DKzHr6c9VM-UpzqzYuh2Gl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_10,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502100149

Add new input parameter to ath12k_mac_setup_bcn_tmpl_ema() for
'tx_arvif' as the caller ath12k_mac_setup_bcn_tmpl() already
stores it locally. Avoid duplicate retrieval.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index e642fba2843e..7d9975db5f47 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1642,13 +1642,13 @@ static void ath12k_mac_set_arvif_ies(struct ath12k_link_vif *arvif, struct sk_bu
 	}
 }
 
-static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif)
+static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif,
+					 struct ath12k_link_vif *tx_arvif)
 {
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ieee80211_bss_conf *bss_conf;
 	struct ath12k_wmi_bcn_tmpl_ema_arg ema_args;
 	struct ieee80211_ema_beacons *beacons;
-	struct ath12k_link_vif *tx_arvif;
 	bool nontx_profile_found = false;
 	int ret = 0;
 	u8 i;
@@ -1661,7 +1661,6 @@ static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif)
 		return -ENOLINK;
 	}
 
-	tx_arvif = ath12k_mac_get_tx_arvif(arvif);
 	beacons = ieee80211_beacon_get_template_ema_list(ath12k_ar_to_hw(tx_arvif->ar),
 							 tx_arvif->ahvif->vif,
 							 tx_arvif->link_id);
@@ -1730,7 +1729,7 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_link_vif *arvif)
 			return 0;
 
 		if (link_conf->ema_ap)
-			return ath12k_mac_setup_bcn_tmpl_ema(arvif);
+			return ath12k_mac_setup_bcn_tmpl_ema(arvif, tx_arvif);
 	} else {
 		tx_arvif = arvif;
 	}
-- 
2.34.1


