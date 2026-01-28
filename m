Return-Path: <linux-wireless+bounces-31259-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDQCLGOxeWn5yQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31259-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 07:49:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DB19D83A
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 07:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDEFE3011C6B
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 06:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A670288C0E;
	Wed, 28 Jan 2026 06:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="okBR7+LK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f0xfmmzM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C075321CC4F
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769582943; cv=none; b=IuR4I7LDzXidFDLGbCQfsNbtknPR+ziwrXAQBha1yUGeHkFtA0fsCcWamHSeHHwH6H/LopI20VQIfh+KnEDgL2OlKfpT8k/OULf45SRnEPduG0wJ0O8Lu5bzuyxMeLOy+KTpfzNJy5T2K7J2iVg4CQzjDs/vNpGhzRRxzB2EKgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769582943; c=relaxed/simple;
	bh=kuKtMd2Ny4G+rlkPTs7TOxrkTLoDauSeh7r2zHwpbEc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NvSMiqIlTkx3pK4qVYf/5KNk3sz1bhK3GwC25MHIdfDC9B6d3kQB/qtUGfaDqTuxsFBgFjbyqkRT5Fe6fzO8jQCeOumOEIr+ev0jtpgp9HnT+mbpviwAZfw9orfNshrsCLm9Ho9zkR6NXWyhR3+g/pK6w1QH3gJEA/9GtHRR44U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=okBR7+LK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f0xfmmzM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S3X4LG2728765
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 06:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=v4BEeXbchbHlCbaup7z908hHFkecDhmLTBr
	CqW3KKx0=; b=okBR7+LKRNeE+mZ1M9w1Q90dsAiREsLn3SOu32UA6GW9tRTynv+
	VQP3E/VVf6Q1cGwQC/hihmv+PztyHnUtUXPihmOB/UvFIhPlKvlkVwTsRjCXTGve
	br3FcZFQVWa5YtL84yMgwjKG1qL0KxgWOaFYHZuvzxFEi8d6vQwJUcXiqzW2PtDa
	n0JH9cvbm+ESeY1LJTXeb5QFs8HzK3TNwccsJEM1SbYI8Noa982UeszGVwLxIozq
	IKStedetU1xiQPf2nmhLOe6OcSp18CaKQhd77H6cqbnSh1DgLAPj1fJq2S94Ypri
	C9LsE6DVXJCklQ0cmY/24Z+5EN7a4chRwzA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byanaggsk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 06:49:00 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-352e1a8603bso6630253a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 22:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769582940; x=1770187740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v4BEeXbchbHlCbaup7z908hHFkecDhmLTBrCqW3KKx0=;
        b=f0xfmmzMBRv/qIttugi1Qn99kiFdAyOaujbNCu3tvFPNqKOFTyM8556FZLo1x5uTzp
         hvd8MkOwxqTWDaKDYcJmqrdl6FVsadd8eJyK3gMcoDjPtVOS3LeN8951BWV2X01GYbqk
         HJLBmpaCtCUr/N6kctJp+77idV6zBuIpKVhlnJ5i6g2qt8IbByej2RoHsuZtPlfQ/YKs
         brugdzzlG18xtSOXLV/HRACsrFkP0A7OtG3nZ48hcjd3WR6wfrywXW9f9hQL6jt5cp7+
         Zxwmjsx5KhZ5/ZStn01W/z01Atv9rBwyf8ez0QLjWN2QJyb2FoAWjN48Vn7xdsVsPuUL
         ECrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769582940; x=1770187740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4BEeXbchbHlCbaup7z908hHFkecDhmLTBrCqW3KKx0=;
        b=H3RuAXEVIbmunMigFQX4K0VeKCuDUncURvE30vrbw1f6fcURajxb7R55N23RCbWjtH
         zXNZu3lZXqs7n0fBZVc0IlI1oEMNub+7x/p4/xepUhZ2TP64Y8Mkq4Bt24CAK65y8zBo
         ygEZ9VB2bofFpHxC3JomyyxJlcpRZkCOOGWCEZnkRtuIw9LluLm7YBWOZNkUzKr4Gd8a
         /xBnWu+BnVzJ/6k/9gMMOeKSwSNueoHAZJ9suwzg67GCRsgWfHPVb6QUOvy+u9KOxCdK
         ItISCSQ/I9kWnl7XCADUjSx337ej5RASSO2+KReQGYIpnuSugY1yF0rsbkvnWgpXEZ6H
         bhqQ==
X-Gm-Message-State: AOJu0YxzuhV1iquJBR3ipJ0uIiPwoU0CvmCErFstAFyHxPqobPCvImiQ
	dI04mpNince2cJj824KMOROnXxnICX0fQFBKmpkXyj8CfvhdjTmuUvJ2iUmdJmevAf7HFm0LNs/
	2Ek/U2HlvyclfwMVnqyeXTMR9tuy6yx4hS795L3Ik+Q3/G+ZPnPCUYRLyvzAeuG9796GUmQ==
X-Gm-Gg: AZuq6aLzZuaduJ1/FA3FnE4hIMhOam2vv7Frw2QSnRCG8vZstdgPS5GP/AX+qAIl3Bp
	UybemomVHY1o+9QlQpMlyU34OXL2bHR0QFjKAGLSIsJjN3qBK4PUXyb7s3xPJ43jdYAiSechow1
	3Yt34wMOtI62Qbo5WzRbThAGX5pQvrXTXDnbl7YB/7h/IwicRXI+HdXHyXSwMEpJhqRjDzHEkF0
	T2Avr54jut1dymjJN/2EOrfBGyLb+/DVmWmYQ2eNQSRBo71JXYDnOdFKywZqd9s2kGhQzFsVxrf
	m9F5BGdr0rY8CrSp/DHTgDJ68pccKI6JJDJBxgwWhmjH4pw/m6BmcObydq1wcvoP710IWnGd95K
	4F3JSmuCr8Q4zjxvm3u62CQNZu81PYyVTI2jbkajOCxQu0Gnhmw1WeWB8lN8AtMEqPJp/JacfVq
	bfI9VfbyEvN22Gfef0yXVs8CM=
X-Received: by 2002:a17:90b:28ce:b0:353:3977:a082 with SMTP id 98e67ed59e1d1-353fecc6684mr3570376a91.1.1769582940038;
        Tue, 27 Jan 2026 22:49:00 -0800 (PST)
X-Received: by 2002:a17:90b:28ce:b0:353:3977:a082 with SMTP id 98e67ed59e1d1-353fecc6684mr3570349a91.1.1769582939511;
        Tue, 27 Jan 2026 22:48:59 -0800 (PST)
Received: from hu-amitajit-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2cae91sm1359995a91.4.2026.01.27.22.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 22:48:59 -0800 (PST)
From: Amith A <amith.a@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, amith.a@oss.qualcomm.com
Subject: [PATCH wireless-next] wifi: mac80211: use wiphy_hrtimer_work for CAC timeout
Date: Wed, 28 Jan 2026 12:18:56 +0530
Message-Id: <20260128064856.3667270-1-amith.a@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7XVorGTqS-ksje2vdMsgh2akdtIrHif_
X-Proofpoint-ORIG-GUID: 7XVorGTqS-ksje2vdMsgh2akdtIrHif_
X-Authority-Analysis: v=2.4 cv=N58k1m9B c=1 sm=1 tr=0 ts=6979b15c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=TBLNI4pxKqmck-2k7qYA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA1NCBTYWx0ZWRfXz2QgiwdE+No+
 yjh9Q3n3a8DPcEv0+VyK2kTeA47oXjiAcdDp6LMZEzebm4ae9AAWTsEmYTELfmd5lCIi4fgDF4v
 8EE7dgLedfBV83jXn+PuV0hGKNjop+GZNOONBEUGgsvSLckyYbHBuXLwDK6w5i8TsI8W7Bsm2xV
 VoGmvlXcZuZUzD1teoPs6d3UBQATWKUU1ZqOHr835opZxioGkSiJwiO2tjO+qnF+FiPBaAuA5YX
 BBfl3S8RN8YKKRxUkD+xbzPFeeKR+O1m+aylz1lGWiRpILKRRcHp6mqgPMr8gA/a4Pgrw23DboD
 jz2ybohb53cOSMr4ubqTw0psshlY189xti6wy5LpFL1/ZV5vyqtwPL9IqOl0GQ5CVi9MCQkNOjT
 F7LrEJeoUkQCAN4YkcESK8x3Vc1eJmOlXuyDq2kc95oS7OdSn4Dby98vuOBav4n7lE3muAM2mqP
 DhJ1delltehTjDUe+yg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_01,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1011 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280054
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-31259-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[amith.a@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 17DB19D83A
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
have this timeout latency. The other patches in that series converted some
mac80211 work items to use the new infrastructure.

Unfortunately the CAC timeout work was not addressed as part of that series,
so address it now.

Signed-off-by: Amith A <amith.a@oss.qualcomm.com>
---
 net/mac80211/cfg.c         | 8 ++++----
 net/mac80211/ieee80211_i.h | 2 +-
 net/mac80211/iface.c       | 2 +-
 net/mac80211/link.c        | 4 ++--
 net/mac80211/util.c        | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 964f440e31cd..acec44957040 100644
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
+	ktime_t ktime = ktime_set(0, cac_time_ms * NSEC_PER_MSEC);
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


