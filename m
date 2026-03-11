Return-Path: <linux-wireless+bounces-32941-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJRTI8rPsGmznQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32941-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 03:13:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4CA25AC60
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 03:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D454030238E6
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 02:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B680314B72;
	Wed, 11 Mar 2026 02:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="qZCc8qaG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF0F1EEE6
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 02:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194909; cv=none; b=LZemRdVDUDmcreiTq63oEBE9OgqtRR5MczANIbACgyxUBuxb6k3qvJrukxVPWKo6l/OoV55H5m/HtUJvzyVdLnzlrWE2oupyvAP66+Xxu8GaDqxlb7T1sLKeynTuqX2M9fP8wVU4Pz9t6Qnw90M4OpKfYWIQYA6YkAQiwDvVGOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194909; c=relaxed/simple;
	bh=tMI0t3aoAC6b+oW2ysqLvf96MJ65teVFWTnsn6LI6lU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=itV5/TGGL4O1edMg5y58kht9NlRmt019CgiilJGNfSRtfuBKHLZc5UoN9c8kHkaC9JVZmb7ffoc8ebbU7L50+KK+o2DFLdoZ7YG2A4qe6Tznz1UR+7KKzNtloUF/8aa4trl9hZXzvY0LEsnmR31lvPRqsx2ktX99gsU8Jq6qd7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=qZCc8qaG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62B28O7U03703575, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773194904; bh=enx2SIbzfDkxi7i/xutQanQ2TZXUsxSDlNpxCyOuZtw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=qZCc8qaGsaRj+Aw484hCuOLzEU+kd92y7l+50+WRjPWRBqOePrZc8ejIMRSrbaGID
	 3LwV3VfHEKycpI8NfqxA7ilk9N7GE05XAN31DbqJVviYhIvOq2/CzCyrlEASOEvTjf
	 qcuTIUBBaw85zcntk+OQxjUWyA4PsceUfboTc082aLRdPhT5LXKeBVnXblOq9g1Ub6
	 bwKjXRATjEqSuuBR+kExixD+yDulSE87czMg5KtjNaJUXuFXR4GkvVL74cy7HdX/PM
	 EBPm3IJAmcT6+AqqXf0tM4ZksK4LIDZHE15iaWwzFO207OKtOrlpeOORXbW6bbJFAJ
	 rJmQYMRpSjOYA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62B28O7U03703575
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 10:08:24 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 11 Mar 2026 10:08:23 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 11 Mar 2026 10:08:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <goainwo@gmail.com>
Subject: [RFT rtw-next] wifi: rtw88: add quirks to disable PCI ASPM for HP P3S95EA#ACB
Date: Wed, 11 Mar 2026 10:08:16 +0800
Message-ID: <20260311020816.7065-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: DE4CA25AC60
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32941-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On an HP laptop (P3S95EA#ACB) equipped with a Realtek RTL8821CE 802.11ac
PCIe adapter (PCI ID: 10ec:c821), the system experiences a hard lockup
(complete freeze of the UI and kernel, sysrq doesn't work, requires
holding the power button) when the WiFi adapter enters the power
saving state.

Add a quirk to disable ASPM.

Reported-by: LB F <goainwo@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com/
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index ec0a45bfb670..0b60a0ce96a1 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2018-2019  Realtek Corporation
  */
 
+#include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include "main.h"
@@ -1744,6 +1745,34 @@ const struct pci_error_handlers rtw_pci_err_handler = {
 };
 EXPORT_SYMBOL(rtw_pci_err_handler);
 
+enum rtw88_quirk_dis_pci_caps {
+	QUIRK_DIS_PCI_CAP_ASPM,
+};
+
+static int disable_pci_caps(const struct dmi_system_id *dmi)
+{
+	uintptr_t dis_caps = (uintptr_t)dmi->driver_data;
+
+	if (dis_caps & BIT(QUIRK_DIS_PCI_CAP_ASPM))
+		rtw_pci_disable_aspm = true;
+
+	return 1;
+}
+
+static const struct dmi_system_id rtw88_pci_quirks[] = {
+	{
+		.callback = disable_pci_caps,
+		.ident = "HP Notebook - P3S95EA#ACB",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Notebook"),
+			DMI_MATCH(DMI_PRODUCT_SKU, "P3S95EA#ACB"),
+		},
+		.driver_data = (void *)BIT(QUIRK_DIS_PCI_CAP_ASPM),
+	},
+	{}
+};
+
 int rtw_pci_probe(struct pci_dev *pdev,
 		  const struct pci_device_id *id)
 {
@@ -1808,6 +1837,7 @@ int rtw_pci_probe(struct pci_dev *pdev,
 	    bridge && bridge->vendor == PCI_VENDOR_ID_INTEL)
 		rtwpci->rx_no_aspm = true;
 
+	dmi_check_system(rtw88_pci_quirks);
 	rtw_pci_phy_cfg(rtwdev);
 
 	ret = rtw_register_hw(rtwdev, hw);
-- 
2.25.1


