Return-Path: <linux-wireless+bounces-23716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B816FACE1FE
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 18:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E9E3A434B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 16:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045881DDA34;
	Wed,  4 Jun 2025 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="PgC3zLsc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9398D1DB34B;
	Wed,  4 Jun 2025 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749053636; cv=none; b=npvp1gHp6vA7LW0102uejCSrSToUO+ZMxHnpdkLrLn/gWYitRGvIaImlpPacHjW4qT/6TpDc+TjIE4XXSCPoAVe171+nctDhyYF8Cnro8XPQ2MfDn3xgsYFB91jG5s8kffsPzT+s8XHufjfWsMbLvNGWFlP9tjWv/W0HK/nyhVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749053636; c=relaxed/simple;
	bh=gT9GBvOSDzBhGo5mZNNkNzJ98TDzw354ctI3xOd57PA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HUNZhjkneOsRYbwFeNcv/x/O+ooM3YlQB2BXWwIAVe+DoTnOYHAm6sUaHwrG4xOxbaMgTUUFeoG/h8/rIY4PHJkC0/ptYDQhxMBHQOhnsraJqmT8DpTbl7V/2u8by5izO+QLtoh2UM8lyP52ooYeZCYwN/aRPOvbE/a6CVmcOTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=PgC3zLsc; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.17])
	by mail.ispras.ru (Postfix) with ESMTPSA id 3DDB0407618E;
	Wed,  4 Jun 2025 16:13:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3DDB0407618E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1749053632;
	bh=nkt1L82aQ6GsktfVLB7qp2/gA1gCgwVjkKxLM6i0PJg=;
	h=From:To:Cc:Subject:Date:From;
	b=PgC3zLsc1Ouq2zG3taX0bUnQ8246aBUrrOOsRYI7YKW09WxsJBtAPzE3v5utZ1iW4
	 FZltqut5lZbVuxM1pzUl8VZDMYOpnObCp9KlzKiaJ3BqHgb9AzM2Ekc5H/UjPrk0a7
	 CIQ50KdDb/p1jKY+DcZDKk6MbJa/nlhusnlOB4DA=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v2 1/2] wifi: rtw89: sar: drop lockdep assertion in rtw89_set_sar_from_acpi
Date: Wed,  4 Jun 2025 19:13:32 +0300
Message-ID: <20250604161339.119954-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following assertion is triggered on the rtw89 driver startup. It
looks meaningless to hold wiphy lock on the early init stage so drop the
assertion.

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

v2: no changes

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


