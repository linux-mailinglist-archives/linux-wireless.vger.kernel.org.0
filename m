Return-Path: <linux-wireless+bounces-34759-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CISpGhFe32m5SAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34759-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 11:44:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 191A9402C67
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 11:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03A0F3047EFC
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 09:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD8C33AD8B;
	Wed, 15 Apr 2026 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bMS6oWOp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RqxDk7v+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5BE33C195
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246215; cv=none; b=Tu157XvQyes/0KXJ+r9HepGs001tZNuX54qIw9IQW2lDRXekV4s4ZavIJsg+rG2MqPe6LcIbZc1Z2mHVQW7gjtkP/btouU9ogZiJJgMaxZDU+WbL99b/jMvGxFgyaxmup4Ft+jxNEq9XUqcr2FqKGNXOhKgVZvLailDut7OrI5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246215; c=relaxed/simple;
	bh=qwPelY5ICqzVgwNOB2zRKi7+mw+U0luOILnba+fn52c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=olWSa/NW2mlrssXYMoUTbk0RH0jNOjFqrY2sTqMRhMK+0FctUbE4ogdY8F16iwuAxGfnNa/8cTb4Gs8kMVv5TdW2QdU9Gr9V7VQAGcZaK27GXSmlf6L90m2GtbDj5QmyezDlkGUHgjsZCKZneAQqUtwok0604FTn7UgOzIzyxJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bMS6oWOp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RqxDk7v+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F8uAXf731025
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 09:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=iEhGMF4yTOa
	lUogbEiS/Oidfy409TmFBX22jKoCwKBw=; b=bMS6oWOpTQWwYfxVAy0EZ3EJuey
	y9hg7Yxgqy8gW7E0kBbQtmfaJtZ2gNzsTeBkBM568Tm/+EQCwVgAnDmxEmcAyrwd
	A/4tuV9AHUneH3bqXz0VqD918ozsJqI6bkB6ZP4EmTd8rQmBDcCN7n+3xJafJPFZ
	Qjg8shM7Z1/3kbzHEUZuTEipyo2En9DoOssI8L6gaBX9FxbouOJzN4rnjcIgJzVH
	Hrv3h5zYqD/CL2h0z4qEOM1BmDS/wFpb2eaD9EIVYfBKCY3psFCSIdl4wuzSGh6i
	Z1iR/v+wTxVk8wxG4HHJFaz9/elh+wRdVgwgS2KFvWfyR30NSKsl1iKWcPA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhruub5m8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 09:43:31 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35da8eb0553so6582617a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 02:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776246211; x=1776851011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEhGMF4yTOalUogbEiS/Oidfy409TmFBX22jKoCwKBw=;
        b=RqxDk7v+4p7+2zYEk4qr4trJJYhF8qPeK9UPeJdV3rVyNuNry4KNHme/sl/XehP7h9
         VCyXIBt/ZNgEVL2jfR+pSl8KxC1ytnViD85E9h/gwDXVmuCnqSlLD6LQCyCBVFGh44sx
         YGEb06hMfxY/NDIvU6shaSX71aizaZUVEfRLTsABD06QQiRX8OQIHTCe1QgU3bCpFquc
         OpPgzOg8T+RhJU2f54ofdEHm95sujPafwz3zjl8aSQWWLIrjjkwNokzEUdn6KMiKQ5tL
         wxH+Ou01vRxCad3DdBxxzYVxTtSLNZi+Fj3izN4BnQu+r9bc1M62sgdd/sa/qRgdqt7e
         ar6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776246211; x=1776851011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iEhGMF4yTOalUogbEiS/Oidfy409TmFBX22jKoCwKBw=;
        b=jn3cj8ho0cODNLSkl7IwrLSBa/4YY8C/fVzi2+e+llvHSLK4VtnKaG3aUkykMoJ+Cz
         QtYgvtMF6EDZqLXyG8b6/r+Du6iPRhNWmjEKcOPw0GYHptTf7e4JvfdXFoenb35DdQ8v
         O5Kr5IkaGeSJqQPbRkPEE1Alk3LAX7JsEAe4x6azKXnDBS1cIA738Lkg52ZYguB0ZIm3
         sPrgHlNsGKvTvfVTAwJS4kO1A5ZMkv7TdUrhsce/a6t+HgPzFzU7InJRh/f9pnz4lWsp
         gat9b8Ifz47D8rACaoypb42g3hbVkoVZnHJyRf2+U21uVmHH8CAVng650ChxRIqp2q5d
         9q+w==
X-Gm-Message-State: AOJu0YwqrwffDIRiHX4FTmWs4xWybo2vUHq6Laiv8NGINSi63BIq6ZZa
	LbltI3W03Uit6FykBcIpyCkPS2u62194Kq3E2XiR8lhi5d8jBkW4PLxpqGywXiCgYApawsBURiK
	8O8WYrj16VCF4LJpOARnl9knyslm3h/xwRhG7iiyI+c5vUakGOUDKIsndbjD+lg0+wUiT8Dqe1F
	kBeA==
X-Gm-Gg: AeBDieuhQA5hzN6+dNz0bSHgGVKnu1W/rHNdEAZyDAZHyT9valzxPjtV0c8WG7gvUGZ
	C/HuQkpnfeID8nQLEtqFXUnSrHgfStwVSrG3LxHDGG1ml8o3cARt7qs3/+lXqEo6UNRnOmolNVU
	Jb9/XVUIAmNtV5CLXd3FuQwhs3s8WNUFLd7VwdhUEiWYQvk4EiUvBZz1uOC6iGw7FO80M/6Eejf
	zinvKGx+LW5YiKNn7Jj+TJoiEzn66kglauQ3XTbDiOXn1m5hn7BBX1G7lgeHJ0JobOFvqsEcGah
	xttTYOceLUcubF2wT/44LOePuCIRmvh7SGRvxU/c/yiMysbWCBMRwkECJyzM7ASCqysFpNvQYre
	L7HVYILee5BgbJlSVhvO3VSONw7/FA7651J5VYizkKooEdGKytPOmp8BN
X-Received: by 2002:a17:90a:fb57:b0:35f:b3b9:3bf3 with SMTP id 98e67ed59e1d1-35fb3b94609mr7209583a91.10.1776246210808;
        Wed, 15 Apr 2026 02:43:30 -0700 (PDT)
X-Received: by 2002:a17:90a:fb57:b0:35f:b3b9:3bf3 with SMTP id 98e67ed59e1d1-35fb3b94609mr7209554a91.10.1776246210256;
        Wed, 15 Apr 2026 02:43:30 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd2101cf1sm2391200a91.15.2026.04.15.02.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 02:43:29 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
Subject: [PATCH wireless-next v1 2/4] wifi: cfg80211/nl80211: rename to probe_peer(), extend probe status, and update in-tree users
Date: Wed, 15 Apr 2026 15:13:02 +0530
Message-Id: <20260415094304.1731390-3-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415094304.1731390-1-pritiwa@qti.qualcomm.com>
References: <20260415094304.1731390-1-pritiwa@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: w5p1g7uirfTq3hoDV2a6lW3z9b_55FyW
X-Authority-Analysis: v=2.4 cv=dpfrzVg4 c=1 sm=1 tr=0 ts=69df5dc3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=oxEqpr3IIF0rXDadY8gA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA4OCBTYWx0ZWRfX4nz283m7gPMa
 58LcwJWLPDJjG79t/biEHqRfnCsP5BT8cyERWhpJqW8WN9RM+z0qD8AkvYKEkMP+dvngs8OWgKE
 rqraw48M9LhOR0uGUqmE2BnacxFK9kNDN2IThVORUCwh6eOKByQbs9AdTzq053JBlTid1ygj/BF
 OsKYWzp6ZVyNUzonFA8JlJ1hp8SthYeI7QY4El7UBXUva4BUgGoq8CXqYv85NmDGUHL6CIVP3Po
 HhPwMn0fdcImxWjwQ/Wn2mEfbAUar+oFtVFFAtwg80q/fzhuU8j93QyMdjUMNdfMJ92X/5bgjyb
 wD0I7FDV9NRZLhQSGiWn5JPzQsedNrFlgY33FHWV59PAP7T4//eVykcfyDSbh/kN7kf8G968EWx
 98+j78fHEzi1rzizKG8i4LwipYY7UcSiOS0ZH2qr7TfF036ffo5fWSKRhQeFesrC6NxfkNM3qAI
 0ZUP9p2m3h6WT++IyxQ==
X-Proofpoint-GUID: w5p1g7uirfTq3hoDV2a6lW3z9b_55FyW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150088
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34759-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qti.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 191A9402C67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>

Rename probe_client() to probe_peer() to reflect that probing is no longer
limited to AP clients and may be used for any connected peer.

Extend cfg80211_probe_status() to include peer and link_id so drivers can
report per-link results.

Update nl80211 handler to NL80211_CMD_PROBE_PEER with AP/GO requiring MAC
and STA/P2P-client omitting MAC (AP implied), and gate STA-mode probing via
NL80211_EXT_FEATURE_PROBE_AP.

Update in-tree users (wil6210, mwifiex) and mac80211 so the tree continues
to build after this change.

mac80211 switches cfg80211_ops to .probe_peer and passes link_id = -1
at the probe status callsite to preserve existing behavior.

This change is otherwise behavior-neutral, per-link STA reporting will
follow in a subsequent patch.

Signed-off-by: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c   | 11 +--
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  8 +-
 include/net/cfg80211.h                        | 16 ++--
 net/mac80211/cfg.c                            |  6 +-
 net/mac80211/status.c                         |  2 +-
 net/wireless/nl80211.c                        | 87 +++++++++++++------
 net/wireless/rdev-ops.h                       | 10 +--
 net/wireless/trace.h                          |  2 +-
 8 files changed, 89 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 3d6e5aad48b1..7d04594e974f 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2012-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/etherdevice.h>
@@ -2325,7 +2326,7 @@ static void wil_probe_client_handle(struct wil6210_priv *wil,
 	 */
 	bool alive = (sta->status == wil_sta_connected);
 
-	cfg80211_probe_status(ndev, sta->addr, req->cookie, alive,
+	cfg80211_probe_status(ndev, sta->addr, req->cookie, -1, alive,
 			      0, false, GFP_KERNEL);
 }
 
@@ -2378,9 +2379,9 @@ void wil_probe_client_flush(struct wil6210_vif *vif)
 	mutex_unlock(&vif->probe_client_mutex);
 }
 
-static int wil_cfg80211_probe_client(struct wiphy *wiphy,
-				     struct net_device *dev,
-				     const u8 *peer, u64 *cookie)
+static int wil_cfg80211_probe_peer(struct wiphy *wiphy,
+				   struct net_device *dev,
+				   const u8 *peer, u64 *cookie)
 {
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
 	struct wil6210_vif *vif = ndev_to_vif(dev);
@@ -2659,7 +2660,7 @@ static const struct cfg80211_ops wil_cfg80211_ops = {
 	.add_station = wil_cfg80211_add_station,
 	.del_station = wil_cfg80211_del_station,
 	.change_station = wil_cfg80211_change_station,
-	.probe_client = wil_cfg80211_probe_client,
+	.probe_peer = wil_cfg80211_probe_peer,
 	.change_bss = wil_cfg80211_change_bss,
 	/* P2P device */
 	.start_p2p_device = wil_cfg80211_start_p2p_device,
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index c9a651bdf882..dae10236f460 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4557,9 +4557,9 @@ mwifiex_cfg80211_disassociate(struct wiphy *wiphy,
 }
 
 static int
-mwifiex_cfg80211_probe_client(struct wiphy *wiphy,
-			      struct net_device *dev, const u8 *peer,
-			      u64 *cookie)
+mwifiex_cfg80211_probe_peer(struct wiphy *wiphy,
+			    struct net_device *dev, const u8 *peer,
+			    u64 *cookie)
 {
 	/* hostapd looks for NL80211_CMD_PROBE_CLIENT support; otherwise,
 	 * it requires monitor-mode support (which mwifiex doesn't support).
@@ -4725,7 +4725,7 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 		ops->disassoc = mwifiex_cfg80211_disassociate;
 		ops->disconnect = NULL;
 		ops->connect = NULL;
-		ops->probe_client = mwifiex_cfg80211_probe_client;
+		ops->probe_peer = mwifiex_cfg80211_probe_peer;
 	}
 	wiphy->max_scan_ssids = MWIFIEX_MAX_SSID_LIST_LENGTH;
 	wiphy->max_scan_ie_len = MWIFIEX_MAX_VSIE_LEN;
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9d3639ff9c28..6675c6021fa5 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4921,8 +4921,8 @@ struct mgmt_frame_regs {
  * @tdls_mgmt: Transmit a TDLS management frame.
  * @tdls_oper: Perform a high-level TDLS operation (e.g. TDLS link setup).
  *
- * @probe_client: probe an associated client, must return a cookie that it
- *	later passes to cfg80211_probe_status().
+ * @probe_peer: probe a connected peer (AP: STA MAC required; STA: no MAC),
+ *	must return a cookie that is later passed to cfg80211_probe_status().
  *
  * @set_noack_map: Set the NoAck Map for the TIDs.
  *
@@ -5320,8 +5320,8 @@ struct cfg80211_ops {
 	int	(*tdls_oper)(struct wiphy *wiphy, struct net_device *dev,
 			     const u8 *peer, enum nl80211_tdls_operation oper);
 
-	int	(*probe_client)(struct wiphy *wiphy, struct net_device *dev,
-				const u8 *peer, u64 *cookie);
+	int	(*probe_peer)(struct wiphy *wiphy, struct net_device *dev,
+			      const u8 *peer, u64 *cookie);
 
 	int	(*set_noack_map)(struct wiphy *wiphy,
 				  struct net_device *dev,
@@ -9602,15 +9602,17 @@ bool cfg80211_rx_unexpected_4addr_frame(struct net_device *dev, const u8 *addr,
 /**
  * cfg80211_probe_status - notify userspace about probe status
  * @dev: the device the probe was sent on
- * @addr: the address of the peer
+ * @peer: The peer MAC address (or MLD address for MLO) or %NULL if not
+ * applicable (e.g. for STA/P2P-client)
  * @cookie: the cookie filled in @probe_client previously
+ * @link_id: The link ID on which the probe was sent (or -1 for non-MLO)
  * @acked: indicates whether probe was acked or not
  * @ack_signal: signal strength (in dBm) of the ACK frame.
  * @is_valid_ack_signal: indicates the ack_signal is valid or not.
  * @gfp: allocation flags
  */
-void cfg80211_probe_status(struct net_device *dev, const u8 *addr,
-			   u64 cookie, bool acked, s32 ack_signal,
+void cfg80211_probe_status(struct net_device *dev, const u8 *peer, u64 cookie,
+			   int link_id, bool acked, s32 ack_signal,
 			   bool is_valid_ack_signal, gfp_t gfp);
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 7b77d57c9f96..abd0ac20f0da 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4746,8 +4746,8 @@ static int ieee80211_set_rekey_data(struct wiphy *wiphy,
 	return 0;
 }
 
-static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
-				  const u8 *peer, u64 *cookie)
+static int ieee80211_probe_peer(struct wiphy *wiphy, struct net_device *dev,
+				const u8 *peer, u64 *cookie)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
@@ -5835,7 +5835,7 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.tdls_mgmt = ieee80211_tdls_mgmt,
 	.tdls_channel_switch = ieee80211_tdls_channel_switch,
 	.tdls_cancel_channel_switch = ieee80211_tdls_cancel_channel_switch,
-	.probe_client = ieee80211_probe_client,
+	.probe_peer = ieee80211_probe_peer,
 	.set_noack_map = ieee80211_set_noack_map,
 #ifdef CONFIG_PM
 	.set_wakeup = ieee80211_set_wakeup,
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 4b38aa0e902a..4a64ac6d1451 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -654,7 +654,7 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
 								GFP_ATOMIC);
 			else if (ieee80211_is_any_nullfunc(hdr->frame_control))
 				cfg80211_probe_status(sdata->dev, hdr->addr1,
-						      cookie, acked,
+						      cookie, -1, acked,
 						      info->status.ack_signal,
 						      is_valid_ack_signal,
 						      GFP_ATOMIC);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e7be43f023b6..a7623200d9cb 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2400,7 +2400,7 @@ static int nl80211_add_commands_unsplit(struct cfg80211_registered_device *rdev,
 	}
 	if (rdev->wiphy.max_sched_scan_reqs)
 		CMD(sched_scan_start, START_SCHED_SCAN);
-	CMD(probe_client, PROBE_CLIENT);
+	CMD(probe_peer, PROBE_PEER);
 	CMD(set_noack_map, SET_NOACK_MAP);
 	if (rdev->wiphy.flags & WIPHY_FLAG_REPORTS_OBSS) {
 		i++;
@@ -15790,26 +15790,44 @@ static int nl80211_register_unexpected_frame(struct sk_buff *skb,
 	return 0;
 }
 
-static int nl80211_probe_client(struct sk_buff *skb,
-				struct genl_info *info)
+static int nl80211_probe_peer(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct sk_buff *msg;
 	void *hdr;
-	const u8 *addr;
+	const u8 *addr = NULL;
 	u64 cookie;
 	int err;
 
-	if (wdev->iftype != NL80211_IFTYPE_AP &&
-	    wdev->iftype != NL80211_IFTYPE_P2P_GO)
-		return -EOPNOTSUPP;
+	/* Allow in AP, STA, and their P2P counterparts (and MLO) */
+	switch (wdev->iftype) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+		if (!info->attrs[NL80211_ATTR_MAC])
+			return -EINVAL;
 
-	if (!info->attrs[NL80211_ATTR_MAC])
-		return -EINVAL;
+		addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
+		break;
+	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_P2P_CLIENT:
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_PROBE_AP))
+			return -EOPNOTSUPP;
 
-	if (!rdev->ops->probe_client)
+		if (!wdev->connected)
+			return -ENOLINK;
+
+		/* STA/P2P-client probes the currently associated AP/GO. */
+		if (info->attrs[NL80211_ATTR_MAC])
+			return -EINVAL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (!rdev->ops->probe_peer)
 		return -EOPNOTSUPP;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
@@ -15823,9 +15841,8 @@ static int nl80211_probe_client(struct sk_buff *skb,
 		goto free_msg;
 	}
 
-	addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
 
-	err = rdev_probe_client(rdev, dev, addr, &cookie);
+	err = rdev_probe_peer(rdev, dev, addr, &cookie);
 	if (err)
 		goto free_msg;
 
@@ -19629,7 +19646,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 	{
 		.cmd = NL80211_CMD_PROBE_PEER,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = nl80211_probe_client,
+		.doit = nl80211_probe_peer,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
@@ -22165,8 +22182,8 @@ void cfg80211_sta_opmode_change_notify(struct net_device *dev, const u8 *mac,
 }
 EXPORT_SYMBOL(cfg80211_sta_opmode_change_notify);
 
-void cfg80211_probe_status(struct net_device *dev, const u8 *addr,
-			   u64 cookie, bool acked, s32 ack_signal,
+void cfg80211_probe_status(struct net_device *dev, const u8 *peer, u64 cookie,
+			   int link_id, bool acked, s32 ack_signal,
 			   bool is_valid_ack_signal, gfp_t gfp)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
@@ -22174,31 +22191,47 @@ void cfg80211_probe_status(struct net_device *dev, const u8 *addr,
 	struct sk_buff *msg;
 	void *hdr;
 
-	trace_cfg80211_probe_status(dev, addr, cookie, acked);
+	trace_cfg80211_probe_status(dev, peer, cookie, acked);
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	switch (wdev->iftype) {
+	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_P2P_CLIENT:
+		if (WARN_ON(peer))
+			return;
+		break;
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+		if (WARN_ON(!peer))
+			return;
+		break;
+	default:
+		break;
+	}
 
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
 	if (!msg)
 		return;
 
 	hdr = nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_PROBE_PEER);
-	if (!hdr) {
-		nlmsg_free(msg);
-		return;
-	}
+	if (!hdr)
+		goto nla_put_failure;
 
 	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
 	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex) ||
-	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, addr) ||
+	    (peer && nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, peer)) ||
 	    nla_put_u64_64bit(msg, NL80211_ATTR_COOKIE, cookie,
-			      NL80211_ATTR_PAD) ||
-	    (acked && nla_put_flag(msg, NL80211_ATTR_ACK)) ||
-	    (is_valid_ack_signal && nla_put_s32(msg, NL80211_ATTR_ACK_SIGNAL,
-						ack_signal)))
+			      NL80211_ATTR_PAD))
 		goto nla_put_failure;
 
-	genlmsg_end(msg, hdr);
+	if (link_id >= 0 &&
+	    nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID, link_id))
+		goto nla_put_failure;
 
+	if ((acked && nla_put_flag(msg, NL80211_ATTR_ACK)) ||
+	    (is_valid_ack_signal &&
+	     nla_put_s32(msg, NL80211_ATTR_ACK_SIGNAL, ack_signal)))
+		goto nla_put_failure;
+	genlmsg_end(msg, hdr);
 	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
 				NL80211_MCGRP_MLME, gfp);
 	return;
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index bba239a068f6..f821411e6721 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -947,13 +947,13 @@ static inline int rdev_tdls_oper(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
-static inline int rdev_probe_client(struct cfg80211_registered_device *rdev,
-				    struct net_device *dev, const u8 *peer,
-				    u64 *cookie)
+static inline int rdev_probe_peer(struct cfg80211_registered_device *rdev,
+				  struct net_device *dev, const u8 *peer,
+				  u64 *cookie)
 {
 	int ret;
-	trace_rdev_probe_client(&rdev->wiphy, dev, peer);
-	ret = rdev->ops->probe_client(&rdev->wiphy, dev, peer, cookie);
+	trace_rdev_probe_peer(&rdev->wiphy, dev, peer);
+	ret = rdev->ops->probe_peer(&rdev->wiphy, dev, peer, cookie);
 	trace_rdev_return_int_cookie(&rdev->wiphy, ret, *cookie);
 	return ret;
 }
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index eb5bedf9c92a..9635f53fa358 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2122,7 +2122,7 @@ DECLARE_EVENT_CLASS(rdev_pmksa,
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->bssid)
 );
 
-TRACE_EVENT(rdev_probe_client,
+TRACE_EVENT(rdev_probe_peer,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
 		 const u8 *peer),
 	TP_ARGS(wiphy, netdev, peer),
-- 
2.34.1


