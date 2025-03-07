Return-Path: <linux-wireless+bounces-19971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C749AA55C13
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 01:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF0C1712D3
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 00:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374B29454;
	Fri,  7 Mar 2025 00:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jOj83+rx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A32B67A
	for <linux-wireless@vger.kernel.org>; Fri,  7 Mar 2025 00:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307874; cv=none; b=AJLcHvACm287mtbdTYsc1YBZSiAe7aqUupnumGYVYEuWNPJK1CCrbLWPEKtpEd7vteb4Lc0ksdFz5nEKQSW8CNrLPUa0uOavrtt7BzuphAc1gRQqZrdM1wQ89Ift+oyPoUx7qbBhgcKXNkkav7W0NpIb5XemfLsoeX/oYeECGbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307874; c=relaxed/simple;
	bh=JMBt47SgKKOyTNSBQOjOqrfyyJJzRsyzBeNO6m2guFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bXC4YU7HLH2Cy4X5sDbcUkCoLYS97VryWXxO2OTT8SqS3CszsUi7WpVonNLwtwMozPAkJmPHHpMkewqCHOjtp9lNmldSTj9+7MZP/V1bNiLMpuGdoGMMtzacgkIqM51HrsOoVnJNWyFSHmyKCOkCyHekUJ62PvogVd/kl/iidPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jOj83+rx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526I57h3027093
	for <linux-wireless@vger.kernel.org>; Fri, 7 Mar 2025 00:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ayxwWAhnlkr
	KFVj8puGeGpKxFLpXu42p0gvQT+pvOzA=; b=jOj83+rxk7mpne0Mja39wtxWWs/
	N9eXjQSOXXjvah/n9ffJK4AKIhgbn3Ai/gpbYHPJrzY7Jb1fhqvHb7LbKb1hSOtt
	IH5mQfKXa+72gsVD4odxiILpCiONQKgEoZSjWzGNIf60ogHApVeSoVouErcRpf04
	62zCIbjacuVDYzrNjoct9j9+1VeQwySjZ8VQ0zTPySLMz2a9S7KbrM3yPldaNnCA
	eGX5lsARUHl/jP4nG82vN73mgBKkdSAUKZszJRj5HXe5MkeLD226A4ntdUsTtKg7
	rynZBsfZM8n197CutP3hH7pYlwxwMf5hA6Qdo9zm+wj4qOV5ucbMCdzp1qA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6ttusp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 07 Mar 2025 00:37:51 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2237f73c669so20893535ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 06 Mar 2025 16:37:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741307870; x=1741912670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayxwWAhnlkrKFVj8puGeGpKxFLpXu42p0gvQT+pvOzA=;
        b=A0JX+I2Bfz6C6FKn8+qAvcpz9cNzQrkA310CGpMWaFDycZJsrKMe+vwyfWoPvX2YLr
         jH0SwHRp/+QFHq3e6nS+OBSYhaxlm/uaZz8Gr7QB2JACk/2dPP/Q7BwdyJ2FdY/cix8o
         Tjok4Eh8vWywyz26Pv93dHaH+0fDLDA0qEaDdltrDb+ASeo2YYYR6jX2KDgTz4IrFiKQ
         6ycLBwkCA4BVndSeDNPiNRdrKACiO1BhS9QauT++259I/56utyf4x03QDxxv01ZhxxFL
         X7Wk3c2aXU0SiZ3Ipb0t1mg2SLTXxRtzRs5skrO1FWYXtLL7QU1+6NDwVHjBhzCe3hgF
         YIGA==
X-Gm-Message-State: AOJu0YyKErhdX2l9kxpTUyErvgOePCe5Ns6Fxjv9bMdUkT54nDc6OkvM
	owreIzneKJJJ4G1n9cT0y8dDpfjN4cYWoKqBpxTZPOlafIaNmIM6UN9FPK+hA7Uqk1XFFw/99c0
	Y5IyFQ5e5EG6Y0lD2Zh5m/Mi4zsaqlWAISHgFbsgJ0cbJxU+eeMOQ5sQEDgSxnRxXtA==
X-Gm-Gg: ASbGncvzPtk+qzgSx9KqMniFWhkwFPmzRWVhUAi+YuHXnCKI+L5o3b7AcU0olkScitF
	ev5h+lY98rI0PIk3cZedK2q86Ng4e30kFgxGjbESQz1hxZ2iasFguURGMKoovJiCTb7ClP0v7gz
	jjfK4mS9Mx8KzPhXSqxe1Xk+JM55294D5juKccMPhN/2+SEmJd69eNB8hVvuwkRuFu7X0SUZzdG
	kEzkrExJCS6nhkQuaUSOf9KbEI+EpFiLd/z80+QHiYFPoz/LRNk73gXRPC8MJ9JLjqK7ni5HGIH
	mjMXyYuGpKARCY08gNXpRlCwsMhOndSVQzJ6l3QdkiWjQYdI0v9hdtDFVIdTGoe64XrGCeWO
X-Received: by 2002:a17:903:22c1:b0:223:5525:6239 with SMTP id d9443c01a7336-22428c075d8mr21750995ad.38.1741307869698;
        Thu, 06 Mar 2025 16:37:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGagEilmowmTYuxav69WI43VMbxWDVFL3gsd/z7DvwGNEz/R6hxAQwqr2+TclGDS4en4mJV6Q==
X-Received: by 2002:a17:903:22c1:b0:223:5525:6239 with SMTP id d9443c01a7336-22428c075d8mr21750685ad.38.1741307869260;
        Thu, 06 Mar 2025 16:37:49 -0800 (PST)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f8b6sm18559185ad.136.2025.03.06.16.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 16:37:48 -0800 (PST)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Muna Sinada <muna.sinada@oss.qualcomm.com>
Subject: [wireless-next v2 2/2] wifi: mac80211: VLAN traffic in multicast path
Date: Thu,  6 Mar 2025 16:37:40 -0800
Message-Id: <20250307003740.1329351-3-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307003740.1329351-1-muna.sinada@oss.qualcomm.com>
References: <20250307003740.1329351-1-muna.sinada@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HZbuTjE8 c=1 sm=1 tr=0 ts=67ca3fdf cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=gyU_N_hUvND95jcV2lsA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: tHCs4sobHNtQQ6EhwSFVGSozHxXuWDjA
X-Proofpoint-ORIG-GUID: tHCs4sobHNtQQ6EhwSFVGSozHxXuWDjA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_08,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=841 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503070001

Currently for MLO, sending out multicast frames on each link is handled by
mac80211 only when IEEE80211_HW_MLO_MCAST_MULTI_LINK_TX flag is not set.

Dynamic VLAN multicast traffic utilizes software encryption.
Due to this, mac80211 should handle transmitting multicast frames on
all links for multicast VLAN traffic.

Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
---
v2: update Author signoff to new email
 
---
 net/mac80211/tx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a24636bda679..40f95bc6ddce 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4525,8 +4525,10 @@ netdev_tx_t ieee80211_subif_start_xmit(struct sk_buff *skb,
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


