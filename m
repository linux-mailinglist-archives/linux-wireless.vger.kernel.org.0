Return-Path: <linux-wireless+bounces-26282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7097B219E2
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 02:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87DF01A23848
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 00:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF092D46C7;
	Tue, 12 Aug 2025 00:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pMIM4bkK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFACA1DDA1E
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 00:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754959454; cv=none; b=JzWoASH6kjiyMBlHbQI1EAbUaOaY9QrnoavJo/aBKRwirMcLGqLwJ6Yc4XKEgLv1VJhjPFvL1Tkci6233c3hvvSTce5BZiezusHWg+MHXk1SODjLUWWK6LyzUm/f0Hk38TtFs5fHH+aJg8vxH3Pa9KSKoc2MX8+hA9KvApGiZxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754959454; c=relaxed/simple;
	bh=68fy49gO8Z/tkyWyDmhjFcEhG+9uq+yQERuCgIVPMvw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=czPGsXd8xWgqWJUhUGf7Hds1L21b8Kq57DbZvyokdzqocmSDmpH58H238oHA/cyK3GWtPJmBSTrhGNMe6ae1WqmaSefQlvmwXJ9lNnqD1QuG+F9tarYpbY4W0iQSzN8RxaojyoVpLQNZfFCYXyAt9SzYw/wsQyZqYR2VVpknIOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pMIM4bkK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57C0i8edD1223540, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754959448; bh=FctmNRIR6QWuJYGYDYtPmzFvQPRRrsXt0CPs3hmrYb4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=pMIM4bkKLVeqKgqe5IxngzXP9ceTYRRUk5jDH3yFvgB1h5ABCZ7ep1f6msql5wj76
	 3X7N7HohgXN3Pt7cQyWFrU07xqDsWxdN5z0b7rAQmzBWH6PtTItdON0W/zoXqba9w9
	 cGCrkyAYdEUyUZ0nNgWxyKhKK9HF4aYaKqQl3rUzuiZIXknzgHH7gL6bup0qeYH5c9
	 dubQ384EkVvvqajZnAk+avfhJ8CrfMeDe+uv5we8aOX+Mni1/RtoJ5xjt0YseNjm99
	 jUsfh1LoLMIDEtVfG9zPdIcEdrpMjV+BKyYbAj3wlQL2hlxCdaPmhiAD01cLLJF+gt
	 CR8DVTH8TUukA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57C0i8edD1223540
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 08:44:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Aug 2025 08:44:09 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 12 Aug
 2025 08:44:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <wojcikmarcin49@gmail.com>
Subject: [PATCH rtw-next] wifi: rtw89: 8852be: disable PCI D3Cold by quirk for certain platform
Date: Tue, 12 Aug 2025 08:43:26 +0800
Message-ID: <20250812004326.8582-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

On a platform, RTL8852BE gets lost from suspending, and kernel throws

  Unable to change power state from D3cold to D0, device inaccessible

then driver throws

  0000:39:00.0: failed to write DBI register, addr=0xB48
  0000:39:00.0: failed to write DBI register, addr=0xB48
  0000:39:00.0: failed to read PCI cap, ret=134
  0000:39:00.0: xtal si not ready(W): offset=90 val=10 mask=10
  0000:39:00.0: mac init fail, ret:-110

An solution is to disable d3cold via sysfs to write 1 to

  /sys/bus/pci/devices/0000:39:00.0/d3cold_allowed

Since it's hard to measure hardware signals to find cause, add a quirk to
disable d3cold for the platform.

Reported-by: Marcin Wojcik <wojcikmarcin49@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/CAE3x6Qi8Nku26B4aWE+jtJmHb=hO8C743_myNrrBzUAGyuUw9A@mail.gmail.com/
Closes: https://github.com/morrownr/rtw89/issues/18
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h      |  1 +
 drivers/net/wireless/realtek/rtw89/pci.c       |  3 +++
 drivers/net/wireless/realtek/rtw89/rtw8852be.c | 14 +++++++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 43e10278e14d..39085c9589da 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5028,6 +5028,7 @@ enum rtw89_flags {
 
 enum rtw89_quirks {
 	RTW89_QUIRK_PCI_BER,
+	RTW89_QUIRK_PCI_NO_D3COLD,
 	RTW89_QUIRK_THERMAL_PROT_120C,
 	RTW89_QUIRK_THERMAL_PROT_110C,
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index a669f2f843aa..c9b93191805d 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3060,6 +3060,9 @@ static int rtw89_pci_claim_device(struct rtw89_dev *rtwdev,
 	pci_set_master(pdev);
 	pci_set_drvdata(pdev, rtwdev->hw);
 
+	if (test_bit(RTW89_QUIRK_PCI_NO_D3COLD, rtwdev->quirks))
+		pci_d3cold_disable(pdev);
+
 	rtwpci->pdev = pdev;
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index b0726f590ca2..ea6c129a3422 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -65,10 +65,22 @@ static const struct rtw89_pci_info rtw8852b_pci_info = {
 	.ssid_quirks		= NULL,
 };
 
+static const struct dmi_system_id rtw8852b_pci_quirks[] = {
+	{
+		.ident = "ASUS TUF Gaming F16 FX607VUR_FX607VU",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ASUS TUF Gaming F16 FX607VUR_FX607VU"),
+		},
+		.driver_data = (void *)RTW89_QUIRK_PCI_NO_D3COLD,
+	},
+	{},
+};
+
 static const struct rtw89_driver_info rtw89_8852be_info = {
 	.chip = &rtw8852b_chip_info,
 	.variant = NULL,
-	.quirks = NULL,
+	.quirks = rtw8852b_pci_quirks,
 	.bus = {
 		.pci = &rtw8852b_pci_info,
 	},
-- 
2.25.1


