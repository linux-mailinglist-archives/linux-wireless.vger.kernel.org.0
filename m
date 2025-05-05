Return-Path: <linux-wireless+bounces-22628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6FCAAB252
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 06:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBD41891D76
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 04:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7613375BB;
	Tue,  6 May 2025 00:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkMVA4g3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83F22D7AE0;
	Mon,  5 May 2025 22:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485725; cv=none; b=hDNxpNW74S+mjfqfyLz6q9CbPiILcVxhd8hu80XZYXdFQ2DQDKFy15oT5D0Mp5hQfdCqLezYxUbD66b2SQhcSRVv7F5bRs+5A6CyemnTradzMN2yc3Jn1ZFfj5Wx7OYL4nSAKqWsd7JbUoXkJSkQmv8UDcwTJZvk79U7DQulPk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485725; c=relaxed/simple;
	bh=AacAX110S5z2tG92wMAN89b1mrxBDeQr+V5y2E7kQ7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fn2iFII++XEsg+R4a9RHaa4jMKVHp4Y/Z9o22U2O6JkuWvmau0lrCnpw2nltegCypqJolq2bLLnvSGpQSJ5hiTumXa5fhjNtgUkKD7dLuYOGwjjd4Quibz8q/ZaUbCiLpFeFnNabx7CT8N+D6c9aLXmhqeskxcTUno/CCouMbNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkMVA4g3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A2BC4CEF1;
	Mon,  5 May 2025 22:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485724;
	bh=AacAX110S5z2tG92wMAN89b1mrxBDeQr+V5y2E7kQ7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GkMVA4g31jvFTM7h3iqHWumElU3hWDwYODlMfHww3esDOoG8yYLHlMhzbL/xjvIyl
	 8W2lh/12eG8f1u6lz+e9mKYUjvUymZv8ZMXAd8NYuEC3s0W+p90Sn81B2IRwLVIlgJ
	 tc+35pdILDYtaNu5UMLcN1ZY67fM47BHvK20OEPiIkq1GwAIdwpjIiV66PFqgUJcdh
	 TUGLu7WTMEP4fsxbs/OI8tvYLQFVlh/2xsL8liqUGuMppvhS4BWuaFrA+JPE8MBVpK
	 dSYD2tnHym8vxq0V8yLi1DLHIbju5rogl179/fV50ohH4DMJpfEnPZLcNQQXwzsA3/
	 viXSOhgX7XBBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Avula Sri Charan <quic_asrichar@quicinc.com>,
	Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
	Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 445/486] wifi: ath12k: Avoid napi_sync() before napi_enable()
Date: Mon,  5 May 2025 18:38:41 -0400
Message-Id: <20250505223922.2682012-445-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Avula Sri Charan <quic_asrichar@quicinc.com>

[ Upstream commit 268c73d470a5790a492a2fc2ded084b909d144f3 ]

In case of MHI error a reset work will be queued which will try
napi_disable() after napi_synchronize().

As the napi will be only enabled after qmi_firmware_ready event,
trying napi_synchronize() before napi_enable() will result in
indefinite sleep in case of a firmware crash in QMI init sequence.

To avoid this, introduce napi_enabled flag to check if napi is enabled
or not before calling napi_synchronize().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Avula Sri Charan <quic_asrichar@quicinc.com>
Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Link: https://patch.msgid.link/20250124090058.3194299-1-quic_tamizhr@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/core.h |  1 +
 drivers/net/wireless/ath/ath12k/pci.c  | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 7f2e9a9b40977..3faf3430effb9 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -148,6 +148,7 @@ struct ath12k_ext_irq_grp {
 	u32 num_irq;
 	u32 grp_id;
 	u64 timestamp;
+	bool napi_enabled;
 	struct napi_struct napi;
 	struct net_device *napi_ndev;
 };
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 2ff866e1d7d5b..45d537066345a 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -481,8 +481,11 @@ static void __ath12k_pci_ext_irq_disable(struct ath12k_base *ab)
 
 		ath12k_pci_ext_grp_disable(irq_grp);
 
-		napi_synchronize(&irq_grp->napi);
-		napi_disable(&irq_grp->napi);
+		if (irq_grp->napi_enabled) {
+			napi_synchronize(&irq_grp->napi);
+			napi_disable(&irq_grp->napi);
+			irq_grp->napi_enabled = false;
+		}
 	}
 }
 
@@ -1112,7 +1115,11 @@ void ath12k_pci_ext_irq_enable(struct ath12k_base *ab)
 	for (i = 0; i < ATH12K_EXT_IRQ_GRP_NUM_MAX; i++) {
 		struct ath12k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
 
-		napi_enable(&irq_grp->napi);
+		if (!irq_grp->napi_enabled) {
+			napi_enable(&irq_grp->napi);
+			irq_grp->napi_enabled = true;
+		}
+
 		ath12k_pci_ext_grp_enable(irq_grp);
 	}
 
-- 
2.39.5


