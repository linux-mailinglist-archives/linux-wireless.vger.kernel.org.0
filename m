Return-Path: <linux-wireless+bounces-37395-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iP7SCl+qIWqDKwEAu9opvQ
	(envelope-from <linux-wireless+bounces-37395-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 18:39:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5F6641EDA
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 18:39:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=YY6TRu+O;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37395-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37395-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7C8731C3C6B
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 16:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F3149250A;
	Thu,  4 Jun 2026 16:24:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EC2492194
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2026 16:24:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590273; cv=none; b=PNtQlitlyqjEfkTqOkE/QhlN5XjIH8TtP0EgSCJ9oTe3NlAPp1vB058Mw0+sPXkA1plpOa7e1hSmgtSWOQMrlF7UyvwrXeyn2w5wZpf9z875rSfFq5xCd7qKxmF5ahH5ttK3uDQ4pFh0lrZzDW8YQcxMfg8lJX8GWg8p02fwRPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590273; c=relaxed/simple;
	bh=NgU0V+auS3yuy/5JGMaJDMz3TIzXTqhkNKOxDBrX9zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hprnfJ6LhsGEOLhu4aT9AZi3XfJOP8vMMp9iLe7HiBYDW6WPFU7jj5g1BBRVn6B6NSXCZ4Y6v3cjV1/Nvtr1WdvNciVVV1lKeXUO0UP8nrp2t2lrauETQs0C/xKB3JwQ/qfLEBQ6bBvr6herTO9MW7uiUCSfWbOWpSH2c477DXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YY6TRu+O; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654CDWqp3222779;
	Thu, 4 Jun 2026 16:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6v0JoBgkCXl
	g62qYWgUc4/I1luo/JtIriHdvZGbexsY=; b=YY6TRu+O1pDtOfxUkleBCynRUzH
	SFWl8bArw4nYcdYJlx3bHbM/8NuGM1sMa+OtKPJm/qSjfZaqAicx4/YA1yWcNB6g
	4Ubw245U6C5246iQqgJ8ocrAQsNFlXTIJb9XjIiEC875+37olEFrsiUieQ2CZblQ
	2/dLzL2d+if5RV0UZntGRligfdLe8XZlBDsAVgBsMLUSKbHdP9EScFKbv2iW9r21
	VbEJkfkMFAlea/z7ZCRW5WpbufrqesmDXLczC44+Qqw7pZR97rYP502pg2bsRaKw
	wq5KB4mwXhtz1M7loUd3mZILZke5onyhxntUI4eIDP9TqMZdzV/KIaX/pAA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek95u98je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 16:24:24 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 654GOKm4020836;
	Thu, 4 Jun 2026 16:24:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4efrykcnn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 16:24:21 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 654GOKkk020845;
	Thu, 4 Jun 2026 16:24:21 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 654GOK1p020844
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 16:24:20 +0000 (GMT)
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id 040DF4210A; Thu,  4 Jun 2026 21:54:20 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH wireless-next v2 3/3] wifi: mac80211: Add 802.3 multicast encapsulation offload support
Date: Thu,  4 Jun 2026 21:54:03 +0530
Message-Id: <20260604162403.1563729-4-tamizh.raja@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=at2CzyZV c=1 sm=1 tr=0 ts=6a21a6b8 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=Ey_6hWEVD5QzAVX8jzgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE2MCBTYWx0ZWRfX3aVViLlADnrO
 xo1quY4sHS+xLwZNSRT21Z384Qc6u195af3kC5hA06A6moNX7PhEXp7u1JSfkjQcBbMwGpNytxh
 Ozx8ca6A0BQOmrndAqMkr6RwIDxetSGECOjYzibx9M6WJxml5B/QkH617Bd+P8y3fTgKLz5g5M3
 CM5o2Zxi96JLAOWH00srtyIORolZjqMKhaxTE9J2ds/ZqTHBrWX4nLbsbyn3mVeBB4bmla4INnZ
 2vblj1useW53m8a8HkbjUMau3M/xAw8wgYwMIEdPNvi6mWqspUNc0Mf1GYO8z3tO/vZDwR/Ti0i
 eVdWgJ4KxWMSScZA4Xj91n9j1dqDH8dDM4DMPclb0hWIAakf/si2158y5l72fQJGJx8AQTH1QbW
 ySlAoZ/dbzD6YbRKWGMgJ03S0ZFqexd9tMomHy8z8Q7zH4PGv0br2xnpychcU8Pz4nvPT7LLJEW
 h3znGOPAkwTy+HsVrAA==
X-Proofpoint-GUID: xGR-a8kFAsfT08FRCNDRqg0JoYVuqPzM
X-Proofpoint-ORIG-GUID: xGR-a8kFAsfT08FRCNDRqg0JoYVuqPzM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040160
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37395-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:tamizh.raja@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A5F6641EDA

mac80211 converts 802.3 multicast packets to 802.11 format
before driver TX, even when Ethernet encapsulation offload
is enabled. This prevents drivers that support multicast
Ethernet encapsulation offload from receiving frames in
native 802.3 format.

Introduce the IEEE80211_OFFLOAD_ENCAP_MCAST flag to bypass the
802.11 encapsulation step and pass the multicast packet to the
driver in 802.3 format. Drivers that support multicast Ethernet
encapsulation offload can advertise this flag.

Disable multicast encapsulation offload in MLO case for drivers not
advertising MLO_MCAST_MULTI_LINK_TX support for AP mode and for
3-address AP_VLAN multicast packets.

Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
---
 include/net/mac80211.h |  4 ++++
 net/mac80211/tx.c      | 49 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 7dd558f4025b..4f95da023746 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2014,12 +2014,16 @@ enum ieee80211_vif_flags {
  * @IEEE80211_OFFLOAD_DECAP_ENABLED: rx encapsulation offload is enabled
  *	The driver supports passing received 802.11 frames as 802.3 frames to
  *	mac80211.
+ * @IEEE80211_OFFLOAD_ENCAP_MCAST: tx multicast encapsulation offload is enabled
+ *	The driver supports sending multicast frames passed as 802.3 frames
+ *	by mac80211.
  */
 
 enum ieee80211_offload_flags {
 	IEEE80211_OFFLOAD_ENCAP_ENABLED		= BIT(0),
 	IEEE80211_OFFLOAD_ENCAP_4ADDR		= BIT(1),
 	IEEE80211_OFFLOAD_DECAP_ENABLED		= BIT(2),
+	IEEE80211_OFFLOAD_ENCAP_MCAST		= BIT(3),
 };
 
 #define IEEE80211_NAN_AVAIL_BLOB_MAX_LEN	54
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a353758f53ff..ebe50bf23efc 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4746,11 +4746,32 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	kfree_skb(skb);
 }
 
+static bool ieee80211_check_mcast_offload(struct ieee80211_sub_if_data *sdata,
+					  struct sk_buff *skb)
+{
+	struct ethhdr *ehdr = (struct ethhdr *)skb->data;
+
+	if ((ieee80211_vif_is_mld(&sdata->vif) &&
+	     (sdata->vif.type == NL80211_IFTYPE_AP &&
+	      !ieee80211_hw_check(&sdata->local->hw, MLO_MCAST_MULTI_LINK_TX))) ||
+	    (sdata->vif.type == NL80211_IFTYPE_AP_VLAN &&
+	     !sdata->wdev.use_4addr))
+		return false;
+
+	if (!is_multicast_ether_addr(skb->data) ||
+	    !(sdata->vif.offload_flags & IEEE80211_OFFLOAD_ENCAP_MCAST) ||
+	    sdata->control_port_protocol == ehdr->h_proto)
+		return false;
+
+	return true;
+}
+
 static void __ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
 					      struct net_device *dev)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ethhdr *ehdr = (struct ethhdr *)skb->data;
+	struct ieee80211_link_data *link;
 	struct ieee80211_key *key;
 	struct sta_info *sta;
 
@@ -4761,14 +4782,30 @@ static void __ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
 		goto out;
 	}
 
-	if (unlikely(IS_ERR_OR_NULL(sta) || !sta->uploaded ||
+	/*
+	 * If STA is invalid, use the multicast offload path when applicable.
+	 * In AP mode, drop the frame if there are no associated stations;
+	 * otherwise use the default link and multicast key for transmission.
+	 */
+	if (IS_ERR_OR_NULL(sta) &&
+	    unlikely(ieee80211_check_mcast_offload(sdata, skb))) {
+		sta = NULL;
+		if (ieee80211_vif_get_num_mcast_if(sdata) <= 0) {
+			/* No associated STAs - no need to send multicast frames. */
+			kfree_skb(skb);
+			goto out;
+		}
+		link = &sdata->deflink;
+		key = rcu_dereference(link->default_multicast_key);
+	} else if (unlikely(IS_ERR_OR_NULL(sta) || !sta->uploaded ||
 	    !test_sta_flag(sta, WLAN_STA_AUTHORIZED) ||
-	    sdata->control_port_protocol == ehdr->h_proto))
+	    sdata->control_port_protocol == ehdr->h_proto)) {
 		goto skip_offload;
-
-	key = rcu_dereference(sta->ptk[sta->ptk_idx]);
-	if (!key)
-		key = rcu_dereference(sdata->default_unicast_key);
+	} else {
+		key = rcu_dereference(sta->ptk[sta->ptk_idx]);
+		if (!key)
+			key = rcu_dereference(sdata->default_unicast_key);
+	}
 
 	if (key && (!(key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE) ||
 		    key->conf.cipher == WLAN_CIPHER_SUITE_TKIP))
-- 
2.34.1


