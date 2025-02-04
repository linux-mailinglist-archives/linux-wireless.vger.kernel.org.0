Return-Path: <linux-wireless+bounces-18437-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFA7A277DD
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 502CB7A417F
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8309F217659;
	Tue,  4 Feb 2025 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dkYdlNYE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8471217666
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738688741; cv=none; b=RibYZtHExA7XGUObw7NgqD/YeNxeZ7mmlZ5WSsJV3gAj8nmZTG19dsfJYfECidXa1PNCgRieZSdeltQZh74L3VaopdFwlCMGgxeLoAxWueBjDU/CANcr3BoTi0FTBDMogkrOLN+vhseCkwfBrLsTX3PakOBFa17Bls3Xyowly7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738688741; c=relaxed/simple;
	bh=H5SVcCEw7SFD7kxR7pbqt98rEJ5prStjaWsC3qTVMRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bx8GCJPchhGXBVso6eGr7gAXPGfURczoAlMO0PUSJ2eeMwAAoenxlDvpi63PZHmbWFEZk/5kiUbMTJLvfFTPdDU3PmDuc26P4ai0p6jhEGUBcU0mSBo6kozEK+/S2WvcpycKptGqfkcWIGuW8sJXEPe6yJENfctDjQaU+TC0zfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dkYdlNYE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5148WtKG011051
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 17:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TXWRaM1cylEvYyBQLAOCl/odoq1V8DJ3wyrrRKU9QRw=; b=dkYdlNYEiN5KUGH8
	nn3b2mWakSBWRkQGi8OsChdx5fTRnnpQOP5sXKul9A/haO5l6+GZY2LVzvvCyXHl
	Wq5TyitWmDIsEgmTRqZtmUCLcGXHnlRWwVa7SrwWcFHYSzT2jiuHLyjQYyLknSbi
	/19EJcHDmkgYULs2WbAfznNo1Csxp18Tf4B5jI8pv2SXL8U3F+EGnKops7p2qrLK
	NAfDsuQSgxXF82Y00U3pHNzQaT8oFl9NFL7j/tF2H/rwQ27Csyr/78kJ0/wk8AbM
	r4CBqUdp+p7XRJw8iXVHd3i2JKwZgwnTzmIE0WBPvKmovhmuzXXbg3WM1T3GROc3
	0wDGog==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kffnh8mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 17:05:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-216266cc0acso119331235ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 09:05:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738688738; x=1739293538;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXWRaM1cylEvYyBQLAOCl/odoq1V8DJ3wyrrRKU9QRw=;
        b=pbtG9+PgJI53pRHpZ1OCr5Px3TKmKdHWFKUQ/VQtg5wGzuFd98jk2TJieA4fVfHa3o
         O8qy0C/AU0mcf56l9fYvuqt/q/wjTuuARhCJR+tL7Xexv7HF3oTnk8Aa9SkKSqLAF5vO
         2wFV5XASyNA3yhVmHDUe8dNcxo4DxlLn0K0XXejyI8c5Mo8kXVZV9pEx+8/DL6iw1s5P
         nkLvfDLlw47KiopuyUA2dsMrkwTBF+Atl8qJ5MT9+Ov1CH/l9phmRzkG1fQ6dPC+dn0W
         3PX1QH7Azu3wWmPegOYh8I61rGV1flMOgp7S4ThcETvtCvlKiqqEIqq6A1Qcdr+FgZsA
         RaZA==
X-Gm-Message-State: AOJu0YwfHBS01xt7bOfpzBofRCTvfuki2mUdoNjPiLyE3aIhixh6yBcT
	0onLn/9G1IYaQTBRJfCHIQWS7pyrOGW74RsLH/9wqG3B5h+E/xrMsHVx7hYC6Mmsbr7Kzto4z4Z
	iJEY06GYDpYOsKeVmezHpng+aeHCIrbJKsyUr3cFf+2g0mVkdD6kSZsO0xSBHT5KnXg==
X-Gm-Gg: ASbGnctDdLG9vrkpEtpyrpjIB97elrUlxgFhd2zZfNuxXab+aHl1VEn6B+U63wc+afp
	yD2eRUG7/h/u0gRwR0Vies+/K1u7c0em+TFUkynPUO+CPBTDSwe4hlrThFPPzz/Xndaq1dioX2y
	iWGsXkdJ9aN2jQZqCuz4WNaZxlnUjaYOPddWDS7BLnWLZqgS4kiUO/VvJZDe0XOlwHrZZfn9dad
	YFlfo3+6bTiOtYQ4MsNEeGPol2nUChvMhWJxHe3oRCC38pY04oHwCZc+zxjeFZpItnXDo37qcUa
	xUsFJadeUCsDJ1GzWIR3oWlw4XOTX6t0erAK73dowJCRyU5WzzLz5tyYRjzIyMB/foal7ZZEATQ
	JLUByFRXLVtTzq18M+va+zAKK9t7Odg==
X-Received: by 2002:a05:6a21:918b:b0:1e0:d5be:bf75 with SMTP id adf61e73a8af0-1edd772d3a5mr6632213637.17.1738688738106;
        Tue, 04 Feb 2025 09:05:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFOZCGllE9vRCHjbzgU7t9YEmIsU4+LL2GFRur7KyGfweOuCHEm8rmV9rRR5FRsq2tNOAJrA==
X-Received: by 2002:a05:6a21:918b:b0:1e0:d5be:bf75 with SMTP id adf61e73a8af0-1edd772d3a5mr6632167637.17.1738688737725;
        Tue, 04 Feb 2025 09:05:37 -0800 (PST)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cddbbsm10772788b3a.125.2025.02.04.09.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:05:37 -0800 (PST)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 04 Feb 2025 22:35:14 +0530
Subject: [PATCH v2 8/8] wifi: ath12k: handle link removal in
 change_vif_links()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-unlink_link_arvif_from_chanctx-v2-8-764fb5973c1a@oss.qualcomm.com>
References: <20250204-unlink_link_arvif_from_chanctx-v2-0-764fb5973c1a@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v2-0-764fb5973c1a@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: xDSf1_nz6H8HiztFbrat7o6Q6r_-tQts
X-Proofpoint-ORIG-GUID: xDSf1_nz6H8HiztFbrat7o6Q6r_-tQts
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 mlxlogscore=816 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040132

Currently, the link interface is deleted during channel unassignment, which
does not align with mac80211 link handling. Therefore, add changes to only
perform vdev stop during channel unassignment. The actual vdev deletion
will occur in change_vif_links().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 9ac2f883cd5cc3ee5950fabdf6b89e5330171468..682ea0fc9a857a97000f1e683eb145f36ef0dd17 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3601,6 +3601,7 @@ ath12k_mac_op_change_vif_links(struct ieee80211_hw *hw,
 			       struct ieee80211_bss_conf *ol[IEEE80211_MLD_MAX_NUM_LINKS])
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	unsigned long to_remove = old_links & ~new_links;
 	unsigned long to_add = ~old_links & new_links;
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k_link_vif *arvif;
@@ -3625,6 +3626,21 @@ ath12k_mac_op_change_vif_links(struct ieee80211_hw *hw,
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
+		ath12k_mac_remove_link_interface(hw, arvif);
+		ath12k_mac_unassign_link_vif(arvif);
+	}
+
 	return 0;
 }
 
@@ -9438,9 +9454,6 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	if (ahvif->vdev_type != WMI_VDEV_TYPE_MONITOR &&
 	    ar->num_started_vdevs == 1 && ar->monitor_vdev_created)
 		ath12k_mac_monitor_stop(ar);
-
-	ath12k_mac_remove_link_interface(hw, arvif);
-	ath12k_mac_unassign_link_vif(arvif);
 }
 
 static int

-- 
2.34.1


