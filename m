Return-Path: <linux-wireless+bounces-21119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E025A79DF2
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 10:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16593B6AB9
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 08:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0192241672;
	Thu,  3 Apr 2025 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nyZSa5hk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1978D2417D8
	for <linux-wireless@vger.kernel.org>; Thu,  3 Apr 2025 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668540; cv=none; b=A8Y9R6qLYGnPbKHmcCTXdtTFXPF6xYmDjZfs6+ngn8UVasb29xbHFgnQgBHdt0FMTY9O5Vn1dFGc3bTuagkSyudIZWCt7LpkVRWMLgYmxxazPvyJMfula3Ms5dV2kDkplAZ6ON/HrkW9eWxDhUhT8wO/JOf9boRvhG9AvKfMVVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668540; c=relaxed/simple;
	bh=LB1U4ye8ZkOqoR+a+tAWIJjCYOCWXWua0vFk3Mhfzk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q3KtR29MeIwYk1/JBd7krTcF5JEjGz41J9AlDDUkGcZxorm0c3Q+/L7zCDaXDUz03yA8v0NIHzngTVh7fL0uhjCMKa2SSX3XF2ANO+gb7vHRmO/yk2b/EASQR5wvtRID5PKm6qS0wCXvkHVENmLXyXzu6X9eEVjN9Wdx6ybxwnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nyZSa5hk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53382mSi012570
	for <linux-wireless@vger.kernel.org>; Thu, 3 Apr 2025 08:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pbTzqnkUjWa
	BGAa+M5WyuW2Lwd0XVXESY098g/Hz86w=; b=nyZSa5hkPBluC8Dc51ka508ouXG
	+zGPpgO3kT5PORF6bmhc0adIVyI27E6mQeNBUNphPQVLeMVvEztNvksQHgOSICHv
	nIuz84Pe+2RDGUp6rwgzHcKkeQNq094E42YhEQ7IjKz3osoXbCJiBeaj2S2uik21
	jQiAg97sIjU8qWcUucH+UDkUPO4gkf/i1fqVuFPbwE02WjIQjvpLiZSBkE+HRDuU
	Abtk16MgIp0CCe8ULM3sgr9nl24tm+ABBh5gB0dgAwRHhp0Zb6dh9rvCYA2MPZqh
	Dgy8W90z65nfi9C1jLcYM1h3GxinBtnU5XGYYT9wL9lJ6QZLD/CItemn6KQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ruadvbrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 03 Apr 2025 08:22:17 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7394772635dso545319b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 03 Apr 2025 01:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743668537; x=1744273337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbTzqnkUjWaBGAa+M5WyuW2Lwd0XVXESY098g/Hz86w=;
        b=PVYLeXbYWiGF27993FEfcKa9c2+lngrfmnfqhaiqBfyvP9Yyi9f4PdSthsMPG4vOj5
         30aOu07GAqZye8V8PsKCD9mmSS1UfuLuf+vcIaTHJaYZLFZD9wtRnvXk4dr5DsNNUVaC
         udXBdNKBR6Mh99HeO9wW8bKYlMbotZblzFm19hsZjEXVYbxgO1384K5x8duIYlbWT+MD
         KcLjflx0M6Tm9pZRHSoA30f/pp0KPED/B0i17Yib/7ftoStE1ISHqByZhhdoiKkVKb6x
         RMxoSS2cDvMVyeY9RX7qNvp1qznXQnsP+giO0AmGcQPkXS//IZMYv2lvXA/ZwcC1/41p
         DYUw==
X-Gm-Message-State: AOJu0YxjK+WjhqXALCiYffCNZNC3pT08xqnSAaPbSSumWARETtdbZaAu
	GL2qFpiiEJCGcgE3GT9KIniMi2HghJO7jRjs+0jJ5vD66LUT8Fed5AIXXTab9y6FLrDgUIkFiJx
	lY79jCeJe8PA1wz5sluNg6LXeiG0du6BOpX2jHx9YK90J8PkY4MaLRTbPwJnO41YRSw==
X-Gm-Gg: ASbGnctrJJe1Lqs77s29174N/H4wGKG5uwhaHPeF/5rNq4xkyjBGqTVXLWN5y5fxq+p
	FCgEgUn1HimxexkWFxmQ1qeZcRuxogEncuMx/FRjoFH5bs5a+1txYk6m+AcKI6aycJkvB7hgdws
	HGYrZN3Yz0CXvTjStx4Uith5VM8iB4/Y8/U6Gsy7eyHOOJjXV4hQZ3UH+e3lNwgSPFvAwiitGxh
	Zrdxf6v7kReocvBdpA/aq4bvAX8IB+kIhQ3jIZcAnBkH8xHx+K+30qFmLUgnWvIwoeNp0MI7Jxj
	DrytsxUQtmjnEZNf1cJRcbvdeaXTiLGQ8PDFYf31TEwLmCupOo7MDQsoXmC5dpuiViEEtNE16Ty
	LlOPjZiea3CjI74WNesR9rT1tjbnX8h05JWv+7GY=
X-Received: by 2002:a05:6a00:890:b0:736:ab1e:7775 with SMTP id d2e1a72fcca58-739d834c643mr2369655b3a.0.1743668536795;
        Thu, 03 Apr 2025 01:22:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqsWE9G+caW1pyWMILrByDaNLCVf5Ir0Q136+lDLGLobUBxhtKjLaeoaRf3WLuJGU+NshJeg==
X-Received: by 2002:a05:6a00:890:b0:736:ab1e:7775 with SMTP id d2e1a72fcca58-739d834c643mr2369629b3a.0.1743668536359;
        Thu, 03 Apr 2025 01:22:16 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea080esm900381b3a.108.2025.04.03.01.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 01:22:16 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next 1/2] wifi: ath12k: Resolve multicast packet drop by populating key_cipher in ath12k_install_key()
Date: Thu,  3 Apr 2025 13:52:06 +0530
Message-Id: <20250403082207.3323938-2-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403082207.3323938-1-aaradhana.sahu@oss.qualcomm.com>
References: <20250403082207.3323938-1-aaradhana.sahu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VI/dn8PX c=1 sm=1 tr=0 ts=67ee4539 cx=c_pps a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=L4pZBo2K2MvCq6627mAA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: oLgNJxbyssWQxyMGhsMyvymAzYRitZHB
X-Proofpoint-GUID: oLgNJxbyssWQxyMGhsMyvymAzYRitZHB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_03,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030033

Currently, the key_cipher in the ath12k_vif structure, which represents the
group cipher of the MLD AP, is populated when the link address matches the
ieee80211_vif address within ath12k_install_key().

However, in MLD AP, the link address and ieee80211_vif address can differ.
Due to this key_cipher is not populated and multicast packets don't get the
correct cipher information and resulting multicast packets drop.

To fix this, compare the link address with the arvif->bssid instead of the
ieee80211_vif address.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1

Fixes: 3dd2c68f206ef ("wifi: ath12k: prepare vif data structure for MLO handling")
Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index b19e30d95560..0036178cf999 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4658,7 +4658,6 @@ static int ath12k_install_key(struct ath12k_link_vif *arvif,
 		.macaddr = macaddr,
 	};
 	struct ath12k_vif *ahvif = arvif->ahvif;
-	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
@@ -4711,7 +4710,7 @@ static int ath12k_install_key(struct ath12k_link_vif *arvif,
 	if (!wait_for_completion_timeout(&ar->install_key_done, 1 * HZ))
 		return -ETIMEDOUT;
 
-	if (ether_addr_equal(macaddr, vif->addr))
+	if (ether_addr_equal(macaddr, arvif->bssid))
 		ahvif->key_cipher = key->cipher;
 
 	return ar->install_key_status ? -EINVAL : 0;
-- 
2.34.1


