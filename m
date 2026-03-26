Return-Path: <linux-wireless+bounces-33986-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKZYNIdnxWkn+AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33986-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:06:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C84FA338E4A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D12B730D07BC
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 16:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342F138D01A;
	Thu, 26 Mar 2026 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EbHKFopt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A7741C2EB
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543667; cv=none; b=CJIbi5uZ+MH99LQPG7MeOS4p5zyxwkx/EIV3rMo2WVkoqQyBYVfjPMf+VOvQzupy81CP6whWlm+GA878RkIgWGkerj+flKv7GZUGdsqnIaIvtifEkw/f11090sXw2qJ3qu0Dn8JJ4DSidFH6CHLGaToh1Y8WbFt8dSXyeTLaQbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543667; c=relaxed/simple;
	bh=wLez8/knSa2yztKNDrj8PMgen+8WRjr4o2tS8Q5sbo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bWkwWRGNJL0e2JRun1wMwzzq91vMPP0YaJ/urBJX9ucdUjcySY4xVWdaO/ERs9+2YU6Wtvo2+qWwlj/vOA2FweAZsycTPDOv1IJjIemqv3DbeQzgKiOLJZ5hCJf3LwdkcZWVwuOjcVWJxgUCAZQ1LiZ41LSb5ofKX9HzMMe689s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EbHKFopt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QF9dg41088012;
	Thu, 26 Mar 2026 16:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sV7IH4qcBRF
	10o6sqPCNwHRP/DmNDzCeCIa9G4DuSw8=; b=EbHKFoptaQPu0ntw3Jvy+z56TXt
	btU62f6GF6TeJHjPi7Dfx1LyVqmkEUqBrbg6VyLj5y3TbIN12kh20TaaIYqUUvf+
	/WS/9rLRjcxZdTHxQ2Q4cctndqSejPIECjF4JZ30IVMm8Uk7KeeYcc1dRaWkWPGD
	a6i3YFG4qAGmeKb9KiZI2Do5Ol4Hpg/gPkb56sqtjaDjhcrI8Lt6r7fEUWeYPCv2
	0O8hNhL/czHwU4wLEKfdRFrHjZVS02KINS5UIf47Ur8EkH7jDzUKrTXtlVNKB1FN
	VPd7nsmRiD/5Wx76EvZttRJq0nfXYJyqgPd4sz89UQjELIOG0UxTDFFKhBw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4rcn3fwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 16:47:39 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QGlSMl010532;
	Thu, 26 Mar 2026 16:47:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4d1mdn6skx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 16:47:36 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62QGlZjh010572;
	Thu, 26 Mar 2026 16:47:35 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 62QGlZJQ010570
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 16:47:35 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id 2ECE8417A3; Thu, 26 Mar 2026 22:17:35 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Subject: [PATCH wireless-next 2/3] wifi: mac80211: use ap_addr for 4-address NULL frame destination
Date: Thu, 26 Mar 2026 22:17:22 +0530
Message-Id: <20260326164723.553927-3-tamizh.raja@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326164723.553927-1-tamizh.raja@oss.qualcomm.com>
References: <20260326164723.553927-1-tamizh.raja@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Vdr6/Vp9 c=1 sm=1 tr=0 ts=69c5632b cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=svvMyppN8UTKOYKPt-oA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: QfRS5_oe2ZvzvvEguLwQiozhg1lFd9wj
X-Proofpoint-GUID: QfRS5_oe2ZvzvvEguLwQiozhg1lFd9wj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDExOSBTYWx0ZWRfX4m993orUhcvP
 0FN5HxulcZoFoLEX8Tbk2CQ1TyDypYd8TWjgm+v/n9S1/3OXlNNRl0xaXloKVoyDarbKhlOxsz2
 y1h4nY/XYnfx+xgQrcepSfaK9SmnKbZgSIEopIKFnFPaQWqotw8YylYcc7zAkaC/Op2i1XVb7K/
 V81FXRdG386azfzu5LsZFxcYhF5zoJRecthyvtQFG9+amy+4cT5b49VuLXIzOohMfilWKa3Oge4
 bsRrRgim1XqAtuXYXm2pxBdGUi3CyHuJbkOOEUVx4rZ+AWya01dWDIJhId7yBFek6snqKjmsbyR
 Ns6QPUi87pKjcJH4Mj39qXfZMBrx5qCyERd/W20bYnghh7toX2CBsK/8WK8BW3IconxhdDm6QZ5
 7ALACkxErXt3+pfgrhqm2jQp8+FGq0qb5wkXLtHonuLcYEK1IRw4L37n4F2m1dS+qlkZYqoGea0
 PJrw9rYZ9ZBI9NgOA1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260119
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
	TAGGED_FROM(0.00)[bounces-33986-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C84FA338E4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently ieee80211_send_4addr_nullfunc() uses deflink.u.mgd.bssid
for addr1 and addr3 fields. In MLO configurations, deflink.u.mgd.bssid
represents link 0's BSSID and is not updated when link 0 is not an
assoc link. This causes 4-address NULL frames to be sent to the
wrong address, preventing WDS AP_VLAN interface creation on the peer AP.

To fix this use sdata->vif.cfg.ap_addr instead, which contains the AP's MLD
address populated during authentication/association and remains
valid regardless of which links are active.

This ensures 4-address NULL frames reach the correct AP, allowing
proper WDS operation over MLO connections.

Co-developed-by: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Signed-off-by: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
---
 net/mac80211/mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 7fc5616cb244..9603fe4b612f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2514,9 +2514,9 @@ void ieee80211_send_4addr_nullfunc(struct ieee80211_local *local,
 	fc = cpu_to_le16(IEEE80211_FTYPE_DATA | IEEE80211_STYPE_NULLFUNC |
 			 IEEE80211_FCTL_FROMDS | IEEE80211_FCTL_TODS);
 	nullfunc->frame_control = fc;
-	memcpy(nullfunc->addr1, sdata->deflink.u.mgd.bssid, ETH_ALEN);
+	memcpy(nullfunc->addr1, sdata->vif.cfg.ap_addr, ETH_ALEN);
 	memcpy(nullfunc->addr2, sdata->vif.addr, ETH_ALEN);
-	memcpy(nullfunc->addr3, sdata->deflink.u.mgd.bssid, ETH_ALEN);
+	memcpy(nullfunc->addr3, sdata->vif.cfg.ap_addr, ETH_ALEN);
 	memcpy(nullfunc->addr4, sdata->vif.addr, ETH_ALEN);
 
 	IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT;
-- 
2.34.1


