Return-Path: <linux-wireless+bounces-35024-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PAPK1rt5WnxpAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35024-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:09:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 51105428AAD
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94DE2300D0E8
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 09:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B650A388E73;
	Mon, 20 Apr 2026 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f64tEB1t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gn1ZV4wB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2C738AC96
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676180; cv=none; b=qXWQvee9Ijz3HEM+WicrsoUCztH/VRzOxkNviGgWAcQpbYSY+3mogqUHIkoi0n7XdOVgqHPBg4jRZQxdTA4G68QpYs9PxjXUsDwEjq4+Bsrrqc5lIjbwas38Nf5xpVkgonybeRD6ShHBvbpfqVO5QKf5cuFlL3i91YQYd9ryp58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676180; c=relaxed/simple;
	bh=W3FeMsbEzemHaT7cXM89NJ1TSMBgoPYoj1jESapleXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nlddnwaI903VkFSCVx1d6wZZnUJFV12W7Kr386Q3CbevCcMZD0Jk50VrpdsMCs7YQpQ42h0UBqWDs+sGSt5vpryQXmshrS4kUp9fU9ZgZxiJf9/uyXjGgj4jXb8gyE3Dury79tsQ3LiAB6UeGYlaouZu25AKS8PZoD2+gc2Iu6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f64tEB1t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gn1ZV4wB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K7Wt1a1532103
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=SGrxciHxHAQ
	6tLaTN2Cs6clZq644yq6UtEaNaHZgUSI=; b=f64tEB1t8nokViz0DnVSLJXbBaH
	Aj1HDMoIj6cPSubWrEocCfe2UaP96iIl8kfgxPE1tkz0IRRHS3G3E4ZppoFuQMn7
	IQasCTl+QNpPL/EKkZ2LmeFw94JIQ+EJMKXXoTmp7/L+QwwZuYV7fPRjYWombDqu
	33WYhh5xcskUXmLTdPrbp26o/Op4z1PRHU6JA9Fyj98uUBBNoLQijVPdlk265vG1
	JAfbCrGWp5mWJ+8lmq0FropuDNPBT5vaPF+TzzPCkwqRVIQliZWjzcDEsvMWna7e
	DtMokFjBACARtafN4hdY2ACA2G+cqVrjTwOXlhPmsSvHLyf0dhf/yGyoMpw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfus0nqn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:38 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35e5791871fso5475434a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 02:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776676178; x=1777280978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGrxciHxHAQ6tLaTN2Cs6clZq644yq6UtEaNaHZgUSI=;
        b=gn1ZV4wBitd85RcyjqPiHa8stFRcbOOfhLaPQzPRqmOfoEa89/wwWOw8n6328LGhXR
         9iDREQGmxLsDaNY9koMSDC3v6Ev9b/cjY3jEg9nqRNkk81FhH/ZDVjpHr+sYIIhYM8T8
         7H/6LrrtIvMHrJ5Z7OV4ql8uWUECUruLYN7ynMIz1/LAw1rMvmvUsAHaAoK4nnojZfTO
         7KUnwYPV6nWsuzt4y5muHyWscHOBv1Gvh+mRXdr27wRMuSFCtR9L3gLtFONdF4/YI7LZ
         2xiLAwVuIUIFTnLPUU9g6VHDC3NCUJv4LlkbEBHSEwXaQ83JiQo6QAvXKxjejg9FF3gy
         6zXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776676178; x=1777280978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SGrxciHxHAQ6tLaTN2Cs6clZq644yq6UtEaNaHZgUSI=;
        b=JtQZf0euFbg+Be9oZTk7oSUCR+fllA0zRTZA2ta4tmy7AnVav8Gx762GMq5P51yRzK
         6ERAMu6Vjak66e6gxOiwIpEbtuSVpdrLavy9ZXtsHXUU/3pMBNoYbfFwC/tMFBlBj2pn
         h9IylNtLST+OGBv1O/xnjebhB/B57CVk+vi8nBKMYfG6SaSgfAm0j8SPaLYSyBnFxqPt
         umDUmfflT2syJiVkK6SPSqpjDMRftLcU7Op55WguSPw6/rdDwmgY9rc9/iziWAMz/WLM
         5nlbW+c33ijSmpu7ZWrljtS59qweu6aHqZ84RT8LNzot96g05DmsZi4SiRm8Y66+w8XM
         CRwg==
X-Gm-Message-State: AOJu0YyUnVNJeZW/MHguE6YPnbNjoPFa9A6YjogYd6KhW89eKFotcvDH
	TKH7kyLhW/A3hik/eyWgiev9Fmv9/AIep7UGnvfselZqDj8UOeq8AgwYzjVsfMxpB+ZsP1HzO7n
	kd0Kk+DlIV1Znlu39X/KTXqsFjdCjcD4rA/ZTLeAsHsCI3EhSrVjK5SXB8qTyWjqfaB1ljEilSA
	Lj
X-Gm-Gg: AeBDietn+IdNX9oZtfI4mEz7fyFsTQgjgCcxX5CPaKhZDoW4rVjTE3uyJ0o7y5KBs37
	2YnhR096iTUfIbE+RWcI8vGx9h4ZK91JcxoMIelRwi3WGsliWh23+nEtbNnEObyaLlyUrCNA+g/
	xR+hlyEw5g1QwrZHV0Qwey32zj4daEaIbWpiEPLGSA0OEt/VXg7wCmbIyYQi3IvBVrcK5AbIcEi
	hSyi/CQdgQR/pUQ7tVVAKOxltxnAklCAmjkDyUhrI58at7BoHbsS3Njoo5iqFTr69iiJpxNUT8V
	nUYw4aB0UbJ23alBxoRvdW8aSA4rrK6bA9LvfvxCicY2BTOL/qO05NrP1zl0/aUnvWDkxdyMhES
	qFsKsVp6jv2Zy8ZAJwzMGkG3+f3YeH9zOd9tJP/inD94wBBjS5zZxNLWA0+ctKJI/5Q==
X-Received: by 2002:a17:90b:2cc6:b0:35f:bcfc:27b8 with SMTP id 98e67ed59e1d1-361403d2e7amr13142412a91.7.1776676177556;
        Mon, 20 Apr 2026 02:09:37 -0700 (PDT)
X-Received: by 2002:a17:90b:2cc6:b0:35f:bcfc:27b8 with SMTP id 98e67ed59e1d1-361403d2e7amr13142386a91.7.1776676176996;
        Mon, 20 Apr 2026 02:09:36 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fba1436sm3812551a91.11.2026.04.20.02.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:09:36 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        peddolla.reddy@oss.qualcomm.com
Subject: [PATCH wireless-next v5 02/13] wifi: cfg80211: Add MAC address filter to remain_on_channel
Date: Mon, 20 Apr 2026 14:38:45 +0530
Message-Id: <20260420090856.2152905-3-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420090856.2152905-1-peddolla.reddy@oss.qualcomm.com>
References: <20260420090856.2152905-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4NyBTYWx0ZWRfXzCi+PMXWddLs
 4TjzXxyqFLdauJFMgmfuevdaZWZ3KUV7NyixZ7K9UqOO/z66TGRiJ79LtxCnJFu6e28ocuIxfyJ
 zuRWtZ4i9x60mVokwvDqYfmjnEqvBI9x1CKyQovxt8QvCuo3AvXXwq7BXOXxJeejHDlzZhTSLlx
 IWGUCqyAQRWJ7rtLV2NmRkRv5GetU1wgeHIqq64PGFk3QM/eG1l3U3nsHLWFkgnkiFwqlwbHQyO
 tYMV5wF7+TPbnlRx4xN8vtm4DEVkmVQ6TNsciXeCapttpPHMxDmeaDyzGGyH9h+ZLMKlayqaIyX
 1Zj3YADLWP3kGryroMJqW830HD9vkYONXaNfuoVquMaK5xg+g6h8C2MwgODnV1qD1UU250Gufsj
 N3ZdNCJBuku5ohKXZXTVWXcLrAeJRlo1FGMGjtGCVCkEgH5sa0C8RYnOkwp1FDP0vYegJXathpp
 GS/k1AxmrLwYwQtRhsA==
X-Proofpoint-GUID: xL4KAn3JC2F_HTwE1yPyy4Fxans5k_di
X-Authority-Analysis: v=2.4 cv=PMQ/P/qC c=1 sm=1 tr=0 ts=69e5ed52 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=0xrcVbMI0WWvuKK7pMEA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: xL4KAn3JC2F_HTwE1yPyy4Fxans5k_di
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200087
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
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35024-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 51105428AAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 9d3639ff9c28..25847230428e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5267,7 +5267,7 @@ struct cfg80211_ops {
 				     struct wireless_dev *wdev,
 				     struct ieee80211_channel *chan,
 				     unsigned int duration,
-				     u64 *cookie);
+				     u64 *cookie, const u8 *rx_addr);
 	int	(*cancel_remain_on_channel)(struct wiphy *wiphy,
 					    struct wireless_dev *wdev,
 					    u64 cookie);
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 3d55bf4be36f..7f3d6d60b8ea 100644
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
@@ -7029,6 +7031,12 @@ enum nl80211_feature_flags {
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
@@ -7108,6 +7116,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_EPPKE,
 	NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION,
 	NL80211_EXT_FEATURE_IEEE8021X_AUTH,
+	NL80211_EXT_FEATURE_ROC_ADDR_FILTER,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 2a693406294b..fca9852bff3b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2093,7 +2093,8 @@ void ieee80211_roc_purge(struct ieee80211_local *local,
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
index f334cdef8958..541da67fafe1 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -14066,6 +14066,7 @@ static int nl80211_remain_on_channel(struct sk_buff *skb,
 	unsigned int link_id = nl80211_link_id(info->attrs);
 	struct wireless_dev *wdev = info->user_ptr[1];
 	struct cfg80211_chan_def chandef;
+	const u8 *rx_addr = NULL;
 	struct sk_buff *msg;
 	void *hdr;
 	u64 cookie;
@@ -14078,6 +14079,14 @@ static int nl80211_remain_on_channel(struct sk_buff *skb,
 
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
@@ -14125,7 +14134,7 @@ static int nl80211_remain_on_channel(struct sk_buff *skb,
 	}
 
 	err = rdev_remain_on_channel(rdev, wdev, chandef.chan,
-				     duration, &cookie);
+				     duration, &cookie, rx_addr);
 
 	if (err)
 		goto free_msg;
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index bba239a068f6..d97d5c08d135 100644
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
index eb5bedf9c92a..938fea1fe9d8 100644
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


