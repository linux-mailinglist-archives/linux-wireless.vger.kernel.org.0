Return-Path: <linux-wireless+bounces-31045-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPLrBVy8cGkRZgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31045-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 12:45:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF13F5631F
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 12:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 01D9F6840D1
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 11:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14A43D5226;
	Wed, 21 Jan 2026 11:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="e/Y1DREZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A7B39900A;
	Wed, 21 Jan 2026 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768995594; cv=pass; b=PnLe70QDWVxuN8Y+EY3O9V6tNaIZKfAyNZUv9rWNPpfwYyaN+RGoooXhQtknWloW52zhXoPl8B2UG8KN21/DkV5BWvdg0qGlevHX8U9GM38eYIfz1Q24ALAH1wCn0odE+geS8VBtTxB3EPJLZ6pVi0uqxqNmabwgyGCo/b7oxo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768995594; c=relaxed/simple;
	bh=xSMHRexFKeGh+mCT8QAgPgvwg0bxy4Ohw1W3+YU7KX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WrdLzq0Oexp44pxL5OBadToSnwhDGmvycBY409HwQ5GfCSATjHnNOxOg7r1rTwCAkK8UItK7DkxN0b426nPqf5d9XLIQrsjTvNsd0m7JHiBzCReFAMaSFS0YE+1t43l/4ml58pX9Rwy/5/6XJ2LKLiwHPvPJMAI8bQcFPwNJalA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=e/Y1DREZ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1768995589; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=H7H6Ah3/zE4TNztXQzljOnw86J0RbsaNXZv6a7PARHkXtbyrcWw+PuGY6zGkB5dpic8qPA33HG4iwwLBMlcoHYCiTjBd00RmGOcyMVNRlnKu7URLaLTDatS+oNEM1c/wVJO6t80VptuaW8MVxrB2USij9eE0307zRIlX0y7IJR8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768995589; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8ke4xCVLQr8AOgPjzVSn9L6BhtzqTx5uuv9e/xsHD7k=; 
	b=lxkZxJFWPBeAnNOLmMaSjXNvT5j0Z8JHStwVRRsMSHnHAFig8yyPh/peDeLD2yNbH2GuqoFG6d3Wl7uNkMajb6JW/iggwTCdcG1SApbSbhNeuM83n5SMpGUachvWdlvz2ZKpyKalANEgBiq0d7yag+6pH99PahynmglC0ATKB2Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768995589;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8ke4xCVLQr8AOgPjzVSn9L6BhtzqTx5uuv9e/xsHD7k=;
	b=e/Y1DREZyFZR3KRaTk5B3njCpIka8c3ykuRD+a5ANg1mOaQY8yd4AGUloSoloCrL
	1e9Wk5PYQxyFP3mWbaVWgqffOsf5cycS7fKMAUHJIiovvjWjfJmQ+zjzye8wfU/KysV
	xGQo1jirA0kIHQ2O9wP6BpCf4nApjrVHKjpjhJoA=
Received: by mx.zohomail.com with SMTPS id 176899558724093.76415336325874;
	Wed, 21 Jan 2026 03:39:47 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [PATCH v2] iwlwifi: pcie: support shutdown operation
Date: Wed, 21 Jan 2026 19:39:38 +0800
Message-ID: <20260121113940.113145-1-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-wireless@vger.kernel.org];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux.beauty];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-31045-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.beauty:+]
X-Rspamd-Queue-Id: AF13F5631F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Kexec reboot does not reset PCI devices. If iwlwifi is left running,
the next kernel can time out during probe, breaking networking after
kexec:
kernel: iwlwifi 0000:06:00.0: Host monitor block 0x22 vector 0x0
kernel: iwlwifi 0000:06:00.0: value [iter 0]: 0x00000000
kernel: iwlwifi 0000:06:00.0: probe with driver iwlwifi failed with error -110

Register a dedicated PCI shutdown callback:
run the normal teardown path and then disable the PCI function and
transition it to D3hot so the next kernel can re-initialize it reliably.

Signed-off-by: Li Chen <me@linux.beauty>
---
Changes in v2:
- Don't reuse the ->remove callback for shutdown.
- Disable the PCI function and set D3hot after teardown.

 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index dc99e7ac4726..e950aab5a39d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1192,6 +1192,21 @@ static void iwl_pci_remove(struct pci_dev *pdev)
 	iwl_pcie_gen1_2_remove(trans);
 }
 
+static void iwl_pci_shutdown(struct pci_dev *pdev)
+{
+	struct iwl_trans *trans = pci_get_drvdata(pdev);
+
+	if (trans) {
+		iwl_pcie_gen1_2_remove(trans);
+		pci_set_drvdata(pdev, NULL);
+	}
+
+	pci_save_state(pdev);
+	pci_clear_master(pdev);
+	pci_disable_device(pdev);
+	pci_set_power_state(pdev, PCI_D3hot);
+}
+
 #ifdef CONFIG_PM_SLEEP
 
 static int iwl_pci_suspend(struct device *device)
@@ -1325,6 +1340,7 @@ static struct pci_driver iwl_pci_driver = {
 	.id_table = iwl_hw_card_ids,
 	.probe = iwl_pci_probe,
 	.remove = iwl_pci_remove,
+	.shutdown = iwl_pci_shutdown,
 	.driver.pm = IWL_PM_OPS,
 	.driver.coredump = iwl_pci_dump,
 };
-- 
2.52.0


