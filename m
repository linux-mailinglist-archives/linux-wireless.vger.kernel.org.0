Return-Path: <linux-wireless+bounces-25636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5029B09B23
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 08:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6F03B2ADE
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 06:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2798217578;
	Fri, 18 Jul 2025 06:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ffq1RTW/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7278A1E8322
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 06:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752818951; cv=none; b=pV5r4pipnqgSelD9/yHzHSr/0vX/D52DJgAhOB1ilJ5LBkJy3AcPXQ1aXGWsUlLQjv1cgLkgJfoAQoNaCl/Ux2/St9b+REUbyCxD1AFxJhXOP962Wh2pi3vmIrRJ9cwSbxO7kieWVMww663OEOzUpu7G98TYVyimV5vpSy2rekA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752818951; c=relaxed/simple;
	bh=tlUGLgWpLnVf0wskfSymo8ElCH/g6mWup4ALuXSqDEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YsT23zf0/3fQe1RpQAHy7gG9x8h7gAEoH9j6gMQ5yk1Fd0Fz1m3hPufpx2Zv67LZlSm95BiJoAdCD0dX8FlNPQgPXaqOV1sfE4EidDYcr20SiyTJ7uDqzxN/YHJKgV5+otu2bdWh/mEc23AoRzuU396MU3DxPy0bUXnY5DTZ12U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ffq1RTW/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HLcWC2008502
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 06:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=wJnl1dSCiyjJyYi3gA1KZqVsGdAkX5UHi6aJOH3A0mQ=; b=Ff
	q1RTW/3e36l/S4roVvE/t6jNU54TgysgNN6bwpEB7dgF8xpmaf7akT8JL+ixy1yZ
	PeQ/mrkPotseGkEc4vVHgNam7m6MsHUyJxWHR6BUSAKOl7ihKgvNx6Xc2SSxRYZI
	BOsx64cfkLNjtdISRwp/M7Q8nb2ITu4y55mKhlXGZMEX73KIMX43qbAQhwuqtRi9
	XeAtohGVFDMiM38DfyfaAsMVopFUvGOf21GjZZsi1MV6U91yLJ9ZC3l4OnMqVfFn
	c5YLqB2RD0fYrBct25hVxZEsfRH3mf8w2kxLjxgwfuXPPQ8J2gcP4Wi5+YjIY2tg
	+eR5X9KBBl6nzTAWfMqQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxbabru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 06:09:08 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-754f57d3259so2516748b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 23:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752818947; x=1753423747;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJnl1dSCiyjJyYi3gA1KZqVsGdAkX5UHi6aJOH3A0mQ=;
        b=BFwvpTbKXQ1rT3Xrv5EwG/wjbNe17hQF/sUkM++YYoBvgn/DyoOz5Wqy6iEsXUVF8r
         tuHZtIunR6oXs6B9mCA7SR3KnjEmJQ2BDHgUPU5tJ3ZQgN+AToab6u4zV1Ssx2kPREVJ
         y98GexxMM7775/syxSI8nY6/k6BYu1EwmnbaipcfBAGLK3I/EBw3mEqQWKRJFyrcE5vB
         LPM8GNOwFNbGzbM+YTFK2E/ti/+OITAZRdS/6oQsHyXBEzSjgTM7qvVXRG+4iPyv/mud
         xzA8cp+RrLndQE2pg6wTZzKhXFVRY3nt0LiKdoEgK+98g4XK9nAWF7sAr6SKx57OOvQC
         Umuw==
X-Gm-Message-State: AOJu0YzIocvaySCqchqPt4GsLiP46bHMsjQcWxtqZlO8vQ47cGnLGa9u
	rPyQJgPVeM6KNtAMWeRsVaDldpzsqHzy1Tw/glfMBnDBn607sChhKKTPRJ2AbkozTwZnuLMQ/r4
	2FIUrMcK/8RkwCRm8Mo89aiopWE6yMsTf4g4vJnxE2jKL1hIZ4mAvpuuqoa6Bq0wsuRiryQ==
X-Gm-Gg: ASbGnctrAtRgJ0v4rfAEFQphvf0R/rF/LVPsOYSh+RKm/hhIht4QUKW3UlXvmAwF8hA
	C6dcKNtXfLK70CNdCFsNyYYHyMdNGk9NsYCUg0vHOZYV6PwowBW+mx+gYKYCTsor2SDiVpV3ACg
	7iiXMUZZEwvq+vDsO95x2KROEMJ4pZSvUCofpV1snW4uR/Hpdc9ky7tMtEML+EnJJaGUQlJ/SnU
	jkFrWexuo3P76SzU+U+6tn0t+2XYhXVAKzC86izTnxxgkjUfpit0X5I43v1eMEWMDCy1qPpUwdh
	/uPa+nZgfcTynHEO3TxbTw7J/5FT6Crd62Y9Qvva8HFEIdgbWTWepZSw2VUjcINY7ufJTCgS9By
	F4uynaKE=
X-Received: by 2002:a05:6a00:4b45:b0:746:26fe:8cdf with SMTP id d2e1a72fcca58-758492e296dmr8543622b3a.7.1752818946825;
        Thu, 17 Jul 2025 23:09:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErAAazyrgMNDt14piUwkypC2MF32l8BjJL4ReFNMloM+f+ZiBoUe9sJOa476bI7r080MuIyQ==
X-Received: by 2002:a05:6a00:4b45:b0:746:26fe:8cdf with SMTP id d2e1a72fcca58-758492e296dmr8543588b3a.7.1752818946293;
        Thu, 17 Jul 2025 23:09:06 -0700 (PDT)
Received: from che-ventolnx02.qualcomm.com ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e26d0sm531236b3a.8.2025.07.17.23.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 23:09:06 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next v3 4/4] wifi: mac80211: extend connection monitoring for MLO
Date: Fri, 18 Jul 2025 11:38:37 +0530
Message-Id: <20250718060837.59371-5-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250718060837.59371-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250718060837.59371-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Proofpoint-GUID: 3aTRS1t3_OwOmcf5Gr20wE_mpRk4EKlP
X-Proofpoint-ORIG-GUID: 3aTRS1t3_OwOmcf5Gr20wE_mpRk4EKlP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA0NiBTYWx0ZWRfX+6HfDxm+XohT
 yliGwi7d7LCfPohNwS3pBJMZi1fHIiujWs/0ODH9YRoj8fHGpHLu5CdioLHoMoIp9xUnv8xKvrv
 d8pyVmHRFVn0PiTVke0X7DmcefMBLqsnHaKkb2NOMVRC5JG4GAqCvLDmHof5og8mdMWdg0ircPz
 BZ1y2v3FCG2DrmN/nVK2vmyiVYBWaULadcWW5OhIyzBaQIlkSigw5RHbHJPq6IL1uzVrrS1OuyC
 FYJNYLfKE9SV+wG9Lzp7cA6OQX+jrLro2pUU0pwCo3Y5jOTfBGaYVrXjwppOuyeTeZJwlWskys/
 6E2Ptx1ywD3wuj2ME7rFcJ4jlWHQYIRIKoKHM2ZQgoaRVCY6KKfX/JBYm/AZY+Qm0S5lHe/C6mk
 MIoFbOZHO5aifzGW9zz2wa+lRt0o3AIpLc5bZRlxUNtaCk7F/7y4ex1TqfJzKoLsrfbts433
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=6879e504 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=LKpuYLUdS0qzNSG1YBcA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180046
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
index 86b69bd94b4c..b4b7ea52c65e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4367,9 +4367,6 @@ static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	if (WARN_ON(ieee80211_vif_is_mld(&sdata->vif)))
-		return;
-
 	/*
 	 * Try sending broadcast probe requests for the last three
 	 * probe requests after the first ones failed since some
@@ -4415,9 +4412,6 @@ static void ieee80211_mgd_probe_ap(struct ieee80211_sub_if_data *sdata,
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	if (WARN_ON_ONCE(ieee80211_vif_is_mld(&sdata->vif)))
-		return;
-
 	if (!ieee80211_sdata_running(sdata))
 		return;
 
@@ -8524,36 +8518,70 @@ static void ieee80211_sta_bcn_mon_timer(struct timer_list *t)
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
+	unsigned long latest_timeout;
 
-	if (WARN_ON(ieee80211_vif_is_mld(&sdata->vif)))
-		return;
-
-	if (sdata->vif.bss_conf.csa_active &&
-	    !sdata->deflink.u.mgd.csa.waiting_bcn)
-		return;
-
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


