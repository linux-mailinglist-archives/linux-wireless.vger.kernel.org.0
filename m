Return-Path: <linux-wireless+bounces-18370-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518CCA26B14
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 05:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC302165EF8
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 04:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF2919D080;
	Tue,  4 Feb 2025 04:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AkJz/G+9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F302054E4
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 04:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738643060; cv=none; b=ng1+/HQ3f9C6Sxn3Wnnouwz1h2TzxBq/5OBF0t8hJa9inXhzPWgobB6vjG2p5fhQtXi8fnqEd+mJxGs6tfky8x82KApuuCn4qYpY5ucroKMDFadHGUsjttL38lGn+4mqmOdpLV2rOmzxN4rEertTTr4n7wqbU2cihuLDgP5iicc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738643060; c=relaxed/simple;
	bh=3zeSV7XScPXnxBgxyXBl4PSjkPapzFvlWTrtbgOi9xU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CBrZzuIQPqTA8XwrM9xq1W+8AG2yeDbEqqdcIqTXNAfHNn1p5cUjFr2jxlS7xZck+lCTtBmepLVOltGm2OHoes5IUwydx59FHqLegtv9xxDIdsgmnisnQWeUIBvCY9b5tTMV1LPEcYWZGlvD9YY+kQVDngSyNZxbwQibK1RSmrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AkJz/G+9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513KQjsP027024
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 04:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n5abZU6dyDkIdkVihxBVrDuFbwGtylY+gTuk/12qRbw=; b=AkJz/G+928HsBnpC
	q/6sCZUhnsfxrls2KVuZd71WpKgcdzGgniGzqUPexWfGQmY+ZGY/pWGoxtzymfyo
	DItzXN4D6fGgZfa997TCWEsd1Z6OvGeAM1H2EweQoXBkMNuAh4fvTGedawgvQ30y
	Sx73RqHaUYay5OvqMerZGNJsYUoUHCck5qzD2WyIEf9mhJytn8qCnpSJ5HwaTorp
	nwi8HceQcppdwrWsRjEso0lGWQv2DWksngY0/YnUpqaBhb5dghg4xLBSjkTwbTr7
	+EeMuRo3uBpfz717PhmBPNa3dcbvaVp0DKMQ9S8Op6CZnC/v2GC8b/WVBKJF3+rS
	NgnTuA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k4ufrtdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 04:24:17 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2166a1a5cc4so109662805ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 20:24:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738643056; x=1739247856;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5abZU6dyDkIdkVihxBVrDuFbwGtylY+gTuk/12qRbw=;
        b=baOV93Z6wHst71DR60LEyiidwNhSSsyHN1+f8Vn5Tv+rCBzDK7InfeAolUxnaWd0R2
         g/qNCH22uO7idDkK+j18H72yIIMKzgAwGz8pBFx3ukUG56N9INkbicjQX5Yn5n/h5TsF
         rSWnHv+owFQ7Os8YZrvk6h3d6Eo4yVfMZ34KPq+8ZVJQjgtaZMf23rDn2GLkIfDqZbno
         UxActTZ8e/pYvvvcjqryghGaORLA/14SJ4ssrlD2cTriXBJEb6UkNGoGPNwxhxwnymXm
         1gNR1eNSWjrJo6/DP3NfgukDObBtg3DrZ0W+MTYmVJJSlGNP7Cwd8A1Txr3/h2LGSIAZ
         uQUw==
X-Gm-Message-State: AOJu0YzfXFGm8V1npFh6IzDSvxcCYYWegvg8n3NNmYgZYXZlzovBPN+Y
	rXSOWJ/CMFGXrYdwTxLbGH6gstMloQCAg5dJv6/M6keIDC/v3bukA2iRNzJI1+S1AcglySEorSf
	N+khokNM/gNC52U190Q+sZ5DulNZvY/h/rjW6GIMm83Q/CZfGAGdYidSqCJQ0Laj9yFjTzqO2fQ
	==
X-Gm-Gg: ASbGncsoQJpAOweRZgEG88OTj2NBqVPRCqGhzCEsIwnF1wi+z+hHNTTZSNj0roe55ND
	x6Tjv8exIpkCWPBaYXXzVOqckLg/3KN9UeMUkTRkXdY5PXJlpNQLoM8DqyDUGmjRkIzpG9UGQPN
	R2nr/LVcQoE6Apjp5y9WaUcHHXC5TSj+0zq/Ha8r0IADiE0GPb+0HtkrpCf+nT4AIMcz6ZpRSSM
	SE4NB87wIG3GDelZihq5e8GS2II0sasOBw5xNK3QFQrhYPXfaiC7O1qIP1dT4uPviNBXQh6ncZ+
	pEjkweV3PgA5RJtyRLK/aVWNUKSVXDSWCVMYERTwXFtgKnDP2thB0/fwWK2ZYeOSRYvU11pQq38
	s2kvaRlE4sz367hMsZL36+Oa1Uepxsw==
X-Received: by 2002:a17:902:f606:b0:215:89a0:416f with SMTP id d9443c01a7336-21dd7d82c71mr370635115ad.30.1738643056478;
        Mon, 03 Feb 2025 20:24:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhoG9w5PlyPWrqyvJgyt6LTeaXrrnMjdnwMh0e7+nmLXcFU8Xb2spNcgNI5qyh0iy5T8MZgw==
X-Received: by 2002:a17:902:f606:b0:215:89a0:416f with SMTP id d9443c01a7336-21dd7d82c71mr370634855ad.30.1738643056138;
        Mon, 03 Feb 2025 20:24:16 -0800 (PST)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec04796e1sm8897144a12.58.2025.02.03.20.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 20:24:15 -0800 (PST)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 04 Feb 2025 09:53:48 +0530
Subject: [PATCH 8/8] wifi: ath12k: handle link removal in
 change_vif_links()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-unlink_link_arvif_from_chanctx-v1-8-675bd4cea339@oss.qualcomm.com>
References: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: _CGyTF1T2V__spVRZ9BTbyEZL20qwmiM
X-Proofpoint-ORIG-GUID: _CGyTF1T2V__spVRZ9BTbyEZL20qwmiM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502040032

Currently, the link interface is deleted during channel unassignment, which
does not align with mac80211 link handling. Therefore, add changes to only
perform vdev down during channel unassignment. The actual vdev deletion
will occur in change_vif_links().

Additionally, since the link arvif is currently allocated in
change_vif_links(), to maintain symmetry, add changes to deallocate the
link arvif in change_vif_links() as well.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 53 +++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index b9017002f3efb27d917f0aa35a0ecc66af18ec99..d965ae2e755821ea5bfa366a5d74263020e5dee5 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3577,10 +3577,12 @@ ath12k_mac_op_change_vif_links(struct ieee80211_hw *hw,
 			       struct ieee80211_bss_conf *ol[IEEE80211_MLD_MAX_NUM_LINKS])
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	unsigned long to_remove = old_links & ~new_links;
 	unsigned long to_add = ~old_links & new_links;
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k_link_vif *arvif;
 	u8 link_id;
+	int ret;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
@@ -3601,6 +3603,31 @@ ath12k_mac_op_change_vif_links(struct ieee80211_hw *hw,
 			return -EINVAL;
 	}
 
+	for_each_set_bit(link_id, &to_remove, IEEE80211_MLD_MAX_NUM_LINKS) {
+		arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
+		if (WARN_ON(!arvif))
+			return -EINVAL;
+
+		if (!arvif->is_created)
+			continue;
+
+		if (WARN_ON(!arvif->ar))
+			return -EINVAL;
+
+		ath12k_dbg(arvif->ar->ab, ATH12K_DBG_MAC,
+			   "mac remove link interface (vdev %d link id %d)",
+			   arvif->vdev_id, arvif->link_id);
+
+		ret = ath12k_mac_vdev_delete(arvif->ar, arvif);
+		if (ret)
+			/* No need of error prints here since already inside the above
+			 * call, in error path, prints are there.
+			 */
+			return ret;
+
+		ath12k_mac_unassign_link_vif(arvif);
+	}
+
 	return 0;
 }
 
@@ -4100,7 +4127,8 @@ static void ath12k_mac_op_link_info_changed(struct ieee80211_hw *hw,
 }
 
 static void ath12k_mac_remove_link_interface(struct ieee80211_hw *hw,
-					     struct ath12k_link_vif *arvif)
+					     struct ath12k_link_vif *arvif,
+					     bool delete_vdev)
 {
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ath12k_hw *ah = hw->priv;
@@ -4111,7 +4139,9 @@ static void ath12k_mac_remove_link_interface(struct ieee80211_hw *hw,
 
 	cancel_delayed_work_sync(&arvif->connection_loss_work);
 
-	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac remove link interface (vdev %d link id %d)",
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+		   "mac remove link interface %s(vdev %d link id %d)",
+		   delete_vdev ? "" : "partially ",
 		   arvif->vdev_id, arvif->link_id);
 
 	if (ahvif->vdev_type == WMI_VDEV_TYPE_AP) {
@@ -4120,7 +4150,9 @@ static void ath12k_mac_remove_link_interface(struct ieee80211_hw *hw,
 			ath12k_warn(ar->ab, "failed to submit AP self-peer removal on vdev %d link id %d: %d",
 				    arvif->vdev_id, arvif->link_id, ret);
 	}
-	ath12k_mac_vdev_delete(ar, arvif);
+
+	if (delete_vdev)
+		ath12k_mac_vdev_delete(ar, arvif);
 }
 
 static struct ath12k*
@@ -4300,7 +4332,7 @@ static void ath12k_scan_vdev_clean_work(struct wiphy *wiphy, struct wiphy_work *
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac clean scan vdev (link id %u)",
 		   arvif->link_id);
 
-	ath12k_mac_remove_link_interface(ah->hw, arvif);
+	ath12k_mac_remove_link_interface(ah->hw, arvif, true);
 	ath12k_mac_unassign_link_vif(arvif);
 
 work_complete:
@@ -4436,7 +4468,7 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 			return -EINVAL;
 
 		if (ar != arvif->ar) {
-			ath12k_mac_remove_link_interface(hw, arvif);
+			ath12k_mac_remove_link_interface(hw, arvif, true);
 			ath12k_mac_unassign_link_vif(arvif);
 		} else {
 			create = false;
@@ -8274,7 +8306,7 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 					       ahvif->link[ATH12K_DEFAULT_SCAN_LINK]);
 		if (scan_arvif && scan_arvif->ar == ar) {
 			ar->scan.arvif = NULL;
-			ath12k_mac_remove_link_interface(hw, scan_arvif);
+			ath12k_mac_remove_link_interface(hw, scan_arvif, true);
 			ath12k_mac_unassign_link_vif(scan_arvif);
 		}
 	}
@@ -8297,7 +8329,7 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 			if (WARN_ON(arvif->is_started))
 				return NULL;
 
-			ath12k_mac_remove_link_interface(hw, arvif);
+			ath12k_mac_remove_link_interface(hw, arvif, true);
 			ath12k_mac_unassign_link_vif(arvif);
 		}
 	}
@@ -8502,7 +8534,7 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 			spin_unlock_bh(&ar->data_lock);
 		}
 
-		ath12k_mac_remove_link_interface(hw, arvif);
+		ath12k_mac_remove_link_interface(hw, arvif, true);
 		ath12k_mac_unassign_link_vif(arvif);
 	}
 }
@@ -9439,8 +9471,7 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	    ar->num_started_vdevs == 1 && ar->monitor_vdev_created)
 		ath12k_mac_monitor_stop(ar);
 
-	ath12k_mac_remove_link_interface(hw, arvif);
-	ath12k_mac_unassign_link_vif(arvif);
+	ath12k_mac_remove_link_interface(hw, arvif, false);
 }
 
 static int
@@ -10293,7 +10324,7 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 			return -EBUSY;
 
 		if (ar != arvif->ar) {
-			ath12k_mac_remove_link_interface(hw, arvif);
+			ath12k_mac_remove_link_interface(hw, arvif, true);
 			ath12k_mac_unassign_link_vif(arvif);
 		} else {
 			create = false;

-- 
2.34.1


