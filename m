Return-Path: <linux-wireless+bounces-23561-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E052ACC97A
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 16:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2F216E651
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 14:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9864122A4E8;
	Tue,  3 Jun 2025 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="jDaMGMh8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4172B23A578;
	Tue,  3 Jun 2025 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748961994; cv=none; b=QfY4a95ILtDYh0lZnuvQbEejvbNEnovw7xtFPgmnWez56O5RaojNrApO1BPDcMbeIluwmzwG3IA+sc4IOCdGg7ekQC+iPdh6aKSVRTowdfPO90J9xomZAk14gSYYuQmlvzIZsXAGHZC+6Dds4eXXj6zRzYolz8XGdBmmtKg+jIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748961994; c=relaxed/simple;
	bh=9OzLM+RZP9khYjgnGJg+Qru9hD/2Zxsf8cJFIPbEpJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WOTYrCo+vPAz3cgLRAIg0+JS6cIPNfmhfJg9aa+cJr+I6eJQMZjM3zy77IVaWkzk7l1bRy9TDiwpsGZ1zasnrOqy5HUZMG4XWYJLtypPzZy65NMm9EXtq6C1AS4MjXOFNlkd3x2FNgteCFtwuTfdjEjUSYA1bmbMU5KpiKHkylc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=jDaMGMh8; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.12])
	by mail.ispras.ru (Postfix) with ESMTPSA id 653BD4076189;
	Tue,  3 Jun 2025 14:46:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 653BD4076189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1748961982;
	bh=NJ+5hBLio2Q6E2yy/CS8mYnMUfTtOgpeRZxk4jwaFoY=;
	h=From:To:Cc:Subject:Date:From;
	b=jDaMGMh8vGLnUVEnOc/JFHN0loRF3e0IO4Q3KZHcpadW70aZ6afHdRH1SGRzTguhI
	 MtY2ol27PdOlvxqpzhUeh/sV3+Ky6Se/+5CsGw0d1HRvHQ5MknPwDPPIVY2X3UyyHd
	 jrtUk37wDDdqooxZ4Tc1I+9cZyV+6MlwPLIMb5FY=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next] wifi: rtw89: sar: drop wiphy lock assertion in rtw89_set_sar_from_acpi
Date: Tue,  3 Jun 2025 17:46:13 +0300
Message-ID: <20250603144614.175003-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following assertion is triggered on the rtw89 driver startup. It
looks meaningless to hold wiphy lock on an early init stage, nothing
should interfere. Besides, as rtw89_set_sar_from_acpi() is called only at
that place, so drop the assertion.

 WARNING: CPU: 7 PID: 629 at drivers/net/wireless/realtek/rtw89/sar.c:502 rtw89_set_sar_from_acpi+0x365/0x4d0 [rtw89_core]
 CPU: 7 UID: 0 PID: 629 Comm: (udev-worker) Not tainted 6.15.0+ #29 PREEMPT(lazy)
 Hardware name: LENOVO 21D0/LNVNB161216, BIOS J6CN50WW 09/27/2024
 RIP: 0010:rtw89_set_sar_from_acpi+0x365/0x4d0 [rtw89_core]
 Call Trace:
  <TASK>
  rtw89_sar_init+0x68/0x2c0 [rtw89_core]
  rtw89_core_init+0x188e/0x1e50 [rtw89_core]
  rtw89_pci_probe+0x530/0xb50 [rtw89_pci]
  local_pci_probe+0xd9/0x190
  pci_call_probe+0x183/0x540
  pci_device_probe+0x171/0x2c0
  really_probe+0x1e1/0x890
  __driver_probe_device+0x18c/0x390
  driver_probe_device+0x4a/0x120
  __driver_attach+0x1a0/0x530
  bus_for_each_dev+0x10b/0x190
  bus_add_driver+0x2eb/0x540
  driver_register+0x1a3/0x3a0
  do_one_initcall+0xd5/0x450
  do_init_module+0x2cc/0x8f0
  init_module_from_file+0xe1/0x150
  idempotent_init_module+0x226/0x760
  __x64_sys_finit_module+0xcd/0x150
  do_syscall_64+0x94/0x380
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Found by Linux Verification Center (linuxtesting.org).

Fixes: 88ca3107d2ce ("wifi: rtw89: sar: add skeleton for SAR configuration via ACPI")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/wireless/realtek/rtw89/sar.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index 517b66022f18..33a4b5c23fe7 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -499,8 +499,6 @@ static void rtw89_set_sar_from_acpi(struct rtw89_dev *rtwdev)
 	struct rtw89_sar_cfg_acpi *cfg;
 	int ret;
 
-	lockdep_assert_wiphy(rtwdev->hw->wiphy);
-
 	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
 	if (!cfg)
 		return;
-- 
2.49.0


