Return-Path: <linux-wireless+bounces-27040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8B5B45826
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Sep 2025 14:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF475A4311
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Sep 2025 12:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEF8350D48;
	Fri,  5 Sep 2025 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BATH75HE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222C934AB0A
	for <linux-wireless@vger.kernel.org>; Fri,  5 Sep 2025 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076490; cv=none; b=sfMooamrqZH/l5tekuXq/KQ+hKhJGcn6qoxL2zcTX+LqLAopwHyX/o1nu4PJH5Yhfu5eXntQjUPXX+SLbI/wiHNakqxwZmhvkYrfZTf1k0ECx92yYBQhXd/QzxFyKgeYLIcZTgaB4o3ToJKelAhR5I/Hn3BpiWrN4v/LNupwwf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076490; c=relaxed/simple;
	bh=J082ip8oI4BcuJZyRNdgradhNpOj828tOBWuf64+xgo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=i8yOuIQ4wAjptkXQSzZT5uDXvTs7ArplStz3ZQ+hMwNbJGScgv2i1mPebLcN+B/NhrhHkT8jNdbBe/UMjz/IQ20fyZVPXUwPhIqILRB0z7sO/n+kRyAA+P6Od0j4JOi2DL82KTHpjSRKp0vhlowRxmZqOND82tGXJ0WnDrgeAJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BATH75HE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857EDpd007551
	for <linux-wireless@vger.kernel.org>; Fri, 5 Sep 2025 12:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=PnoEsGdxqqq+
	FIZVH7OYFnVpR36GWf1rMYPBcU3Bqhs=; b=BATH75HEm8CTPalJQ4riPPDYX3+H
	jSl8HtQINeJeXLPTOjXnhoSApfx5oRIZMxYSm8fMH2nhqT7mjZ3K8lXgYidylMl5
	XL4PNQex3YN0ioS9BMvRJT6Il+y9Z7c1zE8k4K/gfpDecv5KMipsmxe7+87avECp
	yfuLdRZgbG6zHjYaeYT03dVUUTlbjGL9hYiCbhH980W/EmX+jxtL+g/YIPDkAiK2
	neOu69gTuShF6ii3gE+78zy8aA1CmPV5T1CbRulmjZFca4fNRyIDXT65xPm/fkS7
	0xODZuCC5P4xiULRaOydDlXgwUVgJKJqnr5CkPXY6JmW4LPPFdIITcL8Ag==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura931hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 05 Sep 2025 12:48:08 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77278d3789cso4015141b3a.1
        for <linux-wireless@vger.kernel.org>; Fri, 05 Sep 2025 05:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757076486; x=1757681286;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnoEsGdxqqq+FIZVH7OYFnVpR36GWf1rMYPBcU3Bqhs=;
        b=vhs277toSuQGEGukfDeu2wcIiNcsQ67C3UXpK07qCj301WIKe7POwrK/PWuFsYicmj
         iAItd7u11lXpo96uYsJLKg6s/Y3ek594RjW03INGQ+YdBKpUO9vRoXt3C31mzk1J9SRE
         PJ/dh0gkOPepSr32vrjxsM58cSZ/Hztip30MgEtGaDaYmaTWcquPmL8S6MBlcCmkUqj3
         8cnRbvq/oO9A2uhg3ND7xOG21RwkbIme1R9DvQNIl6uE/wJg561QU+q6pE85Z8wvsB7/
         vZ6I9QZwevozmQoDA1dHZgP63E+5Zqc1lvXbQlkfHHnQ4Ts+DZ0mCbL4eIAqA+g/J2tI
         ovEg==
X-Gm-Message-State: AOJu0Yykdq2mdhiRkPnReNEG/bVOeJ9ugNuYUtAbGdv2Rl4uGUeOElok
	au48L9EofJoKwgsJg9OSc0hugB7OcJN08W3zW5whqqArnNABBAk3o51aFmLC9OSWvEuxe2igTjK
	8lpkzGcVymekBnCF13ejRMEcwl9wLwu09XlJErE57ytlf0ftAXuUyfp8yRpkQFG1/udFmpS+Jk1
	qMdA==
X-Gm-Gg: ASbGncshK4+3Oo2yU60b7XCHDdI6AfLv28Yxv50pgg5dkanUEA5WkVr9aCczedMa8J5
	nnd5OVKL4JMckV6KoUALIeJtQ/CcPjQerpeiBhwyEdV8KDtk5iEvL6SA+Qpg0GRaxdVc00+nWTu
	z9+eBsJVngZ8H+cPXCfKK3dx22OC0qMHrCHVOO2J3qqmq1vD2uK+37Oal2wHLSC1LSxnFi5GqkU
	wyODm7EuG406r6cnCaZTPGqNQ/3M4F+LXdGTZr4QIAeT/BN/QutIcpoDlFXShxq8hsCXqSgJY3c
	7+tR6PSWtr44SrXuLHPPsvOLhGI3i4xpMHFizKhjza1HLhcz8wJmqO0XyDxEWypq3pxS3ofnDvX
	DL+KluC8RaCbToSgw+Li/aLXDc6KWvVJ/2k+vCzr1cTuCajLcQvkvq6Tfb3P++4hH74qe43+JkQ
	==
X-Received: by 2002:a05:6a20:1594:b0:248:4d59:93d5 with SMTP id adf61e73a8af0-2484d599525mr14294961637.55.1757076486486;
        Fri, 05 Sep 2025 05:48:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+bGBfGl7Fsr54Xy6h/copErhPkUt2t6Lw+VQUe8R0kU2Adw8e1CrcQx0dQhU4gHL6WYqFwg==
X-Received: by 2002:a05:6a20:1594:b0:248:4d59:93d5 with SMTP id adf61e73a8af0-2484d599525mr14294926637.55.1757076485970;
        Fri, 05 Sep 2025 05:48:05 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4d96829a66sm18041851a12.6.2025.09.05.05.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 05:48:05 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH wireless] wifi: cfg80211: Fix "no buffer space available" error in nl80211_get_station() for MLO
Date: Fri,  5 Sep 2025 18:18:00 +0530
Message-Id: <20250905124800.1448493-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-ORIG-GUID: nwdYuNfT1fJEERpAnkjmfJ4VtH_mhXI3
X-Proofpoint-GUID: nwdYuNfT1fJEERpAnkjmfJ4VtH_mhXI3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX+p/FVFWEGd1n
 ItqecoqvTGsuFEEefiaDbQb1aF3x4YSaH79y20fgjuK966u/ZGwcSsViW1XCY29NYENKNZV4ST1
 qUz0k4nJuxOqUUz5R+VMBaiZiKMEzJtNWy8fXG0OauDJsAZncSES/3nKewC7jSbqrKpMQFM9ANq
 r7+BeNhW1heP8O2ZDYzamdrpQ2nZ0au/12rpuPteZxPy6uEAxVB2B4geNv63Zef7vFe0ni4vlHB
 gbnOFs4Q5T15MFJXLd3cUSkxGmo0jF7uY+K+oZVMP1NAQYYgjXRRlpOWjck7YqsMoE+3ExmUtI8
 9SSJfb8e6dN0NmXixOLyvuPJ/PqpweK7w/bNWe/gk9DVGJ6mKSD7RPbwYyTLQvg8BBRjOjtPMXq
 rMwEaGYG
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68badc08 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kD4sTvn9sZURAWMP:21 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8
 a=gXmUh3uitkxkngZH5WgA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Currently, nl80211_get_station() allocates a fixed buffer size using
NLMSG_DEFAULT_SIZE. In multi-link scenarios - particularly when the
number of links exceeds two - this buffer size is often insufficient
to accommodate complete station statistics, resulting in "no buffer
space available" errors.

To address this, modify nl80211_get_station() to return only
accumulated station statistics and exclude per link stats.

Pass a new flag (link_stats) to nl80211_send_station() to control
the inclusion of per link statistics. This allows retaining
detailed output with per link data in dump commands, while
excluding it from other commands where it is not needed.

This change modifies the handling of per link stats introduced in
commit 82d7f841d9bd ("wifi: cfg80211: extend to embed link level
statistics in NL message") to enable them only for
nl80211_dump_station().

Apply the same fix to cfg80211_del_sta_sinfo() by skipping per link
stats to avoid buffer issues. cfg80211_new_sta() doesn't include
stats and is therefore not impacted.

Fixes: 82d7f841d9bd ("wifi: cfg80211: extend to embed link level statistics in NL message")
Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
---
Note:
- Planning to re-enable MLO station statistics in
  nl80211_get_station() at a later stage with the
  following option.
    1) Consider extending nl80211_dump_station() to support MAC
       address filtering, enabling targeted station statistics dumping.
---
---
 net/wireless/nl80211.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 89519aa52893..f2f7424e930c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7062,7 +7062,8 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 				u32 seq, int flags,
 				struct cfg80211_registered_device *rdev,
 				struct net_device *dev,
-				const u8 *mac_addr, struct station_info *sinfo)
+				const u8 *mac_addr, struct station_info *sinfo,
+				bool link_stats)
 {
 	void *hdr;
 	struct nlattr *sinfoattr, *bss_param;
@@ -7283,7 +7284,7 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 			goto nla_put_failure;
 	}
 
-	if (sinfo->valid_links) {
+	if (link_stats && sinfo->valid_links) {
 		links = nla_nest_start(msg, NL80211_ATTR_MLO_LINKS);
 		if (!links)
 			goto nla_put_failure;
@@ -7574,7 +7575,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 				NETLINK_CB(cb->skb).portid,
 				cb->nlh->nlmsg_seq, NLM_F_MULTI,
 				rdev, wdev->netdev, mac_addr,
-				&sinfo) < 0)
+				&sinfo, true) < 0)
 			goto out;
 
 		sta_idx++;
@@ -7635,7 +7636,7 @@ static int nl80211_get_station(struct sk_buff *skb, struct genl_info *info)
 
 	if (nl80211_send_station(msg, NL80211_CMD_NEW_STATION,
 				 info->snd_portid, info->snd_seq, 0,
-				 rdev, dev, mac_addr, &sinfo) < 0) {
+				 rdev, dev, mac_addr, &sinfo, false) < 0) {
 		nlmsg_free(msg);
 		return -ENOBUFS;
 	}
@@ -19680,7 +19681,7 @@ void cfg80211_new_sta(struct net_device *dev, const u8 *mac_addr,
 		return;
 
 	if (nl80211_send_station(msg, NL80211_CMD_NEW_STATION, 0, 0, 0,
-				 rdev, dev, mac_addr, sinfo) < 0) {
+				 rdev, dev, mac_addr, sinfo, false) < 0) {
 		nlmsg_free(msg);
 		return;
 	}
@@ -19710,7 +19711,7 @@ void cfg80211_del_sta_sinfo(struct net_device *dev, const u8 *mac_addr,
 	}
 
 	if (nl80211_send_station(msg, NL80211_CMD_DEL_STATION, 0, 0, 0,
-				 rdev, dev, mac_addr, sinfo) < 0) {
+				 rdev, dev, mac_addr, sinfo, false) < 0) {
 		nlmsg_free(msg);
 		return;
 	}

base-commit: c5142df58d5a19a0615414037f256cd5ca39f7c5
-- 
2.17.1


