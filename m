Return-Path: <linux-wireless+bounces-15668-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3139D7A87
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 04:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2296C2802BB
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 03:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CA717C7CA;
	Mon, 25 Nov 2024 03:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ionic.de header.i=@ionic.de header.b="Ar3/++OM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ionic.de (ionic.de [145.239.234.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9652B9A8;
	Mon, 25 Nov 2024 03:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.234.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732506720; cv=none; b=mdRnwxbmE651YFlCqCOL91T7Y2yXzm3sEn/AMEx0qL+66+Zo19CTrit+j0e/lcAiwPjWxYwoVGO3vcgXXPfJ591WPdieGsgLKLN7FKhFYrDODiKmT2wSLwRepSyTPI3xnh0lxbsKjiSb4rNRuWGpnQsRi1v9gPaBOs52Y4x3Mqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732506720; c=relaxed/simple;
	bh=uarmoy9+EMg/fFr/hCx5+LAu3sMG/dpzPKmrg3NEXGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9vMRyzXf8zW8H+Jsnz/6sTPXjzJLFNethba33ufp3M6xHCQUYyZ9Z1LM2p+flhpO4HTzi0Zjo5r96bZ1k7UjrwoyRgDQmX0w02NsLf4xxFy7q0NtO2dwuIGLe1frDFBH9Ru/Wb57fW4rcBsNFDCEybRJ1RPd2n46BH/Fi1BDRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ionic.de; spf=pass smtp.mailfrom=ionic.de; dkim=pass (1024-bit key) header.d=ionic.de header.i=@ionic.de header.b=Ar3/++OM; arc=none smtp.client-ip=145.239.234.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ionic.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionic.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ionic.de; s=default;
	t=1732506709; bh=uarmoy9+EMg/fFr/hCx5+LAu3sMG/dpzPKmrg3NEXGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ar3/++OM2MF5d6/Q8wCmnrnQ0bVadEZtObzAEYedGk+CunBNax65rbQ30jDcn6AY8
	 ky4xKKHY/exRuD3ye+AmzyXSqWdYht9Ge8OrRX1C7UKW/wLBmz1XRW7Jw9bXPoqBUt
	 oijbjbuTk9PHeDHtruife5YXIojidn2N0yP+9L5o=
Received: from grml.local.home.ionic.de (unknown [IPv6:2a00:11:fb41:7a00:21b:21ff:fe5e:dddc])
	by mail.ionic.de (Postfix) with ESMTPSA id B7059148870F;
	Mon, 25 Nov 2024 04:51:49 +0100 (CET)
From: Mihai Moldovan <ionic@ionic.de>
To: ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC] [PATCH v2 09/13] wifi: ath11k: implement QRTR endpoint ID fetching for PCI
Date: Mon, 25 Nov 2024 04:50:24 +0100
Message-ID: <fba915367126c230964aedd619ce6c035b74565c.1732506261.git.ionic@ionic.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1732506261.git.ionic@ionic.de>
References: <cover.1732506261.git.ionic@ionic.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QRTR endpoint ID fetching for PCIe devices will use MHI.

Signed-off-by: Mihai Moldovan <ionic@ionic.de>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 22 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/mhi.h |  1 +
 drivers/net/wireless/ath/ath11k/pci.c |  1 +
 3 files changed, 24 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 6e45f464a429..0b3f9f965aee 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -11,6 +11,8 @@
 #include <linux/of_address.h>
 #include <linux/ioport.h>
 
+#include <net/qrtr.h>
+
 #include "core.h"
 #include "debug.h"
 #include "mhi.h"
@@ -491,3 +493,23 @@ int ath11k_mhi_resume(struct ath11k_pci *ab_pci)
 
 	return 0;
 }
+
+int ath11k_mhi_set_qrtr_endpoint_id(struct ath11k_base *ab)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	struct ath11k_qmi *qmi = &ab->qmi;
+	int ret;
+
+	/* Pass endpoint ID up for QMI usage. */
+	ret = qrtr_endpoint_id_get_or_assign(ab_pci->mhi_ctrl,
+					     &qmi->handle.endpoint_id);
+	ath11k_dbg(ab, ATH11K_DBG_PCI,
+		   "queried mhi_ctrl QRTR endpoint ID: %u\n",
+		   qmi->handle.endpoint_id);
+	if (ret) {
+		ath11k_warn(ab, "failed to query QRTR endpoint ID: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wireless/ath/ath11k/mhi.h b/drivers/net/wireless/ath/ath11k/mhi.h
index a682aad52fc5..84465fb5d5da 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.h
+++ b/drivers/net/wireless/ath/ath11k/mhi.h
@@ -27,4 +27,5 @@ void ath11k_mhi_clear_vector(struct ath11k_base *ab);
 int ath11k_mhi_suspend(struct ath11k_pci *ar_pci);
 int ath11k_mhi_resume(struct ath11k_pci *ar_pci);
 
+int ath11k_mhi_set_qrtr_endpoint_id(struct ath11k_base *ab);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index a6cc2a4f072d..6f3c1db11f69 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -744,6 +744,7 @@ static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.ce_irq_enable = ath11k_pci_hif_ce_irq_enable,
 	.ce_irq_disable = ath11k_pci_hif_ce_irq_disable,
 	.get_ce_msi_idx = ath11k_pcic_get_ce_msi_idx,
+	.set_qrtr_endpoint_id = ath11k_mhi_set_qrtr_endpoint_id,
 };
 
 static void ath11k_pci_read_hw_version(struct ath11k_base *ab, u32 *major, u32 *minor)
-- 
2.45.2


