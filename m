Return-Path: <linux-wireless+bounces-18366-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3559EA26B0D
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 05:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026E43A2E7C
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 04:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25742045A4;
	Tue,  4 Feb 2025 04:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JvxtmIXj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022A1203709
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 04:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738643050; cv=none; b=EXPwNld1uOPjvKSYixV2F1aFeU3DpB3AdRrQFdQ7PncmS2g2+GbYlfpY8Rg3OSPfFf1k/9VOkNMf1r/DsFx+8mI6OHvSBzo3TQmgQTlM9JjNm7U/AFWY5ynsxUGlV3CPXtD45OJVg4qCQFdf3ZC7F0muv5kYagJbUGAQyTErlcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738643050; c=relaxed/simple;
	bh=czAUF9ihlUTrE5t62GrutrMGkeEVeCGhMcd8UTHifBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rJ9r5TZ9U0JtMk32vTmFl8ewVVyTdi4PRHmF8Ukb/pFNKZMPLkv0AtKyn0ru9sNi3672o2sBmZu64whXoXoDYP1fl+ttC9GRoVd6mDfteaTXsAvhFB00+PUaJZrw7OuhCBws5hJdRb5N5QAn5BWVmMETbYwhfjRTNfQ2OEDgw00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JvxtmIXj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513KQfLJ026948
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 04:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GSD2xSqgc+UtRZaCrfIPDdeC6n1yLrDoUby1rjCIZRE=; b=JvxtmIXjoIYFfxte
	+GG7fsBK6w8KIL09Ut4vyjq3Lykgqm8F2fGSWV1kF4rQvi5YB3pZJBIfwqmvbsRa
	30jS1khygjm3xhRV/oH+SJSRCAaSTDGyLn+J14w6gpm7M2Yi7Wg4OGkLs2PJRmCA
	pC8MVRidmPGrLtXH7DYpVcXqXVSNMdDXJsh2PuqeryBRbiackc8CZGyHTaS1p1S2
	ZuWNLakPNY6CJHX8N5VlG5pcRl1zIKhRBz8FGv2YbwKbys1i8DdatEpFu69LQUoK
	MhTPaG3jjpIybd3DU8zlSJbEtE0ObJjKUMeQDitnBbfBjQqUloydert1CAlqbj9e
	m1XDjA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k4ufrtda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 04:24:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21655569152so113990185ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 20:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738643047; x=1739247847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSD2xSqgc+UtRZaCrfIPDdeC6n1yLrDoUby1rjCIZRE=;
        b=QayVihTPwxfjI94wpPWY76s0U1lJpd5tJ7z7k/DQTMbME/8QXiZSBRV+hckvUUUvk2
         mc4kQsSk070bsZkY7ojhH9EhjruhbPdUSt8X66DjwPW4BhUul6S9hVt5Ex1eRwiHXohT
         4UzDRX3WZVgzcVkxwb8pZUP1b510roIn/j4SHqz8hUBANHbkbBA3ypAIJWff36bFiiAl
         Q+s+rCosxWox/P+nM0pLgK85xGfJ8vwhPpDGUPBidizHC2VyAW7KLDuxiTbFEq9eHRMY
         2PUZ8QdpcxbX0LgU4+FH4sEVUuy4RcFHzctVNTilsFD9eQcZLzSo6mIR5hLGb0B2+uNS
         Mp9w==
X-Gm-Message-State: AOJu0Yz2odFoEgycxmuFHRa8E5OG8gwhF3CcrGnk3OTHrRKeg3kIjEzo
	7tci1SRZm+wyhoZnitgLKFd2AKGMS7SpPORdIwrhbrpmTX7JAjMk3jpKKFgp1aHyu4T3uz5lnO0
	8WL2VcF+H7SVASxabKNNXZTk+QJx+pjmVaXAr6Xq8utNEQqvODId1Kao7ERZjjC8hTQ==
X-Gm-Gg: ASbGncsKYL7EBHYXv9PBbB2SjQQKnfw269TXerjU5jPmdUSZpb/sN4Olxfp80UOL8Z1
	UoMo0ZWM924e9A5qM+PmlpFxSE/WeIuO1mktcttAqL+dTHsTwx/P6wQYvE6plDS2n2pUzwf0duG
	NysSx3hLzP6gdrXOoMUyhtKBk2fUhdWkQB5TBrwSg9Ovl6mTEdy+7ATH3HiRBECx3knADJPiIej
	hynuMZVJ3Wc3bdaLtKeiZK1EoRMuHUWWbI5fUk5OXJ8Aj0RmeHI7oiYhNJySd0Ed0v9+F6b9Dmz
	idhkneiA4dTn0tABHzynzNDq7lXpI1AZU4r6ogqAV2Ul+47ia2HKm44jL5l7iGnOaHZkw4PUw35
	fPrcjXH+e4XzlUn++6Fc0x3rohw6TTg==
X-Received: by 2002:a05:6a21:8dc8:b0:1e0:d934:6189 with SMTP id adf61e73a8af0-1ed7a6e12e6mr41633272637.31.1738643047455;
        Mon, 03 Feb 2025 20:24:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnli/E874b/FlDlx0jep/rC6suUy2lsy1H+BJH6Rq1iVfIuI+6c0/qJ8tC48WQ/GeAsfZA2Q==
X-Received: by 2002:a05:6a21:8dc8:b0:1e0:d934:6189 with SMTP id adf61e73a8af0-1ed7a6e12e6mr41633241637.31.1738643047073;
        Mon, 03 Feb 2025 20:24:07 -0800 (PST)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec04796e1sm8897144a12.58.2025.02.03.20.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 20:24:06 -0800 (PST)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 04 Feb 2025 09:53:44 +0530
Subject: [PATCH 4/8] wifi: ath12k: remove redundant logic for initializing
 arvif
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-unlink_link_arvif_from_chanctx-v1-4-675bd4cea339@oss.qualcomm.com>
References: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 108k6AXwJXl1EP9Wh7pHjZswiXF5xpiV
X-Proofpoint-ORIG-GUID: 108k6AXwJXl1EP9Wh7pHjZswiXF5xpiV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502040032

The current logic for initializing arvif is present in both the add
interface operation callback and ath12k_mac_assign_link_vif(). The former
handles deflink initialization, while the latter is responsible for other
links. This redundancy could be avoided by using a common helper function.

Hence, add a new helper ath12k_mac_init_arvif() which initializes a
given arvif.

Since synchronizing rcu is not required after adding a rcu pointer, remove
that now.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 80 +++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 7defc2b20fb61dcaec06d0e332c48a1b6cd2f5d6..5f0388002e16c38a834d6c7c6c020b7afa7044f0 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3973,13 +3973,59 @@ static void ath12k_mac_op_link_info_changed(struct ieee80211_hw *hw,
 	ath12k_mac_bss_info_changed(ar, arvif, info, changed);
 }
 
+static void ath12k_mac_init_arvif(struct ath12k_vif *ahvif,
+				  struct ath12k_link_vif *arvif, int link_id)
+{
+	struct ath12k_hw *ah = ahvif->ah;
+	u8 _link_id;
+	int i;
+
+	lockdep_assert_wiphy(ah->hw->wiphy);
+
+	if (WARN_ON(!arvif))
+		return;
+
+	if (WARN_ON(link_id >= ATH12K_NUM_MAX_LINKS))
+		return;
+
+	if (link_id < 0)
+		_link_id = 0;
+	else
+		_link_id = link_id;
+
+	arvif->ahvif = ahvif;
+	arvif->link_id = _link_id;
+
+	INIT_LIST_HEAD(&arvif->list);
+	INIT_DELAYED_WORK(&arvif->connection_loss_work,
+			  ath12k_mac_vif_sta_connection_loss_work);
+
+	for (i = 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
+		arvif->bitrate_mask.control[i].legacy = 0xffffffff;
+		memset(arvif->bitrate_mask.control[i].ht_mcs, 0xff,
+		       sizeof(arvif->bitrate_mask.control[i].ht_mcs));
+		memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,
+		       sizeof(arvif->bitrate_mask.control[i].vht_mcs));
+	}
+
+	/* Handle MLO related assignments */
+	if (link_id >= 0) {
+		rcu_assign_pointer(ahvif->link[arvif->link_id], arvif);
+		ahvif->links_map |= BIT(_link_id);
+	}
+
+	ath12k_generic_dbg(ATH12K_DBG_MAC,
+			   "mac init link arvif (link_id %d%s) for vif %pM. links_map 0x%x",
+			   _link_id, (link_id < 0) ? " deflink" : "", ahvif->vif->addr,
+			   ahvif->links_map);
+}
+
 static struct ath12k_link_vif *ath12k_mac_assign_link_vif(struct ath12k_hw *ah,
 							  struct ieee80211_vif *vif,
 							  u8 link_id)
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_link_vif *arvif;
-	int i;
 
 	lockdep_assert_wiphy(ah->hw->wiphy);
 
@@ -4006,25 +4052,8 @@ static struct ath12k_link_vif *ath12k_mac_assign_link_vif(struct ath12k_hw *ah,
 		}
 	}
 
-	arvif->ahvif = ahvif;
-	arvif->link_id = link_id;
-	ahvif->links_map |= BIT(link_id);
-
-	INIT_LIST_HEAD(&arvif->list);
-	INIT_DELAYED_WORK(&arvif->connection_loss_work,
-			  ath12k_mac_vif_sta_connection_loss_work);
-
-	for (i = 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
-		arvif->bitrate_mask.control[i].legacy = 0xffffffff;
-		memset(arvif->bitrate_mask.control[i].ht_mcs, 0xff,
-		       sizeof(arvif->bitrate_mask.control[i].ht_mcs));
-		memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,
-		       sizeof(arvif->bitrate_mask.control[i].vht_mcs));
-	}
+	ath12k_mac_init_arvif(ahvif, arvif, link_id);
 
-	rcu_assign_pointer(ahvif->link[arvif->link_id], arvif);
-	ahvif->links_map |= BIT(link_id);
-	synchronize_rcu();
 	return arvif;
 }
 
@@ -8312,19 +8341,8 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 	ahvif->ah = ah;
 	ahvif->vif = vif;
 	arvif = &ahvif->deflink;
-	arvif->ahvif = ahvif;
-
-	INIT_LIST_HEAD(&arvif->list);
-	INIT_DELAYED_WORK(&arvif->connection_loss_work,
-			  ath12k_mac_vif_sta_connection_loss_work);
 
-	for (i = 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
-		arvif->bitrate_mask.control[i].legacy = 0xffffffff;
-		memset(arvif->bitrate_mask.control[i].ht_mcs, 0xff,
-		       sizeof(arvif->bitrate_mask.control[i].ht_mcs));
-		memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,
-		       sizeof(arvif->bitrate_mask.control[i].vht_mcs));
-	}
+	ath12k_mac_init_arvif(ahvif, arvif, -1);
 
 	/* Allocate Default Queue now and reassign during actual vdev create */
 	vif->cab_queue = ATH12K_HW_DEFAULT_QUEUE;

-- 
2.34.1


