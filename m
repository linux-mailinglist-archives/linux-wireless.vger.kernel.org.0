Return-Path: <linux-wireless+bounces-24560-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ED5AEA336
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 18:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B054D1C4546C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 16:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EE5202C48;
	Thu, 26 Jun 2025 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="naV4ZgZQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA271F9F7A
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750954080; cv=none; b=ZwPRl1z+dwnWpfxfByD2i2jxPvE2FBjP0KQYfRl2aOy8tlmryNfxGW59WxbevI8IMAq1nnK4eNRgqKs6I4/1lx9TE7s7WNV7GYBBSv0LSkKU0OldWq72VGowdRPfiIaif694+sSdeCRA5OZnsGEggdfRf+DRacJZnCo319thnkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750954080; c=relaxed/simple;
	bh=zmp4olk32DsmgXvZhBn8fVeD0w/WVRrejG1kOqj+mDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=k+NiCsVdXiG2NGB83c4RuJ0BZoYK7fG7tgPOmX3JzIGDmOtnLzgbMLhT20Oy/WMSUDEJ5+CMf187/QmAIRSvvP0cSxvYlXDSBsIARh+Z3mvz+1PGCkgaTMKQu6xJ/yzCmYCK5ygJ8efjRyuNyRraONi5CVRGbjS65OVaN4ktEho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=naV4ZgZQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9L1l2020637
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:07:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=DC47ykUZWMz2IS0DwWf3U+Iranb6huMeG3vc8GPr1Ew=; b=na
	V4ZgZQjXD0pNTnpdMMW2jYTO8a8ETItQmPDMsOZB0/qY2RhCGBWUHzpS7D7d8Z/9
	+CCMYYFtX9/VHz/VloCkkIhpNLPFgC/APS2uDOWvXEa2lN6Hag8V6vGjpVlxtzZM
	WGPMi/FBXM8fWKOFojY8KhbEl/U7QDBU5kHA5pWGrGwXau5spwXDK0rmsbbCMbBR
	qYs4Urc6js5FIFkY5Wbdeug2rjUYxMEFuLyuOMC+6nZexmVZCZS11gnD4bjr+4yY
	w3kdi+9rtQ+cW6Q9u0tHz4+J2aej3GGioaULNg2GsSMQqiAxygqovvzCPyE2uSpl
	QNGoeNT/3DdYXfhbbgCg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47g7tddvng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:07:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2365ab89b52so10873845ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 09:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750954076; x=1751558876;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC47ykUZWMz2IS0DwWf3U+Iranb6huMeG3vc8GPr1Ew=;
        b=aFjsnu2dwd25/UosoCZgiNSTdjrWrBDDC8UY4+59dgUklkx4voSlFJBQSb/mfNsSiI
         /w/5UQPVEqISZhXSBFxn3UTykFuJpfac4tvGbF5DfBHWwWwy/KIUCdMJQkt1WePJH4pM
         DwUTKy5jOKnkbCCwvLmwaeKuMJmO79p1hIF/55r3HQLHo98TtJtgN7AD5Lpn9JsjoZZC
         MKfxb17hqourWigQiRTmZJna030U1zTdng1g5wayHjVR83nZnCfpRlzlEoHFXHznU36P
         aMBKYsUAXBMviM8r08nYmcuKtzz61n3T6LOzFo8z0ya9QD78DQrPuwFzRqD51YEjvR3H
         ybpg==
X-Gm-Message-State: AOJu0YyxhFKEQfUP/icx2ZVH1rYl9Y5wlWQTmYE5zI+DAtx7mGrCA8Ii
	4Xa6/1Q3WIdf8bVV3g7PkC5iOL0XoEKHJauWQXENwyWTjKGzBnfJ3tq1mtdgdov+pI7KASfFApE
	J24DwGXCvSHjnb2K3erWndb5wBHWq8QQPdbVfFr19M7250/Q9ATxMlEAzbdqZjmjS7AcTUVh8tr
	gBmQ==
X-Gm-Gg: ASbGncvPb+urw5I9TB49kFgGnQTZtCiEgHpdw/0zLz1kPy6EaORzHGLYPz6fKdQ13cJ
	+1a/0Pr+fY9S+Qk/aAwYShSEyOz1RaylxXxJN/uKkFg/y/WE1zfs8IjTN2JJc5fK7HSQ53cQhWg
	7wnVqY9pEEB7agUaYHwwDTNOTpgQEWZFExHf1rEQDGYwblJqmhuYpZq0yclHhprsOaam/7UEf4A
	zPkpVpym7B3GAOmnwlDsXkeYbOcyhdZ+L17PmA3gCxt85l0ZKyepO934LpTyohay8Q542aSDUWg
	GUhjl4v2brdyWa1I8WTgF3dszRTOUH4ADv0SAbv3IU7jbl5Jkct21w87Z2KqlsYfrWXcoDezMcH
	H1imQ7KzjEFQ2WQvHsuc2157DwVom2UY6szuMU0Ag+wB+tsbOYTAM7poF
X-Received: by 2002:a17:903:1b10:b0:238:121:b841 with SMTP id d9443c01a7336-238240f3ad6mr126835515ad.17.1750954076505;
        Thu, 26 Jun 2025 09:07:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqv005QwQlDsQ+/Faa0eirLrU/lZu/CnCfBc8uI/a1qneelzemvFC2FAHSIWCvp56M7XcTnw==
X-Received: by 2002:a17:903:1b10:b0:238:121:b841 with SMTP id d9443c01a7336-238240f3ad6mr126835105ad.17.1750954076076;
        Thu, 26 Jun 2025 09:07:56 -0700 (PDT)
Received: from che-siroccolnx03.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23abe3fa0d9sm1410345ad.170.2025.06.26.09.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 09:07:55 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next v2 2/2] wifi: mac80211: extend connection monitoring for MLO
Date: Thu, 26 Jun 2025 21:37:13 +0530
Message-Id: <20250626160713.2399707-3-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250626160713.2399707-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250626160713.2399707-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=CPYqXQrD c=1 sm=1 tr=0 ts=685d705d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=LKpuYLUdS0qzNSG1YBcA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDEzNyBTYWx0ZWRfX//ecr2/dbrLZ
 ByQPztdDWqPN/TlUxAa9lUFb+oaq8PE1Jh18WNvu7JYS8q1TuGeLyUzSQqoYvqoN0eYt2f9xKjV
 33k5sEqMbw61U6FDMeqQo2OBJAHRyynoWXpFnuG6VH1ffXNJe9P1csc+tSETykK76/+wPEHCERO
 ydVdvzUu2pKEWs46115MleDZckcQnbS6nfxy5yMyqIvFpSGnqxARKFK8pCT3HjqrZqtVUEVhL1D
 Gws8+0RQ0aXudI5wvKw2aNERNK7xjq9r/4tufX1mE0sOPkWzMNDUv6lHwXI4Kxe4vLzluslBsB0
 bTzoOXBkcJAqJ6TMpyoRPdErvRI2skKeY3lM1XRc1DHoUhBfvCppfuPuX5gHc0Cxuos0ar75QDb
 uxDa8DB0wpR6NRO4c2NaEpNbaufsq7GeNpWHPnscas/HowYyAPEiPFjwyJyyPeKRfmb3/9EY
X-Proofpoint-GUID: gZxd7oLSzyrFxucGAS21LcWMNCICNBkL
X-Proofpoint-ORIG-GUID: gZxd7oLSzyrFxucGAS21LcWMNCICNBkL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260137
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
 net/mac80211/mlme.c | 76 +++++++++++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 24 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 57e514de0036..c36dec1851a1 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4297,9 +4297,6 @@ static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	if (WARN_ON(ieee80211_vif_is_mld(&sdata->vif)))
-		return;
-
 	/*
 	 * Try sending broadcast probe requests for the last three
 	 * probe requests after the first ones failed since some
@@ -4345,9 +4342,6 @@ static void ieee80211_mgd_probe_ap(struct ieee80211_sub_if_data *sdata,
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	if (WARN_ON_ONCE(ieee80211_vif_is_mld(&sdata->vif)))
-		return;
-
 	if (!ieee80211_sdata_running(sdata))
 		return;
 
@@ -8447,36 +8441,70 @@ static void ieee80211_sta_bcn_mon_timer(struct timer_list *t)
 			 &sdata->u.mgd.beacon_connection_loss_work);
 }
 
+static unsigned long
+ieee80211_latest_active_link_conn_timeout(struct ieee80211_sub_if_data *sdata)
+{
+	unsigned long latest_timeout;
+	unsigned int link_id;
+	struct sta_info *sta;
+
+	guard(rcu)();
+
+	sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
+	if (!sta)
+		return 0;
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
+		/*
+		 * latest_timeout holds the timeout of the link
+		 * that will expire last among all links in an
+		 * non-AP MLD STA. This ensures that the connection
+		 * monitor timer is only reset if at least one link
+		 * is still active, and it is scheduled to fire at
+		 * the latest possible timeout.
+		 */
+		if (time_is_after_jiffies(timeout) &&
+		    time_after(timeout, latest_timeout))
+			latest_timeout = timeout;
+	}
+
+	return latest_timeout;
+}
+
 static void ieee80211_sta_conn_mon_timer(struct timer_list *t)
 {
 	struct ieee80211_sub_if_data *sdata =
 		timer_container_of(sdata, t, u.mgd.conn_mon_timer);
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
+	unsigned long latest_timeout;
 
-	sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
-	if (!sta)
+	if (ieee80211_is_csa_in_progress(sdata))
 		return;
 
-	timeout = sta->deflink.status_stats.last_ack;
-	if (time_before(sta->deflink.status_stats.last_ack, sta->deflink.rx_stats.last_rx))
-		timeout = sta->deflink.rx_stats.last_rx;
-	timeout += IEEE80211_CONNECTION_IDLE_TIME;
+	latest_timeout = ieee80211_latest_active_link_conn_timeout(sdata);
 
-	/* If timeout is after now, then update timer to fire at
+	/*
+	 * If latest timeout is after now, then update timer to fire at
 	 * the later date, but do not actually probe at this time.
 	 */
-	if (time_is_after_jiffies(timeout)) {
-		mod_timer(&ifmgd->conn_mon_timer, round_jiffies_up(timeout));
+	if (latest_timeout) {
+		mod_timer(&ifmgd->conn_mon_timer,
+			  round_jiffies_up(latest_timeout));
 		return;
 	}
 
-- 
2.17.1


