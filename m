Return-Path: <linux-wireless+bounces-29446-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4830CC9764C
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Dec 2025 13:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 343DC4E3C8C
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Dec 2025 12:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492C43101B0;
	Mon,  1 Dec 2025 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gv12s/IH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RFBlkD0V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE0D31ED7C
	for <linux-wireless@vger.kernel.org>; Mon,  1 Dec 2025 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764593034; cv=none; b=At5XQmdQGkTEGDmCX4zi7aXAPr6gO2Ir0xd/HgUtcu9jaRwpeCDpce9JVhyDsqNLWLrpNQcRnyxHqnuHFRJ6hxh/OtW7JwjdbCp7D+GPtIk9G2EJOO6Ecns8PhOkdUZX6I0igPQWhrTjP4F8cfb3fHNKQDi/m+BFgkNjb8xBa7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764593034; c=relaxed/simple;
	bh=GH482HQseJW7R4QoliiIACcw54hmP3LITJI8fgJuTts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rHmg2QNVd4+Dv+JLO91+AvWFs05EZOmVTyr+6qXiM3V04hSUWWgl+g6GL7+RUCE6mmOBAXlZTnDXrTOmn7bjUNTyJjQUjIturmHNj0PZia1njElDf+rQLzHtN4WhVt0OgUn5sYAtEvhIJZJ9Dea4zQKQLTlv4OHo3tzpaCWJBAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gv12s/IH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RFBlkD0V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B19MEHW3362428
	for <linux-wireless@vger.kernel.org>; Mon, 1 Dec 2025 12:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g3eWAp1Uztlnh+JGWFxdF/vF9gNgmc6EwOi5LM6HCKM=; b=Gv12s/IHP5hSlfis
	zkDXZpDoYamcMTEOyJ1p0r9bM8Y/Puj1Ba5v1QbW66gJM65C5DN6JbercA1y2ldq
	L+G6uEw/hBvpwRCn5FIlG4qwn9yhQ+Gv95ANFSAAv6zTVyHy193kJ3zh7Lt9hv3N
	+j2iUG1JQpkggG+Grfn/zCN1oLMPTuOI5RTe1UxdRd57RaRxkOT6QfGGMBOJaffb
	kaC284BGLOz+3TgYmBwWjvRIskHXXTkI7/qCdvCYvN/zr7yruadYlpX0bgnir+KF
	AVy5Z5waXZt0KH2Ziw7eTTTKWxlHQkQ3iaaIAJ8iGkFBDVX7ywTeTE5NqJyJTQAR
	L5PYBQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4as8b00j9p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Dec 2025 12:43:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-340c0604e3dso4298430a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 01 Dec 2025 04:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764593031; x=1765197831; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g3eWAp1Uztlnh+JGWFxdF/vF9gNgmc6EwOi5LM6HCKM=;
        b=RFBlkD0V2TDmgh+NIgAzFMqCVo5YGFkGU52x7CELdO3LfozUcGRalX6s29b/kWw00K
         9fMCGJ5SU7WS+ZmJ/o7gDEMe863pAun14XkHEkB8Zpv+e+qbkC1VlW0nVKRmHYgAMIMK
         Q8AzvRaQvVMs56kcW0rIinnMF/a1tp/6/M3esGtry0X6ZHxlTa6b/StzGKFKJU9vFn3o
         aGgzvgsgnp+HeDUgP/wakE8Myws9K2YF49fsT4V2cZWzn2xqcM7i0EdahlVOcX7cJnb8
         abiYW/lPByIru1JxMMm8HN22JQj5ET+ywWQNHwkiPmMwRkjypwwDviUIuInp0ulxUdRi
         dOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764593031; x=1765197831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g3eWAp1Uztlnh+JGWFxdF/vF9gNgmc6EwOi5LM6HCKM=;
        b=CFloXp52im2xicNCIv0uO3Pty/yOwh8JgaVbmcUANopSRm9t2z0HBauAwTpCOp5Ct/
         BdJv72MRY3YqZOc0iamPKO5TeR95OVV0oUS2rSoZp6mudyo9zAQ7zA828vBc/MGeeZA7
         vgIrLWYIqchTMNqUThKvqtL/Ovkdyi0nTSxwK0C8bjdnlVToIGupqDD1vDkBavXTAbKW
         2CgZwtRihXJnsDQCANfPsxDKQMAAsWdAk5xk5CQrcopyLHh+jTu7k11ddGQyEhPSUxGm
         1uNgNZ6DrrgIquwZHIPJ2G+FNPn5ZLstp2OTNFRuxdG9GQ4HjeUfwyM7z/mK5ptIhkBj
         krDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT1rMT224SV9v535gOgdNPu9+ab7w2gtmPsZUuaZl7KRuik2giaGQDcSo+5LLI6voD1NcNzmOZ+hj61jrQGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAaS+lFTuzvGoUjuFw/BGZyh0VV4ydLK4f3IKUUuasdNBp22dR
	4h2ZcwmbcoaNLhOZoX+nR6Vbw5IPnnXpcSJIMckD+qj1/h+VN/YBAUQssN921LA0xzD1XjTy/rX
	LDcOt6YSX7zDh34pkCRbonx9Myflxl+z0yCEZXuhSLY1AMVsh4AnV8BfO8/BArrsol081Xg==
X-Gm-Gg: ASbGncvQTjMfH9nsfnm3KFmKkjisONZlK+WCqtSh8NMlsZIXSxUn6hxtSFS1a1b3upK
	JZ0fyipHhD9Z+BjhzTqnkj1Y3hOMXdvM0cTBWNar3IKLaspVSPa4UZPuDbZvFA8fNGp/KNVAHXZ
	FEwFAhO+jjGKY8MNvha4K1nmSYkmzs0TAU7tu3MotPbY84zPHT16cJ+XCbvwdLEDY2dxKI/WiZw
	jMlIAq6MV88d6L/H1h0lVi6c+SOaW9g0Po06s353HHxAl9djmGQu3Lz2HZacpTW1GAl/o9S+OVN
	8o9t7cgrplB7RzWXw0QEpL92t4jGMiU8Ks1YnGmHdHUiw9vHjfPl4VUvHxqJ2cs+aP5FV5W0TFC
	+QyzAlRPJLFOYFCQ3T/i9lnc6J5ToYwgUeSF7/aJq/lWt
X-Received: by 2002:a17:90b:4ec7:b0:341:88d5:a74e with SMTP id 98e67ed59e1d1-34733f4ac35mr37194039a91.29.1764593030909;
        Mon, 01 Dec 2025 04:43:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+1AJmch3kW0mA+J5AWIFl5cR6CskMUYu3HyMBvIiPCYmUUTKrD3aXjJSClrHjHz/ZGceKoA==
X-Received: by 2002:a17:90b:4ec7:b0:341:88d5:a74e with SMTP id 98e67ed59e1d1-34733f4ac35mr37194006a91.29.1764593030406;
        Mon, 01 Dec 2025 04:43:50 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3477b733381sm13146374a91.12.2025.12.01.04.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 04:43:50 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 01 Dec 2025 18:13:20 +0530
Subject: [PATCH 4/4] bus: mhi: Fix broken runtime PM design
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-mhi_runtimepm-v1-4-fab94399ca75@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764593001; l=7600;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=GH482HQseJW7R4QoliiIACcw54hmP3LITJI8fgJuTts=;
 b=6iTeiDENHrbVLHbi/ceLO/7iDY2j59zpb8UbDBQqB3y4mszKHxMTOmMfNQCmVJepmbVUaIH3P
 FIGaMVQ5N2wAm3TcemuMJi1WTt4sNs8Uya2mNRCAqG28Z03+njJQ/cu
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=TcKbdBQh c=1 sm=1 tr=0 ts=692d8d87 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=A8rfxp3GyOsx1I41rDQA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: GcSspDOHHF_FL5cw1JbDfNvL_Cj9yPY3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDEwMyBTYWx0ZWRfX7gKHi4zF8QPV
 YsQlFH6SqIJGZjPmJBnfDXMZ6JpnpAwiLjsdHZ9LuLRF/XFXPWdDJwp/kAjlUyEN5SU10OhQ6jU
 1vlgArJFn0mLiF5Eh4WYh2bsFs120hnx36E8QrKOf6i1IfUrPe85wGKBGD/B5ci2FGSImmjFii6
 FF+S/KT3LtNZhwJ4H4mYtaS9U7cT9k+KZGwxk8qJkT+vuS4uS8s5mva9gh+qxFPjrji/0lMtCza
 oZOVeW7E7s8NWq+OIP8v5rPdoMFu9FUoYgNYxtOFbQEDIJGCvMSuYQooZN9H8oz9oEJr/MaH7SR
 oN5DcNtRId9JAcTBY21RHgHP2tNf1m4Wv/wME92XxjpkYEJeENhxuXQ+QN+McrlYXdEesX/yV4a
 cdV/Ov3ih6puwGEdFLDkbbfY340iTw==
X-Proofpoint-GUID: GcSspDOHHF_FL5cw1JbDfNvL_Cj9yPY3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512010103

The current MHI runtime PM design is flawed, as the MHI core attempts to
manage power references internally via mhi_queue() and related paths.
This is problematic because the controller drivers do not have the
knowledge of the client PM status due to the broken PM topology. So when
they runtime suspend the controller, the client drivers could no longer
function.

To address this, in the new design, the client drivers reports their own
runtime PM status now and the PM framework makes sure that the parent
(controller driver) and other components up in the chain remain active.
This leverages the standard parent-child PM relationship.

Since MHI creates a mhi_dev device without an associated driver, we
explicitly enable runtime PM on it and mark it with
pm_runtime_no_callbacks() to indicate the PM core that no callbacks
exist for this device. This is only needed for MHI controller, since
the controller driver uses the bus device just like PCI device.

Also Update the MHI core to explicitly manage runtime PM references in
__mhi_device_get_sync() and mhi_device_put() to ensure the controller
does not enter suspend while a client device is active.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/bus/mhi/host/internal.h |  6 +++---
 drivers/bus/mhi/host/main.c     | 28 ++++------------------------
 drivers/bus/mhi/host/pm.c       | 18 ++++++++----------
 3 files changed, 15 insertions(+), 37 deletions(-)

diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index 61e03298e898e6dd02d2a977cddc4c87b21e3a6c..d6a3168bb3ecc34eab1036c0e74f8d70cf422fed 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -355,9 +355,9 @@ static inline bool mhi_is_active(struct mhi_controller *mhi_cntrl)
 static inline void mhi_trigger_resume(struct mhi_controller *mhi_cntrl)
 {
 	pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
-	pm_runtime_get(mhi_cntrl->cntrl_dev);
-	pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
-	pm_runtime_put(mhi_cntrl->cntrl_dev);
+	pm_runtime_get(&mhi_cntrl->mhi_dev->dev);
+	pm_runtime_mark_last_busy(&mhi_cntrl->mhi_dev->dev);
+	pm_runtime_put(&mhi_cntrl->mhi_dev->dev);
 }
 
 /* Register access methods */
diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 7ac1162a0a81ae11245a2bbd9bf6fd6c0f86fbc1..85a9a5a62a6d3f92b0e9dc35b13fd867db89dd95 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -427,6 +427,8 @@ void mhi_create_devices(struct mhi_controller *mhi_cntrl)
 		if (ret)
 			put_device(&mhi_dev->dev);
 	}
+	pm_runtime_no_callbacks(&mhi_cntrl->mhi_dev->dev);
+	devm_pm_runtime_set_active_enabled(&mhi_cntrl->mhi_dev->dev);
 }
 
 irqreturn_t mhi_irq_handler(int irq_number, void *dev)
@@ -658,12 +660,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 			/* notify client */
 			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
 
-			if (mhi_chan->dir == DMA_TO_DEVICE) {
+			if (mhi_chan->dir == DMA_TO_DEVICE)
 				atomic_dec(&mhi_cntrl->pending_pkts);
-				/* Release the reference got from mhi_queue() */
-				pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
-				pm_runtime_put(mhi_cntrl->cntrl_dev);
-			}
 
 			/*
 			 * Recycle the buffer if buffer is pre-allocated,
@@ -1152,12 +1150,6 @@ static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
 
 	read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
 
-	/* Packet is queued, take a usage ref to exit M3 if necessary
-	 * for host->device buffer, balanced put is done on buffer completion
-	 * for device->host buffer, balanced put is after ringing the DB
-	 */
-	pm_runtime_get(mhi_cntrl->cntrl_dev);
-
 	/* Assert dev_wake (to exit/prevent M1/M2)*/
 	mhi_cntrl->wake_toggle(mhi_cntrl);
 
@@ -1167,11 +1159,6 @@ static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
 	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)))
 		mhi_ring_chan_db(mhi_cntrl, mhi_chan);
 
-	if (dir == DMA_FROM_DEVICE) {
-		pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
-		pm_runtime_put(mhi_cntrl->cntrl_dev);
-	}
-
 	read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
 
 	return ret;
@@ -1377,7 +1364,6 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
 	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
 	if (ret)
 		return ret;
-	pm_runtime_get(mhi_cntrl->cntrl_dev);
 
 	reinit_completion(&mhi_chan->completion);
 	ret = mhi_send_cmd(mhi_cntrl, mhi_chan, cmd);
@@ -1408,8 +1394,6 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
 
 	trace_mhi_channel_command_end(mhi_cntrl, mhi_chan, to_state, TPS("Updated"));
 exit_channel_update:
-	pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
-	pm_runtime_put(mhi_cntrl->cntrl_dev);
 	mhi_device_put(mhi_cntrl->mhi_dev);
 
 	return ret;
@@ -1592,12 +1576,8 @@ static void mhi_reset_data_chan(struct mhi_controller *mhi_cntrl,
 	while (tre_ring->rp != tre_ring->wp) {
 		struct mhi_buf_info *buf_info = buf_ring->rp;
 
-		if (mhi_chan->dir == DMA_TO_DEVICE) {
+		if (mhi_chan->dir == DMA_TO_DEVICE)
 			atomic_dec(&mhi_cntrl->pending_pkts);
-			/* Release the reference got from mhi_queue() */
-			pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
-			pm_runtime_put(mhi_cntrl->cntrl_dev);
-		}
 
 		if (!buf_info->pre_mapped)
 			mhi_cntrl->unmap_single(mhi_cntrl, buf_info);
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index b4ef115189b505c3450ff0949ad2d09f3ed53386..fd690e8af693109ed8c55248db0ea153f9e69423 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -429,6 +429,7 @@ static int mhi_pm_mission_mode_transition(struct mhi_controller *mhi_cntrl)
 
 	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
 		ret = -EIO;
+		read_unlock_bh(&mhi_cntrl->pm_lock);
 		goto error_mission_mode;
 	}
 
@@ -459,11 +460,9 @@ static int mhi_pm_mission_mode_transition(struct mhi_controller *mhi_cntrl)
 	 */
 	mhi_create_devices(mhi_cntrl);
 
-	read_lock_bh(&mhi_cntrl->pm_lock);
 
 error_mission_mode:
-	mhi_cntrl->wake_put(mhi_cntrl, false);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
+	mhi_device_put(mhi_cntrl->mhi_dev);
 
 	return ret;
 }
@@ -1038,9 +1037,11 @@ int __mhi_device_get_sync(struct mhi_controller *mhi_cntrl)
 		read_unlock_bh(&mhi_cntrl->pm_lock);
 		return -EIO;
 	}
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	pm_runtime_get_sync(&mhi_cntrl->mhi_dev->dev);
+	read_lock_bh(&mhi_cntrl->pm_lock);
 	mhi_cntrl->wake_get(mhi_cntrl, true);
-	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
-		mhi_trigger_resume(mhi_cntrl);
 	read_unlock_bh(&mhi_cntrl->pm_lock);
 
 	ret = wait_event_timeout(mhi_cntrl->state_event,
@@ -1049,9 +1050,7 @@ int __mhi_device_get_sync(struct mhi_controller *mhi_cntrl)
 				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
 
 	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
-		read_lock_bh(&mhi_cntrl->pm_lock);
-		mhi_cntrl->wake_put(mhi_cntrl, false);
-		read_unlock_bh(&mhi_cntrl->pm_lock);
+		mhi_device_put(mhi_cntrl->mhi_dev);
 		return -EIO;
 	}
 
@@ -1339,11 +1338,10 @@ void mhi_device_put(struct mhi_device *mhi_dev)
 
 	mhi_dev->dev_wake--;
 	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
-		mhi_trigger_resume(mhi_cntrl);
 
 	mhi_cntrl->wake_put(mhi_cntrl, false);
 	read_unlock_bh(&mhi_cntrl->pm_lock);
+	pm_runtime_put(&mhi_cntrl->mhi_dev->dev);
 }
 EXPORT_SYMBOL_GPL(mhi_device_put);
 

-- 
2.34.1


