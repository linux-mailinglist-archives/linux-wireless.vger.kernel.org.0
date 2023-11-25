Return-Path: <linux-wireless+bounces-71-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9397F8B02
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Nov 2023 14:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029ED1C20B12
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Nov 2023 13:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E97DD512;
	Sat, 25 Nov 2023 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="zlk0cw4O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5271EA1
	for <linux-wireless@vger.kernel.org>; Sat, 25 Nov 2023 05:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1700917452; x=1701176652;
	bh=43iqpWsQOIvUj4idO/6jD2I4/VKJLSuA11XDlQSzX2g=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=zlk0cw4OPc+Zc80S+sBy1obAJ+u+qBnyIwAVzuvZjQr9cuEtY2bHiznhesoAFJUt3
	 lt4PGu5kvoJw8MBwykRHqqCLlBtaeuSEaRPPiIa8RdD9nFFK138U9vW+oXt8e71gg6
	 B9pCefKxZOx1OzRGJEO/SVOMcO1h56K0A3LrxHn7rabmGTJdzLKtDq0n5D8EYm+Nfs
	 /c3wZTes8y1Jh3p0T/vgMavPGvSSYs2hs13k2EX68OIPJCCMptSERsdzcPV7laPCUU
	 XPBsCPgXfNpLkUVml9apYUwg/J+vWhPuKuOdBwWTy9SSgDKQ1M9KBNl1nmkWHwFlci
	 VEO0OVoJBb1fA==
Date: Sat, 25 Nov 2023 13:03:45 +0000
To: "kuba@kernel.org" <kuba@kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
From: cristian_ci <cristian_ci@protonmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "cristian_ci@protonmail.com" <cristian_ci@protonmail.com>
Subject: [BUG] wireless: mt7601u: probe failed with error -110
Message-ID: <Bnwq2et4CBU1_MS8X3rFeejMDmKf2dr_BNq60IzBcGKbjTxHG1CjJ0zB_wZjn8_iLJsi7fCx6_Eh01ozYBqPA-cEZXMZE_X98E0b7yotXCg=@protonmail.com>
Feedback-ID: 27475468:user:proton
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi, this mt7601u device attempts continuously to probe spamming the followi=
ng lines to dmesg output:

[   99.604249] usb 1-2: new high-speed USB device number 7 using xhci_hcd
[   99.758083] usb 1-2: New USB device found, idVendor=3D148f, idProduct=3D=
7601, bcdDevice=3D 0.00
[   99.758098] usb 1-2: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[   99.758104] usb 1-2: Product: 802.11 n WLAN
[   99.758109] usb 1-2: Manufacturer: MediaTek
[   99.758114] usb 1-2: SerialNumber: 1.0
[   99.880644] usb 1-2: reset high-speed USB device number 7 using xhci_hcd
[  100.025562] mt7601u 1-2:1.0: ASIC revision: 76010001 MAC revision: 76010=
500
[  100.029499] mt7601u 1-2:1.0: Firmware Version: 0.1.00 Build: 7640 Build =
time: 201302052146____
[  100.455461] mt7601u 1-2:1.0: EEPROM ver:0d fae:00
[  100.645586] mt7601u 1-2:1.0: Error: MCU resp urb failed:-71
[  100.645610] mt7601u 1-2:1.0: Error: MCU resp evt:0 seq:5-4!
[  100.645678] mt7601u 1-2:1.0: Error: MCU resp urb failed:-71
[  100.645697] mt7601u 1-2:1.0: Error: MCU resp evt:0 seq:5-4!
[  100.645774] mt7601u 1-2:1.0: Error: MCU resp urb failed:-71
[  100.645816] mt7601u 1-2:1.0: Error: MCU resp evt:0 seq:5-4!
[  100.645920] mt7601u 1-2:1.0: Error: MCU resp urb failed:-71
[  100.645926] mt7601u 1-2:1.0: Error: MCU resp evt:0 seq:5-4!
[  100.646026] mt7601u 1-2:1.0: Error: MCU resp urb failed:-71
[  100.646031] mt7601u 1-2:1.0: Error: MCU resp evt:0 seq:5-4!
[  100.646036] mt7601u 1-2:1.0: Error: mt7601u_mcu_wait_resp timed out
[  100.784270] mt7601u 1-2:1.0: Vendor request req:07 off:0080 failed:-71
[  100.917572] mt7601u 1-2:1.0: Vendor request req:02 off:0080 failed:-71
[  101.057650] mt7601u 1-2:1.0: Vendor request req:02 off:0080 failed:-71
[  101.057737] mt7601u: probe of 1-2:1.0 failed with error -110
[  101.058197] usb 1-2: USB disconnect, device number 7
[  101.313690] usb 1-2: new high-speed USB device number 8 using xhci_hcd

I'm not the only one to have experienced this bug. I've been suggested to r=
eport that to kernel mailing list by linux support channels.

I've tested this bug against upstream 6.6.2 kernel tarball from the latest =
stable branch [1].

To solve this issue. I've also tried to patch mt7601u driver disabling mcu =
calibration. Which doesn't seem a wise idea because apparently it fixes pro=
bing but also hangs completely the machine after some seconds (so, it needs=
 a hard/forced shutdown).

Thanks in advance,

Regards,

Cristian.

[1] https://www.kernel.org/

