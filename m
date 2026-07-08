Return-Path: <linux-wireless+bounces-38793-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 38GqKDJgTmo1LgIAu9opvQ
	(envelope-from <linux-wireless+bounces-38793-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 16:35:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A0E72770A
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 16:35:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=uRhbHwK3;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38793-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38793-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0FC830E7F1E
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 14:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C8849553B;
	Wed,  8 Jul 2026 14:30:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A62F3033DE;
	Wed,  8 Jul 2026 14:30:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521022; cv=none; b=hSOWzd3OrcuHt/Zw2FCGqbhaZEnRJLsbnmipXbVKP9ohveC8P3xjmjqnwriwgY+ZU3FIHpztkX0AgMFcTpamabXEkxcKgWwkdttDQbP1codcsTiDdmw2nOkitM0qoezESzR6llNVnvyQgaSIjpazCsPSErfsLXD1sbmTrZBeDWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521022; c=relaxed/simple;
	bh=VL9HBYLxktPtHWz3XN6ujn/qPGVwq+t0QM8uPcnnyFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=luB26zPmS9Hd+YiaKfiUlALhcaJiHGdXDX2WrKU+eR2zFcDElV8kGFghGPNmfqDU1WOW2z5loJEY0qHCHzZ+LpxOg4smEcIM/5v04Gy81i/6hvfRrNZa8SHh45FgnpEfcdCMiXP1IrjZlBTYQAY251DZnAXiCHdAvxQVdJTAab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRhbHwK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65AD1C2BCF4;
	Wed,  8 Jul 2026 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783521021;
	bh=VL9HBYLxktPtHWz3XN6ujn/qPGVwq+t0QM8uPcnnyFE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uRhbHwK3Hf3oKmmdv0lNC/QZ6OhpkyuOaN+7dORrmgX8oRHJRRtfj85EdijayXYoj
	 CQSgtp8xqhVG/GTkdPVdoJ2/li8G68v24TsSohL+1UTOddETUJC9S0RAiJB48r76tF
	 TipfLmRXNsSvT2h3Linjb90tfzMdcdu3rEeAP7WwGWIbuWa3+bltJVMFQN2RX5SHRN
	 FyIwspRQ0Qg45UKYxoiDLMmOFi1S2alIdj0zEdwVLe2GbqkekY1DdaT27Xkjt2doKJ
	 ERmPOTc6N/ddk0C+tl5d7HtvBmhNj+tlqN5Pht89On1m19Nlesf+RyuQuGuYX2uFRF
	 9ggCA394y4ZNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A57C43458;
	Wed,  8 Jul 2026 14:30:21 +0000 (UTC)
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Wed, 08 Jul 2026 16:30:21 +0200
Subject: [PATCH v3 7/8] wifi: ath11k: Use pci_{enable/disable}_link_state()
 APIs to enable/disable ASPM states
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-pci-aspm-fix-v3-7-6bd72451746e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2987; i=mani@kernel.org;
 h=from:subject:message-id;
 bh=59wUpl/E90ZN2ijmP67COqOAAWZoyF3++0KlktxUhMw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqTl76AXfVIr8lqqmcElFkQxvRb8nDLwSolH+U2
 iY07JQuAxuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCak5e+gAKCRBVnxHm/pHO
 9Wy6B/4nR2x6UIp/WP9pSP7RSsfelBYusTRvVs4+R8UckgV8QXSru8c3ChXtF9OQA25L+uTJIPt
 cPxnbkzy/D+vaVEXLXlKcvbiNwCVpX6wOPUmjt871CfxhHdbHzPiKCWyRSWqnc+Cp76e4N92F5z
 dO+CNQfuRXGBKMEeOa/ZeWWXGpvB4TpnOB1x8eoNVvtxSsFV9hNI7e4Cyn4VK/+Dpak80cfm5qc
 8dbw7VfNliQlhn3a/BK96N5h4fCU7mQwAFHFH481OTDGcGKl6nFaW31jtf3t9efq1gHu0Tn8pS6
 b3TB8xLvXYX3IaziB8Y8XVlT15A7Px8rfBobRQIPmiCafNLm
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
	TAGGED_FROM(0.00)[bounces-38793-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: F2A0E72770A

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

It is not recommended to enable/disable the ASPM states on the back of the
PCI core directly using the LNKCTL register. It will break the PCI core's
knowledge about the device ASPM states. So use the APIs exposed by the PCI
core to enable/disable ASPM states.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/Kconfig |  2 +-
 drivers/net/wireless/ath/ath11k/pci.c   | 19 +++----------------
 drivers/net/wireless/ath/ath11k/pci.h   |  3 ++-
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
index 122726f84492..c8b418521173 100644
--- a/drivers/net/wireless/ath/ath11k/Kconfig
+++ b/drivers/net/wireless/ath/ath11k/Kconfig
@@ -19,7 +19,7 @@ config ATH11K_AHB
 
 config ATH11K_PCI
 	tristate "Atheros ath11k PCI support"
-	depends on ATH11K && PCI
+	depends on ATH11K && PCI && PCIEASPM
 	select MHI_BUS
 	select QRTR
 	select QRTR_MHI
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 35bb9e7a63a2..da980e01d1fc 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -604,19 +604,9 @@ static void ath11k_pci_free_region(struct ath11k_pci *ab_pci)
 
 static void ath11k_pci_aspm_disable(struct ath11k_pci *ab_pci)
 {
-	struct ath11k_base *ab = ab_pci->ab;
-
-	pcie_capability_read_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-				  &ab_pci->link_ctl);
-
-	ath11k_dbg(ab, ATH11K_DBG_PCI, "link_ctl 0x%04x L0s %d L1 %d\n",
-		   ab_pci->link_ctl,
-		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L0S),
-		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
+	ab_pci->aspm_states = pcie_aspm_enabled(ab_pci->pdev);
 
-	/* disable L0s and L1 */
-	pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-				   PCI_EXP_LNKCTL_ASPMC);
+	pci_disable_link_state(ab_pci->pdev, PCIE_LINK_STATE_ASPM_ALL);
 
 	set_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags);
 }
@@ -624,10 +614,7 @@ static void ath11k_pci_aspm_disable(struct ath11k_pci *ab_pci)
 static void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci)
 {
 	if (test_and_clear_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags))
-		pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-						   PCI_EXP_LNKCTL_ASPMC,
-						   ab_pci->link_ctl &
-						   PCI_EXP_LNKCTL_ASPMC);
+		pci_force_enable_link_state(ab_pci->pdev, ab_pci->aspm_states);
 }
 
 #ifdef CONFIG_DEV_COREDUMP
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index 1e3005a4b64c..474c18741418 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -72,7 +72,8 @@ struct ath11k_pci {
 
 	/* enum ath11k_pci_flags */
 	unsigned long flags;
-	u16 link_ctl;
+	/* Cached PCIe ASPM states */
+	u32 aspm_states;
 	u64 dma_mask;
 };
 

-- 
2.43.0



