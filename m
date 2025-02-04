Return-Path: <linux-wireless+bounces-18436-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ECDA277E4
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027003A822A
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7526217663;
	Tue,  4 Feb 2025 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WOAtA+HV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B4217650
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738688739; cv=none; b=YQiZTsBqPsd7M3xJz5cEy5R9a/ALhywAiNOPy0YBGlb7gtp+4G3f8cjYHqSnrJUb9kZQvUBAnei3tjaTWHG8WUTQuKAxqMZ/FEPihCfg7OQKGv6L7tYz5cIec/dzVQQJ925QaJHjZy0zUULb5GG9R/W2v5Ks7Tqsp1C5GbeOGnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738688739; c=relaxed/simple;
	bh=gNc7Lt2ImNbmQPIIPEj2dlmoTdt3Zsh0jVL81MByKcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kStzl9HhVi9C0rhnoG6MItOXudEXRHAWF48q5cF1V/p3nPTLw/WxyjR7ISEHzL8eYuAs8caV1tY7FwLmFJoecquQG6KqjGHnFBmrlyl3TCOTfHkPlhaRatcsCUct33SoPFGARC1d9jK9o6ONKTS/6Bi6lmdJaxivJTJ/rQK1jFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WOAtA+HV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514BYh7h010449
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 17:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	51f2EOU8rD4IqmdPJzdUmHNaP2sswXDBQc7pnwOJIpA=; b=WOAtA+HVSHrlyoEh
	MjhpxA95iJw8CriT7YkCj9ECfD3Fn+jujKPN+OarSp+sJl1g219IJM8Lrs+O0Taj
	gsw6SZ+Hh1kcCGEUaEOPNtzVwVKopoKbHn2sbS2MuCpf7lP1Q+yPGzpShL3XcKEz
	LtG9OYizTWj5M/T+wZsoQf9h+TK/cHStS7ZeE0wcWA1VjTC2xYTuhncF7Zs8JHJN
	fm2dwNGA1sa4U0p9/Fei7Q9DzYj8fY1mFsE4ix0z+ISZAidbYWcloVdgOl1/Gga/
	R23T4+rM0yZmu4yK5rnj4csixKVhz3KRS9uQ+b450PHMk6cRlz8FzkyNFJbpzDM7
	E0329Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kj4ygsse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 17:05:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2f550d28f7dso10711529a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 09:05:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738688736; x=1739293536;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51f2EOU8rD4IqmdPJzdUmHNaP2sswXDBQc7pnwOJIpA=;
        b=ZHazjYtrZXYCBSKe31HfogAmEpJPHa9nqA0JyS19jxgihpHR9gxvSCUYmcjiWccJWC
         AscurSMSGoZKEooTN9Ho5y0V5TMYYLFVC2ytBgaeBGw9hluJgD/RC5JFjBNYMcp1vFez
         xcfAoDLJsWUtk17CzPqgliy7zlW1m34GeYcApPniDhWxJFNgo6tP3Idiy4jHykQ6GmRm
         5pmCNWZbKlKmMR5P61BlhW4w9xGeQ8Dhn0JtNsmwhDMbdxlGEV1X1vKCP2F+4PUjxjKg
         uekIDUJWeubBQce2qWyCgctyNX3qWYa+JFCD8l0LF3jIR4kd71FenfvSvkAQzJUMGOsc
         z0ug==
X-Gm-Message-State: AOJu0YwZ5b9Q9f0q2vlhgQLaqLjX6YXdTReCxX4Ppi0wCRKXpNX2kP3S
	yFaNqb5hKYNt4UMRXzPUB/A6SoyKF1gU1IxgYCBD6ikto4BbRz4BOZ1Qt5HY5SmhDW1c2a8By+S
	n7xSeYn96Uuu9XRXiNulJjGIPqn98azlubiEvx2KTCUs2J1k1Ers/knB2AHoDrs2wbA==
X-Gm-Gg: ASbGncvwpALDxJwq69crEh9kESo4XfRQ+srkEKG9JW32d4gXmXzh/edIsP/lHI0hPKy
	xtvd7/pGlx4/P+ktkAR4coFwix35TrD0A23A4IKX1OxwJERr0BshzUYZ7Ab1ElvO1Gnz1IUUdcB
	M0vZvBguua1352TwKigz80CWH90Ktch71ytcWJt9E6byjJKDGwI6rGjecEUh4oe1Lakc2KrlR2S
	U6TQUMYBJA1e8f8LFXKo4fBcxnbtgNnvHH27o3y82TiWD4qf5ORPBjltzmQou4MS3SS6go768uw
	XFqFtIrUzUXcBDK2lesWvRiZ6ujC7PbYzZINpXEaI69EwNAVpnoHbeB5ZoS3t/UA33MpFwNS5tA
	HISBfou7Ig1tkaLU9B/99VSaKTjjHXQ==
X-Received: by 2002:a05:6a00:114d:b0:728:ecab:51e3 with SMTP id d2e1a72fcca58-72fd0c02f1emr36077593b3a.11.1738688736345;
        Tue, 04 Feb 2025 09:05:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEG9Uiqc+7PlX1ZsIPR20CQZaNTTSfUWKtsKFXqKtj6fdi754GWLoojlhA+zlni6fNFJsLjxg==
X-Received: by 2002:a05:6a00:114d:b0:728:ecab:51e3 with SMTP id d2e1a72fcca58-72fd0c02f1emr36077504b3a.11.1738688735422;
        Tue, 04 Feb 2025 09:05:35 -0800 (PST)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cddbbsm10772788b3a.125.2025.02.04.09.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:05:35 -0800 (PST)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 04 Feb 2025 22:35:13 +0530
Subject: [PATCH v2 7/8] wifi: ath12k: allocate new links in
 change_vif_links()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-unlink_link_arvif_from_chanctx-v2-7-764fb5973c1a@oss.qualcomm.com>
References: <20250204-unlink_link_arvif_from_chanctx-v2-0-764fb5973c1a@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v2-0-764fb5973c1a@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: 259JWFedWv2DBTSrWN8XyzAjVTsAL6D7
X-Proofpoint-GUID: 259JWFedWv2DBTSrWN8XyzAjVTsAL6D7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040132

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

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 4f5bda45387ee16e1ab7a3c15a72252933f29129..9ac2f883cd5cc3ee5950fabdf6b89e5330171468 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3600,6 +3600,31 @@ ath12k_mac_op_change_vif_links(struct ieee80211_hw *hw,
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


