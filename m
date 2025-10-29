Return-Path: <linux-wireless+bounces-28379-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60210C1CE18
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 20:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA30F4E41B0
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 19:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20EA3596E4;
	Wed, 29 Oct 2025 19:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="rpS5djc1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE1358D27;
	Wed, 29 Oct 2025 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764583; cv=none; b=lTzAsv0WLkULXpMJQ3zYx4J1mmeMF3f9udFzwUsxg3TbenbO/6sBAJY3Ps7Cjm/I5AFkg88eFZPLHlCRrEQnFuXj6ujt4V4XZwQU+y6Z3AQlxOqFIUHtm0pKbhqqAafbGI8U9EUCBvN/+adcOsJS38vcIB4WJkQPvnJ021G1J/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764583; c=relaxed/simple;
	bh=pWofwh7qGFgN1Qd0RhW6fTC+Rfko4QJuxhesX3mqfGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JxaEk/rBACUEVwfAhGwqfoulxHub6v9NSQrrjUgmTPnjhz7ItxeJ481pL3IRFiAhhS3lnQfdsqc0T/vsZyQwPuH4FUTMJUKPtpWAR7XrRBpsmWduMLjJKL/Bnlx/w1KSIJID8eNS6g2RgIVWzK/MB9wJNOFoCQOyhFIF6x3y6O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=rpS5djc1; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id 43AB74076729;
	Wed, 29 Oct 2025 19:02:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 43AB74076729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1761764576;
	bh=TiAGTa2EXLg8eiwEDFIdBzkh3CwFSjxdkK/+re2kcEc=;
	h=From:To:Cc:Subject:Date:From;
	b=rpS5djc15ChD4rD8EdLChF3HshRTQflqo56q+8Dre1t1avVVez2e85YFkQuvfEilK
	 U/Wv9CFek7Sca+akKIBhZVM39m4QFRyVpPwscvVODRMY57lOY40dEH0dkIM+U36Dmq
	 vDK6JNBe1lXiaW3WrveqnkNMC+a7Ej7ddhtte9Pw=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v4 00/10] wifi: rtw89: improvements for USB part
Date: Wed, 29 Oct 2025 22:02:28 +0300
Message-ID: <20251029190241.1023856-1-pchelkin@ispras.ru>
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

Series has been tested to work with RTL8851BU (USB) for TX report
functionality - I've been able to test only V0 format of C2H message, and
RTL8852BE (PCIe) devices for other things (mainly that the changes have
not unexpectedly influenced th PCIe part).

Changelog.

v4: - add new 7/10 patch with TX URBs anchor based on previous feedback
    - further changelog below --- in the patches

v3: https://lore.kernel.org/linux-wireless/20251017100658.66581-1-pchelkin@ispras.ru/
    - add new 6/9 and 8/9 patches based on previous feedback
    - further changelog below --- in the patches

v2: https://lore.kernel.org/linux-wireless/20251002200857.657747-1-pchelkin@ispras.ru/
    - add new 3/7 and 4/7 patches prepared due feedback to previous comments
      or developed in process
    - further changelog below --- in the patches

v1: https://lore.kernel.org/linux-wireless/20250920132614.277719-1-pchelkin@ispras.ru/

Fedor Pchelkin (9):
  wifi: rtw89: usb: use common error path for skbs in
    rtw89_usb_rx_handler()
  wifi: rtw89: usb: fix leak in rtw89_usb_write_port()
  wifi: rtw89: usb: use ieee80211_free_txskb() where appropriate
  wifi: rtw89: refine rtw89_core_tx_wait_complete()
  wifi: rtw89: implement C2H TX report handler
  wifi: rtw89: usb: anchor TX URBs
  wifi: rtw89: handle IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
  wifi: rtw89: provide TX reports for management frames
  wifi: rtw89: process TX wait skbs for USB via C2H handler

Ping-Ke Shih (1):
  wifi: rtw89: fill TX descriptor of FWCMD in shortcut

 drivers/net/wireless/realtek/rtw89/core.c | 61 ++++++++++-----
 drivers/net/wireless/realtek/rtw89/core.h | 44 ++++++++---
 drivers/net/wireless/realtek/rtw89/fw.c   |  4 +-
 drivers/net/wireless/realtek/rtw89/fw.h   | 41 ++++++++++
 drivers/net/wireless/realtek/rtw89/mac.c  | 72 +++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h  | 95 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.c  |  2 +-
 drivers/net/wireless/realtek/rtw89/pci.h  |  4 -
 drivers/net/wireless/realtek/rtw89/txrx.h |  6 +-
 drivers/net/wireless/realtek/rtw89/usb.c  | 68 +++++++++++++---
 drivers/net/wireless/realtek/rtw89/usb.h  |  1 +
 11 files changed, 350 insertions(+), 48 deletions(-)

-- 
2.51.0


