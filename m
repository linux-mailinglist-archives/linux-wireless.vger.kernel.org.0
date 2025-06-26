Return-Path: <linux-wireless+bounces-24559-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4964AEA339
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 18:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0238316DBF6
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 16:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BDC8632C;
	Thu, 26 Jun 2025 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R2sCYqT2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEBB1EF36B
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750954079; cv=none; b=fU1vkCezvtrXf0ZBTsbsPJAb/GyXZ6eI8gCtaRMZGfHvh1PEHiJ6AnTZicujAIxl5ZD7bXCioWKmZkjeM1k0dWgdn8N31AO26EuBf3Cu8O2lc5MBNbK6iUyMhyJnJyZjK3CS4ifeauEhajDjkko5Fu8DyPv5ui3j5qzKO4zqNjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750954079; c=relaxed/simple;
	bh=lCC8VlGHvpd3+LcSg+meYWvAf5HWXkeG6Gxdj66+/6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bJ4YtEQWnkVVcFMMvVmsfNFIHA3OZrf2NrArxuvwxzvzzV7jt01yE7LhHn33B0LdQ6YVjN575eyH8KvxPMIe72BdrNAbqghMejObR/u7RrcNgafE56m1bmFiVof/sZZr7PsRaqWfORYuprMx5TX7u/F3XPaTbjObbYVSsYyaFpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R2sCYqT2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QA6Zhc013363
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=xZoSsT0Ive9C5s9rjHa+reC+6oAdo5G3Dcd18cOrng8=; b=R2
	sCYqT2aF9AO7A72Rw6lh+x8lfecTYZaYvEReDLC76WwPeoP9tQKd3/24eXs5Vvmc
	BT2zTuHsdL+mC2mcTM5LdP9ZokZWw8EWVNqI2PsVJ4/RKF/ykEOW42Fkd84+SgXW
	fGacBryR0KMbGCINVOt5Ds0F6ehdKrCy4ow/WANvZyYCbSrvEC9bzYMxO82ihvbu
	M+QIvnF5PiqLEGyoM7/GHxc1frudX3Vtd8f1mLzMMt9a8Lb6aZV3wHzUZGS8ellQ
	1LZpdBpEklyGmRhHCPZWyG+D3crfhmEHPG+cPlnXGacvdFbxZFyPrHS2ddiht+K1
	DclRfzyAXzErGKNgs8tQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f3bgkwgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:07:56 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b31ff60558eso1798466a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 09:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750954075; x=1751558875;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZoSsT0Ive9C5s9rjHa+reC+6oAdo5G3Dcd18cOrng8=;
        b=HbOy6T2dOwVwggZ/i8oZzMg5CxJfWm1x1ix7LpAi0JvIPH7DNfggWS+a+T/RXrGzj0
         tZz/4ocmnNa1xGqkH5QN2kqeADHmm43GCtrml+7tU3PByYn+LVVAsL7OgxIFSnCQFxyq
         RGZycemJOpdAOKTYK/gUH8KKOTvnts+UaSM/nKQ3ZG7xxvuR3rBtV0qpnZcV+ji8bK/k
         VSdxODyJPXBkZ6Bd8kXQvJtei4Z8yH60/LUDdXGOAWif2F5M+LeaTi5XaewvQ1Ynxtq6
         LprUgmdlJ4F+SJsjz+VUM2dUijsH1qJ43VdS6RAqKvnRSvD7As5kSZ0R7DWPYHYq+sCA
         fCzw==
X-Gm-Message-State: AOJu0YwxB53Ep8B0V/OpQa8x+fhW6JD06/VdTp/pPvjrBuU+z82MJALV
	UUIIfCvmKapPa3E9OyCqBHIIJLdguakjuWOtjb742fevaoIpRd12y2xpZyxOsg2aDL3Zz4sGlUg
	BRBWXIlLFRevFFvLBaEgB+Fn+Sg8KvQFz4TU5dPG+sqe/cFunx7xL5ULnDgoMjq1bE5Afa4xCvF
	32jw==
X-Gm-Gg: ASbGncucQE7Yk6ovY5Tpr+ueJ4qcNJiznRqdqt9d6LB53CLWDmWicalwjoBWgq3e8ih
	RaUjTFECOEJnWTfxWinUk+HXTe4aCBTmMlgPj1uQZkYXXINpt7qRXrhgvtHo+4WV9iJUYmJDnFm
	6AYU8coiyhkxbQkARw/OxOFSMMklRSY+bgOPUapCE3WDZcBi4HtMU16001tYZqw7KAF3wst2L7F
	R98M4NHrimAGJMT5CuMk041Dd9D9AMZR82Xi2FZbCDvh+SFdYENOD5UV9VD6HO04UnNReyZXHZL
	peJSerouh0TWMYOug2ng325QCk1SqZlWNEj348/YSsZjRdRHNeiLGKAPjUBqx+5W+A3HJ0Wthwh
	2BlKyp0we2CwqJvGsxSsA5gCJYziWEEnISAK8zR1s0f7uDgU40QVqnmM5
X-Received: by 2002:a17:90b:3506:b0:2fa:17e4:b1cf with SMTP id 98e67ed59e1d1-316d69aeee5mr5700129a91.2.1750954074984;
        Thu, 26 Jun 2025 09:07:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4mM7nhjU/Bv63Nki++v2FwbWyO7sAlVlMvpvGLTiazKUjYq7I9VNXbvjX+UWKA/O4C54Grg==
X-Received: by 2002:a17:90b:3506:b0:2fa:17e4:b1cf with SMTP id 98e67ed59e1d1-316d69aeee5mr5700080a91.2.1750954074362;
        Thu, 26 Jun 2025 09:07:54 -0700 (PDT)
Received: from che-siroccolnx03.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23abe3fa0d9sm1410345ad.170.2025.06.26.09.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 09:07:54 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next v2 1/2] wifi: mac80211: extend beacon monitoring for MLO
Date: Thu, 26 Jun 2025 21:37:12 +0530
Message-Id: <20250626160713.2399707-2-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250626160713.2399707-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250626160713.2399707-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: pk1SkJrdeNXDUa1ldxFGLZ2ReC-lmTbf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDEzNyBTYWx0ZWRfXzWztv6N2K+UW
 GjEUIu+8FfXw1gx4nJbCn2RqTc/5XeUFKWhl+MELN3R2X3QmFJjwnl+68vi8z9qg98cRi+vMZ53
 5yklHX4x2tCHtyZ4x4Nr7nwdf/xcHWm+4SHBfkuDZsPnMU/PHK5Rym2PtpLT4GUq4EFfKfp0pO/
 F/hZEDodqikpMovw0okr63VC+ujeMH5jhUk1TnexH5dk/bKToHYpKbwXNsCHFC54knul/cS0DDM
 y6fewj9eAOqojg0+nrf28pTRBZ2Ij9bWEucT5iSg41YVwrznwUpA4HfcVRxoYaUrrJafMci1reI
 vk+9Y1CDGdmTRS27vTiWYl6rgyHUuvgCfKlOCR0k1UH9ID6QaVFDR2hn6iy35Fl33XNAbnNjjO6
 Kka4I/BQCRzZhEE5ocCK6wHAjiFyvlNTTZkjZu6mSSs0fi42Mx3uR/m1jznqAgkCqlpyJzYB
X-Authority-Analysis: v=2.4 cv=L4kdQ/T8 c=1 sm=1 tr=0 ts=685d705c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=eANRQvAV50QnJ_dsQ2sA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: pk1SkJrdeNXDUa1ldxFGLZ2ReC-lmTbf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260137
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
 net/mac80211/mlme.c | 48 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 6001c8897d7c..57e514de0036 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2439,6 +2439,21 @@ static void ieee80211_csa_switch_work(struct wiphy *wiphy,
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
@@ -8389,16 +8404,39 @@ void ieee80211_sta_work(struct ieee80211_sub_if_data *sdata)
 	}
 }
 
+static bool
+ieee80211_is_csa_in_progress(struct ieee80211_sub_if_data *sdata)
+{
+	/*
+	 * In MLO, check the CSA flags 'active' and 'waiting_bcn' for all
+	 * the links.
+	 */
+	unsigned int link_id;
+
+	guard(rcu)();
+
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
 		timer_container_of(sdata, t, u.mgd.bcn_mon_timer);
 
-	if (WARN_ON(ieee80211_vif_is_mld(&sdata->vif)))
-		return;
-
-	if (sdata->vif.bss_conf.csa_active &&
-	    !sdata->deflink.u.mgd.csa.waiting_bcn)
+	if (ieee80211_is_csa_in_progress(sdata))
 		return;
 
 	if (sdata->vif.driver_flags & IEEE80211_VIF_BEACON_FILTER)

base-commit: c73ebc0dbb6ed968cb58d04d82ede3b5fb95e8bf
-- 
2.17.1


