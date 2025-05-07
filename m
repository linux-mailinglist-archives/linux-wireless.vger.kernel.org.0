Return-Path: <linux-wireless+bounces-22720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DBEAAEC70
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 21:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE741C027F8
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 19:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB89E28E5FE;
	Wed,  7 May 2025 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I77xTJSt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D1728E5F1
	for <linux-wireless@vger.kernel.org>; Wed,  7 May 2025 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746647340; cv=none; b=tEHNGreHCXuecJCQtQoJZ5g4md9OH7/ZtomWOgieYL5FGS0oxPZexFMAYjch7l+KlPSs0EPD/aMzHNJomqkzSRLx3SUr4mAFL3g5Pf1gvWGnoDCOqly2NIMUYHLjrAjK2yYuDwZSLtnkYGvWkzupSrm/7DPLohJ159zFFw8/qAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746647340; c=relaxed/simple;
	bh=34wbE245jXKTT46OtSNlfYUHx+scjKzLThsjbO4iCa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nu+UiggpzQdamtXtOZ5bckhzpfObgYyJJnIuDAgNBYo5AQsYVTcUytavtd3lIOqU/KJAIpliHgdLDtlCwf3tEYPo7auorefXmyFtqrBeKLYd0qW/tP2zrWDn5pT92Av/8ASikljtJu4vC/sr8A2uiGfiwiJ7q/fqz65LTbx2Zvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I77xTJSt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547D8T4t014546
	for <linux-wireless@vger.kernel.org>; Wed, 7 May 2025 19:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=XwKI5jA8OMK
	g+8bF5bR6cOAjHSyQ+AqN+1M4Cp7EEak=; b=I77xTJStlB1HJHuA+1P4o0UTkJU
	CPMFV7FJFsmGWHlvDSKWIBpdybhYMHY1D91TYXt11h0Sb7pYpJRyWRB7TtVW6yU8
	vgkhNKt8psdLRNYXYj340YfgWWEj0YqfNirvfMQPDLur0aQbbpMNlly2GnoiossJ
	r8mtQhKrypOxXSa3jDr7ka0d7Fl1OR9CdtvUYk4Au7p5Gtj1JvIeiqwFMnCkavMA
	UyrrI5BPIOP/W17tPzJT8oVXDBb3JuCSIPDGFyZNY55mWmoqQ/mCm1DVH/QuqRmU
	jkTjyHfgOqcWzTa5pPsw3F7P8zESKMOO2+MFQzMGPE3qt7Zp4+Nyb5+D+Ug==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46g0kh2gpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 07 May 2025 19:48:56 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b090c7c2c6aso96278a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 07 May 2025 12:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746647335; x=1747252135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwKI5jA8OMKg+8bF5bR6cOAjHSyQ+AqN+1M4Cp7EEak=;
        b=MtjtHjEU1brQIH1kQU7iQMbYkMcOZOldk/4eqci+4yE2G2IMiQCavRSL9jHLJwZnWv
         5qphHxYQSinFj/yovsDz8k0uEV+9WwOrDbujtyHSA1VmDilXIFfKKO9+JsREN5+Q14Lr
         oyJsmgXTlIpwcLfc5mBLkD4nlbVvLhCIwBvr2Tmb3BWSbNAtbU0+9iQ/cLF16VkMwX5Q
         lYDr56+PWRIyPZMCYyv76ihCz6exNH2/yb6gmf7N/Mn/mpjEpTJdymMIEFh1eYRuBcPM
         oyHwsXFKKT3a+v/5mMT6MDq2f0OxiwWc5+FYp5oNYwmjkM8cXN35dt5GXKpU5JKnB1gK
         SO6g==
X-Gm-Message-State: AOJu0Yz/m55QrJmZziDT9HQY72cUC7NXbMnOPORVWNEn34E7nBI7mqjD
	sjS1XiFktSwuKHqCWw2Q7DM727V3dSp51BM4QmusoS/ZdP+uSkb/O5YaYShUFAWA/zsbuE5g2Vv
	qZLDJlXewi5laGVnDqujP6muqtZVjkdNgZ8qXwSoGtPsMKE3UF7yTBTJha1UlpMwXhuYwA1VZNA
	==
X-Gm-Gg: ASbGnctF81EgyvWwqDO95BcafI7vnDkXh53E6IZ/XH83/lOJlpwC/spiUKDT2/K95UI
	wzB8rvHz7XFLDOYLJqpeNEfQ6N3JznwHycjLZilt5XJDxZDZMBjyUEIPBU1BEk4/d4HzYDPL0Ze
	eaFYRrQJSZ36rjictRQgOtQnsOHiXKpPHRPxkdBittfbCNu66iC84El2Ztna+2wnXEWNu7s6pVh
	0zE6b8jnbmMXP3vwYKTYDKPVQJ7iCucCk+avmRBTvxNaVyTioMOYec4hhgc2HQqMK9oWC0VmEYm
	5PpNDQyYBSPAewDaNvmbTLYFhRmW9okRltEFDnuRe2rb66c298Z4KMp/m26+k8P2buJOnIlNcfi
	X7W1DwLvgiCepBpy6gCbptZbSo58twyZq8/bwlCOT
X-Received: by 2002:a05:6a20:2d27:b0:204:695f:47e1 with SMTP id adf61e73a8af0-2148c21e5b2mr6199485637.23.1746647335412;
        Wed, 07 May 2025 12:48:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxAvWBi+9vbWSuGJzghkgb7rwjXyKrmtXfei5W9+e8FDuVL36YaW3uDbqX9QePUcf0pF5S5g==
X-Received: by 2002:a05:6a20:2d27:b0:204:695f:47e1 with SMTP id adf61e73a8af0-2148c21e5b2mr6199462637.23.1746647334948;
        Wed, 07 May 2025 12:48:54 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3920074sm9972704a12.11.2025.05.07.12.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 12:48:54 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Mahendran P <quic_mahep@quicinc.com>
Subject: [PATCH ath-pending v2 1/2] wifi: ath12k: Prepare ahvif scan link for parallel scan
Date: Thu,  8 May 2025 01:18:31 +0530
Message-Id: <20250507194832.2501668-2-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507194832.2501668-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20250507194832.2501668-1-rameshkumar.sundaram@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE4MSBTYWx0ZWRfXz3LauiIytDbS
 rYNNPIvShoj9J4ynNdcXGOiqFXcg4LfjD4fwpU7OajgEDMFwAQxIWf+dIevX4hUfvoyO/sv4Alz
 /qwWKQ/CtEA8u3p2/hWpCkjzHc8Rh7QfBKNG96r+rkLkyz6Dcq0kTV0HJnUrdnpr5PVg50PryK4
 1xHE04LgB4imGrAj4/5KW7a8wJMVl+PXmj5ad6AmAzOeyNx7t4hsNZeZkMPC2eYiunRQjZRgklR
 k4A7su6XrW5qbTXv3vo8JWukBHDxgHtOECAAdyZAB7uvJb/1KbyGPAIxczZ0MtMASQHmaPZUMBD
 aIB95hxAuDBmJIYeGUhe7TvUvKhD4n7avNMj4usvnXJEdnFlLcRZ1nn/pn38C0X4ekdRT1sG2Es
 1nEPEN9CLhWeybYq2oWmhiRaA7HP77B/Lejo6jNp45IKBKp6rtIR5k6zoACs3Gbd0WGpJAyQ
X-Authority-Analysis: v=2.4 cv=PNUP+eqC c=1 sm=1 tr=0 ts=681bb928 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=NQOVZfBc_sQf-YiYnVMA:9
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 2cBXirn8-pqxlv8GowKYL-H4KsVLcwzB
X-Proofpoint-GUID: 2cBXirn8-pqxlv8GowKYL-H4KsVLcwzB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_06,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070181

When two split-phy devices that support overlapping frequency ranges within
the same band(say 5 GHz low and 5 GHz high) are grouped into an ath12k
hardware (HW) setup, they share a common wiphy instance. Consequently, the
channel list (wiphy->bands[]) becomes unified across all associated
radios (ar).

When a scan is triggered with frequency list containing frequencies of
both 5 GHz low and 5 GHz high, mac80211 generates a single scan request
to driver with all the frequencies. This is because mac80211 splits the
scan request based on band.

ath12k checks the first frequency in the requested scan frequency list and
initiates scan to corresponding radio's(ar) firmware with all the
frequencies. Firmware rejects this scan since some of the frequencies in
the scan request are not supported, resulting in a scan failure.
To fix this ath12k driver should split the scan request into multiple
scans based on requested frequencies and schedule them to corresponding
underlying radio(s) in parallel.

Currently, ath12k driver assigns the scan link (link 15) in ahvif->links[]
for scan vdev creation. However, with parallel scan support being
introduced in the following patch, multiple radios (e.g., 5 GHz low and
5 GHz high) in the same HW group may attempt to use the same scan link
concurrently, causing conflicts where the vdev created by one radio could
be deleted and re-initialized by another.

To address this, reserve space for additional scan links for each radio in
a MLO group and allow subsequent radios to use different available scan
links (ahvif->link[15..MAX_SCAN_LINKS]) when scan link (15) is
pre-occupied.
While at it, rename ATH12K_DEFAULT_SCAN_LINK as ATH12K_FIRST_SCAN_LINK
as there is no longer only one scan link.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Reviewed-by: Mahendran P <quic_mahep@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  2 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 49 +++++++++++++++++++-------
 drivers/net/wireless/ath/ath12k/mac.h  |  7 ++--
 3 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 31add5f8a8ff..570bbe4aecd5 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -380,7 +380,7 @@ struct ath12k_vif {
 	struct ath12k_link_vif __rcu *link[ATH12K_NUM_MAX_LINKS];
 	struct ath12k_vif_cache *cache[IEEE80211_MLD_MAX_NUM_LINKS];
 	/* indicates bitmap of link vif created in FW */
-	u16 links_map;
+	u32 links_map;
 	u8 last_scan_link;
 
 	/* Must be last - ends in a flexible-array member.
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index d3b12ce32c78..b80ae1476f5e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3891,7 +3891,7 @@ static struct ath12k_link_vif *ath12k_mac_assign_link_vif(struct ath12k_hw *ah,
 	/* If this is the first link arvif being created for an ML VIF
 	 * use the preallocated deflink memory except for scan arvifs
 	 */
-	if (!ahvif->links_map && link_id != ATH12K_DEFAULT_SCAN_LINK) {
+	if (!ahvif->links_map && link_id < ATH12K_FIRST_SCAN_LINK) {
 		arvif = &ahvif->deflink;
 
 		if (vif->type == NL80211_IFTYPE_STATION)
@@ -4909,11 +4909,12 @@ ath12k_mac_find_link_id_by_ar(struct ath12k_vif *ahvif, struct ath12k *ar)
 	struct ath12k_link_vif *arvif;
 	struct ath12k_hw *ah = ahvif->ah;
 	unsigned long links = ahvif->links_map;
+	unsigned long scan_links_map;
 	u8 link_id;
 
 	lockdep_assert_wiphy(ah->hw->wiphy);
 
-	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
+	for_each_set_bit(link_id, &links, ATH12K_NUM_MAX_LINKS) {
 		arvif = wiphy_dereference(ah->hw->wiphy, ahvif->link[link_id]);
 
 		if (!arvif || !arvif->is_created)
@@ -4923,10 +4924,20 @@ ath12k_mac_find_link_id_by_ar(struct ath12k_vif *ahvif, struct ath12k *ar)
 			return link_id;
 	}
 
-	/* input ar is not assigned to any of the links of ML VIF, use scan
-	 * link (15) for scan vdev creation.
+	/* input ar is not assigned to any of the links of ML VIF, use next
+	 * available scan link for scan vdev creation. There are cases where
+	 * single scan req needs to be split in driver and initiate separate
+	 * scan requests to firmware based on device.
 	 */
-	return ATH12K_DEFAULT_SCAN_LINK;
+
+	 /* Unset all non-scan links (0-14) of scan_links_map so that ffs() will
+	  * choose an available link among scan links (i.e link id >= 15)
+	  */
+	scan_links_map = ~ahvif->links_map & ATH12K_SCAN_LINKS_MASK;
+	if (scan_links_map)
+		return __ffs(scan_links_map);
+
+	return ATH12K_FIRST_SCAN_LINK;
 }
 
 static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
@@ -4957,9 +4968,16 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 
 	/* check if any of the links of ML VIF is already started on
 	 * radio(ar) corresponding to given scan frequency and use it,
-	 * if not use scan link (link 15) for scan purpose.
+	 * if not use scan link (link id >= 15) for scan purpose.
 	 */
 	link_id = ath12k_mac_find_link_id_by_ar(ahvif, ar);
+	/* All scan links are occupied. ideally this shouldn't happen as
+	 * mac80211 won't schedule scan for same band until ongoing scan is
+	 * completed, don't try to exceed max links just in case if it happens.
+	 */
+	if (link_id >= ATH12K_NUM_MAX_LINKS)
+		return -EBUSY;
+
 	arvif = ath12k_mac_assign_link_vif(ah, vif, link_id);
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac link ID %d selected for scan",
@@ -9184,7 +9202,8 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 	struct ath12k_hw *ah = hw->priv;
 	struct ath12k *ar;
 	struct ath12k_base *ab;
-	u8 link_id = arvif->link_id;
+	u8 link_id = arvif->link_id, scan_link_id;
+	unsigned long scan_link_map;
 	int ret;
 
 	lockdep_assert_wiphy(hw->wiphy);
@@ -9203,12 +9222,16 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 	 * and now we want to create for actual usage.
 	 */
 	if (ieee80211_vif_is_mld(vif)) {
-		scan_arvif = wiphy_dereference(hw->wiphy,
-					       ahvif->link[ATH12K_DEFAULT_SCAN_LINK]);
-		if (scan_arvif && scan_arvif->ar == ar) {
-			ar->scan.arvif = NULL;
-			ath12k_mac_remove_link_interface(hw, scan_arvif);
-			ath12k_mac_unassign_link_vif(scan_arvif);
+		scan_link_map = ahvif->links_map & ATH12K_SCAN_LINKS_MASK;
+		for_each_set_bit(scan_link_id, &scan_link_map, ATH12K_NUM_MAX_LINKS) {
+			scan_arvif = wiphy_dereference(hw->wiphy,
+						       ahvif->link[scan_link_id]);
+			if (scan_arvif && scan_arvif->ar == ar) {
+				ar->scan.arvif = NULL;
+				ath12k_mac_remove_link_interface(hw, scan_arvif);
+				ath12k_mac_unassign_link_vif(scan_arvif);
+				break;
+			}
 		}
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 33835172e446..e30524802dda 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -53,8 +53,11 @@ struct ath12k_generic_iter {
 /* Default link after the IEEE802.11 defined Max link id limit
  * for driver usage purpose.
  */
-#define ATH12K_DEFAULT_SCAN_LINK	IEEE80211_MLD_MAX_NUM_LINKS
-#define ATH12K_NUM_MAX_LINKS		(IEEE80211_MLD_MAX_NUM_LINKS + 1)
+#define ATH12K_FIRST_SCAN_LINK	IEEE80211_MLD_MAX_NUM_LINKS
+#define ATH12K_SCAN_MAX_LINKS	ATH12K_GROUP_MAX_RADIO
+/* Define 1 scan link for each radio for parallel scan purposes */
+#define ATH12K_NUM_MAX_LINKS (IEEE80211_MLD_MAX_NUM_LINKS + ATH12K_SCAN_MAX_LINKS)
+#define ATH12K_SCAN_LINKS_MASK	GENMASK(ATH12K_NUM_MAX_LINKS, IEEE80211_MLD_MAX_NUM_LINKS)
 
 #define HECAP_PHY_SUBFMR_GET(hecap_phy) \
 	u8_get_bits(hecap_phy[3], IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER)
-- 
2.34.1


