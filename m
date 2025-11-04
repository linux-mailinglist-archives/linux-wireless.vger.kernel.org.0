Return-Path: <linux-wireless+bounces-28537-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BA9C31577
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 14:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A8918908B2
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 13:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27D432A3FE;
	Tue,  4 Nov 2025 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Y9FBwkEA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9DB32A3DE;
	Tue,  4 Nov 2025 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264673; cv=none; b=Nkb/s1Gq21xngvoZMhz0SMR2TET4AzRZBDQRHXsNkFYIFq+2iwkYWRAr+Bm+v9AjDTrU40RCZKj1NWXfn4LAktCN6KZBc6wISICZLLlcuxFLP6Zifv6ZfOwugmfjfM3H2xmEa6sCH+1dtofitY6zWHedbB2v02p5qKw6pISOY7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264673; c=relaxed/simple;
	bh=qwA//D22qvRhrJrv6hZHYgq586r3VcoE66vLN7/f6qI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EHAxNkQIByxIaArUnuD3T2tQe33EHy79Na1rgO4aNYdIRJAHKVzdNh2DmBC0h+Hg+s9kdmuaCG3QO3jravfxY8u/NC/q1PNODRl0Dba0reUwc5FT0pY+Umd/nTbA1Zun6YuD9qy4Tp+RMUGsa4CN9affcvKUjWL1GdVvldFbu5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Y9FBwkEA; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.12])
	by mail.ispras.ru (Postfix) with ESMTPSA id 86CFB4076184;
	Tue,  4 Nov 2025 13:57:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 86CFB4076184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1762264660;
	bh=EDhtJ7dzVqD9En3I5r7ESfLQ7Y14C2nctAXTFG5L9Po=;
	h=From:To:Cc:Subject:Date:From;
	b=Y9FBwkEAmhk/O0pJB87KBtl1lwA9Dtzf1EIGAQ8kKKSnMNncBidDrusFZXQTnxeLy
	 llEwLpa7ZEv6qiQstRQExqYketYM/nj3+JFPNoNFA1yWCRjAH6tSvxOz0WZfpMJmpR
	 LeX0xrDqBlD7HcaXa2t3D29pQSB1ny6uuy1Sa1TE=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v5 00/10] wifi: rtw89: improvements for USB part
Date: Tue,  4 Nov 2025 16:57:07 +0300
Message-ID: <20251104135720.321110-1-pchelkin@ispras.ru>
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

v5: - minor adjustments for 8/10
    - further changelog below --- in the patches

v4: https://lore.kernel.org/linux-wireless/20251029190241.1023856-1-pchelkin@ispras.ru/
    - add new 7/10 patch with TX URBs anchor based on previous feedback
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
 drivers/net/wireless/realtek/rtw89/core.h | 45 ++++++++---
 drivers/net/wireless/realtek/rtw89/fw.c   |  4 +-
 drivers/net/wireless/realtek/rtw89/fw.h   | 41 ++++++++++
 drivers/net/wireless/realtek/rtw89/mac.c  | 78 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h  | 95 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.c  |  2 +-
 drivers/net/wireless/realtek/rtw89/pci.h  |  4 -
 drivers/net/wireless/realtek/rtw89/txrx.h |  6 +-
 drivers/net/wireless/realtek/rtw89/usb.c  | 68 +++++++++++++---
 drivers/net/wireless/realtek/rtw89/usb.h  |  1 +
 11 files changed, 357 insertions(+), 48 deletions(-)

-- 
2.51.0


