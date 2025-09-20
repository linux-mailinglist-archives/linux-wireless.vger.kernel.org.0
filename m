Return-Path: <linux-wireless+bounces-27535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A642CB8C8EE
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 15:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8AD87AF7FC
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 13:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38AE1F8AC8;
	Sat, 20 Sep 2025 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Z1C1nDsp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5A8341AA;
	Sat, 20 Sep 2025 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758374829; cv=none; b=gDz/dnMrrWJtrddb5Ux2fWFIvvSyc4RXynS2DACeaiyevkMnWfWcDMeFbLNkfJBmz8tay1niz0RPctCPjeVfg2NHzGKtP62xK5cIEZQpQ75niCgZjfbp4En+xET6mhuGVLvuPWMHLPaSfVIGhuvuvhZDFAizesTCN1sdP+Igdnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758374829; c=relaxed/simple;
	bh=5gOciC5shX1x//52AeNkUQHZJ9dDIQy/+fGR2BfZcaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t361rIPIrLgOhgGW9QpMtn4EVBjAqq7uOL6fXPTOTKGhpHZMVYRyeYefIEgjlcxOWxyg0rr91IjgnAxQdzmYz0/TEyHssOISe/MjxHG7hvk6DH/xboLZj5w1NbH0Yg4Mzyb54Mlpf6SmaSB2maT90A5ki7BIWZv7b2jJBTdReKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Z1C1nDsp; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.11])
	by mail.ispras.ru (Postfix) with ESMTPSA id 5C1EB4076179;
	Sat, 20 Sep 2025 13:27:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5C1EB4076179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1758374822;
	bh=RD5rtyVmdoF6gvXExwvsAgwbWu7FWaouuHRI6q4gRMI=;
	h=From:To:Cc:Subject:Date:From;
	b=Z1C1nDspCjh2pkxl3Zx+KZewgezH4763Qh8Rsf0rOr3n7etCnPv55XmwtJvjjKs1g
	 w6LUBl/B2RGiqElOtS64A+fo+HWEqILgd4sECfTSq08Hx5uUT0iF5yxZSOLSMb2jTn
	 2c3d4OjeaRgluYc+G8Nc1PN1qTc8oH6whfZhfEvY=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next 0/6] wifi: rtw89: improvements for USB part
Date: Sat, 20 Sep 2025 16:26:05 +0300
Message-ID: <20250920132614.277719-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first two patches concern memory leak issues found during testing.

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

Sorry for the inconvenience with the timing when the series is sent.  It's
not extremely urgent, and I'd gladly appreciate if it'd be reviewed for
any issues I'm not aware of.  Testing with other USB chips would be great,
too.  Thanks!

Fedor Pchelkin (6):
  wifi: rtw89: usb: fix leak in rtw89_usb_rx_handler()
  wifi: rtw89: usb: fix leak in rtw89_usb_write_port()
  wifi: rtw89: implement C2H TX report handler
  wifi: rtw89: handle IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
  wifi: rtw89: process TX wait skbs for USB via C2H handler
  wifi: rtw89: forcefully clear TX wait list on HCI reset

 drivers/net/wireless/realtek/rtw89/core.c | 23 +++++++--
 drivers/net/wireless/realtek/rtw89/core.h | 44 ++++++++++++++--
 drivers/net/wireless/realtek/rtw89/fw.h   |  5 ++
 drivers/net/wireless/realtek/rtw89/mac.c  | 63 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h  |  9 ++++
 drivers/net/wireless/realtek/rtw89/pci.c  |  1 +
 drivers/net/wireless/realtek/rtw89/pci.h  |  4 --
 drivers/net/wireless/realtek/rtw89/txrx.h |  2 +
 drivers/net/wireless/realtek/rtw89/usb.c  | 35 +++++++++++--
 drivers/net/wireless/realtek/rtw89/usb.h  | 15 ++++++
 10 files changed, 186 insertions(+), 15 deletions(-)

-- 
2.51.0


