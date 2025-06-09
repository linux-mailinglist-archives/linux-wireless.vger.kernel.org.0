Return-Path: <linux-wireless+bounces-23844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E7CAD18CD
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 09:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84CCB3A8243
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 07:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE7425A353;
	Mon,  9 Jun 2025 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mptDO3iE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA5027FB38
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 07:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749452613; cv=none; b=j7+o2aGt8OJp5oVILgz25S6csBJPQXzCADp0ridZ/RZKlZogLuVve8o6cXj66eFqfxmdzGoZBRiw2rUaBdIKIPisVJnFo2HNTZOv7Ayc1UmOnrYOyG8qnDM1Y/poqGcK6euqJbrl6NdPbB1lBs8VYim08z1e7E9Tk5Ltur73CLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749452613; c=relaxed/simple;
	bh=iWM9lzGpuRAiOGjODpXk0wzzjYAP8Og8FQzRJauU2G0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uYfGYQic8CwlqXXc5K2pMDCa/1DToeFrkeP+fMcav3T/29QkOaAyWwyWbmu2yNWBYQKMKFad0tBnM4R5411GEaPDXqkrC4s6Z6GYt6882H4io8d9ZH/s0gfH8zXxxSTZgpJGqxT0ukPXQ4BAmlbl19nOcsZpIXkne4xSneKd7W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mptDO3iE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 558MtGDd029980
	for <linux-wireless@vger.kernel.org>; Mon, 9 Jun 2025 07:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=TkHniuGwhATtjmRCx0mJ+lmqn6aiPxC7tNahdgCEHD8=; b=mp
	tDO3iEyOQG6xck8//jCJ/2zkBVEMA/WGpEveszdhcoemGFLaxQ0kwdusMRxd1Ya1
	icKFiXtj4pjV4NQix94rcklDxsS1qBeEcu71CMcJNamDmkDtA3R8rvtsGxiwC8Wd
	vTwl2ixC+eKcPjjlqOLQigpro2blu3/rnncubWQNystC5Xqc3xTIrCXaDgK9SFhd
	nya/ZCaoxivRAtss82aBjEI0P468lJgqeCO2SR7f/yoBzgtIUnfwsOscQ++pvk2P
	BPNUxwK9Bnj+matPrgxz7MXXHZI494Od8Atub3lM0HpiD9K/JTUtv3K8HG2eX2A2
	ixKfVFzRw7Dv58GYNGQQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474ce9n80b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 07:03:30 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2355651d204so37291865ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 00:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749452609; x=1750057409;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TkHniuGwhATtjmRCx0mJ+lmqn6aiPxC7tNahdgCEHD8=;
        b=tGyRwBfkd/yTjki9R+Pn2Jr219LXOTRXXIMG0i64iWzdH0bAp+UZ1EdDCuvrAmOfEw
         VPrDx+FKr1TIZt296jmYDNDVNNrl6AllQE8sKZLfsuAGY7Lb7E+O4XFLeHzmg/0JC0UK
         CyWxz5OxNA0Th9eHEOyuF4ApeN5g5g0Hg/F4DjuPyouiExp6BjKXfshtR+ObpBBOTGtb
         p9PfOBuYFX96kJXjPH1NzruJbIqfSnKg60NMO2UQ98a73aUkkKpWdpbkSTDSagKzoQN2
         PEU5qJLk341SU68nD62vhQDEih8Z1fLFlUo0/hwZKMIYGUOF+pk1VodrQRIc5JwhJVvs
         4RDw==
X-Gm-Message-State: AOJu0YxXSrVBT6wDxjDZ7AN7f+MpXCTYzshaNMsogTWRbvF+an91HpYF
	IkOMR43an6Ni3UnxXbaDO8HGsXiJLlRJZVGGZh609hTnrSENwLm0/fArU9h5Kj0iV+gtqKhBIip
	pD7jTM7A2mQv7N09pftRKOjfG6+K1kDai5pF3Dc7j8++Lmh4aBUqdTbhgo+nAq08FB9mksA==
X-Gm-Gg: ASbGncucvXf0JFY2ljiFHyrazSj8lchn1YYuknJFj8Jbs285rbXBXOeJISu3Z0aPFas
	SikWQzLq40VttxEtebv6ZlP6J38SE+6HTv+W6NFjYh91GkSiStc9my8VsHKXG7it5atnwYUeqHP
	y5ZQhyctIP83iXPUFMVUZDJ+jAJVvNgl6sFofVUtjpy5dAGjl0M1RrrS5tK/wf2ZjC+kNrfUbSQ
	NJLv+39rCfBAKmB69BJtNCN660weccrBgt/jEoaKBjq0izWdK1jGTwcQk5m7gcLHcIQ7qW+TIEL
	KcfvZxO90p06jiH7qw50uTRJBa/H+EF/Mg/h5tjvXwa0Qvo52q0yS3yzTs+sKqlbLK7h2ILQowP
	jLWD6odTleu80DMg7Pqp3kpsIV0k4T19SmkAVEVA0O8WW/w==
X-Received: by 2002:a17:902:f712:b0:235:e1d6:4e22 with SMTP id d9443c01a7336-23601e4bf08mr149124245ad.18.1749452609132;
        Mon, 09 Jun 2025 00:03:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFHLKxmEWWDPJZnVLwkZ8Lpc+fNnHutzIj+6ajKGEmg2rxhZmOJC+93MV0tgWdvT32Y4Sc/w==
X-Received: by 2002:a17:902:f712:b0:235:e1d6:4e22 with SMTP id d9443c01a7336-23601e4bf08mr149123995ad.18.1749452608731;
        Mon, 09 Jun 2025 00:03:28 -0700 (PDT)
Received: from che-siroccolnx03.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236034050a1sm48592145ad.145.2025.06.09.00.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 00:03:28 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next 1/2] wifi: mac80211: extend beacon monitoring for MLO
Date: Mon,  9 Jun 2025 12:33:18 +0530
Message-Id: <20250609070319.1033874-2-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250609070319.1033874-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250609070319.1033874-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Proofpoint-GUID: x-7J75MM1b5r6vxUSO_tz0E_7-L0JaAE
X-Authority-Analysis: v=2.4 cv=drjbC0g4 c=1 sm=1 tr=0 ts=68468742 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=eANRQvAV50QnJ_dsQ2sA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: x-7J75MM1b5r6vxUSO_tz0E_7-L0JaAE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA1MiBTYWx0ZWRfX6vN1XbsKZq+Z
 2kj6LI/qOTeOCu7kNu5xL0Uy0s1yJa1h01CBXgMG+c1kETem6b0sbOuIBvr8Lw+0ogXf9jny/nt
 Ovtd2tbtg6eIILc1AlRVEWjfLoZiV15DqR0RSiXa7k75Da3bi27vfEzUCmXJTKUOVaWs9IF+h0d
 viAiPUA84bBsuie1AdgGYNP3XgfV3mJfMfTLIOQfV4tiFxdbypJzUngvtKHwNBPct16Q4k5esPA
 4AjBNSb1niurO+3FacsxS2NIds4Ly39eflCss5Y55tMX28LfUk+GB+AvR6vzt0ip5JDb8vCeYbo
 WhWpGv1/pR07Fja2m0eHHkyEMTdXsyTDZGrsrXcSz+L0ntN8q7OA27W4IvYKh1IbaJSimI79mTi
 EfHTld2+SAJWN3/gjO9sYX7vDGd56cM89c+Cm0E72o81hZhg1hgauViQx9HQqbTlPlnqAZcC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_02,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090052
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Currently, reset beacon monitor (ieee80211_sta_reset_beacon_monitor())
timer is handled only for non-AP non-MLD STA and do not support non-AP MLD
STA. When the beacon loss occurs in non-AP MLD STA with the current
implementation, it is treated as a single link and the timer will reset
based on the timeout of the deflink, without checking all the links.

Check the CSA flags for all the links in the MLO and decide whether to
schedule the work queue for beacon loss. If any of the links has CSA
active, then beacon loss work is not scheduled.

Also, call the functions ieee80211_sta_reset_beacon_monitor() and
ieee80211_sta_reset_conn_monitor() from ieee80211_csa_switch_work() only
when all the links are CSA active.

Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 net/mac80211/mlme.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b84150dbfe8c..927fbe6f12f1 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2439,6 +2439,19 @@ static void ieee80211_csa_switch_work(struct wiphy *wiphy,
 		}
 	}
 
+	/* It is not necessary to reset these timers if any link does not
+	 * have an active CSA and that link still receives the beacons
+	 * when other links have active CSA.
+	 */
+	for_each_link_data(sdata, link) {
+		if (!(link->conf && link->conf->csa_active))
+			return;
+	}
+
+	/* Reset the beacon monitor and connection monitor timers when CSA
+	 * is active for all links in MLO when channel switch occurs in all
+	 * the links.
+	 */
 	ieee80211_sta_reset_beacon_monitor(sdata);
 	ieee80211_sta_reset_conn_monitor(sdata);
 }
@@ -8385,16 +8398,37 @@ void ieee80211_sta_work(struct ieee80211_sub_if_data *sdata)
 	}
 }
 
+static bool
+ieee80211_is_csa_in_progress(struct ieee80211_sub_if_data *sdata)
+{
+	/* In MLO, check the CSA flags 'active' and 'waiting_bcn' for all
+	 * the links.
+	 */
+	unsigned int link_id;
+
+	guard(rcu)();
+	for (link_id = 0; link_id < ARRAY_SIZE(sdata->link);
+	     link_id++) {
+		struct ieee80211_link_data *link =
+			rcu_dereference(sdata->link[link_id]);
+
+		if (!link)
+			continue;
+
+		if (!(link->conf && link->conf->csa_active &&
+		      !link->u.mgd.csa.waiting_bcn))
+			return false;
+	}
+
+	return true;
+}
+
 static void ieee80211_sta_bcn_mon_timer(struct timer_list *t)
 {
 	struct ieee80211_sub_if_data *sdata =
 		from_timer(sdata, t, u.mgd.bcn_mon_timer);
 
-	if (WARN_ON(ieee80211_vif_is_mld(&sdata->vif)))
-		return;
-
-	if (sdata->vif.bss_conf.csa_active &&
-	    !sdata->deflink.u.mgd.csa.waiting_bcn)
+	if (ieee80211_is_csa_in_progress(sdata))
 		return;
 
 	if (sdata->vif.driver_flags & IEEE80211_VIF_BEACON_FILTER)
-- 
2.17.1


