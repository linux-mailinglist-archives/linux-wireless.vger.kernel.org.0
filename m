Return-Path: <linux-wireless+bounces-35460-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM5AEhx88GkaUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35460-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:21:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D53F481424
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1AD83289EC2
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593E53E1239;
	Tue, 28 Apr 2026 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GvmamRTM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FU8p0tCE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A878521CA02
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367385; cv=none; b=lTiu0mBI+ebORgqFhhy6g1UmQB4HOVOoMEeQ2fU0KT0bHXqI12rw8ZlMRFNStFv9shba1F2/nMChys1KpuK4WOHxc7CydSW5pUgGNQezQlnvwXxOGsmHdzQW1gi09httXlEyl9hUCVaXJ6S82JKDw3V0SX/c6pzyE3l9xqX5jng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367385; c=relaxed/simple;
	bh=ojJABCaqVmgp/oHZYO7QyrI6NORe+i29hNZBq715FBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BK0QO05t6UKUguI85wG626aqkKaFlLHf/g751n6rDJhhPh0boWhX6l7Oda1SqFxFMxdDS3fzl3UMHhMDRIqsFIcjxo3lnFIrH0JVIyml/2ugY116sTx7zafc/cEVxx2EnvkFy2fFBxDktLnC1DxMYOtg0rd4DlH5L9JHPwNrfh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GvmamRTM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FU8p0tCE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S3kS6x2112686
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=MPK3u55xT8J
	s22Ym6nNh7k7776HH209oo+purneHdQc=; b=GvmamRTMdgPfTe2wrKMzZ9TGYmJ
	Vl52lKag7IB8FA8NrYABduS4QWs/5mkB3apYifxH4r1N40PyArQ4yU9JG3I/D8H5
	PAGcPXhvrXHlZ4KQXp/In6nsLb/pb5PJpKDWdB2PMPQ7wMUMKrE03xpEtoz7wBYY
	njPlmQrQW23yiT8mriaHWMVda2AspWIcyfPXGBYolmjKDKq8GyQaarh32Yan34s1
	jQEXqKGcr1ORhMDTQTJdVs5wjzEVsjceFXfClC2NO8DVd5Eh5hzSLLEfjgRTbi2H
	qXiUdktOihz/KM9DCOc8c1erGqmGteL9gfBsbGGnCmViuDpednZARPnMI/A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtdmbjryu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:09:42 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c70ea91bfe1so5856447a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777367382; x=1777972182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPK3u55xT8Js22Ym6nNh7k7776HH209oo+purneHdQc=;
        b=FU8p0tCEbyIk9Oi9sCIxUVFvQK5z0lZqX9FOc+R8QzRMfBOLC1oForjJbnc5CZuC+v
         OdbTPVRlU+HdJv4UXtgWwIIAkoncF/x1qqqvTGGTYO9ohZ/mTcmMpByqtM8NNFA8SqdV
         zLVr5WwBaL8wPHtvoPAikzGnYwsdHjaFX1y8IAQVcxrRz4k/s/ve5Vn2smeKZ7Q4NOzY
         J7Nj+gzuL9O05yPJKsL20aJC2GxmAnbDax3YiHBDv/ARn+BFDTK8hGelNRkyqlmJjb/s
         rQNWIs+H9+QtBIezOrlNpcNKCLIrxPP+pVc3KjIn5i6eAoYDvRDPP0O6DS1s1hlyNSnd
         1jQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777367382; x=1777972182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MPK3u55xT8Js22Ym6nNh7k7776HH209oo+purneHdQc=;
        b=O6be6TDo3AfFJR6KqRtttWcWIwFOLiVYvy9klDeJxESYvJI6jMDAwYQlZHdI15L/Pn
         tuddhI/6Bm2wv2pZq6Ve9HZ8EslEBbqYvWqtblRdLAGOzI5bOWOclpTG4t+JpAaa2MAm
         BRbkLMmQRnaHx+5nUrMuiTDbw/T1urPWvZzxFNF1pteIDqp+asNHsUv2QJ3n9wtiBFHe
         k+D5PVWhzKCeBPpBXp5NcsGtA0TYTxxmEXE3FDcJQys8E+FGmzIGfSaCvmtgoIc3i/8L
         VeofUO4a/zV0LL+hBr6pimXYJv7vRZk7xslnwdQLPdQkEXxJ0wwgo4Q+AgqzUvS1/Uwf
         xxiA==
X-Gm-Message-State: AOJu0Yzs/Wt6rQ0vV9iek33cRmfcl5S7rm4aRaVfOUFRgNl8oNqKBlWH
	JUwy3RJ90jWH6/lVVB5lg+8YMWOiIGQGuBhfL9aTTy7Slb91y92+V9bbfJtwT8smhoMA+zOD5gw
	s6eZ97vNaWpVkxWJ7Uu5D9E4W9VZzNxEHxyXE0+i6x0fXgBtF+q8JmPZ6LaPdK3yCOiApVCb916
	PaqA==
X-Gm-Gg: AeBDievP4l8kQyNoJWTqlt/NAIV+eHR/xWWlIQU2MMC6WL+HyTiqA1IcbAly0e3Bhlh
	d6++5XG+KPE037APZB4oxQycurV/WSM0u/G6TtKmh2tLc6Cnfryh4OAzrDrPaKxCRJU7MZkT/Qw
	n3DMQW+smur0z/prquq+Y1he8Z+FpF+DFYUonbkDvVe5kS218Wes16D8GqXNW5MbCSQiHAQ3r+0
	maMjIoMeq20g9eKv58JyeuFt1R/frmlyOc628zNasxL/puslp54Rsej/3tA2QQuejP8+GeOTl3k
	QXFZODUwkBgmXHW2w/DwiG2NuM8PR8RuYIC3dhhKuOL6rfRQmGvjUFid/UpX5wPZnEPDAqODYQu
	t6s1LXZs7wVvcxK+r7x1qKH/NhLGBWf+UwfnttHoVAS1jSZxEIyb+TYU0kTqTpHeBHwBNk4iVV5
	ScDE6k9JncqqjIs6OLvY99SxVqFrE4xzYc9rTWsgXR+h0TmL676efHFQ==
X-Received: by 2002:a05:6a20:734e:b0:3a2:7ef4:81df with SMTP id adf61e73a8af0-3a39c256630mr2869213637.26.1777367381786;
        Tue, 28 Apr 2026 02:09:41 -0700 (PDT)
X-Received: by 2002:a05:6a20:734e:b0:3a2:7ef4:81df with SMTP id adf61e73a8af0-3a39c256630mr2869167637.26.1777367381206;
        Tue, 28 Apr 2026 02:09:41 -0700 (PDT)
Received: from hu-sarishar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fc33d5a53sm1898177a12.22.2026.04.28.02.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 02:09:40 -0700 (PDT)
From: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Sarika Sharma <sarika.sharma@oss.qualcomm.com>
Subject: [PATCH wireless-next 1/2] wifi: cfg80211/mac80211: change memory allocation for link_sinfo structure
Date: Tue, 28 Apr 2026 14:39:18 +0530
Message-Id: <20260428090919.1798601-2-sarika.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428090919.1798601-1-sarika.sharma@oss.qualcomm.com>
References: <20260428090919.1798601-1-sarika.sharma@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YcFgeLm4ZFI9xxQilXLKgZdiWe_9hKis
X-Authority-Analysis: v=2.4 cv=PcrPQChd c=1 sm=1 tr=0 ts=69f07956 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=1LaM9D7_W8aAdDzxfx8A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: YcFgeLm4ZFI9xxQilXLKgZdiWe_9hKis
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA4MSBTYWx0ZWRfX2y5vYaD1MTqX
 GZcY14fkMrzu7Hd59p1k2eh6KPy2n+XwUutvRdjyOZw99kCWO6v5Hs1y+ugYTosvKEC9E57QHG8
 vKiiaSxMtmB+Hk3BwbnkrKPw55CjVr73zeFfwmBN/DAo9lquXAlvcI/qFm7dUqBp6u+I5RLOnbf
 QuHPrSBAPHfgo77Qa+XkilXbQ+1PFwibfOpPajvADNNS7aG06LKaXZdxmzYf/IVHS46j9N0eVTm
 KxACSe8y5MV7OpIAiTwFdIXemnybekNMiBSawJ2gasm7tL1Yn6oOkyaNWHhAmq4raQOXa7dLuTS
 wnf3ah9iiCc3KjsI1rBfTRpdj5iarlL13yPTHUlgYqBD2NTziR9u0349K5why5+dvLHUq1F+1t5
 yXzuIrZCbUzDq3slrx0D50HMrgVx+io3tDRRwJpPQfBRFPQhG8v5+ROK9gVUshUJYVy2nqbg0bY
 noSn/irW6o3NRkDAusg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280081
X-Rspamd-Queue-Id: 1D53F481424
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35460-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sarika.sharma@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
 include/net/cfg80211.h  | 29 +++++++++++++++++++++++++----
 net/mac80211/ethtool.c  |  4 ++++
 net/mac80211/sta_info.c | 14 +++++++++-----
 net/wireless/nl80211.c  | 29 ++++++-----------------------
 net/wireless/util.c     | 21 +++++++++++++++++++++
 5 files changed, 65 insertions(+), 32 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9d3639ff9c28..7dc12c2877b1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9146,6 +9146,29 @@ int cfg80211_sinfo_alloc_tid_stats(struct station_info *sinfo, gfp_t gfp);
 int cfg80211_link_sinfo_alloc_tid_stats(struct link_station_info *link_sinfo,
 					gfp_t gfp);
 
+/**
+ * cfg80211_alloc_link_sinfo_stats - allocate link_sinfo and per tid-statistics.
+ * @link_sinfo: the station link information
+ * @tidstats: indicate if per-tid stats are required
+ * @gfp: allocation flags
+ *
+ * Return: 0 on success. Non-zero on error.
+ */
+int cfg80211_alloc_link_sinfo_stats(struct link_station_info **link_sinfo,
+				    bool tidstats, gfp_t gfp);
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
@@ -9159,10 +9182,8 @@ static inline void cfg80211_sinfo_release_content(struct station_info *sinfo)
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
index 4c31ef8817ce..6c6fc7641a53 100644
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
+			if (!link_sta || !link ||
+			    cfg80211_alloc_link_sinfo_stats(&link_sinfo,
+							    tidstats,
+							    GFP_KERNEL)) {
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
index cff5a1bd95cc..1e1ae2dab7ad 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2738,6 +2738,27 @@ int cfg80211_link_sinfo_alloc_tid_stats(struct link_station_info *link_sinfo,
 }
 EXPORT_SYMBOL(cfg80211_link_sinfo_alloc_tid_stats);
 
+int cfg80211_alloc_link_sinfo_stats(struct link_station_info **link_sinfo,
+				    bool tidstats, gfp_t gfp)
+{
+	int ret;
+
+	*link_sinfo = kzalloc_obj(**link_sinfo, gfp);
+	if (!*link_sinfo)
+		return -ENOMEM;
+
+	if (tidstats) {
+		ret = cfg80211_link_sinfo_alloc_tid_stats(*link_sinfo, gfp);
+		if (ret) {
+			kfree(*link_sinfo);
+			*link_sinfo = NULL;
+			return ret;
+		}
+	}
+	return 0;
+}
+EXPORT_SYMBOL(cfg80211_alloc_link_sinfo_stats);
+
 int cfg80211_sinfo_alloc_tid_stats(struct station_info *sinfo, gfp_t gfp)
 {
 	sinfo->pertid = kzalloc_objs(*(sinfo->pertid), IEEE80211_NUM_TIDS + 1,
-- 
2.34.1


