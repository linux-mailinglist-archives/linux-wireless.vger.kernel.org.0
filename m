Return-Path: <linux-wireless+bounces-18367-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CF5A26B0E
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 05:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 365727A136F
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 04:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB801204C30;
	Tue,  4 Feb 2025 04:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LVfYyZu5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B261204C17
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 04:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738643053; cv=none; b=bij4+khz/GZdbsHTUPRrxj0GeVw+XT+50ByggIKz1CP1g4dxLCVaFZyc+1BwEEEb6hFfqYviOGKDvgqMApM6/MDYFTEi+b5SilKNlydyjxYToojVQg3aN3hNMNS2Scb+srn3GzXa0SnVSyLlCJNulwP5529efWmqiHumfvaa0C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738643053; c=relaxed/simple;
	bh=gwPZy+ldd2gBfU4saE4MLv7VxN67dn4s+tHZP4cQRRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QsgXK6NljjCggAm+ECX7OYwhCJKNaXSGz77F39s5Xm3MbwN24A6vhsprQrHz6Cr/0z0huuKrur6fV/myW+AEByhzYcOtTp+kgmK5O+tCNMH14FrpgLUwrwzVvEhw7Lu4NqLLfwaH7kRdLe/FDxQT4Tp/aeSCbNOH++sQEKZw9sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LVfYyZu5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513IajG9008805
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 04:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x00RgwEIM9B0L+foEiTohE00SGuLhH++Md440wM3z3g=; b=LVfYyZu5HFLiu5Md
	r8TOLI+yqZhXRM658SPG76IELfKSm43/ULtNs4vyKsf+qxtBpJFbRNT1DJoj4fwN
	LwryJiZMUPpTo2FZFyNgdqt1Ax0pM2HX7y6qQIgj5LEBQ+rCozXPASQBxVhlCYRV
	Ldojp+Ofb4r9Z863FB+s/HZbCf2lqXIu2kXh4e6vUhed2tllpsvZgegshnOxg8y3
	Oxm2bsdcDI4ovVrrgW0FlZp+SG+6h2efiGAWUMqtdL20TlLkwlvVRODKHyDvHMFc
	nNsJGHwAWifLU7/uV3vJWnqj2wHlkVHa7G8/pQtvlkwIac8LyQC3X46bbM25jhoa
	VjX3jA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k37u1205-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 04:24:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21effaf89d9so12975925ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 20:24:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738643050; x=1739247850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x00RgwEIM9B0L+foEiTohE00SGuLhH++Md440wM3z3g=;
        b=fn5AuP6bLNoO+q58cR30XEkqlpbKvW1Cy2WgJ9ooGEFDBJPYQ0vG5YxjF93p/jPkKB
         ntoXQ8P7dOKxYxe8hDBkPmi5l8KjX/30Sk+6EDx6xAV4gDUYwPjFgWRpTOlBl8SwTLrh
         2nLgmpzrLTHuO8rSuKFvw7QLMLaBr8XLQw0rpb9xzoVF6TtptmWfoS0IJsDq6XRLfQSi
         gHOVkIPGu28kt0hkqqrTNzuEt6jhBIXpSSlGScnhKUzLc51qgRZdDxzenH/Sb0leFwqQ
         cebmEqzGdq92bG329CQy290FS2h9pyJASF409i69/iFOACj16v8C+1jNHX4SvEh+TsIm
         GntA==
X-Gm-Message-State: AOJu0Yx20ZaIIM/mq08lZLnyZ2UhXgojgMtb3jhzVwQjNGHttAEhhId8
	hQeEDjbqPpxBT70ZZXM9qMS4KwNKJP+Y12tnjow4kOCyYJVCVQT7sMdnEOL7qOyUVcc53TiTQaT
	0dkNgWhHB90DRxqVYptXqduNNoNKIK7YgVR5x8zC+Bu1rxfq8OC79LkKMJnIYD6EDVA==
X-Gm-Gg: ASbGnctbawO1k+298Tqo6Q1wxfLsdnHpF3cjmEnKpwc1yY9+8eiprm40DD/rcu3ut7B
	AhY4fIK7j0vsWiNXNy4h6v/R5XS2sHrCV2LIEs7EcAuDCJjlFypkskDN/i0sdLJc2jesZxtKOVj
	sbw3liiNd2YiwTm5V3XXMnCSD6brQqZzaZHw2MAST4VT+BllhQB0sHXNFbfBFV3QeyY4DSZLrX+
	jOFUL487y7SdzPzSXxA7sdVyiAphqd8pxk6KCtcvHXQSkGMxv9DOFJTY9tPQ1MDJdP+bcQnvROK
	muVRvJO/F48Ymq38gl8YpIZqlfoT298kqlyzoGEXMWFT2JCfLUO9JO8/a4ezz5jJKRuPst8AJyu
	R6aXs6cq6dkZr2sRGLGobdgQO46t7FQ==
X-Received: by 2002:a05:6a21:6da5:b0:1e1:dbfd:1fde with SMTP id adf61e73a8af0-1ed7a5e7e38mr38458890637.27.1738643049760;
        Mon, 03 Feb 2025 20:24:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBA73qDRykSxKVpm1Py5x1Wfon1kxEZVcDUKBFbVikl2vgIOYfg85rf8JTG2O8i3ygGa8zJQ==
X-Received: by 2002:a05:6a21:6da5:b0:1e1:dbfd:1fde with SMTP id adf61e73a8af0-1ed7a5e7e38mr38458862637.27.1738643049381;
        Mon, 03 Feb 2025 20:24:09 -0800 (PST)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec04796e1sm8897144a12.58.2025.02.03.20.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 20:24:09 -0800 (PST)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 04 Feb 2025 09:53:45 +0530
Subject: [PATCH 5/8] wifi: ath12k: use arvif instead of link_conf in
 ath12k_mac_set_key()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-unlink_link_arvif_from_chanctx-v1-5-675bd4cea339@oss.qualcomm.com>
References: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: lGP12yagAEiNhA_yJsD2gt_qtHvaVAuX
X-Proofpoint-GUID: lGP12yagAEiNhA_yJsD2gt_qtHvaVAuX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040032

Currently, in ath12k_mac_set_key(), if sta is not present, the address is
retrieved from link_conf's bssid or addr member, depending on the interface
type.

When operating as an ML station and during shutdown, link_conf will not be
available. This can result in the following error:

ath12k_pci 0004:01:00.0: unable to access bss link conf in set key for vif AA:BB:CC:DD:EE:FF link 1

The primary purpose of accessing link_conf is to obtain the address for
finding the peer. However, since arvif is always valid in this call, it can
be used instead.

Add change to use arvif instead of link_conf.

A subsequent change will expose this issue but since tear down will give
error, this is included first.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 5f0388002e16c38a834d6c7c6c020b7afa7044f0..db866c1419a613103f119037b19e24b7edaa6c24 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4667,9 +4667,6 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 			      struct ath12k_link_sta *arsta,
 			      struct ieee80211_key_conf *key)
 {
-	struct ath12k_vif *ahvif = arvif->ahvif;
-	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
-	struct ieee80211_bss_conf *link_conf;
 	struct ieee80211_sta *sta = NULL;
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_peer *peer;
@@ -4686,19 +4683,10 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 	if (test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags))
 		return 1;
 
-	link_conf = ath12k_mac_get_link_bss_conf(arvif);
-	if (!link_conf) {
-		ath12k_warn(ab, "unable to access bss link conf in set key for vif %pM link %u\n",
-			    vif->addr, arvif->link_id);
-		return -ENOLINK;
-	}
-
 	if (sta)
 		peer_addr = arsta->addr;
-	else if (ahvif->vdev_type == WMI_VDEV_TYPE_STA)
-		peer_addr = link_conf->bssid;
 	else
-		peer_addr = link_conf->addr;
+		peer_addr = arvif->bssid;
 
 	key->hw_key_idx = key->keyidx;
 

-- 
2.34.1


