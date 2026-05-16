Return-Path: <linux-wireless+bounces-36516-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLADNIKbCGoGxwMAu9opvQ
	(envelope-from <linux-wireless+bounces-36516-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 18:29:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C795055C9CA
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 18:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C935B3005151
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 16:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D423E8341;
	Sat, 16 May 2026 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Id28iRHd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7306D3E5ED2
	for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778948985; cv=none; b=jsDKAP4UNMRqgbHpU0TsP3IdIstHN3Eupdvpl3Z1pMClK/fLJlJSlEoac3if373HcL8ULOyirYZENRnpbaimsp4yQx3l0hxzPji4QCYPpkaOCm0tvSF7j2ZrHH5DAhKB9tyXM7w4nUpW8R+PptQyLlN5+wuoGw+Wy1NP4/a/6xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778948985; c=relaxed/simple;
	bh=bch26OPsSs4T+UUa3J76lHR+a+EfYiqLgWoZl87cpTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oTaWDwzw2SRZiIgCXFf5qO0nNRNS4O7Z4k28KR5QiNqM/hZSdcQseyVAoSG5iTPa6ZngUX6Aq0ZX6RII5he7o98O1ojsoLdM7Kved6kUEQJ9q9eJob/AQ4hrvA1rUBozOE4U1s3doQbHSA8amyD0vSdJapR0HwfgxXuBJ3rK8AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Id28iRHd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64G3fhed3243219;
	Sat, 16 May 2026 16:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LGPj0CZeMet
	vOd62M0lJr+KFwvBb/sKf7ufxfnk36uA=; b=Id28iRHdLHtd5apN+5LhG4JcW7q
	e86Tv2hIpfkH3pqcoDSxqmG4DQBjbKRtBv6yVm3lWs434x7+zUxwxK3amHykg8W8
	w/+W8TAsVow8F5gs9u5M/XjlECnXwJkY7WoxYFxe9LRd8gAtwgeyEN0UaD9NYp+3
	xplLAijfPOQ/og9B1q4Nu5qZ+00e73+71CxSPvUDL/CPryyF43efN4xITCrLM/2D
	vleGRkcPNSJmkv9igC2Gtjbu9dO6JtWz8kE1ZKuHPFsxGuuZNcue6P3yJTQT719q
	sFb/lTVIkP3tkqihYDwaNg4X9h//BQ83HjageluThT9j9zAZAuqi3Vcmu5g==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gvqs8sd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 16:29:31 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64GGTPCD017029;
	Sat, 16 May 2026 16:29:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4e6hnh5ynb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 16:29:27 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64GGTRus017039;
	Sat, 16 May 2026 16:29:27 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 64GGTRXx017038
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 16:29:27 +0000 (GMT)
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id D700541929; Sat, 16 May 2026 21:59:26 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH wireless-next 3/3] wifi: mac80211: Add 802.3 multicast encapsulation offload support
Date: Sat, 16 May 2026 21:59:00 +0530
Message-Id: <20260516162900.1981500-4-tamizh.raja@oss.qualcomm.com>
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
X-Proofpoint-GUID: LVzmr0qXEUZexGu93T7zlrybQFm3x9NO
X-Proofpoint-ORIG-GUID: LVzmr0qXEUZexGu93T7zlrybQFm3x9NO
X-Authority-Analysis: v=2.4 cv=LKJWhpW9 c=1 sm=1 tr=0 ts=6a089b6b cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=pqQ9c96EJVKEXv8CjxgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDE2MyBTYWx0ZWRfX2rvo/S62u9ZY
 yyFodjWvd2JHBFGr8zrskzHui8ikKDI0NGuCsTPu5VFY+kvx++yzZfq1ffMaDJiMGC4CZq6udxp
 q3mEPlLxQogphebehZ9dKAT/vFUPaQqZfi4JdElwIV82/UDq7lkmRlx954dRLffI5mi+FU4tPxT
 45FQKG16b+LvsWcwfb2nf2R87WIG/QJpJPXR7k8CTRA+N9MXqqGZq9Zy+1A4gZOsVlHiVM1rnRy
 pBnmKsIfAYSTqYbWxVX940aJJuRTS6azPMRJUSzAljH+ndlPWXBuwroVmasOeo1ZZB/ZD3PQMre
 UwoPesBr1TZKVe3TV9dzNejQrf5XlV4J5N8XNk+SSnFwRtQJ8pEzF25qcOxGFuairJ93EYUaHer
 j2HTjxd7bS827+F0RHyeuaafXMFwQ4AI9J36l0a3Ij0FP2iRV3znfQxfbuVGd0aBxLB7lPXmGdH
 7VIwfFGAymWgtMIFrYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605160163
X-Rspamd-Queue-Id: C795055C9CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36516-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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

mac80211 currently converts 802.3 multicast packets to 802.11 format before
invoking the driver TX path, even when the interface is configured for
Ethernet encapsulation offload. This prevents drivers that support
multicast Ethernet encapsulation offload from receiving frames in
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
 net/mac80211/tx.c      | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 4fb579805e0f..6d41227cb831 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2013,12 +2013,16 @@ enum ieee80211_vif_flags {
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
index ee3017f86f02..b2c094b06dc8 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4736,11 +4736,32 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
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
 
@@ -4751,6 +4772,25 @@ static void __ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
 		goto out;
 	}
 
+	/*
+	 * For station mode sta is valid even though dest address
+	 * is multicast and that will be sent in eth mode only.
+	 * So, add error check for sta pointer before choosing
+	 * multicast offload path.
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
+		goto tx_offload;
+	}
+
 	if (unlikely(IS_ERR_OR_NULL(sta) || !sta->uploaded ||
 	    !test_sta_flag(sta, WLAN_STA_AUTHORIZED) ||
 	    sdata->control_port_protocol == ehdr->h_proto))
@@ -4760,6 +4800,7 @@ static void __ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
 	if (!key)
 		key = rcu_dereference(sdata->default_unicast_key);
 
+tx_offload:
 	if (key && (!(key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE) ||
 		    key->conf.cipher == WLAN_CIPHER_SUITE_TKIP))
 		goto skip_offload;
-- 
2.34.1


