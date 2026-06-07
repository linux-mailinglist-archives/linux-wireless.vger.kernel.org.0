Return-Path: <linux-wireless+bounces-37468-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F/CzN8ixJWpbKgIAu9opvQ
	(envelope-from <linux-wireless+bounces-37468-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 07 Jun 2026 20:00:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 548AE651280
	for <lists+linux-wireless@lfdr.de>; Sun, 07 Jun 2026 20:00:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=RkkwtjgD;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=FNySkVLt;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37468-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37468-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 971E030120FF
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Jun 2026 18:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1FD3148D3;
	Sun,  7 Jun 2026 17:59:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44468318B9D
	for <linux-wireless@vger.kernel.org>; Sun,  7 Jun 2026 17:59:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780855199; cv=none; b=CRXT+WAeuXvrX66PPwBuf9wVjT0U0KMynvRESps0hPykACgagGuXRbV2q7rLOFNA/A6DJX8qRcb3XH/dHU1rOz+4nUH4pETHTrTOxaEjeuCcG95WgX2HZ6mFMXrrjr8PpVG6WJQsGdlvM5YGayuyzW/vJMSeeHkDpQQNb9bDvzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780855199; c=relaxed/simple;
	bh=NrR7qNQL6tVdZ1xdnkIuiOYzDVm3K6reDt9aKBW8d4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mr9Iwu7y42YFW+i5QbPyHJ7xWUvuaeZF3p+YKBP7+fCvXn6X0QIBsU39qTaU57jaqu0NZWzHSo6YIDqysSQ4HLm2PMrcRk0S3f2XMNx6w6/GPGpoOqY6K2+naXjNtnFoETOg4rK0EJlBZAD7Pp7Fgo972wu/4JCKn0fRAWZdCg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RkkwtjgD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FNySkVLt; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657EjnIf440155
	for <linux-wireless@vger.kernel.org>; Sun, 7 Jun 2026 17:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dk5utpCcHYq
	7q8GwcnreEiUanj8Y4L/sEzsjQLz9HHk=; b=RkkwtjgDF6TzatAa8JNhEbOFo+Q
	5qWmN1+IDvAZk8cLaKBtxs2evT2Nkfb1gIhfXIikQww213HJSO2upIPD06w2UBqY
	0/iIRKf7ZC4RTT4WlRwk0yV7aCVpG3NZrpqG8UwCrVUqYNT0SJa9xHZ+xjmGRDfp
	qzUgS6akqQK5rlCC3I/aolK7QdEjKPvJ15G3nJ+miuJyH8yh8y0a9U96jU62eDNA
	yoQhiZCtQ/wLyTfqMhSEs8TBURDbkSQndwqmbgsb9Cq/eNvwa33uDftyMX7h3Xqs
	XZyM2CtV5fEDMn1hDusiKqfrXgsGhX5E/wdWFJYTiD46Mtk2gHrbIuHq8AA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em98cvx6k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 07 Jun 2026 17:59:57 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c0c36f4b76so36261515ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 07 Jun 2026 10:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780855197; x=1781459997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dk5utpCcHYq7q8GwcnreEiUanj8Y4L/sEzsjQLz9HHk=;
        b=FNySkVLt0gsQPGJdUhlofM3wJbdg1RdJPk3VJ3RNZ8HCEPgbEtQN//N7CXRze7qVuJ
         BBbhbFvfXu9c323ZH7Ah9+lkkra9yQMMdCF/jB9I55yDmzQbzRw4+8J7wLJOvC2ICw48
         ASjLpHiwSheWMMVC2TPoRVVfHR7X9qbXkJOUyyMo6dQFIxZGOZcgEYrjdB7LJFtzkYyJ
         X7IuntS2gbBCKQy3NJ+cyEhZyVcDFTCDPbhwh782KY/ZfTUKmIxHPLox+Z6xruBVTICE
         VmvKI7tRdP0bZ9aKS0D3TXx2RYye9hxyZeYjQIS9aAQ04dnjdTdpsscOrXtpa2p8atRh
         Ekig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780855197; x=1781459997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dk5utpCcHYq7q8GwcnreEiUanj8Y4L/sEzsjQLz9HHk=;
        b=XE/xyJ4rtJkSF2jM/XCuBAx4/zF+3Kj4fZk1wgo0VU+DOXsg4WlXvIRwD/2RyFOjK6
         YdFe0KIroUVq87+4BgE203CN3uBywvCMe1h2lAZJe9E6cGNTaPvwQJVEUHCJbkCO3/H8
         l6trKv0EB5r1RnnJF2xY6kHYqC9kZobz/mawzhYUzXv713c+5/3JYe1tmP1Y3UpmlIMg
         W6RuBcK7AyNXb6bdsPIE2/FPgdHYvPfR12Hc21Oz24hrdVMWwvPrr5hyohsOigVEaOXO
         nLI1TdGxsYARpCr8O41r5fmkVHqERd9zofe9fUptZKkVzeINzyBKqdYvbimAm6d33tqu
         0gJA==
X-Gm-Message-State: AOJu0YwXi8Qxa/AQ99vuI2/fu8rviQTUpllffQyeoKgoGk7UCkCxalyE
	xlzCHcBQ93uRsMxUYlkoRNjGPr3gLUbMROem3AWgOH7Xgm8hV+661aGG9HC/71SaKY58qW99eIA
	AtbbDoCxL2FArWKIBZxPR4d/DOvS0QRh1Wo3hPOF5vVl+/IicpMRtybVWTPsnsQAtbtuafg==
X-Gm-Gg: Acq92OFVQr+ZF4m69KwoRyX1icVxFOE0s7T7msoMEvGX0cHLCDeDe3s40BQUz/Gw0at
	FhBja2NJdjJnvGzFubaRI//+iO3no2Zd4GDa6+cQuKy/HPsO9mu9+qNDgvBS47/6Jb+Fkkcu273
	GMu9EBIf4JTwpNouETswLFr8FoeS/P6ygWXKrZI98uO2JlDC6w62LBIUY0W0t5K+w/tjHl1mAdq
	BW+3jWpNJHKigwFIWH/SF5CKmbr57t7E+Yft190aIeXlnru2D+pevvrspn1I2JUR77LGYClYKgb
	EZPq/36ftvW5uquyHkZXIfLUgw+yfInqSVoyHp9tP0Qnh9vYVANsM+A2FCthDyO/qAtp1Epij3v
	lT+B8LNpKJZIJTTA4+K6SZ28OgzIPPbndzY+EuJm7r7OsPFb3nnKXOwQrSFyOgYpKAGJnhU5SiZ
	p1oyReV3HT+rnOU7VESoyrLgVKo3SaKdV4S+61sUNOysbKvuM/GQ==
X-Received: by 2002:a05:6a20:4328:b0:3b4:7c33:296c with SMTP id adf61e73a8af0-3b4cd0a5a5dmr14105524637.45.1780855196517;
        Sun, 07 Jun 2026 10:59:56 -0700 (PDT)
X-Received: by 2002:a05:6a20:4328:b0:3b4:7c33:296c with SMTP id adf61e73a8af0-3b4cd0a5a5dmr14105498637.45.1780855195975;
        Sun, 07 Jun 2026 10:59:55 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a624fsm13078522a12.18.2026.06.07.10.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 10:59:55 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        praneesh.p@oss.qualcomm.com
Subject: [PATCH wireless-next 3/5] wifi: cfg80211: Refactor nl80211_dump_station() to prepare for per-link stats
Date: Sun,  7 Jun 2026 23:29:10 +0530
Message-ID: <20260607175912.2266215-4-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607175912.2266215-1-praneesh.p@oss.qualcomm.com>
References: <20260607175912.2266215-1-praneesh.p@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDE4MCBTYWx0ZWRfX3gF1RndaaT+c
 ROF7eMfXQMhb9dO7ctyAI+F31a63CS1vDFyDVy2Mmp+sXUim8BprTb3u7Y7Wpdh08IQCs8Z7vRS
 VJ60DiJY2IhwePL7Zoc0C97PiwATv9lBCfegQW4PTO8+XjVw+DDb0+xtFut49xlZnHRg2rqJeWX
 fBiPpfqRnY5W1X5As99pIhvPJ13vbiTlWXf6k6P4+aIbSsSEBtVw9VZ0fFRpOTwsnedqNAVYYzj
 yJKz5T0+8W+MYICYrE0Ehj+nAVivAiBfW8f8KaeM4AkS4++vvXAAVgOjbkU+KrwV7nRQcJu/D89
 ukBVgkFAENwdAxUE66tIHGYQeSytLyRJTfGTqubGWXbiVWmn9Ip4j0epDdGhWosqY67lX7u1fpI
 n5Azvvwe53zm6uoaVAiTxGwU9aI7WWqYXTW0nIDs7Y+LmOwtkq1uFyMT6U2LNWAG8Qy1BfHEl4l
 7S/kQ4k8FJ/kqGw7k+A==
X-Proofpoint-ORIG-GUID: fWEn68o21ci6-7mgaqSwC-czRb0HEZVP
X-Proofpoint-GUID: fWEn68o21ci6-7mgaqSwC-czRb0HEZVP
X-Authority-Analysis: v=2.4 cv=A/pc+aWG c=1 sm=1 tr=0 ts=6a25b19d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=hwBch8dKHD1l83SQFqoA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606070180
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37468-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:praneesh.p@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[praneesh.p@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praneesh.p@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 548AE651280

Currently, nl80211_dump_station() relies on the netlink callback's generic
args array (cb->args[2]) to track the station index during dumps. It also
processes the entire sinfo structure and transmits it to userspace
immediately in a single pass.

This approach creates a bottleneck for MLO. When an MLD station has
multiple active links, the aggregated station information, combined
with the individual per-link statistics, can easily exceed the
maximum netlink message size limits. The current monolithic dump
iteration cannot pause and resume mid-station to fragment these large
per-link statistics across multiple netlink messages.

Introduce a stateful context structure (struct nl80211_dump_station_ctx)
allocated during the dump to track the iteration state. Move the station
index (sta_idx) tracking into this context, and introduce a phase
variable to represent the current fragmentation state (starting with
Phase 0 for the base aggregated MAC-level statistics).

Utilize the existing nl80211_prepare_wdev_dump() to safely parse the wdev
attributes on every dump iteration, ensuring proper RTNL and wiphy locking
without caching dangling device pointers. Furthermore, move the
NL80211_CMD_GET_STATION command definition from genl_small_ops to
genl_ops to natively support the .done callback. Implement
nl80211_dump_station_done() to ensure the newly allocated state context
and its deeply allocated sinfo payload are safely freed when the dump
concludes or is aborted prematurely by userspace.

Note that the previous dump path used nl80211_send_station(), which
included NL80211_ATTR_IE and NL80211_ATTR_RESP_IE. These attributes are
not carried forward in this implementation. As documented, association
response IEs (assoc_resp_ies) are only relevant at station creation time
(e.g. via cfg80211_new_sta()) to notify userspace about association
details, and are not expected to be part of get_station()/dump_station()
callbacks. Aligning with this expectation, these IEs are intentionally
omitted here.

This refactoring maintains the existing netlink batching performance while
laying the stateful foundation required for per-link statistics
fragmentation in subsequent patches.

Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
 net/wireless/nl80211.c | 201 +++++++++++++++++++++++++++++++----------
 1 file changed, 153 insertions(+), 48 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 88232c323d9c..d146d6af6e48 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -39,6 +39,39 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
 
 /* the netlink family */
 static struct genl_family nl80211_fam;
+/**
+ * enum nl80211_dump_station_phase - station dump fragmentation phases
+ * @NL80211_DUMP_STA_PHASE_AGGREGATED: send aggregated (MLO-combined) station
+ *	statistics for the station entry
+ * @NL80211_DUMP_STA_PHASE_PER_LINK: send per-link statistics for each active
+ *	MLO link of the station; only used when dump_link_stats is set
+ */
+enum nl80211_dump_station_phase {
+	NL80211_DUMP_STA_PHASE_AGGREGATED = 0,
+	NL80211_DUMP_STA_PHASE_PER_LINK   = 1,
+};
+
+struct nl80211_dump_station_ctx {
+	int sta_idx;
+	enum nl80211_dump_station_phase phase;
+	u8 mac_addr[ETH_ALEN];
+	struct station_info sinfo;
+};
+
+/**
+ * struct nl80211_dump_station_cb - state stored in netlink_callback::ctx
+ * @wiphy_idx: args[0] - wiphy index from nl80211_prepare_wdev_dump
+ * @wdev_id: args[1] - wdev identifier from nl80211_prepare_wdev_dump
+ * @ctx: args[2] - dump station context pointer
+ *
+ * args[0] and args[1] are reserved by nl80211_prepare_wdev_dump().
+ * The ctx pointer must live at args[2] to avoid corrupting those fields.
+ */
+struct nl80211_dump_station_cb {
+	long wiphy_idx;
+	long wdev_id;
+	struct nl80211_dump_station_ctx *ctx;
+};
 
 /* multicast groups */
 enum nl80211_multicast_groups {
@@ -8279,23 +8312,72 @@ static void cfg80211_sta_set_mld_sinfo(struct station_info *sinfo)
 	sinfo->filled &= ~BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG);
 }
 
+static int
+nl80211_send_accumulated_station(struct sk_buff *msg,
+				 struct netlink_callback *cb,
+				 struct cfg80211_registered_device *rdev,
+				 struct wireless_dev *wdev,
+				 const u8 *mac_addr,
+				 struct station_info *sinfo)
+{
+	void *hdr;
+
+	hdr = nl80211hdr_put(msg, NETLINK_CB(cb->skb).portid,
+			     cb->nlh->nlmsg_seq, NLM_F_MULTI,
+			     NL80211_CMD_NEW_STATION);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if ((wdev->netdev &&
+	     nla_put_u32(msg, NL80211_ATTR_IFINDEX, wdev->netdev->ifindex)) ||
+	    nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(wdev),
+			      NL80211_ATTR_PAD) ||
+	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, mac_addr) ||
+	    nla_put_u32(msg, NL80211_ATTR_GENERATION, sinfo->generation))
+		goto nla_put_failure;
+
+	if (nl80211_put_sta_info_common(msg, rdev, sinfo))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+	return 0;
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
+}
+
 static int nl80211_dump_station(struct sk_buff *skb,
 				struct netlink_callback *cb)
 {
-	struct station_info sinfo;
 	struct cfg80211_registered_device *rdev;
 	struct wireless_dev *wdev;
-	u8 mac_addr[ETH_ALEN];
-	int sta_idx = cb->args[2];
-	bool sinfo_alloc = false;
-	int err, i;
+	struct nl80211_dump_station_cb *cb_data = (void *)cb->ctx;
+	struct nl80211_dump_station_ctx *ctx = cb_data->ctx;
+	int err, ret;
+
+	NL_ASSERT_CTX_FITS(struct nl80211_dump_station_cb);
 
 	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev, NULL);
 	if (err)
 		return err;
+
 	/* nl80211_prepare_wdev_dump acquired it in the successful case */
 	__acquire(&rdev->wiphy.mtx);
 
+	/* First invocation: allocate ctx */
+	if (!ctx) {
+		ctx = kzalloc_obj(*ctx);
+		if (!ctx) {
+			err = -ENOMEM;
+			goto out_err;
+		}
+
+		ctx->phase = NL80211_DUMP_STA_PHASE_AGGREGATED;
+		ctx->sta_idx = 0;
+		cb_data->ctx = ctx;
+	}
+
 	if (!wdev->netdev && wdev->iftype != NL80211_IFTYPE_NAN) {
 		err = -EINVAL;
 		goto out_err;
@@ -8306,55 +8388,77 @@ static int nl80211_dump_station(struct sk_buff *skb,
 		goto out_err;
 	}
 
-	while (1) {
-		memset(&sinfo, 0, sizeof(sinfo));
-
-		for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
-			sinfo.links[i] =
-				kzalloc_obj(*sinfo.links[0]);
-			if (!sinfo.links[i]) {
-				err = -ENOMEM;
-				goto out_err;
+	/* Phase 0: dump aggregated station info */
+	if (ctx->phase == NL80211_DUMP_STA_PHASE_AGGREGATED) {
+		while (true) {
+			memset(&ctx->sinfo, 0, sizeof(ctx->sinfo));
+			for (int i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
+				ctx->sinfo.links[i] =
+					kzalloc_obj(*ctx->sinfo.links[0]);
+				if (!ctx->sinfo.links[i]) {
+					err = -ENOMEM;
+					goto out_err_release;
+				}
 			}
-			sinfo_alloc = true;
-		}
-
-		err = rdev_dump_station(rdev, wdev, sta_idx,
-					mac_addr, &sinfo);
-		if (err == -ENOENT)
-			break;
-		if (err)
-			goto out_err;
 
-		if (sinfo.valid_links)
-			cfg80211_sta_set_mld_sinfo(&sinfo);
+			err = rdev_dump_station(rdev, wdev, ctx->sta_idx,
+						ctx->mac_addr, &ctx->sinfo);
+			if (err == -ENOENT) {
+				err = skb->len;
+				goto out_err_release;
+			}
 
-		/* reset the sinfo_alloc flag as nl80211_send_station()
-		 * always releases sinfo
-		 */
-		sinfo_alloc = false;
+			if (err)
+				goto out_err_release;
+
+			if (ctx->sinfo.valid_links)
+				cfg80211_sta_set_mld_sinfo(&ctx->sinfo);
+
+			ret = nl80211_send_accumulated_station(skb, cb, rdev,
+							       wdev,
+							       ctx->mac_addr,
+							       &ctx->sinfo);
+			if (ret == -EMSGSIZE) {
+				err = skb->len;
+				goto out_err_release;
+			}
 
-		if (nl80211_send_station(skb, NL80211_CMD_NEW_STATION,
-				NETLINK_CB(cb->skb).portid,
-				cb->nlh->nlmsg_seq, NLM_F_MULTI,
-				rdev, wdev, mac_addr,
-				&sinfo) < 0)
-			goto out;
+			if (ret < 0) {
+				err = ret;
+				goto out_err_release;
+			}
 
-		sta_idx++;
+			/* Reset ctx for next station */
+			cfg80211_sinfo_release_content(&ctx->sinfo);
+			ctx->sta_idx++;
+		}
 	}
 
- out:
-	cb->args[2] = sta_idx;
+	ctx->phase = NL80211_DUMP_STA_PHASE_AGGREGATED;
 	err = skb->len;
- out_err:
-	if (sinfo_alloc)
-		cfg80211_sinfo_release_content(&sinfo);
+	goto out_err;
+
+out_err_release:
+	cfg80211_sinfo_release_content(&ctx->sinfo);
+	memset(&ctx->sinfo, 0, sizeof(ctx->sinfo));
+out_err:
 	wiphy_unlock(&rdev->wiphy);
 
 	return err;
 }
 
+static int nl80211_dump_station_done(struct netlink_callback *cb)
+{
+	struct nl80211_dump_station_cb *cb_data = (void *)cb->ctx;
+	struct nl80211_dump_station_ctx *ctx = cb_data->ctx;
+
+	if (ctx) {
+		cfg80211_sinfo_release_content(&ctx->sinfo);
+		kfree(ctx);
+	}
+	return 0;
+}
+
 static int nl80211_get_station(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -19319,6 +19423,14 @@ static const struct genl_ops nl80211_ops[] = {
 		/* can be retrieved by unprivileged users */
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WIPHY),
 	},
+	{
+		.cmd = NL80211_CMD_GET_STATION,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = nl80211_get_station,
+		.dumpit = nl80211_dump_station,
+		.done = nl80211_dump_station_done,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV),
+	},
 };
 
 static const struct genl_small_ops nl80211_small_ops[] = {
@@ -19418,13 +19530,6 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
 					 NL80211_FLAG_MLO_VALID_LINK_ID),
 	},
-	{
-		.cmd = NL80211_CMD_GET_STATION,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = nl80211_get_station,
-		.dumpit = nl80211_dump_station,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV),
-	},
 	{
 		.cmd = NL80211_CMD_SET_STATION,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-- 
2.43.0


