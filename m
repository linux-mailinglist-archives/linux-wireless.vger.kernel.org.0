Return-Path: <linux-wireless+bounces-36797-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGS5OEQqEGpQUQYAu9opvQ
	(envelope-from <linux-wireless+bounces-36797-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 12:04:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 776A15B1A58
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 12:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D08C306B579
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 10:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666993C6A38;
	Fri, 22 May 2026 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jqjpioQF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WMosYht3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC1B357D05
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444078; cv=none; b=bSswHvzO+PmvBsOS1I6J404lJ3g9VRow+/OBZPu5nuAJC/uDW9qOfnepjqKpwVh21GtpM6xIgjOEc3YhMIcx29O5IypfaVeWSP0L1sgf853VDAo9cv+As1Dxo5MW0LgVUDilrYr3YwNhgR27jmm9oyVutCR4QT1wrlzFibviMoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444078; c=relaxed/simple;
	bh=y3Md+/LJdRoPfa8fSBTst//7iA3QrqSh3tsJRClRwKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fnOLxVS9vhXxo0eeuVBFudCtx0b0cEvQml633kFu/W0VzMngMiM7C/3N3Ak5yaA4UEOI9HTcMloD3mXI+u3aW172DdXedrgAu95rHWYOHNin4kaF7tAhSTYh22HBMINcMBt/28ZAfKM3Jsa2b9r2lxHqk1aSGcT7cJdQ88FD47k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jqjpioQF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WMosYht3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M7ULNt778735
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 10:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	89GZyqjxzP4kzPz+TzUkPQL4cVAEH+s+D1a55Or7dm0=; b=jqjpioQFFAri1m2v
	HbJL84xCVFhlIq0d2UiQ47xNCEwDEpYfl4QL2066E9UNWXygtvKtJX6KVopUig/B
	DNCs1cdIbKI7+ComLVYO15cK90mYoNtvznOcMR7Pw8RmqruWrK/FwqkO21zVgCBK
	BGtMJPVA+o5ViB3j7kd4mCSt1nju/CF1aR0HxDv8B2oJFbuE0NkFGMdP0EDG41PL
	2EARo6n8CCNkcRm9atfIEi0uo7M3xl0W6uCWvjaXHbMUrrZvkd43nV+sABOxFnxR
	QFVHmfwgpIAYWljVCxKScvyUUXS3b4Wc3qsYtvf0yKf+zVnB4cPFQ+LMUzoQGMTs
	inJCFg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eac7at5uf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 10:01:15 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82fa366fb79so9513855b3a.2
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779444075; x=1780048875; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89GZyqjxzP4kzPz+TzUkPQL4cVAEH+s+D1a55Or7dm0=;
        b=WMosYht3MVMArPKL0lwi1xACPiyEN2Ockb3Yf2/a/yzCha+jqneKvO1Tfsx8pYHWjE
         PvCO+WHPT5p3cwPbfeN8MvemJBKQFrfYkQaaIARbL586NayjWQ2sGct1tcR+Q9e2BnSr
         3XIwKvInmRRBqelq74pEvIOPtZrFdUnR3PNaSWjB7r2J0Pel3rN4lyxxPeXDia4Z1sgQ
         i74eg3J2DYQmvBKDzpmbpJK1OE8dUB5hX2yqK6WkCyqqZnwOr/yIAxQv+lP+VA75agyw
         Pxja88xcWsUXsPPHeqhSSP+fOqXhMqNkx/9gyqVxHbtSvRJCXoQPbZ0OZ87vVCZCv06A
         8YLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779444075; x=1780048875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=89GZyqjxzP4kzPz+TzUkPQL4cVAEH+s+D1a55Or7dm0=;
        b=bJJWNOmw1CqUJtCK3x+ECZkD35ZePJX8fDAeqR+SQ+f2XLA012V75wyHHXc/6ZS2et
         ZMtYvCJs2eLBpou6uhGNxQ9/bYy99ajFos/K3mR9w/JSgFcXRUiNCiZHJ6NXxWEu88rv
         SMjTrZmTyLToT0jO6fJ/xq6ia9Y4hBRGxzlgceYg+f9t4TS98y01z+yYj5NcDSo6oNdq
         2nuvNcL7vCBWA42YgwA/K6wqh83A8X2Z9ZE3KWZqCQdUR/WC7pm5JqK4wACiS2+FBYKR
         v5LPy4frNZUCLht39t00QADmaaudYzmtfRKCpCHGqAMZHZzj5fZgLvFVKSue4M9k21vE
         R90w==
X-Forwarded-Encrypted: i=1; AFNElJ92J/NoF6KHmnREjiFvuNCXpWrz0jyjZC3MrXwI9ZuWXb3mGvYMCSZSmyVbLr1D0akVRujsnfFlVZPXMdZi/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvNBIMpt/BgcP/PHxDkCh4cQz41Jv5R1Hdq/hesDpRhIXUwtBD
	oUwFMG/pFVaFVzdZRYttndl0W66LLBg1TYn4wOLvMcqAk8imn/uALls+mlMf65TU+/iHW5tE/FA
	BXitmkTDtiFTJHmFezB6au+jD2sQ42uIS1JjGBF/V2TLw+mJvwXXzowjxIHWuoJRQWdCqgQ==
X-Gm-Gg: Acq92OF78j/8LH6/GNCzeIGesGE+uviIkCraURBowkl5IAX/GptJ31JAa015Oz1U8Kq
	NmZqOK6cer23R8JCzPEcwHVR9PUuM23TtXINZcpBAJ3T5X6inZB56XWq4lXBuI5zzdHRa4mpPx8
	9KCMSyC00PxINBWDJBZriiL90EixtOxG+1jzScol05GZ/dj77ZxlDiIZd8DE6qO+Tjv63qGKiSM
	AV3+e3Sgoh+h5xywnhIReFMf3nAesSc6kKw8p2ykBQSNDn+RfoRblvRYExAVgutR9z548yi8rAc
	7ywKsG1oeSS0F3qKOK5/1FkdRMCSU4z+I6YqPK/dvSjyLL4IMhNpN970oIqQFDWfiNCsDgWWzas
	1v50lULMnVsNoi6vIo5IngpaibVN64o46t1wy48a2nC2wiwVT3d8md8dG
X-Received: by 2002:a05:6a00:1807:b0:81f:31c3:2e34 with SMTP id d2e1a72fcca58-8415f330494mr3326893b3a.25.1779444074807;
        Fri, 22 May 2026 03:01:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:1807:b0:81f:31c3:2e34 with SMTP id d2e1a72fcca58-8415f330494mr3326808b3a.25.1779444074141;
        Fri, 22 May 2026 03:01:14 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9b74sm1516641b3a.3.2026.05.22.03.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:01:13 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:30:34 +0530
Subject: [PATCH v2 3/6] net: mhi_net: Hold runtime PM during active data
 path operations
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-mhi_runtimepm-v2-3-fbebf41a82bb@oss.qualcomm.com>
References: <20260522-mhi_runtimepm-v2-0-fbebf41a82bb@oss.qualcomm.com>
In-Reply-To: <20260522-mhi_runtimepm-v2-0-fbebf41a82bb@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, netdev@vger.kernel.org,
        mayank.rana@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        vivek.pernamitta@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779444039; l=4173;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=y3Md+/LJdRoPfa8fSBTst//7iA3QrqSh3tsJRClRwKA=;
 b=s+sHbgZoUcbrkhk1NuhJt9uKCZYJuw6T6gtb1ZC0H9M7hSgDCA1Etn58jrZgjHnvT0SCRG62Q
 V7oqxMJp/lHBjYl/lZQf2obhPMwRXspe8hoAXlE3MFihEsy0yCkGb4V
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: xcaKwK6wNszWuXUGgMD8sm58QYPU0y8o
X-Authority-Analysis: v=2.4 cv=JrbBas4C c=1 sm=1 tr=0 ts=6a10296b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=-cKO2LIWXEwUer3o84gA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: xcaKwK6wNszWuXUGgMD8sm58QYPU0y8o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5OSBTYWx0ZWRfX0m0WeyPsed+A
 FNQEsR1FkvtrYDaItmriPXzLieonuD5nQsrwO5H2BB4bsNsxddG6+S/V3SrmeBJ8ZV7e9BUM9a5
 slqqKjGYtfW7Sx6RYnE43W/JH2SGoEQna2SK9QxgVxtN5YdkabHcMb+vTs/F3hcejTv7Cg0FACu
 K8JQuwhWUdcAFcveXz1sZYww7rXR2TnNgVPU+SyI/NYcPPqQX2XDIuLLDGO2k0e+wwh+zYpywuh
 fSLKMekzKpgiHX+2x1HAYnry3H6zAQPBOfgYVclkPbsW9zHj3VvWkAudL2XSjwkoTpxwTQjm8hb
 DR8X/LoWe4KTOtNIK+ajB9HfG4xHaXWX/nDDjyipx4UZ9ij435+/NVn6Hf9bQMVT4eFpHgF6xC1
 hcjntlyXyknt+C0+U6QEYEZ6rRfReU3R7DJh64MVI1lM2MRgouVoAj3Ee3NivTgDGWNhxmuAQnt
 zI5oFvu2M2pMEcaswgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220099
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36797-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[kernel.org,oss.qualcomm.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,sipsolutions.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishna.chundru@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 776A15B1A58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The mhi_net driver does not coordinate with runtime PM, which allows the
underlying MHI controller to be runtime-suspended while transmit, receive,
or RX buffer refill operations are in progress. This can lead to stalled
transfers or failed queueing once runtime PM is enabled in the MHI core.

Add runtime PM reference counting to the mhi_net data path to keep the
controller active for the duration of TX, RX, and buffer management
operations. Enable runtime PM during probe and take/release references
explicitly around these critical paths.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/net/mhi_net.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
index ae169929a9d8..5d7f9ccdb17b 100644
--- a/drivers/net/mhi_net.c
+++ b/drivers/net/mhi_net.c
@@ -9,6 +9,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/pm_runtime.h>
 #include <linux/skbuff.h>
 #include <linux/u64_stats_sync.h>
 
@@ -76,11 +77,19 @@ static netdev_tx_t mhi_ndo_xmit(struct sk_buff *skb, struct net_device *ndev)
 	struct mhi_device *mdev = mhi_netdev->mdev;
 	int err;
 
+	err = pm_runtime_get(&mdev->dev);
+	if (err < 0 && err != -EINPROGRESS) {
+		dev_err(&mdev->dev, "pm_runtime_get failed %d\n", err);
+		pm_runtime_put_noidle(&mdev->dev);
+		goto exit_drop;
+	}
+
 	err = mhi_queue_skb(mdev, DMA_TO_DEVICE, skb, skb->len, MHI_EOT);
 	if (unlikely(err)) {
 		net_err_ratelimited("%s: Failed to queue TX buf (%d)\n",
 				    ndev->name, err);
 		dev_kfree_skb_any(skb);
+		pm_runtime_put(&mdev->dev);
 		goto exit_drop;
 	}
 
@@ -251,6 +260,7 @@ static void mhi_net_ul_callback(struct mhi_device *mhi_dev,
 		/* MHI layer stopping/resetting the UL channel */
 		if (mhi_res->transaction_status == -ENOTCONN) {
 			u64_stats_update_end(&mhi_netdev->stats.tx_syncp);
+			pm_runtime_put(&mdev->dev);
 			return;
 		}
 
@@ -261,6 +271,7 @@ static void mhi_net_ul_callback(struct mhi_device *mhi_dev,
 	}
 	u64_stats_update_end(&mhi_netdev->stats.tx_syncp);
 
+	pm_runtime_put(&mdev->dev);
 	if (netif_queue_stopped(ndev) && !mhi_queue_is_full(mdev, DMA_TO_DEVICE))
 		netif_wake_queue(ndev);
 }
@@ -277,6 +288,12 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
 
 	size = mhi_netdev->mru ? mhi_netdev->mru : READ_ONCE(ndev->mtu);
 
+	err = pm_runtime_resume_and_get(&mdev->dev);
+	if (err) {
+		dev_err(&mdev->dev, "pm_runtime_resume_and_get failed %d\n", err);
+		return;
+	}
+
 	while (!mhi_queue_is_full(mdev, DMA_FROM_DEVICE)) {
 		skb = netdev_alloc_skb(ndev, size);
 		if (unlikely(!skb))
@@ -296,6 +313,7 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
 		cond_resched();
 	}
 
+	pm_runtime_put(&mdev->dev);
 	/* If we're still starved of rx buffers, reschedule later */
 	if (mhi_get_free_desc_count(mdev, DMA_FROM_DEVICE) == mhi_netdev->rx_queue_sz)
 		schedule_delayed_work(&mhi_netdev->rx_refill, HZ / 2);
@@ -362,20 +380,41 @@ static int mhi_net_probe(struct mhi_device *mhi_dev,
 
 	SET_NETDEV_DEV(ndev, &mhi_dev->dev);
 
+	pm_runtime_no_callbacks(&mhi_dev->dev);
+	err = devm_pm_runtime_set_active_enabled(&mhi_dev->dev);
+	if (err)
+		return err;
+
+	err = pm_runtime_resume_and_get(&mhi_dev->dev);
+	if (err) {
+		dev_err(&mhi_dev->dev, "pm_runtime_resume_and_get failed %d\n", err);
+		return err;
+	}
+
 	err = mhi_net_newlink(mhi_dev, ndev);
 	if (err) {
 		free_netdev(ndev);
+		pm_runtime_put(&mhi_dev->dev);
 		return err;
 	}
 
+	pm_runtime_put(&mhi_dev->dev);
 	return 0;
 }
 
 static void mhi_net_remove(struct mhi_device *mhi_dev)
 {
 	struct mhi_net_dev *mhi_netdev = dev_get_drvdata(&mhi_dev->dev);
+	int err;
+
+	err = pm_runtime_resume_and_get(&mhi_dev->dev);
+	if (err)
+		dev_err(&mhi_dev->dev, "pm_runtime_resume_and_get failed %d\n", err);
 
 	mhi_net_dellink(mhi_dev, mhi_netdev->ndev);
+
+	if (!err)
+		pm_runtime_put(&mhi_dev->dev);
 }
 
 static const struct mhi_device_info mhi_hwip0 = {

-- 
2.34.1


