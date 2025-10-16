Return-Path: <linux-wireless+bounces-27996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C90EBE5964
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Oct 2025 23:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57BD519A82EC
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Oct 2025 21:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B74E2D9EE5;
	Thu, 16 Oct 2025 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="D2im+KXj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3844B201004
	for <linux-wireless@vger.kernel.org>; Thu, 16 Oct 2025 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651059; cv=none; b=oNuiqEG6nItdzBuDUtAziQHRa36inWJg4Xh5hWnGoGggVAhftgcjm/DxEA5+fCmPJlZg76NTXeD7sOpndOv/C6hssXOtO2f6YZ38KbfMKtHOBSw5apXeYdKhmjiuUiXENnkg8llsUkf9UNp6RRoXwuFiyeHFW1FocmyrF0wWt30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651059; c=relaxed/simple;
	bh=E1ebM1D7a9YZg3kfHFk8oGlhjCVfD448OsvpiIi9UWo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=W3k1SB+AQFXeVV+5M9A3lfuf3+2xIQtPX/2T0gJDgTLZrQP3MogH60L4Z3k/6SqXeguoPRWAgig+DV572ViptEoFmcjj0OsDvE1fOEvq0n6AO65qDJJNSy9CpHessb6h3dVs6ePDrhAo4Gx6wRFupBE4u5j2pNxwPlGlAxmcvtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=D2im+KXj; arc=none smtp.client-ip=185.70.43.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1760650370; x=1760909570;
	bh=E1ebM1D7a9YZg3kfHFk8oGlhjCVfD448OsvpiIi9UWo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=D2im+KXjtyk128l1EjhYfeE3fUEBvV3sr5XjBJ8fcqFpgMw8/pviCO3w8HVr/bg/b
	 TO5zoaSIAMnIiOCtPdDiEGUWCm+uHg0h4wqkCscSDkTe08D+oUcTn13jfCcs9XRIR0
	 RG02DnAGOe6TtaK53licQTsHaVKlOO1F/OifCZ1Z1oZKf0c7od2IvXAVzlFZEx0duC
	 zMR0GXJnC1syijr36TeU3svRmfpAvn/hdDseVHJqAbn4ST2bK679dhWwThA8XMWN5v
	 M1UE59qr28ATUjMMevj6d6NzPV6XPDgXirDnTcG0heGswZGU6DcdPDIAsLnk/TzUYP
	 NDM+Q7CHkQd4A==
Date: Thu, 16 Oct 2025 21:32:42 +0000
To: "pkshih@realtek.com" <pkshih@realtek.com>
From: Samuil <samuilsgames@protonmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RTW88 USB Wi-Fi Adapter (8822BU) Disconnects and Fails with USB Write Errors - Status -71 & -110
Message-ID: <zjR8G0R1ZUFe9h8_ibO-LWc9OOJyMThA9jp9ftYbETLG3IN0cHPvhCAaC9ypGKPbapsbzTH5VqnDhFcX93GkwnG1BEyETplFQmRiGGshBz8=@protonmail.com>
Feedback-ID: 26992803:user:proton
X-Pm-Message-ID: f2bc95de633ee915683afa61d0dad0d276adb263
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear Sir or Madam,

My TP-Link Archer T4U (AC1300) Wi-FI adapter has not been working properly.=
 When I first boot the system, the device is perfectly operational. However=
, after a few minutes it disconnects. In GNOME the whole WiFi GUI is bugged=
 after that: It shows that I am still connected but I can't turn off the co=
nnection or do anything. `iwctl station list` also runs indefinitely withou=
t ever showing info. It seems like iwd and NetworkManager are blocked by th=
e RTW88 driver. When I try to turn off my PC in this state, the driver erro=
r blocks my OS from entirely shutting down until I unplug the WiFi adapter.

Keywords: networking, rtw88_8822bu, wifi

Kernel version: 6.17.3 (latest stable)

Most recent kernel version which did not have the bug: 6.11.*

The Journal shows following error message during boot:
```
Okt 16 22:10:05 batcomputer kernel: rtw88_8822bu 1-4:1.0: write register 0x=
c4 failed with -71
Okt 16 22:10:05 batcomputer kernel: usbcore: registered new interface drive=
r rtw88_8822bu
Okt 16 22:10:06 batcomputer kernel: usb 2-4: new SuperSpeed USB device numb=
er 2 using xhci_hcd
Okt 16 22:10:06 batcomputer kernel: usb 2-4: New USB device found, idVendor=
=3D2357, idProduct=3D0115, bcdDevice=3D 3.00
Okt 16 22:10:06 batcomputer kernel: usb 2-4: New USB device strings: Mfr=3D=
1, Product=3D2, SerialNumber=3D3
Okt 16 22:10:06 batcomputer kernel: usb 2-4: Product: 802.11ac NIC
Okt 16 22:10:06 batcomputer kernel: usb 2-4: Manufacturer: Realtek
Okt 16 22:10:06 batcomputer kernel: usb 2-4: SerialNumber: 123456
Okt 16 22:10:06 batcomputer kernel: rtw88_8822bu 2-4:1.0: Firmware version =
27.2.0, H2C version 13
```

When my Internet cuts off, these messages pop up:
```
Okt 16 22:11:55 batcomputer kernel: rtw88_8822bu 2-4:1.0: firmware failed t=
o leave lps state
Okt 16 22:12:04 batcomputer kernel: xhci_hcd 0000:02:00.0: WARN Set TR Deq =
Ptr cmd failed due to incorrect slot or ep state.
Okt 16 22:12:04 batcomputer kernel: rtw88_8822bu 2-4:1.0: read register 0x8=
a4 failed with -110
Okt 16 22:12:05 batcomputer kernel: rtw88_8822bu 2-4:1.0: failed to get tx =
report from firmware
Okt 16 22:12:05 batcomputer kernel: rtw88_8822bu 2-4:1.0: write register 0x=
8a4 failed with -110
Okt 16 22:12:05 batcomputer kernel: rtw88_8822bu 2-4:1.0: read register 0x4=
c failed with -110
Okt 16 22:12:06 batcomputer kernel: rtw88_8822bu 2-4:1.0: rtw_usb_reg_sec: =
reg 0x4e0, usb write 1 fail, status: -110
Okt 16 22:12:06 batcomputer kernel: rtw88_8822bu 2-4:1.0: read register 0x1=
0c failed with -115
Okt 16 22:12:07 batcomputer kernel: rtw88_8822bu 2-4:1.0: read register 0x4=
c failed with -110
Okt 16 22:12:09 batcomputer kernel: rtw88_8822bu 2-4:1.0: write register 0x=
4c failed with -110
Okt 16 22:12:14 batcomputer kernel: rtw88_8822bu 2-4:1.0: rtw_usb_reg_sec: =
reg 0x4e0, usb write 1 fail, status: -110
Okt 16 22:12:14 batcomputer kernel: rtw88_8822bu 2-4:1.0: write register 0x=
4c failed with -110
Okt 16 22:12:16 batcomputer kernel: rtw88_8822bu 2-4:1.0: rtw_usb_reg_sec: =
reg 0x4e0, usb write 1 fail, status: -110
Okt 16 22:12:18 batcomputer kernel: rtw88_8822bu 2-4:1.0: rtw_usb_reg_sec: =
reg 0x4e0, usb write 1 fail, status: -110
Okt 16 22:12:18 batcomputer kernel: rtw88_8822bu 2-4:1.0: rtw_usb_reg_sec: =
reg 0x4e0, usb write 1 fail, status: -110
Okt 16 22:12:20 batcomputer kernel: rtw88_8822bu 2-4:1.0: rtw_usb_reg_sec: =
reg 0x4e0, usb write 1 fail, status: -110
[...] (goes on like this for a while)
```

When I shut off my computer, these messages pop up:
```
[...] (repeats for a LOT of times with marginally different mem addresses)
Okt 16 22:19:04 batcomputer kernel: xhci_hcd 0000:02:00.0: Event dma 0x0000=
000105a9e110 for ep 0 status 4 not part of TD at 000000011fd2bd30 - 0000000=
11fd2bd50
Okt 16 22:19:04 batcomputer kernel: xhci_hcd 0000:02:00.0: Event dma 0x0000=
000105a9e110 for ep 0 status 4 not part of TD at 000000011fd2bd90 - 0000000=
11fd2bdb0
Okt 16 22:19:04 batcomputer kernel: rtw88_8822bu 2-4:1.0: rtw_usb_reg_sec: =
reg 0x4e0, usb write 1 fail, status: -110
Okt 16 22:19:05 batcomputer kernel: xhci_hcd 0000:02:00.0: Event dma 0x0000=
000105a9e110 for ep 0 status 4 not part of TD at 000000011fd2bdf0 - 0000000=
11fd2be10
Okt 16 22:19:05 batcomputer kernel: rtw88_8822bu 2-4:1.0: rtw_usb_reg_sec: =
reg 0x4e0, usb write 1 fail, status: -110
Okt 16 22:19:06 batcomputer kernel: xhci_hcd 0000:02:00.0: Event dma 0x0000=
000105a9e110 for ep 0 status 4 not part of TD at 000000011fd2be20 - 0000000=
11fd2be40
Okt 16 22:19:06 batcomputer kernel: xhci_hcd 0000:02:00.0: Event dma 0x0000=
000105a9e110 for ep 0 status 4 not part of TD at 000000011fd2beb0 - 0000000=
11fd2bed0
Okt 16 22:19:06 batcomputer kernel: usb 2-4: USB disconnect, device number =
2
Okt 16 22:19:06 batcomputer kernel: xhci_hcd 0000:02:00.0: WARN Set TR Deq =
Ptr cmd failed due to incorrect slot or ep state.
```

Thanks for the help in advance!

Best regards,
Samuil


