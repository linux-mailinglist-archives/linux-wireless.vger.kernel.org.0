Return-Path: <linux-wireless+bounces-18368-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5473DA26B11
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 05:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7A818877FD
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 04:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2EA205E0A;
	Tue,  4 Feb 2025 04:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qz+6YlsN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA88B2054F8
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 04:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738643058; cv=none; b=cYBc+ECLmo47jI5b6A8F3Eac1D8FImBCRlN2Znt4YKEYyGs65Z5c4r3533A9e5im0Z5hasUX9PcfXYSKRL2BUAX6oKS8OmOxGu+hl2UylXE/248g87Ep5AhYFqraF+DNz+EMML3oNyHTKiuJ5cZYRB++LI/USjyk1zZNvxFEaYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738643058; c=relaxed/simple;
	bh=B39Xe8rgwAmkmFxB95m6R7rKmvQyb+S+ESe2rrI+qpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KssgVvf/Gy5oJK22yB0iIQayYi9X7Q1J12EQpSDvERNvwIX1tJU173ULtAzW0Y/UarE1nn/flwnP2Fzo4U2iPJPuE/x/qMSa7dCGdH5YOshMwILq1wyTAWtGzbBqiWsLvuAHwm2KBaHxHkJx8Y71fMxsjwaeDU6w2cewt7oahZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qz+6YlsN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513IppQ0006193
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 04:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	axAsNklMxgFf0ah3MCcqQDPWHHSWt1rtg0cgBrQZVoI=; b=Qz+6YlsNhcWkiWgR
	axWgDCaPeLChnXiicuoP6TNcRFX5TrnOLBYcdL11FShpWX8P4HeqQNr0dic6LwNF
	+CzCrOaKfqYNHrw2S+G8JWyRacrwa1vLixXnTWMcULAEvrueiuLIAmQxEBezpfAW
	5+Mj+MyIAB40Zoz9Ny1dsZ3K7C/zanN/qU29DiHkzAl+s2aXUi5dHT3Et9oYhSGo
	gx/2o3CMquum7blpjMbJPpJZexoFB0Sw8bK/THtKNiPkt9okdqo2880/7cGVVPIA
	nlCjER2hFGreR5VMsKspVRRSlL4WSE+SL5DZ7P/kFfnmd5hwpETyrFMhoETFesop
	4JUhQw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k3ex10t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 04:24:15 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21effc75088so9689985ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 20:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738643054; x=1739247854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axAsNklMxgFf0ah3MCcqQDPWHHSWt1rtg0cgBrQZVoI=;
        b=gT3ZHhpkbPAeTXOZo3717QctADnPGOnBlZ+1lTasTuhD6+szx0zAPhjqfLrMVnVIPU
         UROCC+Ul71V2DWZkoRdQ4hoQp16yU8Gy36IOElgF91zpgdl94oYOFE4/wOi1wgOuvGgN
         wFK6QgMDmXj1hBebAWvwsv00L1mNMH7Xf4L0lh0NNudWRbwnP1DPMvuh6MVeUH3IZw87
         Qys1q4Coxu/JAt0huIlbQfksTX71RRD9oJFrKo1mc/l3jcXo5EHKlk8/LuZFi6xJWbmI
         SAV0r/9VjAIdMXBtQ4lqTlJsmiuFfIvVV1EYqg0eWNZcIvHY8h+xE9bOtXlUK5lZaazp
         tNIQ==
X-Gm-Message-State: AOJu0YzdPsiQaA8835eoU85KSsxAm+Weob9F4IZXqIhsLhhm+/9LBwK/
	LetH+psWKvq2ylqQTdpxjanpAbVe12bOZl7xe7YlOY0Xye7gDXH9v/divFXJ72oAVaq3yV7qWpp
	fRo3zqZ5/RcHB2SdSdKFZ6dJPrAL3A4DKfNIbded2cwNMX7IWfbgC4pHwiyJ7SYDzxw==
X-Gm-Gg: ASbGncsiTwRoNgdaolovGFTGoj/HkvII7/Wv87exi//tGRhxDcBP3ja9l8dr6IAhtz7
	l7gb/iEvvW5oCV9c7uPOkOZ/kfkqFGhuhtZKMZZrQggJtVIptvgDWcW7swjgoFFNwBT+WcbTxcs
	vv73JN/h5OGXzJsOVPZR49XkN/D9fOH4eWHDf3Loyu3gDO8tuYH/RXSWGvtQc5hSdaqD5SgS84E
	ilFzJg107k2sVT0kKZY0Mum/eHZLUoyyix1v5EnSNkbRThI6ER6Thostwu00ZHjucZ4egm/JuFK
	aiPpHCuQl4l0bcUB2+os6pwoESGFi6EiNSFGs/gwOd3onUJyqu8eELmRnjoHY3kA82d68dlt5+H
	8r6LkdSLBm+ol66ywF8gZ1ER/t5O4eg==
X-Received: by 2002:a05:6a21:3284:b0:1e8:bd15:6845 with SMTP id adf61e73a8af0-1ed7a5a50eamr38531509637.1.1738643054302;
        Mon, 03 Feb 2025 20:24:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG37uEnTRl9KVMSU4spm40ZsO3haIDtnzXWYxqrau1noeC/5WzeqS9hfmEiHCb/xGDbajfSvg==
X-Received: by 2002:a05:6a21:3284:b0:1e8:bd15:6845 with SMTP id adf61e73a8af0-1ed7a5a50eamr38531478637.1.1738643053911;
        Mon, 03 Feb 2025 20:24:13 -0800 (PST)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec04796e1sm8897144a12.58.2025.02.03.20.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 20:24:13 -0800 (PST)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 04 Feb 2025 09:53:47 +0530
Subject: [PATCH 7/8] wifi: ath12k: allocate new links in change_vif_links()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-unlink_link_arvif_from_chanctx-v1-7-675bd4cea339@oss.qualcomm.com>
References: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: KOiU7Z-WN91028PWuXL8ApB9lWfLb_7x
X-Proofpoint-GUID: KOiU7Z-WN91028PWuXL8ApB9lWfLb_7x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502040032

Currently, links in an interface are allocated during channel assignment
via assign_vif_chanctx(). Conversely, links are deleted during channel
unassignment via unassign_vif_chanctx(). However, deleting links during
channel unassignment does not comply with mac80211 link handling.
Therefore, this process should be managed within change_vif_links(). To
maintain symmetry, link addition should also be handled in
change_vif_links().

Hence, add changes to allocate link arvif in change_vif_links(). Creating
the link interface on firmware will still be done during channel
assignment.

And since link will be created but channel might not be assigned, there is
a need now to test is_created flag in ath12k_mac_mlo_get_vdev_args() before
accessing link_conf or else link bring up will fail.

A subsequent change will handle link removal part.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 5d80bbb664ea6a710eedd7b57db3523df9c893e6..b9017002f3efb27d917f0aa35a0ecc66af18ec99 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3576,6 +3576,31 @@ ath12k_mac_op_change_vif_links(struct ieee80211_hw *hw,
 			       u16 old_links, u16 new_links,
 			       struct ieee80211_bss_conf *ol[IEEE80211_MLD_MAX_NUM_LINKS])
 {
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	unsigned long to_add = ~old_links & new_links;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k_link_vif *arvif;
+	u8 link_id;
+
+	lockdep_assert_wiphy(hw->wiphy);
+
+	ath12k_generic_dbg(ATH12K_DBG_MAC,
+			   "mac vif link changed for MLD %pM old_links 0x%x new_links 0x%x\n",
+			   vif->addr, old_links, new_links);
+
+	for_each_set_bit(link_id, &to_add, IEEE80211_MLD_MAX_NUM_LINKS) {
+		arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
+		/* mac80211 wants to add link but driver already has the
+		 * link. This should not happen ideally.
+		 */
+		if (WARN_ON(arvif))
+			return -EINVAL;
+
+		arvif = ath12k_mac_assign_link_vif(ah, vif, link_id);
+		if (WARN_ON(!arvif))
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -8765,6 +8790,9 @@ ath12k_mac_mlo_get_vdev_args(struct ath12k_link_vif *arvif,
 		if (arvif == arvif_p)
 			continue;
 
+		if (!arvif_p->is_created)
+			continue;
+
 		link_conf = wiphy_dereference(ahvif->ah->hw->wiphy,
 					      ahvif->vif->link_conf[arvif_p->link_id]);
 

-- 
2.34.1


