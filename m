Return-Path: <linux-wireless+bounces-18435-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D841A277DF
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453E83A1A68
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EF5216E29;
	Tue,  4 Feb 2025 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f/INd/E8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C21216E0B
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738688737; cv=none; b=MVqSJsGfVi+7Kpa8yLwTvz0kE5M+9pkX1egnXKpUOiEwJLdcu1wEppXnzMpGH319rnKkJ9pMfN7hfkWOjj6z68mwPFsVx4vZ1BXPbeK7WB+QwavIjdPJxrbxhLwSXURsFhHHRFjpb/ingcR0Ul0V34SL0VvAe1y6hTvqUld89xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738688737; c=relaxed/simple;
	bh=nj1MR/o86niB/+6cv7aECXNXfmddam89K/k6jiut1E0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WDh7lSyEz6X/1jDT4H3J1STTZVpzoKY+5APJ3mhYZMbHZJCALkLi+ICu5yR76UG/yvE+JxsazRSvr0EVZC6LlO2oq81Qyas7zm6/TvLmmxqLY9xN/zwDsEaILTTH3fxcjuxYzvYUMiszmQBQzgw9R6kB8GLHMP5XWLhZcaBtfkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f/INd/E8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514E1VI3032200
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 17:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WN5HH/8aK4QaE6vMfcOuIYz8YHDTi8XwCxrBcxjH2dE=; b=f/INd/E8o/rPhrP1
	jf9oKAxw2vaJS6NwdnTVlHhMy8gnCEGjXlWVRRtsV8ODpdJ6PTdQUIJyo6Etdkpc
	PpWi69ujlDmOF3boUtT+JfvN9u9DixUfBsryJbJh5z+XqWlqRB5dMI2wxpc164vG
	3Ds1oKebKUS2RVYylra23jB2DPNzanBbToqfen2pATw/oquUI3dC/d5AY4OhlW66
	ThdoX6THf+h49SdddNaIcUv4uHqLUdIylHfFyEXF+4dsxKgE5etWpYAGsyx+c8Cd
	SRwy2IksrSHT2fQnaNwQizHSr5QqpiJonNSJgiLipZvPRdDG/CY1e9/mm0o1cc2Z
	ku4JNA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44km9wgf8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 17:05:34 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2f46b7851fcso16543222a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 09:05:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738688734; x=1739293534;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WN5HH/8aK4QaE6vMfcOuIYz8YHDTi8XwCxrBcxjH2dE=;
        b=UJQQBR8l3P0sDIejo9d+1H3IGZ/ZAc8QyVL2UIbknF6bEMQXkbJcDODCYmyzxqhRWP
         VWvPnGNYorbzeLaZo1E9tlD3AfAu9V0Dk29x9vOedne4J6hfsl4K0P6xLJ9yTPeXaYwM
         7Ht0c4iJ5bi3Jhc8joS9jVWEFMmQwj/Dmo5FVRv7PALmOh3L3G2cyptUo5oocH04reqL
         cvgh35HthFe/hQ33GWe0HbuSTCiwffG9QVdSwbLA5iubfRmdWbojhDcouiVRO6gEzHuc
         GNS0anzHymMLixDK24Ho/BN6kccCkSTiuGIQbAtWp31zA3kQJgVrhYaPXFXAjymKW36G
         hTzQ==
X-Gm-Message-State: AOJu0YwuG+cvnhLb69Z4++UNlSmtLDop/tTi5h8Yo5rDT0mn83FXrZak
	Ja+ecoO92a/3c2fKH4A+WZS+borDEMGBEjeExXvVmV41Jm/tSrlaaDlv2LRQwQ17MbPV+XAfOeq
	EnVf6kDLQjN1HjQFPgmb1JNbmAqyVz7H7Pbh8T1QIZbfM8y6ka/fH80MS23Fp7QMb9g==
X-Gm-Gg: ASbGncsnseEv/AMGB4CEIHRYuTYnWtPSXlpy9Sgr1WZfQRLul4f5kNfJH+1a4qFnKP8
	WuIrKY8PArLvENZycICdMS0bjVOn7oQJO0mKib/+syNEF1uBK0QX+gkaE/OooXDaCJ/cCT0T2TW
	GJeZfNkod1aDzuYIEZ8b7wmJSV4V/TBFLOTVvQFOloKl+jIx2vNO3mYprui3wL4Zuu0I0n3ciny
	VafzwvfAli0wvTsibxkhng+aZSmDJGiCyk0rAZ1GqeItYtPvapgJiS0aBFnrpgGYhUEdbAwEn7r
	QQFpvvpOB02DpAktj8bFagasdUc/97kP71RkQH0S4EtT66P6Wgyxi9gLnspXiHL9/oct9GU2TSq
	O2JwF8jZPGzKdQuC6Dsmm2vE7M7cVwQ==
X-Received: by 2002:a05:6a00:2443:b0:71d:f4ef:6b3a with SMTP id d2e1a72fcca58-72fd0c97f99mr38907448b3a.21.1738688733350;
        Tue, 04 Feb 2025 09:05:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV4Scox1v8cF8o5B+dd4wbuk+Xtys9zwQP72i2ppE3zrl3iSfXErz5Ui3BkGP9bHQnBFm7Qg==
X-Received: by 2002:a05:6a00:2443:b0:71d:f4ef:6b3a with SMTP id d2e1a72fcca58-72fd0c97f99mr38907379b3a.21.1738688732823;
        Tue, 04 Feb 2025 09:05:32 -0800 (PST)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cddbbsm10772788b3a.125.2025.02.04.09.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:05:32 -0800 (PST)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 04 Feb 2025 22:35:12 +0530
Subject: [PATCH v2 6/8] wifi: ath12k: relocate a few functions in mac.c
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-unlink_link_arvif_from_chanctx-v2-6-764fb5973c1a@oss.qualcomm.com>
References: <20250204-unlink_link_arvif_from_chanctx-v2-0-764fb5973c1a@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v2-0-764fb5973c1a@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: DSRG4I7_uOyH-9VeDUxFgx5h_7V3I7Lk
X-Proofpoint-GUID: DSRG4I7_uOyH-9VeDUxFgx5h_7V3I7Lk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040132

An upcoming change will invoke ath12k_mac_init_arvif(),
ath12k_mac_assign_link_vif(), ath12k_mac_unassign_link_vif(), and
ath12k_mac_remove_link_interface() from a line located above their current
definition. Hence, relocate these functions to above so that these can be
invoked later on.

No functionality changes. Compile tested only.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 250 +++++++++++++++++-----------------
 1 file changed, 125 insertions(+), 125 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index db866c1419a613103f119037b19e24b7edaa6c24..4f5bda45387ee16e1ab7a3c15a72252933f29129 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3469,6 +3469,131 @@ static void ath12k_recalculate_mgmt_rate(struct ath12k *ar,
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
+static void ath12k_mac_remove_link_interface(struct ieee80211_hw *hw,
+					     struct ath12k_link_vif *arvif)
+{
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ath12k_hw *ah = hw->priv;
+	struct ath12k *ar = arvif->ar;
+	int ret;
+
+	lockdep_assert_wiphy(ah->hw->wiphy);
+
+	cancel_delayed_work_sync(&arvif->connection_loss_work);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac remove link interface (vdev %d link id %d)",
+		   arvif->vdev_id, arvif->link_id);
+
+	if (ahvif->vdev_type == WMI_VDEV_TYPE_AP) {
+		ret = ath12k_peer_delete(ar, arvif->vdev_id, arvif->bssid);
+		if (ret)
+			ath12k_warn(ar->ab, "failed to submit AP self-peer removal on vdev %d link id %d: %d",
+				    arvif->vdev_id, arvif->link_id, ret);
+	}
+	ath12k_mac_vdev_delete(ar, arvif);
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
@@ -3973,131 +4098,6 @@ static void ath12k_mac_op_link_info_changed(struct ieee80211_hw *hw,
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
-static void ath12k_mac_remove_link_interface(struct ieee80211_hw *hw,
-					     struct ath12k_link_vif *arvif)
-{
-	struct ath12k_vif *ahvif = arvif->ahvif;
-	struct ath12k_hw *ah = hw->priv;
-	struct ath12k *ar = arvif->ar;
-	int ret;
-
-	lockdep_assert_wiphy(ah->hw->wiphy);
-
-	cancel_delayed_work_sync(&arvif->connection_loss_work);
-
-	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac remove link interface (vdev %d link id %d)",
-		   arvif->vdev_id, arvif->link_id);
-
-	if (ahvif->vdev_type == WMI_VDEV_TYPE_AP) {
-		ret = ath12k_peer_delete(ar, arvif->vdev_id, arvif->bssid);
-		if (ret)
-			ath12k_warn(ar->ab, "failed to submit AP self-peer removal on vdev %d link id %d: %d",
-				    arvif->vdev_id, arvif->link_id, ret);
-	}
-	ath12k_mac_vdev_delete(ar, arvif);
-}
-
 static struct ath12k*
 ath12k_mac_select_scan_device(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,

-- 
2.34.1


