Return-Path: <linux-wireless+bounces-37496-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aS3xLY6HJmrOYAIAu9opvQ
	(envelope-from <linux-wireless+bounces-37496-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 11:12:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A3265472C
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 11:12:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=QTS+151P;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=DFsUipcN;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37496-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37496-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A034300F768
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 09:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5EE2E62B4;
	Mon,  8 Jun 2026 09:07:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE553B42FB
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 09:07:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909679; cv=none; b=nF9uHf7grVFNu+ol5MiU0FM7v39/q416l/2MopoI0mBOkPayuSGN7xlgBZbRVMLIrHVOlhdZkgdMuWcjgwxocTIgpbKqVHXGqckZ8+r+jFggxuVqZEIjpinQb05KMmCTqWDhpwGNDGxzaqcFprUdLpmRgWU+AjuF9dY766Gl7yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909679; c=relaxed/simple;
	bh=o2LYGfTbuQ31+K7b//XXon0t/cFHdkPtaprGFq1GlYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tAkMLwAyhH4TBEyr5tQ/8fIaqdAAgABZSjvu6mpvvxrmMCH+otu4eJfGmS3wJviGnHebBycX8PmUT9HKm4MNoRLQcWCZT4w/MnL+QcASOW0Hz1PBKeG8v5/J9D46e+q5xXbdEL4wcnHPitTzyHxGgOoW61KdvvSUVWijURJ9HAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QTS+151P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DFsUipcN; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65890xxl3164877
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 09:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3EoAoWPMpRX
	N58wbSZ9OZgBJ/La8GgdI/YVM2n6Ye0A=; b=QTS+151PfiFmURQ0aVjkPRO3B3B
	jcFudOklL6nmWRuKD24MmDav9/65U623qKydvELhwzg5uzHgNDiL3AyZu3wCkPy0
	8z4yLbQVX/TKoo0D7hhLyCQ6EXnqg0dF8B2wtXC4WLfAqdXIIa5U0QagcUPsNPTG
	61MEQTuNlBgV3N8uPt456Z2YBcASCF7sWeqeA09aRbHuGi54VPt8NUH8Mqab2hcT
	Ygyw9CYJOHJtvGuVPrwAFapumZznYjwFmmZ7Pcpsqx+CXLca4jobcqpPG4Cs5pSg
	tNUA/yonKRhWL71c8blVo/+EJPa7lhetE+gmsk5GZio6e7vvaiddztWmtAw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entr0g16e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 09:07:55 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36bc5e97950so4746493a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 02:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780909675; x=1781514475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EoAoWPMpRXN58wbSZ9OZgBJ/La8GgdI/YVM2n6Ye0A=;
        b=DFsUipcNh87s8gAe5Giu3y9gCS0uSLPtA5EMooD9bTVeKwZcA584yeA2wEg0hktzBy
         +GXtF6WnpWaPj1HlMRr12t+yappdXFzMgW3oTbAWp8m/wUuVH/3geUN1JM4I3Ejhmj3B
         7FzHvskyDHouasuI7K76zG4Xp26Bqa+Z+nfKuLPfSNBNzcdJfdz4NuutM1roe4qL5idF
         f3k/iZyLu7VBx6Rwb2LDucfrhC2mMwHDenvPeysFtv6vwrnkC2z1nzGKmsampiXB4qHJ
         xcPU49GjDIELjn+Mx7v2n4cULQus6dND0QqEqKUgxKSEEqoeeYw3VMArFpOtSW2MkIJ3
         583g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780909675; x=1781514475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3EoAoWPMpRXN58wbSZ9OZgBJ/La8GgdI/YVM2n6Ye0A=;
        b=ETkMVuDvmsEgJfPFxfqj23lHYfqY3/Cs42CgQeR2yAwswD3BeWO+DnyvohHCDJ3TwA
         p2fXihIjICMB3Kspc4wHULGpWdg6jLXyLz/SmSdLZ9JXo3r+zjcDjK1i81L5fAC405OR
         9EJmw2fbqUxaQbn4Bn0kB8wpK43qZX1vyU9db5QdUqFiz9NGREOgSiBohiSBUoQ56seP
         0WQrjVH51ab64SpxGQtVuI+1t6gt4WdPDYNnmQgJ8LdAIRp68L3o3hDFETd8uKf1nkkS
         F3f6J4oPvqxV7ZPt36WOWpo61TO71l6UGSm2Qvfn4AyQWxXf7O7GGcn6Hox0DMLjRZzD
         USYg==
X-Gm-Message-State: AOJu0YxJlKyghDnD8SsieNKC8s5XzqRr2WKacDrsQR5JrkDaSsF5S0Dw
	YS27i/k7B9Hc/H0QZBuUp7iXO/hKjlXRkAn+Px+ouEU2+hlR4zhbYeIou0H1BqCBSDHonHZUQy5
	REvophQkJ5+IJQ+RtWwPOoFdXCBa/DYtjE2pZi0XXnBctNJRxsPXmOLD/voWePgIeuvED4BOnYe
	7XyQ==
X-Gm-Gg: Acq92OFV13fjxNiGKjd2tN9MZM6cR87HhkF3QZZtT8AptHaHN36u1RDZ3eJI7iJRmT+
	cogQcqfiF/5I9LxSYitJ2rYUQ86ILnEw/kj6Rhhif1tP6g5SDKcC9aMxP7lYcjwkAnK+1bh8g7x
	2wNWhe6WH1k7FMtSiJOSfzPXSmYBcSfbUnvC8BduSi8FFm0RGKJLAqTza6FYuoz0jpDCgPUKchx
	3QPYdEGm1WagyEYJ6zeoUyggwSParFril4ZBviH88efBozrQ5fwycYUZPZv1TGDJRY/jkLgwBJD
	3rYusHp2W0fQmQH81OnWbLithQgZ7O2Ubthu0HT/WiYHRIePwlT0zT59dU/IFrJxw7+tbCuHdG5
	GylJ8maEKn3rTUBGufUJZM5EEdCyMNdyAOy9mdqOw+SL1ZQYNAfz4T2bW
X-Received: by 2002:a17:90b:3512:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-370ee82fa3cmr15110892a91.1.1780909674568;
        Mon, 08 Jun 2026 02:07:54 -0700 (PDT)
X-Received: by 2002:a17:90b:3512:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-370ee82fa3cmr15110876a91.1.1780909674159;
        Mon, 08 Jun 2026 02:07:54 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282379db0sm16512603b3a.24.2026.06.08.02.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 02:07:53 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com,
        veerendranath.jakkam@oss.qualcomm.com
Subject: [PATCH wireless-next v4 3/4] wifi: mac80211: implement STA-mode peer probing
Date: Mon,  8 Jun 2026 14:37:26 +0530
Message-Id: <20260608090727.2389161-4-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608090727.2389161-1-pritiwa@qti.qualcomm.com>
References: <20260608090727.2389161-1-pritiwa@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4MyBTYWx0ZWRfX4Ez5I4DG0Yjc
 teV3adloZpjcawUNpHLuOfyuMawfBmJ0ahhGCvHniGwVdyQrGR5L6v+bUN8IThpnqPVc7V62dHo
 1siQGxvnYHos2RJVwh8d3PVfFWE1M9/Jgd6dK2IqyuZs3iQ8KxH5c0thuYZtt5PcZDUpI2Jw+A4
 FcEZVVvZGByK6n1VNQzBPtK7beN2CdYFGNcDY1EgFDzhYYrxPp9TkJsJOadBQ2ddeQCtZaUgs4V
 iqCgEvBLPvdoLCsk4jc9s8ZKqh0y/w+OuvsVQPu3oYoEpFu8SNjEOYB0W2QyctefU8LRsYkC+jk
 MbEeVe1aV5rtISchS48ROx/9Lb2h48EqVOatapZOa1UwBT9067eqJyBU89uGZnM1X0O/gxUVIIg
 FaSsWDxgzk2RS2poTO1H0+PGptCIrwBYZaTgXW8XzczWzSqUib/b8DkSpBDsyVsNAoKqpu0kIYg
 deUQnpQp0iRUNmG+vEA==
X-Proofpoint-ORIG-GUID: uzoea3hU5XPswtwj8UZwQuDyq5gF68z7
X-Proofpoint-GUID: uzoea3hU5XPswtwj8UZwQuDyq5gF68z7
X-Authority-Analysis: v=2.4 cv=VowTxe2n c=1 sm=1 tr=0 ts=6a26866b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=1tVaBpimU39H8dQPe8UA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080083
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37496-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:quic_drohan@quicinc.com,m:veerendranath.jakkam@oss.qualcomm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52A3265472C

From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>

Add STA/P2P-client support to ieee80211_probe_peer(): when called
for a station interface, send a null-data frame (TODS) to the
associated AP and report the ACK via cfg80211_probe_status().

For MLO connections the driver/firmware selects the link
(IEEE80211_LINK_UNSPECIFIED); for non-MLO the single link is used.

Signed-off-by: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
---
 include/net/mac80211.h |   2 +-
 net/mac80211/cfg.c     | 152 +++++++++++++++++++++++------------------
 net/mac80211/status.c  |   5 +-
 3 files changed, 89 insertions(+), 70 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 4fb579805e0f..6df439ef9807 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1396,7 +1396,7 @@ struct ieee80211_tx_info {
 			u8 pad;
 			u16 tx_time;
 			u8 flags;
-			u8 pad2;
+			u8 link_valid:1, link_id:4;
 			void *status_driver_data[16 / sizeof(void *)];
 		} status;
 		struct {
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f948b1331e3e..977e2c75b575 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4922,101 +4922,121 @@ static int ieee80211_probe_peer(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_qos_hdr *nullfunc;
 	struct sk_buff *skb;
-	int size = sizeof(*nullfunc);
 	__le16 fc;
-	bool qos;
+	bool qos, fromds;
+	struct ieee80211_bss_conf *conf;
 	struct ieee80211_tx_info *info;
 	struct sta_info *sta;
 	struct ieee80211_chanctx_conf *chanctx_conf;
-	struct ieee80211_bss_conf *conf;
 	enum nl80211_band band;
-	u8 link_id;
+	const u8 *peer_addr;
+	const u8 *src_addr;
+	int link_id;
+	int size;
 	int ret;
 
 	/* the lock is needed to assign the cookie later */
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	rcu_read_lock();
-	sta = sta_info_get_bss(sdata, peer);
-	if (!sta) {
-		ret = -ENOLINK;
-		goto unlock;
-	}
-
-	qos = sta->sta.wme;
-
-	if (ieee80211_vif_is_mld(&sdata->vif)) {
-		if (sta->sta.mlo) {
-			link_id = IEEE80211_LINK_UNSPECIFIED;
-		} else {
-			/*
-			 * For non-MLO clients connected to an AP MLD, band
-			 * information is not used; instead, sta->deflink is
-			 * used to send packets.
-			 */
-			link_id = sta->deflink.link_id;
+	switch (sdata->vif.type) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+		sta = sta_info_get_bss(sdata, peer);
+		if (!sta)
+			return -ENOLINK;
 
-			conf = rcu_dereference(sdata->vif.link_conf[link_id]);
+		qos = sta->sta.wme;
+		peer_addr = sta->sta.addr;
 
-			if (unlikely(!conf)) {
-				ret = -ENOLINK;
-				goto unlock;
+		if (ieee80211_vif_is_mld(&sdata->vif)) {
+			if (sta->sta.mlo) {
+				link_id = IEEE80211_LINK_UNSPECIFIED;
+				src_addr = sdata->vif.addr;
+			} else {
+				/*
+				 * For non-MLO clients connected to an AP MLD,
+				 * use the link address for the client's link.
+				 */
+				link_id = sta->deflink.link_id;
+				conf = wiphy_dereference(local->hw.wiphy,
+							 sdata->vif.link_conf[link_id]);
+				if (unlikely(!conf))
+					return -ENOLINK;
+				src_addr = conf->addr;
 			}
+			/* MLD transmissions must not rely on the band */
+			band = 0;
+		} else {
+			chanctx_conf = wiphy_dereference(local->hw.wiphy,
+							 sdata->vif.bss_conf.chanctx_conf);
+			if (WARN_ON(!chanctx_conf))
+				return -EINVAL;
+			band = chanctx_conf->def.chan->band;
+			link_id = 0;
+			src_addr = sdata->vif.addr;
 		}
-		/* MLD transmissions must not rely on the band */
-		band = 0;
-	} else {
-		chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
-		if (WARN_ON(!chanctx_conf)) {
-			ret = -EINVAL;
-			goto unlock;
+		fromds = true;
+		break;
+
+	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_P2P_CLIENT:
+		link_id = IEEE80211_LINK_UNSPECIFIED;
+		peer_addr = sdata->vif.cfg.ap_addr;
+		src_addr = sdata->vif.addr;
+		if (!ieee80211_vif_is_mld(&sdata->vif)) {
+			chanctx_conf = wiphy_dereference(local->hw.wiphy,
+							 sdata->vif.bss_conf.chanctx_conf);
+			if (WARN_ON(!chanctx_conf))
+				return -EINVAL;
+			band = chanctx_conf->def.chan->band;
+		} else {
+			band = 0;
 		}
-		band = chanctx_conf->def.chan->band;
-		link_id = 0;
+		sta = sta_info_get(sdata, peer_addr);
+		if (!sta)
+			return -ENOLINK;
+		qos = sta->sta.wme;
+		fromds = false;
+		break;
+
+	default:
+		return -EOPNOTSUPP;
 	}
 
-	if (qos) {
-		fc = cpu_to_le16(IEEE80211_FTYPE_DATA |
-				 IEEE80211_STYPE_QOS_NULLFUNC |
-				 IEEE80211_FCTL_FROMDS);
-	} else {
+	size = sizeof(*nullfunc);
+	fc = cpu_to_le16(IEEE80211_FTYPE_DATA |
+			 (qos ? IEEE80211_STYPE_QOS_NULLFUNC
+			      : IEEE80211_STYPE_NULLFUNC) |
+			 (fromds ? IEEE80211_FCTL_FROMDS : IEEE80211_FCTL_TODS));
+	if (!qos)
 		size -= 2;
-		fc = cpu_to_le16(IEEE80211_FTYPE_DATA |
-				 IEEE80211_STYPE_NULLFUNC |
-				 IEEE80211_FCTL_FROMDS);
-	}
 
 	skb = dev_alloc_skb(local->hw.extra_tx_headroom + size);
-	if (!skb) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
+	if (!skb)
+		return -ENOMEM;
 
 	skb->dev = dev;
-
 	skb_reserve(skb, local->hw.extra_tx_headroom);
 
 	nullfunc = skb_put(skb, size);
+	memset(nullfunc, 0, size);
 	nullfunc->frame_control = fc;
-	nullfunc->duration_id = 0;
-	memcpy(nullfunc->addr1, sta->sta.addr, ETH_ALEN);
-	if (ieee80211_vif_is_mld(&sdata->vif) && !sta->sta.mlo) {
-		memcpy(nullfunc->addr2, conf->addr, ETH_ALEN);
-		memcpy(nullfunc->addr3, conf->addr, ETH_ALEN);
-	} else {
-		memcpy(nullfunc->addr2, sdata->vif.addr, ETH_ALEN);
-		memcpy(nullfunc->addr3, sdata->vif.addr, ETH_ALEN);
-	}
-	nullfunc->seq_ctrl = 0;
 
-	info = IEEE80211_SKB_CB(skb);
+	memcpy(nullfunc->addr1, peer_addr, ETH_ALEN);
+	memcpy(nullfunc->addr2, src_addr, ETH_ALEN);
+	memcpy(nullfunc->addr3, fromds ? src_addr : peer_addr, ETH_ALEN);
 
+	info = IEEE80211_SKB_CB(skb);
 	info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS |
 		       IEEE80211_TX_INTFL_NL80211_FRAME_TX;
 	info->band = band;
-
 	info->control.flags |= u32_encode_bits(link_id,
 					       IEEE80211_TX_CTRL_MLO_LINK);
+	if (link_id != IEEE80211_LINK_UNSPECIFIED) {
+		info->status.link_valid = 1;
+		info->status.link_id = link_id;
+	}
+
 	skb_set_queue_mapping(skb, IEEE80211_AC_VO);
 	skb->priority = 7;
 	if (qos)
@@ -5025,18 +5045,14 @@ static int ieee80211_probe_peer(struct wiphy *wiphy, struct net_device *dev,
 	ret = ieee80211_attach_ack_skb(local, skb, cookie, GFP_ATOMIC);
 	if (ret) {
 		kfree_skb(skb);
-		goto unlock;
+		return ret;
 	}
 
 	local_bh_disable();
 	ieee80211_xmit(sdata, sta, skb);
 	local_bh_enable();
 
-	ret = 0;
-unlock:
-	rcu_read_unlock();
-
-	return ret;
+	return 0;
 }
 
 static int ieee80211_cfg_get_channel(struct wiphy *wiphy,
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 1bb622d06acf..f80496445f94 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -655,7 +655,10 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
 								GFP_ATOMIC);
 			else if (ieee80211_is_any_nullfunc(hdr->frame_control))
 				cfg80211_probe_status(sdata->dev, hdr->addr1,
-						      cookie, -1, acked,
+						      cookie,
+						      info->status.link_valid ?
+							info->status.link_id : -1,
+						      acked,
 						      info->status.ack_signal,
 						      is_valid_ack_signal,
 						      GFP_ATOMIC);
-- 
2.34.1


