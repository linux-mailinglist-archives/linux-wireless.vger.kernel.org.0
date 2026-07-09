Return-Path: <linux-wireless+bounces-38820-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pjcYJnuKT2rLjAIAu9opvQ
	(envelope-from <linux-wireless+bounces-38820-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 13:48:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2575473093F
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 13:48:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ZEqDOnLO;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=CPH+cuzN;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38820-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38820-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEF953040DA3
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 11:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2D440FD87;
	Thu,  9 Jul 2026 11:42:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7634379C32
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jul 2026 11:42:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783597376; cv=none; b=C0CrVwQBTkcn2AWfpGHock4qVOnaysAeTjKmcXkrHCD3N2fn+GG1DP8Fj92aNQxNAL1VFFbFlK/TAU2LtmqUleTbhqAURZiRLrf6QwRw6nUiMTVM9ioZkPjU3Ci0nBUS9fcwdfH4wjnsPfPw6Q4oiXMlGqVi9tlvjg4qQmdQqxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783597376; c=relaxed/simple;
	bh=u/6wZyWrjekW0OpzmFoUO7mvD5KHKVYC6QfdEV6pANk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mFhUs4VEgNXcy0EVuBVxg9fF5X5Y/Qc++h4GbV6p57jqkIeL3u4ihlf/jkAwYgy8g/rRH9oaCurTuV/+9sbTKZjdNiL1WiZMAOCxkdLoDREuzD+iNp5CBg7RygnVaygatr7l6N1Abp5jBBaOCVHk76hVWqWJ2IQy0hSsbYqS9Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZEqDOnLO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CPH+cuzN; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669BNMu11488878
	for <linux-wireless@vger.kernel.org>; Thu, 9 Jul 2026 11:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jFZZnsSKIXc
	OaSgJCGaiYfkE7gIVteZGdWc6yJg7JYk=; b=ZEqDOnLOVsW0qR+97JLRxlzASMx
	YcJBU0DERZMoVUZYtxB64+BYvVtLKloJuRLaz5dncRU7FGDM/mv5DyolCjkKw2zs
	gtFZZAgVWU57yB+JoR1L5J0wr5myQqDOYZXvIgL3VEbtORDmhz7Lp3o+1IVPNk/e
	4j98geB2xYFImu0LAR32DtxQ9kB+XqAmfujAfhMVha2G48kM+QcaTUcJ2ocFHq0z
	q7U4BNqYLB56BJo4qG9+NgrQj7Ip4kClRBVYzonNTtQMW+1CyyZ0V1D4HGQ86f5Z
	ltMKee0wkF0rMZlU12aoOgJcVCIU7L36i3hg6+UG+2jC/TKCW3HPg0QH2fg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9wwftycp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 11:42:53 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c89704da8c7so1849094a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 04:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783597373; x=1784202173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jFZZnsSKIXcOaSgJCGaiYfkE7gIVteZGdWc6yJg7JYk=;
        b=CPH+cuzN9C2HP1FeQyPs1AgNH+vv0gwQHSh+orlXOux03i8nxcHMKEWZ4w+CevftIW
         bVIBiLTS65wwPOONm3anauvswVJTQuhWPtxA5GOlA+na8KX491BddHNP2kEcPShQfQZO
         u//jJWxSgLilCFc+tjuWgd7QeK/7LtfUKe8rmyq6899xXLbt6uj4tERGeSjPQpn/kZs8
         tPb0DPFlwDsAAW/nKOUqs6yWCsHC2CZSTGVkXwoJHzUl3oTM56oLSb2nl02C8bFKQjZD
         hr4lmpCqgWJjABdAJn38WR8GW/Ij2GLd5wTEMSzRdrUeLzUpVJMc5MeUx9f6eOKvMCfr
         xGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783597373; x=1784202173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jFZZnsSKIXcOaSgJCGaiYfkE7gIVteZGdWc6yJg7JYk=;
        b=iVQSEU9lKPWHyNl438TZg0kWxn5Uf9kB2jHtX8PqpARCu0GJsHbJD1INUXZOv6HwEt
         nvamaKkrHu98hMIDR5ry2kK7TiNF6gEHoqpKxsQ0yeni2pr0MJVhzoeiYHTMbJGmlOkm
         PLLmd/hitrKM4uCXkGQILJ8LDDQCdP9awrAu+iHwEYKt1VHGmHCDlOSxnxcA8zU252bx
         pyX2WD9RkXv+RyBZW6nysHRSwMEPZB6T0V3y9pNBg+2veZSsBTZELxArVTGXuL5Govn4
         9kR4Ao8Q+qH9Rr3x4yZOeIFahWfc4Mq/DPqW0SfY2iLqekdPPZNz0eUCQ91u4B3Qm2aL
         l+PQ==
X-Gm-Message-State: AOJu0YyI5ORQZ42gvxRXN13kyR3Q/9FipsX+MuasHefU8O4OVzNTa5y6
	tVHAcq7zxZMXEoV4riGNd7JoaJBwVbGnCvqkfHS78MbvTdUMeBlgWoGS+tO0OA6UKs8J8jm6nYB
	UnVy7GJw6vrbtxU78R9ujTIT580MyOiBXJoSre0FNmhX1+SVieUKj2204Nxx2cqfSY8i0WeDIJP
	l92Q==
X-Gm-Gg: AfdE7cl8+LWcDiw+RhFtAfBaDrJNXtaP0Hh5JzqTLBmO0aU6GVcKgbzILyqOBk1QzDD
	hlBhTiiEkIN+iBtaHsjCDUmGRaHAgszyfPGBkrD0FhKIDLmoY4Rb+AaPdvjvT2WFEj7/vAP95Xv
	8CqOAJNEk5Bi79eKwVN3dx2XP0EjbXUYS300fHFn2gorZauU7stRlMqVE3fczu1UterJK0jbfK1
	05j0aZA4EItf2SA1i7vJTzTfS8Wap977Wyte+LxFmxSXQj1vX+N/zRPbSEH6xIe6D0fbjrHWvkF
	yhYZhOW95Mjmz+q84OPvw/B4lGDdaxu+CfxJPEcMfCBg4HZZj12LhklxsAqLKqbMTY3oNSn8IoR
	x9YrYVZ0wDIkYlPL8mYKYK4tn7eoo6wsGIgc=
X-Received: by 2002:a05:6a21:9148:b0:3b3:f46:1eea with SMTP id adf61e73a8af0-3c0bcbe9c3fmr7935331637.7.1783597372834;
        Thu, 09 Jul 2026 04:42:52 -0700 (PDT)
X-Received: by 2002:a05:6a21:9148:b0:3b3:f46:1eea with SMTP id adf61e73a8af0-3c0bcbe9c3fmr7935298637.7.1783597372203;
        Thu, 09 Jul 2026 04:42:52 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6594f9a0sm31772753c88.4.2026.07.09.04.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 04:42:51 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, veerendranath.jakkam@oss.qualcomm.com
Subject: [PATCH wireless-next v6 3/4] wifi: mac80211: implement STA-mode peer probing
Date: Thu,  9 Jul 2026 17:12:27 +0530
Message-Id: <20260709114228.672317-2-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709114228.672317-1-pritiwa@qti.qualcomm.com>
References: <20260709114228.672317-1-pritiwa@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDExMyBTYWx0ZWRfX5Gl0/hnE4FzG
 gmRpdwgm0bM6jdnqzH+EKCZEnRoo35YEtdOyGOS5TYRz/K27x+7+4fF1jav/8XaP+BWN3IAQokf
 DG3vjz3uoaaDyRIPCmIznjmjE91xwCJhMWkjw56aPvyAtzQIpwyUnjBsmdx/lvR1qmGXozL9wfg
 f2aIuMg5YntvjpSg1dl1vaJfI3ci2njnd1XjyLSjv1ZmrTfqe87RMgxVCsCanpDRMWyjzXFVFVD
 Fsmn3C5g0Wu+5gq6h1WVKAsCRbLcgnFYoDIoLX6XsC/80KeQOOsivbdSnlR9RNj9YRkvG95tjAX
 51nP9XrnF8d9Kk9gLx8SXWk0XqU8da3pFM5GWSe877qTaD2O/ukga8LUK1bPfFx1Y/gu4lVNE6u
 HvlsRj41zwt4xQ6J8nT+qvBNt8z0DPlPgyJZbyHa3Dtk87Ns1Ohzko9hdsAq2kqck8fAwSdr1Kf
 xtfZqSWC+c2qZudcuLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDExMyBTYWx0ZWRfXzAh717olnACq
 wlnuX5FE8zq9iBQncuBdHwmsV2YDJisybY6pbcCwoCn+qKkVPWmLG0EhTuaLto5hSlvBTqDgloQ
 yCQRjEwVOWNt9o2YwsWFRZREurO9yTU=
X-Proofpoint-ORIG-GUID: bawcX9rQUEYjjIIO8i0fPM5DF_M6bKCa
X-Proofpoint-GUID: bawcX9rQUEYjjIIO8i0fPM5DF_M6bKCa
X-Authority-Analysis: v=2.4 cv=Krh9H2WN c=1 sm=1 tr=0 ts=6a4f893d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=j5NnyRWwbgm38xLfpi0A:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090113
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-38820-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:veerendranath.jakkam@oss.qualcomm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qti.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: 2575473093F

From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>

Add STA/P2P-client support to ieee80211_probe_peer(): when called
for a station interface, send a null-data frame (TODS) to the
associated AP and report the ACK via cfg80211_probe_status().

For MLO connections the driver/firmware selects the link
(IEEE80211_LINK_UNSPECIFIED); for non-MLO the single link is used.

Signed-off-by: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
---
 include/net/mac80211.h |   7 ++-
 net/mac80211/cfg.c     | 117 ++++++++++++++++++++---------------------
 net/mac80211/status.c  |   5 +-
 3 files changed, 67 insertions(+), 62 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 4f95da023746..78beb6e3bdd4 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1342,6 +1342,11 @@ ieee80211_rate_get_vht_nss(const struct ieee80211_tx_rate *rate)
  * @status.tx_time: airtime consumed for transmission; note this is only
  *	used for WMM AC, not for airtime fairness
  * @status.flags: status flags, see &enum mac80211_tx_status_flags
+ * @status.link_valid: if the link which is identified by @status.link_id is
+ *	valid. This flag is set by the driver in the TX status callback when the
+ *	connection is MLO and the driver knows which link was used for TX.
+ * @status.link_id: id of the link used to transmit the packet. This is used
+ *	along with @status.link_valid.
  * @status.status_driver_data: driver use area
  * @ack: union part for pure ACK data
  * @ack.cookie: cookie for the ACK
@@ -1396,7 +1401,7 @@ struct ieee80211_tx_info {
 			u8 pad;
 			u16 tx_time;
 			u8 flags;
-			u8 pad2;
+			u8 link_valid:1, link_id:4;
 			void *status_driver_data[16 / sizeof(void *)];
 		} status;
 		struct {
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 9c311c8290f7..df68a5bdeb2f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4956,99 +4956,100 @@ static int ieee80211_probe_peer(struct wiphy *wiphy, struct net_device *dev,
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
+	const u8 *dst_addr;
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
+	switch (ieee80211_vif_type_p2p(&sdata->vif)) {
+	case NL80211_IFTYPE_AP:
+		fromds = true;
+		break;
+	case NL80211_IFTYPE_STATION:
+		/* For STA, the peer is always the associated AP/GO */
+		peer = sdata->vif.cfg.ap_addr;
+		fromds = false;
+		break;
+	default:
+		return -EOPNOTSUPP;
 	}
 
+	sta = sta_info_get_bss(sdata, peer);
+	if (!sta)
+		return -ENOLINK;
+
 	qos = sta->sta.wme;
+	dst_addr = sta->sta.addr;
 
 	if (ieee80211_vif_is_mld(&sdata->vif)) {
-		if (sta->sta.mlo) {
-			link_id = IEEE80211_LINK_UNSPECIFIED;
-		} else {
+		if (fromds && !sta->sta.mlo) {
 			/*
-			 * For non-MLO clients connected to an AP MLD, band
-			 * information is not used; instead, sta->deflink is
-			 * used to send packets.
+			 * AP mode, non-MLO client on AP MLD: use the
+			 * per-link address for the client's link.
 			 */
 			link_id = sta->deflink.link_id;
-
-			conf = rcu_dereference(sdata->vif.link_conf[link_id]);
-
-			if (unlikely(!conf)) {
-				ret = -ENOLINK;
-				goto unlock;
-			}
+			conf = wiphy_dereference(local->hw.wiphy,
+						 sdata->vif.link_conf[link_id]);
+			if (!conf)
+				return -ENOLINK;
+			src_addr = conf->addr;
+		} else {
+			/*
+			 * MLO client (AP or STA mode), or STA mode:
+			 * always use LINK_UNSPECIFIED and MLD address.
+			 */
+			link_id = IEEE80211_LINK_UNSPECIFIED;
+			src_addr = sdata->vif.addr;
 		}
 		/* MLD transmissions must not rely on the band */
 		band = 0;
 	} else {
-		chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
-		if (WARN_ON(!chanctx_conf)) {
-			ret = -EINVAL;
-			goto unlock;
-		}
+		chanctx_conf = wiphy_dereference(local->hw.wiphy,
+						 sdata->vif.bss_conf.chanctx_conf);
+		if (WARN_ON(!chanctx_conf))
+			return -EINVAL;
 		band = chanctx_conf->def.chan->band;
 		link_id = 0;
+		src_addr = sdata->vif.addr;
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
 
-	nullfunc = skb_put(skb, size);
+	nullfunc = skb_put_zero(skb, size);
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
+	memcpy(nullfunc->addr1, dst_addr, ETH_ALEN);
+	memcpy(nullfunc->addr2, src_addr, ETH_ALEN);
+	memcpy(nullfunc->addr3, fromds ? src_addr : dst_addr, ETH_ALEN);
 
+	info = IEEE80211_SKB_CB(skb);
 	info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS |
 		       IEEE80211_TX_INTFL_NL80211_FRAME_TX;
 	info->band = band;
-
 	info->control.flags |= u32_encode_bits(link_id,
 					       IEEE80211_TX_CTRL_MLO_LINK);
 	skb_set_queue_mapping(skb, IEEE80211_AC_VO);
@@ -5059,18 +5060,14 @@ static int ieee80211_probe_peer(struct wiphy *wiphy, struct net_device *dev,
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
index c3d29aed93fe..d635490f59d3 100644
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


