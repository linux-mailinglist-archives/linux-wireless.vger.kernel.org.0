Return-Path: <linux-wireless+bounces-20127-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89750A5A7E3
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 23:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222F03AE731
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 22:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD001E570B;
	Mon, 10 Mar 2025 22:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EGasCQdN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145B840BF5
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741646139; cv=none; b=jklXxy20o2KiM6arONtzY6dy1qlHxML7+3xTAaZGIxt3YweY3+6c5bs39POsxU1JYS33Xa2KUvqtqvb67R/G2UUJ0TMtDCB94PAxXSkMlAPuTtO5FOeJ/QUuuS4JPvLNASBlcehDsSpXyG2MImlb5Uetx2yze2tZu+MJT3MbGjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741646139; c=relaxed/simple;
	bh=5DAcgLjdfaGUB+RnjQge/W5GDTtDD9jKrpaLvYuC6aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PDuqEhGEAUHzb2ZH360hVcDYBDFZcKiK+ga/ClaIl+NCwQSoFiX8Fqcc8eGOC4sUqj673kN97ATPXLky/01/d43/WSdGNaMPl3HISP7qF1wlxB2C6WD4NbxjgVKf9F1zo6FPUPJEzR7LB5pMGbNECFHtgs0w32JLJTZIeUSh1Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EGasCQdN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AJwLr5001500
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 22:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=VaRAp/zLeJd
	hDMnjrfsnYFhRGrLM67zH0GGVhVKx5tM=; b=EGasCQdNpxXft5bQYhP9soyAnUN
	oue3OJED5Ox8i46ZI6gAQS8FkRj/FKC+13m9bvPRgAXGD4kUgXcqCvQFnIXGJXu8
	7tNpEc53lQYkXJb8GhNQcFBOlSArcx+b4pRitbIKml/FfqIFZetS4BI64B3jEPcO
	YZZjSmI5qM62uNiOGl71mFxJpiIIh8Fr3cHBFNftO8afxrSiY/2wdh8qG0srxqSO
	6JXgcopQtvKI45XWxnEuJWCkvJ9yZnKXccsMgMky3bhCZLkRY7pfcgJ1guTRjRYK
	NVsPibX9TbSXOVQNMiKY/pGv3e6YHOjuwTW9RMp4CUFHGsOvoUfGUKNpluA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f1jx93y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 22:35:36 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-223477ba158so125463015ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 15:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741646135; x=1742250935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaRAp/zLeJdhDMnjrfsnYFhRGrLM67zH0GGVhVKx5tM=;
        b=dN/p/EH7La7+tDdc7QuMACWiDdSco82LuhVzvQ+zG9CqPSP87u7xDjQvlZk5j1FcwM
         osVkn4EmDUPtAELmtG6fYfOe59oTwta8V6tBcwqhW7fZK6jUE63en3Z/+63rhne9lkv1
         VnE2vo/zJAG79u68vDRwYMRfLpwgcKj1zcypRxnAXOvRgqzdsV3lwAldMnc/TLcnjdf0
         ZkxD1CiZvKpgC4j+7IJ3kS/DmUMpKqDRrLkZrURpSY9WSOZ9PhBLfdAiQhM75suOBMck
         Knpu6ZSssQLFIOcVNcHrkmIlWvjsNz/QnPy2TFSkNqQR9uyQl5Fm9AMQMAAjFf2sbKb0
         OUdQ==
X-Gm-Message-State: AOJu0YxV3V7DWpd686xPdwDy7VYsQ000ZnB0KLYtmkinnKT5iex4jtTg
	6dX652L4SNeHmNXgoHydmoMpV5xjgmAxnUwM83SLtJ89AZ6OELBewUi+yeJ1QK4EZbar86Tc0oD
	x5qpHXcfbYcuhg1PYiSJQ7G+X6Y2pCmZm5Vn7G4hzYB/oEKUfW0x2snDuDiP80CeV4sZfLA0+qg
	==
X-Gm-Gg: ASbGncvYrh+gzR8HVxPCmll2l7M8pdAZxl8n4Aa2X/yyU/5xEu0PxkGMWh6VZSe43zK
	J+GaJSa3TQNZ6diqwMhRiRSKZM/8LIOJSUiKnn5t+HAqSvpTCYVY+qRFTw4dMAnAZm5DoFTKbYp
	GUVJ9ffRKw8amEgahXSK9fs9VdgBiADjJuTlcgR7Igc4ynK++hIVSKRTLZrMqRWQ2+CiZvP33Zd
	cxrrhZIxaxAtocWrOHwwgiOguxxi/wd37aij9+DCbJZULvR5mPWwAy6s//u/PZ2z8vvSN/fYM+B
	6Mz/9Gi87k2uLYSVj83VIcAKOiHNdCKKJGtmCS2xAV54g28sd9uJ9h+GQpYlqgteOWgN+/1g
X-Received: by 2002:a17:903:22c8:b0:220:f449:7419 with SMTP id d9443c01a7336-22428880305mr215987945ad.7.1741646135241;
        Mon, 10 Mar 2025 15:35:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJdrUDOH3XwWweRI65ZhBkNz5j0hsOAvFJKiYGJkXiznXK/7uzmhpPxKvDCDHxzdqlp4XjzA==
X-Received: by 2002:a17:903:22c8:b0:220:f449:7419 with SMTP id d9443c01a7336-22428880305mr215987725ad.7.1741646134888;
        Mon, 10 Mar 2025 15:35:34 -0700 (PDT)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109eba53sm83675825ad.53.2025.03.10.15.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 15:35:34 -0700 (PDT)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Muna Sinada <muna.sinada@oss.qualcomm.com>
Subject: [wireless-next v3 2/2] wifi: mac80211: VLAN traffic in multicast path
Date: Mon, 10 Mar 2025 15:35:28 -0700
Message-Id: <20250310223528.3528897-3-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310223528.3528897-1-muna.sinada@oss.qualcomm.com>
References: <20250310223528.3528897-1-muna.sinada@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ctthk04i c=1 sm=1 tr=0 ts=67cf6938 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=gyU_N_hUvND95jcV2lsA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: f4Y5R_DIjQReuVbVrDlfgRzjjiJRUPI_
X-Proofpoint-GUID: f4Y5R_DIjQReuVbVrDlfgRzjjiJRUPI_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=860
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100171

Currently for MLO, sending out multicast frames on each link is handled by
mac80211 only when IEEE80211_HW_MLO_MCAST_MULTI_LINK_TX flag is not set.

Dynamic VLAN multicast traffic utilizes software encryption.
Due to this, mac80211 should handle transmitting multicast frames on
all links for multicast VLAN traffic.

Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
---
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


