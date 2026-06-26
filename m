Return-Path: <linux-wireless+bounces-38110-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6wXxNXoTPmpL/ggAu9opvQ
	(envelope-from <linux-wireless+bounces-38110-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 07:51:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE666CA80B
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 07:51:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=P7Ce1zD7;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38110-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38110-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3AF8305FC3C
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 05:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD1D3CBE8B;
	Fri, 26 Jun 2026 05:50:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496B23CCA13
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 05:50:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782453052; cv=none; b=YvmtVJ+gtgydawtbZ+qs1wiYRJuQpSEcUmUPUqeA5EX3aow7NgdHyQZV5wCJtsRtSlK7cUTeXzAtecRHTOkuVn2VcgK0aUKkJcV0YjT7W/uXQPj9HSiJlWr/xP8Fs/aCW9y5LLmW2Eu3IynRmOyj/Ue/ZUcDpnA3vJJcn0yr7vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782453052; c=relaxed/simple;
	bh=se1yRc+pzBap9J/Jld6XacHGf24b/DKzSZOJc0cffto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYAOVRNahlDl82lTbtbM6y/BxoodsMNewO6JGH2YHSkAIsTZ58LBr+/QiH+6yNpp6x6lT1tgvY0IyLigbKe4OcYxdQ9E0/AjoIYLBWsj7/15OqZevDTfFxiTgIpPysZJyhrcBS3KORKe7WVx3GHt87mt91KAVZHi5B2LNNmF0Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7Ce1zD7; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782453046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=llzLv6U3NajHrHb9ipH9po5+lkC7tqbJjW1uUPul6Qc=;
	b=P7Ce1zD73HA3dyoOaSTezOqccg79/IOAG2+Ig30JomSf3BjkI4ZsrKUbpGXKgvL2ZjotJy
	IlTA1mKzrPhjPzVXRVggJqw6A71onA/FKZj2RcmppLzkH3VTLXJCzLq5eBoIsT3fVh+ffQ
	UbvIZ9COU06wj2GLQ2ck2nTflvQuYto=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-ox-KTFp0NlqmCxplqAfEkw-1; Fri,
 26 Jun 2026 01:50:42 -0400
X-MC-Unique: ox-KTFp0NlqmCxplqAfEkw-1
X-Mimecast-MFC-AGG-ID: ox-KTFp0NlqmCxplqAfEkw_1782453040
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF6911954202;
	Fri, 26 Jun 2026 05:50:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1ACAB1956045;
	Fri, 26 Jun 2026 05:50:34 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: bhelgaas@google.com,
	alex@shazbot.org,
	mani@kernel.org
Cc: jjohnson@kernel.org,
	linux-pci@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	mhi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v11] PCI: Add device-specific reset for Qualcomm devices
Date: Fri, 26 Jun 2026 07:50:23 +0200
Message-ID: <20260626055023.197470-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-38110-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bhelgaas@google.com,m:alex@shazbot.org,m:mani@kernel.org,m:jjohnson@kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:mhi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:jtornosm@redhat.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5EE666CA80B

Some Qualcomm PCIe devices (WCN6855/WCN7850 WiFi cards, SDX62/SDX65 modems)
lack working reset methods for VFIO passthrough scenarios. These devices
have no FLR capability, advertise NoSoftRst+ (blocking PM reset), and have
broken bus reset.

The problem manifests in VFIO passthrough scenarios:

- WCN6855 (17cb:1103) and WCN7850 (17cb:1107) WiFi devices:
  Normal VM operation works fine, including clean shutdown/reboot.
  However, when the VM terminates uncleanly (crash, force-off), VFIO
  attempts to reset the device before it can be assigned to another VM.
  Without a working reset method, the device remains in an undefined state,
  preventing reuse.

- SDX62/SDX65 (17cb:0308) 5G modems: Never successfully initialize even
  on first VM assignment without proper reset capability.

Add device-specific reset methods using BAR-space hardware reset registers
that exist in these devices:

- WCN6855/WCN7850 WiFi devices use SoC global reset via BAR0 (sequence from
  ath11k/ath12k driver: ath11k_pci_soc_global_reset(), ath11k_pci_sw_reset(),
  ath11k_mhi_set_mhictrl_reset()):
  - Write/clear reset bit at offset 0x3008
  - Wait for PCIe link recovery (up to 5 seconds)
  - Clear MHI controller SYSERR status at offset 0x38

- SDX62/SDX65 modem devices use MHI SoC reset via BAR0 (sequence from MHI
  driver: mhi_soc_reset(), mhi_pci_reset_prepare()):
  - Write reset request to offset 0xb0
  - Wait 2 seconds for reset completion

These are true hardware reset mechanisms (not power management or firmware
error recovery), providing proper device reset for VFIO scenarios.

Testing was performed on desktop platforms with M.2 WiFi and modem cards
using M.2-to-PCIe adapters, including extensive force-reset cycling to
verify stability.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v11: Address Manivannan Sadhasivam feedback:
  - Remove unused QUALCOMM_WIFI_MHISTATUS define
  - Use PCI_ERROR_RESPONSE instead of 0xffffffff
  - Sort device IDs in ascending order (0x0308, 0x1103, 0x1107)
v10: https://lore.kernel.org/all/20260623183115.1585273-1-jtornosm@redhat.com/

 drivers/pci/quirks.c | 117 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 431c021d7414..0de606366200 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4240,6 +4240,120 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
 	return 0;
 }
 
+#define QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET	0x3008
+#define QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET_V	BIT(0)
+#define QUALCOMM_WIFI_MHICTRL			0x38
+#define QUALCOMM_WIFI_MHICTRL_RESET_MASK	0x2
+
+/*
+ * Qualcomm WiFi device-specific reset using SoC global reset via BAR0
+ * registers.
+ */
+static int reset_qualcomm_wifi(struct pci_dev *pdev, bool probe)
+{
+	bool link_recovered = false;
+	unsigned long timeout;
+	void __iomem *bar;
+	u32 val;
+	u16 cmd;
+
+	if (probe)
+		return 0;
+
+	if (pdev->current_state != PCI_D0)
+		return -EINVAL;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	pci_write_config_word(pdev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
+
+	bar = pci_iomap(pdev, 0, 0);
+	if (!bar) {
+		pci_write_config_word(pdev, PCI_COMMAND, cmd);
+		return -ENODEV;
+	}
+
+	val = ioread32(bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
+	val |= QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET_V;
+	iowrite32(val, bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
+	ioread32(bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
+
+	msleep(10);
+
+	val &= ~QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET_V;
+	iowrite32(val, bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
+	ioread32(bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
+
+	msleep(10);
+
+	timeout = jiffies + msecs_to_jiffies(5000);
+	while (time_before(jiffies, timeout)) {
+		val = ioread32(bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
+		if (val != PCI_ERROR_RESPONSE) {
+			link_recovered = true;
+			break;
+		}
+		msleep(20);
+	}
+
+	if (!link_recovered) {
+		pci_err(pdev, "PCIe link failed to recover after reset\n");
+		goto out_restore;
+	}
+
+	/* After SOC_GLOBAL_RESET, MHISTATUS may still have SYSERR bit set
+	 * and thus need to set MHICTRL_RESET to clear SYSERR.
+	 */
+	iowrite32(QUALCOMM_WIFI_MHICTRL_RESET_MASK, bar + QUALCOMM_WIFI_MHICTRL);
+	ioread32(bar + QUALCOMM_WIFI_MHICTRL);
+
+	msleep(10);
+
+out_restore:
+	pci_iounmap(pdev, bar);
+	pci_write_config_word(pdev, PCI_COMMAND, cmd);
+
+	return link_recovered ? 0 : -ETIMEDOUT;
+}
+
+#define MHI_SOC_RESET_REQ_OFFSET		0xb0
+#define MHI_SOC_RESET_REQ			BIT(0)
+
+/*
+ * Qualcomm modem device-specific reset using MHI SoC reset via BAR0
+ * register.
+ */
+static int reset_qualcomm_modem(struct pci_dev *pdev, bool probe)
+{
+	void __iomem *bar;
+	u16 cmd;
+
+	if (probe)
+		return 0;
+
+	if (pdev->current_state != PCI_D0)
+		return -EINVAL;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	pci_write_config_word(pdev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
+
+	bar = pci_iomap(pdev, 0, 0);
+	if (!bar) {
+		pci_write_config_word(pdev, PCI_COMMAND, cmd);
+		return -ENODEV;
+	}
+
+	iowrite32(MHI_SOC_RESET_REQ, bar + MHI_SOC_RESET_REQ_OFFSET);
+	ioread32(bar + MHI_SOC_RESET_REQ_OFFSET);
+
+	/* Be sure device reset has been executed */
+	msleep(2000);
+
+	pci_iounmap(pdev, bar);
+	pci_write_config_word(pdev, PCI_COMMAND, cmd);
+
+	return 0;
+}
+
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
 		 reset_intel_82599_sfp_virtfn },
@@ -4255,6 +4369,9 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 		reset_chelsio_generic_dev },
 	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
 		reset_hinic_vf_dev },
+	{ PCI_VENDOR_ID_QCOM, 0x0308, reset_qualcomm_modem }, /* SDX62/SDX65 modems */
+	{ PCI_VENDOR_ID_QCOM, 0x1103, reset_qualcomm_wifi },  /* WCN6855 WiFi */
+	{ PCI_VENDOR_ID_QCOM, 0x1107, reset_qualcomm_wifi },  /* WCN7850 WiFi */
 	{ 0 }
 };
 
-- 
2.54.0


