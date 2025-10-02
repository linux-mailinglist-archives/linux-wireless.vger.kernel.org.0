Return-Path: <linux-wireless+bounces-27786-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EB2BB5182
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Oct 2025 22:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B63189FD91
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Oct 2025 20:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39312877F1;
	Thu,  2 Oct 2025 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="bPStELjE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A178145A05;
	Thu,  2 Oct 2025 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759435767; cv=none; b=o+xI0IEVApwv+mGe7gMcw9Hs6z0wxflnh+d0tp/YxEWeVNpyg2sMvsrZjLv/TN3M/UiY7LPIqSazhr1bWP62xPDzNDcndAmTpx7s9wWnJJDIKrxtLnBXln4BHNbs0cU8oHKgPjY21U6HsKkUY44RXupokDoGiPXU8jZIg4FsBag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759435767; c=relaxed/simple;
	bh=SS8XM5DGlXeZWc4WZYK27AkBICGircypGHPsropx6v8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bDocD89R1+D6kTNkolM8oJY11SlZJRo6BWz64Os+kF1NZ0DxHdWt1GR++wJ9gYnsM8i+gXcxsPhct0K3WOlG2GtZj1ZDViqXdFBfQOy1XrIf95a8/hvgBUhoJAUAGdrRD4XWVuBRiPPyUc0UGwAKgGhKx8N7gShloaVXybscAc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=bPStELjE; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.9])
	by mail.ispras.ru (Postfix) with ESMTPSA id 7C7B540762E7;
	Thu,  2 Oct 2025 20:09:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7C7B540762E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1759435754;
	bh=uzxikgNSE787uKZRw289jDmqaIO5ELL1UND9MiIfUDk=;
	h=From:To:Cc:Subject:Date:From;
	b=bPStELjEu0aeiWY7tAEf0gnuOD+MiThys3sIOv2roz83aSqk4Rdn0KtQUzvltKJyU
	 uuXSMfnFL0vsoLV0YlUMHTEaQZq7JAreUJ7oX6fANf37zuT9Gzw1cePfEKi7lMdLjL
	 0ZWF5L7ec/1yspoazvGd4SqpN3AMOe5lfbNEGEWE=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v2 0/7] wifi: rtw89: improvements for USB part
Date: Thu,  2 Oct 2025 23:08:45 +0300
Message-ID: <20251002200857.657747-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first two patches concern memory leak issues found during testing.

The third and the fourth one do some extra small changes.

The other ones implement TX completion functionality missing for the USB
part of rtw89 driver, suggested by Bitterblue Smith [1].  This will allow
handling TX wait skbs and the ones flagged with IEEE80211_TX_CTL_REQ_TX_STATUS
correctly.

rtw89 has several ways of handling TX status report events.  The first one
is based on RPP feature which is used by PCIe HCI.  The other one depends
on firmware sending a corresponding C2H message, quite similar to what
rtw88 has.  RTL8851BU vendor driver [2] was taken for reference.

[1]: https://lore.kernel.org/linux-wireless/0cb4d19b-94c7-450e-ac56-8b0d4a1d889f@gmail.com/
[2]: https://github.com/fofajardo/rtl8851bu.git

Series has been tested to work with RTL8851BU (USB) and RTL8852BE (PCIe)
devices.


Changelog.

v2: - add new 3/7 and 4/7 patches prepared due feedback to previous comments
      or developed in process
    - further changelog below --- in the patches

v1: https://lore.kernel.org/linux-wireless/20250920132614.277719-1-pchelkin@ispras.ru/

Fedor Pchelkin (7):
  wifi: rtw89: usb: use common error path for skbs in
    rtw89_usb_rx_handler()
  wifi: rtw89: usb: fix leak in rtw89_usb_write_port()
  wifi: rtw89: usb: use ieee80211_free_txskb() where appropriate
  wifi: rtw89: refine rtw89_core_tx_wait_complete()
  wifi: rtw89: implement C2H TX report handler
  wifi: rtw89: handle IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
  wifi: rtw89: process TX wait skbs for USB via C2H handler

 drivers/net/wireless/realtek/rtw89/core.c | 41 ++++++++++++---
 drivers/net/wireless/realtek/rtw89/core.h | 45 +++++++++++++----
 drivers/net/wireless/realtek/rtw89/fw.h   | 14 ++++++
 drivers/net/wireless/realtek/rtw89/mac.c  | 46 +++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h  | 61 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.c  |  2 +-
 drivers/net/wireless/realtek/rtw89/pci.h  |  4 --
 drivers/net/wireless/realtek/rtw89/txrx.h |  6 ++-
 drivers/net/wireless/realtek/rtw89/usb.c  | 41 +++++++++++----
 9 files changed, 228 insertions(+), 32 deletions(-)

-- 
2.51.0


