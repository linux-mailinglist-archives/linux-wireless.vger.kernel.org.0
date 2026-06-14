Return-Path: <linux-wireless+bounces-37781-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j4hxIq85LmqdqwQAu9opvQ
	(envelope-from <linux-wireless+bounces-37781-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 07:18:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D533168062A
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 07:18:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=arOKUpYw;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="So0hdkZ/";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37781-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37781-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E3BB3020A98
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 05:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FD718BC3B;
	Sun, 14 Jun 2026 05:18:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DA7171BB
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 05:18:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781414308; cv=none; b=LWzIfCRkQlyDD3JDEWOmEMbEOwYZRasagvsdgX/fEU3vLz+yXWWDys/TijdwFocTPVGn41RUoHw6No3IKp/eX6qbgfc0aEmW+xOPEdOHRrCddCVCwBlesPGet3EzKWBUf9ICB/IObeQk0U5J0T2571LUslqljmiIeWMB69JDg0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781414308; c=relaxed/simple;
	bh=zkOTlUszwFMgWtESsdrB/mducK1rqxjiVVp8w4+J94s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=li7O9R8keCQQjuRtH1cNduPv9saScxZRlayWJimXLmHd6GtAI8+z7d0ESPdxMK4e2q9Wrybe5sXilCGJeIsBQy+Rjh7hEi6cCJCeGe9bVXnwX1BihXJLArq8LT3iE3hk5/qnz+EMSEO4mhxacELzooZsrDpOMG3VGnvvs08pF+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=arOKUpYw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=So0hdkZ/; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65E4Ax5u600386
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 05:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Bm4jK+Xf02d
	DBOsENrfFjm6MJTebtVtYExFXmcCKlgU=; b=arOKUpYwGemyL83ekTpK9Taikj7
	ZxJop4V2QrBplYjBVoNL0gdWpR85H/fHvEEeGBCsaB6MbnK1sAxLqbz4cKWzfT7U
	UwXN/Wx3T+s5TDtxL7hJfu0XEWwBSVajELSyI5HXRVeiy8jythBzODo6AkEj3B6I
	ppONxfdmdSMv9qiuhM1CiimTeqgpvTWSeN1mDfWp0tPQ9f2c+xlKRdYk8hsdg+nk
	N7CH5x5Ws52p5venPnlR6eXF9ntmjhkiadaKM/ILpJELeKQM0INkqrsdC4pucijb
	yQcpGUyqCC1E6GPrg32vtYGikTiuEU3m67doQ+PZasRlmbbC6MPrfTJ4fZg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery7u2sjk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 05:18:26 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c858e0cbca3so1126659a12.2
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 22:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781414305; x=1782019105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bm4jK+Xf02dDBOsENrfFjm6MJTebtVtYExFXmcCKlgU=;
        b=So0hdkZ/jKAG+wwYkDNz09OJkRDKmfl6W5oMBz2mpUGbWltf5TeAC+hd2PcKuhMh86
         1fcr0ivY8EB2ghEg15Kek5wxVv660M+BNMdzAZEbiiswd8EmNGU4vLUBwfm7wnykh0d1
         +27wpCNq51uobgKowXxp6ozzky11ZpmfMx6qTYsvm4v+CZ2hYBN2eIxURdzX7RHm4ss/
         mPAJMXuw3Zw6KSHePG7RLv4Tww/QVSAMtgkkBIvNfOu4nOHkob7YnM+pINhKa35l1hAx
         JQ4KaI19PG0xJtRr+yId0HqtAV+42A+JDdlrXtzhXEpqwLry+KQKU2wb8XipwF1c0pv/
         7oUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781414305; x=1782019105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bm4jK+Xf02dDBOsENrfFjm6MJTebtVtYExFXmcCKlgU=;
        b=Q8U7LLRc9Wz/17ZW8thvjlZn0B933YtXtwop0Fzyk4unxess2WlTvvfbHMPdDtJ4jS
         YddX5vzgzm2h/B+tWsK+sHt5vNkRb2G6sSu+pvGRZKlCOKL6FBCDj1mxjHKBquVWn5jq
         urj5mToY3lmSxg1nBT27syNXNqxCPAVqOtpVNzqmsX6bN5k3ZUQ49gqwWg+9SPMEgkUI
         tpalQ1/hgQtNXhj2ajVO4oyPHJVA8aYdbl1UmsJESIGrT2OnVwkOI7PKdBSiYb6Ub6nu
         JEHm7qZRl+hvj7wThYh1e2bF1f2GvfT7skjZltS7Cj+wQXZO1ZCkujQH5EsXDz8iDcHQ
         bcPQ==
X-Gm-Message-State: AOJu0YyNynbb27zs1RynMiHrkps8FgbdXXrht19LRggj0/UUlmGukpdq
	EUx+xBrxmbv4j1XlouEycIhlxeGB4Y0UX5Mh+CbLx3Zg1nJz7sf3iD4+eBEPwbopn8eIOLiaQ1Q
	EkQ7hZGTtydO7+x5skXDYkcZvVa5QtocPUn3dmURkRpU9vssvfr7p6IJd+SdO+k5N1k6XFw==
X-Gm-Gg: Acq92OEzFe3T+U+8U6Gr+aQ76q6URh+sdLzOKZEhivOgGJhgm19AvGkad3d1VYZ5mDq
	svBr7JVVDmrs4ci3rr8qufdnG40MVyLwx6VxLB6Bgaynyy/eYp0PUkwpQHHk075S5yRyvt9zJNW
	6Lw6AAuWGgFupde4GEg4yvopbTKBwkq/oxCpq8pfFCWyPoCrCsxrW9nzheyDYj+ZYl7qMBVf1V8
	tLPh36B3+ZEy33EGtau8XOgvavdhr4ajxGz1+PsW6fxZZTRes8SHNewlKP9HdpPDqh9Wifi8jAr
	uXvGYAkRkbhvvQ6+vbC74frOifqRqFr00QxvggIz3Nqoluz7PUidKRtMJEiqJA44jxRXDx4FDcI
	Cs64xDEkEE3V6W3nV/WUxfZ6ZvyA7hXMMCfZlaTVp1qjCi2cdNCyKmjwxM6KYzjVJ8uWwl12I+U
	nEb0GvkPLvN9wTSvNG8vgYkHbOPNONhEYy145Jhhk=
X-Received: by 2002:a17:903:2351:b0:2c0:dd75:e824 with SMTP id d9443c01a7336-2c6641ca3cbmr66820835ad.4.1781414305438;
        Sat, 13 Jun 2026 22:18:25 -0700 (PDT)
X-Received: by 2002:a17:903:2351:b0:2c0:dd75:e824 with SMTP id d9443c01a7336-2c6641ca3cbmr66820605ad.4.1781414304948;
        Sat, 13 Jun 2026 22:18:24 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c651dsm64456705ad.26.2026.06.13.22.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 22:18:24 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        praneesh.p@oss.qualcomm.com
Subject: [PATCH wireless-next v2 2/5] wifi: cfg80211: Add helper to pack station-level STA_INFO
Date: Sun, 14 Jun 2026 10:47:32 +0530
Message-ID: <20260614051739.3979947-3-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260614051739.3979947-1-praneesh.p@oss.qualcomm.com>
References: <20260614051739.3979947-1-praneesh.p@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=F8BnsKhN c=1 sm=1 tr=0 ts=6a2e39a2 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=1T2V7jJnlCC3E2zEIMEA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 1bu05RCiZ_uz1IooM-Zc6b92eUbMphKO
X-Proofpoint-ORIG-GUID: 1bu05RCiZ_uz1IooM-Zc6b92eUbMphKO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDA0OCBTYWx0ZWRfX/B3S1c6CSYmc
 P27gR/DhPkhDKtqUYfTPvi6rXz8Vs3O6L0MmHFHRNuATO9qzzM4bkCDcEAOB63hagSRWmGG5NH2
 nwbPK8hRm1VYLmJ2u3/4oM76qtPKNsA2NjJcXaxjQAIXVHGq68VumO4LzxL+ZFeKpzGdNQSfufX
 nGPK+DEsg7HC7B04N+UifR+wR1VbWDEVQ+o1l9ABOZQ0u/Eeo90DTUHSddat7qY/5FZGdNpP/VG
 Bljpawzo5SwfTGQgDT0X+rn+smfKNLiSkKMM+UU5Lq/+y05cuFbskXgaIOpUtW22ZLX71bdmM0J
 TUYpScqAbEzC3yT2rhGfbKN5SdBjUiyuTVcrQypKv44+QSAp4ctVcovCiMVsu8bqZtEKbJm8Kj1
 h2BxxWufFPjSbJUIN5sry33Rn+9zB9H7W9thaT3OPMboQ9MPeL70oRLiZcWtShPCv2c7O76ihRg
 SPP72pn6CXoqoJJsOqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDA0OCBTYWx0ZWRfX/OJoC/4jcbsC
 CmxwXds7/TWbXVqSmzl5djRlKVMveaN7Fh3OIRIV8eNqOugcAnJ1CJzmC4bwMUOVzz6g0hay7bl
 2bHmhxYG6und/HIsOORs/hN5PgDbwww=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606140048
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37781-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:praneesh.p@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[praneesh.p@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praneesh.p@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D533168062A

Add a helper function nl80211_put_sta_info_common() to pack the
station-level (aggregated) STA information into a netlink message.
This prepares the code for future enhancements such as supporting
fragmented link statistics in nl80211_dump_station.

Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
 net/wireless/nl80211.c | 66 +++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 98548e69b5fc..66f19bfc030a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -8029,32 +8029,15 @@ static int nl80211_fill_link_station(struct sk_buff *msg,
 	return -EMSGSIZE;
 }
 
-static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
-				u32 seq, int flags,
-				struct cfg80211_registered_device *rdev,
-				struct wireless_dev *wdev,
-				const u8 *mac_addr, struct station_info *sinfo)
+static int nl80211_put_sta_info_common(struct sk_buff *msg,
+				       struct cfg80211_registered_device *rdev,
+				       struct station_info *sinfo)
 {
-	void *hdr;
 	struct nlattr *sinfoattr, *bss_param;
 
-	hdr = nl80211hdr_put(msg, portid, seq, flags, cmd);
-	if (!hdr) {
-		cfg80211_sinfo_release_content(sinfo);
-		return -1;
-	}
-
-	if ((wdev->netdev &&
-	     nla_put_u32(msg, NL80211_ATTR_IFINDEX, wdev->netdev->ifindex)) ||
-	    nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(wdev),
-			      NL80211_ATTR_PAD) ||
-	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, mac_addr) ||
-	    nla_put_u32(msg, NL80211_ATTR_GENERATION, sinfo->generation))
-		goto nla_put_failure;
-
-	sinfoattr = nla_nest_start_noflag(msg, NL80211_ATTR_STA_INFO);
+	sinfoattr = nla_nest_start(msg, NL80211_ATTR_STA_INFO);
 	if (!sinfoattr)
-		goto nla_put_failure;
+		return -EMSGSIZE;
 
 #define PUT_SINFO(attr, memb, type) do {				\
 	BUILD_BUG_ON(sizeof(type) == sizeof(u64));			\
@@ -8145,8 +8128,7 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 	PUT_SINFO_U64(T_OFFSET, t_offset);
 
 	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_BSS_PARAM)) {
-		bss_param = nla_nest_start_noflag(msg,
-						  NL80211_STA_INFO_BSS_PARAM);
+		bss_param = nla_nest_start(msg, NL80211_STA_INFO_BSS_PARAM);
 		if (!bss_param)
 			goto nla_put_failure;
 
@@ -8188,8 +8170,7 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 		struct nlattr *tidsattr;
 		int tid;
 
-		tidsattr = nla_nest_start_noflag(msg,
-						 NL80211_STA_INFO_TID_STATS);
+		tidsattr = nla_nest_start(msg, NL80211_STA_INFO_TID_STATS);
 		if (!tidsattr)
 			goto nla_put_failure;
 
@@ -8202,7 +8183,7 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 			if (!tidstats->filled)
 				continue;
 
-			tidattr = nla_nest_start_noflag(msg, tid + 1);
+			tidattr = nla_nest_start(msg, tid + 1);
 			if (!tidattr)
 				goto nla_put_failure;
 
@@ -8232,6 +8213,37 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 	}
 
 	nla_nest_end(msg, sinfoattr);
+	return 0;
+
+nla_put_failure:
+	nla_nest_cancel(msg, sinfoattr);
+	return -EMSGSIZE;
+}
+
+static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
+				u32 seq, int flags,
+				struct cfg80211_registered_device *rdev,
+				struct wireless_dev *wdev,
+				const u8 *mac_addr, struct station_info *sinfo)
+{
+	void *hdr;
+
+	hdr = nl80211hdr_put(msg, portid, seq, flags, cmd);
+	if (!hdr) {
+		cfg80211_sinfo_release_content(sinfo);
+		return -1;
+	}
+
+	if ((wdev->netdev &&
+	     nla_put_u32(msg, NL80211_ATTR_IFINDEX, wdev->netdev->ifindex)) ||
+	    nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(wdev),
+			      NL80211_ATTR_PAD) ||
+	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, mac_addr) ||
+	    nla_put_u32(msg, NL80211_ATTR_GENERATION, sinfo->generation))
+		goto nla_put_failure;
+
+	if (nl80211_put_sta_info_common(msg, rdev, sinfo))
+		goto nla_put_failure;
 
 	if (sinfo->assoc_req_ies_len &&
 	    nla_put(msg, NL80211_ATTR_IE, sinfo->assoc_req_ies_len,
-- 
2.43.0


