Return-Path: <linux-wireless+bounces-31347-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEMOBqsrfGkfLAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31347-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 04:55:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 929FAB6F0E
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 04:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22A48301410A
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 03:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D4F23ABA9;
	Fri, 30 Jan 2026 03:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PnihehD/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BP3+t77o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B57314D26
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 03:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769745318; cv=none; b=IuiohRRO9rrbyluAiccL+0frMOhT0vB9+6n7iEgjwP9ppwSBeUhGBLb1W9Jmtj6YACjQ44ab0UYO7d9O1Ac5FUxYKXkhj5++yhZnhL+ZNGyzbiMn2yQe2G9PqUFTWonBwPDJV03OBYiNano63f8m2aosdghGoe0kJ9KQ4GzQxgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769745318; c=relaxed/simple;
	bh=Jgkfyt/0ZN2+SUVzYVWeTC9CUorQIpQfFQNvzmxEkFU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ItHRwG8Sf4t/erg74hW7uZBaBDCChrOMmmyC449AILEUFqx3PqnDmjcaL6mIEYlw1nJye8badeFx/LPvBYvCGY9dyviL9qGrF0Vgt8GmKdFmqPmuyx1kiIO9damrWZBryuHzCclVNTL7DVY7D5tXxuITfwBkaD/bv8HRF2fTwUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PnihehD/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BP3+t77o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U3VrfY1488881
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 03:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=DOCnL8KbbsoDU5D9nEWTzz0ZwjmpwjwunOc
	EjhT/4BE=; b=PnihehD/y/WkpQZ6tWtvVShZ+KT0ZC5+RlEpkaZwHVRLN1QCp0m
	9Lmo11u4bPm+IXvcvrMlilbFA2Jto5oUqTV+i8hXviXc6eidtQI2ciIhmCTSM8k8
	yskZL3S+x/mbQVjbtnY2dKbiL3hPu8U2zee2ME4ZPw+ZGsQs2We/4lxNTDDwAqmo
	jYFqDTGBDJY4DrHWz9sespVa2FFbF0R6gciHR12dN+TAv8hCIvbZOmkGm/Pn0i69
	qwlbcOhfridusozN6YSOiDCVJJ4CFDFNunBUOKhopSyeE9nY9G+UtOx1Fo7EDM6U
	ZtlT6WNz/eShrqbCxYQGPVM4VCo8T/qq2EQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0bp3spn6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 03:55:16 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8216fece04cso2283914b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 19:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769745315; x=1770350115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DOCnL8KbbsoDU5D9nEWTzz0ZwjmpwjwunOcEjhT/4BE=;
        b=BP3+t77oGeNflJVduT4U3AJCVX96pqpUikiki741vI1wEm37ty3rnyisNsUXy/6/AX
         gi3RVr4HXoXeM9moIPnyU0U9J9cJQNkidEqxkLWk8McDRPuJrr0trWfXqMzhL4xbGQBy
         IQZG6sZGysfT0ZEG/coExB1P2Aj6p23FD6wN9IUuyOFpqGL7U5nuVZlzebliuEVeSL3o
         j2qo8IaiQ4Wd4CGcQpyzBGfrGWyqTFSJPECSfjdjS3KedOstQRCL18fmvc3DuLYTVPWN
         JWkft1c/VOeFQeI6dMulziZVyT7Q/Yr83gn/8TXgOWWB+wmCilp1QjjusBDzibaBej51
         WMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769745315; x=1770350115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOCnL8KbbsoDU5D9nEWTzz0ZwjmpwjwunOcEjhT/4BE=;
        b=xHQbkl4c6QYiCj0qzidcbPw8R/d5UvWVpxBwUJyg91knYqYkQRP3DvXIgAi+sAVTQE
         Ss7qU3mlmndyoa+d+fjEJim81+aZAvQZOFElxo1enDGwLK+DOt7w8liGpMoX7Q2u+04M
         /L6ct/cmH8leoiJn2yRONylHAIWCxA9eYmRT2uWLo5XlLZ9QYj3NSWWu88SWJCO3Xl3s
         nb3yUNSGpaBYTIZwzUTeOfygsVOusRLH4ZwFe+Pw+Z+hkgoBgqCYO8cxWGhvtSIjVZJR
         yoWldF3QXSbkRghqpW7hjTNMy6SlzaHxN3Ct/aCdVgjeolbuVlMEQTTECDQBgMWj7xZP
         0j4w==
X-Gm-Message-State: AOJu0Yy5IbbZuFnqM9fdCkpTojAC2AYOqs8nUuENpnEBYpbpkdL9okRD
	m8APoeGpK8yYI8VntiRuV1SwSUhzaqPyRXpWX26CevqcEZopPJLYMKgthS4gcuj4uLT6RWNpaiu
	h1fTkjT35DT5oh0zqkM5gKOhz4vmUpFssHCTZiU/HZtMOLStsgziQdNFP9gOR4HrlsuGUWA==
X-Gm-Gg: AZuq6aKx9WnIoFRJnP+zvRc1osevBfb6P9VoW+pi+z+PEoVzt4rHw3qvcuP2jl1AaTQ
	E0d8UnpejzuwcmGYhmFmPVApKNj60C1qoUGhmPcpx7ZzEa/xD3kuJv4028tUGONo15zRyJYPprD
	DRTeL0ZFAdyjXxeG7s8xXrWleWrMZr5ugzxuoH34XCuoI7/ELOUh8AhIENe+fg92w+iE5plWS9Q
	B97DRGfap+GIPOObnVpPrP42YSDDnm5dQMju81rq6Dx4STH2xxGhY8rE7NwxbnrOig9FklcH9p0
	DT9EnHQu8iWBms0pBuk6UwUhKf4hIFK/PXdXSyILY55PSFUQMzIhFw8EMT3drNbC4UHiXs+feoF
	g035SLJg9DFfY9HDaG5gDGqb7UAiKGlEuK86ru1vWD5BbISnrTvnK0bvRjiXuZV8vavoL3CZxCy
	wWMbtRlFOB9zK0vm5YoB9x3Ic=
X-Received: by 2002:a05:6a00:849:b0:781:1110:f175 with SMTP id d2e1a72fcca58-823ab679259mr1416458b3a.14.1769745315258;
        Thu, 29 Jan 2026 19:55:15 -0800 (PST)
X-Received: by 2002:a05:6a00:849:b0:781:1110:f175 with SMTP id d2e1a72fcca58-823ab679259mr1416414b3a.14.1769745314434;
        Thu, 29 Jan 2026 19:55:14 -0800 (PST)
Received: from hu-amitajit-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c521cdsm6447158b3a.62.2026.01.29.19.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 19:55:14 -0800 (PST)
From: Amith A <amith.a@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, amith.a@oss.qualcomm.com
Subject: [PATCH wireless-next v2] wifi: mac80211: use wiphy_hrtimer_work for CAC timeout
Date: Fri, 30 Jan 2026 09:25:11 +0530
Message-Id: <20260130035511.2328713-1-amith.a@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nITdrecVbKhjmHOhuSM4vFEVO303yoKR
X-Proofpoint-ORIG-GUID: nITdrecVbKhjmHOhuSM4vFEVO303yoKR
X-Authority-Analysis: v=2.4 cv=d6T4CBjE c=1 sm=1 tr=0 ts=697c2ba4 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=TBLNI4pxKqmck-2k7qYA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDAyOCBTYWx0ZWRfXx25DpsWa94vb
 xy++QQ7ElfDHAv967AnfpqthleE5cGEQaxFyhQ9DOmwTHzYyCI7SDBJJSZwepWknbLiFt17PVEw
 EymqG5xPhxwkA2Fe/SZGzvTZsTG0Jir0i93X4KpdVl7DAJiPBMlLpxdOlqmb8ufJWeudPQpdy6R
 Ty47RPOCQHuF4L+2SIpb8LPQZCRJAMkXUuivTq1PGRBilde36jLbtkOnwRy3Tq3a9IOeUJ5oijQ
 v/w/r+va2gm5fc4/VTIXKf1Kyk9k0JcZtE4c0QTWKd915Jr8LuPmK0EcrpTfwwagATg63/GXdpj
 MGhxy1rtcTqNnnsvGRDA069oLiQq/MxcR3Org5vaNfiISZHw7j29q8LJeNSvNnAAXVmMRJURFIJ
 Sk341ExIxCtekCj8UYv2ry6WW27m4k9dZAq/8ZM4SnkKoWzeECAf0iagRcfZhaM9/izUl7Rin1c
 JV4JyOy1+pF6TEztR5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300028
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31347-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amith.a@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 929FAB6F0E
X-Rspamd-Action: no action

Prior initiating communication in a DFS channel, there should be a
monitoring of RADAR in that channel for a minimum of 600 seconds if it
is a Weather RADAR channel and 60 seconds for other DFS channels. This
Channel Availability Check(CAC) is currently implemented by scheduling
a work item for execution with a delay equal to an appropriate timeout.
But this work item is observed to take more delay than specified
(4-5 seconds in regular DFS channels and 25-30 seconds in Weather RADAR
channels). Even though this delay is expected in case of delayed work
queue as there is no guarantee that the work will be scheduled exactly
after the specified delay, a delay of more than 20 seconds is too much
for the AP to be in non-operational state.

Recently commit 7ceba45a6658 ("wifi: cfg80211: add an hrtimer based
delayed work item") added an infrastructure to overcome this issue by
supporting high resolution timers for mac80211 delayed work, which do not
have this timeout latency. Switch the CAC timeout to use this
infrastructure, so the CAC completion handling is triggered with tighter
timing and reduced latency.

Signed-off-by: Amith A <amith.a@oss.qualcomm.com>
---
Changes in v2:
 - Updated the commit message to imply that the change adds a performance
   improvement and not a correctness fix.
---
 net/mac80211/cfg.c         | 8 ++++----
 net/mac80211/ieee80211_i.h | 2 +-
 net/mac80211/iface.c       | 2 +-
 net/mac80211/link.c        | 4 ++--
 net/mac80211/util.c        | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 964f440e31cd..f1d19accae27 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1916,7 +1916,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 
 	if (sdata->wdev.links[link_id].cac_started) {
 		chandef = link_conf->chanreq.oper;
-		wiphy_delayed_work_cancel(wiphy, &link->dfs_cac_timer_work);
+		wiphy_hrtimer_work_cancel(wiphy, &link->dfs_cac_timer_work);
 		cfg80211_cac_event(sdata->dev, &chandef,
 				   NL80211_RADAR_CAC_ABORTED,
 				   GFP_KERNEL, link_id);
@@ -3851,6 +3851,7 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 					   u32 cac_time_ms, int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	ktime_t ktime = ktime_set(0, ms_to_ktime(cac_time_ms));
 	struct ieee80211_chan_req chanreq = { .oper = *chandef };
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_link_data *link_data;
@@ -3874,8 +3875,7 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 	if (err)
 		return err;
 
-	wiphy_delayed_work_queue(wiphy, &link_data->dfs_cac_timer_work,
-				 msecs_to_jiffies(cac_time_ms));
+	wiphy_hrtimer_work_queue(wiphy, &link_data->dfs_cac_timer_work, ktime);
 
 	return 0;
 }
@@ -3894,7 +3894,7 @@ static void ieee80211_end_cac(struct wiphy *wiphy,
 		if (!link_data)
 			continue;
 
-		wiphy_delayed_work_cancel(wiphy,
+		wiphy_hrtimer_work_cancel(wiphy,
 					  &link_data->dfs_cac_timer_work);
 
 		if (sdata->wdev.links[link_id].cac_started) {
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index dc757cb32974..df5056463388 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1101,7 +1101,7 @@ struct ieee80211_link_data {
 	int ap_power_level; /* in dBm */
 
 	bool radar_required;
-	struct wiphy_delayed_work dfs_cac_timer_work;
+	struct wiphy_hrtimer_work dfs_cac_timer_work;
 
 	union {
 		struct ieee80211_link_data_managed mgd;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 3ce94b95decd..15583fc7003a 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -561,7 +561,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	wiphy_work_cancel(local->hw.wiphy, &sdata->deflink.csa.finalize_work);
 	wiphy_work_cancel(local->hw.wiphy,
 			  &sdata->deflink.color_change_finalize_work);
-	wiphy_delayed_work_cancel(local->hw.wiphy,
+	wiphy_hrtimer_work_cancel(local->hw.wiphy,
 				  &sdata->deflink.dfs_cac_timer_work);
 
 	if (sdata->wdev.links[0].cac_started) {
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 1e05845872af..17bf55dabd31 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -116,7 +116,7 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 			ieee80211_color_change_finalize_work);
 	wiphy_delayed_work_init(&link->color_collision_detect_work,
 				ieee80211_color_collision_detection_work);
-	wiphy_delayed_work_init(&link->dfs_cac_timer_work,
+	wiphy_hrtimer_work_init(&link->dfs_cac_timer_work,
 				ieee80211_dfs_cac_timer_work);
 
 	if (!deflink) {
@@ -155,7 +155,7 @@ void ieee80211_link_stop(struct ieee80211_link_data *link)
 			  &link->csa.finalize_work);
 
 	if (link->sdata->wdev.links[link->link_id].cac_started) {
-		wiphy_delayed_work_cancel(link->sdata->local->hw.wiphy,
+		wiphy_hrtimer_work_cancel(link->sdata->local->hw.wiphy,
 					  &link->dfs_cac_timer_work);
 		cfg80211_cac_event(link->sdata->dev,
 				   &link->conf->chanreq.oper,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 4d5680da7aa0..260893b83df1 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3597,7 +3597,7 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local,
 			if (ctx && &ctx->conf != chanctx_conf)
 				continue;
 
-			wiphy_delayed_work_cancel(local->hw.wiphy,
+			wiphy_hrtimer_work_cancel(local->hw.wiphy,
 						  &link->dfs_cac_timer_work);
 
 			if (!sdata->wdev.links[link_id].cac_started)

base-commit: c30e188bd2a886258be5facb970a804d8ef549b5
-- 
2.34.1


