Return-Path: <linux-wireless+bounces-18369-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFD5A26B12
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 05:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2110F165F5A
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 04:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B24205AD5;
	Tue,  4 Feb 2025 04:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eX1zT/y8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA81B2054F4
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 04:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738643058; cv=none; b=VPFESP2EolbviJ2KJoEIhph/WY4pwCYRCUPTj/drs3T/WsURqYa3ROAB5c1r1HKi0BxKeRXGLB9VKLy3A1kOIoQmb0hRVSBkXxGtzfhyrt85yffC99mUZrAIR02wLez2XTCfAd57URI0EtgbCD/3Gw4heoJevs/csgoEEhU9MlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738643058; c=relaxed/simple;
	bh=6+4xk2qwahdHWPYlJdCB8T7RNkmPa/xjG/CLQ+Pp5bg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DyJRntG2LofnwfF+WJyDoZcR6/MHcboTPziuRPfgtovEZ4qqyWfWbwvGV5IvKRIuNZrm9BDNAdTd5j0A6xSoE8mp27ANZz2QEO0uWSio6JpJFd5tyJGLtPUm2sfdH6muqUwk0HiLd+ObleGufK7ZwxoYjCPA7lOs1E+R7bMGugM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eX1zT/y8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5141C1mp022107
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 04:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HrVb+INNM+z4pj0PiN/+xSGN0XHpDBNtY7UI5NNgmI8=; b=eX1zT/y8Q28g6+lI
	NelVFC6kdNacEmslF/iin8/O1Naf/xHUKjwqX4j4fnl4bedPYzE0KESrGmMS1icn
	0IUmvxUvCUS4X7c2I1lenjqIj6dYvzVDGM80JORLccDn6S/85mU610sNlLKdLScM
	ZA/hzo7H5MRPSlhhQvrPPEM/n8RKkF7yZ1a41yvmnMeZJpba+ikyaMO3tx9fjL/W
	Oo1E4gCvr50DTUhRVo7y18tlBU6Y6SYu4yiayugVE0OCsLsfcInCsUSE9xezO82y
	7S9QB0qyvjfLpisHjGKOClwDliXEhUr3EfSOIXJZge5c/l6wB0by7eQAYgQFaDD/
	FVou0g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k911gahd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 04:24:13 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-216430a88b0so111505135ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 20:24:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738643052; x=1739247852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrVb+INNM+z4pj0PiN/+xSGN0XHpDBNtY7UI5NNgmI8=;
        b=ZSaNB9RHYpLt+UntIGJiN86zfyfTuGXWhBysWpcKBG49FYvhhxFyx4USjCS09xjEtv
         2mFhcPqPhsAcKv/V2DwMqFwRSPEC/aMxh9Gn1cSkzTx5g9NsdBjNPzX8lD58eanfVQSU
         7wTyxlnr6GOODhZgSvBzoodhInXpJbbngrKAdWr20PZZV5EXMbLELqG93xscOPdlWtuO
         9Y9hj5gq9umvpuVcTnocl7p2qixnsdpNJ0c3dQmsGkTlxQUBozu6e40rp7oPxi7Nd7h7
         Ywc4D1Y2n/FBj0nJJgRINn/76Eb8nmQjvloUS/ZcXGxV4j1/QKJXV+E1ue+zhhbtCNcS
         Z0Zg==
X-Gm-Message-State: AOJu0Yx/Af+d1E5PRZa9ng9OPYUCDnMgceVWLogyJbEgEX4GlYjGSJJ0
	0O67v2x1v8A4kp04WA56I9Or4Ij135GQlkvvxsUyf5Mw+hPsyjs8ctnB6X/2ixLm9PSydDjT8Bj
	wHo0+I9lj2dXDrrTpy+u2A35eurVl/RhV0vo3IeXlgHNhw2FkJMHHN/vDD94Ol1xHQQ==
X-Gm-Gg: ASbGncvhJ06sCp+aI2QR71YzyqgABVjK+RSnw63JmJ5WFnfjSer3Kb61saa72WSrLKQ
	6BFDdogQ1n+Vmm1OAzd0a9GHRrKv2scbjntInLgHPykMFcCvjvgUsWfx8pdp5pUH0//CkDErAN1
	NLiW4GXqMIfKVogPSqkVR4mh75v2KnLHVYffC6+IJhz2osEmJPiY0cLk/3n3WIP0GJNMUfklh76
	YkUrZDHGlxmhC9P+TcwYyZkLP00Lx2ZffgG2ePdDx2I7IGwYDE++IaJUqxAOt0IRAWArKfR+ksa
	n/ovZeiusSjqfJCewmLnfpWzIgjvUkCjJfWIFeKMJx+Ks5LlQR4T1boOYOaHNpxLXx/Q4/6q/GL
	9i7SgbAfnJ+fIxQlBug4SwfNwK57INQ==
X-Received: by 2002:a17:902:d48e:b0:21a:5501:938 with SMTP id d9443c01a7336-21dd7e38e38mr386772195ad.52.1738643052112;
        Mon, 03 Feb 2025 20:24:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE49ECwcCEgYzSew4ZO7UPQc13n0Kq+P/s7ciZAzDlfP1uq9+He2FL6XzGDxNA6kiAXbLbiUQ==
X-Received: by 2002:a17:902:d48e:b0:21a:5501:938 with SMTP id d9443c01a7336-21dd7e38e38mr386771925ad.52.1738643051669;
        Mon, 03 Feb 2025 20:24:11 -0800 (PST)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec04796e1sm8897144a12.58.2025.02.03.20.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 20:24:11 -0800 (PST)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 04 Feb 2025 09:53:46 +0530
Subject: [PATCH 6/8] wifi: ath12k: relocate a few functions in mac.c
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-unlink_link_arvif_from_chanctx-v1-6-675bd4cea339@oss.qualcomm.com>
References: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: jfNCYOK0gw5fZE2L5CvEK_o5SyqGINiP
X-Proofpoint-ORIG-GUID: jfNCYOK0gw5fZE2L5CvEK_o5SyqGINiP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=945
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040032

An upcoming change will invoke ath12k_mac_init_arvif(),
ath12k_mac_assign_link_vif(), and ath12k_mac_unassign_link_vif() from a
line located above their current definition. Hence, relocate these
functions to above so that these can be invoked later on.

No functionality changes. Compile tested only.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 202 +++++++++++++++++-----------------
 1 file changed, 101 insertions(+), 101 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index db866c1419a613103f119037b19e24b7edaa6c24..5d80bbb664ea6a710eedd7b57db3523df9c893e6 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3469,6 +3469,107 @@ static void ath12k_recalculate_mgmt_rate(struct ath12k *ar,
 		ath12k_warn(ar->ab, "failed to set beacon tx rate %d\n", ret);
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
+static struct ath12k_link_vif *ath12k_mac_assign_link_vif(struct ath12k_hw *ah,
+							  struct ieee80211_vif *vif,
+							  u8 link_id)
+{
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif;
+
+	lockdep_assert_wiphy(ah->hw->wiphy);
+
+	arvif = wiphy_dereference(ah->hw->wiphy, ahvif->link[link_id]);
+	if (arvif)
+		return arvif;
+
+	if (!vif->valid_links) {
+		/* Use deflink for Non-ML VIFs and mark the link id as 0
+		 */
+		link_id = 0;
+		arvif = &ahvif->deflink;
+	} else {
+		/* If this is the first link arvif being created for an ML VIF
+		 * use the preallocated deflink memory except for scan arvifs
+		 */
+		if (!ahvif->links_map && link_id != ATH12K_DEFAULT_SCAN_LINK) {
+			arvif = &ahvif->deflink;
+		} else {
+			arvif = (struct ath12k_link_vif *)
+			kzalloc(sizeof(struct ath12k_link_vif), GFP_KERNEL);
+			if (!arvif)
+				return NULL;
+		}
+	}
+
+	ath12k_mac_init_arvif(ahvif, arvif, link_id);
+
+	return arvif;
+}
+
+static void ath12k_mac_unassign_link_vif(struct ath12k_link_vif *arvif)
+{
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ath12k_hw *ah = ahvif->ah;
+
+	lockdep_assert_wiphy(ah->hw->wiphy);
+
+	rcu_assign_pointer(ahvif->link[arvif->link_id], NULL);
+	synchronize_rcu();
+	ahvif->links_map &= ~BIT(arvif->link_id);
+
+	if (arvif != &ahvif->deflink)
+		kfree(arvif);
+	else
+		memset(arvif, 0, sizeof(*arvif));
+}
+
 static int
 ath12k_mac_op_change_vif_links(struct ieee80211_hw *hw,
 			       struct ieee80211_vif *vif,
@@ -3973,107 +4074,6 @@ static void ath12k_mac_op_link_info_changed(struct ieee80211_hw *hw,
 	ath12k_mac_bss_info_changed(ar, arvif, info, changed);
 }
 
-static void ath12k_mac_init_arvif(struct ath12k_vif *ahvif,
-				  struct ath12k_link_vif *arvif, int link_id)
-{
-	struct ath12k_hw *ah = ahvif->ah;
-	u8 _link_id;
-	int i;
-
-	lockdep_assert_wiphy(ah->hw->wiphy);
-
-	if (WARN_ON(!arvif))
-		return;
-
-	if (WARN_ON(link_id >= ATH12K_NUM_MAX_LINKS))
-		return;
-
-	if (link_id < 0)
-		_link_id = 0;
-	else
-		_link_id = link_id;
-
-	arvif->ahvif = ahvif;
-	arvif->link_id = _link_id;
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
-
-	/* Handle MLO related assignments */
-	if (link_id >= 0) {
-		rcu_assign_pointer(ahvif->link[arvif->link_id], arvif);
-		ahvif->links_map |= BIT(_link_id);
-	}
-
-	ath12k_generic_dbg(ATH12K_DBG_MAC,
-			   "mac init link arvif (link_id %d%s) for vif %pM. links_map 0x%x",
-			   _link_id, (link_id < 0) ? " deflink" : "", ahvif->vif->addr,
-			   ahvif->links_map);
-}
-
-static struct ath12k_link_vif *ath12k_mac_assign_link_vif(struct ath12k_hw *ah,
-							  struct ieee80211_vif *vif,
-							  u8 link_id)
-{
-	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
-	struct ath12k_link_vif *arvif;
-
-	lockdep_assert_wiphy(ah->hw->wiphy);
-
-	arvif = wiphy_dereference(ah->hw->wiphy, ahvif->link[link_id]);
-	if (arvif)
-		return arvif;
-
-	if (!vif->valid_links) {
-		/* Use deflink for Non-ML VIFs and mark the link id as 0
-		 */
-		link_id = 0;
-		arvif = &ahvif->deflink;
-	} else {
-		/* If this is the first link arvif being created for an ML VIF
-		 * use the preallocated deflink memory except for scan arvifs
-		 */
-		if (!ahvif->links_map && link_id != ATH12K_DEFAULT_SCAN_LINK) {
-			arvif = &ahvif->deflink;
-		} else {
-			arvif = (struct ath12k_link_vif *)
-			kzalloc(sizeof(struct ath12k_link_vif), GFP_KERNEL);
-			if (!arvif)
-				return NULL;
-		}
-	}
-
-	ath12k_mac_init_arvif(ahvif, arvif, link_id);
-
-	return arvif;
-}
-
-static void ath12k_mac_unassign_link_vif(struct ath12k_link_vif *arvif)
-{
-	struct ath12k_vif *ahvif = arvif->ahvif;
-	struct ath12k_hw *ah = ahvif->ah;
-
-	lockdep_assert_wiphy(ah->hw->wiphy);
-
-	rcu_assign_pointer(ahvif->link[arvif->link_id], NULL);
-	synchronize_rcu();
-	ahvif->links_map &= ~BIT(arvif->link_id);
-
-	if (arvif != &ahvif->deflink)
-		kfree(arvif);
-	else
-		memset(arvif, 0, sizeof(*arvif));
-}
-
 static void ath12k_mac_remove_link_interface(struct ieee80211_hw *hw,
 					     struct ath12k_link_vif *arvif)
 {

-- 
2.34.1


