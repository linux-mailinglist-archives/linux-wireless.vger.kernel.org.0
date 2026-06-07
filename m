Return-Path: <linux-wireless+bounces-37470-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fve4ItWxJWpfKgIAu9opvQ
	(envelope-from <linux-wireless+bounces-37470-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 07 Jun 2026 20:00:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0951765128D
	for <lists+linux-wireless@lfdr.de>; Sun, 07 Jun 2026 20:00:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Uy64Y7sv;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=jrNdoPhD;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37470-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37470-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F085E300A4D0
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Jun 2026 18:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912B3313539;
	Sun,  7 Jun 2026 18:00:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349D12D3ECF
	for <linux-wireless@vger.kernel.org>; Sun,  7 Jun 2026 18:00:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780855207; cv=none; b=bTilA2ZRuu4vlOS/3bMoDTvmDrjrAQrtv1bOL1vZ2qUPHDRBZ7MukbJeYPn5v4o9YWmrpmyV7jZS5EjCZHv5EdZf088PK2ZLuGEJfLQZO7X7R6a/ZElzeQjKv6+5Khdy8DJPClfX9fYpEwy7+SzMC/s72rGAYYKcX8tGSd8p9e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780855207; c=relaxed/simple;
	bh=mSdcKPgCtzdGfN32oHqMGgD+A7MwUdli5Q4XSj/DO+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktFjrY9aZI/41HG7m4JEMrp7BE5lwZ3arjtwh9GFVVjJTpEgnWldyMT5iLND32AhoFwGA23+ym6Y0D+L5Gz141RKNu7OsfQPLs3UhusJMFwb+cQM8zwJ94IPK3sQX8yx7DzuXsxq61BkRxfhrm5dVPWWKKlPTolEYS07WBUNDys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uy64Y7sv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jrNdoPhD; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657EkU7A441455
	for <linux-wireless@vger.kernel.org>; Sun, 7 Jun 2026 18:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=IXITkc+tkWQ
	McJ/oIGv5IYMCHMit1ftKb5kgEiFE1Js=; b=Uy64Y7svAp+JJuSTJ093XwcMFb7
	FpQ0J1v09mQUOKHH/PkCY/52gTKbawJPRNHh0eofUB9jRCCmy5p5+Jos4Cspn6LP
	xnpeYt559OP5G4c/ZW4wmkuBwW1dFHMG0BvjT2TGRsxsxVaMGfLpwmBgfVaUdt9k
	k042q/LP8ldkDJAGiAYcDW60jZDUR6yY/hsRainBPQy0/BsDRCVbc2uw7xO8X1bA
	6/xRUdWAumEQPD+UXnqy0kGKUvaw+uOFYHZMaiDIc0pEsd3bDYZAxl5Tg5CAQiYx
	DH7K8zRzeDQDJcXSReJIzVHJNLy3z1eP/XdF1Qlj82ffSGX5/wGQT3PemRg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em98cvx75-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 07 Jun 2026 18:00:05 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c8582b167f7so1821061a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 07 Jun 2026 11:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780855204; x=1781460004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXITkc+tkWQMcJ/oIGv5IYMCHMit1ftKb5kgEiFE1Js=;
        b=jrNdoPhD7FttJ6/p/3Wlkr1JLjAVmW8BzWdNrrx+xwPV6ckus6QxZ+9b+jykTBXsYF
         O0mttrTB64qicdkxyBU2hniby0gp12Y29Lxjr4zN1i7/gT8FKf8ONSpL+JDTw6Sjp+Xw
         NmVy29BLlVvB4xZnsaTJ3wSsJMj+Zff4BqK4SvJvJDXy4ncwkKabfvZgXSPXcX1hEP4b
         Q0dJVNLZG5NFS/FVCuZ2u9t0R5oGtwlo9bujhAMpyQZTAvhg2cKmrCuOeRrGAHfK+FAk
         MX2jfG6JcJfl0+lyGuqu0R/N7VysqkjXvCQ/wTyNt0rMiWjhdfLjMCPtsbF13FDy0i5c
         AcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780855204; x=1781460004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IXITkc+tkWQMcJ/oIGv5IYMCHMit1ftKb5kgEiFE1Js=;
        b=kYviSyg+nuEKc7Dw0lJKgM1f/z0LC5KOI60OGmoWY0Y9hkJUfSaxGWzka4vjlqYJyU
         9NjkmiTweDmI4Rj2gcFdaCLVF1LT8WKomfyIGbS0I5yTf0vWefEMuDtGaeIg9Q+2cD9g
         Rs18s7ecpotRLVJC+fZK861zCZCvayVRoNvQO1Ik4rLwPChIbpWjjIM/4da0kf0OO2Qf
         dG5m/Z2HVHx0PSgxNxe9tFefpAWL7TAFIa5HTbcN2Y2MqUvdB3LBjCVcfQwejwOtYjpA
         dbjQzQ2vDo7aXg9PPGC9tPi2uvpTnII1HjnS3CoBHeloWco9x9VTjE8wpRd8Ccbp+cDq
         0pQQ==
X-Gm-Message-State: AOJu0YzkIgAqySrY51h87AwKUl9NV50WSmaTuLWZ8xrkljWX9LTQxtzE
	XWc63lsLHYVz5ELan5LdanbkB3GaDgiCxanTOC40zorJbuvdjOAsYR+FjsNTLiOpKRLiTvt8JFv
	7xpjCn+NBc208zRz8GZ9LA1KMWRpDcYBo6Xdnte0vLmlr977IEFCAquqwdjFy2RDA+Rg6z9x0hK
	6a9g==
X-Gm-Gg: Acq92OFQTU0ZwzZaU5sMXBctg0A5Z4dcm8k9yGg151WdkZRoJQ2sGxpEz7PIc11M4Yk
	GdGrAyqXclGz/zV/q0+XcmmPUAZl977BGJWxLLCG3iGIkXdzApGKhpemxdp5Zj4C7fUUL2uSDrU
	+9RzqlGvZqcsMa2TNMOKJk4/Q6Dv5rpaEJnfhAllBK/5D+iJEIQWYSkWU6qQsBYH2B1dTp3mvps
	LbQBcAwdexuToClSuoDcKWqWO4eKJy5gPC8sgzWTHCblbIFc6ZZSm7wmCHb1YkzyF99j/byUAia
	7asCVPu8Y1RlES9P4AzbyMa1uVzv8C74cYaOkGtHLkvlg5l378zGmsHB9LonLi7Je4VUg64LbWb
	y17YuCf0djD3jjQGHwJ0SWcWu3j9pM/RuDcwvBUmd7XTxfqDkCe+REVMQKFLhbVc7RUGie5B6p3
	euJOT/HS+Us7LZzBhvVoahCkKATMogHjOD4vWLnHeL9w54z6Yxig==
X-Received: by 2002:a05:6a21:6f0e:b0:3b3:1ee3:2796 with SMTP id adf61e73a8af0-3b4ccd00046mr15508161637.1.1780855204266;
        Sun, 07 Jun 2026 11:00:04 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f0e:b0:3b3:1ee3:2796 with SMTP id adf61e73a8af0-3b4ccd00046mr15508136637.1.1780855203782;
        Sun, 07 Jun 2026 11:00:03 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a624fsm13078522a12.18.2026.06.07.11.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 11:00:03 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        praneesh.p@oss.qualcomm.com
Subject: [PATCH wireless-next 5/5] wifi: cfg80211: support MAC address filtering in station dump for link stats
Date: Sun,  7 Jun 2026 23:29:12 +0530
Message-ID: <20260607175912.2266215-6-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607175912.2266215-1-praneesh.p@oss.qualcomm.com>
References: <20260607175912.2266215-1-praneesh.p@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDE4MCBTYWx0ZWRfXyBYz/ldt5XeP
 mFudZ8DhUHG5YEm2RIlxE4glHnxq0iqcuIHRHTLjAZpJE7hOLhEhINQ1oPA/Hcvmqvx8ZACDR6Z
 tP9sbemtgqu9o27S7fnXjLue6yIjlkomok7oTKpliwN8zbaw43DDj6yAT9+TO34CbbJj0TcnCdJ
 Q/ABS/RhuiFubB8dVfjcFcSg1dig/HIq6n9B+VQDHA0xdM/lOwTc2LMqPy6NNxsgqEbAUCLLQ7K
 qnvwpNH39wa5wxtZJ3kkAnzDhpdivt5e1ZNZxbj9PI5gNodksODIi0eJzimO4w9UdMr1Nd5MPJ0
 9q8RnupGwXhlsafNnKosystQxuSsHACmD4uB62W21fEuPV3y9Q/a83OhQCHRuphNzE+tdqOcHL3
 keeEt6WxR3r6iYeP6R2Q4Q+UZM5XAO/E8Z5hyOvxcBpukskr9jZtPBshUHBUeEd1HYMz3SCMbGJ
 zzOyg5YtjorzuEb5H4g==
X-Proofpoint-ORIG-GUID: R5cjsuASKKBYDhvKegDeivJISnMzkQkI
X-Proofpoint-GUID: R5cjsuASKKBYDhvKegDeivJISnMzkQkI
X-Authority-Analysis: v=2.4 cv=A/pc+aWG c=1 sm=1 tr=0 ts=6a25b1a5 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=pcWKcSKorTg-uW9tO98A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606070180
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37470-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0951765128D

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
 net/wireless/nl80211.c | 44 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3dba329c7eb2..209df747e53e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -56,6 +56,8 @@ struct nl80211_dump_station_ctx {
 	enum nl80211_dump_station_phase phase;
 	int link_idx;
 	bool dump_link_stats;
+	bool filter_mac;
+	u8 filter_mac_addr[ETH_ALEN];
 	u8 mac_addr[ETH_ALEN];
 	struct station_info sinfo;
 };
@@ -8618,6 +8620,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 	struct nl80211_dump_station_ctx *ctx = cb_data->ctx;
 	struct nlattr **attrbuf = NULL;
 	int err, ret;
+	const u8 *mac_addr;
 
 	NL_ASSERT_CTX_FITS(struct nl80211_dump_station_cb);
 
@@ -8650,6 +8653,19 @@ static int nl80211_dump_station(struct sk_buff *skb,
 		ctx->link_idx = 0;
 		ctx->dump_link_stats =
 			!!attrbuf[NL80211_ATTR_STA_DUMP_LINK_STATS];
+		if (attrbuf[NL80211_ATTR_MAC]) {
+			mac_addr = nla_data(attrbuf[NL80211_ATTR_MAC]);
+			if (!is_valid_ether_addr(mac_addr)) {
+				kfree(attrbuf);
+				kfree(ctx);
+				err = -EINVAL;
+				goto out_err;
+			}
+
+			ctx->filter_mac = true;
+			memcpy(ctx->filter_mac_addr, mac_addr, ETH_ALEN);
+		}
+
 		cb_data->ctx = ctx;
 	}
 
@@ -8661,7 +8677,12 @@ static int nl80211_dump_station(struct sk_buff *skb,
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
@@ -8679,8 +8700,25 @@ static int nl80211_dump_station(struct sk_buff *skb,
 				}
 			}
 
-			err = rdev_dump_station(rdev, wdev, ctx->sta_idx,
-						ctx->mac_addr, &ctx->sinfo);
+			if (ctx->filter_mac) {
+				if (ctx->sta_idx > 0) {
+					err = skb->len;
+					goto out_err_release;
+				}
+
+				err = rdev_get_station(rdev, wdev,
+						       ctx->filter_mac_addr,
+						       &ctx->sinfo);
+				if (!err)
+					memcpy(ctx->mac_addr,
+					       ctx->filter_mac_addr, ETH_ALEN);
+			} else {
+				err = rdev_dump_station(rdev, wdev,
+							ctx->sta_idx,
+							ctx->mac_addr,
+							&ctx->sinfo);
+			}
+
 			if (err == -ENOENT) {
 				err = skb->len;
 				goto out_err_release;
-- 
2.43.0


