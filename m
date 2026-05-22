Return-Path: <linux-wireless+bounces-36799-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOkeE8cqEGo1UgYAu9opvQ
	(envelope-from <linux-wireless+bounces-36799-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 12:07:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B841C5B1AF7
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 12:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 300033014C49
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 10:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C003C8C48;
	Fri, 22 May 2026 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aB4/UNTx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jhtr0b5h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2F93B7B7A
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444096; cv=none; b=tByCRgkFDHjOEMA79txgNIUGp1BSaiB6yraU7TUJPN9o2oaEB/0BFOgQICvuSCiRUarJ5323w7Qf++amTQHrrubhVPUMuufN9EMufs/ctuULk8uQPIvDf8WGXn+PHgrDWqrZuWFrP8N345o42Y+8BNdv43bo1UXEhe030LYChsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444096; c=relaxed/simple;
	bh=vGJb93aYUaQ8jo1tSvCSFnkGptC5OIX1Pw2nFhM0VA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b+gmj6Jw6ZM/in4jmbLG3nFsAun5vYxdI3dV+7SgmqheGvj/Vrd7FW3KdBWp9dG2IQ76HhuZlSfF3/pP3SIuddtluB6YCZdYGW6rkbl4c7bJVGHsyCbtH4siJwHZGjjZHNBGk5IbFnscJWh1m7rlLAfNHnY+wgakA76v0/lWJ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aB4/UNTx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jhtr0b5h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M8oXSQ3532131
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 10:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4bR4ejhF0h4W2ccu0JEwLdaUkh6Z3ndW9f2Ipfo1SaM=; b=aB4/UNTxbpSN1RC/
	1dG3EFP85XnO7MT7R2W4Qs0lipz9XHR4AqH5O/T458jYczzhH9G7qHfvZjAgUgBI
	VvxFvf4a6EKgKH3kzJIOIwANo/pZpIXHy1nU3aLqbcb9+0nQX1kzj/o7raFPvblj
	gcVKLOBnnpwt9+bz2NHLdKvGDNqK/EecVXNA8U8lNbFf6RF9oWMOsYUEbcHiA49x
	etdmiOPpYg4zrKLhqZGR/7ff41oKhdoS3aUXrE7zX5xpQD8I+ztT/YobcKmGa8CO
	PnYbS/AukIu7j4O8tvvolAql4or1OHnTNVsqHw5BpQFqMxuBVzAmhDLM/qfd5hI3
	Vh2QxQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea39gvh1g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 10:01:32 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-83f24cd00f8so3887533b3a.0
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 03:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779444092; x=1780048892; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bR4ejhF0h4W2ccu0JEwLdaUkh6Z3ndW9f2Ipfo1SaM=;
        b=Jhtr0b5hmY6oWkIeP7REkNf3bVgL3939X/slx4sNKyr6rMaeuLSPJK9Tu/TvwOuTOC
         iexjTnvtnnSwv6reyH8+lPDJL4BPc2/jDunhdu3TYS2UmJRVpPXh1/hXUIid4CpAfhat
         koxGLxge3/CiKemonCs+ivrIxYzgNx8wpXgRScjiv5Har2TlD6RozC5ZzCsbMS4doJsv
         LIQTiTrUe/epOyBfHP0JiFV6rcRwK4gumE5UsvAq2tUgCzJ9iam4/TUNOojZ676gHXtL
         Omrr6CydFWtBN8SQ27Yf2X8Fbux8cNQbRCiBU8arrGLUbNw9XZtlf8CWrr4ikDf/+RyN
         RQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779444092; x=1780048892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4bR4ejhF0h4W2ccu0JEwLdaUkh6Z3ndW9f2Ipfo1SaM=;
        b=IqeZRaJzoybZmIokcydO9rXzjii2ztWL1dALfIjd0sHn2R5MoMxIlOLHVK+ezsrcGs
         Al7fhLWcq5dS/X7JwAkpxCqPBhsYw6+eFU9e4tHEjhArgJGZKp16JQ6YXtJY1JBIMRrD
         /xXDVJZ5Lr753AJEjE62iyRoEqntBMMRkV9I4shOWbVrY8moI1w7L62Q3WZrWnmBbNnD
         +f7GQlcQJPwi5Mx/Z1MMmSWuwu8GMHpJ3DAsFQe2m2gfGFBt1y4VTk/EVLow2h+0eo4j
         Wv1qAjbddrdv31jyITd7RhAbH86ug9/qZ31/Af6MBCSfP8MfchqgPLEa8BnaA0lN3AYW
         Kagg==
X-Forwarded-Encrypted: i=1; AFNElJ+OTuO+JL0d37tjMmTrjQo4NFB9XtI3SPgpV4Mo9eM5okeYUxY3rGc9jt1w+6nqtcphXEaoNrME/rhXvFUboA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhXxctKTuZgOQaI7ns5hFZ5zTynd8kvJHUTXDJ8STsS+khlEiJ
	d7+0Cyy+JiWI1BldkimYcNhlMiIP3zRI0YvCPF1MIUlT1zlr12xaUq986L0QXiJH5rCMdkJIo4s
	+KlK2WFa9V6t6SmQwfQGyrTe6YKg1DwzHjv1/7Gb+IussLEriVs/hcFv1r2NtaZOI78iLSQ==
X-Gm-Gg: Acq92OGV0CJkUKgRamC8jOX2NM/frTTtWdHke169vkuqMACBeLOx1eQSTgcu1McSrWu
	t2jkEQpcplYrENWTOz8ExiFnFpVWR0XGoPBiW9t6/XoQflmZ5td3lvhaGSDAZpgwHsVbefgHgun
	AEf0dZ31lPRytO13rHuCEJWrisfGrEOUT2W8VV7oNL+0wolb66m/nAfCnQlK8YYYAC9JMyiFJkr
	rcBmtpbrljIIqI4sLYXxOHDsbTm63kPX6/X5MNQZsyAs6PeXa9/NWpT41rYV7X5h3cGjIUwA0oJ
	o/AWg2uWqYHNdbm7WsKJaJ/bld6NTq8KPRNH7PL5TweVAK2bHBqwBi3GC3rxoDt25Xtr3bcwtlM
	eDNokpeUIz7C/QL/7Tw0aexGM3VWuMPtdyYHKOctFYe9MczycTXbDPY/b
X-Received: by 2002:a05:6a00:1988:b0:824:3bd9:aac6 with SMTP id d2e1a72fcca58-8415f158d1bmr2990103b3a.16.1779444091950;
        Fri, 22 May 2026 03:01:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:1988:b0:824:3bd9:aac6 with SMTP id d2e1a72fcca58-8415f158d1bmr2990025b3a.16.1779444091299;
        Fri, 22 May 2026 03:01:31 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9b74sm1516641b3a.3.2026.05.22.03.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:01:30 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:30:36 +0530
Subject: [PATCH v2 5/6] net: wwan: Hold runtime PM during active data path
 operations
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-mhi_runtimepm-v2-5-fbebf41a82bb@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779444039; l=10149;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=vGJb93aYUaQ8jo1tSvCSFnkGptC5OIX1Pw2nFhM0VA8=;
 b=5HBYYXQJRnjFECEDyTxAMsVcYHphefIrjpOXjPGckvK/1sqC+W9+kiVtG9bbrgpJFZpJ24t7g
 QTVXR1LTohwBnb5K2h0l2+2Ptqd/7bRJefIPqDTarqjhDq3aBiTiykq
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=Yr8/gYYX c=1 sm=1 tr=0 ts=6a10297c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=2zpQ2AhS3inu96TDYMYA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: qLnOIqXoHhiABNHlwb9k3mDniIb1ZOCJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5OSBTYWx0ZWRfXygp5Spsbp7ay
 Q6YePrnI7vRG/8hzW3MeXPuh+LBJylvCXMhZttooD9K+vttZ7TZT3I2XU1PWpQj0J9rx7DYlqOi
 hQVt2NTcytrSXnWodh6api+cbFlZLmrvoGRGa9Uq4QjTpiuTmFi2nGkNOMGnEfYMQEzc/mr/YSq
 eEfmtdossN+Id7s/H/PpZ7jrXz4hUSHu+bBhhJe6WwWTyUPqsYu8HAgwS+SYF6xvIBkDsasybz8
 zLRQkpUqmulsdPxE2moMWxen7JI85x/nV65RVovWVoWANdd/Y4rgbL4gSotS4wGxWQU71RFAtVU
 LXeGJP97OfRkVb1tHQGmwsugSncN1jjwFfbDgtFY7YD1UmaiM06SKSGkZtmnixTk9fVGVIi1uLp
 3sm6wpVV0zaeTshJQ+xazm3O70JSxZcQOEeEO0Mm2n62ZKAscFdXoTk445yrFGi9DtYBPuYmofq
 7jOJR42CTB3BApdH8oA==
X-Proofpoint-GUID: qLnOIqXoHhiABNHlwb9k3mDniIb1ZOCJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220099
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36799-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: B841C5B1AF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The mhi_wwan_ctrl and mhi_wwan_mbim drivers do not coordinate with runtime
PM, which allows the underlying MHI controller to be runtime suspended
while transmit, receive, or RX buffer refill operations are in progress.
This can lead to stalled transfers or failed queueing once runtime PM is
enabled in the MHI core.

Enable runtime PM during probe and take explicit references around TX, RX,
and buffer management operations so the controller remains active for the
duration of each critical path.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/net/wwan/mhi_wwan_ctrl.c | 60 +++++++++++++++++++++++++++++++++++++++-
 drivers/net/wwan/mhi_wwan_mbim.c | 44 ++++++++++++++++++++++++++++-
 2 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
index fa73861db6ad..0fe0f24c0df4 100644
--- a/drivers/net/wwan/mhi_wwan_ctrl.c
+++ b/drivers/net/wwan/mhi_wwan_ctrl.c
@@ -4,6 +4,7 @@
 #include <linux/mhi.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/wwan.h>
 
 /* MHI wwan flags */
@@ -79,6 +80,13 @@ static void mhi_wwan_ctrl_refill_work(struct work_struct *work)
 {
 	struct mhi_wwan_dev *mhiwwan = container_of(work, struct mhi_wwan_dev, rx_refill);
 	struct mhi_device *mhi_dev = mhiwwan->mhi_dev;
+	int err;
+
+	err = pm_runtime_resume_and_get(&mhi_dev->dev);
+	if (err) {
+		dev_err(&mhi_dev->dev, "pm_runtime_resume_and_get failed %d\n", err);
+		return;
+	}
 
 	while (mhi_wwan_rx_budget_dec(mhiwwan)) {
 		struct sk_buff *skb;
@@ -102,17 +110,27 @@ static void mhi_wwan_ctrl_refill_work(struct work_struct *work)
 			break;
 		}
 	}
+	pm_runtime_put(&mhi_dev->dev);
 }
 
 static int mhi_wwan_ctrl_start(struct wwan_port *port)
 {
 	struct mhi_wwan_dev *mhiwwan = wwan_port_get_drvdata(port);
+	struct mhi_device *mhi_dev = mhiwwan->mhi_dev;
 	int ret;
 
+	ret = pm_runtime_resume_and_get(&mhi_dev->dev);
+	if (ret) {
+		dev_err(&mhi_dev->dev, "pm_runtime_resume_and_get failed %d\n", ret);
+		return ret;
+	}
+
 	/* Start mhi device's channel(s) */
 	ret = mhi_prepare_for_transfer(mhiwwan->mhi_dev);
-	if (ret)
+	if (ret) {
+		pm_runtime_put(&mhi_dev->dev);
 		return ret;
+	}
 
 	/* Don't allocate more buffers than MHI channel queue size */
 	mhiwwan->rx_budget = mhi_get_free_desc_count(mhiwwan->mhi_dev, DMA_FROM_DEVICE);
@@ -123,12 +141,15 @@ static int mhi_wwan_ctrl_start(struct wwan_port *port)
 		mhi_wwan_ctrl_refill_work(&mhiwwan->rx_refill);
 	}
 
+	pm_runtime_put(&mhi_dev->dev);
 	return 0;
 }
 
 static void mhi_wwan_ctrl_stop(struct wwan_port *port)
 {
 	struct mhi_wwan_dev *mhiwwan = wwan_port_get_drvdata(port);
+	struct mhi_device *mhi_dev = mhiwwan->mhi_dev;
+	int err;
 
 	spin_lock_bh(&mhiwwan->rx_lock);
 	clear_bit(MHI_WWAN_RX_REFILL, &mhiwwan->flags);
@@ -136,12 +157,20 @@ static void mhi_wwan_ctrl_stop(struct wwan_port *port)
 
 	cancel_work_sync(&mhiwwan->rx_refill);
 
+	err = pm_runtime_resume_and_get(&mhi_dev->dev);
+	if (err)
+		dev_err(&mhi_dev->dev, "pm_runtime_resume_and_get failed %d\n", err);
+
 	mhi_unprepare_from_transfer(mhiwwan->mhi_dev);
+
+	if (!err)
+		pm_runtime_put(&mhi_dev->dev);
 }
 
 static int mhi_wwan_ctrl_tx(struct wwan_port *port, struct sk_buff *skb)
 {
 	struct mhi_wwan_dev *mhiwwan = wwan_port_get_drvdata(port);
+	struct mhi_device *mhi_dev = mhiwwan->mhi_dev;
 	int ret;
 
 	if (skb->len > mhiwwan->mtu)
@@ -150,6 +179,12 @@ static int mhi_wwan_ctrl_tx(struct wwan_port *port, struct sk_buff *skb)
 	if (!test_bit(MHI_WWAN_UL_CAP, &mhiwwan->flags))
 		return -EOPNOTSUPP;
 
+	ret = pm_runtime_resume_and_get(&mhi_dev->dev);
+	if (ret) {
+		dev_err(&mhi_dev->dev, "pm_runtime_resume_and_get failed %d\n", ret);
+		return ret;
+	}
+
 	/* Queue the packet for MHI transfer and check fullness of the queue */
 	spin_lock_bh(&mhiwwan->tx_lock);
 	ret = mhi_queue_skb(mhiwwan->mhi_dev, DMA_TO_DEVICE, skb, skb->len, MHI_EOT);
@@ -157,6 +192,9 @@ static int mhi_wwan_ctrl_tx(struct wwan_port *port, struct sk_buff *skb)
 		wwan_port_txoff(port);
 	spin_unlock_bh(&mhiwwan->tx_lock);
 
+	if (ret)
+		pm_runtime_put(&mhi_dev->dev);
+
 	return ret;
 }
 
@@ -179,6 +217,8 @@ static void mhi_ul_xfer_cb(struct mhi_device *mhi_dev,
 	/* MHI core has done with the buffer, release it */
 	consume_skb(skb);
 
+	pm_runtime_put(&mhi_dev->dev);
+
 	/* There is likely new slot available in the MHI queue, re-allow TX */
 	spin_lock_bh(&mhiwwan->tx_lock);
 	if (!mhi_queue_is_full(mhiwwan->mhi_dev, DMA_TO_DEVICE))
@@ -217,11 +257,26 @@ static int mhi_wwan_ctrl_probe(struct mhi_device *mhi_dev,
 	struct mhi_controller *cntrl = mhi_dev->mhi_cntrl;
 	struct mhi_wwan_dev *mhiwwan;
 	struct wwan_port *port;
+	int err;
 
 	mhiwwan = kzalloc_obj(*mhiwwan);
 	if (!mhiwwan)
 		return -ENOMEM;
 
+	pm_runtime_no_callbacks(&mhi_dev->dev);
+	err = devm_pm_runtime_set_active_enabled(&mhi_dev->dev);
+	if (err) {
+		kfree(mhiwwan);
+		return err;
+	}
+
+	err = pm_runtime_resume_and_get(&mhi_dev->dev);
+	if (err) {
+		dev_err(&mhi_dev->dev, "pm_runtime_resume_and_get failed %d\n", err);
+		kfree(mhiwwan);
+		return err;
+	}
+
 	mhiwwan->mhi_dev = mhi_dev;
 	mhiwwan->mtu = MHI_WWAN_MAX_MTU;
 	INIT_WORK(&mhiwwan->rx_refill, mhi_wwan_ctrl_refill_work);
@@ -240,11 +295,14 @@ static int mhi_wwan_ctrl_probe(struct mhi_device *mhi_dev,
 				&wwan_pops, NULL, mhiwwan);
 	if (IS_ERR(port)) {
 		kfree(mhiwwan);
+		pm_runtime_put(&mhi_dev->dev);
 		return PTR_ERR(port);
 	}
 
 	mhiwwan->wwan_port = port;
 
+	pm_runtime_put(&mhi_dev->dev);
+
 	return 0;
 };
 
diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index 1d7e3ad900c1..56e660ecfcb4 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -20,6 +20,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/pm_runtime.h>
 #include <linux/skbuff.h>
 #include <linux/u64_stats_sync.h>
 #include <linux/usb.h>
@@ -153,9 +154,18 @@ static netdev_tx_t mhi_mbim_ndo_xmit(struct sk_buff *skb, struct net_device *nde
 {
 	struct mhi_mbim_link *link = wwan_netdev_drvpriv(ndev);
 	struct mhi_mbim_context *mbim = link->mbim;
+	struct mhi_device *mhi_dev = mbim->mdev;
 	unsigned long flags;
 	int err = -ENOMEM;
 
+	err = pm_runtime_get(&mhi_dev->dev);
+	if (err < 0 && err != -EINPROGRESS) {
+		dev_err(&mhi_dev->dev, "pm_runtime_get Failed %d\n", err);
+		pm_runtime_put_noidle(&mhi_dev->dev);
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
 	/* Serialize MHI channel queuing and MBIM seq */
 	spin_lock_irqsave(&mbim->tx_lock, flags);
 
@@ -184,6 +194,7 @@ static netdev_tx_t mhi_mbim_ndo_xmit(struct sk_buff *skb, struct net_device *nde
 	return NETDEV_TX_OK;
 
 exit_drop:
+	pm_runtime_put(&mhi_dev->dev);
 	u64_stats_update_begin(&link->tx_syncp);
 	u64_stats_inc(&link->tx_dropped);
 	u64_stats_update_end(&link->tx_syncp);
@@ -396,6 +407,10 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
 	struct mhi_device *mdev = mbim->mdev;
 	int err;
 
+	err = pm_runtime_get(&mdev->dev);
+	if (err < 0 && err != -EINPROGRESS)
+		dev_err(&mdev->dev, "pm_runtime_get Failed %d\n", err);
+
 	while (!mhi_queue_is_full(mdev, DMA_FROM_DEVICE)) {
 		struct sk_buff *skb = alloc_skb(mbim->mru, GFP_KERNEL);
 
@@ -415,6 +430,8 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
 		cond_resched();
 	}
 
+	pm_runtime_put(&mdev->dev);
+
 	/* If we're still starved of rx buffers, reschedule later */
 	if (mhi_get_free_desc_count(mdev, DMA_FROM_DEVICE) == mbim->rx_queue_sz)
 		schedule_delayed_work(&mbim->rx_refill, HZ / 2);
@@ -501,6 +518,7 @@ static void mhi_mbim_ul_callback(struct mhi_device *mhi_dev,
 		/* MHI layer stopping/resetting the UL channel */
 		if (mhi_res->transaction_status == -ENOTCONN) {
 			u64_stats_update_end(&link->tx_syncp);
+			pm_runtime_put(&mhi_dev->dev);
 			return;
 		}
 
@@ -511,6 +529,8 @@ static void mhi_mbim_ul_callback(struct mhi_device *mhi_dev,
 	}
 	u64_stats_update_end(&link->tx_syncp);
 
+	pm_runtime_put(&mhi_dev->dev);
+
 	if (netif_queue_stopped(ndev) && !mhi_queue_is_full(mbim->mdev, DMA_TO_DEVICE))
 		netif_wake_queue(ndev);
 }
@@ -614,6 +634,17 @@ static int mhi_mbim_probe(struct mhi_device *mhi_dev, const struct mhi_device_id
 	if (!mbim)
 		return -ENOMEM;
 
+	pm_runtime_no_callbacks(&mhi_dev->dev);
+	err = devm_pm_runtime_set_active_enabled(&mhi_dev->dev);
+	if (err)
+		return err;
+
+	err = pm_runtime_get(&mhi_dev->dev);
+	if (err < 0 && err != -EINPROGRESS) {
+		dev_err(&mhi_dev->dev, "pm_runtime_get Failed %d\n", err);
+		return err;
+	}
+
 	spin_lock_init(&mbim->tx_lock);
 	dev_set_drvdata(&mhi_dev->dev, mbim);
 	mbim->mdev = mhi_dev;
@@ -623,8 +654,12 @@ static int mhi_mbim_probe(struct mhi_device *mhi_dev, const struct mhi_device_id
 
 	/* Start MHI channels */
 	err = mhi_prepare_for_transfer(mhi_dev);
-	if (err)
+	if (err) {
+		pm_runtime_put(&mhi_dev->dev);
 		return err;
+	}
+
+	pm_runtime_put(&mhi_dev->dev);
 
 	/* Number of transfer descriptors determines size of the queue */
 	mbim->rx_queue_sz = mhi_get_free_desc_count(mhi_dev, DMA_FROM_DEVICE);
@@ -637,12 +672,19 @@ static void mhi_mbim_remove(struct mhi_device *mhi_dev)
 {
 	struct mhi_mbim_context *mbim = dev_get_drvdata(&mhi_dev->dev);
 	struct mhi_controller *cntrl = mhi_dev->mhi_cntrl;
+	int err;
+
+	err = pm_runtime_get(&mhi_dev->dev);
+	if (err < 0 && err != -EINPROGRESS)
+		dev_err(&mhi_dev->dev, "pm_runtime_get Failed %d\n", err);
 
 	mhi_unprepare_from_transfer(mhi_dev);
 	cancel_delayed_work_sync(&mbim->rx_refill);
 	wwan_unregister_ops(&cntrl->mhi_dev->dev);
 	kfree_skb(mbim->skbagg_head);
 	dev_set_drvdata(&mhi_dev->dev, NULL);
+
+	pm_runtime_put(&mhi_dev->dev);
 }
 
 static const struct mhi_device_id mhi_mbim_id_table[] = {

-- 
2.34.1


