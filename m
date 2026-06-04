Return-Path: <linux-wireless+bounces-37394-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q+nsCVGpIWo0KwEAu9opvQ
	(envelope-from <linux-wireless+bounces-37394-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 18:35:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B595A641E1F
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 18:35:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=IOcig9Mi;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37394-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37394-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B22B930AD69C
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 16:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF847481AAB;
	Thu,  4 Jun 2026 16:24:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E3F481FCD
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2026 16:24:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590273; cv=none; b=Z/LEY8scgAnY9Nubw7cOgz5tlk866XZjUQ3CQE6nS/uKnnmskNKsasD+ElAKFSV65Wv5YuyOtZc1pUd5vZhtbTSVljrx3qNLZYz2cRV69WMNNtlcSKK9crt1gNXvrF+/fYaaU1w7oRGqCHJUwhiyopB8rV6PPc13DFMz1VYgwxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590273; c=relaxed/simple;
	bh=ZsQdIAy+meq4G/2Eba7T26HA0RhSzoYIH5XfOMuaX6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DgzmDeQuTUri77oXjNLSVW2/SUWQnUGYKuM9QE19EoUfUSeh6hlWUPPfWzjGuL6oflpnPOlPYjkcCPTDjd5S/MWTRS1xctKl5qDxBqGCsfkeGPuk9pXvHXTUlEMJASugMcwI6TMmCyKKrGirOQOWTSIBDBOzs9yiEQjeeovIqtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IOcig9Mi; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654BYooi995280;
	Thu, 4 Jun 2026 16:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vJGhDZx5uEr
	ihcZ1++ElaaqlkWEIkedmkgJdPCzoy8w=; b=IOcig9MiKPHIx2W5ag6+L1dCWAG
	VoySADrOYn+Dqv/GnYMAn23/i4ze7/J2zHRHPhchk4foVI1xh5SuaQsoUO/wq5Np
	ugFP0n8S6KEXARLgWVB9AdN+rBCiY5YOgCHdQOwD4/bSaoxN431d3frG54iNKhsF
	P8LYpNCobjegfYi6tkWHYoU5t05zZsxLHS4PNQtIWZ47QxPWARf6nsyp/m7fUQk/
	P31TiQ0jynReevbSTDnNfyQIWsihZnbCV3Go5ykN+dLHFkPlyUHaQJFbru4t3yfU
	FqKhCB7JhYGZmCCTF+p3htCHDMr9L6oSSUFPXWmNW3gPPeqcAV9STPOegVA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek374tng2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 16:24:23 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 654GOKm3020836;
	Thu, 4 Jun 2026 16:24:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4efrykcnmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 16:24:20 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 654GOKeg020831;
	Thu, 4 Jun 2026 16:24:20 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 654GOKHh020830
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 16:24:20 +0000 (GMT)
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id 2FB0142107; Thu,  4 Jun 2026 21:54:19 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH wireless-next v2 2/3] wifi: mac80211: Add multicast to unicast support for 802.3 path
Date: Thu,  4 Jun 2026 21:54:02 +0530
Message-Id: <20260604162403.1563729-3-tamizh.raja@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604162403.1563729-1-tamizh.raja@oss.qualcomm.com>
References: <20260604162403.1563729-1-tamizh.raja@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE2MCBTYWx0ZWRfX3jujAnNHbWXD
 6kBZlXhTe6K33OezRszh8YkwT7FelF8RWvCDkfzz9Y9VKvYJ9q86cSxLJ9Ra3qpBtOIn6b994nm
 et/RjMpskgkpkUuKZ/rPUj6ldk36+SOqfuHY2ECa8AmI7IIGf7qpD2yuQl88XaxRoUFL7eDeGRr
 x3/1Pf/2pl93O88YOpe6wD0XTMFixAixEOgIsZ8pKM97QwoNmBAd7SyV4kPZ7Z+6cZwIkL9uZ6Y
 NpSBI+ts606J9h517RtpKJFYqXCPfnGsuP8nyc/hlrEhXiuKX08yivBZZDQC1EYc7XqzP+Zm8Kc
 LSMFxaHE+a7oRZbvImm/3pDpXAdQqyZXIGDN5b+VXs77cu0oXQSABuW/wfvtuX1ndsu/WWadpAB
 q6r3IoEPhiCHNCRSHUfdjYybH63rfjErSKpKkAdkmFJna8gMdbA07mmQfPp2B7bKWRkSPaJeOW0
 nT8XqsUNaipd1Op4sFQ==
X-Proofpoint-GUID: DHAVx_Hz2hbDej1FZb-fuSR6guFnLVTq
X-Proofpoint-ORIG-GUID: DHAVx_Hz2hbDej1FZb-fuSR6guFnLVTq
X-Authority-Analysis: v=2.4 cv=eJsjSnp1 c=1 sm=1 tr=0 ts=6a21a6b7 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=hy-MqIdau6L9KCk-2joA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606040160
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37394-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:tamizh.raja@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:mid,vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B595A641E1F

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
index 15ec77255c3f..a353758f53ff 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4746,19 +4746,14 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
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
@@ -4787,6 +4782,30 @@ netdev_tx_t ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
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


