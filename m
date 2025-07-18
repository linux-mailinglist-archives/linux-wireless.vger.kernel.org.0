Return-Path: <linux-wireless+bounces-25635-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B7EB09B24
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 08:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95D61C42E58
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 06:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421311DF994;
	Fri, 18 Jul 2025 06:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z2rTVZOJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA9517578
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 06:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752818949; cv=none; b=VAi4a9GQbLF6Zg6c+aXzfG9QhaDV1Yy6IExGJR5hoA+tIBugtC809fD8GA4HPUY1XMQbRg0x3XSqZX21Y/jVhRRZlU6OBSXtjmVlrHpsXybTeBZ0iLxKSDQgI3mDnn4DQOo+6GHDjNd6rknQif0lnD6QwsiaLzAvfPtzCE1y+sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752818949; c=relaxed/simple;
	bh=n/s4FtwaXf3LvkAr8mSFrEOB0B2A1YTUjWV9/UymQ4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TaZ3+3xJ5CjBYG4387VXuRWl1x8YAkZoBHLlo84jw0WwKsM8yyX+OnZqwu3QKTQngKkJXXFmlVjnSK4ysEdWGN1LqbXLzTMPxDzDCuz+77oCZf8RavHvRtPDl56fAFWDI9IKYGLyA+93LENsNf38++qQD/ATBDwu+9zetF22N0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z2rTVZOJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HL0jcE030488
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 06:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=6V2IguxMRDPCUUGxvD1gKnxzhhOCz1su/yieXVO21kU=; b=Z2
	rTVZOJuyjIJTV9e/XBC/YQZMoY/aoi7YQHdK4WikgC1lYetOP3KHaEiTVidZgu5V
	qxZj54MursM2nrVg6Yy7llzVgTPuuPtzkndoAw48cJ/DnWWlzh+mMhmlRSGc04Xw
	7Z7L+mDJks5sntDw1lkLP+/gv17nd5HZIkLAIm6i0eoLmztrhq5/xjjl5WcQjLts
	9NbLlCAwQ391i9/qJwEstIIGmtudAZUlIC3rk2gMT5YSKQJKxUSjGE7oX+oqYpux
	jR8zOh27WR9dBhHLGxPU8nli0gu3E1odxirWzR8b7wdAn7we+lUy7Uhw4Fgf6NFf
	jJOlyvx7f8WRCjtYXy/Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47x8x7q62r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 06:09:06 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74d12fa4619so1658484b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 23:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752818945; x=1753423745;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6V2IguxMRDPCUUGxvD1gKnxzhhOCz1su/yieXVO21kU=;
        b=Er8G8ofHNKCn5mw2LMhimTSUcUgjDiMXs7gKl4cbDW366yFmZoyIHyUri0wPmSs3LI
         Zd+A3GpEr0kNhYlv+8vH5TtGACZJUFlbnh+HGsgYEyGMpdPey8DEXASwQ2/T/lNv+t5q
         jPmSs6ksELlH8ncmvVdGGgvnozGuU7ZMzYGOl7A6yPRnHAa33G5LD2PXTz2wv7yIj4TN
         HmiewWC/mm9hBpf35hYP1NB/Z1DNcPv+ycvJSq2B6rI8oufC1Y6++njamKC+yEKFwSrD
         b8tCBNMTmBAft6HwfYL1IQCzUNQ+c5jOODuE9IoWzvH8qkJ1mkZy0E2WppQLgjGWvWOf
         baeA==
X-Gm-Message-State: AOJu0YzOvTUCEKNKbOUZaMuv7K9mYdI5OxCj6/C+kFSE89+CfIBWYFMv
	Ti3DWKw8h9JFDB258zTduWCTBkKEMKNG+RYI8BnM8LIABINKuVmK9u0QDklDfGznt3SN0wBWyoM
	Y/2xwkNyFje9hM2hn9dsFtsxho2KR6I+ATLwif0LoOdwbW7lGNdlk0lhJLvKZyPwhZT7YbQ==
X-Gm-Gg: ASbGncsGVcW01VLNW3e+yWi9CgW19YtVOIpLdZWgaLBgk1QdvC9QHKdeWCAfBSYETCp
	ku8qAwALkAs3GprNyVOQSwU0G/uLKxFaJgfy/h3k3vjirdWiCnShf2rMFCXH/eu4AgfyulzwO7e
	K64HIHT70Kmj+YTB9oFqRnGC58NIlCvj6loI4zQTgW3L4+Wm5SahngF1rx2W18DS/6tPwGpJT3m
	W/CVHgC7UwujEbrshWMdtu6DME6ObmEioPoNQXSlJzxLgl7RGl1w4rj5MW9fiZCKTQbUPlSh/9C
	NSsrw8afvWlxlnYGQtaxYL37nTxJdIcG2ki0fVcuL2kiHM+qwK13K/kuHFWJr+gjcqmnbFMN9KG
	IAqsUyB0=
X-Received: by 2002:a05:6a00:b52:b0:748:f80c:b398 with SMTP id d2e1a72fcca58-759ad4f5f17mr2011563b3a.15.1752818944814;
        Thu, 17 Jul 2025 23:09:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/cVuedHxGfcLGXagTm9evTtsjdEPKK6a5ia1sdkCwZuuRrw42BHW4XAFDf1mfjXnpst165w==
X-Received: by 2002:a05:6a00:b52:b0:748:f80c:b398 with SMTP id d2e1a72fcca58-759ad4f5f17mr2011535b3a.15.1752818944318;
        Thu, 17 Jul 2025 23:09:04 -0700 (PDT)
Received: from che-ventolnx02.qualcomm.com ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e26d0sm531236b3a.8.2025.07.17.23.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 23:09:04 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next v3 3/4] wifi: mac80211: extend beacon monitoring for MLO
Date: Fri, 18 Jul 2025 11:38:36 +0530
Message-Id: <20250718060837.59371-4-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250718060837.59371-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250718060837.59371-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA0NiBTYWx0ZWRfXzZ8kqwxH8ak3
 5wq4S+pHy97EoXV1tb+CJF2+zXqOnDXo2y9Ok1on7gJ/F7A5DJ0Om0zanCrSW6b/8UsUfwKnpJB
 C4b5ajfOUO9xlkPtDHTYpo1o6zfY9gClZIddJvD7H/zc1FJZZhtdI1i/j+wGl5QlCvm00WKt0U0
 orfWuoMtOiIC6bClDqPWr3FGs69FFt63WdIWfjzHPdYgGQkIvaTk4SPB4x8QdRgBhxR/H4QmIN3
 rfHGBzNauH74vTTopR1s383xEEdOhg+y0CLs1HCeGP1iE9fhAXi0kznX7GELp+hxe0derVMxY2x
 S7qZSij8hhzJcczR3B3A20NIO2yRF0NVJKcb6L88RDLKwLEqioq5f/iYV5spzvHHnqVc++7uBTU
 rnAhJq66D1hhpUSMPzvReX5+SE+RnTM/aNvVN7sxUuG1RFrbdZ6j0eMNGOUcPHUi0auQ+i9m
X-Proofpoint-GUID: BerFOsdPi22phzUIF2CPXw0XsegZmxfD
X-Proofpoint-ORIG-GUID: BerFOsdPi22phzUIF2CPXw0XsegZmxfD
X-Authority-Analysis: v=2.4 cv=N9YpF39B c=1 sm=1 tr=0 ts=6879e502 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=eANRQvAV50QnJ_dsQ2sA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180046
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
 net/mac80211/mlme.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 5298dbbb5341..86b69bd94b4c 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2505,6 +2505,21 @@ static void ieee80211_csa_switch_work(struct wiphy *wiphy,
 		}
 	}
 
+	/*
+	 * It is not necessary to reset these timers if any link does not
+	 * have an active CSA and that link still receives the beacons
+	 * when other links have active CSA.
+	 */
+	for_each_link_data(sdata, link) {
+		if (!link->conf->csa_active)
+			return;
+	}
+
+	/*
+	 * Reset the beacon monitor and connection monitor timers when CSA
+	 * is active for all links in MLO when channel switch occurs in all
+	 * the links.
+	 */
 	ieee80211_sta_reset_beacon_monitor(sdata);
 	ieee80211_sta_reset_conn_monitor(sdata);
 }
@@ -8473,16 +8488,32 @@ void ieee80211_sta_work(struct ieee80211_sub_if_data *sdata)
 	}
 }
 
+static bool
+ieee80211_is_csa_in_progress(struct ieee80211_sub_if_data *sdata)
+{
+	/*
+	 * In MLO, check the CSA flags 'active' and 'waiting_bcn' for all
+	 * the links.
+	 */
+	struct ieee80211_link_data *link;
+
+	guard(rcu)();
+
+	for_each_link_data_rcu(sdata, link) {
+		if (!(link->conf->csa_active &&
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
 		timer_container_of(sdata, t, u.mgd.bcn_mon_timer);
 
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


