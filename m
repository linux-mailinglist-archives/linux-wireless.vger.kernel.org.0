Return-Path: <linux-wireless+bounces-37780-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gduJNaM5LmqbqwQAu9opvQ
	(envelope-from <linux-wireless+bounces-37780-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 07:18:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A216680625
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 07:18:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=kRBdEthx;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=BgmGkgtW;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37780-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37780-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D58C730039AF
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 05:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C043818BC3B;
	Sun, 14 Jun 2026 05:18:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74832171BB
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 05:18:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781414304; cv=none; b=Npu5nfsWW6pi1cZ709xdGls1u3jrXYJZNjJDm/NC7Barjr9GSPvPYYBwZojmzJXPGjM0zK66cpf93U1yMTt6QxS2hXGyOGjjK4coK7DFDTPAqssmfQ/WiQ0UFdWMN5n6m0oVMVuvqQTVaZpCxqvzPC5/UQ/mn1TbO33fsxtI1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781414304; c=relaxed/simple;
	bh=xyNk5DZM50Hk/oBSPWBgREFk9DRBbzASQSJb4R638Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYZCqKwhNYgPG0dAQ3CWAvIWbp67r8hQg/p7SlL5eFz8F84x1V7iNVeWb07TSLyVw+xQEw4yWwcJNOolPZN3y/F1LXN6vOzwomkv7Y69B9KZJIlSJNHujAinqPFxNF6lvehSaNoZUR0rW+oEzptIJoeuNn8tHRlrG/FYSdRyRq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kRBdEthx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BgmGkgtW; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65E49GSG2799515
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 05:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=EiKLOiDVudl
	QGkTMkHnlpYL7j4GbMZyPsHezGFhbg+8=; b=kRBdEthxlh/q7uir2Vpqxhx3Jsq
	eFoBXsdL387n1KpUdc16+IjgUwXtEzWySQlhSSS9khGv1NnlpI1tMwdDysl9aLWU
	rrOw8C/TWtIl3WiORplV9wx5Ktahwh4UPpmmRuLQTtpr3TG2HQBo4gtfxjoOAxc1
	zyCvxnwmisEJWbeOh6GJQ4xdghtGGhuNvgqj9Mif72XX1lkVNVCkIpyc6NEK67J+
	aZZ1WJKvWVM31Eau8/ctaYx2tEi1BoVuhSzzudFevr9SgVEJsb1mHj1udFP6SXpe
	QqP05xrZbP+pVeScQWmw3j6VHtxRpCby9UbbP3QidahdUNAuFH/XLp8hZXQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eryffjr2q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 05:18:22 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c0c32faa62so36708805ad.2
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 22:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781414302; x=1782019102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiKLOiDVudlQGkTMkHnlpYL7j4GbMZyPsHezGFhbg+8=;
        b=BgmGkgtWKYRnF1W3c34sA32+Fy7W1TuzZ/kek8TpFE6PwyC/tSw4LH8si9s3JUVv2o
         4yNO6Qzz7onmQLrkmNYlyqLwO5oIB2OlTsUO/KInrHgsaW+Em6od3O1zzIUAl0OaD4SV
         L2I2VsIl7LMQinni8rXEKJkr3maQBpF0deKd8G+M3CJPRV+UveiQSstZpIHch+DOUXoR
         dsBkg1XTLOC0qLeqk28VxmfBYrB4BvhzviqsAB92HOUl8B42rjoJ/V11/3utrTDdxEnO
         E83mSAp7H1XJbyHPnc7UusPie1Oei4IE1BZMhNfRayF/DiD4PXPrkbsxvAGf6ILeQvM5
         hAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781414302; x=1782019102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EiKLOiDVudlQGkTMkHnlpYL7j4GbMZyPsHezGFhbg+8=;
        b=IZMYLsNY0DWdHLtQuYaOkHz6o+erRnZsRf1NdzYXDYnhkK1eUCeIH6nLKpD0ybC6xB
         4Zj/ev2f2WyCLH5wJdD0d0K+88jAs/CkXM0wrUuQmICFNJbbJ8m4PF4bqQgqGKkg+2w8
         sXZEkhKWq8BIOrLrQ1XBJK1T4UiE4UgWH2SnouebxxL7SLFRLJxppf56pLD0WdqYtVvH
         IKaAa0qCbUxielkhs5CQ6rvPeJD4uOPwylX3ZiyhAxVHiS5Os3wrxLEQ4A1Gi/4oDgmD
         IvKeSigL/8ljpBhFfTgHNYxKZRLXYNJisNVhE3d8GIMnPsE5A+KY3qbonikCMqO0mRE7
         kRvA==
X-Gm-Message-State: AOJu0YwE041B7l42XYAsjhxKm/c1xMy2IX29LqoFxapJVEe9RdRXHGCf
	8Tald1uN2q0w35EqsG922oZrPwbNCplB86eB+JLKUWKLXsBfv+HW6y+OIpESbwPoKl3XEe+8oQu
	UQPUt8nrXMiq2a8wbOV/QoIwKMnbHP25C970Q1s99od2MbDyKqqMX7mvn5rL4o8+ZHuR/rw==
X-Gm-Gg: Acq92OGMydP9+KxUP1BJretCTBJXgJo4vlJL1GNf9MrD8yOmrYScZOHbVhg7X1MMyxy
	g9znHrgYOJXxLzlcmLnMQbOp/WcAwxI+pdUWZakpajpvjuJMpg7y7nx39ginkLtNyeybKQOOpV+
	YYUay5PbiFByfKvkfTDbSs8mDn6O3e7S8IIpQUDsJ20BVpGno5c4juGx7FCWksvxN8H4vk75GrQ
	/BEXmjAwhSy6z8fG7Vh7xpFZi/NknaXn63/Gyrk4qpMF89E+sBYyNrqZmC92QK9VKvLfRHxAXBK
	/bckQCHUvSGfe6BWqsfVHifrs4i2pp9GzxRVdQcp+b4t+oMALALqWzSeRZ5vUGSvWghAbHX+daZ
	uaw6ThYP8HhTuM6LwEvlDNBvBO2+2hYTjSmydELO8cNBwz3oSEcN1JYmedFXKmluJNDlyeKVm0x
	tGBj2gIn0t3sSuIDBj6UkUG+UnJggqAebP8dSGIrw=
X-Received: by 2002:a17:903:46c6:b0:2b0:6a22:5165 with SMTP id d9443c01a7336-2c41050a155mr109935345ad.7.1781414302029;
        Sat, 13 Jun 2026 22:18:22 -0700 (PDT)
X-Received: by 2002:a17:903:46c6:b0:2b0:6a22:5165 with SMTP id d9443c01a7336-2c41050a155mr109935095ad.7.1781414301565;
        Sat, 13 Jun 2026 22:18:21 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c651dsm64456705ad.26.2026.06.13.22.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 22:18:21 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        praneesh.p@oss.qualcomm.com
Subject: [PATCH wireless-next v2 1/5] wifi: cfg80211: Drop unused link stats handling in nl80211_send_station()
Date: Sun, 14 Jun 2026 10:47:31 +0530
Message-ID: <20260614051739.3979947-2-praneesh.p@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=HuxG3UTS c=1 sm=1 tr=0 ts=6a2e399e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=9HtPZ92rRTiFI9LOixoA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: e3vlnJ56FU08lFnkrugToRoXjuobvIBX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDA0OSBTYWx0ZWRfX+oprFxbyujWb
 Cxm/dbkLea7qNhxS3SWFv+IoSL7ENEfsRdvfNDViGiD2XKQgRwWTWuZxme47KUt/LwKrXzUxdIP
 oMAwrekvxmeBl4SDgK//WSrrdmonQoA=
X-Proofpoint-GUID: e3vlnJ56FU08lFnkrugToRoXjuobvIBX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDA0OSBTYWx0ZWRfX4EGOu32w+rJj
 /V4/7FMaBaqxPwlXpr5JrOBww8RQXBVwUdnB8CHSm5crrnpNCtrCkwhT3kq8F7eDr3FWRqDJ0+F
 M5kjOx5+rmwEJmskyjA0SfCCDL75tluUH7ztkkQeeCBt4/rxmls3YKJ9t/wEZYopiDiLotGnv7g
 MrJnsFPg02RNbnmoDt3/mPSft5IfiW/aPRssnuYuhozEBnnMMnOMT+qFsb6TYaCSGSKQRfWOeF0
 Dl3n0UdhDlHiQIz6FstAhIOM67fzeljG225rnDNkg6mdjz8/srDQmv7iSKcPSJp0xuHLE2GQUbd
 cG8mUU8v6gCPKzKB6Gr7BgFNh/ZLlGEttsaYJl2a3tSv+pIsecesKLVL6eG6B+f4CBE8lRl8YOx
 JuR5ZgrZbC6IH9q97Kizg5ajiQbnCw+2bHXBhf34D/CxpHDUzOSfKbF/5vSIJxxnbQw3xm3iHFa
 NDeqB1+szs6SEXNOQcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606140049
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37780-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A216680625

Remove the link level statistics handling from
nl80211_send_station() and drop the unused link_stats parameter
from its signature and callers. The removed code iterated over
each MLO link and attempted to send link specific station data
through NL80211_ATTR_MLO_LINKS, but this logic was never used
because link_stats was always false.

This logic was introduced during early work on link level station
statistics with the intention of reporting information for each
link. Due to message size concerns when a station has multiple
links, the feature was disabled behind the link_stats flag and
remained unused.

The link level reporting block in nl80211_send_station() is dead
code and cannot support larger messages, so remove it. This
cleanup also prepares for proper link level statistics reporting
in nl80211_dump_station() in a later patch, where fragmentation
allows safe transmission of multi link data.

Also fix label indentation: the nla_put_failure label had an
erroneous leading space.

Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
 net/wireless/nl80211.c | 50 +++++-------------------------------------
 1 file changed, 6 insertions(+), 44 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 53b4b3f76697..98548e69b5fc 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -8033,14 +8033,10 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 				u32 seq, int flags,
 				struct cfg80211_registered_device *rdev,
 				struct wireless_dev *wdev,
-				const u8 *mac_addr, struct station_info *sinfo,
-				bool link_stats)
+				const u8 *mac_addr, struct station_info *sinfo)
 {
 	void *hdr;
 	struct nlattr *sinfoattr, *bss_param;
-	struct link_station_info *link_sinfo;
-	struct nlattr *links, *link;
-	int link_id;
 
 	hdr = nl80211hdr_put(msg, portid, seq, flags, cmd);
 	if (!hdr) {
@@ -8258,45 +8254,11 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 			goto nla_put_failure;
 	}
 
-	if (link_stats && sinfo->valid_links) {
-		links = nla_nest_start(msg, NL80211_ATTR_MLO_LINKS);
-		if (!links)
-			goto nla_put_failure;
-
-		for_each_valid_link(sinfo, link_id) {
-			link_sinfo = sinfo->links[link_id];
-
-			if (WARN_ON_ONCE(!link_sinfo))
-				continue;
-
-			if (!is_valid_ether_addr(link_sinfo->addr))
-				continue;
-
-			link = nla_nest_start(msg, link_id + 1);
-			if (!link)
-				goto nla_put_failure;
-
-			if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID,
-				       link_id))
-				goto nla_put_failure;
-
-			if (nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN,
-				    link_sinfo->addr))
-				goto nla_put_failure;
-
-			if (nl80211_fill_link_station(msg, rdev, link_sinfo))
-				goto nla_put_failure;
-
-			nla_nest_end(msg, link);
-		}
-		nla_nest_end(msg, links);
-	}
-
 	cfg80211_sinfo_release_content(sinfo);
 	genlmsg_end(msg, hdr);
 	return 0;
 
- nla_put_failure:
+nla_put_failure:
 	cfg80211_sinfo_release_content(sinfo);
 	genlmsg_cancel(msg, hdr);
 	return -EMSGSIZE;
@@ -8549,7 +8511,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 				NETLINK_CB(cb->skb).portid,
 				cb->nlh->nlmsg_seq, NLM_F_MULTI,
 				rdev, wdev, mac_addr,
-				&sinfo, false) < 0)
+				&sinfo) < 0)
 			goto out;
 
 		sta_idx++;
@@ -8613,7 +8575,7 @@ static int nl80211_get_station(struct sk_buff *skb, struct genl_info *info)
 
 	if (nl80211_send_station(msg, NL80211_CMD_NEW_STATION,
 				 info->snd_portid, info->snd_seq, 0,
-				 rdev, wdev, mac_addr, &sinfo, false) < 0) {
+				 rdev, wdev, mac_addr, &sinfo) < 0) {
 		nlmsg_free(msg);
 		return -ENOBUFS;
 	}
@@ -21635,7 +21597,7 @@ void cfg80211_new_sta(struct wireless_dev *wdev, const u8 *mac_addr,
 		return;
 
 	if (nl80211_send_station(msg, NL80211_CMD_NEW_STATION, 0, 0, 0,
-				 rdev, wdev, mac_addr, sinfo, false) < 0) {
+				 rdev, wdev, mac_addr, sinfo) < 0) {
 		nlmsg_free(msg);
 		return;
 	}
@@ -21665,7 +21627,7 @@ void cfg80211_del_sta_sinfo(struct wireless_dev *wdev, const u8 *mac_addr,
 	}
 
 	if (nl80211_send_station(msg, NL80211_CMD_DEL_STATION, 0, 0, 0,
-				 rdev, wdev, mac_addr, sinfo, false) < 0) {
+				 rdev, wdev, mac_addr, sinfo) < 0) {
 		nlmsg_free(msg);
 		return;
 	}
-- 
2.43.0


