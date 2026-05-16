Return-Path: <linux-wireless+bounces-36517-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCkmHISbCGoGxwMAu9opvQ
	(envelope-from <linux-wireless+bounces-36517-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 18:29:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A526B55C9D1
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 18:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CBD713005304
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 16:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DF23E8663;
	Sat, 16 May 2026 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DmPvCYSJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60B13E8326
	for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778948987; cv=none; b=i5kpEzIWVJViw7rx5b52t50eEp3ASN5oQMsAjI3tqEirBBkO3KAtbjBrAj9zDoh9ZjXm++xhT2vKQB8MTzKNVLCZafB680fudmSwQqp3VHxg5c8dK/sKXvWoJZVrJbuRh+t6QHdcEVaBgKFSJzulQB21JGrdAGqGFZ0DiQMgkew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778948987; c=relaxed/simple;
	bh=+PUabzGUe30e66xnZ97yPpfyU6uh0hIMufMJcy0rNyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o0zJnhxRg4rnli4yQHNwMTh6Mvhdf//1BHj/A6unb0h7/Rt9bWEBYQ8gw+6uIwPRiCfC82viI+b6JTPkvBwHq+3dQXFEpoaike7hKUKtx1RH1DRs6S+xM5Z4DhCArR0ZprAQsNimaeZxfbPY68iGcQwHszz4NG79xJ7w85A0acs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DmPvCYSJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64G4BXhw784662;
	Sat, 16 May 2026 16:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1z6pg3OzNg4
	UFrjIeQWSbJ2cqxUKqcSzPaIKNaYiCLE=; b=DmPvCYSJcI0bj+riQqWPmp0PN2t
	WX0oLFkdlcR7fz/dsrMy1oKrhcp+hQOquuBGkT+sdkcLQ6nTrG6ujUC4j7LbSHJ7
	4ATS7BPb0ZX0P/KpVMOfNmNPIidJ3QH77mEHh2UEb5eM1/YVrCgoRCeVzzrjain6
	oB9TzBXMAfccFpbFEmmWIiVLnUV0Fjrig8lYSsxqTpdePEkSB3K6kdt24fg3d8Np
	i9hsk57nz1FAEpqdOnHsBg8cvtC0ZpjOLZk8xeS7XHu+l4qt2xEh02CxP/mRHfS4
	rEcZ9e3FiRLcKpGrpdApnQtSHlJ9s1QpFavN+el1Ju0K4XChB2zE+8UuRHw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6hbc96uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 16:29:28 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64GGTPvs017028;
	Sat, 16 May 2026 16:29:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4e6hnh5yn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 16:29:25 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64GGTPBQ017023;
	Sat, 16 May 2026 16:29:25 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 64GGTPTq017021
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 16:29:25 +0000 (GMT)
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id D97FD41FA1; Sat, 16 May 2026 21:59:24 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH wireless-next 2/3] wifi: mac80211: Add multicast to unicast support for 802.3 path
Date: Sat, 16 May 2026 21:58:59 +0530
Message-Id: <20260516162900.1981500-3-tamizh.raja@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260516162900.1981500-1-tamizh.raja@oss.qualcomm.com>
References: <20260516162900.1981500-1-tamizh.raja@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=cuSrVV4i c=1 sm=1 tr=0 ts=6a089b69 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=hy-MqIdau6L9KCk-2joA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDE2MyBTYWx0ZWRfX8ZTPxC+esjDM
 9hQcpdsQee6L8uGAKvXiUn9t0HHBlxvx0bmVmJj8WkdVBFwxSdkqkn206VymlKe2iSRCrHpw0yR
 9C5rk0GthhGjZjLC2BEuSuD1LM8dIGdBxPDjNSolC1r2Vv4Zn7Ueo/ZLuC9qk/REzLHVxz0zPxT
 I7Zb8ITWW/iM3XZkqhNxxvIU9q/T6VmRs0cHBq8dB9kL+Uv5TtXn55Ejsr2XozEI6nFIAXiRc8I
 p4mc77+XFyxRsT7Zqj0aUBD2xWx9qrk+nYC+LZonykqXPoBG17f//446PxIzBIhxbfXMWLGHKMk
 chTanJpxS0Brq322I/tX3kxmSr1aRV7CKYI0Pj3SaefihTSzAGSUTa8uIyFvNewh6ByVs4UEzWC
 CDj3srz7Qj0MKZoK9OkU1+kzoukU+WOWML9aIWKr9VcXM7H82Kwh2iigWVoNwlCpuXau8fwmPQx
 DjuTzcTGfYKprPr35eA==
X-Proofpoint-GUID: DE-gO1oiBY_UX3ZXFk6ADoK8GmMLreOU
X-Proofpoint-ORIG-GUID: DE-gO1oiBY_UX3ZXFk6ADoK8GmMLreOU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605160163
X-Rspamd-Queue-Id: A526B55C9D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36517-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

mac80211 already supports multicast-to-unicast conversion for
native 802.11 TX paths, but this handling is missing for the
802.3 transmit path. Due to that the packet never converted to
unicast and directly pass it to 802.11 Tx path by checking the
destination address as multicast.

Extend ieee80211_subif_start_xmit_8023() to honor the
multicast_to_unicast setting by cloning and converting multicast
Ethernet frames into per-station unicast transmissions, following
the same behavior of the native 802.11 TX path and allow it
to take 802.3 path.

Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
---
 net/mac80211/tx.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 5f84a3bf5cd9..ee3017f86f02 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4736,19 +4736,14 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	kfree_skb(skb);
 }
 
-netdev_tx_t ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
-					    struct net_device *dev)
+static void __ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
+					      struct net_device *dev)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ethhdr *ehdr = (struct ethhdr *)skb->data;
 	struct ieee80211_key *key;
 	struct sta_info *sta;
 
-	if (unlikely(!ieee80211_sdata_running(sdata) || skb->len < ETH_HLEN)) {
-		kfree_skb(skb);
-		return NETDEV_TX_OK;
-	}
-
 	rcu_read_lock();
 
 	if (ieee80211_lookup_ra_sta(sdata, skb, &sta)) {
@@ -4777,6 +4772,30 @@ netdev_tx_t ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
 	ieee80211_subif_start_xmit(skb, dev);
 out:
 	rcu_read_unlock();
+}
+
+netdev_tx_t ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
+					    struct net_device *dev)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ethhdr *ehdr = (struct ethhdr *)skb->data;
+
+	if (unlikely(!ieee80211_sdata_running(sdata) || skb->len < ETH_HLEN)) {
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
+	if (unlikely(is_multicast_ether_addr(ehdr->h_dest) &&
+		     ieee80211_multicast_to_unicast(skb, dev))) {
+		struct sk_buff_head queue;
+
+		__skb_queue_head_init(&queue);
+		ieee80211_convert_to_unicast(skb, dev, &queue);
+		while ((skb = __skb_dequeue(&queue)))
+			__ieee80211_subif_start_xmit_8023(skb, dev);
+	} else {
+		__ieee80211_subif_start_xmit_8023(skb, dev);
+	}
 
 	return NETDEV_TX_OK;
 }
-- 
2.34.1


