Return-Path: <linux-wireless+bounces-29444-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5B4C975F3
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Dec 2025 13:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1796C3A5B28
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Dec 2025 12:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F8531B828;
	Mon,  1 Dec 2025 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I6zc93mW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UisuwfSk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A1D30DD1C
	for <linux-wireless@vger.kernel.org>; Mon,  1 Dec 2025 12:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764593022; cv=none; b=uXLHO1M9NY1zvXV0rH2R6JEfqkLga8vndz28NuyOKJbKxDhpSvP/DqcwiWuehgKA4MutFysMID5AziP55R3HBnaqRCyqXlkb00/3Vu/ny5ZWgAXZ8Frg9UfEEqbTpoKgEueNg82wRqQgbqdsQJxdXB8NQKmJKnJ49WQue0eXBqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764593022; c=relaxed/simple;
	bh=qc/vuexUJiBX8btbCsHgZ8uF0KFcot3K2uoQmn9qVn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qq1m/Kr8PvZzkqcw3XcQa/3jF2G4Y+7CyRVI5I+OfA3YqUbvaZzs2a9j9u10YB6OP56kRcRMQgPkwuQ0rLqSjiRYdcWnnsXJTQDznjz+dlCEFyCS7XnszqiYplkweao+HzGs7S+N6+gXM1bP/mQGHWTCEzhi1qidP9XTgqYtYG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I6zc93mW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UisuwfSk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B16iaDl3689155
	for <linux-wireless@vger.kernel.org>; Mon, 1 Dec 2025 12:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kclx5aUfeE0Z1tsnWaGEfHCQHdHWqYTUl99Q34R7qJQ=; b=I6zc93mWd5fswOHV
	lqDPNAcYqJxYDl8xH7Q/SZTt9MQnpXAiuF4czJAafkqRhn15JD/pX8QinQcqfylq
	waUWqeUAbQuIkf4x+ANpKK/hc0uhdKmmQ1BlDRFNQQhHGjd6HYjU2PWJ1V8Y9GFN
	bKJYS28MZbLvH7aopGPNfi7HlGH+1NWetyFOpzXkIXFg/DyZXCVWQfagsjsv7mwH
	HyjpXpJQHUmSYiHumvOL5OITht3IzNsvp3s1cyfVIL6Kn75rKjWgsZKRTvOSZDhC
	Jt4GbpWZ9bx0SqbtXz2+tU0s4WHCoEG5x4JhPjFGEdQl2DejYObna4JHEMUagKN7
	aVH5cQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4as61411yf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Dec 2025 12:43:40 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-345b4f2a8e8so5826165a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Dec 2025 04:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764593019; x=1765197819; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kclx5aUfeE0Z1tsnWaGEfHCQHdHWqYTUl99Q34R7qJQ=;
        b=UisuwfSk8N39AnRTUauQdPf+hekXHetLx83sZJKs/aQ5KWC1ZizP5yvvck9ErcV23t
         HWOOTws0yKjX9M8fwngWrnvgf1SgB+Yt8DvYdf+JHm5vMXJa4aUEPetEEbGNVDXLJUpI
         k4Xtj7T36JkVYpCKs5sbyIrycZezpkjof+oA6HZ6dbqzImFkbWVJoB0l3yfOjrM2atd7
         d8bjta3eDupbmksX0GwkWHaIvZdApUBN6sKRQb+p2nmVae8cBAMYm5dVqYGMRG8K2sXk
         k9dOUCWDhOOeINxcCMWDZx7nP+KlA7rJzb0A2KiuFPYjoYJ/w0rIM0MRu3N7Z3Ntgc9m
         OTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764593019; x=1765197819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kclx5aUfeE0Z1tsnWaGEfHCQHdHWqYTUl99Q34R7qJQ=;
        b=G/DcGv/cHZosh8as9BkFLev5P1MBMQ8iDSTdc5667scnFyhYQ0RCaYT/Dy/HlZDXOe
         NcFiPw0MxoPR36WNEOBnqGoB0c2oBphyPf2w1IyR6K5iTrMNqdtAk1oZ5+WScpwmGoML
         S3GlnPd0c7Ihi4BDTmAeJGvolIMn0Pe4WT3X5IVoBpnTObNlrRDN3A6jSwloGymsEITP
         HE0SBwukzQamIg9Ov9FQd9IZZt3pVqZV7L91UehbdmMkMhPm0Zka69ISYf9wvsjG9urX
         UwZWjsqB3MXfGWentrr3QK8mvkqNNguU76vGb8qxaBC0ZJAYM6UiHVah6kzc/i3008un
         gqaA==
X-Forwarded-Encrypted: i=1; AJvYcCX/WOOrHXkxq9xoERamckpCJS9QXqvpQfDFJwBRqzM65KIn41JflEcUswW6+MvNI/p5HF5RXn/wsrYsOB2JaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7mk3nh7iSIVE8gAEyPYKUSp3DosXxYU/ZXcIt4U/ZA2AM9TLY
	+ntIRsRFWgRCnNyy5ITAE/JuNOsOdi9Z3eWFbmdGUmKDcml0Pg1wVMWlgeN5u2v82kkgcZlSbQ1
	vpDN92xKFMUBgQA9JsffG0DJF+NTXZ4oW531Fq/zM5mbNCF0ZqKgxkTL3BwRDenrOvSxvdA==
X-Gm-Gg: ASbGnctWd6sKvQ0xmp6RubC6VAJBvUXG6TZ14y9WkrukUSDNqDvyrJGBjIaIzwyf9Xu
	Ap6CDRtaAuKqiSBiJFGNzZp/j4wC9R0pzU8UW6cGMaszmgEYBpLrmCRs8vm7hZg3TjAWC2QKDwZ
	2VZvITe16wQbpVkZbJ2IMqrwl8alaKvpcMi3qyHvLdu3lZg2V20i/fxpEjqE3WOpA6LrdMQ16Ov
	LA0OUuccCRuXEH2QfSIaxAdRV2N/YeZAkSHWM9CTCfMCo824xAvdMh+93Hd8dQpwnpoU8IjFtEU
	pFLWugzOy72jnBEqGqDPCBP4UJmJLVbz1JvJKq4qlzVdUz7qx+yOF3ACYbNOY4O6fli9xvKVxuk
	kkcvKO3cQZQwNu/p61GMH35hyTElmxYoRRJLGDtWR//Yt
X-Received: by 2002:a17:90b:2ecc:b0:32e:a10b:ce33 with SMTP id 98e67ed59e1d1-34733f306dbmr34662152a91.21.1764593019166;
        Mon, 01 Dec 2025 04:43:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpXToaAAMg9liEGygMd9CVV6y8KmXhe059ugemu/KQs6zGoiCMjUmEU//RbcblAKyJubsVfQ==
X-Received: by 2002:a17:90b:2ecc:b0:32e:a10b:ce33 with SMTP id 98e67ed59e1d1-34733f306dbmr34662105a91.21.1764593018601;
        Mon, 01 Dec 2025 04:43:38 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3477b733381sm13146374a91.12.2025.12.01.04.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 04:43:38 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 01 Dec 2025 18:13:18 +0530
Subject: [PATCH 2/4] bus: mhi: Remove runtime PM callback ops from
 controller interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-mhi_runtimepm-v1-2-fab94399ca75@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764593001; l=7478;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=qc/vuexUJiBX8btbCsHgZ8uF0KFcot3K2uoQmn9qVn0=;
 b=6l4fcR7xQsfD87W6Fc04RoQBbA2SzZ/GlJtlqPacx2CneievN+IL0leOfp+hR7nAD5fUmwjYV
 FDDouGZK2jiCqWFWVNFQlM4lAUiXDyceAJMa2CouaPe6wk/Ad2TOcSI
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=J/KnLQnS c=1 sm=1 tr=0 ts=692d8d7c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=UDtOtXLn3dyDcuLNbMIA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: kfAbIsGkbovY0Ak2kDYCwC4VU-oE95k9
X-Proofpoint-ORIG-GUID: kfAbIsGkbovY0Ak2kDYCwC4VU-oE95k9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDEwMyBTYWx0ZWRfXzwZd62QHzWkN
 pP3PL/XqfhuPSpkq1DwUbNksDQHAy4MwVJ+U3gjq93KHkysNZmiV362tDgiYm8Na9EhfuDhIwBE
 Pf9f5m3fXBoH+7kPUWoDGwQQsDg0s2aCpI8cDakzXNAbVpopUGZuiPR/FK/f4ic50QXgW7ZOLX9
 Nf3bavbuiUJxzr0iw9WOJg8xMXFJqM2MDVw8/a2eDJCwqJoYTEJtwdGQhTKErT9y66G3ZDEiSRE
 PYt1DgY2Ej8A2Wt10A8n26gJ0R5hnnJESSdn4eLNcg6KPm81glEzOfE5xek5YWC/ApiQ6WFioJx
 E07gwon4Cg0X+KtbhPrNs/jpipVGUwvTAlpf7VM+1rUjcv0DnMccaQ+W981i8FYgE6/hOPIXATt
 dcxfR7GaRnt20bWbyLENcRlaON5Jlg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512010103

Remove the runtime_get and runtime_put function pointers from the
struct mhi_controller interface and all associated usage across the
MHI host stack. These callbacks were previously required by MHI drivers
to abstract runtime PM handling, but are now redundant.

The MHI core has been updated to directly use standard pm_runtime_*
APIs, eliminating the need for driver-specific indirection.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/accel/qaic/mhi_controller.c   | 11 -----------
 drivers/bus/mhi/host/pci_generic.c    | 24 +++---------------------
 drivers/net/wireless/ath/ath11k/mhi.c | 10 ----------
 drivers/net/wireless/ath/ath12k/mhi.c | 11 -----------
 include/linux/mhi.h                   |  4 ----
 5 files changed, 3 insertions(+), 57 deletions(-)

diff --git a/drivers/accel/qaic/mhi_controller.c b/drivers/accel/qaic/mhi_controller.c
index 13a14c6c61689fa4af47dade6d62b3cb1a148354..319344be658b38656f6e85e92be4b5473f43c897 100644
--- a/drivers/accel/qaic/mhi_controller.c
+++ b/drivers/accel/qaic/mhi_controller.c
@@ -820,15 +820,6 @@ static void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *addr,
 	writel_relaxed(val, addr);
 }
 
-static int mhi_runtime_get(struct mhi_controller *mhi_cntrl)
-{
-	return 0;
-}
-
-static void mhi_runtime_put(struct mhi_controller *mhi_cntrl)
-{
-}
-
 static void mhi_status_cb(struct mhi_controller *mhi_cntrl, enum mhi_callback reason)
 {
 	struct qaic_device *qdev = pci_get_drvdata(to_pci_dev(mhi_cntrl->cntrl_dev));
@@ -889,8 +880,6 @@ struct mhi_controller *qaic_mhi_register_controller(struct pci_dev *pci_dev, voi
 	mhi_cntrl->iova_start = 0;
 	mhi_cntrl->iova_stop = PHYS_ADDR_MAX - 1;
 	mhi_cntrl->status_cb = mhi_status_cb;
-	mhi_cntrl->runtime_get = mhi_runtime_get;
-	mhi_cntrl->runtime_put = mhi_runtime_put;
 	mhi_cntrl->read_reg = mhi_read_reg;
 	mhi_cntrl->write_reg = mhi_write_reg;
 	mhi_cntrl->regs = mhi_bar;
diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index b188bbf7de042d8b9aa0dde1217d2c86558c3caf..7036b1654c550a79e53fb449b944d67b68aad677 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -1173,23 +1173,6 @@ static int mhi_pci_get_irqs(struct mhi_controller *mhi_cntrl,
 	return 0;
 }
 
-static int mhi_pci_runtime_get(struct mhi_controller *mhi_cntrl)
-{
-	/* The runtime_get() MHI callback means:
-	 *    Do whatever is requested to leave M3.
-	 */
-	return pm_runtime_get(mhi_cntrl->cntrl_dev);
-}
-
-static void mhi_pci_runtime_put(struct mhi_controller *mhi_cntrl)
-{
-	/* The runtime_put() MHI callback means:
-	 *    Device can be moved in M3 state.
-	 */
-	pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
-	pm_runtime_put(mhi_cntrl->cntrl_dev);
-}
-
 static void mhi_pci_recovery_work(struct work_struct *work)
 {
 	struct mhi_pci_device *mhi_pdev = container_of(work, struct mhi_pci_device,
@@ -1277,7 +1260,7 @@ static int mhi_pci_generic_edl_trigger(struct mhi_controller *mhi_cntrl)
 	}
 
 	pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
-	mhi_cntrl->runtime_get(mhi_cntrl);
+	pm_runtime_get(mhi_cntrl->cntrl_dev);
 
 	ret = mhi_get_channel_doorbell_offset(mhi_cntrl, &val);
 	if (ret)
@@ -1291,7 +1274,8 @@ static int mhi_pci_generic_edl_trigger(struct mhi_controller *mhi_cntrl)
 	mhi_soc_reset(mhi_cntrl);
 
 err_get_chdb:
-	mhi_cntrl->runtime_put(mhi_cntrl);
+	pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
+	pm_runtime_put(mhi_cntrl->cntrl_dev);
 	mhi_device_put(mhi_cntrl->mhi_dev);
 
 	return ret;
@@ -1338,8 +1322,6 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mhi_cntrl->read_reg = mhi_pci_read_reg;
 	mhi_cntrl->write_reg = mhi_pci_write_reg;
 	mhi_cntrl->status_cb = mhi_pci_status_cb;
-	mhi_cntrl->runtime_get = mhi_pci_runtime_get;
-	mhi_cntrl->runtime_put = mhi_pci_runtime_put;
 	mhi_cntrl->mru = info->mru_default;
 	mhi_cntrl->name = info->name;
 
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index acd76e9392d31192aca6776319ef0829a1c69628..18bac9e4bc35bffabef05171b88bd5515e7df925 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -230,14 +230,6 @@ static int ath11k_mhi_get_msi(struct ath11k_pci *ab_pci)
 	return 0;
 }
 
-static int ath11k_mhi_op_runtime_get(struct mhi_controller *mhi_cntrl)
-{
-	return 0;
-}
-
-static void ath11k_mhi_op_runtime_put(struct mhi_controller *mhi_cntrl)
-{
-}
 
 static char *ath11k_mhi_op_callback_to_str(enum mhi_callback reason)
 {
@@ -384,8 +376,6 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 	mhi_ctrl->sbl_size = SZ_512K;
 	mhi_ctrl->seg_len = SZ_512K;
 	mhi_ctrl->fbc_download = true;
-	mhi_ctrl->runtime_get = ath11k_mhi_op_runtime_get;
-	mhi_ctrl->runtime_put = ath11k_mhi_op_runtime_put;
 	mhi_ctrl->status_cb = ath11k_mhi_op_status_cb;
 	mhi_ctrl->read_reg = ath11k_mhi_op_read_reg;
 	mhi_ctrl->write_reg = ath11k_mhi_op_write_reg;
diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index 08f44baf182a5e34651e8c117fe279942f8ad8f4..99d8d9a8944cefa2561cd47d83bbeb53ef13044d 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -230,15 +230,6 @@ static int ath12k_mhi_get_msi(struct ath12k_pci *ab_pci)
 	return 0;
 }
 
-static int ath12k_mhi_op_runtime_get(struct mhi_controller *mhi_cntrl)
-{
-	return 0;
-}
-
-static void ath12k_mhi_op_runtime_put(struct mhi_controller *mhi_cntrl)
-{
-}
-
 static char *ath12k_mhi_op_callback_to_str(enum mhi_callback reason)
 {
 	switch (reason) {
@@ -386,8 +377,6 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
 	mhi_ctrl->sbl_size = SZ_512K;
 	mhi_ctrl->seg_len = SZ_512K;
 	mhi_ctrl->fbc_download = true;
-	mhi_ctrl->runtime_get = ath12k_mhi_op_runtime_get;
-	mhi_ctrl->runtime_put = ath12k_mhi_op_runtime_put;
 	mhi_ctrl->status_cb = ath12k_mhi_op_status_cb;
 	mhi_ctrl->read_reg = ath12k_mhi_op_read_reg;
 	mhi_ctrl->write_reg = ath12k_mhi_op_write_reg;
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index dd372b0123a6da5107b807ff8fe940c567eb2030..312e5c4b9cf8a46ffb20e2afc70441a11ecf659c 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -347,8 +347,6 @@ struct mhi_controller_config {
  * @wake_get: CB function to assert device wake (optional)
  * @wake_put: CB function to de-assert device wake (optional)
  * @wake_toggle: CB function to assert and de-assert device wake (optional)
- * @runtime_get: CB function to controller runtime resume (required)
- * @runtime_put: CB function to decrement pm usage (required)
  * @map_single: CB function to create TRE buffer
  * @unmap_single: CB function to destroy TRE buffer
  * @read_reg: Read a MHI register via the physical link (required)
@@ -427,8 +425,6 @@ struct mhi_controller {
 	void (*wake_get)(struct mhi_controller *mhi_cntrl, bool override);
 	void (*wake_put)(struct mhi_controller *mhi_cntrl, bool override);
 	void (*wake_toggle)(struct mhi_controller *mhi_cntrl);
-	int (*runtime_get)(struct mhi_controller *mhi_cntrl);
-	void (*runtime_put)(struct mhi_controller *mhi_cntrl);
 	int (*map_single)(struct mhi_controller *mhi_cntrl,
 			  struct mhi_buf_info *buf);
 	void (*unmap_single)(struct mhi_controller *mhi_cntrl,

-- 
2.34.1


