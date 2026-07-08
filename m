Return-Path: <linux-wireless+bounces-38789-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id snWII4hhTmqTLgIAu9opvQ
	(envelope-from <linux-wireless+bounces-38789-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 16:41:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE13727801
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 16:41:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b="mLWRBx/r";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38789-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38789-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B398E302EA84
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 14:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79B340FD9B;
	Wed,  8 Jul 2026 14:30:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5182DC357;
	Wed,  8 Jul 2026 14:30:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521021; cv=none; b=eEHmAJQ/QHP3fxt5TK4YdC0HVZ/pgJAbKsm9xK4PchkfGOyBl4XErFqhP3osXmtn3Ml7R4PXVXB4pZSUGnm59wYcrz7b8JT1YZBEOgVmljKgLMT25ov1AOAJPyfhPZfQ2ilL/qUlFfhRAJys+WFa/iQsDhbn59b+7ERyrIzPrIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521021; c=relaxed/simple;
	bh=OoH4VDNYfqIdk7eUC4E7wvwCzrnTAR4vZ7H1AmPQRUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pHh5LBbIKzJy0ZYRFhQToabge+ylslpZbV/OW0ONwsHdM6uNUGsmMZB2ITVdE/smhWgP58yGfPJJYGmScApQeoDnuWx3r45/2LgKYQtMvD/a/xPfrc6SwbvwCjRUtyvQxblpzFQ3SiDtyLBT6QPG8A6UMdz7600r7yYPH9nnxCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLWRBx/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 317ECC2BCF6;
	Wed,  8 Jul 2026 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783521021;
	bh=OoH4VDNYfqIdk7eUC4E7wvwCzrnTAR4vZ7H1AmPQRUg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mLWRBx/rKh4KDB3brVKPZdVtAOASWVJt0n4IfCnurxDC/TUdtT6iQbFTfe+oLtKnr
	 /CIGcvkCnApBCZ3/ADb5YKnd4fnug4aW8SiycAclv22mNZApex6A0exnDz5LwndKxw
	 dtHC/DQZW+TOMb8R+4iW9SR9ZcXyPC/ySgLxUcyYTO2vArjmTtRqz54WHL3yv0Zs+A
	 QsRcUfuuGbnsZXWHJ/4Q9pzl6zT8AMHmqLVi3NqsxtWni5b9erivv+vberN/nXUdsP
	 Z1Zi6wmcfHG1oe8PHe6+Mifx7V/OVWLwMvqiGb1iF1XpshCowy879K3QR4/9jCYeMU
	 Q017W85zDAhMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC0CC43458;
	Wed,  8 Jul 2026 14:30:21 +0000 (UTC)
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Wed, 08 Jul 2026 16:30:18 +0200
Subject: [PATCH v3 4/8] PCI/ASPM: Improve the kernel-doc for
 pci_{enable,disable}_link_state*() APIs
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-pci-aspm-fix-v3-4-6bd72451746e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4034; i=mani@kernel.org;
 h=from:subject:message-id;
 bh=XgClAjnhyiml8XcqJmydooMNI2pyqgbp7gCJozvqSQ0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqTl7536htPm2+Z+Y3TZ++LzfQwUsWmNTkYTsAo
 pR++Vq69LuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCak5e+QAKCRBVnxHm/pHO
 9d6GB/4gFDbW2k6rvRFAVXErqcl6iisx10DlBU7FdtAsPYq9rrPjv9r26SgQGwr5/swGAjJOaon
 hiuNPLT58G5Y/hJs6VfYFTEyO/lWptPDC22XsXPA05Zyiyp6PQsv1jxh9hp9Kbn3+xCBx081nfE
 oMUMjO0LX9zwxjj6ecs8jTyt9rMZqH/ivA3gO9uMvStCo7DhT+iK/H33oug7FqHL5VbKv/1fgKd
 p93eH+WkbR1egae/5Z/1lwl+crm7zqTz5JPMPQlVx2FCZ0GIrbvXSeqN2CSnYgwjr1RgkeBwIw6
 1gr5mPep2A3VaNEEcPI4vA2lUMJzOejlXtKTOYSqvbcsM8+p
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38789-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bhelgaas@google.com,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:robh@kernel.org,m:nirmal.patel@linux.intel.com,m:jonathan.derrick@linux.dev,m:jjohnson@kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:ath11k@lists.infradead.org,m:ath10k@lists.infradead.org,m:krishna.chundru@oss.qualcomm.com,m:qiang.yu@oss.qualcomm.com,m:mani@kernel.org,m:ilpo.jarvinen@linux.intel.com,m:manivannan.sadhasivam@oss.qualcomm.com,s:lists@lfdr.de];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c04:e001:36c::12fc:5321:from];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[mani@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CE13727801

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Add kernel-doc for pci_disable_link_state_locked() API and fix the
kernel-doc for pci_disable_link_state() API.

Also convert the kernel-doc of pci_enable_link_state() and
pci_enable_link_state_locked() APIs to the standard format and mention that
pci_force_enable_link_state() should be used to re-enable the states
disabled by pci_disable_link_state().

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pcie/aspm.c | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 6d6862fd2ebb..5e7e199c78d2 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1483,6 +1483,17 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool locked
 	return 0;
 }
 
+/**
+ * pci_disable_link_state_locked - Disable device's link state
+ * @pdev: PCI device
+ * @state: ASPM link state to disable
+ *
+ * Disable device's link state so the link will never enter specific states.
+ *
+ * Context: Caller holds pci_bus_sem read lock.
+ *
+ * Return: 0 on success, a negative errno otherwise.
+ */
 int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
 {
 	lockdep_assert_held_read(&pci_bus_sem);
@@ -1555,17 +1566,20 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked,
 }
 
 /**
- * pci_enable_link_state - Clear and set the default device link state so that
- * the link may be allowed to enter the specified states. Note that if the
- * BIOS didn't grant ASPM control to the OS, this does nothing because we can't
- * touch the LNKCTL register. Also note that this does not enable states
- * disabled by pci_disable_link_state(). Return 0 or a negative errno.
+ * pci_enable_link_state - Enable device's link state
+ * @pdev: PCI device
+ * @state: Mask of ASPM link states to enable
+ *
+ * Enable device's link state, so the link will enter the specified states.
+ * Note that if the BIOS didn't grant ASPM control to the OS, this does
+ * nothing because we can't touch the LNKCTL register. Also note that this
+ * does not enable states disabled by pci_disable_link_state(). Use
+ * pci_force_enable_link_state() for that.
  *
  * Note: The device will be transitioned to D0 state if the PCI-PM L1 Substates
  * are getting enabled.
  *
- * @pdev: PCI device
- * @state: Mask of ASPM link states to enable
+ * Return: 0 on success, a negative errno otherwise.
  */
 int pci_enable_link_state(struct pci_dev *pdev, int state)
 {
@@ -1574,19 +1588,22 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
 EXPORT_SYMBOL(pci_enable_link_state);
 
 /**
- * pci_enable_link_state_locked - Clear and set the default device link state
- * so that the link may be allowed to enter the specified states. Note that if
- * the BIOS didn't grant ASPM control to the OS, this does nothing because we
- * can't touch the LNKCTL register. Also note that this does not enable states
- * disabled by pci_disable_link_state(). Return 0 or a negative errno.
+ * pci_enable_link_state_locked - Enable device's link state
+ * @pdev: PCI device
+ * @state: Mask of ASPM link states to enable
+ *
+ * Enable device's link state, so the link will enter the specified states.
+ * Note that if the BIOS didn't grant ASPM control to the OS, this does
+ * nothing because we can't touch the LNKCTL register. Also note that this
+ * does not enable states disabled by pci_disable_link_state(). Use
+ * pci_force_enable_link_state() for that.
  *
  * Note: The device will be transitioned to D0 state if the PCI-PM L1 Substates
  * are getting enabled.
  *
- * @pdev: PCI device
- * @state: Mask of ASPM link states to enable
- *
  * Context: Caller holds pci_bus_sem read lock.
+ *
+ * Return: 0 on success, a negative errno otherwise.
  */
 int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
 {

-- 
2.43.0



