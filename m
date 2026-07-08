Return-Path: <linux-wireless+bounces-38788-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C0GMCW1fTmroLQIAu9opvQ
	(envelope-from <linux-wireless+bounces-38788-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 16:32:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C71727627
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 16:32:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=q+srIZaL;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38788-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38788-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3E113028B06
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 14:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC21B42CAFA;
	Wed,  8 Jul 2026 14:30:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983FD3B38B8;
	Wed,  8 Jul 2026 14:30:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521021; cv=none; b=tVUe11HVKDIUTDFfMUd6xWn1ZxtVfR5LrSbrb7BHh9OJqE3Ph2MZfy4+Nd9jue/YlrS3Z+kKsypWocKAZ8L4zvrv86vyU8DzC986RKpMxJ6DQ4hLFZ3yff9ABoeZMjS4UHlvh33R2JxB7dcFUG8/ve+7jCS1hOs9WQCezZabQxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521021; c=relaxed/simple;
	bh=4hVqwbuZIm/HNP5Bk8JYvtEHijklI0/2Q3n+iiwAi48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fLu68eztoc5CWgIcEtcT8p0xeDCsI6G7Ep0OIL3S0HAZjpRiQAW6AxBoaDeiaJPu65iUW5l7SRi/4JUTIpVmIBBtJ3frXkHWW+c5srMhx99/k379YL7noIISj0LDvMN07v6vbkbLw8XcTJFTdGHEog2BDnfKa9M1WueLylLklhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+srIZaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24C05C2BCFA;
	Wed,  8 Jul 2026 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783521021;
	bh=4hVqwbuZIm/HNP5Bk8JYvtEHijklI0/2Q3n+iiwAi48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q+srIZaLXr0j/rgkL6db46q04rppUtUhKz3yzCbQtF3G+icwe2EqU4nWDVJV+eLO/
	 XfplMDlTJgndWeTqUsmg2dFr5qSa8lbyUzeBdd2HQiIkDn3RUD54gjcbIzxoZGWDVn
	 vuJCRnE0Pc6xX9o34YWfWOE2LVKo08UyN0kwXgpT3g7akD56D5R6lYd5UBdYS1Oxe1
	 HyE0ysoLtsj866CntWx9CgxAXr2k9lRrThb+HaErAG/1BSrE0JP5Yoe0bdHhRM7JmA
	 iRgly67/+EmK/szSB0g3lN0eSVU1LrtZX8/8m7ww08OuqhiK/ooMJSep6lK7U5i6jp
	 Dm8Sz9Hblp++w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A06FC44506;
	Wed,  8 Jul 2026 14:30:21 +0000 (UTC)
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Wed, 08 Jul 2026 16:30:17 +0200
Subject: [PATCH v3 3/8] PCI/ASPM: Transition the device to D0 (if required)
 when enabling ASPM link states
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-pci-aspm-fix-v3-3-6bd72451746e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4530; i=mani@kernel.org;
 h=from:subject:message-id;
 bh=eN8FiCdGdbeUI39wBlUZELPWwOUG9j0iJUbJK/xZFBw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqTl74efK/Ai2x0uHQ4mqtQkU8ooqxnXudiFrXg
 XsrnmsIH8uJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCak5e+AAKCRBVnxHm/pHO
 9YxaCACO28V3wROkvPTSmhskvI+UjcCjrMS1wY2edQf4bTICp+480nDgV3gTbJpRm4kJttXNlwO
 bC6tgagWp9VUhLb5CVAA9u9cAYf4bH8Emjb7/iDDZTwH8pxBiJ9oDa0BJmRGTXAts0oapdpF1vk
 44Qibcc1ZpIpfVVwzENLF02X4ZjrO/CrTniD+P4LUkA0t1L+W4d9PW0icrymu0nktqayckHlJ8x
 mabEoMNDTVYcoymRyuakmV8OqwgptaadyBx+5C1FMUolVxyE+nhsa1sBAtcZwqM4bc0jnGkxVEb
 ApsGRWy9IIvgVNWTzqDA5er5LV3U891/iSpdxcuh+yrxgqcz
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
	TAGGED_FROM(0.00)[bounces-38788-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: B7C71727627

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Per PCIe spec r6.0, sec 5.5.4:

"If setting either or both of the enable bits for PCI-PM L1 PM Substates,
both ports must be configured as described in this section while in D0."

Currently, the callers of pci_enable_link_state_locked() (vmd, pcie-qcom)
transition the device to D0 themselves before enabling the link state. But
this is easy to get wrong and has to be duplicated by every caller.

Move the D0 transition into the shared __pci_enable_link_state() helper so
that all three APIs pci_enable_link_state(), pci_enable_link_state_locked()
and pci_force_enable_link_state() perform it, and only when the PCI-PM L1
PM Substates are getting enabled.

Now that the helper handles the transition, drop the redundant D0 transition
from the vmd and pcie-qcom callers.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c |  5 -----
 drivers/pci/controller/vmd.c           |  5 -----
 drivers/pci/pcie/aspm.c                | 23 +++++++++++++++++------
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d8eb52857f69..45f4caeb0814 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1085,11 +1085,6 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 
 static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
 {
-	/*
-	 * Downstream devices need to be in D0 state before enabling PCI PM
-	 * substates.
-	 */
-	pci_set_power_state_locked(pdev, PCI_D0);
 	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
 
 	return 0;
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index d4ae250d4bc6..20597d2cf66e 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -762,11 +762,6 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	pci_info(pdev, "VMD: Default LTR value set by driver\n");
 
 out_state_change:
-	/*
-	 * Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
-	 * PCIe r6.0, sec 5.5.4.
-	 */
-	pci_set_power_state_locked(pdev, PCI_D0);
 	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
 	return 0;
 }
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index c04fb71de91c..6d6862fd2ebb 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1524,6 +1524,17 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked,
 		return -EPERM;
 	}
 
+	/*
+	 * Ensure the device is in D0 before enabling PCI-PM L1 PM Substates, per
+	 * PCIe r6.0, sec 5.5.4.
+	 */
+	if (state & PCIE_LINK_STATE_L1_SS_PCIPM) {
+		if (locked)
+			pci_set_power_state_locked(pdev, PCI_D0);
+		else
+			pci_set_power_state(pdev, PCI_D0);
+	}
+
 	if (!locked)
 		down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
@@ -1550,8 +1561,8 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked,
  * touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
  *
- * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
- * PCIe r6.0, sec 5.5.4.
+ * Note: The device will be transitioned to D0 state if the PCI-PM L1 Substates
+ * are getting enabled.
  *
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
@@ -1569,8 +1580,8 @@ EXPORT_SYMBOL(pci_enable_link_state);
  * can't touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
  *
- * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
- * PCIe r6.0, sec 5.5.4.
+ * Note: The device will be transitioned to D0 state if the PCI-PM L1 Substates
+ * are getting enabled.
  *
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
@@ -1600,8 +1611,8 @@ EXPORT_SYMBOL(pci_enable_link_state_locked);
  * Note that if the BIOS didn't grant ASPM control to the OS, this does nothing
  * because we can't touch the LNKCTL register.
  *
- * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
- * PCIe r6.0, sec 5.5.4.
+ * Note: The device will be transitioned to D0 state if the PCI-PM L1 Substates
+ * are getting enabled.
  *
  * Return: 0 on success, a negative errno otherwise.
  */

-- 
2.43.0



