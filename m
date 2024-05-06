Return-Path: <linux-wireless+bounces-7258-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB138BD6C9
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 23:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26D01F241B2
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416492BAE5;
	Mon,  6 May 2024 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VEk3/a93"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91060156258
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715030445; cv=none; b=nfk9cIyDDvRSxIlr/ypZfmljzixFPlYXvVNsbzSEjyyzsZMvIINXrzQ8IG+tbTzuIjq2uR/x1VnKl3D/AXurAM2UERMQourUxCU93luJkRZmBptFolDTzlOWzuyjmLv0QAq0xulntNDF7QhtxZx81PWt5icJgdI/y0OFdMQxHKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715030445; c=relaxed/simple;
	bh=i7kZbOjAcK2Z8wkySV0XWEDKu6Ql58soS/XjUCngkfs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJfNlzgOhsKeUV8utdy9i6O7yXzePlv8KAeY9S6/uvLiyvbpc+GOHExFw4lyIeEL096u2Ijum9gRmyEITsdp/uaxmbY6/sARhOpzZxZVB6CWhL9SagcllPp8sh0i2fm4mHuCkME0dQpoEwssKhYtkhIOYNX7wVz4/QDuebAYiSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VEk3/a93; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 446Kxg0j008618;
	Mon, 6 May 2024 21:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=mNe5PDjyQlUSpUivfWOGzMHZpZ/WtOm3tLIm4qxR67I=; b=VE
	k3/a93OO7x77/Rlqv+JtUYmoGFOLSUqqfi03gGDYbp+TShV58JTk8qm6IK0252gW
	y60QKhaUEzopdFKnJeY2YzEPGhVS36X02L+hMJcsu7vLNSbCRFEnWeNLopVgh9tf
	oUQeCyJVIHRlcTdMWTc6XxTvljdnvkWOaTXBGJwDZSogZjOQQg/M7zGbryAquLhO
	cX2tqO4Hs3Co4WG4dJ/dz6o/SSSUIAdR0eNnG+j2EKdhNkOkRoHwwaFrPM/LSdw1
	Wso6E5nBXELvyabwyS4J+u3L00UM4xRd3CaAp29rqh3zciqBQrfRWEehJo+7Fdpv
	aqb+saVcu7TKXFbIwJyw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xy1vw8nmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 21:20:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 446LKU4o009246
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 May 2024 21:20:30 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 6 May 2024 14:20:30 -0700
From: Muna Sinada <quic_msinada@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>,
        Gautham Kumar Senthilkumaran <quic_gauthamk@quicinc.com>
Subject: [PATCH 2/2] wifi: mac80211: VLAN unicast packets take 8023 xmit path
Date: Mon, 6 May 2024 14:20:14 -0700
Message-ID: <20240506212014.670423-3-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506212014.670423-1-quic_msinada@quicinc.com>
References: <20240506212014.670423-1-quic_msinada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hOKbMBoheUT4FVZiiGtwjE1Iw-V_OEv0
X-Proofpoint-GUID: hOKbMBoheUT4FVZiiGtwjE1Iw-V_OEv0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_15,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=747 impostorscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405060155

Default behavior for multicast AP VLAN interface traffic is using
software encryption as per commit 18890d4b89d8 ("mac80211: Disable hw
crypto for GTKs on AP VLAN interfaces").

When encapsulation offload is enabled, non-VLAN AP unicast packets are
taking the 8023 xmit path. Similarly unicast packets in AP VLAN
interfaces should have the same behavior as the non-VLAN AP case.

Allow AP VLAN unicast packets to take the 8023 xmit path where
hardware will handle encapsulation and encryption. As a result, there
is less CPU overhead in the 8023 xmit path as we don't encapsulate in
software. Mcast/bcast will continue to use 80211 xmit path.

Co-developed-by: Gautham Kumar Senthilkumaran <quic_gauthamk@quicinc.com>
Signed-off-by: Gautham Kumar Senthilkumaran <quic_gauthamk@quicinc.com>
Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 net/mac80211/tx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index c0e0b5f63714..d77172771a36 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4654,7 +4654,9 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 				  u64 *cookie)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_sub_if_data *ap_sdata;
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_key *key;
 	struct sta_info *sta;
 	struct sk_buff *next;
 	int len = skb->len;
@@ -4679,6 +4681,17 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 	if (IS_ERR(sta))
 		sta = NULL;
 
+	if (sta && sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
+		ap_sdata = container_of(sdata->bss,
+					struct ieee80211_sub_if_data, u.ap);
+		if (ap_sdata->vif.offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED &&
+		    !is_multicast_ether_addr(skb->data)) {
+			key = rcu_dereference(sta->ptk[sta->ptk_idx]);
+			ieee80211_8023_xmit(sdata, dev, sta, key, skb);
+			goto out;
+		}
+	}
+
 	skb_set_queue_mapping(skb, ieee80211_select_queue(sdata, sta, skb));
 	ieee80211_aggr_check(sdata, sta, skb);
 
-- 
2.34.1


