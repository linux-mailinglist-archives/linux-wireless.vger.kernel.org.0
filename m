Return-Path: <linux-wireless+bounces-29443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B13C975AB
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Dec 2025 13:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66FDC343FEE
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Dec 2025 12:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BB130FC37;
	Mon,  1 Dec 2025 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jmGcLuQj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bLlraItj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AB230FF3B
	for <linux-wireless@vger.kernel.org>; Mon,  1 Dec 2025 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764593016; cv=none; b=acmsEe2IBaBipGdhy4s1wSdZNYmDvcoCEx9YrLmewn+UjrHkJRTQ/Dl88AwX31PSs6fqHk09gfKKBIq1HrFbt+5AOAyzPL/qLIzItr6RyWAW4l9Ob4HJ7ri79hMpT7kJ98CgeYk6fTJ5erpw5VpcMdR6qoctFRZsVCy6kfbpVaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764593016; c=relaxed/simple;
	bh=O1bfb49f81nWjSwl16Z6OQyKyPquLUwL1wCzDbmKlZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k/Gbyp6mD6MOpprCXhUSliLJ6hZjuz0CE+n9vHr261wzSMf45wpysAy0+hXzGGqHxElBpPjitts3fGHFH7i58kBhKYsA4GNIo7IwpxXRNUXX1Rt6cGS4GoIT+6PEWZN1kwGvhD4tyinmeky88DhsKtMS5VTqYvQKxg5scPpJ5s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jmGcLuQj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bLlraItj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B18Hbae2431617
	for <linux-wireless@vger.kernel.org>; Mon, 1 Dec 2025 12:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YC6FU3llCYxXh4VP04XbK7i9763mHcc9u/o//Iu96T4=; b=jmGcLuQjx1kSOQH8
	znVK1DJ4FY7Ci3owB8HJ6D2/pr8V281Yz1rCRbBrV2Wwk8ACe/Dc0ecc1XTa/yfQ
	qym6y+ByyrSi6k26VkLVYCp5FiHut7QKKR/Gi8xqmnubfwpuX86qUuoaZbhrS6t+
	+qmG6VfiIMvR8cFDX2EN6GSLIut0wO105sE12uxhad+lQKSRQABpBYPb4ZFa0GlT
	C4tFosIk3SsU7ljWUXllkYcKmvpSUd6CXq476tsEg2z0hsY2IjTSYmalJD+VllcX
	EpExd0XSH8AJzeKCvRP07ilxzjB7XGfYlwxcJXvTVLApdMUx2hXnrlDp0fazZyuP
	LCSW0g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4arwnvsywd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Dec 2025 12:43:34 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3416dc5754fso7587416a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Dec 2025 04:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764593013; x=1765197813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YC6FU3llCYxXh4VP04XbK7i9763mHcc9u/o//Iu96T4=;
        b=bLlraItj2P55/yiHytR5LwtMF06M5dAxheMLxJhESbzm1jtJX1wleBt/TqWkOGA0lB
         AFes89kdare6we/B/Bb+z/y6XWH7At1khP+v2xGMm9+K6Yom1eRNaHzSdzWQVu/T+QAm
         HJRdZP3fyK/33QmpN0z23rfnBh5Uakv3QfsuHJBoR1afL3k+c3NA8e1r24u5oOqqnHe/
         SrmocA+0szUwhjqTSZyp0KBGq7eAqgb5xQNc3clHMWKT3gU9kboc0qJABEfosx6YFEZr
         pMNLCSs2NGS+bvcwXdSuTICGVCBT2gfglgQLarAqRZWG4G5689EU4YMYWsWRLd4el3g8
         1dGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764593013; x=1765197813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YC6FU3llCYxXh4VP04XbK7i9763mHcc9u/o//Iu96T4=;
        b=sejFdug179ugD/q963TgUl7yHN7fps5zK90jEW/Y4qQ8Etzw1h+poXzGDLA5qaXWnD
         ln1CNQKbdsQ09cF4mFEeHyHZiRCZza00elyOKIt66bP+OIx6Zoc3A6ihm4LCWmmllIC3
         IuSPaUB9mv+Wpjuf7/YlwmKYCnaKCTEk+sKd/xu5r740Bt641EqR1S6L6bAaOHMctz/4
         uxYOc8AkudnL1THomsW0MpC6Em+3AobJqyJS/VUpRYv70iltTdZk7+y2HsVS5AbCxb0p
         SjDabnp4BiCyCo4+vY20iktPZ+EApSsBMTozYDri60+pOQP3DDZU2QIOzL+KPvEOdJiN
         eqRA==
X-Forwarded-Encrypted: i=1; AJvYcCXMBltHHQal9HKGL521kATHGGuWLgJPO/8SprVOxJ5nMl1qm3bUZamcbfku5g2NLBj8NFOS3iPCD7Ozv0AA+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJRdfumIK1PlR5iyKfYQmY/24SmND1OXr79C+Z2qUciny8vOdv
	Zp3dODsyQh/0O8YsQEAmW/o/67zGxbjqB7m/WOzmR0YCJovX3bdiBhq01iitDJK6Rm3jT3x6jFT
	z3cL3YohIUYlQ6A4trvRS3cMKJAEM8cMLQw2ybjHY/WXxvnHjxuuPzl64NNRSs/sUsWHCnw==
X-Gm-Gg: ASbGnctpV1t8Wj7FQfYWY6OlzxM96GsyualaLzy0XZdRdxAGYsoZAOdbJAZCV2B4mCT
	4mogYLDQZk+jMFoQ8Nl2DPlYNB0od9YTRvTNogYzCfDMVBqOcfuJBblmjfDsPOmVeTyeiFe0A2v
	B2M/kgp2WW+dIwxS03f81TzEx3OgaJ1UzKh5RNIaxboFMNy2B9Y+bMcrfoU2kzqe2BtZW1OorGX
	KGoW2xa6u4UGUKra69nX9wq7w9Z3wzVMSWsPFMmSy2BAGmBhf1emqK7Wz0dXq/xB86BU7KFPWMs
	5wNPmjfHOyjnB9l5jiHCJ/pW3Uz4Afvknn0wJ8Wl1O3zj3FFMJO6MoOLuHeQEB7YU4BCsMtXWVn
	11Q3ObZzYNeUbyKHgDU1atU0qEJgyRzldEcqhp+IK7icG
X-Received: by 2002:a17:90b:57cf:b0:340:5c27:a096 with SMTP id 98e67ed59e1d1-34733e55262mr35348001a91.6.1764593013366;
        Mon, 01 Dec 2025 04:43:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElgDjDJHW2YDf+PAwc9iRI3ntCUsGwfUffpxrfbB3ePkiBM/khpNTD20UCrGFmP3x4X6p7TA==
X-Received: by 2002:a17:90b:57cf:b0:340:5c27:a096 with SMTP id 98e67ed59e1d1-34733e55262mr35347954a91.6.1764593012680;
        Mon, 01 Dec 2025 04:43:32 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3477b733381sm13146374a91.12.2025.12.01.04.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 04:43:32 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 01 Dec 2025 18:13:17 +0530
Subject: [PATCH 1/4] bus: mhi: Replace controller runtime_get/put callbacks
 with direct PM runtime APIs
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-mhi_runtimepm-v1-1-fab94399ca75@oss.qualcomm.com>
References: <20251201-mhi_runtimepm-v1-0-fab94399ca75@oss.qualcomm.com>
In-Reply-To: <20251201-mhi_runtimepm-v1-0-fab94399ca75@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, netdev@vger.kernel.org,
        mayank.rana@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        vivek.pernamitta@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764593001; l=4834;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=O1bfb49f81nWjSwl16Z6OQyKyPquLUwL1wCzDbmKlZQ=;
 b=yLM+3VZeO3i0vzTYNib15uacoRstISgcmAjNZBsE2uImwB5USfI0sbF6aT/yYbSsn9pqrY/4E
 WgFlDNvcU6+DI+bVnaoIPTkVXI/EG9ShgxobuhrFdniiGsg71jFlRYz
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: NSuDOC2YHT42TkVeuriWFJwL36MMZG39
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDEwMyBTYWx0ZWRfXyXZGc5CdnxBw
 7QOWGpjxCYwa85EdXcYnPdGgGpqg1Vuc/P97i8NBrqDcrLNEktq1SeiBHl7ZlxQoX0d2lD6fhbO
 TfEZFUukLGPGIpBI8R7VKpOGQtkgGOPtuKN91/VduAP8wPDO0gT9YTylkD2FslPyCw/XGn/XzL7
 9bKZpgbj410P4mZikYafUwsKWmi4LSkMwyRBY/EpgxOvRpGVAK646x3ubgzAZpD0JhAjTIb/dm8
 9r2aipFYT7CUW9Zu0F7zXaOoKlRYXNME6c5t0TSAhlYyfH2fRNVy6PI1RzdOZGpJBjQW6TdI3D6
 DAZNH3hoHkQjpVF5Uy17C+Xw+ohJ7g2LumSGe+/Q9XSbPrJDC8Zm58UhHOH5hiyWJxrlpfxetnz
 yCFoQ6nlloO4nOqqyWhLd2dl6XZszg==
X-Authority-Analysis: v=2.4 cv=Urxu9uwB c=1 sm=1 tr=0 ts=692d8d76 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=-vyvwYMTLgQEoxk1dJgA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: NSuDOC2YHT42TkVeuriWFJwL36MMZG39
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512010103

Replace usage of runtime_get() and runtime_put() function pointers in
the MHI core with direct calls to the pm_runtime APIs. As the controller
drivers were not doing more than calling the PM runtime APIs in these
callbacks.

This refactoring simplifies the runtime PM handling and removes the need
for drivers to provide no-op or duplicate implementations of these ops.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/bus/mhi/host/init.c     |  1 -
 drivers/bus/mhi/host/internal.h |  7 +++++--
 drivers/bus/mhi/host/main.c     | 19 ++++++++++++-------
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 099be8dd190078af4ca12cd7a1de739572feca9d..5b22808fd543f9febcaa9ea623101d2d5d05b040 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -938,7 +938,6 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 	int ret, i;
 
 	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->regs ||
-	    !mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put ||
 	    !mhi_cntrl->status_cb || !mhi_cntrl->read_reg ||
 	    !mhi_cntrl->write_reg || !mhi_cntrl->nr_irqs ||
 	    !mhi_cntrl->irq || !mhi_cntrl->reg_len)
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index 7937bb1f742ca8033c17a01f5cffbf103330f51f..61e03298e898e6dd02d2a977cddc4c87b21e3a6c 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -7,6 +7,8 @@
 #ifndef _MHI_INT_H
 #define _MHI_INT_H
 
+#include <linux/pm_runtime.h>
+
 #include "../common.h"
 
 extern const struct bus_type mhi_bus_type;
@@ -353,8 +355,9 @@ static inline bool mhi_is_active(struct mhi_controller *mhi_cntrl)
 static inline void mhi_trigger_resume(struct mhi_controller *mhi_cntrl)
 {
 	pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
-	mhi_cntrl->runtime_get(mhi_cntrl);
-	mhi_cntrl->runtime_put(mhi_cntrl);
+	pm_runtime_get(mhi_cntrl->cntrl_dev);
+	pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
+	pm_runtime_put(mhi_cntrl->cntrl_dev);
 }
 
 /* Register access methods */
diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 8615512743199a59a58c3756d9cc3407079cee7e..7ac1162a0a81ae11245a2bbd9bf6fd6c0f86fbc1 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -661,7 +661,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 			if (mhi_chan->dir == DMA_TO_DEVICE) {
 				atomic_dec(&mhi_cntrl->pending_pkts);
 				/* Release the reference got from mhi_queue() */
-				mhi_cntrl->runtime_put(mhi_cntrl);
+				pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
+				pm_runtime_put(mhi_cntrl->cntrl_dev);
 			}
 
 			/*
@@ -1155,7 +1156,7 @@ static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
 	 * for host->device buffer, balanced put is done on buffer completion
 	 * for device->host buffer, balanced put is after ringing the DB
 	 */
-	mhi_cntrl->runtime_get(mhi_cntrl);
+	pm_runtime_get(mhi_cntrl->cntrl_dev);
 
 	/* Assert dev_wake (to exit/prevent M1/M2)*/
 	mhi_cntrl->wake_toggle(mhi_cntrl);
@@ -1166,8 +1167,10 @@ static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
 	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)))
 		mhi_ring_chan_db(mhi_cntrl, mhi_chan);
 
-	if (dir == DMA_FROM_DEVICE)
-		mhi_cntrl->runtime_put(mhi_cntrl);
+	if (dir == DMA_FROM_DEVICE) {
+		pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
+		pm_runtime_put(mhi_cntrl->cntrl_dev);
+	}
 
 	read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
 
@@ -1374,7 +1377,7 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
 	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
 	if (ret)
 		return ret;
-	mhi_cntrl->runtime_get(mhi_cntrl);
+	pm_runtime_get(mhi_cntrl->cntrl_dev);
 
 	reinit_completion(&mhi_chan->completion);
 	ret = mhi_send_cmd(mhi_cntrl, mhi_chan, cmd);
@@ -1405,7 +1408,8 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
 
 	trace_mhi_channel_command_end(mhi_cntrl, mhi_chan, to_state, TPS("Updated"));
 exit_channel_update:
-	mhi_cntrl->runtime_put(mhi_cntrl);
+	pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
+	pm_runtime_put(mhi_cntrl->cntrl_dev);
 	mhi_device_put(mhi_cntrl->mhi_dev);
 
 	return ret;
@@ -1591,7 +1595,8 @@ static void mhi_reset_data_chan(struct mhi_controller *mhi_cntrl,
 		if (mhi_chan->dir == DMA_TO_DEVICE) {
 			atomic_dec(&mhi_cntrl->pending_pkts);
 			/* Release the reference got from mhi_queue() */
-			mhi_cntrl->runtime_put(mhi_cntrl);
+			pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
+			pm_runtime_put(mhi_cntrl->cntrl_dev);
 		}
 
 		if (!buf_info->pre_mapped)

-- 
2.34.1


