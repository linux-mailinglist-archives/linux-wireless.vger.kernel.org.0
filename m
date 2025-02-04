Return-Path: <linux-wireless+bounces-18434-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCECA277D1
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC60163B0A
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B040216E10;
	Tue,  4 Feb 2025 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QPuIK44Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E02421661C
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738688736; cv=none; b=HTih6PypP6OA7sfLjJIbiXg8O/xaj4KHCf4tWUbflks2u2SGkcahb0WFUsh4kOgk37EOWUAYR3l0xkvz0FYJP1RLj4yJXwh3k2hfQ9PuGJ036TBzXkd2YbBJMA0WUjX/mwlbe3nVjRhbYLNg2h3/F1BVkxKQ54UjNTFTQYD6OOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738688736; c=relaxed/simple;
	bh=5m9D3okHYC52yuqw3igqQ23OrYpATKiC13aUYPGPyE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DpuE7NY7QCPChZEPwQjLAEZpjn/6eINH8TfqwkjNE8NCeJ00ZnaY6gOE9fPc5ybV6M0LG+8IbnABi/VOmshxEFngvrY/NbEg3QlYaO60URoua8Ugwm338SuZ6kvcr0bAYKkbfLjEMFd0FZnH76gkhADL25LLCrr++pTrzEW6Hog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QPuIK44Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514BZ7aG011508
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 17:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OL/QcLRIJh0ky121SiQIUudqZdpTL1YzhtN9uKN3Eyw=; b=QPuIK44YH2E+/SjH
	CNBlWWhcTrMxRA6kdQoh8urr66IGa9/MiJCxswKEaxk44ecejCbSARlTDmyXfre2
	hzwcoOQskv2P1+fmNzmsyPo9KB+t6v6G1Tjv4bfTSF+8n4XztTfzni8SVd5/hsH7
	4R1TKIdS2ZPXYCnRfvJbGDBsmtdCCs30ipUaWsL/276wpej5sDBu4ZOHgfYvU674
	bZ0rX4bFWcxotevmFmZaDqQcWfFM+756r/a7YFFckN0W0H1Up546TwI0+dVoEuDd
	YFEPKZShcnig2d3J+yoh1o4Adh4eLuCz1jNedyFDh2sbJFKLI0wk9I6EJwK3++iy
	yMGeRg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kj4ygss2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 17:05:33 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ef80d30df1so10808520a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 09:05:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738688732; x=1739293532;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OL/QcLRIJh0ky121SiQIUudqZdpTL1YzhtN9uKN3Eyw=;
        b=awwFmKMI7dD4b1GH2QtKhFLHZXvo+7Doc9NH2tx9FWvhTS+8hu7HqjP7J0e+5h/5dw
         75SHDymEaxxFvRjD9iZ3YNNvDEwBqxNrXjSU+A6E6kfWP4slEEXABRwYLPPlC77HN/V6
         AmYXsGmgSFwHF9yk5CwkMkERrV/RdUYZbJlPBtKA2ThyWX19B4GydxImwEmPmJS4ay3e
         Jvhps11Uo/rEOHcNSDW3t0VoHCYWzrZgFqAXWyz09vSeZedbuIFs8+oifnU7SB52dC1y
         JQHTD1OVwgNza9UbeDzxOTGAmjd+2nB2h/nFdmj6P6gRB29RXYULTzOvydCWR9dj9Eru
         EpVQ==
X-Gm-Message-State: AOJu0YwJpaoXWWdu7ONlG9tYRPTsLC9k1WC9X1UboI6MBCbSugLlZIFN
	blETDm1JIDzSS1FrggbFz0/AIp95S7C/OL+RezecsxRY76R4XeLubeCHdGqCmjIUGCa73ua2Y3C
	GA8OokfPsupZ1KO8WAY/xCMFdrTeIMMYBbyXR0kBopoZdsWTAh10y0Bkxb1anOXiQ7baPDwBw1w
	==
X-Gm-Gg: ASbGnctN9o5Qn25GfduDw8hdPl67hkwZfvduEPyCglqCM3J66gxWGqfgwzBuOgVaAe3
	rrCrmwc9ocZzJq0U5trVC4nyb3UYRceYiuX9uKK//7nzyaurc4OIaFn/GbjJUXyZ0Kgrt9OF0ON
	4C9xXUlL8X7drh906+10pJbNn6brYoSHZy6QEa6z307Nksce3nYj7JlQWJ4JyBKMqBfv47hLDMU
	KCL4cPFyBDqnAoKssm59RcaSjaDt74ziEBNc2fpKUl8jPz8tl5wp26CFHeybB3O4+pjT232rMkU
	MAf2cjc9ioHA1TAOa6HgGZQEngOwsouJJdM311JqN2rMvM7sbvwBFfSLG9iZ58JGb8Ib/WV4iLE
	/DyVOAxkS+XdPLJI+Q7JUySnhCZEJoA==
X-Received: by 2002:a05:6a00:18a5:b0:72a:bcc2:eefb with SMTP id d2e1a72fcca58-72fd0bcdb58mr38129920b3a.2.1738688730735;
        Tue, 04 Feb 2025 09:05:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMARmptt0ygx1XHCqHB2J4I02VOK37cI/VtiWUK0SRjm18Qm7birg0sl11fNhJ9zPqFGNEgA==
X-Received: by 2002:a05:6a00:18a5:b0:72a:bcc2:eefb with SMTP id d2e1a72fcca58-72fd0bcdb58mr38129749b3a.2.1738688727960;
        Tue, 04 Feb 2025 09:05:27 -0800 (PST)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cddbbsm10772788b3a.125.2025.02.04.09.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:05:27 -0800 (PST)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 04 Feb 2025 22:35:10 +0530
Subject: [PATCH v2 4/8] wifi: ath12k: remove redundant logic for
 initializing arvif
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-unlink_link_arvif_from_chanctx-v2-4-764fb5973c1a@oss.qualcomm.com>
References: <20250204-unlink_link_arvif_from_chanctx-v2-0-764fb5973c1a@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v2-0-764fb5973c1a@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: ZzVzS5m17qXH8q5CvW16iH_D9wCyht-Z
X-Proofpoint-GUID: ZzVzS5m17qXH8q5CvW16iH_D9wCyht-Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040132

The current logic for initializing arvif is present in both the add
interface operation callback and ath12k_mac_assign_link_vif(). The former
handles deflink initialization, while the latter is responsible for other
links. This redundancy could be avoided by using a common helper function.

Hence, add a new helper ath12k_mac_init_arvif() which initializes a
given arvif.

Since synchronizing rcu is not required after adding a rcu pointer, remove
that now.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
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


