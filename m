Return-Path: <linux-wireless+bounces-37392-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SM0pL0qqIWp4KwEAu9opvQ
	(envelope-from <linux-wireless+bounces-37392-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 18:39:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D423641EC1
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 18:39:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=nRyMI7ST;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37392-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37392-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00EA4302FEB9
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 16:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3E949219A;
	Thu,  4 Jun 2026 16:24:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEE14779A7
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2026 16:24:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590271; cv=none; b=Iy948+S1cveJ5Cv0vDEaVlR1mQBrT0J0aqKjZvfTZgosjGK3yqiVSA03giULcK5sVYSt4TlKOS1euJThip2sgReoNa8evsXvnVCvRK4r+/SZUwRGXYETl7hK28DTiktlKH+GtMtqpt3umKzYOAuONG/72wq9IJ50Acn4JCayLPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590271; c=relaxed/simple;
	bh=ccaSDSYYWDkkNGpYlE/glj7FrqLu7pNh76zi8KJTxQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=csl9Sobx72x410fClub9tyMWf3h2QUJVv8nQM938cAqrhM1hexEcjgbZ4zoEGZyMBnlUnbjQU3t/TKOUG5T0fDb2DkF7sGavj0atIpRK7aph+oB/r5Ns/LDlC1amvs30rXEdVN8N0xA0TG7xvJ1Gt2gw/UFBiAisqqIqHZ84H38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nRyMI7ST; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654Eh4eX600152;
	Thu, 4 Jun 2026 16:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Jw72IVU0fTv
	zYSvD3ULxJGN1yb7llQxFTwxXdHFi814=; b=nRyMI7STImcWzEbLf3FJD5Dmu+U
	poXoRuKq/qJNMtFavE7ya3kP0v63XQZlKwbkXyeIIdYkZhOn3XfJo/7+YhymC7JL
	am/x8zNiD9+NbS79cpBfsNzi9rETpR+LmJPblphMFhnvh0GJrpeeTCkX7/nLM9Un
	UnXPn0SbL4ufSxvCpHkep+wp9tkEOKy/HzjqrNHo9yU08GSxb7FzcgyKQfoIllA1
	QpM5n04HKSiBz60qh6ME1jk0ecjZTuM8NySIl9O80DK8DNHiktacbIdq/5R8Iapj
	A9Pzuy0Bk+28G5eP8a2hbo6UFSntDynbTzxJnnPsAOsKyuI2eAcLNW/mj3A==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejy8m3f43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 16:24:22 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 654GOJWM020820;
	Thu, 4 Jun 2026 16:24:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4efrykcnmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 16:24:19 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 654GOJdd020815;
	Thu, 4 Jun 2026 16:24:19 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 654GOJaB020814
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 16:24:19 +0000 (GMT)
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id 718D34210A; Thu,  4 Jun 2026 21:54:18 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH wireless-next v2 1/3] wifi: mac80211: Add sta pointer sanity check in ieee80211_8023_xmit()
Date: Thu,  4 Jun 2026 21:54:01 +0530
Message-Id: <20260604162403.1563729-2-tamizh.raja@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a21a6b7 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=pmfvr_IGfeeChePx7DsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE2MCBTYWx0ZWRfXzeQR4BXaHlzf
 JVrvwK69rJmDwVmVd37I30TMAR9S2r4DcHhuUePVnwrFjWh/tITb0Uwu7QQawy/UN16vxloh64n
 jH6VGs//0b+b7697fZ+rySgrMX2CKOFM4i0p3w8aXvU/mnab/lCE7wUntryqkTg5VlqhAUATRRS
 h0EfYQ7ex9L0vbEh3JEsZhqBHtoJRswbFteD/+w41zYVUQMEcN0G33w0jX0ghO/VsqhBD6Kt8sG
 3NOQk+g9O1ph6uM/ve4D0ecB6ZDjilJFG9MCezdoXYWdXpN4e26yD/um1d4wCnjHOFU9oxRK081
 nu2+ij7HAzWabOXAHoL7B7TGSGOHxAUykelyxc0fGa7aRN2PBiK6MTF3ar4cMSTzlG2RapbDjMR
 mY/cVZ8zMIAA7/fmz9yPSPsH1ewsqj1rw6TPvYyoB5L5Et8U6v2jIxKQxu5dSTlGo5zdUiDs9mR
 OEBhuGN53uqOEB9ITog==
X-Proofpoint-GUID: q-I6g1NYCFXyzTnuC66pSZmPwcV1H317
X-Proofpoint-ORIG-GUID: q-I6g1NYCFXyzTnuC66pSZmPwcV1H317
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040160
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37392-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 2D423641EC1

Currently ieee80211_8023_xmit() accesses the sta pointer without any
sanity check, assuming that only unicast packets for an authorized
station are processed. But the sta pointer could become NULL when
a framework to support 802.3 offload for the multicast packets is
added in the follow-up patches. Add the valid sta pointer sanity
check to avoid the invalid pointer access.

This aligns with some of the subordinate functions called by
ieee80211_8023_xmit() that already NULL-check 'sta' such as
ieee80211_select_queue() and ieee80211_aggr_check().

Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
---
 net/mac80211/tx.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index cf336e92c072..15ec77255c3f 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4660,7 +4660,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_tx_info *info;
 	struct ieee80211_local *local = sdata->local;
-	struct tid_ampdu_tx *tid_tx;
+	struct tid_ampdu_tx *tid_tx = NULL;
 	struct sk_buff *seg, *next;
 	unsigned int skbs = 0, len = 0;
 	u16 queue;
@@ -4680,7 +4680,9 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	ieee80211_aggr_check(sdata, sta, skb);
 
 	tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
-	tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
+
+	if (sta)
+		tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
 	if (tid_tx) {
 		if (!test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state)) {
 			/* fall back to non-offload slow path */
@@ -4728,8 +4730,11 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	}
 
 	dev_sw_netstats_tx_add(dev, skbs, len);
-	sta->deflink.tx_stats.packets[queue] += skbs;
-	sta->deflink.tx_stats.bytes[queue] += len;
+
+	if (sta) {
+		sta->deflink.tx_stats.packets[queue] += skbs;
+		sta->deflink.tx_stats.bytes[queue] += len;
+	}
 
 	ieee80211_tpt_led_trig_tx(local, len);
 
-- 
2.34.1


