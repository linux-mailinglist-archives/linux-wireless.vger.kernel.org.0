Return-Path: <linux-wireless+bounces-33270-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMnEBr1/t2kmRwEAu9opvQ
	(envelope-from <linux-wireless+bounces-33270-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 04:57:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7331C294808
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 04:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CA3C3011C4B
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 03:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E35217A309;
	Mon, 16 Mar 2026 03:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Hb7rVL1a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115543242AC
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 03:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773633412; cv=none; b=Ke+POdVoB4NJ7VESnzYykqjtWTbBSZDX6zyzdRUXcBjZM6Q6ZQGiLYzJe0lcZCtxkJiavCpZbUaaUrYV7YNaIjdVxYt657LoJaq/QXl5olWpgrT8SKtoaLRWNhSHq5teWVkQwOucggKaTOmQqYxV+yCtXSr+lynxRqO8yff/vPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773633412; c=relaxed/simple;
	bh=cVOlr1WZTqYAanvLP4mFiLkWXv82DSMTV2Z4XIdnqeg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YlozAt2ZWRTyf85z2HpRuaBme3CnDgS+4kzLOfb/qxKx5AFu9mU9g096kWgBzA1bSfGW70nj9xmTWjYGgJapYvoza7Qd5cs4kIxaIseRF4O1Wz2hewNpiKIkJ9SEyq8FsgRtB85F2wEuvZMqATtieDUw+JmtpQET45u1nO/fvVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Hb7rVL1a; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62G3ujqmF1174255, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773633406; bh=c+qv+lseoBOXDQWgIyrQZuDVh4Vgy/bBPuZ0guOhltI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Hb7rVL1ahhQHxCab3nmb+tF1ttmz0g2OBEYTqeDjir7vZGs1yrAtXkh/sEHjxcSyr
	 BDWNza797mCJCvdMAuvYVIlAQ3RhX/uqiD+SbS96dm5poiOAvXa1yb5W/gNFh8kX/Y
	 ivFChvdWyckEOwD+qZCutqCNCjqMLe0bTqfrO1rFrTDkkwavlO0j7sEzXoGILqvrzt
	 Nq8aTRwxoXUObfXVspX85OogMKWUgAfFBSytRzwGzxiug216tEmEIu9X5uINWZ+BM6
	 R9PY4528Do1zcfcnGz8/b0EuqtiADJyfzaDofPTuYh3RZiSthx/R81F/FiOnBMkt92
	 SFXaGkxr7DIXw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62G3ujqmF1174255
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 11:56:46 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Mar 2026 11:56:46 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 16 Mar 2026 11:56:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <goainwo@gmail.com>
Subject: [PATCH rtw-next] wifi: rtw88: add quirks to disable PCI ASPM and deep LPS for HP P3S95EA#ACB
Date: Mon, 16 Mar 2026 11:56:35 +0800
Message-ID: <20260316035635.16550-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
	TAGGED_FROM(0.00)[bounces-33270-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7331C294808
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On an HP laptop (P3S95EA#ACB) equipped with a Realtek RTL8821CE 802.11ac
PCIe adapter (PCI ID: 10ec:c821), the system experiences a hard lockup
(complete freeze of the UI and kernel, sysrq doesn't work, requires
holding the power button) when the WiFi adapter enters the power
saving state. Disable PCI ASPM to avoid system freeze.

In addition, driver throws messages periodically. Though this doesn't
always cause unstable connection, missing H2C commands might cause
unpredictable results. Disable deep LPS to avoid this as well.

 rtw88_8821ce 0000:13:00.0: firmware failed to leave lps state
 rtw88_8821ce 0000:13:00.0: failed to send h2c command
 rtw88_8821ce 0000:13:00.0: failed to send h2c command

Reported-by: Oleksandr Havrylov <goainwo@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com/
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.h |  5 ++++
 drivers/net/wireless/realtek/rtw88/pci.c  | 31 +++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 1179231a672d..9c0b746540b0 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -432,6 +432,11 @@ enum rtw_wow_flags {
 	RTW_WOW_FLAG_MAX,
 };
 
+enum rtw_quirk_dis_caps {
+	QUIRK_DIS_CAP_PCI_ASPM,
+	QUIRK_DIS_CAP_LPS_DEEP,
+};
+
 /* the power index is represented by differences, which cck-1s & ht40-1s are
  * the base values, so for 1s's differences, there are only ht20 & ofdm
  */
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index ec0a45bfb670..bba370ad510c 100644
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
 
+static int rtw_pci_disable_caps(const struct dmi_system_id *dmi)
+{
+	uintptr_t dis_caps = (uintptr_t)dmi->driver_data;
+
+	if (dis_caps & BIT(QUIRK_DIS_CAP_PCI_ASPM))
+		rtw_pci_disable_aspm = true;
+
+	if (dis_caps & BIT(QUIRK_DIS_CAP_LPS_DEEP))
+		rtw_disable_lps_deep_mode = true;
+
+	return 1;
+}
+
+static const struct dmi_system_id rtw_pci_quirks[] = {
+	{
+		.callback = rtw_pci_disable_caps,
+		.ident = "HP Notebook - P3S95EA#ACB",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Notebook"),
+			DMI_MATCH(DMI_PRODUCT_SKU, "P3S95EA#ACB"),
+		},
+		.driver_data = (void *)(BIT(QUIRK_DIS_CAP_PCI_ASPM) |
+					BIT(QUIRK_DIS_CAP_LPS_DEEP)),
+	},
+	{}
+};
+
 int rtw_pci_probe(struct pci_dev *pdev,
 		  const struct pci_device_id *id)
 {
@@ -1771,6 +1800,8 @@ int rtw_pci_probe(struct pci_dev *pdev,
 	rtwpci = (struct rtw_pci *)rtwdev->priv;
 	atomic_set(&rtwpci->link_usage, 1);
 
+	dmi_check_system(rtw_pci_quirks);
+
 	ret = rtw_core_init(rtwdev);
 	if (ret)
 		goto err_release_hw;

base-commit: 039cd522dc70151da13329a5e3ae19b1736f468a
-- 
2.25.1


