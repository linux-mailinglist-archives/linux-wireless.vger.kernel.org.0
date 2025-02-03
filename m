Return-Path: <linux-wireless+bounces-18321-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0635DA265F6
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 22:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93EA83A48DF
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 21:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0A120FA9A;
	Mon,  3 Feb 2025 21:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y5DEUB5w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC18211269
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738619099; cv=none; b=vBmizOGWFLJi//oltXlVfOYsu/c4xnuz7hl7RSDYqwxsOdNpMMZgvqw97Gpj5LG6xTNj6iEJhFk8IOqykPPvL7uMRObN8kPakhnKdyhWjAtrhTBvlxZ8pqvsu7P2itlmLsAcgbHChAXUHQnhQp8PM4Jdl/xaVWZKFekVKqOiSfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738619099; c=relaxed/simple;
	bh=FEYjzaKspZJqKJcOJL4Ipsjys/joHP1FW+MSJETQDUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NvB80A2Xvx6MsbPZN8jjFvdYxCX78ecvV9pmjBPNCmy7qx3Gt7o12HX3sHe+RKwHcpTgZ7D6MrKkBz1P75IyE0MtDEkFRgDBcDReMg7bMAA4JSyj8pU0MriSK5UjiObggvnT596q4EKjxTcHGv5LFEgwXiQowJIoUHdLuOcYBJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y5DEUB5w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513HfVi3017325
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 21:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jW6HwO/qyQ8
	ldqkF8vmg7N3AHYrGXs/JkvKQvxQSsz8=; b=Y5DEUB5wxzU/ErLzIpcWu03BLp0
	+BGR2FhT7SYgex4bcSADug7Wm1iSjs0C1tGD6oH/ozx4AyP30PhWLaTm/6ky+5WC
	cL47sPJxSAnZuayo6873UPjJZqwVvquQbuSpPkfp5LMw8uVEZkP+4FkAvQTsEkyo
	7cYcsNL+OPtlCAUzdlY8se0AR+QRm0D3RrL/v2RH7mREkbMG9TeR4P0JkP0+Gn78
	gyp1/GAa6VAxCTAC3WmF5UUqb3tDba27xJxSAiSLk1Gv9YlRE4VPaDdGjDKOqjun
	/utwRy8HmHhXRYiX3LHaBnUFy0HCFrjD6vFirJDYxnZAAOl+YkghmP3gYmQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k2e1gghb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 21:44:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef9b9981f1so13623286a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 13:44:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738619095; x=1739223895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jW6HwO/qyQ8ldqkF8vmg7N3AHYrGXs/JkvKQvxQSsz8=;
        b=PNpPB4145IGGA1xKpCCQwmZjtzGPpg21uCtpyKNp0xayUFjyxtefCKoaBW1vo3/ttV
         jGJgO4GBiV+3jbczUWtrt2y13q6fLmzCFdKXr9zRnor76zlpMPlscRRLYl9IP6RP6jya
         oGE53pXs5ml9oJfn8ozZVod0fZ6+7WhUwJ2ngmpRYvfIjhDrKTh5zzZr4e5EgWvGUryq
         NB+YGy4eNiyrX4kYRzV7apR/xn42jEJqSkoH1VXUXH+Ojbosr7AsR+LNUbbUV+sVmSPN
         khzbJUPI33dSNHzK974hcgzaPahKYsmrv1fH2UnuOOykC8KMhfkYl75dgV2b1U/xoTRO
         C9uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmkJdWURXGPpAEHKpUcEmA0RCk5mByicI9LjOMpIPHA9P6LJT3pBAtUPKwaw97L3kRNUVZ1d6/JHLsx6UQhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3xogGzQaZWqTm5rQo7rZvYDsJCvuRgE2BAgMU/pMDSAm04Hle
	lkeZOia1FIXmVSvrfr78ZMJtoUyoFtpI+xgNCytmJySS6i8KNrEhH8DRqvtZCHfWhytSM8iCSLe
	vfhaS1LayC5x6jejavpIx89sGi7BcMnG/I3brGIo8WgDCgp51dWMp+KyxfVdGyGmvKQ==
X-Gm-Gg: ASbGncv9EprXClnJKkBqU+NEHbnMoAH/VK32eMlSa6O981nqIPPZh6slNNopxvjawdo
	NcHE2NmnDYKnIe/6GBS+z3jQUIkTDWEgdU69eEeEy1IJYuZN9tKMKiF3rKYXoDWUboQ6hSAxkwG
	atdyVUzcoxPGzxEnKrgQ1DBqqy8So4isLjylB358ugTHkak7J4t5+mDoeHRNweJI9SQT1FYjAbb
	U1DsOEeHoCw5p7NI/bRJxNZlmotJCw5M2+xvwEyLhtxrr+5HT2RJ9vfh9ao/7aXewQXBZWJyRXs
	Wtxf1GegUufVw1WxCEq5a/ICTXqCcVYYeIk1dw0F/Vawp/wIUt79VKNHG1wn
X-Received: by 2002:a17:90b:53c4:b0:2ee:d63f:d77 with SMTP id 98e67ed59e1d1-2f83abd7ccfmr36001574a91.9.1738619095121;
        Mon, 03 Feb 2025 13:44:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwJd39vaZmazZzFpg8uh7/VVetZSQp/x673t3NGMiSgjrhKf3+jKS8K40tSAFiD6P8umYlEw==
X-Received: by 2002:a17:90b:53c4:b0:2ee:d63f:d77 with SMTP id 98e67ed59e1d1-2f83abd7ccfmr36001555a91.9.1738619094789;
        Mon, 03 Feb 2025 13:44:54 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de331ce6asm82357895ad.209.2025.02.03.13.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 13:44:54 -0800 (PST)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v3 5/5] wifi: ath12k: pass BSSID index as input for EMA
Date: Mon,  3 Feb 2025 13:44:48 -0800
Message-Id: <20250203214448.1978156-6-aloka.dixit@oss.qualcomm.com>
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
X-Proofpoint-GUID: U3iqyR2K_PlgcJSnRV5I6QIapFb8zCIL
X-Proofpoint-ORIG-GUID: U3iqyR2K_PlgcJSnRV5I6QIapFb8zCIL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030157

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
index 90823b85b714..5ec82c881b3e 100644
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
@@ -1695,7 +1686,7 @@ static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif,
 	if (tx_arvif != arvif && !nontx_profile_found)
 		ath12k_warn(arvif->ar->ab,
 			    "nontransmitted bssid index %u not found in beacon template\n",
-			    bss_conf->bssid_index);
+			    bssid_index);
 
 	ieee80211_beacon_free_ema_list(beacons);
 	return ret;
@@ -1730,7 +1721,8 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_link_vif *arvif)
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


