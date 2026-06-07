Return-Path: <linux-wireless+bounces-37469-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qFXzIc6xJWpcKgIAu9opvQ
	(envelope-from <linux-wireless+bounces-37469-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 07 Jun 2026 20:00:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 367A0651287
	for <lists+linux-wireless@lfdr.de>; Sun, 07 Jun 2026 20:00:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=gLDIYB0d;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=dUUMhmkS;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37469-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37469-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46C4730138A9
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Jun 2026 18:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C170E314B9D;
	Sun,  7 Jun 2026 18:00:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7662E0914
	for <linux-wireless@vger.kernel.org>; Sun,  7 Jun 2026 18:00:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780855204; cv=none; b=t5osUXwM0clM8QmAsyp3Yr4OJDdIDjW5rOjBAsCIckBV02yY0EN9i8RplORiCpnFCyHCnkunZNFCUb8EDSwepYpdaKwwhBGVLLXWbLgO4mED0d3yNsEOKOcQQRmbcFQF/giRD3xvvvb4UmQTCFPxx8VvHOB/WOghGGO9zZw4xGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780855204; c=relaxed/simple;
	bh=wlksnwIEOKb5JmCvg+KCud3Rb5IxPQnkyisXf1zNzMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdKLPgQGHUJ0c0bT5PR3qENndGAjJbl0/G5EfyPoi3s8OQIJOO5k07Q43c+dVE0Bl8OPmfcIGez9nGKNmk4bS1lA4XXOBNUvxjRUTYka9BONsVKNQ9fzmwTjuUhNeH3sa/1C544aA4KVeGqyi9v4I/tgmDMzSSsG16eWOijgKYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gLDIYB0d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dUUMhmkS; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657ElCWj887536
	for <linux-wireless@vger.kernel.org>; Sun, 7 Jun 2026 18:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=gTYyVjsDJ2I
	mkuqggi+q90t2do211MjbKZ73aYhLUfY=; b=gLDIYB0d4bt+zN6WrP/Njb7Q3rL
	6SohER/cgAre3KZOY0SdbWGPS7G5aOKj0lEVMdUyoFDouC6jRCz6dpeJFAhQuHWl
	LdCEybmuLNEvLH3tOa4XRbTuO7PXk1UIsbv0VIPce5aXMIv2W8xMKilhxXsxShkb
	gerL5vAQBT9UP0CUbpzCkiIlaVc6o323p7PKiVfGVDBq4Ta4FKvMhnDUAfAdIqkO
	tX0rsjCPbhKMRpGEHvqI5Jbz2a/kEuYdDDFPGGIwTvXucTTDpSrsgSMziZmTEy15
	nSfMy6Gofti6DCEtvlp8C+50bkzdGSY7NJznoJOxnN7+x3jSdgtxwnnsRVw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emaj4vr7n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 07 Jun 2026 18:00:01 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c860544c077so3558226a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 07 Jun 2026 11:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780855200; x=1781460000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTYyVjsDJ2Imkuqggi+q90t2do211MjbKZ73aYhLUfY=;
        b=dUUMhmkShlNJczru4lfD6RjA1t6hG9KpCZKG1P4AEk743wVBJb69u5/qSZ+SjFMeYt
         6Xz3Aw02sfn4rky2qWEmgvlgmFg/NEj1rtf7LJP1fYx3lxvAoCWgtmsuXWSBLjZrw2Yf
         YVdr2eaJMx/ejkrp0Cmqra8BLR7mhpq+21ZEtvdxpbi3CU5gCFKr4UA6vSsPVza2oZFX
         v9F6UXpsGZrq0v4tb6CMSHrlGQIJlOzL6sL9gvh7HsTsYCJnwgH3zfqvffv5FJMDZiBe
         4FHxXtz7l3Dn/E69ZX5bliZwxqAwgLg71/eDHu4z3iARorDFZuKh00vph+jz9PBgE4Mg
         faHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780855200; x=1781460000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gTYyVjsDJ2Imkuqggi+q90t2do211MjbKZ73aYhLUfY=;
        b=a8Lppv+TEiRZ7VPveBHgdRQBtmALXc5x3j5DMvhTIDQTk0YMUTjPAGrjgUyIfleBUq
         llTNJ06+895Lu5eqqitWoLHAIH/kfWC7jqkNNv/fpk27LRICdAuqfr3RZhzEHEmXEBCH
         aWPeMbAKV2vPhvRImOByoAHWgN0o8S039ygLqzoYWaltIOoWZQW1Z4k5lH7/Q6Ok6Nt0
         Xa+cxzWZo7ep4fXz2Y/bMlbeGe3xg7qVeMeBGFbTjRcUlJahaMXyne+VA5oFrR05n7RA
         JSLuYXKV0vxKqUTcxmCqmTOH8dTaJ0d6nrsknVUqApfDqb53L6vwqUTAMd5G6nip0la3
         vi2Q==
X-Gm-Message-State: AOJu0YwpcJC9FEgYW/UU8qDxcJM2SrvYQNTGQJ18H+p9mlRyt6SxERSf
	5qcabw4OzLZvT9VHhfcmcgVKCbs0/+tVTXB6WnS23QkE2acA60VMl+LHxuS5oASf7JLne1zyC54
	0lHdRnk9D9RLRS/2cOs9kTtpPZPBj4GuRxxWN9kDL7ABgrZcwk45vYyudMsLIeKtNRdZGTI/d0x
	BwQg==
X-Gm-Gg: Acq92OHbhrlBYgbIRZLP2dnd15TbVMdsrpCdK+OgUaJS0Nm1ISpeZN5xOCKm3GPHL0F
	Aj7+UPg+V1qmDwyjt0O/2GWjo9ylxFs5vLs7FD8j6XwfJbBPBUwxEOe71ecVPZU7d3bJL38ULzz
	EGRZ0uzcsWd2Tb+6hJ9wPSdpE//WoDu/dsv5uXbdvLWpYlWR6VU7oHMZP5uOlVKYTpgldMY9gjz
	eh0ySY90yCZ+cBE1QipxLXNfwr5WG3fGpICMckJr38Hj5A1rVYEWS5B9kG3FtuppN2WrewYNyC1
	9gKUZigjvxD28HsTSjP5VIohxc6sUswrDi9H1gxLMaDCdEIHnOqM/zDA2fqtUKJaXo1hTvx9zQv
	T54D7PfrXQHS1xVjFNHEOcMoTOwXrjEoCjLjoD4owZJhh8sQy7dIcI/EEZbhNMNgiXYmJcFNlrs
	ZA0QQZag3bWLMwSOPk30mjLWL+pRnycxF/YctDBKdqAD5o8enkoA==
X-Received: by 2002:a05:6a21:685:b0:3b3:31f0:24b6 with SMTP id adf61e73a8af0-3b4ccf91401mr15322858637.22.1780855200205;
        Sun, 07 Jun 2026 11:00:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:685:b0:3b3:31f0:24b6 with SMTP id adf61e73a8af0-3b4ccf91401mr15322834637.22.1780855199605;
        Sun, 07 Jun 2026 10:59:59 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a624fsm13078522a12.18.2026.06.07.10.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 10:59:59 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        praneesh.p@oss.qualcomm.com
Subject: [PATCH wireless-next 4/5] wifi: cfg80211: Fragment per-link station stats in nl80211_dump_station()
Date: Sun,  7 Jun 2026 23:29:11 +0530
Message-ID: <20260607175912.2266215-5-praneesh.p@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: vFszKZbCz9cMnMcVmfIBgv3T_F19ZRII
X-Proofpoint-GUID: vFszKZbCz9cMnMcVmfIBgv3T_F19ZRII
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDE4MCBTYWx0ZWRfXwjbeDvRnN1M1
 UFyFHVMQThAKkXCLVNSMOnWPkUWW9Tm7NS5V4uk01tJBt+QSjKSbB2YvqMl3SuZGFaDorcEZQmm
 75yDs9rj4WOvpOH5Divr2x7jQrLr4PR8ML6jgpEyHwv4LDI3epxj3Kc3pi3u0IWjt67g0c7zT0Q
 MhYN+TVEIxUjZK5cUqFw2ps7/FGe1hAEISZDXJexRuMjL1JOHAc5vK7foFmcCzNRTaYGxOkpfxs
 xJoP3xb7DQH9n4bjcV0/lS5gdR5BXJ4J8xAXnDvUpsqdY3I9VZJfaNOC/9tOZDchjisgCDIEvYK
 WShBdU+9H1t8JJd3nqsCh6RQaDS1OaB41Q+CDdZRX/nuDF15DR2D+B6RcY6yJjxqtZKliictudg
 TywIWnNMOioPHzYQIx08IMHlNOQKkF46wMY3VhlcTx4PkfPKllfmnGDqmNv+GZvuMV4fQIumTwL
 l6OABqebXf/G+EdG6rQ==
X-Authority-Analysis: v=2.4 cv=TLh1jVla c=1 sm=1 tr=0 ts=6a25b1a1 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=FzdnI4vGGgIAPix-wt4A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070180
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37469-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 367A0651287

In MLO scenarios, stations may have multiple links, each with distinct
statistics. When userspace tools like iw or hostapd request station dumps,
attempting to pack all per-link stats into a single netlink message can
easily exceed the default 4KB buffer limit, especially when more than two
links are active. This results in -EMSGSIZE errors and incomplete data
delivery.

To address this, fragment per-link station statistics across multiple
netlink messages to ensure reliable delivery of complete MLO station
information. Extend the stateful two-phase dump mechanism: the first
phase sends aggregated station-level statistics and the second phase
sends individual per-link statistics in separate fragments.

Add a new request flag attribute, NL80211_ATTR_STA_DUMP_LINK_STATS
(NLA_FLAG), for NL80211_CMD_GET_STATION dump. Userspace can set this
flag to request per-link station statistics for multi-link (MLO)
stations.

Extract this flag safely during the first dump invocation by passing an
attribute buffer to nl80211_prepare_wdev_dump(), caching the boolean
result in the dump context to avoid repeated parsing overhead.

Each per-link message now includes a nested NL80211_ATTR_STA_INFO
attribute to carry link-specific statistics, along with
NL80211_ATTR_MLO_LINKS for link context. Add a new helper function
nl80211_send_link_station() to construct these messages. The dump loop
iterates through the valid_links bitmask to process active links,
breaking out gracefully on EMSGSIZE while preserving the deeply allocated
station info for the next syscall iteration.

Even when no per-link statistics attributes are added, an empty
NL80211_ATTR_STA_INFO nest is still emitted. This is intentional, as
userspace expects NL80211_ATTR_STA_INFO to be present in
NL80211_CMD_NEW_STATION messages and may otherwise abort parsing or
drop the event if it is missing.

Backward compatibility is seamlessly preserved for non-MLO stations.

Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
 include/uapi/linux/nl80211.h |  32 +++-
 net/wireless/nl80211.c       | 332 +++++++++++++++++++++++++++++++++--
 2 files changed, 351 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 9998f6c0a665..f00a9cd8ab2c 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1818,6 +1818,10 @@ enum nl80211_commands {
  * @NL80211_ATTR_STA_INFO: information about a station, part of station info
  *	given for %NL80211_CMD_GET_STATION, nested attribute containing
  *	info as possible, see &enum nl80211_sta_info.
+ *	In the per-link dump messages produced when %NL80211_ATTR_STA_DUMP_LINK_STATS
+ *	is requested, the top-level occurrence of this attribute is empty.
+ *	Per-link statistics are carried inside %NL80211_ATTR_MLO_LINKS;
+ *	see %NL80211_ATTR_STA_DUMP_LINK_STATS for the full message layout.
  *
  * @NL80211_ATTR_WIPHY_BANDS: Information about an operating bands,
  *	consisting of a nested array.
@@ -2904,7 +2908,11 @@ enum nl80211_commands {
  * @NL80211_ATTR_MLO_LINK_ID: A (u8) link ID for use with MLO, to be used with
  *	various commands that need a link ID to operate.
  * @NL80211_ATTR_MLO_LINKS: A nested array of links, each containing some
- *	per-link information and a link ID.
+ *	per-link information and a link ID. In %NL80211_CMD_NEW_STATION
+ *	responses produced by a %NL80211_ATTR_STA_DUMP_LINK_STATS dump,
+ *	each link entry additionally carries %NL80211_ATTR_STA_INFO with
+ *	per-link station statistics and %NL80211_ATTR_MAC with the
+ *	link-specific MAC address.
  * @NL80211_ATTR_MLD_ADDR: An MLD address, used with various commands such as
  *	authenticate/associate.
  *
@@ -3165,6 +3173,26 @@ enum nl80211_commands {
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
+ *	   &enum nl80211_sta_info). The top-level %NL80211_ATTR_STA_INFO in
+ *	   this message is intentionally empty; it is present solely for ABI
+ *	   compatibility with parsers that require %NL80211_ATTR_STA_INFO to
+ *	   be present in every %NL80211_CMD_NEW_STATION message.
+ *
+ *	The aggregated message always precedes the per-link messages for the
+ *	same station within a dump sequence.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3763,6 +3791,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_NPCA_PRIMARY_FREQ,
 	NL80211_ATTR_NPCA_PUNCT_BITMAP,
 
+	NL80211_ATTR_STA_DUMP_LINK_STATS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d146d6af6e48..3dba329c7eb2 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -54,6 +54,8 @@ enum nl80211_dump_station_phase {
 struct nl80211_dump_station_ctx {
 	int sta_idx;
 	enum nl80211_dump_station_phase phase;
+	int link_idx;
+	bool dump_link_stats;
 	u8 mac_addr[ETH_ALEN];
 	struct station_info sinfo;
 };
@@ -1126,6 +1128,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_NPCA_PRIMARY_FREQ] = { .type = NLA_U32 },
 	[NL80211_ATTR_NPCA_PUNCT_BITMAP] =
 		NLA_POLICY_FULL_RANGE(NLA_U32, &nl80211_punct_bitmap_range),
+	[NL80211_ATTR_STA_DUMP_LINK_STATS] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -7874,6 +7877,185 @@ static bool nl80211_put_signal(struct sk_buff *msg, u8 mask, s8 *signal,
 	return true;
 }
 
+static int nl80211_fill_link_station(struct sk_buff *msg,
+				     struct cfg80211_registered_device *rdev,
+				     struct link_station_info *link_sinfo)
+{
+	struct nlattr *bss_param, *link_sinfoattr;
+
+#define PUT_LINK_SINFO(attr, memb, type) do {				\
+	BUILD_BUG_ON(sizeof(type) == sizeof(u64));			\
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_ ## attr) &&	\
+	    nla_put_ ## type(msg, NL80211_STA_INFO_ ## attr,		\
+			     link_sinfo->memb))				\
+		goto nla_put_failure;					\
+	} while (0)
+#define PUT_LINK_SINFO_U64(attr, memb) do {				\
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_ ## attr) &&	\
+	    nla_put_u64_64bit(msg, NL80211_STA_INFO_ ## attr,		\
+			      link_sinfo->memb, NL80211_STA_INFO_PAD))	\
+		goto nla_put_failure;					\
+	} while (0)
+
+	link_sinfoattr = nla_nest_start_noflag(msg, NL80211_ATTR_STA_INFO);
+	if (!link_sinfoattr)
+		goto nla_put_failure;
+
+	PUT_LINK_SINFO(INACTIVE_TIME, inactive_time, u32);
+
+	if (link_sinfo->filled & (BIT_ULL(NL80211_STA_INFO_RX_BYTES) |
+			     BIT_ULL(NL80211_STA_INFO_RX_BYTES64)) &&
+	    nla_put_u32(msg, NL80211_STA_INFO_RX_BYTES,
+			(u32)link_sinfo->rx_bytes))
+		goto nla_put_failure;
+
+	if (link_sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES) |
+			     BIT_ULL(NL80211_STA_INFO_TX_BYTES64)) &&
+	    nla_put_u32(msg, NL80211_STA_INFO_TX_BYTES,
+			(u32)link_sinfo->tx_bytes))
+		goto nla_put_failure;
+
+	PUT_LINK_SINFO_U64(RX_BYTES64, rx_bytes);
+	PUT_LINK_SINFO_U64(TX_BYTES64, tx_bytes);
+	PUT_LINK_SINFO_U64(RX_DURATION, rx_duration);
+	PUT_LINK_SINFO_U64(TX_DURATION, tx_duration);
+
+	if (wiphy_ext_feature_isset(&rdev->wiphy,
+				    NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
+		PUT_LINK_SINFO(AIRTIME_WEIGHT, airtime_weight, u16);
+
+	switch (rdev->wiphy.signal_type) {
+	case CFG80211_SIGNAL_TYPE_MBM:
+		PUT_LINK_SINFO(SIGNAL, signal, u8);
+		PUT_LINK_SINFO(SIGNAL_AVG, signal_avg, u8);
+		break;
+	default:
+		break;
+	}
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL)) {
+		if (!nl80211_put_signal(msg, link_sinfo->chains,
+					link_sinfo->chain_signal,
+					NL80211_STA_INFO_CHAIN_SIGNAL))
+			goto nla_put_failure;
+	}
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG)) {
+		if (!nl80211_put_signal(msg, link_sinfo->chains,
+					link_sinfo->chain_signal_avg,
+					NL80211_STA_INFO_CHAIN_SIGNAL_AVG))
+			goto nla_put_failure;
+	}
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) {
+		if (!nl80211_put_sta_rate(msg, &link_sinfo->txrate,
+					  NL80211_STA_INFO_TX_BITRATE))
+			goto nla_put_failure;
+	}
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE)) {
+		if (!nl80211_put_sta_rate(msg, &link_sinfo->rxrate,
+					  NL80211_STA_INFO_RX_BITRATE))
+			goto nla_put_failure;
+	}
+
+	PUT_LINK_SINFO(RX_PACKETS, rx_packets, u32);
+	PUT_LINK_SINFO(TX_PACKETS, tx_packets, u32);
+	PUT_LINK_SINFO(TX_RETRIES, tx_retries, u32);
+	PUT_LINK_SINFO(TX_FAILED, tx_failed, u32);
+	PUT_LINK_SINFO(EXPECTED_THROUGHPUT, expected_throughput, u32);
+	PUT_LINK_SINFO(BEACON_LOSS, beacon_loss_count, u32);
+
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_BSS_PARAM)) {
+		bss_param = nla_nest_start_noflag(msg,
+						  NL80211_STA_INFO_BSS_PARAM);
+		if (!bss_param)
+			goto nla_put_failure;
+
+		if (((link_sinfo->bss_param.flags &
+		      BSS_PARAM_FLAGS_CTS_PROT) &&
+		     nla_put_flag(msg, NL80211_STA_BSS_PARAM_CTS_PROT)) ||
+		    ((link_sinfo->bss_param.flags &
+		      BSS_PARAM_FLAGS_SHORT_PREAMBLE) &&
+		     nla_put_flag(msg,
+				  NL80211_STA_BSS_PARAM_SHORT_PREAMBLE)) ||
+		    ((link_sinfo->bss_param.flags &
+		      BSS_PARAM_FLAGS_SHORT_SLOT_TIME) &&
+		     nla_put_flag(msg,
+				  NL80211_STA_BSS_PARAM_SHORT_SLOT_TIME)) ||
+		    nla_put_u8(msg, NL80211_STA_BSS_PARAM_DTIM_PERIOD,
+			       link_sinfo->bss_param.dtim_period) ||
+		    nla_put_u16(msg, NL80211_STA_BSS_PARAM_BEACON_INTERVAL,
+				link_sinfo->bss_param.beacon_interval))
+			goto nla_put_failure;
+
+		nla_nest_end(msg, bss_param);
+	}
+
+	PUT_LINK_SINFO_U64(RX_DROP_MISC, rx_dropped_misc);
+	PUT_LINK_SINFO_U64(BEACON_RX, rx_beacon);
+	PUT_LINK_SINFO(BEACON_SIGNAL_AVG, rx_beacon_signal_avg, u8);
+	PUT_LINK_SINFO(RX_MPDUS, rx_mpdu_count, u32);
+	PUT_LINK_SINFO(FCS_ERROR_COUNT, fcs_err_count, u32);
+	if (wiphy_ext_feature_isset(&rdev->wiphy,
+				    NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT)) {
+		PUT_LINK_SINFO(ACK_SIGNAL, ack_signal, u8);
+		PUT_LINK_SINFO(ACK_SIGNAL_AVG, avg_ack_signal, s8);
+	}
+
+#undef PUT_LINK_SINFO
+#undef PUT_LINK_SINFO_U64
+
+	if (link_sinfo->pertid) {
+		struct nlattr *tidsattr;
+		int tid;
+
+		tidsattr = nla_nest_start_noflag(msg,
+						 NL80211_STA_INFO_TID_STATS);
+		if (!tidsattr)
+			goto nla_put_failure;
+
+		for (tid = 0; tid < IEEE80211_NUM_TIDS + 1; tid++) {
+			struct cfg80211_tid_stats *tidstats;
+			struct nlattr *tidattr;
+
+			tidstats = &link_sinfo->pertid[tid];
+
+			if (!tidstats->filled)
+				continue;
+
+			tidattr = nla_nest_start_noflag(msg, tid + 1);
+			if (!tidattr)
+				goto nla_put_failure;
+
+#define PUT_TIDVAL_U64(attr, memb) do {					\
+	if (tidstats->filled & BIT(NL80211_TID_STATS_ ## attr) &&	\
+	    nla_put_u64_64bit(msg, NL80211_TID_STATS_ ## attr,		\
+			      tidstats->memb, NL80211_TID_STATS_PAD))	\
+		goto nla_put_failure;					\
+	} while (0)
+
+			PUT_TIDVAL_U64(RX_MSDU, rx_msdu);
+			PUT_TIDVAL_U64(TX_MSDU, tx_msdu);
+			PUT_TIDVAL_U64(TX_MSDU_RETRIES, tx_msdu_retries);
+			PUT_TIDVAL_U64(TX_MSDU_FAILED, tx_msdu_failed);
+
+#undef PUT_TIDVAL_U64
+			if ((tidstats->filled &
+			     BIT(NL80211_TID_STATS_TXQ_STATS)) &&
+			    !nl80211_put_txq_stats(msg, &tidstats->txq_stats,
+						   NL80211_TID_STATS_TXQ_STATS))
+				goto nla_put_failure;
+
+			nla_nest_end(msg, tidattr);
+		}
+
+		nla_nest_end(msg, tidsattr);
+	}
+
+	nla_nest_end(msg, link_sinfoattr);
+	return 0;
+
+nla_put_failure:
+	return -EMSGSIZE;
+}
+
 static int nl80211_put_sta_info_common(struct sk_buff *msg,
 				       struct cfg80211_registered_device *rdev,
 				       struct station_info *sinfo)
@@ -8347,6 +8529,86 @@ nl80211_send_accumulated_station(struct sk_buff *msg,
 	return -EMSGSIZE;
 }
 
+static int nl80211_send_link_station(struct sk_buff *msg,
+				     struct netlink_callback *cb,
+				     struct cfg80211_registered_device *rdev,
+				     struct wireless_dev *wdev,
+				     const u8 *mac_addr,
+				     struct station_info *sinfo,
+				     int link_idx)
+{
+	void *hdr;
+	struct nlattr *links, *link;
+	struct link_station_info *link_sinfo;
+	struct nlattr *sinfoattr;
+	int err;
+
+	hdr = nl80211hdr_put(msg, NETLINK_CB(cb->skb).portid,
+			     cb->nlh->nlmsg_seq, NLM_F_MULTI,
+			     NL80211_CMD_NEW_STATION);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if ((wdev->netdev &&
+	     nla_put_u32(msg, NL80211_ATTR_IFINDEX, wdev->netdev->ifindex)) ||
+	    nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(wdev),
+			      NL80211_ATTR_PAD) ||
+	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, mac_addr) ||
+	    nla_put_u32(msg, NL80211_ATTR_GENERATION, sinfo->generation)) {
+		err = -EMSGSIZE;
+		goto err_cancel;
+	}
+
+	sinfoattr = nla_nest_start_noflag(msg, NL80211_ATTR_STA_INFO);
+	if (!sinfoattr) {
+		err = -EMSGSIZE;
+		goto err_cancel;
+	}
+
+	link_sinfo = sinfo->links[link_idx];
+	if (!link_sinfo) {
+		err = -ENOENT;
+		goto err_cancel;
+	}
+
+	nla_nest_end(msg, sinfoattr);
+	if (!is_valid_ether_addr(link_sinfo->addr)) {
+		err = -EADDRNOTAVAIL;
+		goto err_cancel;
+	}
+
+	links = nla_nest_start(msg, NL80211_ATTR_MLO_LINKS);
+	if (!links) {
+		err = -EMSGSIZE;
+		goto err_cancel;
+	}
+
+	link = nla_nest_start(msg, link_idx + 1);
+	if (!link) {
+		err = -EMSGSIZE;
+		goto err_cancel;
+	}
+
+	if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID, link_idx) ||
+	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, link_sinfo->addr)) {
+		err = -EMSGSIZE;
+		goto err_cancel;
+	}
+
+	err = nl80211_fill_link_station(msg, rdev, link_sinfo);
+	if (err)
+		goto err_cancel;
+
+	nla_nest_end(msg, link);
+	nla_nest_end(msg, links);
+	genlmsg_end(msg, hdr);
+	return 0;
+
+err_cancel:
+	genlmsg_cancel(msg, hdr);
+	return err;
+}
+
 static int nl80211_dump_station(struct sk_buff *skb,
 				struct netlink_callback *cb)
 {
@@ -8354,13 +8616,22 @@ static int nl80211_dump_station(struct sk_buff *skb,
 	struct wireless_dev *wdev;
 	struct nl80211_dump_station_cb *cb_data = (void *)cb->ctx;
 	struct nl80211_dump_station_ctx *ctx = cb_data->ctx;
+	struct nlattr **attrbuf = NULL;
 	int err, ret;
 
 	NL_ASSERT_CTX_FITS(struct nl80211_dump_station_cb);
 
-	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev, NULL);
-	if (err)
+	if (!ctx) {
+		attrbuf = kzalloc_objs(*attrbuf, NUM_NL80211_ATTR);
+		if (!attrbuf)
+			return -ENOMEM;
+	}
+
+	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev, attrbuf);
+	if (err) {
+		kfree(attrbuf);
 		return err;
+	}
 
 	/* nl80211_prepare_wdev_dump acquired it in the successful case */
 	__acquire(&rdev->wiphy.mtx);
@@ -8369,15 +8640,22 @@ static int nl80211_dump_station(struct sk_buff *skb,
 	if (!ctx) {
 		ctx = kzalloc_obj(*ctx);
 		if (!ctx) {
+			kfree(attrbuf);
 			err = -ENOMEM;
 			goto out_err;
 		}
 
 		ctx->phase = NL80211_DUMP_STA_PHASE_AGGREGATED;
 		ctx->sta_idx = 0;
+		ctx->link_idx = 0;
+		ctx->dump_link_stats =
+			!!attrbuf[NL80211_ATTR_STA_DUMP_LINK_STATS];
 		cb_data->ctx = ctx;
 	}
 
+	kfree(attrbuf);
+	attrbuf = NULL;
+
 	if (!wdev->netdev && wdev->iftype != NL80211_IFTYPE_NAN) {
 		err = -EINVAL;
 		goto out_err;
@@ -8388,9 +8666,9 @@ static int nl80211_dump_station(struct sk_buff *skb,
 		goto out_err;
 	}
 
-	/* Phase 0: dump aggregated station info */
-	if (ctx->phase == NL80211_DUMP_STA_PHASE_AGGREGATED) {
-		while (true) {
+	while (true) {
+		/* Phase 0: dump aggregated station info */
+		if (ctx->phase == NL80211_DUMP_STA_PHASE_AGGREGATED) {
 			memset(&ctx->sinfo, 0, sizeof(ctx->sinfo));
 			for (int i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
 				ctx->sinfo.links[i] =
@@ -8428,15 +8706,45 @@ static int nl80211_dump_station(struct sk_buff *skb,
 				goto out_err_release;
 			}
 
-			/* Reset ctx for next station */
-			cfg80211_sinfo_release_content(&ctx->sinfo);
-			ctx->sta_idx++;
+			ctx->phase = NL80211_DUMP_STA_PHASE_PER_LINK;
 		}
-	}
 
-	ctx->phase = NL80211_DUMP_STA_PHASE_AGGREGATED;
-	err = skb->len;
-	goto out_err;
+		/* Phase 1: dump per-link station info */
+		if (ctx->phase == NL80211_DUMP_STA_PHASE_PER_LINK &&
+		    ctx->dump_link_stats && ctx->sinfo.valid_links) {
+			while (ctx->link_idx < IEEE80211_MLD_MAX_NUM_LINKS) {
+				if (!(ctx->sinfo.valid_links &
+				      BIT(ctx->link_idx))) {
+					ctx->link_idx++;
+					continue;
+				}
+
+				ret = nl80211_send_link_station(skb, cb, rdev,
+								wdev,
+								ctx->mac_addr,
+								&ctx->sinfo,
+								ctx->link_idx);
+				if (ret == -EMSGSIZE) {
+					err = skb->len;
+					goto out_err;
+				}
+
+				if (ret < 0) {
+					err = ret;
+					goto out_err_release;
+				}
+
+				ctx->link_idx++;
+			}
+		}
+
+		/* Reset ctx for next station */
+		cfg80211_sinfo_release_content(&ctx->sinfo);
+		memset(&ctx->sinfo, 0, sizeof(ctx->sinfo));
+		ctx->sta_idx++;
+		ctx->phase = NL80211_DUMP_STA_PHASE_AGGREGATED;
+		ctx->link_idx = 0;
+	}
 
 out_err_release:
 	cfg80211_sinfo_release_content(&ctx->sinfo);
-- 
2.43.0


