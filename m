Return-Path: <linux-wireless+bounces-33599-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEZxGfCLvWnY+wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33599-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:03:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D759F2DF1BB
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9AA93078293
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 18:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239D131195A;
	Fri, 20 Mar 2026 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kQNnXYxW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="adLffcC1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74603320CD9
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029641; cv=none; b=oKtCX2GbzNb2UgnczO2rjowjKopGmulEx823YTx9PmhqOZlbVHiixks0WTIbeQC9yBXZZecQ/74QgE6rdF4QqqblYcTOCWMSN9e+HYZCU4Pk4dveDiGx1FRuU8ExDNstHAVhALDQ1OSRmWKzLzFO13ANG4P1PPtTfd/whkacuuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029641; c=relaxed/simple;
	bh=G48oYDO1w5fIdNZLo85svJ3rVTBM18zxntTBt+pKXa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lw8ctgb3VkVa27s2MOyJSPO0XLXgPknBdRjsn9xTNJSmgOh6pl/R/bJfnXlAWxlWBg0YtoA1lbguBSpfVEAiYHp5UgqICcD1KsKL+fvGe0SRrvb2b9kekE9c+QSFAMvlXTzKtqR9Fur4aLZMzmZatxihMc2dLu0+FTonkmNg/9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kQNnXYxW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=adLffcC1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KEIUEb332454
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NE+SWdat8pq
	gVZXMFDnZc/3+l6DxAxwV62xPk37amvU=; b=kQNnXYxWOUYT4CqcuhO7QT3KvjA
	tu5icrnmIflaV9aCCpaWVmC/xP2u8qnCd41l/9nwbR4umUmGPE8oBC9TOOaKEQdN
	sANvbk0ku2e09L0/0CMlgfJHQ/nLVuRO2AmpewtEPHegK3BOZvq/E5a2E1tZjMBw
	fvf64URi+/aTAuEGqYTIyazVVD/Sn3wXGx9ksVKAsYVQ+6hC+yHJG3QGgG2gMpQL
	Irp3XwO9R5m3zv9oBWbVscW6dxUczpB234w3X59cemS02mW0cArehVidKtnN495C
	Wv/qo7xd17MmqW4XkdnyezsoAYC9nawVW0uIerT/4fJH1JH+S1yotI8PNMA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0k0846g6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b061868724so154380365ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 11:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774029637; x=1774634437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NE+SWdat8pqgVZXMFDnZc/3+l6DxAxwV62xPk37amvU=;
        b=adLffcC1dqp8w6nexjK/7x7HY8HBuOwebICY/oKzvGfTDh8wiDpSvuy/jkCnabdPrR
         gDwD4iTdtWrz+uUPwVtvAezk0iCsFHGscfn+NmroicMiHUwAoAKjpnhrlF4JJtxphFK4
         5XwF7ba+G09LNpp01+8J+7HJA2HfhfmwH1RwjRARX6JxpJYHupIJlJn3A3SrPINWRx5g
         lB1ez5TwlGDaJc5QeLz+Ambz92BhhDc2fNjAgnazncpvu1MKylr4lK7knpiobxvcbD54
         6gkkCTh1vSaFQ2S10Rl/1kp0B2Vbe77uuwtZe0KPE5rtwPqKzUXsyXsesFmWpYzrkuqr
         sn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774029637; x=1774634437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NE+SWdat8pqgVZXMFDnZc/3+l6DxAxwV62xPk37amvU=;
        b=laEHc1F6+7SqWGm2eXMu5c18+vdcrtZFiHC3o71AgEp+PoCEkhHnWpW6ab3DvB2a/k
         IKtFQjxezVGfmZu+4OVASXebuJh4FuLC0CCY0P/x69hds9FWCHtN0zpB0nud7B1ELl69
         YiU77yJxjXDwNqFff90i25FE8vcx67+V9dGWOWDcBW8zWUCUQE9C28X0srsz4zoDG/IP
         /Cm+zb+lUmpguvkeMstkgVN4JWAgiZ6lj2yJxl4A6kKKlqGy5DWZ79gjJezuZxA1QEAZ
         +m0pyKNtfgRnqbIVG8Q9zsrQzp4C0h0WlBXL9iAkczubdBlfPaUWoLHztiQvhgmrE4B/
         hKrQ==
X-Gm-Message-State: AOJu0YzzknUcD3XHzT+NDRmpsoLmBU6DQ2uiBDuGzSKu152QgwSTV3KK
	TbKeDaab6qx1dQZCk7zs6C0BN05gkHt3qoDaCgDRhp/LSPjBVlJmljzZ99GKo1q97xoAfg7iMjr
	pHBiMEmzqAbAReOyzbw0C8xfTTvzHsQc5+q5ES2dMviGCPT4UPnU6k5vio7Ltn2nnZ45JPryMLA
	Td
X-Gm-Gg: ATEYQzwu8/z1BfgGWSvtCwSvjfrEdtqRt8c/IpEXjZDVI4PYnSSuWGEFTa2046oijmk
	94tMt3Octarirrwk8rfkl3731BoMSblZLqf+2q5t6GgVqRSW87emfFS5oal6bOY4Oe8dlpaJyNS
	S63Hx773Vhy++yjNS+aRovPPzaIed0YnbrM2SG/vekcu4vYkt04xsdAbB15CkRbdF1cajQs6IzB
	+FH7PuRijoAA9u1m9T0Aaz6X5Xzc93PslreSwPmSxj9I55EM4SlyR/M9tdHLLGvLI0ThPm9Gd/H
	2md2bDnmaRCLh1yAJ+HG+05n8uQZnasCtpW6hBnHevq0k+IW+8+jbYNI423RHHa5tch5kt7nRwm
	s5nr7s9PsGe783hz1pIWpDJ8cbbU6eOPIpWvIhCJd2X8+qGcw6n7bB9k=
X-Received: by 2002:a17:902:ecc1:b0:2b0:5923:5194 with SMTP id d9443c01a7336-2b08279743fmr36877005ad.27.1774029636662;
        Fri, 20 Mar 2026 11:00:36 -0700 (PDT)
X-Received: by 2002:a17:902:ecc1:b0:2b0:5923:5194 with SMTP id d9443c01a7336-2b08279743fmr36876615ad.27.1774029636116;
        Fri, 20 Mar 2026 11:00:36 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083529e8asm29926225ad.20.2026.03.20.11.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:00:35 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v4 03/14] wifi: cfg80211: Add MAC address filter to remain_on_channel
Date: Fri, 20 Mar 2026 23:29:27 +0530
Message-Id: <20260320175938.2547288-4-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320175938.2547288-1-peddolla.reddy@oss.qualcomm.com>
References: <20260320175938.2547288-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=MYhhep/f c=1 sm=1 tr=0 ts=69bd8b46 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=0xrcVbMI0WWvuKK7pMEA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 0x2FW01j767bcgLDzNs9dutdBQaJSrN9
X-Proofpoint-GUID: 0x2FW01j767bcgLDzNs9dutdBQaJSrN9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE0NiBTYWx0ZWRfX5PJu//YzJb33
 0ZM7j3EkqPCpupefMQueNKo1bTPkPMAifrQA6JohElbuWoJo+dRcstk6Oi3NE+xDEiLEJpbZJvX
 PHcIwLg1uyJeaRDmwf3wZew+M/IgxPvc9vZ0iBBfEhTTB8nVST96xRi8oG2Ky4egrMIEGLndUi8
 lswFoSnAZghQVKDZNb9HbSBFsSMbsieQvESuc0viZuZEHSjzDEvW8xx/0M4dCiy2yb62b0xx6Us
 bzcq07NPqN9my8L1uHe5g6EuezDUPKgaZRS7LlF957ob+Bc/stpQra7GSSRnWJAn3zPD/LNLG6W
 InSsm6HzYFIMrRSUO9YiNLeJA4+JCxq318E8nLEBe3Z4agTVngLNpx5N/HBZbSMCmANAxl47gi5
 /0/UNHsFTRVHkn0LfRF/jgitXLKnw43UrbVKC3aW9BQD4yaL/gw06cagFmpAm8HNS4Q3Q1D6rL3
 j5Jjnspkvw03qCmOSSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200146
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
	TAGGED_FROM(0.00)[bounces-33599-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D759F2DF1BB
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
index 8cd870ece351..ce5ed86161bc 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5081,7 +5081,7 @@ struct cfg80211_ops {
 				     struct wireless_dev *wdev,
 				     struct ieee80211_channel *chan,
 				     unsigned int duration,
-				     u64 *cookie);
+				     u64 *cookie, const u8 *rx_addr);
 	int	(*cancel_remain_on_channel)(struct wiphy *wiphy,
 					    struct wireless_dev *wdev,
 					    u64 cookie);
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 67d764023988..7e139c746c32 100644
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
@@ -6834,6 +6836,12 @@ enum nl80211_feature_flags {
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
@@ -6913,6 +6921,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_EPPKE,
 	NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION,
 	NL80211_EXT_FEATURE_IEEE8021X_AUTH,
+	NL80211_EXT_FEATURE_ROC_ADDR_FILTER,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index d71e0c6d2165..09819cc801f5 100644
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
index e15cd26f3a79..8547209dd504 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -13809,6 +13809,7 @@ static int nl80211_remain_on_channel(struct sk_buff *skb,
 	unsigned int link_id = nl80211_link_id(info->attrs);
 	struct wireless_dev *wdev = info->user_ptr[1];
 	struct cfg80211_chan_def chandef;
+	const u8 *rx_addr = NULL;
 	struct sk_buff *msg;
 	void *hdr;
 	u64 cookie;
@@ -13821,6 +13822,14 @@ static int nl80211_remain_on_channel(struct sk_buff *skb,
 
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
@@ -13868,7 +13877,7 @@ static int nl80211_remain_on_channel(struct sk_buff *skb,
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


