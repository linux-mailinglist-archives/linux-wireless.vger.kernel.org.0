Return-Path: <linux-wireless+bounces-35680-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHzHHvHq8mltvgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35680-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:38:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C719949DA32
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B24EC301A3A6
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 05:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8739434405B;
	Thu, 30 Apr 2026 05:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X7kZ/g9c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gvu0Q4bF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E647632FA3C
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 05:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777527509; cv=none; b=nEtFqns5in2VgxuYDN+IZugdqOL5Q5cs12GC+U0ASBSXNAJ5+ggaYtQZJ14KezsPXWv5hSHNPEG4D2ej46oPFqmWZyaFuRmV6QfpwtWzIBU4Py7GuF7wC3Wfq08KdsMzUuTPwb5EQB0RYfdIR+HejwWCKU5Tk3/5QCTPRVx9RFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777527509; c=relaxed/simple;
	bh=oztnRXAIkzwoOvuJhzg70BDOeavKGupzgaHvUlRh+ZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bGxJRKE3xOMaMmkA4q+Z4nqc3pk+zkkZbJg7/iN1BDdwvTRShU8y57gLp0dGBigV0xyCXjNVmG3jOCMIkCmLe7C3hU8ilHWDr1E+enj2/lQ1Q8+jfIVgQ01ZY/0fcKAx0k0eioSDDQKTsPOI/1RipnwSCIpPOStK04Sy28LIHg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X7kZ/g9c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gvu0Q4bF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U44aTl2099612
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 05:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Gauszf9Os2d
	Ry/bJGf0iiwhQiE1tTiHfi5ABy/nOvYo=; b=X7kZ/g9c3QBIe2Yk4dI/LYpqHM3
	ycAKRhEz9dmqdsYo7yirHCfe/1EqO3Yf+q+MhSLXNiY56NNK2wFwDGsrym7orZ4j
	XqC6jU38A/VPp2IMABM8KCppy9xKHaTKRogJ/EK1BnnU5UYbEZJFQFkQly5jJfjS
	4NpEO6gjp0Bg66qU/7hS0aX4VdU3zDWn8/nUlmV9jg7OGg3+UQev46e6fOBCQiAf
	uIIfHT3LEZz31IQG4dnm9M9ZVj9ubvK6eEyYdgf5uF79Lf4JVb5/loSqAOiMW7iV
	RVCRkWMssi7uo677SrDANt5kC3nlo1P2LVcApsXkt+VEULSiVWl5Cr8GbUw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duyr4083x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 05:38:26 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-362eaa3aa61so538234a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 22:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777527506; x=1778132306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gauszf9Os2dRy/bJGf0iiwhQiE1tTiHfi5ABy/nOvYo=;
        b=gvu0Q4bFCUAcUm1YbNOaK7/prbGT/13gZTH8X4fraIzx2r2M4CKC4Bv2DGHlWeSH2r
         Q7a1ChT0Kld6TGgLtpDjh5C3boP9LdwHPHGbXukRRc+3HJ98e5s/ybVau1K7WspuWlGy
         aBatqhipfp9dpVIgrUacFPAOJwTFQ3D5s4nHuvTUWW38nXqOkwCBIZqXJlUFoaoEgogX
         svt5Wa5npFRXS2XIuLhPcOqb3iYKaMTQcCa64dTiJKQDdh/0OuZFP6aAjoUHnDszdTAb
         ULUspm4Kw/QHIhg7NmA1oNM0dRYOjOKHX99oCr3CyReh2tzqKQC8Os0gPllpzdV3HPSi
         awiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777527506; x=1778132306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gauszf9Os2dRy/bJGf0iiwhQiE1tTiHfi5ABy/nOvYo=;
        b=fgT8E/okH5ZYhTI9HrGYABkzJTxtSft5WfqCY02tMx4KX/iFzgCYn9RdUXQQ5IygFk
         6SUPCwvmUonxnWOcvWBhzKDUznrzcLe4iILbdVx/tx6DveNq/V8x32pPoDDFEbGo0cUg
         09e6GezhHBNVuWKR/kcufZMUrz8ENkJA1taZFrJ+P+59S2tkXg3FYQ0GAh93KkRencRQ
         MH9isTPkq59uBdN6eECWP2BAbRisECR3OK39vyBSGEU2gcSjswko254SdHNdy1ww74Xb
         cdcRGpKW4Q8rcKr33O7Rkl8dhsNGm6Zumy5j7ZEWivSz9Ff1A1TQFUemJgFVoy66Reyq
         xv/g==
X-Gm-Message-State: AOJu0Yz0i4xn0T4j9gK6XvEpF6UKXpNMdnMFHQmqltpGTqV6AHkSaKSj
	8SJpexJpvCz+bTHtEwGlXvEpT13bDviuz1LBBFFdDwMRSRpqFoAj+z9+gtI/TmAEHprmJtrXdaD
	re+IJnMfalnVvwDY47W+k4/DPLM14HHRNcBYGVkxbDn8vGAVJ0wIYfkiqsZc4Bu67aullPg==
X-Gm-Gg: AeBDievtEgoBtE+F652q3PZn8hEneGwPDkrMc1ggZS4FZe5pqN0Ji1Ftw1UJ3hXMYdd
	uth3SANJZT7SFBdilDQ+k9dQawmZekuwsNl1G108WPoc4INoxU+oPygPHMCcclM/LNpRzncQwnj
	h1R7bHVQRTICHQp55kjA9ds2O6Zf3EzZCLRu2bIVOQAPkoEBOLfk7Zp1dz/itqgFtN64ig4rPkQ
	VcHIDaMwyuwGhICcki6Y/N14GbljVLU3r53z7gQK30EIZyVHKUmVdP3fOGE0Ku/HZJOS3FfrMEx
	D9Y+OaBIEfYuGAhF/YtL2I/9/fQmh0TdpO4vQRQPSM0luW3RNsaCsW/t0eFO16/gwYz6uAxNem3
	sIFQdTXKOVehsaRxI5vuhko1QzZVR7dY+fywf9kYlGVVduilaGcCydCRGgDlFBNg4SopLoV7zy1
	fgsowoZC2hYQyq040G3WA2kU8jUHY4QQtTVEuldGg+XC1kmlEBTcDvhA==
X-Received: by 2002:a17:90b:2752:b0:35b:9ab6:1d4a with SMTP id 98e67ed59e1d1-364c30cbf38mr1365389a91.18.1777527505849;
        Wed, 29 Apr 2026 22:38:25 -0700 (PDT)
X-Received: by 2002:a17:90b:2752:b0:35b:9ab6:1d4a with SMTP id 98e67ed59e1d1-364c30cbf38mr1365358a91.18.1777527505359;
        Wed, 29 Apr 2026 22:38:25 -0700 (PDT)
Received: from hu-sarishar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98879656dsm39561425ad.25.2026.04.29.22.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 22:38:25 -0700 (PDT)
From: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Sarika Sharma <sarika.sharma@oss.qualcomm.com>
Subject: [PATCH wireless-next v2 1/2] wifi: cfg80211/mac80211: change memory allocation for link_sinfo structure
Date: Thu, 30 Apr 2026 11:08:09 +0530
Message-Id: <20260430053810.2088793-2-sarika.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430053810.2088793-1-sarika.sharma@oss.qualcomm.com>
References: <20260430053810.2088793-1-sarika.sharma@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bJcm5v+Z c=1 sm=1 tr=0 ts=69f2ead2 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=1LaM9D7_W8aAdDzxfx8A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA1MyBTYWx0ZWRfX0txnRFwWg8sP
 0d5DsQQTgiiLtoK626fNfhTejikJ+1lmdaw9fYmKeuogVG0slHznCptPtMxBxzyG3jkRhZUhPoK
 8SQ3WrzVfHbBdKSSi8c5fGTahBTehPzJl70bjySKTiDAgubWE/MbvNdrKq1gaRLh96llEqbuJo8
 8GA9tkA7FI0CIm6rpXp3DeL8Kupub9tsWgovdvkaRyGdXvJRO8Pl6GYWAw03V5/hpHsHe4i8y3X
 7KXZQStw+jd1rqbqXGSFupN0LftCN6ViM2IQVAzdaCFvT6ROidhq/5BTyZyEx/4TefVVsxIQ5Tq
 NvxdFVHe8QHy4FdmqrRvpA8P9g9+E07PuYh/h8Q5n5P6MUzxNuM05mYyqgxzKDJbM/tCQ6mX79m
 lG4JflZEjgczTOA+Q5SmLy3ujgHzLqkPHS1qrG5NS5VbHQprvrH817LHoar4U68KG1WEmP1rF2d
 Rr/c29LHcCxWq21r5Tg==
X-Proofpoint-GUID: CpKO743JsAijab5LO2oYYpfOklHhWSdw
X-Proofpoint-ORIG-GUID: CpKO743JsAijab5LO2oYYpfOklHhWSdw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300053
X-Rspamd-Queue-Id: C719949DA32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35680-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sarika.sharma@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Currently, during the NL80211_CMD_GET_STATION call, cfg80211 allocates
memory for link_sinfo objects for all possible links, regardless
of whether they are valid for the station. However, mac80211 only
fills in link_sinfo for valid links, leading to unnecessary memory
consumption.

To optimize memory usage, introduce an API in cfg80211 to dynamically
allocate link_sinfo and the corresponding link tidstats objects.
Memory is allocated only for valid links during link_sinfo population
in mac80211.

Also, refactor cfg80211_sinfo_release_content() so that link_sinfo is
freed separately, keeping allocation and free paths symmetric.

Signed-off-by: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
---
 include/net/cfg80211.h  | 28 ++++++++++++++++++++++++----
 net/mac80211/ethtool.c  |  4 ++++
 net/mac80211/sta_info.c | 14 +++++++++-----
 net/wireless/nl80211.c  | 29 ++++++-----------------------
 net/wireless/util.c     | 21 +++++++++++++++++++++
 5 files changed, 64 insertions(+), 32 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9d3639ff9c28..7e6fab00d07d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9146,6 +9146,28 @@ int cfg80211_sinfo_alloc_tid_stats(struct station_info *sinfo, gfp_t gfp);
 int cfg80211_link_sinfo_alloc_tid_stats(struct link_station_info *link_sinfo,
 					gfp_t gfp);
 
+/**
+ * cfg80211_alloc_link_sinfo_stats - allocate link_station_info
+ * @tidstats: indicate if per-tid stats are required
+ * @gfp: allocation flags
+ *
+ * Return: pointer on success, ERR_PTR() on  failure.
+ */
+struct link_station_info *
+cfg80211_alloc_link_sinfo_stats(bool tidstats, gfp_t gfp);
+
+/**
+ * cfg80211_free_link_sinfo - free the content and memory allocated for
+ *	link_sinfo
+ * @link_sinfo: the link_station information
+ */
+static inline void
+cfg80211_free_link_sinfo(struct link_station_info *link_sinfo)
+{
+	kfree(link_sinfo->pertid);
+	kfree(link_sinfo);
+}
+
 /**
  * cfg80211_sinfo_release_content - release contents of station info
  * @sinfo: the station information
@@ -9159,10 +9181,8 @@ static inline void cfg80211_sinfo_release_content(struct station_info *sinfo)
 	kfree(sinfo->pertid);
 
 	for (int link_id = 0; link_id < ARRAY_SIZE(sinfo->links); link_id++) {
-		if (sinfo->links[link_id]) {
-			kfree(sinfo->links[link_id]->pertid);
-			kfree(sinfo->links[link_id]);
-		}
+		if (sinfo->links[link_id])
+			cfg80211_free_link_sinfo(sinfo->links[link_id]);
 	}
 }
 
diff --git a/net/mac80211/ethtool.c b/net/mac80211/ethtool.c
index 3d365626faa4..780229e6bc6d 100644
--- a/net/mac80211/ethtool.c
+++ b/net/mac80211/ethtool.c
@@ -136,6 +136,8 @@ static void ieee80211_get_stats(struct net_device *dev,
 		if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG))
 			data[i] = (u8)sinfo.signal_avg;
 		i++;
+		if (sinfo.valid_links)
+			cfg80211_sinfo_release_content(&sinfo);
 	} else {
 		list_for_each_entry(sta, &local->sta_list, list) {
 			/* Make sure this station belongs to the proper dev */
@@ -147,6 +149,8 @@ static void ieee80211_get_stats(struct net_device *dev,
 			i = 0;
 			ADD_STA_STATS(&sta->deflink);
 			data[i++] = sdata->tx_handlers_drop;
+			if (sinfo.valid_links)
+				cfg80211_sinfo_release_content(&sinfo);
 		}
 	}
 
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 4c31ef8817ce..e6ed9375105c 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2963,8 +2963,7 @@ static void sta_set_link_sinfo(struct sta_info *sta,
 				BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
 	}
 
-	if (tidstats && !cfg80211_link_sinfo_alloc_tid_stats(link_sinfo,
-							     GFP_KERNEL)) {
+	if (tidstats) {
 		for (i = 0; i < IEEE80211_NUM_TIDS + 1; i++)
 			sta_set_tidstats(sta, &link_sinfo->pertid[i], i,
 					 link_id);
@@ -3252,6 +3251,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	}
 
 	if (sta->sta.valid_links) {
+		struct link_station_info *link_sinfo;
 		struct ieee80211_link_data *link;
 		struct link_sta_info *link_sta;
 		int link_id;
@@ -3267,12 +3267,16 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 			link = wiphy_dereference(sdata->local->hw.wiphy,
 						 sdata->link[link_id]);
 
-			if (!link_sta || !sinfo->links[link_id] || !link) {
+			link_sinfo =
+				cfg80211_alloc_link_sinfo_stats(tidstats,
+								GFP_KERNEL);
+			if (!link_sta || !link || IS_ERR(link_sinfo)) {
 				sinfo->valid_links &= ~BIT(link_id);
 				continue;
 			}
-			sta_set_link_sinfo(sta, sinfo->links[link_id],
-					   link, tidstats);
+
+			sta_set_link_sinfo(sta, link_sinfo, link, tidstats);
+			sinfo->links[link_id] = link_sinfo;
 		}
 	}
 }
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f334cdef8958..108583fb2cd2 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -8199,7 +8199,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 	u8 mac_addr[ETH_ALEN];
 	int sta_idx = cb->args[2];
 	bool sinfo_alloc = false;
-	int err, i;
+	int err;
 
 	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev, NULL);
 	if (err)
@@ -8220,20 +8220,13 @@ static int nl80211_dump_station(struct sk_buff *skb,
 	while (1) {
 		memset(&sinfo, 0, sizeof(sinfo));
 
-		for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
-			sinfo.links[i] =
-				kzalloc_obj(*sinfo.links[0]);
-			if (!sinfo.links[i]) {
-				err = -ENOMEM;
-				goto out_err;
-			}
-			sinfo_alloc = true;
-		}
-
 		err = rdev_dump_station(rdev, wdev, sta_idx,
 					mac_addr, &sinfo);
 		if (err == -ENOENT)
 			break;
+
+		sinfo_alloc = true;
+
 		if (err)
 			goto out_err;
 
@@ -8273,7 +8266,7 @@ static int nl80211_get_station(struct sk_buff *skb, struct genl_info *info)
 	struct station_info sinfo;
 	struct sk_buff *msg;
 	u8 *mac_addr = NULL;
-	int err, i;
+	int err;
 
 	memset(&sinfo, 0, sizeof(sinfo));
 
@@ -8288,19 +8281,9 @@ static int nl80211_get_station(struct sk_buff *skb, struct genl_info *info)
 	if (!rdev->ops->get_station)
 		return -EOPNOTSUPP;
 
-	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
-		sinfo.links[i] = kzalloc_obj(*sinfo.links[0]);
-		if (!sinfo.links[i]) {
-			cfg80211_sinfo_release_content(&sinfo);
-			return -ENOMEM;
-		}
-	}
-
 	err = rdev_get_station(rdev, wdev, mac_addr, &sinfo);
-	if (err) {
-		cfg80211_sinfo_release_content(&sinfo);
+	if (err)
 		return err;
-	}
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg) {
diff --git a/net/wireless/util.c b/net/wireless/util.c
index cff5a1bd95cc..53e7dfd988ac 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2738,6 +2738,27 @@ int cfg80211_link_sinfo_alloc_tid_stats(struct link_station_info *link_sinfo,
 }
 EXPORT_SYMBOL(cfg80211_link_sinfo_alloc_tid_stats);
 
+struct link_station_info *
+cfg80211_alloc_link_sinfo_stats(bool tidstats, gfp_t gfp)
+{
+	struct link_station_info *link_sinfo;
+	int ret;
+
+	link_sinfo = kzalloc_obj(*link_sinfo, gfp);
+	if (!link_sinfo)
+		return ERR_PTR(-ENOMEM);
+
+	if (tidstats) {
+		ret = cfg80211_link_sinfo_alloc_tid_stats(link_sinfo, gfp);
+		if (ret) {
+			kfree(link_sinfo);
+			return ERR_PTR(ret);
+		}
+	}
+	return link_sinfo;
+}
+EXPORT_SYMBOL(cfg80211_alloc_link_sinfo_stats);
+
 int cfg80211_sinfo_alloc_tid_stats(struct station_info *sinfo, gfp_t gfp)
 {
 	sinfo->pertid = kzalloc_objs(*(sinfo->pertid), IEEE80211_NUM_TIDS + 1,

base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
-- 
2.34.1


