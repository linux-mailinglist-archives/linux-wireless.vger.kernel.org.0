Return-Path: <linux-wireless+bounces-37340-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0MRxOtoLIGrquwAAu9opvQ
	(envelope-from <linux-wireless+bounces-37340-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 13:11:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECA2636DE4
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 13:11:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Q5s0Ubsg;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37340-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37340-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C4013106C31
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 11:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8750E46AECC;
	Wed,  3 Jun 2026 10:59:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2186D466B70
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2026 10:59:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484362; cv=none; b=h3pW4Ziz1vYM9K456zKj6hb23OvY8nC5apYqkQqsB2vGk7TuKXQgX91QoqcTiRPFAFp1fdHLxF8396t+scQXupTaHa/HxRdM9/6iEG6vViJdcXyj6yIbCBWyDhR5s/zoH8rNN47j9rE8pWWgMVQuhbq6VI9xkLMIcaGrJYGUhA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484362; c=relaxed/simple;
	bh=gH0eWHwVZAReFFR22R8EP7TA9dxGDnRYzOdi3ro3KQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4tASfGQN/LYOtFhrI5GZAmeFN0OYrTX6EEJvRpmeovDNtUrWwYxvdKQDRTIBQBKxYZ+vk9mKMR/+DIeEtZm/qBRWcyF7EkRZzJUI7lFbMT/V99u4kfShnh5kwm8TV+EGt9aShZhENK2FtDT0QItJniJv9AzVrIU1KX9tjdrtzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5s0Ubsg; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780484360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jkKgSZKbs0xLT6aF382KOTk5j9dcLvy/bEt1kDc5Ik4=;
	b=Q5s0UbsgxYYEnE6Kcf7viWcbsEQbf1YaUbb2stE0jLjXrfXS9swyiTqMneEJ0aeTyRxMlT
	+qZSH77tQ2YiIx1SmSFHi8jbLfwKpZFy2kdznieGoVT5vd1tf6i+X/nvSgLS5PVXzQMigm
	6+5gHxk1Tx0qKwJDt+sJxVSQBP/Jpy4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-56ind7lZMZCMooqSRig8uA-1; Wed,
 03 Jun 2026 06:59:17 -0400
X-MC-Unique: 56ind7lZMZCMooqSRig8uA-1
X-Mimecast-MFC-AGG-ID: 56ind7lZMZCMooqSRig8uA_1780484355
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57F11195608E;
	Wed,  3 Jun 2026 10:59:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7DD4A1956095;
	Wed,  3 Jun 2026 10:59:10 +0000 (UTC)
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
Subject: [PATCH v6 2/3] PCI: Add device-specific reset for Qualcomm devices
Date: Wed,  3 Jun 2026 12:58:52 +0200
Message-ID: <20260603105853.326290-3-jtornosm@redhat.com>
In-Reply-To: <20260603105853.326290-1-jtornosm@redhat.com>
References: <20260603105853.326290-1-jtornosm@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-37340-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bhelgaas@google.com,m:alex@shazbot.org,m:jjohnson@kernel.org,m:mani@kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:mhi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:jtornosm@redhat.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3ECA2636DE4

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
new reset_d3cold_d3hot() device-specific reset (automaticfallback). The
helper handles IOMMU preparation, performs the power cycle via
pci_set_power_state(), and cleans up IOMMU state.

Device-specific reset is position #1 in the reset hierarchy, so these
Qualcomm devices will use power cycling as their primary reset method,
with the general d3cold method (position #8) available as a fallback on
_PR3-capable platforms if users override via sysfs.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v7: Address the comments from Jeff Johnson: the problem was detected for
    the specific devices WCN6855 and WCN7850, use the name of the devices
    instead of the related drivers ath11k and ath12k, which support a large
    number of devices
v6: https://lore.kernel.org/all/20260602160024.1171949-3-jtornosm@redhat.com/

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


