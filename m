Return-Path: <linux-wireless+bounces-7257-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 669888BD6C8
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 23:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78D07B21356
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A1115B963;
	Mon,  6 May 2024 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BJRF55th"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E29B15B553
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715030436; cv=none; b=pZKCy1LDP0wvRCGPp4Q00NJhzLlVCj0cTJUyMomoSPR3f5DP+HYTDilZPMd3IUJaIMurKAA9B4Z9HZYGoAPi8WSYdx/fdQR0CIQIQmjJgHEbdhsR7RomNY836O5vG0a2f5rBbRAl+/324JmLNC7ETVkJeNCmr91EY3CXs31PUMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715030436; c=relaxed/simple;
	bh=xg0+IAZk0FGAlVzwPysCWpwp0tGwWjJdwx11WUuFR5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fozgup/JXzJrI0cA7j8pryj3WRnI+prc+ZRekNSVNwIDCXUSXDNfnv8J36Y+iTdo128iLIJ+UeQgdNKlGefu8JGzYwhtkKfKXmzwHtONPXnnSvB6Ow4j7ZTno3xdYojxwMzmU3az2Q5Aj2xL2lkNayUAWrB0rmZ3pqFGm584Uv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BJRF55th; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 446A1jcp028107;
	Mon, 6 May 2024 21:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Hs+FSoB7BFyDOGNlqDETnS/1QgMkUbq5yGiFYckk4bA=; b=BJ
	RF55th4jzO1m8IGewmPFFqsHuny/mgLU7NqwK1IMLbl+PGjnR72AJLhtC8NZwABm
	LYsNtSIqglaTWp2JGgcEXaNgjnPhKOaA81Xap4IaKev17VgOv7k9ZRPevIJbBiOH
	NYak/wuDxJqtNcg99rSOsEVd7kuy1dgm+eJWrm+iyMkfZIta9tqHQ5S91SQjPPio
	sg8aPc+qVRDmxiNkYP0uVNsa6UjQZCtYOJcjfGk+9c0mEqhBZzVIkP0A5GVPKTjW
	MmIk00DodONblOpf9YviYK3G31Se1umpcFFN04E69Tvv5yshHBCeWCT9RNgR5FOm
	qsXAAOO8SqVlheFORfYw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xxw38sc54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 21:20:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 446LKTjG009243
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 May 2024 21:20:29 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 6 May 2024 14:20:28 -0700
From: Muna Sinada <quic_msinada@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH 1/2] wifi: mac80211: relocate __ieee80211_subif_start_xmit() definition
Date: Mon, 6 May 2024 14:20:13 -0700
Message-ID: <20240506212014.670423-2-quic_msinada@quicinc.com>
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
X-Proofpoint-GUID: r3V4wrXpP-v-BXkaevyy5ZNRHuLj0skc
X-Proofpoint-ORIG-GUID: r3V4wrXpP-v-BXkaevyy5ZNRHuLj0skc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_15,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=678 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2405060155

Move __ieee80211_subif_start_xmit() definition below
ieee80211_8023_xmit() due to subsequent patch adding
ieee80211_8023_xmit() function call in __ieee80211_subif_start_xmit().

Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 net/mac80211/tx.c | 164 +++++++++++++++++++++++-----------------------
 1 file changed, 82 insertions(+), 82 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index cfd0a62d0152..c0e0b5f63714 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4265,88 +4265,6 @@ void ieee80211_txq_schedule_start(struct ieee80211_hw *hw, u8 ac)
 }
 EXPORT_SYMBOL(ieee80211_txq_schedule_start);
 
-void __ieee80211_subif_start_xmit(struct sk_buff *skb,
-				  struct net_device *dev,
-				  u32 info_flags,
-				  u32 ctrl_flags,
-				  u64 *cookie)
-{
-	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
-	struct ieee80211_local *local = sdata->local;
-	struct sta_info *sta;
-	struct sk_buff *next;
-	int len = skb->len;
-
-	if (unlikely(!ieee80211_sdata_running(sdata) || skb->len < ETH_HLEN)) {
-		kfree_skb(skb);
-		return;
-	}
-
-	sk_pacing_shift_update(skb->sk, sdata->local->hw.tx_sk_pacing_shift);
-
-	rcu_read_lock();
-
-	if (ieee80211_vif_is_mesh(&sdata->vif) &&
-	    ieee80211_hw_check(&local->hw, SUPPORT_FAST_XMIT) &&
-	    ieee80211_mesh_xmit_fast(sdata, skb, ctrl_flags))
-		goto out;
-
-	if (ieee80211_lookup_ra_sta(sdata, skb, &sta))
-		goto out_free;
-
-	if (IS_ERR(sta))
-		sta = NULL;
-
-	skb_set_queue_mapping(skb, ieee80211_select_queue(sdata, sta, skb));
-	ieee80211_aggr_check(sdata, sta, skb);
-
-	if (sta) {
-		struct ieee80211_fast_tx *fast_tx;
-
-		fast_tx = rcu_dereference(sta->fast_tx);
-
-		if (fast_tx &&
-		    ieee80211_xmit_fast(sdata, sta, fast_tx, skb))
-			goto out;
-	}
-
-	/* the frame could be fragmented, software-encrypted, and other
-	 * things so we cannot really handle checksum or GSO offload.
-	 * fix it up in software before we handle anything else.
-	 */
-	skb = ieee80211_tx_skb_fixup(skb, 0);
-	if (!skb) {
-		len = 0;
-		goto out;
-	}
-
-	skb_list_walk_safe(skb, skb, next) {
-		skb_mark_not_on_list(skb);
-
-		if (skb->protocol == sdata->control_port_protocol)
-			ctrl_flags |= IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP;
-
-		skb = ieee80211_build_hdr(sdata, skb, info_flags,
-					  sta, ctrl_flags, cookie);
-		if (IS_ERR(skb)) {
-			kfree_skb_list(next);
-			goto out;
-		}
-
-		dev_sw_netstats_tx_add(dev, 1, skb->len);
-
-		ieee80211_xmit(sdata, sta, skb);
-	}
-	goto out;
- out_free:
-	kfree_skb(skb);
-	len = 0;
- out:
-	if (len)
-		ieee80211_tpt_led_trig_tx(local, len);
-	rcu_read_unlock();
-}
-
 static int ieee80211_change_da(struct sk_buff *skb, struct sta_info *sta)
 {
 	struct ethhdr *eth;
@@ -4729,6 +4647,88 @@ netdev_tx_t ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+void __ieee80211_subif_start_xmit(struct sk_buff *skb,
+				  struct net_device *dev,
+				  u32 info_flags,
+				  u32 ctrl_flags,
+				  u64 *cookie)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_local *local = sdata->local;
+	struct sta_info *sta;
+	struct sk_buff *next;
+	int len = skb->len;
+
+	if (unlikely(!ieee80211_sdata_running(sdata) || skb->len < ETH_HLEN)) {
+		kfree_skb(skb);
+		return;
+	}
+
+	sk_pacing_shift_update(skb->sk, sdata->local->hw.tx_sk_pacing_shift);
+
+	rcu_read_lock();
+
+	if (ieee80211_vif_is_mesh(&sdata->vif) &&
+	    ieee80211_hw_check(&local->hw, SUPPORT_FAST_XMIT) &&
+	    ieee80211_mesh_xmit_fast(sdata, skb, ctrl_flags))
+		goto out;
+
+	if (ieee80211_lookup_ra_sta(sdata, skb, &sta))
+		goto out_free;
+
+	if (IS_ERR(sta))
+		sta = NULL;
+
+	skb_set_queue_mapping(skb, ieee80211_select_queue(sdata, sta, skb));
+	ieee80211_aggr_check(sdata, sta, skb);
+
+	if (sta) {
+		struct ieee80211_fast_tx *fast_tx;
+
+		fast_tx = rcu_dereference(sta->fast_tx);
+
+		if (fast_tx &&
+		    ieee80211_xmit_fast(sdata, sta, fast_tx, skb))
+			goto out;
+	}
+
+	/* the frame could be fragmented, software-encrypted, and other
+	 * things so we cannot really handle checksum or GSO offload.
+	 * fix it up in software before we handle anything else.
+	 */
+	skb = ieee80211_tx_skb_fixup(skb, 0);
+	if (!skb) {
+		len = 0;
+		goto out;
+	}
+
+	skb_list_walk_safe(skb, skb, next) {
+		skb_mark_not_on_list(skb);
+
+		if (skb->protocol == sdata->control_port_protocol)
+			ctrl_flags |= IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP;
+
+		skb = ieee80211_build_hdr(sdata, skb, info_flags,
+					  sta, ctrl_flags, cookie);
+		if (IS_ERR(skb)) {
+			kfree_skb_list(next);
+			goto out;
+		}
+
+		dev_sw_netstats_tx_add(dev, 1, skb->len);
+
+		ieee80211_xmit(sdata, sta, skb);
+	}
+	goto out;
+ out_free:
+	kfree_skb(skb);
+	len = 0;
+ out:
+	if (len)
+		ieee80211_tpt_led_trig_tx(local, len);
+	rcu_read_unlock();
+}
+
 struct sk_buff *
 ieee80211_build_data_template(struct ieee80211_sub_if_data *sdata,
 			      struct sk_buff *skb, u32 info_flags)
-- 
2.34.1


