Return-Path: <linux-wireless+bounces-38794-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6N6XH1pgTmpDLgIAu9opvQ
	(envelope-from <linux-wireless+bounces-38794-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 16:36:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC92D72773B
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 16:36:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=gOQSqBSh;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38794-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38794-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C98D330FC65D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 14:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6079631282F;
	Wed,  8 Jul 2026 14:30:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8B83033E9;
	Wed,  8 Jul 2026 14:30:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521022; cv=none; b=drWrt5X5ae6YGZ5dqyTwT5SwN0KmTVfSW09ONDlS8fTvNoySi5uniedFG9qYF/nmg5OuCkv+eMBw5T3RZJfLtjmYas18AdNKBLsM74xhvDQBHGTvyH2MFoCMHHCNfE9tRyeWYJt/dfGUdvq/f9IQExU7Al7qIIbKoPm//WogHwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521022; c=relaxed/simple;
	bh=TqQr0msAx4grAoY90aiW5jbpDptHFeE3x0YSBfqdt/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hOZ4eEu1osnNWatqg45zAXOxcOZpmLyLE626Biq9eP/VgkZYyjo/p2F0EoLJ9eoYjCAzmi2xuo7QPxqS3ubnowPi6UXHsPRvbK3PSQPCS1jtR/DnfXj6xwZZiZXQLzfX0jpxZJbdgYxySBqHYsTYtmtr2n6LQVjKlxQbUOL5loc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOQSqBSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5787AC2BCB9;
	Wed,  8 Jul 2026 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783521021;
	bh=TqQr0msAx4grAoY90aiW5jbpDptHFeE3x0YSBfqdt/Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gOQSqBShMKYl+w/39ebTEvy4rTe6DqFOob3FkYnC2lckYh1L5sT9EgpU62xsrmyg5
	 pAlkNW3qf5VVz8qUmyAWWnBFAoyex6tpT314lz7/j5AczKNt2uD/UPhn+NWekd+Gh5
	 cnSlKXI4kdBw1/9uuAnwyTTBPKXfxLAqBT+6YDxTxRH3HWQ3ucvc0pFmNuvWTI9wr4
	 C6zgwJlFu8oQ6eg56iqsrncZ8P3qLDK+UfCpa7l9ejkAT/25A6s2gfyjAWWHULl6dm
	 0JHg3c1vpDabNJH4L2ot8Zlaghz9fdUGrA5h/OdB9CesauphBr/VtgntDcBurEIiI0
	 /xzflhOj2F5/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42460C44503;
	Wed,  8 Jul 2026 14:30:21 +0000 (UTC)
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Wed, 08 Jul 2026 16:30:20 +0200
Subject: [PATCH v3 6/8] wifi: ath12k: Use pci_{enable/disable}_link_state()
 APIs to enable/disable ASPM states
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-pci-aspm-fix-v3-6-6bd72451746e@kernel.org>
References: <20260708-pci-aspm-fix-v3-0-6bd72451746e@kernel.org>
In-Reply-To: <20260708-pci-aspm-fix-v3-0-6bd72451746e@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Nirmal Patel <nirmal.patel@linux.intel.com>, 
 Jonathan Derrick <jonathan.derrick@linux.dev>, 
 Jeff Johnson <jjohnson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath12k@lists.infradead.org, ath11k@lists.infradead.org, 
 ath10k@lists.infradead.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Qiang Yu <qiang.yu@oss.qualcomm.com>, mani@kernel.org, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3280; i=mani@kernel.org;
 h=from:subject:message-id;
 bh=fI4OgbaPQvxdUdvQa5firVs9z5T3bQjOqFuWB+LMbBg=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqTl75VwhT+5dcnzfCyLucqXIxYRsokyBQxiGRy
 E53judLsUqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCak5e+QAKCRBVnxHm/pHO
 9cxgCACCZmQ4ZHcdD5iDF15DWrWzCvR8nBREuRoCrrlIwmWq63iwTxavA29WGJJWKfFBrJXcdil
 1aOMoiu/Al2R5zSjVFvRUhLFG7tt97Xx4J+pSKbos+8HKVuaJE0O3gYNoHBFHXp6X5JKkVSRdwZ
 9w8fESRhXhywBZzS3BN6iKtLxEySaXPVe09b15fmBSix7LVRjHRG5eZn0KU/hLltqijgpcZHW9K
 4tWc0FL090YuNf52Xc9J2U6WgO7nMMQ857NpXzMtiNR0LeFuDlgJt871REsetU/10At4cPcnd2Z
 7pCSogU1ACJWcmikj6ZX1r2a6k9QHDBdyoQKLXGH2srrDMsB
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for mani@kernel.org/default with
 auth_id=787
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38794-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bhelgaas@google.com,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:robh@kernel.org,m:nirmal.patel@linux.intel.com,m:jonathan.derrick@linux.dev,m:jjohnson@kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:ath11k@lists.infradead.org,m:ath10k@lists.infradead.org,m:krishna.chundru@oss.qualcomm.com,m:qiang.yu@oss.qualcomm.com,m:mani@kernel.org,m:ilpo.jarvinen@linux.intel.com,m:manivannan.sadhasivam@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mani@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC92D72773B

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

It is not recommended to enable/disable the ASPM states on the back of the
PCI core directly using the LNKCTL register. It will break the PCI core's
knowledge about the device ASPM states. So use the APIs exposed by the PCI
core to enable/disable ASPM states.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Reported-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/Kconfig |  2 +-
 drivers/net/wireless/ath/ath12k/pci.c   | 19 +++----------------
 drivers/net/wireless/ath/ath12k/pci.h   |  4 +++-
 3 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/Kconfig b/drivers/net/wireless/ath/ath12k/Kconfig
index 4a2b240f967a..7852ede3eaea 100644
--- a/drivers/net/wireless/ath/ath12k/Kconfig
+++ b/drivers/net/wireless/ath/ath12k/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause-Clear
 config ATH12K
 	tristate "Qualcomm Wi-Fi 7 support (ath12k)"
-	depends on MAC80211 && HAS_DMA && PCI
+	depends on MAC80211 && HAS_DMA && PCI && PCIEASPM
 	select QCOM_QMI_HELPERS
 	select MHI_BUS
 	select QRTR
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index d9a22d6afbb0..6d48fb25690d 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -884,19 +884,9 @@ static void ath12k_pci_free_region(struct ath12k_pci *ab_pci)
 
 static void ath12k_pci_aspm_disable(struct ath12k_pci *ab_pci)
 {
-	struct ath12k_base *ab = ab_pci->ab;
-
-	pcie_capability_read_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-				  &ab_pci->link_ctl);
-
-	ath12k_dbg(ab, ATH12K_DBG_PCI, "pci link_ctl 0x%04x L0s %d L1 %d\n",
-		   ab_pci->link_ctl,
-		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L0S),
-		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
+	ab_pci->aspm_states = pcie_aspm_enabled(ab_pci->pdev);
 
-	/* disable L0s and L1 */
-	pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-				   PCI_EXP_LNKCTL_ASPMC);
+	pci_disable_link_state(ab_pci->pdev, PCIE_LINK_STATE_ASPM_ALL);
 
 	set_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags);
 }
@@ -925,10 +915,7 @@ static void ath12k_pci_aspm_restore(struct ath12k_pci *ab_pci)
 {
 	if (ab_pci->ab->hw_params->supports_aspm &&
 	    test_and_clear_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags))
-		pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-						   PCI_EXP_LNKCTL_ASPMC,
-						   ab_pci->link_ctl &
-						   PCI_EXP_LNKCTL_ASPMC);
+		pci_force_enable_link_state(ab_pci->pdev, ab_pci->aspm_states);
 }
 
 static void ath12k_pci_cancel_workqueue(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
index 0e0e2020c6ae..409ef063cd69 100644
--- a/drivers/net/wireless/ath/ath12k/pci.h
+++ b/drivers/net/wireless/ath/ath12k/pci.h
@@ -128,7 +128,9 @@ struct ath12k_pci {
 
 	/* enum ath12k_pci_flags */
 	unsigned long flags;
-	u16 link_ctl;
+
+	/* Cached PCIe ASPM states */
+	u32 aspm_states;
 	unsigned long irq_flags;
 	const struct ath12k_pci_ops *pci_ops;
 	u32 qmi_instance;

-- 
2.43.0



