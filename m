Return-Path: <linux-wireless+bounces-22144-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DA1A9F444
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 17:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C539C3AF8F5
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 15:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D235926D4FC;
	Mon, 28 Apr 2025 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IuZDle0A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2928149C64
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745853598; cv=none; b=cal4D/LshaJMoIjwhERH3hDmZuJEy7IkRxxlNk7Ug0Cuk0ippOL1IwAME9LbneISlwpeNMQBfPxqoXs8vRExMuqkFCYSinXjG1BGWjxxozoYrFbR9EfhfKhyLUh5fcAHuWQ7R7ke/rKeP+9g6ilgA+JTx69yKLtvUn3iQqTtbB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745853598; c=relaxed/simple;
	bh=rB+p82A0xN8pJ+14y0D9DpOgsky5yRaW8S+tOnm5Hg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cpiue7P4Rd5rficAZHHEuRdkPP0pYm+32jZdoH3eH7FVqzkEp6Qs29n8n6Ajn8qb4J26yNs2C86EcOUJjz5FeylQceBmbhikCaC7bLu8Ad37kihM8Sq9FMooiOnURTD5ObeSm/XiE/4I0WYfdOw6BdOEOL7FLMdm0C+3JLYGPlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IuZDle0A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SEDKD3012252
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 15:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/cYIuDch08t
	yV7LqknEac8rcsOYsZ3Y6V4DEd/1dOSo=; b=IuZDle0AXYYbViXn0bsI2lgVmbi
	PGWjRVHjfMdIEgP5ZcU1Gr8sKyySSstZaljZOsELot1KhdHTUVdhqCnoV4o5UEoQ
	KOPKiYNWpWsX4SmJ63anXAC4yffiz1JfyexCgandOvB5JQWbQR7KVE8eiAqJ5ezs
	eovQQkKm0az19/l7nzQe+/DDiMsm+vnNjw86sORw0zILv0DMHNVKu8im5gi7bz1e
	halTdE3SFAv7YwYgkLj/mNIiP7u0+/gYcuVVwv7qOGcu+JdWbrxUG1VEtHEIitn3
	VkdNpiMSGKyis6TlnztF9Z3HJvAkY1lYKyMfzK+hylHJBp1N6lbNmcvfm9A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468r8hrh9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 15:19:54 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-225429696a9so71233895ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 08:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745853594; x=1746458394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cYIuDch08tyV7LqknEac8rcsOYsZ3Y6V4DEd/1dOSo=;
        b=w4VqzoaXoyPhTh4K0dGl0/n6SZ4mJn/9xLAXDGoTFl+5vu7DFsqRJJtYCMvbvC64q/
         2w0BVDNeVdjfEFSjmKzHrA8jF/5fWT7cr830dOX7BFlCdc/h95hT42TI1neYoriQiGEV
         foqjGufaJ6qkN2O+dZWWt75MpYUjgg9gBFZkp4rL0IHBiGcfLX6N27zs9DpzEZkp77MT
         6ryCemKmH5le+L7D18AaO2yCghmt/GTavGH6oAi+mqFJjjrarl7YODod55Ip1mSE9hLF
         etvxj0Zzfv2plpxRpI0jNqzGyyHioqvxxE/YwnbM3HmIANctCbLKNm/Ir+2OwUuOe38F
         Ztaw==
X-Gm-Message-State: AOJu0Yyj7OhCP0wxHSCNyVJg3W4dYfMdpxQhn3D8IYOp1DkV1YcW6hMG
	BAEDo1k8W9WJWwmTy9B9NezPzFzh+dDVlZaidbEIT8OJGUi5KmawE6BPop9UVltOEtIOEHa4p3h
	RCa6b1UxiRh4EHJgpUNEX2i5IdwzGiDqFNJkfCoy1FqMVNJtqLIRPiOY23Z9iogyVTrSCQQqDnw
	==
X-Gm-Gg: ASbGncsHFTzUJvzGvt6kf3oThJPGFdYZ6e22cTLxkA2Um41Mkv4rhPh+A9brRc6CCy5
	tshX49VJPw9dHQGeGoXmndcJuvNy+KYLUYZALyE0ImYvTDxtH9CNnlJb0lu5T/RuTBp3JoSA+rO
	GP5Mmrh8+n+No2I5UgRBRO91h0t0Z/9Gd0uZns7I+7JWM5wcUsa4pkDfWZqVAw0oW/RnaJ2hcvY
	pi/BdXNdQBhheDVEZW70XfXS1zFqMRS5FPc81Mb78r9QPw9o4xc03C1pSqcWNjyqow06dRmiOWX
	ZccwwsA+zTJ5+i4cO4wbLHNK9mOQfICDP5fdTOUNL2Y9b9mWWvTB4pFbCv8EtKpn1j4itOjiSb8
	t0Op3126O1+1THjaWJz+wH8OYc5LoBViOW6hq9FUW
X-Received: by 2002:a17:903:2405:b0:21f:85ee:f2df with SMTP id d9443c01a7336-22dc6a0474dmr150911185ad.15.1745853593813;
        Mon, 28 Apr 2025 08:19:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj9bawxTlPZ/vT3cJBo4gD6x6U42aFDaVpKL5eIHZRS2DBfk0jmCu72kDo7fkXUTDGheXspw==
X-Received: by 2002:a17:903:2405:b0:21f:85ee:f2df with SMTP id d9443c01a7336-22dc6a0474dmr150910595ad.15.1745853593128;
        Mon, 28 Apr 2025 08:19:53 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5100c13sm84134515ad.162.2025.04.28.08.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 08:19:52 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH ath-next 1/2] wifi: ath12k: Prepare ahvif scan link for parallel scan
Date: Mon, 28 Apr 2025 20:49:26 +0530
Message-Id: <20250428151927.1169783-2-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428151927.1169783-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20250428151927.1169783-1-rameshkumar.sundaram@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PN-aPeuMv1l9wo_tcm1yrGoauzsJq2W7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEyNSBTYWx0ZWRfX0xbM8p18XeaY 7gKy0HE/f+H2w4QBoUL8l/NtSvxzVRhzvFuun8YzEH+bYigo2d11HDAnnOHZBqMsN3l5x/s8MOa KpIUuWKAEcUOLA23W7rY4cJV98Q9tnGo3hebbRbGKmkyNkVs3zNH6EIE8cX97cLCxO/Lej5p5uI
 0rFkJK3kOCP6R/qx+UQaf826Caczr2cm7E9W/M3EarkH5lD98n53Iy96+4Taw6kyG2WaZpgGx6G Fcyuc4J5T0WFQmzsplW30QkaXayx8kLuxulDRqFm/g/2UKlegqiJcn8DcazaWkXuPXgbr1h1FjN Pm4KKaTHy89dP7Trc3fxO1PcP+pTejoT+TYP7BMCRGr7AL+SyedQ8P487C6UwIGgZ1PuNf833OF
 8RcOYlkPOb/PeHXxTw7aNTwEFsI9ymM9OSrntybDfmrOTrpqNJvobKrpI7n9R2L6zI3gj2vV
X-Authority-Analysis: v=2.4 cv=cfzSrmDM c=1 sm=1 tr=0 ts=680f9c9a cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=NQOVZfBc_sQf-YiYnVMA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: PN-aPeuMv1l9wo_tcm1yrGoauzsJq2W7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280125

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
---
 drivers/net/wireless/ath/ath12k/core.h |  2 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 49 +++++++++++++++++++-------
 drivers/net/wireless/ath/ath12k/mac.h  |  7 ++--
 3 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 4b8f434e3e9a..0d512818ee96 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -352,7 +352,7 @@ struct ath12k_vif {
 	struct ath12k_link_vif __rcu *link[ATH12K_NUM_MAX_LINKS];
 	struct ath12k_vif_cache *cache[IEEE80211_MLD_MAX_NUM_LINKS];
 	/* indicates bitmap of link vif created in FW */
-	u16 links_map;
+	u32 links_map;
 	u8 last_scan_link;
 
 	/* Must be last - ends in a flexible-array member.
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8949073c0163..6dab2f3a9e0d 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3483,7 +3483,7 @@ static struct ath12k_link_vif *ath12k_mac_assign_link_vif(struct ath12k_hw *ah,
 	/* If this is the first link arvif being created for an ML VIF
 	 * use the preallocated deflink memory except for scan arvifs
 	 */
-	if (!ahvif->links_map && link_id != ATH12K_DEFAULT_SCAN_LINK) {
+	if (!ahvif->links_map && link_id < ATH12K_FIRST_SCAN_LINK) {
 		arvif = &ahvif->deflink;
 
 		if (vif->type == NL80211_IFTYPE_STATION)
@@ -4475,11 +4475,12 @@ ath12k_mac_find_link_id_by_ar(struct ath12k_vif *ahvif, struct ath12k *ar)
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
@@ -4489,10 +4490,20 @@ ath12k_mac_find_link_id_by_ar(struct ath12k_vif *ahvif, struct ath12k *ar)
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
@@ -4523,9 +4534,16 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 
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
@@ -8654,7 +8672,8 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 	struct ath12k_hw *ah = hw->priv;
 	struct ath12k *ar;
 	struct ath12k_base *ab;
-	u8 link_id = arvif->link_id;
+	u8 link_id = arvif->link_id, scan_link_id;
+	unsigned long scan_link_map;
 	int ret;
 
 	lockdep_assert_wiphy(hw->wiphy);
@@ -8673,12 +8692,16 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
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
index da37332352fe..8ec4a890172c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -51,8 +51,11 @@ struct ath12k_generic_iter {
 /* Default link after the IEEE802.11 defined Max link id limit
  * for driver usage purpose.
  */
-#define ATH12K_DEFAULT_SCAN_LINK	IEEE80211_MLD_MAX_NUM_LINKS
-#define ATH12K_NUM_MAX_LINKS		(IEEE80211_MLD_MAX_NUM_LINKS + 1)
+#define ATH12K_FIRST_SCAN_LINK		IEEE80211_MLD_MAX_NUM_LINKS
+#define ATH12K_SCAN_MAX_LINKS		ATH12K_GROUP_MAX_RADIO
+/* Define 1 scan link for each radio for parallel scan purposes */
+#define ATH12K_NUM_MAX_LINKS	(IEEE80211_MLD_MAX_NUM_LINKS + ATH12K_SCAN_MAX_LINKS)
+#define ATH12K_SCAN_LINKS_MASK	GENMASK(ATH12K_NUM_MAX_LINKS, IEEE80211_MLD_MAX_NUM_LINKS)
 
 enum ath12k_supported_bw {
 	ATH12K_BW_20    = 0,
-- 
2.34.1


