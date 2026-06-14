Return-Path: <linux-wireless+bounces-37783-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1oYWFL05LmqmqwQAu9opvQ
	(envelope-from <linux-wireless+bounces-37783-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 07:18:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB85E680634
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 07:18:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=dsDCfBSv;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=TH5Itxkh;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37783-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37783-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B61EA301E947
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 05:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B4C18BC3B;
	Sun, 14 Jun 2026 05:18:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36611171BB
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 05:18:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781414315; cv=none; b=LQvctRgNOm45Svabx866zrXwJZ03ahYl09GX9OteNqhGd0hNQPir7W3uymkgRdYoUJFneuCezPDttI1nZsMkmczXjoeVnK3Nyu/rHJQxE0W/vJHFJUagmSVeuLkN3YmHA4VWCylV5ty2UO3w2jG7ie1lfjolgGbgp/0VOCPx2Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781414315; c=relaxed/simple;
	bh=eZpzShBvYsDYf04V8zy0bDiA03vrgx3rU5g0YHmR6TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCaZdPu4wu9B4C2dzM8dbqEpjdIDMrPoV5bna1Zi3waXGCKrhlVcIqNby5KktwS0pcA3gA0g3viIVNAaQdf44RIiMBegLd30QsvUFwwSjQBN2Q8wADh7DNTtRkR3FsyxHuPmc6ZuBvzejaPFMSDoeuzwwXsO+YQ5P8OVRrRPxUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dsDCfBSv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TH5Itxkh; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65E48asq126291
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 05:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rCooeqOaEv4
	I7HLFPq20wnPAfqQPMybGkbd4nqm+hXw=; b=dsDCfBSvIfamYKCquFjmxm0Ke/b
	xYrxLLQVhUbzIyehQKHTSWXmOeZzjFrs6lSqAP3CHnL+ZRmgsuWS1pGXw+yFm9Ck
	shzt9wR5sX8IFRuXy39XUSIgEHC7x3xO5hqS2OlU3oaHh6iAe+HUpXCkvaMGMQnK
	gMqFD9/MHEGpnjMzLRyPedpfeFqIaumDR3P4D+gIxMp3pWNGCMR0ErAzuVfeJdxB
	5AwVHbR9FxO8eiDsVrfQZq3p87abHIiSBp1wazqTYeT17JVoGAxpY7MYLOa+X9pb
	dlvdBOO8kZF3SxB65pxYTRjCh2NWL9nwfko+BMeOec54O5ofBpMgLE+FRZg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4erye12sb3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 05:18:33 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c85a2cda4d0so1063938a12.3
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 22:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781414313; x=1782019113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCooeqOaEv4I7HLFPq20wnPAfqQPMybGkbd4nqm+hXw=;
        b=TH5Itxkh9yIpzFcd8cZKov8jntezV6HJAFE6S09X0EbkTc9vMKcckqX/AMlUlM4fcD
         1hTF2X2uTpHLjLIU05VfAd5PVgxm93Gh14tuWymZ03Ax+qgTIagrZCauGepD9T4fsdsL
         Aj+yjXg+P5itNa2oUkS9Yeztkt3faz3ZeiagcOjKxEAKjxJ9w+cUlZvcBfloP7VEB+vV
         Bao93hk+DGJ1f/ap44UH/fCtU3Zak2gisYILFI6ETEuXnM6zmq2Dny2jabQwAUaAtUSR
         hjlkO/fi5s0D1td7b6gJzgTYyZ9ey+dFJmipJ7VMuNBe+DG923QvexyGhsH90mwu0Ws8
         BDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781414313; x=1782019113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rCooeqOaEv4I7HLFPq20wnPAfqQPMybGkbd4nqm+hXw=;
        b=EtK6GoE6jfU/eG/WvjToaqNnKynFbFycL9x4q3wlGE/siM3egC5qZZuhIusQw1RBN8
         2cEKMPds+PVMEsPGVEcfvktsIx1PsA5CqSAC7iQBTNxEVBRkLHskNFa+Dp4PFmGDIg/j
         yC9FonTeqGg1CweZextDhSR3xuapwZE8MFT5W1L6L5g0FFq6fruVtbq25OpYUlbc/i8h
         e2zZdk+BXTW2BJl6NM5p0SKgMcYPuuhKQ+Bdr547PzT5s/3PsQpCnjP+R1sCOwyUKPey
         8esJgDI5OHUcJ9jlHL36a2EoEXEhT5YI/p9aVdz5qFmzDtZfeVudg39gjLQqGI5YobUc
         odqQ==
X-Gm-Message-State: AOJu0Yw0YdGF5siid04Gilr3rDVIAAHKHvyXCR+5R5gTj35/zvYMH5XF
	lIfXwfvW2nYp4JIBx9XdqmsGdkXHanKtmP5UfuWM2wSszFvLVEIlFG+/NyN1as40yKQ03ZE8vtU
	2z3XbCrlQweeQane1kxD2qitpKgv5thpZWPcH4cuQ3f423vk7sGBfxeVMS7uxcoMoMLz274VS4g
	J0HA==
X-Gm-Gg: Acq92OHK6psRfOFTaCYWAEyMOY63NOsRfygiF3HRxjnmP0AO2K4mQrJYXypaMnXi00O
	tEjCvv6JFGGMoEp+FoE9clGxlDgZZfTiZ4ttnau/p9TVFOK585RdPCge8Q1Z/yGnzsFDnEKyADr
	4gLGmCNMcweXVyjFEyd/WWg8g6f54ADBSDU9RZ9hWwGfabzy3YZWtwiiQt9b+iNlw/kavHWE3N3
	ZzUZkOp4az9+JNo/0kfRgUlaYgsIqT48kQ8OwyC5CCellViw2AEWqvFQsxz9Es9w8wYj9Fqb14q
	petHduamJibinGwhK+ViE6vL/VKtHgfnvGxAxEmTcWWNcstFhaMCUyTkwMK6oOrpuQW1gzxPXwk
	NPvAIsym96IxQk2aghrheM7e9HR0nVkcucuypcn1V36Y1q9sx1yrSFcvstqgzEJKIdPyL5PeTlW
	qAXK5o6hZP+YaG8tOrpOwySl58/yo/aLcFvn3flZw=
X-Received: by 2002:a17:903:b4e:b0:2c1:6020:7398 with SMTP id d9443c01a7336-2c6641efbc2mr64784625ad.12.1781414312431;
        Sat, 13 Jun 2026 22:18:32 -0700 (PDT)
X-Received: by 2002:a17:903:b4e:b0:2c1:6020:7398 with SMTP id d9443c01a7336-2c6641efbc2mr64784445ad.12.1781414311939;
        Sat, 13 Jun 2026 22:18:31 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c651dsm64456705ad.26.2026.06.13.22.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 22:18:31 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        praneesh.p@oss.qualcomm.com
Subject: [PATCH wireless-next v2 4/5] wifi: cfg80211: Fragment per-link station stats in nl80211_dump_station()
Date: Sun, 14 Jun 2026 10:47:34 +0530
Message-ID: <20260614051739.3979947-5-praneesh.p@oss.qualcomm.com>
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
X-Proofpoint-GUID: s-zaXVdxRnLNsbeKdRcFZpZD5F44pv65
X-Authority-Analysis: v=2.4 cv=MNlQXsZl c=1 sm=1 tr=0 ts=6a2e39a9 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=p9g4ZCCWhs38yyyI6XkA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDA0OSBTYWx0ZWRfXy1hHLTBn0Uvj
 egpeQH32TNjjMXVtKQvJ7wuJYORsiAQdwOQ7mJh+wMuk5/MA3IiYXLz5GWfpwW0Mtiewh80y+6V
 x1+3F320UqvvzWTW9H107eo9oLXdy5s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDA0OSBTYWx0ZWRfX1CpUxpaiV1d5
 Sbq+M/wW2XQKGmMvSp0Is1XulL6CElNHk8Ns48P5GsPCWa+bmNNj31h/igI/dJkCRi5jJwGSKBH
 GzNGmkUFPCNN9r/xiX8hFcekL9iAqtmdZNt/zXPOpESOP7I9SjrXKlehvFhwFjgjdeMIjT/kbMS
 kN6sNGtsYAhjNBJCunvWbERihJVYHHBzPgJIZ727teiqxbq1mQE5NxD7vW3wUFJjllMcRS7EuuA
 KTL3HnVr+SKNFVV3Im+dvJwctARsR3njfsEArtx+vlR50qViUvyM9qkwD4CgM5d7AzZiQmwrSbK
 +8ayEq2ae/WhsLGYYXIHnbsZg5d04j8LJYB1+QczV9LsdSo0Qg/OkDDki77kipQ5LUrVCrsU6E4
 D6NddxRwDvSN59EOp1+eh+QxDF2dEg3CNREUjg/615McXShsgl72zeWcJN2MqUQ2C53ULL4G0aW
 6isfcpl40gn5OazOPxg==
X-Proofpoint-ORIG-GUID: s-zaXVdxRnLNsbeKdRcFZpZD5F44pv65
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
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
	TAGGED_FROM(0.00)[bounces-37783-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB85E680634

In MLO scenarios, stations may have multiple links, each with distinct
statistics. When userspace tools like iw or hostapd request station dumps,
attempting to pack all per-link stats into a single netlink message can
easily exceed the default 4KB buffer limit, especially when more than two
links are active. This results in -EMSGSIZE errors and incomplete data
delivery.

To address this, fragment per-link station statistics across multiple
netlink messages to ensure reliable delivery of complete MLO station
information. Extend the stateful context with a two-phase dump mechanism:
phase 0 (AGGREGATED) sends combined MLO-level statistics and phase 1
(PER_LINK) sends individual per-link statistics for each active link.

The dump loop is structured to produce exactly one netlink message per
iteration, with a common header (ifindex, wdev, mac, generation) built
once and phase-specific payload added via a switch statement. This keeps
header construction in one place and makes the EMSGSIZE bail-out uniform.

Add a new request flag attribute, NL80211_ATTR_STA_DUMP_LINK_STATS
(NLA_FLAG), for NL80211_CMD_GET_STATION dump. Userspace can set this
flag to request per-link station statistics for MLO stations.

Extract this flag during the first dump invocation by passing an attrbuf
to nl80211_prepare_wdev_dump(); use __free(kfree) to avoid scattered
manual kfree() calls. Cache the boolean in the dump context to avoid
repeated parsing on subsequent invocations.

Per-link messages carry a single NL80211_ATTR_MLO_LINKS nest with the
link ID, link-specific MAC, and per-link NL80211_ATTR_STA_INFO payload.
The link-specific validity (is_valid_ether_addr) and null pointer guard
are checked in nl80211_put_link_station_payload() before any message
construction begins.

Also fix all nla_nest_start_noflag() calls in nl80211_fill_link_station()
for nested attribute types (STA_INFO, BSS_PARAM, TID_STATS, per-tid) to
use nla_nest_start() so the NLA_F_NESTED flag is set correctly.

Propagate the actual return value from nl80211_put_sta_info_common() in
the AGGREGATED phase rather than returning skb->len. Returning skb->len
signals netlink to re-invoke the dump with the same sta_idx, causing an
infinite loop when the aggregated payload is too large to fit; returning
the real error code (-EMSGSIZE or otherwise) terminates the dump cleanly.

Backward compatibility is seamlessly preserved for non-MLO stations.

Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
 include/uapi/linux/nl80211.h |  19 ++++
 net/wireless/nl80211.c       | 170 ++++++++++++++++++++++++++++-------
 2 files changed, 157 insertions(+), 32 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 9998f6c0a665..1a501effd635 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3165,6 +3165,23 @@ enum nl80211_commands {
  * @NL80211_ATTR_NPCA_PRIMARY_FREQ: NPCA primary channel (u32)
  * @NL80211_ATTR_NPCA_PUNCT_BITMAP: NPCA puncturing bitmap (u32)
  *
+ * @NL80211_ATTR_STA_DUMP_LINK_STATS: Request flag for %NL80211_CMD_GET_STATION
+ *	(dump mode only). When set on an MLD station, the dump produces two
+ *	%NL80211_CMD_NEW_STATION messages per station per dump call:
+ *
+ *	1. An aggregated-stats message whose top-level %NL80211_ATTR_STA_INFO
+ *	   contains MLO-combined statistics (same content as a dump without
+ *	   this flag).
+ *
+ *	2. For each active link, a per-link message containing
+ *	   %NL80211_ATTR_MLO_LINKS with a single link entry. Each entry holds
+ *	   %NL80211_ATTR_MLO_LINK_ID, the link-specific %NL80211_ATTR_MAC,
+ *	   and %NL80211_ATTR_STA_INFO with per-link statistics (see
+ *	   &enum nl80211_sta_info).
+ *
+ *	The aggregated message always precedes the per-link messages for the
+ *	same station within a dump sequence.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3763,6 +3780,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_NPCA_PRIMARY_FREQ,
 	NL80211_ATTR_NPCA_PUNCT_BITMAP,
 
+	NL80211_ATTR_STA_DUMP_LINK_STATS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b4c4406d77bf..6910dfa7343e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1093,6 +1093,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_NPCA_PRIMARY_FREQ] = { .type = NLA_U32 },
 	[NL80211_ATTR_NPCA_PUNCT_BITMAP] =
 		NLA_POLICY_FULL_RANGE(NLA_U32, &nl80211_punct_bitmap_range),
+	[NL80211_ATTR_STA_DUMP_LINK_STATS] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -7870,7 +7871,7 @@ static int nl80211_fill_link_station(struct sk_buff *msg,
 		goto nla_put_failure;					\
 	} while (0)
 
-	link_sinfoattr = nla_nest_start_noflag(msg, NL80211_ATTR_STA_INFO);
+	link_sinfoattr = nla_nest_start(msg, NL80211_ATTR_STA_INFO);
 	if (!link_sinfoattr)
 		goto nla_put_failure;
 
@@ -7936,8 +7937,8 @@ static int nl80211_fill_link_station(struct sk_buff *msg,
 	PUT_LINK_SINFO(BEACON_LOSS, beacon_loss_count, u32);
 
 	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_BSS_PARAM)) {
-		bss_param = nla_nest_start_noflag(msg,
-						  NL80211_STA_INFO_BSS_PARAM);
+		bss_param = nla_nest_start(msg,
+					   NL80211_STA_INFO_BSS_PARAM);
 		if (!bss_param)
 			goto nla_put_failure;
 
@@ -7979,8 +7980,7 @@ static int nl80211_fill_link_station(struct sk_buff *msg,
 		struct nlattr *tidsattr;
 		int tid;
 
-		tidsattr = nla_nest_start_noflag(msg,
-						 NL80211_STA_INFO_TID_STATS);
+		tidsattr = nla_nest_start(msg, NL80211_STA_INFO_TID_STATS);
 		if (!tidsattr)
 			goto nla_put_failure;
 
@@ -7993,7 +7993,7 @@ static int nl80211_fill_link_station(struct sk_buff *msg,
 			if (!tidstats->filled)
 				continue;
 
-			tidattr = nla_nest_start_noflag(msg, tid + 1);
+			tidattr = nla_nest_start(msg, tid + 1);
 			if (!tidattr)
 				goto nla_put_failure;
 
@@ -8464,21 +8464,74 @@ static void cfg80211_sta_set_mld_sinfo(struct station_info *sinfo)
 	sinfo->filled &= ~BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG);
 }
 
+enum nl80211_dump_station_phase {
+	NL80211_DUMP_STA_PHASE_AGGREGATED = 0,
+	NL80211_DUMP_STA_PHASE_PER_LINK   = 1,
+};
+
 struct nl80211_dump_station_ctx {
 	int sta_idx;
+	int link_idx;
+	enum nl80211_dump_station_phase phase;
+	bool dump_link_stats;
 	u8 mac_addr[ETH_ALEN];
 	struct station_info sinfo;
 };
 
+static int nl80211_put_link_station_payload(struct sk_buff *msg,
+					    struct cfg80211_registered_device *rdev,
+					    struct station_info *sinfo,
+					    int link_idx)
+{
+	struct link_station_info *link_sinfo = sinfo->links[link_idx];
+	struct nlattr *links, *link;
+
+	if (WARN_ON_ONCE(!link_sinfo))
+		return -ENOENT;
+
+	if (!is_valid_ether_addr(link_sinfo->addr))
+		return -EADDRNOTAVAIL;
+
+	links = nla_nest_start(msg, NL80211_ATTR_MLO_LINKS);
+	if (!links)
+		return -EMSGSIZE;
+
+	link = nla_nest_start(msg, link_idx + 1);
+	if (!link)
+		goto nla_put_failure;
+
+	if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID, link_idx) ||
+	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, link_sinfo->addr))
+		goto nla_put_failure;
+
+	if (nl80211_fill_link_station(msg, rdev, link_sinfo))
+		goto nla_put_failure;
+
+	nla_nest_end(msg, link);
+	nla_nest_end(msg, links);
+	return 0;
+
+nla_put_failure:
+	nla_nest_cancel(msg, links);
+	return -EMSGSIZE;
+}
+
 static int nl80211_dump_station(struct sk_buff *skb,
 				struct netlink_callback *cb)
 {
 	struct cfg80211_registered_device *rdev;
 	struct wireless_dev *wdev;
 	struct nl80211_dump_station_ctx *ctx = (void *)cb->args[2];
+	struct nlattr **attrbuf __free(kfree) = NULL;
 	int err;
 
-	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev, NULL);
+	if (!ctx) {
+		attrbuf = kzalloc_objs(*attrbuf, NUM_NL80211_ATTR);
+		if (!attrbuf)
+			return -ENOMEM;
+	}
+
+	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev, attrbuf);
 	if (err)
 		return err;
 	/* nl80211_prepare_wdev_dump acquired it in the successful case */
@@ -8490,6 +8543,9 @@ static int nl80211_dump_station(struct sk_buff *skb,
 			err = -ENOMEM;
 			goto out_err;
 		}
+		ctx->phase = NL80211_DUMP_STA_PHASE_AGGREGATED;
+		ctx->dump_link_stats =
+			!!attrbuf[NL80211_ATTR_STA_DUMP_LINK_STATS];
 		cb->args[2] = (long)ctx;
 	}
 
@@ -8505,34 +8561,53 @@ static int nl80211_dump_station(struct sk_buff *skb,
 
 	while (true) {
 		void *hdr;
+		int ret;
 
-		memset(&ctx->sinfo, 0, sizeof(ctx->sinfo));
-		for (int i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
-			ctx->sinfo.links[i] =
-				kzalloc_obj(*ctx->sinfo.links[0]);
-			if (!ctx->sinfo.links[i]) {
-				err = -ENOMEM;
+		/* AGGREGATED phase: fetch sinfo from driver once per station */
+		if (ctx->phase == NL80211_DUMP_STA_PHASE_AGGREGATED) {
+			memset(&ctx->sinfo, 0, sizeof(ctx->sinfo));
+			for (int i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
+				ctx->sinfo.links[i] =
+					kzalloc_obj(*ctx->sinfo.links[0]);
+				if (!ctx->sinfo.links[i]) {
+					err = -ENOMEM;
+					goto out_err_release;
+				}
+			}
+
+			err = rdev_dump_station(rdev, wdev, ctx->sta_idx,
+						ctx->mac_addr, &ctx->sinfo);
+			if (err == -ENOENT) {
+				err = skb->len;
 				goto out_err_release;
 			}
-		}
+			if (err)
+				goto out_err_release;
 
-		err = rdev_dump_station(rdev, wdev, ctx->sta_idx,
-					ctx->mac_addr, &ctx->sinfo);
-		if (err == -ENOENT) {
-			err = skb->len;
-			goto out_err_release;
+			if (ctx->sinfo.valid_links)
+				cfg80211_sta_set_mld_sinfo(&ctx->sinfo);
+		} else {
+			/* PER_LINK phase: advance to next valid link */
+			while (ctx->link_idx < IEEE80211_MLD_MAX_NUM_LINKS &&
+			       !(ctx->sinfo.valid_links & BIT(ctx->link_idx)))
+				ctx->link_idx++;
+
+			if (ctx->link_idx >= IEEE80211_MLD_MAX_NUM_LINKS) {
+				cfg80211_sinfo_release_content(&ctx->sinfo);
+				ctx->sta_idx++;
+				ctx->phase = NL80211_DUMP_STA_PHASE_AGGREGATED;
+				continue;
+			}
 		}
-		if (err)
-			goto out_err_release;
-
-		if (ctx->sinfo.valid_links)
-			cfg80211_sta_set_mld_sinfo(&ctx->sinfo);
 
+		/* Build common header for both phases */
 		hdr = nl80211hdr_put(skb, NETLINK_CB(cb->skb).portid,
 				     cb->nlh->nlmsg_seq, NLM_F_MULTI,
 				     NL80211_CMD_NEW_STATION);
 		if (!hdr) {
 			err = skb->len;
+			if (ctx->phase == NL80211_DUMP_STA_PHASE_PER_LINK)
+				goto out_err;
 			goto out_err_release;
 		}
 
@@ -8546,18 +8621,49 @@ static int nl80211_dump_station(struct sk_buff *skb,
 				ctx->sinfo.generation)) {
 			genlmsg_cancel(skb, hdr);
 			err = skb->len;
+			if (ctx->phase == NL80211_DUMP_STA_PHASE_PER_LINK)
+				goto out_err;
 			goto out_err_release;
 		}
 
-		if (nl80211_put_sta_info_common(skb, rdev, &ctx->sinfo)) {
-			genlmsg_cancel(skb, hdr);
-			err = skb->len;
-			goto out_err_release;
-		}
+		switch (ctx->phase) {
+		case NL80211_DUMP_STA_PHASE_AGGREGATED:
+			ret = nl80211_put_sta_info_common(skb, rdev, &ctx->sinfo);
+			if (ret) {
+				genlmsg_cancel(skb, hdr);
+				err = ret;
+				goto out_err_release;
+			}
+			genlmsg_end(skb, hdr);
+
+			if (ctx->dump_link_stats && ctx->sinfo.valid_links) {
+				ctx->phase = NL80211_DUMP_STA_PHASE_PER_LINK;
+				ctx->link_idx = 0;
+			} else {
+				cfg80211_sinfo_release_content(&ctx->sinfo);
+				ctx->sta_idx++;
+			}
+			break;
 
-		genlmsg_end(skb, hdr);
-		cfg80211_sinfo_release_content(&ctx->sinfo);
-		ctx->sta_idx++;
+		case NL80211_DUMP_STA_PHASE_PER_LINK:
+			ret = nl80211_put_link_station_payload(skb, rdev,
+							       &ctx->sinfo,
+							       ctx->link_idx);
+			if (ret == -EMSGSIZE) {
+				genlmsg_cancel(skb, hdr);
+				err = skb->len;
+				goto out_err;
+			}
+			if (ret) {
+				/* skip invalid link, do not abort the dump */
+				genlmsg_cancel(skb, hdr);
+				ctx->link_idx++;
+				continue;
+			}
+			genlmsg_end(skb, hdr);
+			ctx->link_idx++;
+			break;
+		}
 	}
 
 out_err_release:
-- 
2.43.0


