Return-Path: <linux-wireless+bounces-37656-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V4L2LfpUKmoQngMAu9opvQ
	(envelope-from <linux-wireless+bounces-37656-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 08:26:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1481166F025
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 08:26:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=FCerpZL7;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Y6uHfJui;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37656-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37656-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5279B3208002
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 06:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A4D353EF7;
	Thu, 11 Jun 2026 06:22:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65602D73A6
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 06:22:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158976; cv=none; b=lHOiIg9Qxe6A3z6LPy2lhrYb2N42nJZUSyI6kTr09Cr6RmZNI/n9MArgP/irmvMyfEtNc44ICVfeWk9LyHdB8UMAwstoGbXWBxWl1q2FVMKAZpTXwmSOUeyp9r2T0kulqygr1760tD4EwryyUEU+ZGplC65K2sYL8qtW5PFf2Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158976; c=relaxed/simple;
	bh=C75Pi9xriJXtObJe+zDtIDlGPx+Ufgj7AQAb/ZTivBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DDwIgi2XxwWHTTy10x+WPbohm0a8eYdtdWiqhw85dQGYqid0r31b/8ogbL9qnXCQEV2aub5uFVuddh5WSYo6aNyGJsZVNK8tO/d4oeou5QixeoczS0PprQ77CgDuWEZt89odRNuJKFLpB8mOsAmq5X6o6jM+0UFGUg5yCgcnEJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FCerpZL7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y6uHfJui; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B5GkJt3846601
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 06:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1neOKXXnmUu
	fbO/cqn1bekBQGfLRv5IXlId0XD0ACJU=; b=FCerpZL7lD3ginkY1bQHdB+dluk
	aZFpWNDax3qGmnDWv5qFWatOL7dnJtNgnCWkQPG5aA04dZfK7QIP/oLnMqWAT4cf
	32DzGKpJixqBHi1TAthHGtuhbtJyv+UTdg+wyv5LM6ygAYqEeE7q10mml4F69OVc
	paKwVS7RFTqLWjaQBcuHX2zD+Vvcw7wJ3aSu6zZb4sfhbtPb57rUWR9GCHhKkNnw
	3WIDuWq3MGnz9+3hoUHi7clG+h7CwXqBwI9ibUhk5Z3xON8DztomjN/8gSwVB809
	jIjcQ0kpmEjwwXCm4k9wQk1ip3qi0O568MGXgZyi75g1gDHLbJd21PnoYyg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6u1xns-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 06:22:53 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36d98b54cf2so5515246a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 23:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781158972; x=1781763772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1neOKXXnmUufbO/cqn1bekBQGfLRv5IXlId0XD0ACJU=;
        b=Y6uHfJuiizecSAjVtnXtEv8TB1Da6ZgSfCvr8FTlZlgRYMJSoGS/JD2HuRmA1lG+nz
         7tSDtMlmpBWPV9d7MSlFVbiOqo8wQQCTIlk1SqgEdFQ6MtSF1Q+rGQC9DP0sE7WqOokN
         wk8doU7emg8kOm+yGimtGA888vMFUaKpri67lZ+u+0bmkofxzivGDnwtNrkFDtRaJZsH
         VM78K33g37A7AL+AFsuII0K/jGCvs1ZtwhJnVdXzhvDYN9jMxm89D4X15HXShJp+RRGb
         b2wq4ZnoyhyWvByD2ry8b1qbdQoSumpAOrS8BoOFvswfmIrILOl1lg8qp/LA/lxmqr5E
         628g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781158972; x=1781763772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1neOKXXnmUufbO/cqn1bekBQGfLRv5IXlId0XD0ACJU=;
        b=Xc7WfuITL5RAXMmOBy9NxSZ52q0THAszJ82dNSQU5Qmw1UwdBk4ViC2zw+a/FZvrFc
         oSyo1i7Q+BMLHUEr4qvIGh0AIdh07BYf/rDieOCGdXQx1n2w4hLjJeLmGzvG2Uwu/xlK
         GBRGORbwSqV+2XM4pz51EXrcCz4FjC5O3HS0xRPSJ9m9tyhWlkINKEPObmWd1lEseVxk
         DAMMtLQ9ge8pvIz2WEz05L3IPe2fTI6/AM2g8u6S8hktEcCc9Vpr8VXhc93roUoZ4Zhi
         QSwjwSfZyfTKFVPQTQKH/fBdMJ3ZiWkeU9IeF+EKuTrmmFqjDKSWCeUrLUHl6AkMkvip
         tVcA==
X-Forwarded-Encrypted: i=1; AFNElJ9pS+P1nrpyAwmENbFKHrVIQENfyrLgci68NMcmfW2AJbaN4KJox0Z5adVERqdIg1ElFF/dmCMoD14iSHGKAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYv64jL1HWIqsI3N9bnUgVw/rnno6vkoNMFTDYo6dQtcVXOZ32
	ozqupK53u+l6RTzmHZX/GxWrzG573B4iedeyIZ7zIPPxVs+WzaCsjPxoM2/aDzwt51+qrBCEj/N
	C4L2tG+F/H3gacxEmHqXEQnNiaHb33RorrYVGMCLqoOQUZsu2jkoiFRQhi91rtNnTemiJDw==
X-Gm-Gg: Acq92OESQa7doULtd8mqTwXzqjdKo9klA3qncDB5F1rWEyJBB85NaYth3OqlLOzAJT+
	T15m6lTUsLDnESRNg43pEHZKK40ylpEKxWfwV2vpMMQjmKr8fI4wbYHjAArp+GWwU+cxUUyzbr3
	L3g2+AgOfnxs+xFX3ExviljwJmuXyr2Gk60QI7qTzejc5Ev5oTOQiYhSTft+zuswqW4nnRZ8lce
	h1UrjkqwgXnHuYDQZQth9B9oxXkg8w85Y8u9XxLPG4ehsksMPKPbtT3s01cCu9f8ZWd53viQtgA
	oaiDtDo4UsQcvEonHPdAjOBO7K109lfxV2iILHk7IqPWNQ+J4faqi9ic1ThNr0V0e6QjpC9bw+Q
	9D5hTxmrBh/fYdbep/8l6Ze4cMWXiMoseXvls2iCv8Z3vS1wntLs5+5Km
X-Received: by 2002:a17:90b:2d92:b0:36d:8f51:fe29 with SMTP id 98e67ed59e1d1-377a5ce84camr1824219a91.17.1781158972347;
        Wed, 10 Jun 2026 23:22:52 -0700 (PDT)
X-Received: by 2002:a17:90b:2d92:b0:36d:8f51:fe29 with SMTP id 98e67ed59e1d1-377a5ce84camr1824195a91.17.1781158971866;
        Wed, 10 Jun 2026 23:22:51 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37752874fc3sm1247507a91.5.2026.06.10.23.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:22:51 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: veerendranath.jakkam@oss.qualcomm.com, linux-wireless@vger.kernel.org,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v5 3/4] wifi: mac80211: implement STA-mode peer probing
Date: Thu, 11 Jun 2026 11:52:24 +0530
Message-Id: <20260611062225.2144241-4-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611062225.2144241-1-pritiwa@qti.qualcomm.com>
References: <20260611062225.2144241-1-pritiwa@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PZPPQChd c=1 sm=1 tr=0 ts=6a2a543d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=2b0JHf5xd9TfDdKuZDcA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: TepFNZGVELU1LifgLM5bz-d2e255XhfH
X-Proofpoint-GUID: TepFNZGVELU1LifgLM5bz-d2e255XhfH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA2MCBTYWx0ZWRfX2E16fJxNYDKT
 aBOv303paxjLQnKCI1zj+vQvmqYuA4pfd9IhLS6cNHXqsKiPr7Ww79u/4T4z2z7V8eG8slOTItj
 Yh/z/atMKYhxIXMBWLgOBzyS7oT0vidXF2d4H0qt7KvXo/vHh7staM1eGh0W+YOlWQ/yu81CL2x
 oGSgCqY4BdDKF9sK3j+d/wJT5j1J/vCfpcBP2SnJpnTJ3D0DkO4cn5u4Z4hVxCk8xsckE1oyCD8
 d37WMCNrYuW11EmzKTwe36/aBOxufT3hnsJiT3zS/a8IZvXBDZRKc2BqgyHb9FPLnbcRdBeV85b
 PvJubirQ1qIgBqQO5xnaaR1kZOpHWTMqRE9djFVL7eWP1LNyP82RPMekN0AJcqiCeti7AvFMh9r
 PWG9FxqeD2QqDT7BKoCD0wPGSS+NJYSIsH/tDlJut04XecbS9Qyshrf9AxkfWVzFhppua73f4os
 Qc/WFEbf9V9BiQ5FdJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA2MCBTYWx0ZWRfX+/BsKmZ+JTyA
 Y4/M4cB4RzFczaUrWcOFzGx+B7988vIYGurGzS2rQ359sYQ2WHQIHOx6O6HF/O+w2zXvgfCUtf8
 3hd9rFN818mQd+jAQXSCbgk7H1wGq0g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110060
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37656-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:veerendranath.jakkam@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:quic_drohan@quicinc.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
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
X-Rspamd-Queue-Id: 1481166F025

From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>

Add STA/P2P-client support to ieee80211_probe_peer(): when called
for a station interface, send a null-data frame (TODS) to the
associated AP and report the ACK via cfg80211_probe_status().

For MLO connections the driver/firmware selects the link
(IEEE80211_LINK_UNSPECIFIED); for non-MLO the single link is used.

Signed-off-by: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
---
 include/net/mac80211.h |   2 +-
 net/mac80211/cfg.c     | 111 ++++++++++++++++++++---------------------
 net/mac80211/status.c  |   5 +-
 3 files changed, 60 insertions(+), 58 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 4f95da023746..7ce0b5163671 100644
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
index 9c311c8290f7..3dd60bfbf709 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4956,101 +4956,104 @@ static int ieee80211_probe_peer(struct wiphy *wiphy, struct net_device *dev,
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
 		if (sta->sta.mlo) {
 			link_id = IEEE80211_LINK_UNSPECIFIED;
+			src_addr = sdata->vif.addr;
 		} else {
 			/*
-			 * For non-MLO clients connected to an AP MLD, band
-			 * information is not used; instead, sta->deflink is
-			 * used to send packets.
+			 * For non-MLO clients connected to an AP MLD,
+			 * use the link address for the client's link.
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
+			if (unlikely(!conf))
+				return -ENOLINK;
+			src_addr = conf->addr;
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
+	if (link_id != IEEE80211_LINK_UNSPECIFIED) {
+		info->status.link_valid = 1;
+		info->status.link_id = link_id;
+	}
+
 	skb_set_queue_mapping(skb, IEEE80211_AC_VO);
 	skb->priority = 7;
 	if (qos)
@@ -5059,18 +5062,14 @@ static int ieee80211_probe_peer(struct wiphy *wiphy, struct net_device *dev,
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


