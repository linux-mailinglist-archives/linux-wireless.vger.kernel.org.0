Return-Path: <linux-wireless+bounces-38795-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S7L2H0dgTmo8LgIAu9opvQ
	(envelope-from <linux-wireless+bounces-38795-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 16:35:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CE872771B
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 16:35:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=MTZhMT+7;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38795-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38795-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAD9F30F2F61
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 14:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54653299937;
	Wed,  8 Jul 2026 14:30:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D163AEF34;
	Wed,  8 Jul 2026 14:30:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521022; cv=none; b=TPqTZK6c9pEjgs8VQ7eT+MmtDjL7T1Mol5SHD2zbohs9InGZj2f0Qz3WF+8W0IhwC7STW2qpzccqb8zSqDdCHpgu9ERBZ0wo9S/49rQVSLr1ARWtWIKtflNVBNGRcF0D0cvZ8HCIDKKs2olTETnkYr7H4HRxZbFvIg6HqMNgrgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521022; c=relaxed/simple;
	bh=FBm9gNuNzt9SJsQ0hC9UT2oUPY0iinHKBxh/yqQB+Zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qZ0QJRDsjGSBAINck9I5vFhzEzde6PPXk1ogEHFONTNe0zdNSgmwQkJUb7zNeB8eCykkDu8tQ2Ac3MMXztZyevbR/gp8ykwfFwz8+CcZgDra1u4swbAvS7IYoiazWgSjTmTTg+dlmPliTIOeWX/gSC5rHju/yjZiVPNJxSesYpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTZhMT+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77425C2BCF5;
	Wed,  8 Jul 2026 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783521021;
	bh=FBm9gNuNzt9SJsQ0hC9UT2oUPY0iinHKBxh/yqQB+Zo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MTZhMT+7duBMhXAvbpqWaXcnTAmXbG384xFmed2kGbvGk9oPbBaSs4HpsugdMpxNx
	 679ztub8wi742TQH8aH6yHI/gW93ChTb3xDyRuO8zCsxgoyjraKaeklI+BdNzx97DC
	 MgXq0fbDRCbUziTzx49vGCHf1hbJq+n9jF8QxnmY/59MhFDDcDmxo+9n9EZ63aG2lE
	 qfdK8BuRgRH/Td7/GYfgjJisAGOfkOdnJAQOfOv3QY4U0JzWvdx3TKXvH80MNrBkQq
	 k4OW9664oK7p2EsfFxUwEU1Vf3jJ8sgoDqEtp1V3QKeGhbxIaHwYuvn2JJ1EGGqk2R
	 fMYlINc9lwA7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6241FC43602;
	Wed,  8 Jul 2026 14:30:21 +0000 (UTC)
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Wed, 08 Jul 2026 16:30:22 +0200
Subject: [PATCH v3 8/8] wifi: ath10k: Use pci_{enable/disable}_link_state()
 APIs to enable/disable ASPM states
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-pci-aspm-fix-v3-8-6bd72451746e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2824; i=mani@kernel.org;
 h=from:subject:message-id;
 bh=1V3SgamKnKbZCTaqKi1kk2ScK2GisZBgIvhrbdDfnK8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqTl76e2nfaUZvQNRIS2JAPpu0u23/DFhDhZ81P
 q/TDV/Dm+eJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCak5e+gAKCRBVnxHm/pHO
 9Tw7CAClHNhscV05//m5Z7wi7IlDfyYBab+jNO+wyaShe6hkjqEqWMyHT6/VoLxuobAHNoUOunm
 TTTFtKSglloBBVmGdDeo2vQusyiSbq2D3jecIfM2HWf01oPR/lDhMPM9iu6NP/dTnjPifoFqGfv
 XdHF3Vicrqbavf6w5sZsEAJ74QbBA9UUc3ncielCX8s36O+Ij0cvdEJRpRCTKLxR6WSarpbBz7F
 JbVIyPPBhRVHZswbvVTi48SJxq1IBYZAsIQIbxR6TyWtKgj5KKpdvTYVZq62bqgLmXbnHt1MRNd
 T9Nf2E44HV5nLkqcXnF+3mtJL2czXg7lcRLMpw+sZrEe41go
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
	TAGGED_FROM(0.00)[bounces-38795-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 19CE872771B

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

It is not recommended to enable/disable the ASPM states on the back of the
PCI core directly using the LNKCTL register. It will break the PCI core's
knowledge about the device ASPM states. So use the APIs exposed by the PCI
core to enable/disable ASPM states.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/Kconfig |  2 +-
 drivers/net/wireless/ath/ath10k/pci.c   | 11 ++++-------
 drivers/net/wireless/ath/ath10k/pci.h   |  5 ++---
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wireless/ath/ath10k/Kconfig
index efb9f022d8c6..eac3ec5a4e78 100644
--- a/drivers/net/wireless/ath/ath10k/Kconfig
+++ b/drivers/net/wireless/ath/ath10k/Kconfig
@@ -17,7 +17,7 @@ config ATH10K_CE
 
 config ATH10K_PCI
 	tristate "Atheros ath10k PCI support"
-	depends on ATH10K && PCI
+	depends on ATH10K && PCI && PCIEASPM
 	help
 	  This module adds support for PCIE bus
 
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 335bc7c488e4..2e27a70065cc 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -1965,9 +1965,7 @@ static int ath10k_pci_hif_start(struct ath10k *ar)
 	ath10k_pci_irq_enable(ar);
 	ath10k_pci_rx_post(ar);
 
-	pcie_capability_clear_and_set_word(ar_pci->pdev, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC,
-					   ar_pci->link_ctl & PCI_EXP_LNKCTL_ASPMC);
+	pci_force_enable_link_state(ar_pci->pdev, ar_pci->aspm_states);
 
 	return 0;
 }
@@ -2822,10 +2820,9 @@ static int ath10k_pci_hif_power_up(struct ath10k *ar,
 
 	ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot hif power up\n");
 
-	pcie_capability_read_word(ar_pci->pdev, PCI_EXP_LNKCTL,
-				  &ar_pci->link_ctl);
-	pcie_capability_clear_word(ar_pci->pdev, PCI_EXP_LNKCTL,
-				   PCI_EXP_LNKCTL_ASPMC);
+	ar_pci->aspm_states = pcie_aspm_enabled(ar_pci->pdev);
+
+	pci_disable_link_state(ar_pci->pdev, PCIE_LINK_STATE_ASPM_ALL);
 
 	/*
 	 * Bring the target up cleanly.
diff --git a/drivers/net/wireless/ath/ath10k/pci.h b/drivers/net/wireless/ath/ath10k/pci.h
index d114778edb41..122e365b7cdd 100644
--- a/drivers/net/wireless/ath/ath10k/pci.h
+++ b/drivers/net/wireless/ath/ath10k/pci.h
@@ -128,10 +128,9 @@ struct ath10k_pci {
 	struct timer_list rx_post_retry;
 
 	/* Due to HW quirks it is recommended to disable ASPM during device
-	 * bootup. To do that the original PCI-E Link Control is stored before
-	 * device bootup is executed and re-programmed later.
+	 * bootup. To do that the ASPM states are saved and re-programmed later.
 	 */
-	u16 link_ctl;
+	u32 aspm_states;
 
 	/* Protects ps_awake and ps_wake_refcount */
 	spinlock_t ps_lock;

-- 
2.43.0



