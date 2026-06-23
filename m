Return-Path: <linux-wireless+bounces-38007-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gUOiEFBhOmpS7gcAu9opvQ
	(envelope-from <linux-wireless+bounces-38007-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 12:34:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCADB6B64F6
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 12:34:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ilNo8Z24;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38007-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38007-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4672C3011EA7
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 10:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC76C36D9F9;
	Tue, 23 Jun 2026 10:34:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4FD367F25
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 10:34:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782210892; cv=none; b=ic8uX9KkSgqCV9AwvahyeB2Cj5lydThv6ZV5GgZxczC3k9CVUhc6l4M6CgOIQ39cWYUoehoYJFIo1jBKTewvohJ2eNoeUYp1lBpmgkJ+RTEWkAeh1zHC4+YKYqvmAucaMSrymZZjOAvIS3UxAinT+6gKqjcBuaqyd4z7croPVUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782210892; c=relaxed/simple;
	bh=HN1pNwVg6o9II7RYX+7cT2JFze6SyPGQt1Lg/I/anRk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rFS27FEGuHmQC0Gl5Cr7aoVGafamhB19Vh1peyvGBll2ulifO14iYM0h2egFnDF5iRFPu/4MHeRwILnfOlWPPmrvIZTb783dVry/8+m0xNFVAHoWwAHKSmoVKzKZvNC188fRhYr58sprQ2qu9K6/530V8+wotVbKAiIlPzjTvao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ilNo8Z24; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6cbRj2992227;
	Tue, 23 Jun 2026 10:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=RNBUtBxqfrGUUHr8PI1VLaTMg0HyxxG5hi0
	xc7rBW7c=; b=ilNo8Z24h4Uwhzb9zvnN8HfEGxc58D5OCCAuEtKOozciWV3yJqo
	240h6Os6jzMNdzjfHHAlj+RL0ZR0zO7uGYgpexBUGqJBsdF/OeER/vqPZfI8yLMe
	vD+wPN5NIh2xXhRs+luw3rnVapNEr8wUY/vZLmcT/4d0YklJC6N9pPbHtvV7qVWX
	FWc1uJupDLMXLKq5yGazX2MueIGjtftiDapiiSJr4CFv407+IKDXEEz7weHY11fZ
	1VOisxwB7+bjxkSjfIlNAl9f8tbTRNXmtydvkVlk5UjZ2LrsUJOVM/5WFNQZAdrd
	ShxFbw4sKb0Igs12HtBZkeWdvFDOCxbiAIw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey729v0e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 10:34:47 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NAYiqv028213;
	Tue, 23 Jun 2026 10:34:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4ewkxjp35j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 10:34:44 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65NAYhFd028209;
	Tue, 23 Jun 2026 10:34:43 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-dhanavan-blr.qualcomm.com [10.190.111.33])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 65NAYhVE028208
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 10:34:43 +0000 (GMT)
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4309709)
	id 0405C4104E; Tue, 23 Jun 2026 16:04:43 +0530 (+0530)
From: Dhanavandhana Kannan <dhanavandhana.kannan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Dhanavandhana Kannan <dhanavandhana.kannan@oss.qualcomm.com>
Subject: [PATCH wireless-next] wifi: cfg80211: Avoid UNPROT_BEACON on AP interfaces
Date: Tue, 23 Jun 2026 16:04:12 +0530
Message-Id: <20260623103412.1578812-1-dhanavandhana.kannan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA4NiBTYWx0ZWRfXx7KQlAtm8lMJ
 WlaNRoJ5Up584WNe2PGVe62ZNig+pr3GZO7+sXTJZwms3HPsnny2WOmR/r63UWY98zqdaeWwjuQ
 +XEM7xI8B+EbZHeB8iqli6WGDupCMgc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA4NiBTYWx0ZWRfXzhmZcflWvHef
 wyHBh7om2cDhvnvduSS8HDSAyuQXIujW7H8fjsz93prEnW96f24oeIE/OTy1RLNgPK5lrA9osuF
 9byqvSVCGhUg7Ddhx5zCM28orpLivtXYA2GAbHlfRLsb6cetOcAhEgCuLnIF5IhM/UX5LsDZeOg
 AstGNPb8cLuG/uwc8aXzppimYNeR3p2Hj6Rz5OkMJ1dawoZ3eWsPlyb3Yq0JaTeUdrIKgqsa4Xx
 TuN3CU05OCsrZit+FclN5TjknecN6jO389ooSFTNKz8DHXNq2YovnSMq3T4wp8EYuSNUrTdD9wZ
 bT0XC3cCVzRtsy20ltw2K0togXXMHB+4bht8yq4DjFgTLDvokpbvACQmdgYUa9sQIjakDLZj3mT
 ZxtPWmqHyC5s7+S5CP/BKMRsvXmWh6HhBvayv+/lxFPxEiofmgyv3oA+/zBCQQikG3876bfbTIB
 +QUTAnQfx9ZdyMI68Pg==
X-Proofpoint-ORIG-GUID: zcukaj6Rmw10_dMIeZYQRY_KMr53doW8
X-Proofpoint-GUID: zcukaj6Rmw10_dMIeZYQRY_KMr53doW8
X-Authority-Analysis: v=2.4 cv=eN0jSnp1 c=1 sm=1 tr=0 ts=6a3a6147 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=ShhS-cekG_PNb-4bJKEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230086
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38007-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:dhanavandhana.kannan@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dhanavandhana.kannan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhanavandhana.kannan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCADB6B64F6

Currently, an AP may receive unprotected beacons from neighbouring
BSSes, which cfg80211_rx_unprot_mlme_mgmt() forwards to userspace via
NL80211_CMD_UNPROT_BEACON regardless of interface type.

While the kernel rate-limits these events to once per 10 seconds per
wdev, in multi-BSS scenarios each AP interface maintains its own
rate-limit state, increasing the number of reported events.
In AP mode, hostapd has no handler for NL80211_CMD_UNPROT_BEACON and
logs an unhandled event message for each occurrence, leading to excessive
log noise and making it harder to identify real issues.

Since an AP does not need to act on unprotected beacons from neighbouring
BSSes, skip reporting this event when operating in AP mode.

Signed-off-by: Dhanavandhana Kannan <dhanavandhana.kannan@oss.qualcomm.com>
---
 net/wireless/nl80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 53b4b3f76697..5d2feb5002c5 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -20890,6 +20890,9 @@ void cfg80211_rx_unprot_mlme_mgmt(struct net_device *dev, const u8 *buf,
 	} else if (ieee80211_is_disassoc(mgmt->frame_control)) {
 		event.cmd = NL80211_CMD_UNPROT_DISASSOCIATE;
 	} else if (ieee80211_is_beacon(mgmt->frame_control)) {
+		if (wdev->iftype == NL80211_IFTYPE_AP ||
+		    wdev->iftype == NL80211_IFTYPE_P2P_GO)
+			return;
 		if (wdev->unprot_beacon_reported &&
 		    elapsed_jiffies_msecs(wdev->unprot_beacon_reported) < 10000)
 			return;

base-commit: 972c4dd19cb92e03d75b66c426cfade07582a1ba
-- 
2.34.1


