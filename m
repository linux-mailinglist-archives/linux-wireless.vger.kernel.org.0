Return-Path: <linux-wireless+bounces-37599-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jy65J2xDKGoJBQMAu9opvQ
	(envelope-from <linux-wireless+bounces-37599-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 18:46:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ACA6628D0
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 18:46:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=UfgRyfML;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37599-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37599-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23208314E103
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 16:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E7B480971;
	Tue,  9 Jun 2026 16:37:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7467A4968EC
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 16:37:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023043; cv=none; b=KnV1m/0DEstcks7cA+8gjyYL1bv5UlU/jb2ych+LLy21sjcd5qJ7kQ2HqJ+I8nXZYujsNiaAIiJTzEfCOFC46AERZo7hfDyeWCnftGo3BWyA9nT0C5S+J5KAf8ufThww6ha6iTHRSjmT5ZqGi/ndPZCLEE/nFwkYKK9oUjit95o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023043; c=relaxed/simple;
	bh=0wTKeOb06ZaMphGnMpC+zdYxMN997WDJ2AVnUhIwMmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBINO31tR4HATJ4IzIUASh4/88sfw8PdAurx+Z6C6kW1oFS+Jkn+t3ew2ksaDdCEw+i1KOE22ZbK8xg1DFE8KBDpyoQmaV7FKBmTCRp1x/Gqb5qfafrTXmV0uMu63rtgbFcBgBAuwipb+5DFHuKuAnXnP87vdsO0WhgMccigWFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UfgRyfML; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781023040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5nLA3FkcnPxyCfJB+DiY91GeWWHD23ZQy8CAC5DRV0=;
	b=UfgRyfMLydhfo93XbpXHY3a7tvIjCzptk/B72bqcBAp7IRKT5a9iNB/9458ZA4VOwIOozz
	UBa3Qa2sZ0LfbubAZ9wmdUKeYvT26bDkNc8zrpJcqtr1eR/riSnpsm3YfOXigY04ShYPKY
	mpyJivo763lmhBjCnTFOUKZpj/wjw0g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-71k7r_7FNfeWFs7mdfb05g-1; Tue,
 09 Jun 2026 12:37:16 -0400
X-MC-Unique: 71k7r_7FNfeWFs7mdfb05g-1
X-Mimecast-MFC-AGG-ID: 71k7r_7FNfeWFs7mdfb05g_1781023031
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E69FB184541F;
	Tue,  9 Jun 2026 16:37:10 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.77])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 843D31800662;
	Tue,  9 Jun 2026 16:37:07 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: bhelgaas@google.com,
	alex@shazbot.org
Cc: jjohnson@kernel.org,
	mani@kernel.org,
	linux-pci@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	mhi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v8 2/3] PCI: Add device-specific reset for Qualcomm devices
Date: Tue,  9 Jun 2026 18:36:48 +0200
Message-ID: <20260609163649.319755-3-jtornosm@redhat.com>
In-Reply-To: <20260609163649.319755-1-jtornosm@redhat.com>
References: <20260609163649.319755-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-37599-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bhelgaas@google.com,m:alex@shazbot.org,m:jjohnson@kernel.org,m:mani@kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:mhi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:jtornosm@redhat.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60ACA6628D0

Some Qualcomm PCIe devices (WCN6855/WCN7850 WiFi cards, SDX62/SDX65 modems)
lack working reset methods for VFIO passthrough scenarios. These devices
have no FLR capability, advertise NoSoftRst+ (blocking PM reset), and have
broken bus reset.

The problem manifests in VFIO passthrough scenarios:

- WCN6855 WiFi card (17cb:1103): Normal VM operation works fine, including
  clean shutdown/reboot. However, when the VM terminates uncleanly
  (crash, force-off), VFIO attempts to reset the device before it can
  be assigned to another VM. Without a working reset method, the device
  remains in an undefined state, preventing reuse.

- WCN7850 WiFi card (17cb:1107): Same behavior as WCN6855.

- SDX62/SDX65 5G modems (17cb:0308): Never successfully initialize even
  on first VM assignment without proper reset capability.

Add device-specific reset entries for these Qualcomm devices using D3cold
power cycling with automatic D3hot fallback. The implementation uses
pci_set_power_state(D3cold) which automatically falls back to D3hot on
platforms without ACPI _PR3 power resources. While not a complete reset
(BARs preserved), testing shows D3hot transition provides sufficient reset
for VFIO reuse.

Extract a shared pci_dev_d3cold_d0_cycle() helper function to avoid code
duplication between pci_d3cold_reset() (strict _PR3 requirement) and the
new reset_d3cold_d3hot() device-specific reset (automatic fallback).
The helper performs only the power cycle; IOMMU handling is done by the
caller (pci_d3cold_reset() for general method, __pci_dev_specific_reset()
wrapper for device-specific methods).

Device-specific reset is position #1 in the reset hierarchy, so these
Qualcomm devices will use power cycling as their primary reset method,
with the general d3cold method (position #8) available as a fallback on
_PR3-capable platforms if users override via sysfs.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v8: Fix commit message: correct IOMMU handling description. The helper
    performs only the power cycle; IOMMU is handled by callers (this was
    v6 fix)
v7: https://lore.kernel.org/all/20260603105853.326290-3-jtornosm@redhat.com/

 drivers/pci/pci.c    | 37 +++++++++++++++++++++++++++----------
 drivers/pci/pci.h    |  1 +
 drivers/pci/quirks.c | 19 +++++++++++++++++++
 3 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 096868f80cd4..f7a7443287fd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4491,6 +4491,32 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	return ret;
 }
 
+/**
+ * pci_dev_d3cold_d0_cycle - Perform D3cold->D0 power cycle
+ * @dev: Device to power cycle
+ *
+ * Common helper to perform D3cold->D0 power cycle for reset methods.
+ * Attempts D3cold transition with automatic fallback to D3hot on platforms
+ * without ACPI _PR3 power resources.
+ *
+ * Caller must handle IOMMU preparation/cleanup if needed.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+int pci_dev_d3cold_d0_cycle(struct pci_dev *dev)
+{
+	int ret;
+
+	if (dev->current_state != PCI_D0)
+		return -EINVAL;
+
+	ret = pci_set_power_state(dev, PCI_D3cold);
+	if (ret)
+		return ret;
+
+	return pci_set_power_state(dev, PCI_D0);
+}
+
 /**
  * pci_d3cold_reset - Put device into D3cold and back to D0 for reset
  * @dev: PCI device to reset
@@ -4520,22 +4546,13 @@ static int pci_d3cold_reset(struct pci_dev *dev, bool probe)
 	if (probe)
 		return 0;
 
-	if (dev->current_state != PCI_D0)
-		return -EINVAL;
-
 	ret = pci_dev_reset_iommu_prepare(dev);
 	if (ret) {
 		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
 		return ret;
 	}
 
-	ret = pci_set_power_state(dev, PCI_D3cold);
-	if (ret)
-		goto done;
-
-	ret = pci_set_power_state(dev, PCI_D0);
-
-done:
+	ret = pci_dev_d3cold_d0_cycle(dev);
 	pci_dev_reset_iommu_done(dev);
 	return ret;
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a..a9942787de9e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -234,6 +234,7 @@ void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
 int pci_try_reset_bridge(struct pci_dev *bridge);
+int pci_dev_d3cold_d0_cycle(struct pci_dev *dev);
 
 struct pci_cap_saved_data {
 	u16		cap_nr;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e49136ac5dbf..70f3b0f26799 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4237,6 +4237,22 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
 	return 0;
 }
 
+/*
+ * Device-specific reset method via D3cold/D3hot power cycle.
+ *
+ * Some devices lack working FLR, advertise NoSoftRst+ (blocking PM reset),
+ * and have broken bus reset. This function provides device-specific reset via
+ * power cycling, attempting D3cold with automatic fallback to D3hot on platforms
+ * without ACPI _PR3 power resources.
+ */
+static int reset_d3cold_d3hot(struct pci_dev *dev, bool probe)
+{
+	if (probe)
+		return 0;
+
+	return pci_dev_d3cold_d0_cycle(dev);
+}
+
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
 		 reset_intel_82599_sfp_virtfn },
@@ -4252,6 +4268,9 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 		reset_chelsio_generic_dev },
 	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
 		reset_hinic_vf_dev },
+	{ PCI_VENDOR_ID_QCOM, 0x1103, reset_d3cold_d3hot },  /* WCN6855 */
+	{ PCI_VENDOR_ID_QCOM, 0x1107, reset_d3cold_d3hot },  /* WCN7850 */
+	{ PCI_VENDOR_ID_QCOM, 0x0308, reset_d3cold_d3hot },  /* SDX62/SDX65 */
 	{ 0 }
 };
 
-- 
2.54.0


