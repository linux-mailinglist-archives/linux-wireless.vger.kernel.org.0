Return-Path: <linux-wireless+bounces-32552-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPYlAJKqqWlSBwEAu9opvQ
	(envelope-from <linux-wireless+bounces-32552-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:08:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E76215251
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35EA730CB103
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 16:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B553CD8BB;
	Thu,  5 Mar 2026 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nlwWLScQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dDJfRnFL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52B03CD8D2
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726880; cv=none; b=ZjrnmWMnIU2PfdJGiKUhG/V7ntylIUNLChCCqqvg3kLDERgmGae7njiQ85EHX7c5u2xZZV/sjPOPQ+5cRlkyLlifTqlA0jFnE/tTHn9RPg4wiTkHENYvwZhk1STCRWXl5QiRAnTWz8op0gbW+WngneaynSuim1Bc1oCFwD9L/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726880; c=relaxed/simple;
	bh=cnMRkK6bApqEjfX5O2abMGuj/HDnAyf8BAOO9A5bnRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n4fuSlcbuK81NWDTpOrwRU/0C8qIm3hrmWoPIHes7Es76UHoqPzNz76TWo3VttXBBX23sEsZPL4sN7WKs/dlNcZZMqGjBv+bRraQVxHklm1Gqgns3Z+ata/EWeSdQ7rCqUq7MRlX7WVI9yKPlTmAxmMhfXWLSVojheNMx1+nWUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nlwWLScQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dDJfRnFL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AFnkb4171050
	for <linux-wireless@vger.kernel.org>; Thu, 5 Mar 2026 16:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1UWIeRyKxE7
	Xg9YjSz9WZtqx80RPocTPC3Qbh/qW+Is=; b=nlwWLScQWmRUrOfK/IRbPO9A73k
	im9P5qIxOSglNOxHOyV9HO0mQ7Ie3hsIoIMEiEB3whWhMetKd3ce27jBBHUm5xUD
	F318ncj/xXctWV+g/pndWBzqWvyVoQqma84NHZVvcj3WQKHWkA4Aozl7dNiF+im6
	nsPpIpil02wbmaYP+gRvnlW7SjXtrpf0+dM9qhxarrwqkRDFSIo0NmdrNofpXPIa
	iwnASRIfz4gFNngEOcS7KCSNK7RBeQjgUoF6zPBIHimcHLgcDo4dUH2hn8Gn8sVs
	z0LoHXHMZ41GABM3QUbXxnR7ltt+3QfEm2zE3RWHtJqka1Zg6n+zuTzx8GA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpuhb3g97-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 16:07:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae47b3adacso46438165ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 08:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772726875; x=1773331675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UWIeRyKxE7Xg9YjSz9WZtqx80RPocTPC3Qbh/qW+Is=;
        b=dDJfRnFLVUZWrI7nfAAVqxpWhs/eIIQqXly/EtPl+jAJk405w3rKzOT6T23DydvRVo
         uWzTXqnI12PRIqXKmTuzgE2uMt8196LADBzAWmvssid3vLudDJE69gB3J/yyKSORUHtu
         u60h/Qc9MV3oEKLZUtGfeO5F2IH6Se+tqod4XO6qEZIMLs4SsGzAIgTJutQBuU4eEyGF
         SL8cnhQP65pEvWn+JDKa6wX7Z9JupON6qZ154Ltm5Y69yQHDxBpm0Usa3w10ZFBhP0TG
         6KmwMvjEfYyHgqnzwYvr6GWKIe5ik/VJR2uCVg00U06Xb7cu+jcdH1DwdgecFY/PUAks
         e8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772726875; x=1773331675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1UWIeRyKxE7Xg9YjSz9WZtqx80RPocTPC3Qbh/qW+Is=;
        b=C6V/ZKBUAQLyccpx/cQUCdw8Nm42uQaaJVBwt7tjbK4Qk/ipe2EzX+PRbxzWYa8w1x
         KgHv9iq5MyLGsqpiFXORPWWjSIuafjcgnQc0ST5fjA50mr6TirSNBmCF1OarE6naQo6t
         LlECVrtB9GRcEW87PVJMt2v9SamXEdFemO684ZWzcfjNaYJcLN013mt7mHqE22xF2o6s
         IFrai+UbK7QBnSZkTOUul6beRSNyMLOXdmG26cc5CV46GrM0L4qqTaED7hgqTwfTd4Vb
         EEjDqvaF3P7juji5KGC9rLJU0cXN6WmU6hP/RiA4gQx7cUYNwRfPeaD1lEi1d5ncr0/T
         PPLQ==
X-Gm-Message-State: AOJu0YxevmTq/cZk1JKnnJwqzSXbz2yCUxGbHrfyK/yNPfIiFGN74QjT
	n1abJvRkeFmMqQUDwW6TUG8Ubx/9V/fv5+Gyne5viS7cqkRQvaI4x+RZglDiVLTth7QZp/UJwLq
	zOf4+xifsAwG92rbaSgfbeiELUQMGs8Gnjjk7who1lrlKbMP6NtTw5WciwUM3tSqAs7NvhnjGue
	AW
X-Gm-Gg: ATEYQzxyUMUb0HnW+weRfvQZ7pCVRgb+jJ0i6WKXDLra+EISKha7faySm9f2dVweo5C
	nuRounHVMls/faT4cv3vwM92mXI+j/Zj2k6k0YENOmeG1WfuCeyHvBrcyhK2Q02iIIDR68MhwXx
	HE9cXPkqhGx4jWDuDCbQz1gODT40ObmPJRppKyQZkUWOSKabkWDZqh56PyOh6EA1+RbnXjn7l+0
	c7I6suxGhRPYRJsotan+4Tuxm6hyZR8MIHYTRmqToqd2g9zSy6BkTjzPJ4KjmtyhCpZphRg5fbd
	SRDHKF47068HpU27Vfsoj3gTtEWk9yGwnz73sNcnJVnPpxOCWZWIqD5Y8KGaR7bGmkBcgDUSzJ8
	wre78j+ESy3VKAEYGjqyAEHYReXZ3Af4hMA9Hz0tL16JxO+vBVuE0EIk=
X-Received: by 2002:a17:902:e5cf:b0:2ae:608d:ecc8 with SMTP id d9443c01a7336-2ae80214aa4mr1411655ad.27.1772726875203;
        Thu, 05 Mar 2026 08:07:55 -0800 (PST)
X-Received: by 2002:a17:902:e5cf:b0:2ae:608d:ecc8 with SMTP id d9443c01a7336-2ae80214aa4mr1411195ad.27.1772726874546;
        Thu, 05 Mar 2026 08:07:54 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae489c3626sm133773575ad.8.2026.03.05.08.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 08:07:54 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v3 03/15] wifi: cfg80211: Add MAC address filter to remain_on_channel
Date: Thu,  5 Mar 2026 21:37:00 +0530
Message-Id: <20260305160712.1263829-4-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEzMCBTYWx0ZWRfX68VXIZR15iyb
 kUv0qlxZdxh0yoOhGK5u+/0RvCQKJ7bqem7+W03bzNBRIUPOISUAkJVWc+/TY2kPanDK/l/HuVE
 280zrIfCZbrRgURkPKQw3T3jIdh55S4xj8T2zE3AV8AB9G4CsSc4QNTmFgxL7WuRNmtI0klnYUd
 4tR6A4hZQ1qHsDhhD4+4sDVkLBrl4VRzgBdvhUbHLUdQikk2Rfxs3cpHTjwGjtRMHBRvwDADW2v
 uueJEN8akYqe+JmKdgr1Y3rDLepdnNCK0/VCM7Zj3jGH+59IfEiqUp5p+bb6PuKhNwUDKJPxhUI
 faPtjQ0ODg6FEKP2+PigmTCFQZc2aYc75eLzoE8xBll0yiiAL4ifZVhyr8ZQcxwVHbeldf54dCD
 Dh/vLw6NQYkkVEATZEKtpRYUroI42PI5KmGdOGuG3Ywx/fjEV83DtJgpCb5daY5qmZdnYxV257g
 RoNCPKuqj0ZDoDaVi2Q==
X-Proofpoint-GUID: e9woo-F_DL91hVrlIiI_vBa7kyB6VRsv
X-Authority-Analysis: v=2.4 cv=SqydKfO0 c=1 sm=1 tr=0 ts=69a9aa5c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=0xrcVbMI0WWvuKK7pMEA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: e9woo-F_DL91hVrlIiI_vBa7kyB6VRsv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050130
X-Rspamd-Queue-Id: 55E76215251
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32552-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Currently the remain_on_channel operation does not support
filtering incoming frames by destination MAC address. This
prevents use cases such as PASN authentication in the
responder side that need to receive frames addressed to a
specific MAC during the off-channel period.

Add an rx_addr parameter to the remain_on_channel operation
callback and propagate it through the call chain from nl80211
to driver implementations. Introduce the extended feature
NL80211_EXT_FEATURE_ROC_ADDR_FILTER as a capability gate so
that cfg80211 rejects the request if the driver does not
advertise support for address filtering. Extract the address
from the NL80211_ATTR_MAC attribute when provided in the
netlink message and update the tracing infrastructure to
include the address in remain_on_channel trace events. The
rx_addr parameter is optional and can be NULL, maintaining
backward compatibility with existing drivers.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c           |  3 ++-
 drivers/net/wireless/ath/wil6210/cfg80211.c          |  3 ++-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c   |  4 +++-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.h   |  3 ++-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c      |  3 ++-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c   |  3 ++-
 include/net/cfg80211.h                               |  2 +-
 include/uapi/linux/nl80211.h                         | 11 ++++++++++-
 net/mac80211/ieee80211_i.h                           |  3 ++-
 net/mac80211/offchannel.c                            |  3 ++-
 net/wireless/nl80211.c                               | 11 ++++++++++-
 net/wireless/rdev-ops.h                              |  7 ++++---
 net/wireless/trace.h                                 | 12 ++++++++----
 13 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index 739a24a6ad67..cc0f2c45fc3a 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (c) 2004-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2012 Qualcomm Atheros, Inc.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  *
  * Permission to use, copy, modify, and/or distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
@@ -3033,7 +3034,7 @@ static int ath6kl_remain_on_channel(struct wiphy *wiphy,
 				    struct wireless_dev *wdev,
 				    struct ieee80211_channel *chan,
 				    unsigned int duration,
-				    u64 *cookie)
+				    u64 *cookie, const u8 *rx_addr)
 {
 	struct ath6kl_vif *vif = ath6kl_vif_from_wdev(wdev);
 	struct ath6kl *ar = ath6kl_priv(vif->ndev);
diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 3d6e5aad48b1..d6ef92cfcbaf 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2012-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/etherdevice.h>
@@ -1734,7 +1735,7 @@ static int wil_remain_on_channel(struct wiphy *wiphy,
 				 struct wireless_dev *wdev,
 				 struct ieee80211_channel *chan,
 				 unsigned int duration,
-				 u64 *cookie)
+				 u64 *cookie, const u8 *rx_addr)
 {
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
 	int rc;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index e1752a513c73..92c16a317328 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -970,10 +970,12 @@ brcmf_p2p_discover_listen(struct brcmf_p2p_info *p2p, u16 channel, u32 duration)
  * @channel: channel to stay on.
  * @duration: time in ms to remain on channel.
  * @cookie: cookie.
+ * @rx_addr: Address to match against the destination of received frames
  */
 int brcmf_p2p_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
 				struct ieee80211_channel *channel,
-				unsigned int duration, u64 *cookie)
+				unsigned int duration, u64 *cookie,
+				const u8 *rx_addr)
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct brcmf_p2p_info *p2p = &cfg->p2p;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
index d3137ebd7158..9f3f01ade2b7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
@@ -157,7 +157,8 @@ int brcmf_p2p_scan_prep(struct wiphy *wiphy,
 			struct brcmf_cfg80211_vif *vif);
 int brcmf_p2p_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
 				struct ieee80211_channel *channel,
-				unsigned int duration, u64 *cookie);
+				unsigned int duration, u64 *cookie,
+				const u8 *rx_addr);
 int brcmf_p2p_notify_listen_complete(struct brcmf_if *ifp,
 				     const struct brcmf_event_msg *e,
 				     void *data);
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index c9a651bdf882..c9daf893472f 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -304,7 +304,8 @@ static int
 mwifiex_cfg80211_remain_on_channel(struct wiphy *wiphy,
 				   struct wireless_dev *wdev,
 				   struct ieee80211_channel *chan,
-				   unsigned int duration, u64 *cookie)
+				   unsigned int duration, u64 *cookie,
+				   const u8 *rx_addr)
 {
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(wdev->netdev);
 	int ret;
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index 3a774cc44b26..6654fce4ded8 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1100,7 +1100,8 @@ static void wilc_wfi_remain_on_channel_expired(struct wilc_vif *vif, u64 cookie)
 static int remain_on_channel(struct wiphy *wiphy,
 			     struct wireless_dev *wdev,
 			     struct ieee80211_channel *chan,
-			     unsigned int duration, u64 *cookie)
+			     unsigned int duration, u64 *cookie,
+			     const u8 *rx_addr)
 {
 	int ret = 0;
 	struct wilc_vif *vif = netdev_priv(wdev->netdev);
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a54300b6899a..73cfe1a14c01 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5082,7 +5082,7 @@ struct cfg80211_ops {
 				     struct wireless_dev *wdev,
 				     struct ieee80211_channel *chan,
 				     unsigned int duration,
-				     u64 *cookie);
+				     u64 *cookie, const u8 *rx_addr);
 	int	(*cancel_remain_on_channel)(struct wiphy *wiphy,
 					    struct wireless_dev *wdev,
 					    u64 cookie);
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 8e4f9192d8b7..49f4704ce627 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -729,7 +729,9 @@
  *	to remain on the channel. This command is also used as an event to
  *	notify when the requested duration starts (it may take a while for the
  *	driver to schedule this time due to other concurrent needs for the
- *	radio).
+ *	radio). An optional attribute %NL80211_ATTR_MAC can be used to filter
+ *	incoming frames during remain-on-channel, such that frames
+ *	addressed to the specified destination MAC are reported.
  *	When called, this operation returns a cookie (%NL80211_ATTR_COOKIE)
  *	that will be included with any events pertaining to this request;
  *	the cookie is also used to cancel the request.
@@ -6828,6 +6830,12 @@ enum nl80211_feature_flags {
  *	(NL80211_CMD_AUTHENTICATE) in non-AP STA mode, as specified in
  *	"IEEE P802.11bi/D4.0, 12.16.5".
  *
+ * @NL80211_EXT_FEATURE_ROC_ADDR_FILTER: Driver supports MAC address
+ *	filtering during remain-on-channel. When %NL80211_ATTR_MAC is
+ *	provided with %NL80211_CMD_REMAIN_ON_CHANNEL, the driver will
+ *	forward frames with a matching MAC address to userspace during
+ *	the off-channel period.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6907,6 +6915,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_EPPKE,
 	NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION,
 	NL80211_EXT_FEATURE_IEEE8021X_AUTH,
+	NL80211_EXT_FEATURE_ROC_ADDR_FILTER,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a4babf7624e5..c8e58877e2a3 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2068,7 +2068,8 @@ void ieee80211_roc_purge(struct ieee80211_local *local,
 			 struct ieee80211_sub_if_data *sdata);
 int ieee80211_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
 				struct ieee80211_channel *chan,
-				unsigned int duration, u64 *cookie);
+				unsigned int duration, u64 *cookie,
+				const u8 *rx_addr);
 int ieee80211_cancel_remain_on_channel(struct wiphy *wiphy,
 				       struct wireless_dev *wdev, u64 cookie);
 int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index f60f6a58948b..5f398d38d1c9 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -706,7 +706,8 @@ static int ieee80211_start_roc_work(struct ieee80211_local *local,
 
 int ieee80211_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
 				struct ieee80211_channel *chan,
-				unsigned int duration, u64 *cookie)
+				unsigned int duration, u64 *cookie,
+				const u8 *rx_addr)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 	struct ieee80211_local *local = sdata->local;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2225f5d0b124..2d22fd405c39 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -13798,6 +13798,7 @@ static int nl80211_remain_on_channel(struct sk_buff *skb,
 	unsigned int link_id = nl80211_link_id(info->attrs);
 	struct wireless_dev *wdev = info->user_ptr[1];
 	struct cfg80211_chan_def chandef;
+	const u8 *rx_addr = NULL;
 	struct sk_buff *msg;
 	void *hdr;
 	u64 cookie;
@@ -13810,6 +13811,14 @@ static int nl80211_remain_on_channel(struct sk_buff *skb,
 
 	duration = nla_get_u32(info->attrs[NL80211_ATTR_DURATION]);
 
+	if (info->attrs[NL80211_ATTR_MAC])
+		rx_addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
+
+	if (rx_addr &&
+	    !wiphy_ext_feature_isset(wdev->wiphy,
+				     NL80211_EXT_FEATURE_ROC_ADDR_FILTER))
+		return -EOPNOTSUPP;
+
 	if (!rdev->ops->remain_on_channel ||
 	    !(rdev->wiphy.flags & WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL))
 		return -EOPNOTSUPP;
@@ -13857,7 +13866,7 @@ static int nl80211_remain_on_channel(struct sk_buff *skb,
 	}
 
 	err = rdev_remain_on_channel(rdev, wdev, chandef.chan,
-				     duration, &cookie);
+				     duration, &cookie, rx_addr);
 
 	if (err)
 		goto free_msg;
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 2bad8b60b7c9..3c0fff3cb5ac 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -736,12 +736,13 @@ static inline int
 rdev_remain_on_channel(struct cfg80211_registered_device *rdev,
 		       struct wireless_dev *wdev,
 		       struct ieee80211_channel *chan,
-		       unsigned int duration, u64 *cookie)
+		       unsigned int duration, u64 *cookie, const u8 *rx_addr)
 {
 	int ret;
-	trace_rdev_remain_on_channel(&rdev->wiphy, wdev, chan, duration);
+	trace_rdev_remain_on_channel(&rdev->wiphy, wdev, chan, duration,
+				     rx_addr);
 	ret = rdev->ops->remain_on_channel(&rdev->wiphy, wdev, chan,
-					   duration, cookie);
+					   duration, cookie, rx_addr);
 	trace_rdev_return_int_cookie(&rdev->wiphy, ret, *cookie);
 	return ret;
 }
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index af23f4fca90a..56718e250d31 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2155,22 +2155,26 @@ DEFINE_EVENT(rdev_pmksa, rdev_del_pmksa,
 TRACE_EVENT(rdev_remain_on_channel,
 	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
 		 struct ieee80211_channel *chan,
-		 unsigned int duration),
-	TP_ARGS(wiphy, wdev, chan, duration),
+		 unsigned int duration, const u8 *rx_addr),
+	TP_ARGS(wiphy, wdev, chan, duration, rx_addr),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		WDEV_ENTRY
 		CHAN_ENTRY
 		__field(unsigned int, duration)
+		MAC_ENTRY(rx_addr)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		WDEV_ASSIGN;
 		CHAN_ASSIGN(chan);
 		__entry->duration = duration;
+		MAC_ASSIGN(rx_addr, rx_addr);
 	),
-	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", " CHAN_PR_FMT ", duration: %u",
-		  WIPHY_PR_ARG, WDEV_PR_ARG, CHAN_PR_ARG, __entry->duration)
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", " CHAN_PR_FMT
+		  ", duration: %u, %pM",
+		  WIPHY_PR_ARG, WDEV_PR_ARG, CHAN_PR_ARG, __entry->duration,
+		  __entry->rx_addr)
 );
 
 TRACE_EVENT(rdev_return_int_cookie,
-- 
2.34.1


