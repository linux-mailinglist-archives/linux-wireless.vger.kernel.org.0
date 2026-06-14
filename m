Return-Path: <linux-wireless+bounces-37784-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BGuHG8Q5LmqrqwQAu9opvQ
	(envelope-from <linux-wireless+bounces-37784-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 07:19:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A9A680637
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 07:19:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Z8v14gW9;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=JzdCejaT;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37784-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37784-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB061302262D
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 05:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBD7313546;
	Sun, 14 Jun 2026 05:18:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2B1171BB
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 05:18:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781414318; cv=none; b=HSB80QcUzHkGl/wr76hRuo65TAvU9MuVkHXEq1JzSHLOiSWBNkp0HmymDTrZufJwTymhod35JUUn9Pw99ReSbu+usc0AqPxUUkysc0N+aQ9VpOlE7iZdtf66egWe9TVnO2s1y4ynJfIkO3UNV87GIilJBsPa6EPsM5vGVx3Yh3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781414318; c=relaxed/simple;
	bh=dbqzWpYpAfd64CalqgGMHYiYtW4Ci9WQaOHUiN7Fl2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oP4uw/EZLK0NaDI2xU7AtavsYX7sUlHSoj0pX8RPjJFJVwytpt13Ec5sQ1I+mPjCW/Vs78O/leO7mYAK5IPXYAKuE+Xb5vwKRP8d6aY9FWa5Gx6YwI8afDIEEahg4mwpFr+yPthJMCRflQN0QqaAP9qX0/qrpHAtjb9kW59OzEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z8v14gW9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JzdCejaT; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65E48cIa139883
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 05:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3xcsC7PWMWF
	2K4chMPT3Qgjge7/FQUrHZN5Z4nu+yEU=; b=Z8v14gW9gIyzoNU1NmDesbyTAgN
	pfkDVWPWLLW6GjdpOuaMOXA9GNGIRT+jfjudekFVCqsjlMxs/Dg4S69TbLr5tYmO
	8BtY5qjc9pH/VdYHd3WFEyLqLIMxhYfxPjySkOaKNhUxeSS5h0c7K5h3nIe52XqH
	q7UOjdTQSadM6bbexmnEvLtNU8ED7kEDrb+n4YpCqiLspFIrQ0IeWasVb6Y0BLNZ
	Qs114FhzoU6FpPYSpYrb/dr9cZY1bxudFnB9Zy5eGKbElrIkyheQFL2WmF+eioTe
	Exuhd2gcbcU5i+c8ImkYPEiTV/51ZlhYBY+39pqp4HquSzyJQUEI2H9CPwA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4es0g82pta-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 05:18:36 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c85dc345ac8so1172734a12.1
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 22:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781414316; x=1782019116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xcsC7PWMWF2K4chMPT3Qgjge7/FQUrHZN5Z4nu+yEU=;
        b=JzdCejaTiy3fui5ypG+nfoAnkg5jlZ4qcRXX3/iAJraZDORC0RLDJfChd2BGSbeEcr
         nTIsgWdGPJJeQf+boL1t6wgxn/wLr1qr6zs+qjgTXErnH+uSj6HIVBGRSL+F5XXWRBnH
         14E5HUMcN87IDd3QCK4PvRqAGpAyJSpdjkEaoR8OmfISoiYFRndwgyNwDI9MXHBdr4lQ
         iJvNYSjDPUw3eoZKqbNlWH06yZpvNejfFuU6MyPvXc/2E21AyVVwh2ZamiaF8FHYE7i1
         Jo8pU5fiCm7mzFrCByBaSCmrLss+TDUWHxhMXKfsfNaV06Mz128+dsZay0cQ8CSLzzpM
         CTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781414316; x=1782019116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3xcsC7PWMWF2K4chMPT3Qgjge7/FQUrHZN5Z4nu+yEU=;
        b=C/ynaHGDtAnL9FnfIzTNLRpJYFzE5g1S336BwMp4BwUJwDovJvlGuXRNWdXoj6yI/V
         zX5j4r7di3h/CyDvWzrFK2hE+XzqrrwXatjU4wFxm8IVjGFlw+KYhPHWcDpr3SBooZ4y
         xnpcPj/PwStYS5WdENI7id6+rB6i+s/+1u1/Ha8y5NaeWOe/CoFV25qw0OJuNkmE5MuE
         5BxELne5UqfSEbN4Mr5Esut+3ZqF9XDpE13GCg4MC8XRdcfCLMkxBJLVf86ZXCOKcOzV
         QuooCcRU8+KlSce56WalMHU4KyEJ8NzgK3xQ0vDZf2hTAqnoPcUsdZXKqNfmCBmYv/6n
         W8Vw==
X-Gm-Message-State: AOJu0Yzqo0eqUO4pARhQ6hFpUXFiMSZssMeoI+OKsk4wVzTw57a1nYvO
	MN4VFUYFfzUElCvEVTCIKkkGBwnO6hibuiXyyNbKWPq8TD3qky/DWwNEpaXMyEz10tbr479cGNp
	mUBaXstwna/pMIWhoYOapcV85yvTgW1JL4XosJ4FIdqr5QU/B17Psq5C2Q5yv+l/04cVdTI6XSq
	nw4w==
X-Gm-Gg: Acq92OF0PQH1Qkcj1pC2btlyyNYRPAMVPa4Xh3u6YBlNes9d5ck1+P8X2ldtuaQnAzC
	7/eDD0rr1QsnwZ6KjFmQ9zwVhFt5SOPi6PCBu+3Ufc0D1GPwHMB7rjC+jxVM0MMYI2p8L6gJz0Z
	R/Lvh8FoGc1tqr+ZtxPv9Zu/DogjsuI/GqIRjoQs6ML6lS6631CzU6Px/7tZ4e+DL9qofB2HUX6
	Eetqc12WWX++ika6ByWhqonsYUtZv4RszumhCbp2US9LDuLAftvsYFwO9kb1iBDeKuUrd5AtO26
	XsboaIbLj6NX7zqA+KPMPq50tAEtQCoGSINMXf6wfPpfgnzufUgU6djkIUS/EHK+PzW9dSwUJy2
	Yeb+fj/aYrX9QxHAFwXu5rY+mBXaSXYde08TvA9welkyO52ANkg+Eg8HKLJyQFabq7ugTR/eNXO
	3uVqaxTmqVhGAXSToVqQujZnqblZ/P8iYuNxbPzew=
X-Received: by 2002:a17:903:b46:b0:2b2:5515:661c with SMTP id d9443c01a7336-2c6642b0dc3mr55466465ad.31.1781414315747;
        Sat, 13 Jun 2026 22:18:35 -0700 (PDT)
X-Received: by 2002:a17:903:b46:b0:2b2:5515:661c with SMTP id d9443c01a7336-2c6642b0dc3mr55466335ad.31.1781414315272;
        Sat, 13 Jun 2026 22:18:35 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c651dsm64456705ad.26.2026.06.13.22.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 22:18:34 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        praneesh.p@oss.qualcomm.com
Subject: [PATCH wireless-next v2 5/5] wifi: cfg80211: support MAC address filtering in station dump for link stats
Date: Sun, 14 Jun 2026 10:47:35 +0530
Message-ID: <20260614051739.3979947-6-praneesh.p@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=OOoXGyaB c=1 sm=1 tr=0 ts=6a2e39ac cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=pcWKcSKorTg-uW9tO98A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: iag6pLAx3SG-Rb9StfW03seWMuGkFLXU
X-Proofpoint-ORIG-GUID: iag6pLAx3SG-Rb9StfW03seWMuGkFLXU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDA0OSBTYWx0ZWRfXz8cDsHK6TdeK
 XDRuXVG1LHCL68n3ZzAUKThUKIHhBO1laOoI8jgA1an3YoAZk7TK6Cb7/nxiH1QrmpjuxiNJrbf
 NlsNFFDbRrcvToeBnCQWMU5B+JS9gwpOl/4MgqwJzI/J5V3uUsNjAVPdA0iLQzmGVJPBfkxwuXG
 siG2xr1hpXxHj6eiew6B8uySRpym82wbm50UKP/6xUve+tG9E2aZ5WtZVlEPImm+kl3MWKQ9Daq
 NogAC8uESmC61NqCMrH62JSg+yzQRefq/yIiLFnbSbxrFtLodBxQ1Kj2v2G/tABikVWD5CRfGqB
 zC97vIv0YlzxRxb+YzYdGN8BKkfAbq5BXFzfNCzMjy8RdJF9hSbdRMi5OjU/ibDlaNxi1fmUD9P
 nd+IzfebdDmRyj6VHKSUs1RS1M9J9tyAii39lEnMWlfR4HKX2UKiVUQkFAdxD68xu6zJnZFNaDb
 KkTDqeAEUsltx4CDafw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDA0OSBTYWx0ZWRfX1p70H6RzGcpu
 tXiLVGTsEFJP3LzNOKdHagUyxIBpoSDgieAzh27mzAl+USjRRG3tqSeG/tiFKfnsQcCpfIiHNAw
 YrpHIQDwWywTu+U3IuKqyHc7lint7Ew=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606140049
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
	TAGGED_FROM(0.00)[bounces-37784-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04A9A680637

Currently, when userspace requests station information with
link statistics using NL80211_CMD_GET_STATION with the
NL80211_ATTR_STA_DUMP_LINK_STATS flag, the kernel uses the .doit callback
(nl80211_get_station) which sends a single netlink message. For MLO
stations with multiple links, the link statistics can be large and may
exceed the maximum netlink message size, causing the operation to fail
with -EMSGSIZE.

The .dumpit callback (nl80211_dump_station) already supports
fragmentation across multiple netlink messages, making it suitable
for handling large link statistics. However, it currently iterates over
all stations on the interface, which is inefficient when userspace only
wants information about a specific station.

Add support for MAC address filtering in nl80211_dump_station to allow
userspace to request fragmented link statistics for a specific station.
When NL80211_ATTR_MAC is present in a dump request, cache the MAC address
in the dump context and use rdev_get_station() to retrieve information for
only that station, instead of iterating over all stations with
rdev_dump_station().

This allows userspace tools (like iw) to use NL80211_CMD_GET_STATION with
NLM_F_DUMP flag to retrieve complete link statistics for a specific
station across multiple netlink messages, avoiding the message size
limitation.

Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
 net/wireless/nl80211.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 6910dfa7343e..f9818d4cca90 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -8474,6 +8474,8 @@ struct nl80211_dump_station_ctx {
 	int link_idx;
 	enum nl80211_dump_station_phase phase;
 	bool dump_link_stats;
+	bool filter_mac;
+	u8 filter_mac_addr[ETH_ALEN];
 	u8 mac_addr[ETH_ALEN];
 	struct station_info sinfo;
 };
@@ -8543,10 +8545,22 @@ static int nl80211_dump_station(struct sk_buff *skb,
 			err = -ENOMEM;
 			goto out_err;
 		}
+		cb->args[2] = (long)ctx;
 		ctx->phase = NL80211_DUMP_STA_PHASE_AGGREGATED;
 		ctx->dump_link_stats =
 			!!attrbuf[NL80211_ATTR_STA_DUMP_LINK_STATS];
-		cb->args[2] = (long)ctx;
+		if (attrbuf[NL80211_ATTR_MAC]) {
+			const u8 *mac = nla_data(attrbuf[NL80211_ATTR_MAC]);
+
+			if (!is_valid_ether_addr(mac)) {
+				kfree(ctx);
+				cb->args[2] = 0;
+				err = -EINVAL;
+				goto out_err;
+			}
+			ctx->filter_mac = true;
+			memcpy(ctx->filter_mac_addr, mac, ETH_ALEN);
+		}
 	}
 
 	if (!wdev->netdev && wdev->iftype != NL80211_IFTYPE_NAN) {
@@ -8554,7 +8568,12 @@ static int nl80211_dump_station(struct sk_buff *skb,
 		goto out_err;
 	}
 
-	if (!rdev->ops->dump_station) {
+	if (ctx->filter_mac) {
+		if (!rdev->ops->get_station) {
+			err = -EOPNOTSUPP;
+			goto out_err;
+		}
+	} else if (!rdev->ops->dump_station) {
 		err = -EOPNOTSUPP;
 		goto out_err;
 	}
@@ -8575,8 +8594,22 @@ static int nl80211_dump_station(struct sk_buff *skb,
 				}
 			}
 
-			err = rdev_dump_station(rdev, wdev, ctx->sta_idx,
-						ctx->mac_addr, &ctx->sinfo);
+			if (ctx->filter_mac) {
+				if (ctx->sta_idx > 0) {
+					err = skb->len;
+					goto out_err_release;
+				}
+				err = rdev_get_station(rdev, wdev,
+						       ctx->filter_mac_addr,
+						       &ctx->sinfo);
+				if (!err)
+					memcpy(ctx->mac_addr,
+					       ctx->filter_mac_addr, ETH_ALEN);
+			} else {
+				err = rdev_dump_station(rdev, wdev, ctx->sta_idx,
+							ctx->mac_addr,
+							&ctx->sinfo);
+			}
 			if (err == -ENOENT) {
 				err = skb->len;
 				goto out_err_release;
-- 
2.43.0


