Return-Path: <linux-wireless+bounces-33987-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOPKEEplxWkn+AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33987-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 17:56:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 976C3338CB5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 17:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EA90307AFE1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 16:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0D041C2F5;
	Thu, 26 Mar 2026 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V8BR5rid"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022C041C316
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543667; cv=none; b=gfkQiFF0oVkETK+pcYamKaq4g4GLCrnF3iUAv8WTpPhpax0uFRIErt74YXPH1quaxYLxr6+2tNGytk592GaEw2oGxnVr5bBfWBIydYG/NDIgKmVFgBdcXlYJqUpgCN7+xXHhYcC6r0ftrQ9VVepJz2Ux1j2zD4B9QeAXM3fZw9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543667; c=relaxed/simple;
	bh=h3WtifltXSF6n2GijBsWuNFVPRQl8sjRF7ZiTOn79vU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YB+uqpRbz3dr/b+GAg0TlDzn51HPkZJsTolYZ6PSeLoWbHyF/FYQdrzkeYLLCKVvM8kbHcmDfttFiiQVfFohJ7k04DXDB67xPQvM0H5rEPLfgIAsWDTSdAINqVbqflwF1tzCZdRNtghIoSuQRbgVIwU2qtnR10TaUmOxfKLx+FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V8BR5rid; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QF9kc02451468;
	Thu, 26 Mar 2026 16:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+szUn7X+u79
	/R72a9AMbIMZeCXOmWwiEE3wHOr+mCgE=; b=V8BR5rideLXtPKV/4hHUbLgHXLu
	Tq73LUZIGbcJHhAcjO7FPA/7BPeN4o8gfe/YPOwsEpgsM6vAc6QSj+m5fnTnmnah
	9mwoHqpR/lNnARQN1imni5lXdtEYN0Kc5wTis2QTKA31AVrt4xcNnhRCTlIqd8Uy
	vKhB8WE8OLuZ+gJd/zZrOUD/BXCFgtzNbS69YtM1SCzn5vZsLc9y2SZD2SCFullD
	05bGnoWlax3gt0DslFNLiY0QcmybCuzPJzm+plglmmB0SNhJm34EVU6Ln4sxgVxZ
	NqP0hEF5JqrVCBW0Q4w7f6M0ekGVMBHAd0B+PW6fTtC1dQL/hDbu3vuZtNA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4q1t3py5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 16:47:41 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QGlcMg010617;
	Thu, 26 Mar 2026 16:47:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4d1mdn6sm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 16:47:38 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62QGlcjP010611;
	Thu, 26 Mar 2026 16:47:38 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 62QGlcrG010610
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 16:47:38 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id A5119417A3; Thu, 26 Mar 2026 22:17:37 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH wireless-next 3/3] wifi: mac80211: enable MLO support for 4-address mode interfaces
Date: Thu, 26 Mar 2026 22:17:23 +0530
Message-Id: <20260326164723.553927-4-tamizh.raja@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=e7cLiKp/ c=1 sm=1 tr=0 ts=69c5632e cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=KrUfIt6FkB_zrJtm8mAA:9
X-Proofpoint-GUID: nhirqLkXv48xiOlNiT2Fbo9nwyDMDo95
X-Proofpoint-ORIG-GUID: nhirqLkXv48xiOlNiT2Fbo9nwyDMDo95
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDExOSBTYWx0ZWRfXysEmnPS8yuwH
 GB0zrWQ699anGsEsrTcY9oOfZhSoYOWZ8vEioJGUlk7D6jOzhLgP+psIwAeSYMoPO2MBUhG28Pn
 3QO9tfAWOh2tm1OKg1iBgaTth0iWRyHyh1FcfBs2S5AzWV/yetZjDAHOr5rDgMj+MVaqYP3nEkk
 h42czIBn9G2GwyHIMshfH34wsHnxkTo3pt+DWZi40K6NSm8otbnbbnE5JOQbbl77i1dz0W7c2Oq
 06Fk5BUqRXJcAu8dp/qBvwyq9YQxRloZ1IPARAhqsLWqErwgkIZpoInIcjUBLt7Y2juHF0mvcaC
 D7DuAApwHNo/b7SLnuXBId1nLL6vn4qjHtx7xm5PnzCylhG/A1HrtbG++Qf9yqI8nidWIJWS4nO
 tJHR0wtDjk2boJ9fv6c4CYMCTjMlL/kBRCzqX9P65lq5fb5o95WbMC9g4bhCfzCmtEeTB0lHMpB
 axAMpk01KY+NcJUJ6Vg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260119
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33987-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 976C3338CB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current code does not support establishing MLO connections for
interfaces operating in 4-address AP_VLAN mode.
MLO bringup is blocked by sanity checks in cfg.c, iface.c, and mlme.c,
which prevent MLD initialization when use_4addr is enabled.
Remove these restrictions to allow 4-address AP_VLAN interfaces to
initialize as part of an MLD and successfully participate in MLO
connections. This patch series also adds the necessary changes to
support WDS operation in MLO, making these modifications valid.

Allow 4-address mode interfaces to:
- Proceed with MLD initialization during interface setup
- Add MLO links dynamically via ieee80211_add_intf_link()
- Establish associations with MLO-capable access points
- Support AP_VLAN interfaces with MLO parent APs

Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
---
 net/mac80211/cfg.c   | 7 -------
 net/mac80211/iface.c | 7 -------
 net/mac80211/mlme.c  | 4 ----
 3 files changed, 18 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e4f28e33400c..ccb41125b969 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -281,10 +281,6 @@ static int ieee80211_change_iface(struct wiphy *wiphy,
 		if (params->use_4addr == ifmgd->use_4addr)
 			return 0;
 
-		/* FIXME: no support for 4-addr MLO yet */
-		if (ieee80211_vif_is_mld(&sdata->vif))
-			return -EOPNOTSUPP;
-
 		sdata->u.mgd.use_4addr = params->use_4addr;
 		if (!ifmgd->associated)
 			return 0;
@@ -5480,9 +5476,6 @@ static int ieee80211_add_intf_link(struct wiphy *wiphy,
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	if (wdev->use_4addr)
-		return -EOPNOTSUPP;
-
 	return ieee80211_vif_set_links(sdata, wdev->valid_links, 0);
 }
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 125897717a4c..f6c65b88cabd 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -398,13 +398,6 @@ static int ieee80211_check_concurrent_iface(struct ieee80211_sub_if_data *sdata,
 							nsdata->vif.type))
 				return -ENOTUNIQ;
 
-			/* No support for VLAN with MLO yet */
-			if (iftype == NL80211_IFTYPE_AP_VLAN &&
-			    sdata->wdev.use_4addr &&
-			    nsdata->vif.type == NL80211_IFTYPE_AP &&
-			    nsdata->vif.valid_links)
-				return -EOPNOTSUPP;
-
 			/*
 			 * can only add VLANs to enabled APs
 			 */
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 9603fe4b612f..bc61369213f3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -9858,10 +9858,6 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++)
 		size += req->links[i].elems_len;
 
-	/* FIXME: no support for 4-addr MLO yet */
-	if (sdata->u.mgd.use_4addr && req->link_id >= 0)
-		return -EOPNOTSUPP;
-
 	assoc_data = kzalloc(size, GFP_KERNEL);
 	if (!assoc_data)
 		return -ENOMEM;
-- 
2.34.1


