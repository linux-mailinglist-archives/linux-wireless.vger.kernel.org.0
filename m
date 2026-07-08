Return-Path: <linux-wireless+bounces-38791-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pATuD3RfTmrqLQIAu9opvQ
	(envelope-from <linux-wireless+bounces-38791-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 16:32:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9730372762E
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 16:32:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=mLbMYLM8;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38791-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38791-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56263305289E
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 14:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD7C466B4C;
	Wed,  8 Jul 2026 14:30:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB2D3B813A;
	Wed,  8 Jul 2026 14:30:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521021; cv=none; b=hmYwCUCwq3y5G2JuSQsQCW34JScrG7q20PBJDGgA3eLnLtnsP8JnIf78bxvH2a5+kh8nfwZPg7VX1LCmrUWVVVFjuTL6+GwoRXV9JwAfvLz2pmr/NR7GTKwaNfZOZ+8OwwUbY00Zze4v99tIBlUfsq+LaIiohAsC2ca4uRbUz/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521021; c=relaxed/simple;
	bh=vVE5yOE0bRirNFrBoueGLdw3E79pUlnC26dAxRFgpZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ekmk5bmdZ+MdOlrho36zumoY9DH60tazxeQnAsNWUku4iWoymAiaiQ9KdYsHKo4xvsq9wc57Pg6UAxxEr4vNH918WYD4UHsQOevIUqf429moJsqO5oDDcdm0S+H3SJEdMiqPmFY2O1C3615Cx8xyNcz5ZEHm3dh0YyuwJongIFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLbMYLM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18259C4AF0C;
	Wed,  8 Jul 2026 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783521021;
	bh=vVE5yOE0bRirNFrBoueGLdw3E79pUlnC26dAxRFgpZ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mLbMYLM8wW24mqBR9rd6tll0Ys24KIyR9cB1p/brJFGng/l7BumQ5OX7IOsRiqjWL
	 /BfG4WraqAlBB9aJAVXtAlfTYgs9nBJ1GrG1D4yH4ryEbqN7BoFu1M6b7na6mAM3Ro
	 Kz4Sv7ECSg72DqB93PsnIxNAXeqdHdv3rEd1JNjIQWsMIMf8bz4INAL+NznULE9rTC
	 ryXODxHPppzDKg77/XCMAyHfqfRiFCGoLxBllWuojiJJy+4CexJzwB1MJsPNTR4GoZ
	 NBAp3wJFEmTLQEvy2ZDuNZtmROd9PN8dx5G2IJjt/slxRMpLH2gM1PiIpMBNEWXE4Y
	 gho06IQhzvnDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5D4C43602;
	Wed,  8 Jul 2026 14:30:20 +0000 (UTC)
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Wed, 08 Jul 2026 16:30:16 +0200
Subject: [PATCH v3 2/8] PCI/ASPM: Add pci_force_enable_link_state() API
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260708-pci-aspm-fix-v3-2-6bd72451746e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5764; i=mani@kernel.org;
 h=from:subject:message-id;
 bh=Mr0U/YOJ6IlXuTDx47e3yt+wMzopERPEhAo8juGUh/U=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqTl74NTuP6PUcrzgqzws5sBjwah/bPzY0obC03
 3gtRIlXn/6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCak5e+AAKCRBVnxHm/pHO
 9UnACACVE6DzXMj1/lHXqm8b2d0rVa30L74RcxTqfJhlR2pSVuTNTJ3mCJN22KUIHvmDJAsKUK0
 mw9RIu6duvUNHCneI2GDNvCVC6Sr7bFADno7uEGkTOV7wrA1xbu0xhy2c1vO1NLqXO4MS2VZH8A
 /6g6uKDajWuIKF/ct1Vul7xKTzVAse5lk4e7W/Adn0UF8uM+p/kAurcBNb0cv6C+pG1m7WfmZqa
 Q4YxtuLfa/s1zuWD4Ob4Y9RyinU16qQbYTyBfFXcfuByTS1cqrzPn7dCtrSkmwpVCwmc3wHB8v5
 pBrXNr2ANs4yrNydt4CPOxsNdi03NpXAURT5vp63KmnMq7/u
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38791-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bhelgaas@google.com,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:robh@kernel.org,m:nirmal.patel@linux.intel.com,m:jonathan.derrick@linux.dev,m:jjohnson@kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:ath11k@lists.infradead.org,m:ath10k@lists.infradead.org,m:krishna.chundru@oss.qualcomm.com,m:qiang.yu@oss.qualcomm.com,m:mani@kernel.org,m:ilpo.jarvinen@linux.intel.com,m:manivannan.sadhasivam@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mani@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 9730372762E

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

pci_enable_link_state() and pci_enable_link_state_locked() APIs only enable
the ASPM states that were not previously disabled via
pci_disable_link_state*() API or blacklisted during init (e.g. the pre-1.1
device blacklist, which is only meant to be overridden with
'pcie_aspm=force'). This is an intentional behavior as these APIs must not
silently re-enable states that were deliberately disabled, since doing so
could enable ASPM on a link where it is known to be unsafe.

However, some drivers (e.g. the atheros WLAN drivers) save the currently
enabled ASPM states, disable all ASPM states before firmware download, and
then try to restore exactly the states that were enabled before. Restoring
those states requires re-enabling states that were just disabled via
pci_disable_link_state() API. But, this cannot be achieved using the
existing APIs.

Hence, add pci_force_enable_link_state() API for such callers. Unlike
pci_enable_link_state(), it re-enables the requested states even if they
were previously disabled via pci_disable_link_state() or disabled during
init. The caller is therefore responsible for only enabling states the
device actually supports, typically the ones previously reported by
pcie_aspm_enabled().

This API is implemented by adding a 'force' parameter to the shared
__pci_enable_link_state() helper. When 'force' is true, the requested
states are cleared from 'link->aspm_disable' before enabling.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pcie/aspm.c | 37 ++++++++++++++++++++++++++++++++++---
 include/linux/pci.h     |  3 +++
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 1c15a14718e8..c04fb71de91c 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1506,7 +1506,8 @@ int pci_disable_link_state(struct pci_dev *pdev, int state)
 }
 EXPORT_SYMBOL(pci_disable_link_state);
 
-static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
+static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked,
+				   bool force)
 {
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 
@@ -1527,6 +1528,10 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
 		down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
 	link->aspm_default = pci_calc_aspm_enable_mask(state);
+
+	/* Force enable states that were previously disabled */
+	if (force)
+		link->aspm_disable &= ~link->aspm_default;
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
 	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
@@ -1553,7 +1558,7 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
  */
 int pci_enable_link_state(struct pci_dev *pdev, int state)
 {
-	return __pci_enable_link_state(pdev, state, false);
+	return __pci_enable_link_state(pdev, state, false, false);
 }
 EXPORT_SYMBOL(pci_enable_link_state);
 
@@ -1576,10 +1581,36 @@ int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
 {
 	lockdep_assert_held_read(&pci_bus_sem);
 
-	return __pci_enable_link_state(pdev, state, true);
+	return __pci_enable_link_state(pdev, state, true, false);
 }
 EXPORT_SYMBOL(pci_enable_link_state_locked);
 
+/**
+ * pci_force_enable_link_state - Force enable device link state
+ * @pdev: PCI device
+ * @state: Mask of ASPM link states to enable
+ *
+ * Enable device link state, so the link will enter the specified states.
+ * Unlike pci_enable_link_state(), this also re-enables states previously
+ * disabled by pci_disable_link_state() and overrides the ASPM states disabled
+ * during init (e.g., the pre-1.1 device blacklist). The caller is therefore
+ * responsible for only enabling states the device supports, typically the ones
+ * previously reported by pcie_aspm_enabled().
+ *
+ * Note that if the BIOS didn't grant ASPM control to the OS, this does nothing
+ * because we can't touch the LNKCTL register.
+ *
+ * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+ * PCIe r6.0, sec 5.5.4.
+ *
+ * Return: 0 on success, a negative errno otherwise.
+ */
+int pci_force_enable_link_state(struct pci_dev *pdev, int state)
+{
+	return __pci_enable_link_state(pdev, state, false, true);
+}
+EXPORT_SYMBOL(pci_force_enable_link_state);
+
 void pcie_aspm_remove_cap(struct pci_dev *pdev, u32 lnkcap)
 {
 	if (lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ebb5b9d76360..be6719626c8f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1918,6 +1918,7 @@ int pci_disable_link_state(struct pci_dev *pdev, int state);
 int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
 int pci_enable_link_state(struct pci_dev *pdev, int state);
 int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
+int pci_force_enable_link_state(struct pci_dev *pdev, int state);
 void pcie_no_aspm(void);
 bool pcie_aspm_support_enabled(void);
 bool pcie_aspm_enabled(struct pci_dev *pdev);
@@ -1930,6 +1931,8 @@ static inline int pci_enable_link_state(struct pci_dev *pdev, int state)
 { return 0; }
 static inline int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
 { return 0; }
+static inline int pci_force_enable_link_state(struct pci_dev *pdev, int state)
+{ return 0; }
 static inline void pcie_no_aspm(void) { }
 static inline bool pcie_aspm_support_enabled(void) { return false; }
 static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }

-- 
2.43.0



