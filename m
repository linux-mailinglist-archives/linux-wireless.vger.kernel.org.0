Return-Path: <linux-wireless+bounces-37782-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cPAfD7Y5LmqlqwQAu9opvQ
	(envelope-from <linux-wireless+bounces-37782-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 07:18:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF93D68062E
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 07:18:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=VtKXGxfy;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=EKape2k8;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37782-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37782-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE73D3017C00
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 05:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00C918BC3B;
	Sun, 14 Jun 2026 05:18:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D155171BB
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 05:18:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781414312; cv=none; b=sDBAsUFFbfjLsAY4enO8/tPeJtCJmDDEiL9hNCb+y9/oy+QGE0IcpPVkuK8PfBrXV3u5MDUX4mmRaXAeuzbixmQiC8PU8VpfRp0M2GZ/RBwrYZeAQU9y18fKOw9LqYK9gogWcZMQCSthH7bRl9BOQ72N4KCWXtfSDD2x+E9Uico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781414312; c=relaxed/simple;
	bh=d6EzuNIrrdz9iParmzyumwtwbabJ+NpQ2Gc8EmvSXys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzZT89lY5x7MurTOvZcUw0lg8gXfDnwq70/tKCUB87sDu1Wq/BHxszoKVp3Rqe1XDaaK9QlpZhhm5thhsrSopD8Ab38edTXezGTyfTAlKi2OWNeH3DwQ6hm2nImzyW7jNW4NpaSLuohqAyBVQRoJN/vzzdly6+UTakMAiIOYiLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VtKXGxfy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EKape2k8; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65E49fnG624199
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 05:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kPExHvGqdSa
	YvMfJOkGIJdqnJt4PaGoq4FO7HYaZ2Rg=; b=VtKXGxfy+gliYcLId919ByvIzA1
	dBTdQ4lkG0YvUe6VwVxbi9I6bjY78MKiSKw2BXUtNqJ5kwYHqC8/veDwKO2su/XA
	PjJzYRpn3lCP2T/av8gsddREZMtNhbzcbRcq8BB6y0gweRAE7hY3rTosXt3moNxT
	pOhX/IL9zo1r1BHscaAY3nG7tpssxyZ6mgumzIihJyjaGy7elU9H5343+G2ky3r5
	27SI/zULsb1vzoOk5qCRPq2ZWQNVfxIMlP1wdi/w00EcKYCQsIfGxY/OqKXcwxtp
	nILyTsD/sJM9OoWk5M0cdMnmRGsniSeccNRvY8JKiWODbccrHO7W9w7VUWw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery7gttm8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 05:18:29 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c8581f7723aso965879a12.0
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 22:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781414309; x=1782019109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPExHvGqdSaYvMfJOkGIJdqnJt4PaGoq4FO7HYaZ2Rg=;
        b=EKape2k8FqgnpGdL92zsUAC3KFwwjkGRHBhVkCYeA2CLvn5mf3s7hpNscvNDntLFn6
         l2DjmHCsbauVaoVwaROIURr7uYn5dnTDyzT6i+2FrGWdXsRLOY2QXk2T3zKwamkNSlqZ
         QojSwqThFG9ajsp5jihF5Axiy86cUnNXlrjstWNkb/U7+lISssZIadsflD2G39qk4qNY
         KPSzD++G1nW/9h7LedzK3FXT7yncE/07EOmp2MWVuH/N4c4sdRU+aLU4AG16cbAEp9Pc
         KLukO4znEPynX2MRoQUbjejXys/0T5ZDI+MDyAFlTtDhibdFkJLEohbvDE6bAWJPKExt
         UpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781414309; x=1782019109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kPExHvGqdSaYvMfJOkGIJdqnJt4PaGoq4FO7HYaZ2Rg=;
        b=njxei/U8Ee71CwqDR94+D/deKXz4mcadhZGGDtO7F2oycY3719il1322E8RuaYuSVf
         3KPT18pAPyiymRerShk+WtHGLeHhSaVsN7UDNL4G0yGkqnQjgpMB/rAsQDlbqJMTlOyX
         rwoCuADSHZ20n+aT9y0iu78iyubmOnMjS5tZRk/9ja/SSUvgEVjPVLCs0hVqXsSa4Moo
         8tMSYBPMmyse2AeF+aW5qhiTvcQnzqVOlXS9lK7VCn7WsPPYXkCyOLfu8WQLg+AA5f44
         +rvobSzdCMj5Pv/sReFWbJ12Kf7icSCDXPEF3Znhrl497IfyRk/vMhztddUXH8zqNXqO
         ogZw==
X-Gm-Message-State: AOJu0YzgpkWyUB1l4Fd2DYR1uQpa2OkbwGvPdGrnofjuvLav5iLEQm6T
	nbCJ7RvwiOvGVGSQ7FVPeFESdFitxhmuM5Xq8VnbVpfid8eltcAC+MbLHCsIkH1/tcdUoDAXajB
	80HvClCT4qBIczROwrgvMwD42vwTBaJvZS2zvBAdM5PrfZ7m5OMYuizCBtdX0zukimRfibw==
X-Gm-Gg: Acq92OF/KqsAs3dXgrpHJpOmhohNSpR7ZzJTL6UTM3EShF0iIly7YlwjGXPzdulGoZ0
	5vlKyn0DxiNkuckfBxs6pEYY33fskEMWp11L4LY/H+XKyvb9WmJegbmS+pyOvjudbrq9rSOMcKI
	CyuzL1z9ISAFyPbyYQT4DSF20C0wT9369U6uB+mo6j8d51uvFAurTZM4c/dUEVzQb9a8wiobjwm
	R4rt0UOLMXShOxb8OTIFU04IVU+2cyZDS+bB3RczNRaakuiPlyLgpNinpc4n6AUL7R//NkFfVQe
	4uXjSM2vMRmPa8wovlHJogbo3x1F0YkDTL1eK0zTv2Wrd8LkNJt7JUvgQsCDLbd0KIfICW3vpFT
	6GO3+OeU/+k9IjwFhWfBMJIDb1cNDiBn8ti69yEHXtZ9ENGxZsQE/xMsyrJFS6ncarbWK8UVpO3
	7GEpRn7qNzj2V/jb5mlkPu7Y/hcX00NxCmc5WfyrE=
X-Received: by 2002:a17:902:da84:b0:2c0:d9b7:b7b0 with SMTP id d9443c01a7336-2c41216fae7mr111460075ad.31.1781414308889;
        Sat, 13 Jun 2026 22:18:28 -0700 (PDT)
X-Received: by 2002:a17:902:da84:b0:2c0:d9b7:b7b0 with SMTP id d9443c01a7336-2c41216fae7mr111459865ad.31.1781414308376;
        Sat, 13 Jun 2026 22:18:28 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c651dsm64456705ad.26.2026.06.13.22.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 22:18:27 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        praneesh.p@oss.qualcomm.com
Subject: [PATCH wireless-next v2 3/5] wifi: cfg80211: Refactor nl80211_dump_station() to prepare for per-link stats
Date: Sun, 14 Jun 2026 10:47:33 +0530
Message-ID: <20260614051739.3979947-4-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260614051739.3979947-1-praneesh.p@oss.qualcomm.com>
References: <20260614051739.3979947-1-praneesh.p@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDA0OSBTYWx0ZWRfX7KFOoBxP5y/4
 IGUi33bx2zvAliuCzymL/WrfjBlfaeV5tKECMSbU5MPYmRaF8ZhnidsutcVXln2gTYvJFslV9/U
 KjhmiKvI3rKyL3JOP7ZZ4DXJaNn1KK8=
X-Authority-Analysis: v=2.4 cv=fLYJG5ae c=1 sm=1 tr=0 ts=6a2e39a5 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=TxQvnd6P1TTKPCFIUNUA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDA0OSBTYWx0ZWRfX0nqF8eInNVF3
 K/pJ4Hj3ydALWWWzRf62UNA2oaZkaadQM7V7vbP6DQmO+71ztcMlJABcZbVtitJiUvoNZ34SuoU
 lvS/9cexxFwtzosMuiqn0AGKZvOqzsVlVjq8Bt+/WjPLKDwDobBNQ74RFREdWJ5HTKilbTUU6j+
 zJS6BKakjvRsRBdlJl4O8NG7rQGtntlosEdJetq0AByimI5n4mHc/15aKwgJqi0nUL7Ljy1eQcq
 FZAuB+xGCEmIf8Delv+pQWFMIzgZzgk+aJXPreODe4icFVXyj9Kh1SemNo2tQgz0uoKK7HQBxKT
 6HZ+8WXGp+vaVHhIqeGFXl/20tlREkKG4ofhJT8aY9I6fawaL9IT0o7w6rDSO0uNrdI8KDKsYH8
 ozPVETC4f0BVRJobGpaEISfLvCN1+5jDU/KJ9xxF0nVpl6clU43W8UjWZktfSIh1Nt1jwt3rnPo
 i/N2PvvThdggWyclylw==
X-Proofpoint-GUID: rcwUrtugRqMubVgDBhHyZFdznJN9V_LD
X-Proofpoint-ORIG-GUID: rcwUrtugRqMubVgDBhHyZFdznJN9V_LD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606140049
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37782-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF93D68062E

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
allocated during the dump to track the iteration state. Store the context
pointer directly at cb->args[2], following the same pattern as
nl80211_dump_wiphy which stores its state pointer at cb->args[0].

Move the station index (sta_idx) tracking and the sinfo payload into this
context. The per-station netlink message is built inline in the loop:
common header attributes are assembled directly, then
nl80211_put_sta_info_common() adds the STA_INFO payload.

Furthermore, move the NL80211_CMD_GET_STATION command definition from
genl_small_ops to genl_ops to natively support the .done callback.
Implement nl80211_dump_station_done() to ensure the newly allocated state
context and its deeply allocated sinfo payload are safely freed when the
dump concludes or is aborted prematurely by userspace.

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

At out_err_release, cfg80211_sinfo_release_content() frees any
dynamically allocated sub-fields inside ctx->sinfo (including per-link
pointers in sinfo.links[]). Without the subsequent memset, those
pointers remain non-NULL in the embedded sinfo. When the dump concludes
or is aborted, nl80211_dump_station_done() calls
cfg80211_sinfo_release_content() a second time on the same ctx->sinfo,
which would free the already-released link memory. The
memset(&ctx->sinfo, 0, sizeof(ctx->sinfo)) zeroes all pointers so the
second release call hits kfree(NULL), which is a harmless no-op.

Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
 net/wireless/nl80211.c | 129 +++++++++++++++++++++++++++--------------
 1 file changed, 85 insertions(+), 44 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 66f19bfc030a..b4c4406d77bf 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -8464,16 +8464,19 @@ static void cfg80211_sta_set_mld_sinfo(struct station_info *sinfo)
 	sinfo->filled &= ~BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG);
 }
 
+struct nl80211_dump_station_ctx {
+	int sta_idx;
+	u8 mac_addr[ETH_ALEN];
+	struct station_info sinfo;
+};
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
+	struct nl80211_dump_station_ctx *ctx = (void *)cb->args[2];
+	int err;
 
 	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev, NULL);
 	if (err)
@@ -8481,6 +8484,15 @@ static int nl80211_dump_station(struct sk_buff *skb,
 	/* nl80211_prepare_wdev_dump acquired it in the successful case */
 	__acquire(&rdev->wiphy.mtx);
 
+	if (!ctx) {
+		ctx = kzalloc_obj(*ctx);
+		if (!ctx) {
+			err = -ENOMEM;
+			goto out_err;
+		}
+		cb->args[2] = (long)ctx;
+	}
+
 	if (!wdev->netdev && wdev->iftype != NL80211_IFTYPE_NAN) {
 		err = -EINVAL;
 		goto out_err;
@@ -8491,55 +8503,83 @@ static int nl80211_dump_station(struct sk_buff *skb,
 		goto out_err;
 	}
 
-	while (1) {
-		memset(&sinfo, 0, sizeof(sinfo));
+	while (true) {
+		void *hdr;
 
-		for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
-			sinfo.links[i] =
-				kzalloc_obj(*sinfo.links[0]);
-			if (!sinfo.links[i]) {
+		memset(&ctx->sinfo, 0, sizeof(ctx->sinfo));
+		for (int i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
+			ctx->sinfo.links[i] =
+				kzalloc_obj(*ctx->sinfo.links[0]);
+			if (!ctx->sinfo.links[i]) {
 				err = -ENOMEM;
-				goto out_err;
+				goto out_err_release;
 			}
-			sinfo_alloc = true;
 		}
 
-		err = rdev_dump_station(rdev, wdev, sta_idx,
-					mac_addr, &sinfo);
-		if (err == -ENOENT)
-			break;
+		err = rdev_dump_station(rdev, wdev, ctx->sta_idx,
+					ctx->mac_addr, &ctx->sinfo);
+		if (err == -ENOENT) {
+			err = skb->len;
+			goto out_err_release;
+		}
 		if (err)
-			goto out_err;
+			goto out_err_release;
 
-		if (sinfo.valid_links)
-			cfg80211_sta_set_mld_sinfo(&sinfo);
+		if (ctx->sinfo.valid_links)
+			cfg80211_sta_set_mld_sinfo(&ctx->sinfo);
 
-		/* reset the sinfo_alloc flag as nl80211_send_station()
-		 * always releases sinfo
-		 */
-		sinfo_alloc = false;
+		hdr = nl80211hdr_put(skb, NETLINK_CB(cb->skb).portid,
+				     cb->nlh->nlmsg_seq, NLM_F_MULTI,
+				     NL80211_CMD_NEW_STATION);
+		if (!hdr) {
+			err = skb->len;
+			goto out_err_release;
+		}
 
-		if (nl80211_send_station(skb, NL80211_CMD_NEW_STATION,
-				NETLINK_CB(cb->skb).portid,
-				cb->nlh->nlmsg_seq, NLM_F_MULTI,
-				rdev, wdev, mac_addr,
-				&sinfo) < 0)
-			goto out;
+		if ((wdev->netdev &&
+		     nla_put_u32(skb, NL80211_ATTR_IFINDEX,
+				 wdev->netdev->ifindex)) ||
+		    nla_put_u64_64bit(skb, NL80211_ATTR_WDEV,
+				      wdev_id(wdev), NL80211_ATTR_PAD) ||
+		    nla_put(skb, NL80211_ATTR_MAC, ETH_ALEN, ctx->mac_addr) ||
+		    nla_put_u32(skb, NL80211_ATTR_GENERATION,
+				ctx->sinfo.generation)) {
+			genlmsg_cancel(skb, hdr);
+			err = skb->len;
+			goto out_err_release;
+		}
 
-		sta_idx++;
+		if (nl80211_put_sta_info_common(skb, rdev, &ctx->sinfo)) {
+			genlmsg_cancel(skb, hdr);
+			err = skb->len;
+			goto out_err_release;
+		}
+
+		genlmsg_end(skb, hdr);
+		cfg80211_sinfo_release_content(&ctx->sinfo);
+		ctx->sta_idx++;
 	}
 
- out:
-	cb->args[2] = sta_idx;
-	err = skb->len;
- out_err:
-	if (sinfo_alloc)
-		cfg80211_sinfo_release_content(&sinfo);
+out_err_release:
+	cfg80211_sinfo_release_content(&ctx->sinfo);
+	memset(&ctx->sinfo, 0, sizeof(ctx->sinfo));
+out_err:
 	wiphy_unlock(&rdev->wiphy);
 
 	return err;
 }
 
+static int nl80211_dump_station_done(struct netlink_callback *cb)
+{
+	struct nl80211_dump_station_ctx *ctx = (void *)cb->args[2];
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
@@ -19504,6 +19544,14 @@ static const struct genl_ops nl80211_ops[] = {
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
@@ -19603,13 +19651,6 @@ static const struct genl_small_ops nl80211_small_ops[] = {
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


