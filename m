Return-Path: <linux-wireless+bounces-28024-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86353BE7F1A
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 12:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA14E4E14B2
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 10:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A51A30F818;
	Fri, 17 Oct 2025 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="GWBbr7dx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B8126FA50;
	Fri, 17 Oct 2025 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695636; cv=none; b=RDY8qud40dCOi6Tb1WQtEH2oc3VnPf+zKGrNjwzHYmdQfI97iqpGNnr808+C9KEZnnh1oOsnoeknthsnL/0+PBaKolqV1Pft/oY4O/0OvK5xxRD+QjwAp8hoIvxQOolIClzcLcePfwimrb2pJGthy024YL4NYdL+PZsncAD9MGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695636; c=relaxed/simple;
	bh=pCxoDg4oKfpaxDEhq3czLpI63RXiTrJNP3Ao/8pEw08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZFJR7fggmwlTAZb6sVHezN01OxNdL4WYNkd27DBuFhcrUS7NQeer8KpyQ/oreiIUf2x6UP1n24Eve2TM+3EgZUT6bV8TH/mW6LZOc2HXqktpMJaS2mba9ffHV0KwvFWVZeXIl1x9agDS3GS1ouJ5bePGy61Zgnk5lShSXDddDa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=GWBbr7dx; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id 4153D4076726;
	Fri, 17 Oct 2025 10:07:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4153D4076726
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1760695629;
	bh=PZUBjANI3Z1kimm/2Mkhpax3Z/gvFLkoOAmxwGxn2n8=;
	h=From:To:Cc:Subject:Date:From;
	b=GWBbr7dxM26+E6a0e53oL6RoV6Ut8I+3AWbWXIJX+EVlkqmVdd3ysIXjtzx3up1lO
	 U6DjF41QqzmjQSh3QUs+QBUvMZq+kZmusm+SHsFApVmXzFtfbAWBpkbRQGR7hdcJq2
	 0Vh2ftgXQqgRqYBO9iU2WksxCCShd/f+0gGSYC9A=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v3 0/9] wifi: rtw89: improvements for USB part
Date: Fri, 17 Oct 2025 13:03:02 +0300
Message-ID: <20251017100658.66581-1-pchelkin@ispras.ru>
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

v3: - add new 6/9 and 8/9 patches based on previous feedback
    - further changelog below --- in the patches

v2: https://lore.kernel.org/linux-wireless/20251002200857.657747-1-pchelkin@ispras.ru/
    - add new 3/7 and 4/7 patches prepared due feedback to previous comments
      or developed in process
    - further changelog below --- in the patches

v1: https://lore.kernel.org/linux-wireless/20250920132614.277719-1-pchelkin@ispras.ru/

Fedor Pchelkin (8):
  wifi: rtw89: usb: use common error path for skbs in
    rtw89_usb_rx_handler()
  wifi: rtw89: usb: fix leak in rtw89_usb_write_port()
  wifi: rtw89: usb: use ieee80211_free_txskb() where appropriate
  wifi: rtw89: refine rtw89_core_tx_wait_complete()
  wifi: rtw89: implement C2H TX report handler
  wifi: rtw89: handle IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
  wifi: rtw89: provide TX reports for management frames
  wifi: rtw89: process TX wait skbs for USB via C2H handler

Ping-Ke Shih (1):
  wifi: rtw89: fill TX descriptor of FWCMD in shortcut

 drivers/net/wireless/realtek/rtw89/core.c | 61 +++++++++++++-------
 drivers/net/wireless/realtek/rtw89/core.h | 40 +++++++++----
 drivers/net/wireless/realtek/rtw89/fw.c   |  4 +-
 drivers/net/wireless/realtek/rtw89/fw.h   | 41 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.c  | 65 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h  | 69 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.c  |  2 +-
 drivers/net/wireless/realtek/rtw89/pci.h  |  4 --
 drivers/net/wireless/realtek/rtw89/txrx.h |  6 +-
 drivers/net/wireless/realtek/rtw89/usb.c  | 41 +++++++++++---
 10 files changed, 288 insertions(+), 45 deletions(-)

-- 
2.51.0


