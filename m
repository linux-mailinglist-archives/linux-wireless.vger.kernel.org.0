Return-Path: <linux-wireless+bounces-23845-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E11AD18CE
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 09:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35971698AD
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 07:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA066280CD4;
	Mon,  9 Jun 2025 07:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QIGEyq6Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE3C281341
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749452615; cv=none; b=H12wlicUSMw4lknpSIkQUFpWa8+v1JfxFIGxxs63+CMZ69u0Wd8mxV/uEE1kHNM5E3uhjQE0L6pdIr/DA1p4QAej4DxIZ1ZemQ1EduNVAm9IzuKVh7DAYh2KSKCuDwyKqNPatZv9C3k5z7HC8WWax8iXTe9Y2L6w77zJnXp+tM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749452615; c=relaxed/simple;
	bh=ZVysk2Vun75dajmyOXZgMZFxXkp4xEOVyVppjYPy4Yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Kx4fmnB+Jpxd98oK+kRdDwXQzQairQ0Vf80l38GziTuW5Sa2GPXeM/kWkaamH70ZbM6KVXoYD1lrEmmc5+1jePH8L020lEcJnMF9cBFB21V25DWn1cGVHmwQ3PT+22lEqnqMbl028eo3sH3HVcJoNgS01LQeCjAwamU5dWnm/ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QIGEyq6Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 558NumkW022252
	for <linux-wireless@vger.kernel.org>; Mon, 9 Jun 2025 07:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=ndEyXxwKHzZxkb9HPoxEYfe0E1x/mv3R/OXtP7yKgUE=; b=QI
	GEyq6YdizxHAJvdT77lVikbNQ/dLrZo1uwp1ah+RPVAaql8pzbUnR1zTRlRLbtjT
	XTW852Jp4M8oWYXOIrpWrrg+tcen76cqt06Z7VbzplMJ76SYAoYOWSH+LZDRyAaw
	s1LFFJ0zTQfDvL9Nrs2YniUO8ytm7AZ1tbn8druE81wazZVv8Ma+rfkeT3UlCEfz
	ehbuTNT15I2GLGkvTuppN7MXRNs04Z7qy9Sbn28dB4zhZx+1lUnF0xgaCxPd0QCP
	9PhzKSyFZ8bYhxFhUkpQ9KVigwLe1YyG4bpGvYyxE1sPrdOFwHHV1WbcdwbhivG4
	WzWM1OW98cODNb0O/Zvg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474dt9n4an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 07:03:32 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31315427249so5040165a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 00:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749452611; x=1750057411;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndEyXxwKHzZxkb9HPoxEYfe0E1x/mv3R/OXtP7yKgUE=;
        b=UjrglBIVPxbFU+tZ8M3I5Zi5mwwv5G6tw62rkZWbRIeYIKqWZ4+An9Wg9mT5CChMb9
         a4hYvDLPod3vs6JSeMvB6fYXxHOhD3+O1T48KFraJ1buZOlqL+5XCBJBTFTHNw94Uk3p
         2NaoirIfEsYcapz7Z+mBzsyjXyUQKLr4TaVIC+8bdNy7mq5EuhnklJB1KwlidZZlLWqD
         63yggpv2HAgkb2XS/wJqKzyo1uBNDwngoqPgIzsZfq5gijDmWd4nGz/tcLohDLRdj/ip
         Qb82WjikPlCMoegJuwJyUs46BHbscvxFBenqCSTWLeFa9bODLatC/LZ7inUOxUJKu0Vl
         yM0Q==
X-Gm-Message-State: AOJu0YxVk4/0zkAcxTiGKCPtXSBp78D0QMcMi+ZFTNn1PEBdNX1evYif
	67zKWorSQQXqgr2inGtRCcOA4l4ozEuf+5vsVfZYyFg91WIxzZIz/lkG5orJ0gIfixnukWk1qfJ
	RlcY/mlCi15HWyOLO0AZu5h+VL1YxjrJ36EX4enKI9lg+vPdtQugG1AzfA1BujUeIKGV7ug==
X-Gm-Gg: ASbGnctlPdgDhcArXxg2ch4GvUM+SPLE1OGvkdsk9a5VEoD7uUyf+WpNougs5Hmnk4L
	ASOQL115H/3AR/CAZnyF8rz0c83rt6R9xgIomvCHsbyMc0AN3Ct0tlNZTN3WWkowCx1gvwNtN3q
	TaOsj+7juL7jLqepWk/f2HngdbuVs1jpB1FAhmmrpGC5hVoq0y0IzoVKVTC/yr0VhNT19kPiET4
	vKJoXpJlXRq63ZGSTW7WgGT3i7m/AE/YQEHgJV7BHa56sHBbSZRYWe+S3xpB088rrAAGQK0C1NL
	qGqB+ZUabs35sIM0BOIgVtzfbs3y6dLAzt/xRFvdhPUux/ITsJhVvpqDE1gd8NmyULu6H9hv1NR
	VkB4qUUQZAwax00qwF84e6W8fVOXxO4wcNDfQxqNYvFcZJQ==
X-Received: by 2002:a17:90a:dfc3:b0:2fe:e9c6:689e with SMTP id 98e67ed59e1d1-313472f8a61mr18100394a91.8.1749452610892;
        Mon, 09 Jun 2025 00:03:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/+E3DxUiWOImebCzrfYm9KFH/fDuimxSDUNHRDL5UTn0t2QZYCraYgw7/2iJm8LWZFxQ0Yw==
X-Received: by 2002:a17:90a:dfc3:b0:2fe:e9c6:689e with SMTP id 98e67ed59e1d1-313472f8a61mr18100359a91.8.1749452610402;
        Mon, 09 Jun 2025 00:03:30 -0700 (PDT)
Received: from che-siroccolnx03.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236034050a1sm48592145ad.145.2025.06.09.00.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 00:03:30 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next 2/2] wifi: mac80211: extend connection monitoring for MLO
Date: Mon,  9 Jun 2025 12:33:19 +0530
Message-Id: <20250609070319.1033874-3-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250609070319.1033874-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250609070319.1033874-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=KpNN2XWN c=1 sm=1 tr=0 ts=68468744 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=LKpuYLUdS0qzNSG1YBcA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: VBBdiJLi1Q8stL0KYlHr79F0-X3XOHfV
X-Proofpoint-ORIG-GUID: VBBdiJLi1Q8stL0KYlHr79F0-X3XOHfV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA1MyBTYWx0ZWRfXySqScggzOx6K
 mdde/Ur1a2w76tvUsXYj5M1o6SGXhMl9DqDEPRh4O20aauATb0uL37SA53weHLBgR4Re4iW/qmj
 Q63jNolc5Q4T6NfI294AzbmP6k8DvnXlw+Z6BlXOv0ju8h06ILOsyGYvUtjIe56RIovCd64PVaY
 eMrCINOzm3OXe7ibX5NaOV5SW6jg1SpDVaaDBCLDCFd0cfc554B1+T0YErloEZrZ3Xwz3tu/VEB
 4WBQYnT6mpskqg9be0nP78Uln9lMAN/5aus/29VgnXN3fhXhUopIuCc2Tt/LHqkeI1yqJGvQ7Xv
 PWZRn+s2U4HzUU4Jb2FeoXtRVacUCnaPHqVkdIdAExUqgdPYq9Zj6OrTfX9bRys3i86VWaE+02K
 akBHMqmH0PEXCZsmC12TrqJbguGLmuUVU31eL3mdi1143Ja5nKi+FOi6yzgbRT0sxVyvpzif
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_02,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090053
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Currently, reset connection monitor (ieee80211_sta_reset_conn_monitor())
timer is handled only for non-AP non-MLD STA and do not support non-AP MLD
STA. The current implementation checks for the CSA active and update the
monitor timer with the timeout value of deflink and reset the timer based
on the deflink's timeout value else schedule the connection loss work when
the deflink is timed out and it won't work for the non-AP MLD STA.

Handle the reset connection monitor timer for non-AP MLD STA by updating
the monitor timer with the timeout value which is determined based on the
link that will expire last among all the links in MLO. If at least one link
has not timed out, the timer is updated accordingly with the latest timeout
value else schedule the connection loss work when all links have timed out.

Remove the MLO-related WARN_ON() checks in the beacon and connection
monitoring logic code paths as they support MLO now.

Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 net/mac80211/mlme.c | 79 +++++++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 25 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 927fbe6f12f1..6a3ef574fba5 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4294,9 +4294,6 @@ static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	if (WARN_ON(ieee80211_vif_is_mld(&sdata->vif)))
-		return;
-
 	/*
 	 * Try sending broadcast probe requests for the last three
 	 * probe requests after the first ones failed since some
@@ -4342,9 +4339,6 @@ static void ieee80211_mgd_probe_ap(struct ieee80211_sub_if_data *sdata,
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	if (WARN_ON_ONCE(ieee80211_vif_is_mld(&sdata->vif)))
-		return;
-
 	if (!ieee80211_sdata_running(sdata))
 		return;
 
@@ -8439,36 +8433,71 @@ static void ieee80211_sta_bcn_mon_timer(struct timer_list *t)
 			 &sdata->u.mgd.beacon_connection_loss_work);
 }
 
+static bool
+ieee80211_is_all_links_timed_out(struct ieee80211_sub_if_data *sdata,
+				 unsigned long *latest_timeout)
+{
+	bool all_links_timed_out = true;
+	unsigned int link_id;
+	struct sta_info *sta;
+
+	guard(rcu)();
+	sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
+	if (!sta)
+		return true;
+
+	for (link_id = 0; link_id < ARRAY_SIZE(sta->link);
+	     link_id++) {
+		struct link_sta_info *link_sta;
+		unsigned long timeout;
+
+		link_sta = rcu_dereference(sta->link[link_id]);
+		if (!link_sta)
+			continue;
+
+		timeout = link_sta->status_stats.last_ack;
+		if (time_before(timeout, link_sta->rx_stats.last_rx))
+			timeout = link_sta->rx_stats.last_rx;
+
+		timeout += IEEE80211_CONNECTION_IDLE_TIME;
+
+		/* latest_timeout holds the timeout of the link
+		 * that will expire last among all links in an
+		 * non-AP MLD STA. This ensures that the connection
+		 * monitor timer is only reset if at least one link
+		 * is still active, and it is scheduled to fire at
+		 * the latest possible timeout.
+		 */
+		if (time_is_after_jiffies(timeout)) {
+			all_links_timed_out = false;
+			if (time_after(timeout, *latest_timeout))
+				*latest_timeout = timeout;
+		}
+	}
+
+	return all_links_timed_out;
+}
+
 static void ieee80211_sta_conn_mon_timer(struct timer_list *t)
 {
 	struct ieee80211_sub_if_data *sdata =
 		from_timer(sdata, t, u.mgd.conn_mon_timer);
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_local *local = sdata->local;
-	struct sta_info *sta;
-	unsigned long timeout;
-
-	if (WARN_ON(ieee80211_vif_is_mld(&sdata->vif)))
-		return;
-
-	if (sdata->vif.bss_conf.csa_active &&
-	    !sdata->deflink.u.mgd.csa.waiting_bcn)
-		return;
+	unsigned long latest_timeout = 0;
+	bool all_links_timed_out = true;
 
-	sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
-	if (!sta)
+	if (ieee80211_is_csa_in_progress(sdata))
 		return;
 
-	timeout = sta->deflink.status_stats.last_ack;
-	if (time_before(sta->deflink.status_stats.last_ack, sta->deflink.rx_stats.last_rx))
-		timeout = sta->deflink.rx_stats.last_rx;
-	timeout += IEEE80211_CONNECTION_IDLE_TIME;
-
-	/* If timeout is after now, then update timer to fire at
+	all_links_timed_out = ieee80211_is_all_links_timed_out(sdata,
+							       &latest_timeout);
+	/* If latest timeout is after now, then update timer to fire at
 	 * the later date, but do not actually probe at this time.
 	 */
-	if (time_is_after_jiffies(timeout)) {
-		mod_timer(&ifmgd->conn_mon_timer, round_jiffies_up(timeout));
+	if (!all_links_timed_out) {
+		mod_timer(&ifmgd->conn_mon_timer,
+			  round_jiffies_up(latest_timeout));
 		return;
 	}
 
-- 
2.17.1


