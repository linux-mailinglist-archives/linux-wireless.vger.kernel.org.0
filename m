Return-Path: <linux-wireless+bounces-22537-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308DCAAA792
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1398D5A1F43
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D658F338C14;
	Mon,  5 May 2025 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brnFPH0B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4DB293473;
	Mon,  5 May 2025 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484625; cv=none; b=pUVHvB/jpvqGTJmVizRp0xoTxRt34sjlftD3vizJDIPLII85jkXANCSBXu7KfDgK4u1UNmTZ6QzqVdaN47BK4k8CtOwGoItqmxZ//9oQ02h4AOEoCLJRtF8s4HhFeCZm6V00P0YfUF0PKLRA0YrLZ5Q4HnHD3amzPAYQb7LcSfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484625; c=relaxed/simple;
	bh=Iorwx/78CiNVkAt+h36FsYKKL7SESneynjnqM6o1jN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZEPNx8qArYS2i6egCrwAmgZHMeDIzP8KDuuBScNZGjF/AwBOvPwU02yCdOUwgTKrNmFL4bYq4082WF1caCIqOmQAq5cSsWKCzdYIT1db3QjDUeSAVfo/HlwvLeExRvRkjTPDiux2X4UoRTOCN1vRAF5fSBBdzn+xHbOYWeZGDAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brnFPH0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF12C4CEE4;
	Mon,  5 May 2025 22:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484625;
	bh=Iorwx/78CiNVkAt+h36FsYKKL7SESneynjnqM6o1jN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=brnFPH0Bo9F78qbw6rFVFKfrNBLhvWAd+SIrbcTEG0voE3PKpSf7Kapz4WBHY37XU
	 JgDc2Nve+Lzj912y60pAPWrj0Md+UtvCwpoNoabRqsTC7GTy63Ci6EtpmcTRFW1E7h
	 mUosthKPDOvbVCUGtjI+a0K+T1zxIC+dvrza9Jx/Un5YR99n+WY6fjBdq5JQtaPTGJ
	 nZGda5bhx3h78Fc/ig0dKHAirh2r1oZOsHIo6CpsB3tdxGhbt0NTKQQlxe+LhSAC2/
	 oqagYas8QgwcSw3OIVOL7zNQZvIfCVZU59zO3D/x/wklc5wH+8L/TyrNtxkVkOSTRt
	 oxhEVV2dC9NgA==
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
Subject: [PATCH AUTOSEL 6.14 569/642] wifi: ath12k: Avoid napi_sync() before napi_enable()
Date: Mon,  5 May 2025 18:13:05 -0400
Message-Id: <20250505221419.2672473-569-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 6325ac493f82c..2699c383fc4c9 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -166,6 +166,7 @@ struct ath12k_ext_irq_grp {
 	u32 num_irq;
 	u32 grp_id;
 	u64 timestamp;
+	bool napi_enabled;
 	struct napi_struct napi;
 	struct net_device *napi_ndev;
 };
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index ee14b84845487..895b2314d1d58 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -483,8 +483,11 @@ static void __ath12k_pci_ext_irq_disable(struct ath12k_base *ab)
 
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
 
@@ -1114,7 +1117,11 @@ void ath12k_pci_ext_irq_enable(struct ath12k_base *ab)
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


