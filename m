Return-Path: <linux-wireless+bounces-20812-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AB6A70C18
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 22:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C61319A0372
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 21:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DF226A08F;
	Tue, 25 Mar 2025 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jh2O2weH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8B7193086
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938298; cv=none; b=k8RBrFkZKYUo6Dsj6lqLVmtZ3uPErJkSq1SXb5dUky1eG5A59s09yEKDz11HMQ2mFtkC+QNkRTTrGks3msZbM317zFJKQlwd4rSzZGk+qkfeAOZXdCXgJ8bsROaVf2kfL8hAWGGQ8vCpZr1BMK57BXXQtrS21ALl17iGROGD6uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938298; c=relaxed/simple;
	bh=RTJ+5RqOkAqF3/agsOaoLpdHmhoRqCSit92HFwq+jwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UTAq9GXrpg1osXnQ7uKbc2MVMn+PkG95x9vwAI+7yolpmIZatZNqQANYC7+0pu7acW7n9vzLCdONFZz0yIh2O4quzAgdRa1cTkkIKFZu4YdCoP6TY4mI4LWnASi4xhdzJZ4DDXSJotm5N3PHXB3VsUSmruOkZwmiOOCkrBDBPqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jh2O2weH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PGalJY018592
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 21:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DW3U8ZPosBK
	VswDi6IctAB4+vmf1gyaDynADSK+zG4g=; b=Jh2O2weH77Kl/xnTa1mZw9l4ICl
	/a24OYI+u7gEtoxT9VqwYWZNtPbye1aFzgBT/fILCbBy5nugHLAuMNX5uCgbR656
	YpJ0zNzV3mq7lfGZmAMM7FvLjywVNIFqmfohMrfNezv9vHlzNHLSYjhWwlAgzzsb
	uvdzFqKbc0XNm30EY2w1JY+rJ9ckNLDe8pSy/Vda8mXCEy7Ch7iXX5ryTpulxPIM
	G1WDsdKJGBjZtAwnty1PZ083AxES+pfpYOIRWUNJKg0z0i7X/VWvdoZWGnsD2tRV
	vDbk3dokaBa2KXkJ+3NaxxfXpVo/Xc2qoLc9TgzrHVX721NGQ9Grqt4tx+w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kyr9gqd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 21:31:35 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2240a960f9cso100151385ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 14:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742938294; x=1743543094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DW3U8ZPosBKVswDi6IctAB4+vmf1gyaDynADSK+zG4g=;
        b=Hn0oJIsTWmODSxhnn75xadNdlp8pOEDPbMRMD7e2d7SrbHAMcq48ePPBQ8ZoN86w78
         +UX1KiXEDNls5EwKCiZgnA5XDo5pezhymHgKu16uisUJlmZqP0ZoOqOlQuYsy9y2B2iZ
         WEDuEUs9vlCMzqWmR7CRqKHODnZp7m15+OEbMDSbvgje8S3KA+Ls68s4YmZYqB4WDOQA
         FMfb8H6pIxYtNoSZ3rH8Qpuk3fZk7hojVCo4WbS/QsINTgNu04KJoydmO+2C1tjKcyvC
         +aHoY86QSwNPat3/1XfEDU4gzn76iW6fpzuKgWID/rcm5X3faud/TQqbviBYVpQeVSGa
         JNiQ==
X-Gm-Message-State: AOJu0YxUMbWmEGmxRI7gr2WOkBu8Xmxw2PEk9UdHYOefDnVnyPho8rF4
	G6AvFmgwjqN2FdFG3LwygF6H/Ko+gUJuKb+jEpYj/6Yjdn8YlAUIfbadOku9O1xm+CoR/wwf9jv
	thtQEHvTYPBsqIKH60HrZQ3Ftm3/yvfUeKeObYrHMPWtUA2wwJZs+Fhbqxcm00etUuQ==
X-Gm-Gg: ASbGnctCJ9UuBG8Z/vfOW7jnVsmcog3A8+MB88adfiRDDRLMMLVyURILu3dNUj1ZDOf
	YIBl+z01LRNTO6icaJojTPhkRyPVcwibC94k9B0aOUPFl6xOicC2t01YXKMz+/3AAsQrNfdaBi8
	07nK2+PVdLumWVFDoUOVPVYnUGG5MKb+qGN6QrD12FD5lisB7Q3Ktn+vrXXDdZkO2vkCUVSUqtQ
	rtIrKs7nwzs1R4lZHqr2U1CRurqh0D88EDFFh0hknYPDEH3RpPkH/P+lAZvCFI6zhzLqpMLb9wM
	en5FdnHnUe9XIiEEZwB9ndSkjs/G+fKSksqqHm1gZeP0u4cA8WETKN5fyKXvNvOO95DwvBEa
X-Received: by 2002:a17:903:22c4:b0:224:e33:889b with SMTP id d9443c01a7336-22780c7abb5mr286217295ad.12.1742938294121;
        Tue, 25 Mar 2025 14:31:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLa4bLdwOuXt39O3e4bc3TVtKi3CpdJrVsmyJn87VqQVVzbSAMbEUAvHkf25U9rwS1DFS9Nw==
X-Received: by 2002:a17:903:22c4:b0:224:e33:889b with SMTP id d9443c01a7336-22780c7abb5mr286216785ad.12.1742938293605;
        Tue, 25 Mar 2025 14:31:33 -0700 (PDT)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3a2b5sm95599395ad.50.2025.03.25.14.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 14:31:33 -0700 (PDT)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Muna Sinada <muna.sinada@oss.qualcomm.com>
Subject: [PATCH wireless-next v4 3/3] wifi: mac80211: VLAN traffic in multicast path
Date: Tue, 25 Mar 2025 14:31:25 -0700
Message-Id: <20250325213125.1509362-4-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250325213125.1509362-1-muna.sinada@oss.qualcomm.com>
References: <20250325213125.1509362-1-muna.sinada@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ejxpznenfzYoKDYM0qic330roWEhvtee
X-Authority-Analysis: v=2.4 cv=UblRSLSN c=1 sm=1 tr=0 ts=67e320b7 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=gyU_N_hUvND95jcV2lsA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: ejxpznenfzYoKDYM0qic330roWEhvtee
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_09,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0 impostorscore=0
 adultscore=0 clxscore=1015 mlxlogscore=963 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250143

Currently for MLO, sending out multicast frames on each link is handled by
mac80211 only when IEEE80211_HW_MLO_MCAST_MULTI_LINK_TX flag is not set.

Dynamic VLAN multicast traffic utilizes software encryption.
Due to this, mac80211 should handle transmitting multicast frames on
all links for multicast VLAN traffic.

Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
---
v4: no changes

v3: rebase to cleanly apply to wireless-next

v2:
 - move clearing links for AP_VLAN into seperate function:
   ieee80211_apvlan_link_clear()
 - remove use of goto
 - replaced "master" terminalogy with "AP bss"
 - update Author signoff to new email

---
 net/mac80211/tx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 20179db88c4a..b6d6d0658e14 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4526,8 +4526,10 @@ netdev_tx_t ieee80211_subif_start_xmit(struct sk_buff *skb,
 						     IEEE80211_TX_CTRL_MLO_LINK_UNSPEC,
 						     NULL);
 	} else if (ieee80211_vif_is_mld(&sdata->vif) &&
-		   sdata->vif.type == NL80211_IFTYPE_AP &&
-		   !ieee80211_hw_check(&sdata->local->hw, MLO_MCAST_MULTI_LINK_TX)) {
+		   ((sdata->vif.type == NL80211_IFTYPE_AP &&
+		     !ieee80211_hw_check(&sdata->local->hw, MLO_MCAST_MULTI_LINK_TX)) ||
+		    ((sdata->vif.type == NL80211_IFTYPE_AP_VLAN) &&
+		     !sdata->wdev.use_4addr))) {
 		ieee80211_mlo_multicast_tx(dev, skb);
 	} else {
 normal:
-- 
2.34.1


