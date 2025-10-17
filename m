Return-Path: <linux-wireless+bounces-28037-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E29BEB0F1
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 19:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BBBFF35B447
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 17:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A56302CBD;
	Fri, 17 Oct 2025 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="FTpTCzdK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAA8221726;
	Fri, 17 Oct 2025 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760721918; cv=none; b=nBUYMOjo8n3Qnla1Rq8vxI2QX+kcB7nJ2Wlg3nPx6IFYKTgv7YTLTT3QC1QHQ+ADBHqBkBsOEHQGB6SiUVth8T56UVozjqxrVUkarl38j7fzGa32Vwpzh8vJwLpw+MPNnYzi1exvVGfmN4L5nkW1w/+EcDnQ+ITtHVkepcD/Pdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760721918; c=relaxed/simple;
	bh=J8qJf4dyx5TbSlGTIgUKP/zMB0ccF47zhYYQNzGygeA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pxUk4x9Z7j3C8uKlFNxKyHXpHGhXHbML3obs+RQW0MNQJvr/YDMo52AXjghsYkcPOXs6YDItRgZLBuyF+p2lwFqkz/EhNqOp5Fy90/C17YU/KfvAB8V1ot8q0Bp0PtYkVK8Zehx0jmWS8uIo266JWH86gduIBZA6aB0r2ZiOu2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=FTpTCzdK; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1760721908; x=1760981108;
	bh=J8qJf4dyx5TbSlGTIgUKP/zMB0ccF47zhYYQNzGygeA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FTpTCzdKxmYz2FNcKL0Qsfs0Uic6KX1ye5YCV5k6BqKUyblk89IUNE5PVNOzYeIXl
	 wN9jZpnbDmR8SA7cMdUi8eSKsUkcvu9uTdmkLIc6NtQj0bpr2rPcVvsZnQZenZRavD
	 WRhooSPGPlYwKhOsYQmcoYlFd0/Y+nAGUizf8fpsKi4+/puGtqzAF0yfv+ahLOa/UX
	 0eQRq494JLcJvXuzxe1Jx4t8XHgtDz4bokKUTQ29zni/zLK9ipdvvbw4hOhS6iIVgR
	 m13+mSXifI5SD48hP7PXCBwpbGqr5joMumvfTTyGYKmM+LtdobKSkNBEirbHYhRVWi
	 B0di/CsQzbzuA==
Date: Fri, 17 Oct 2025 17:25:03 +0000
To: Michal Pecio <michal.pecio@gmail.com>
From: Samuil <samuilsgames@protonmail.com>
Cc: "pkshih@realtek.com" <pkshih@realtek.com>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, linux-usb@vger.kernel.org
Subject: RTW88 USB Wi-Fi Adapter (8822BU) Disconnects and Fails with USB Write Errors - Status -71 & -110
Message-ID: <7qi-6tBb1frj_rYuHZflT1akP5I6yA2yxTA7Gg8IQBlDIwSqiWx76AFmcirkfHv5VmqQ7CZ4SesZSswoDKzOt3kbgh3MI-4CqEq-RrxHnns=@protonmail.com>
In-Reply-To: <20251017005947.54e1944b.michal.pecio@gmail.com>
References: <zjR8G0R1ZUFe9h8_ibO-LWc9OOJyMThA9jp9ftYbETLG3IN0cHPvhCAaC9ypGKPbapsbzTH5VqnDhFcX93GkwnG1BEyETplFQmRiGGshBz8=@protonmail.com> <20251017005947.54e1944b.michal.pecio@gmail.com>
Feedback-ID: 26992803:user:proton
X-Pm-Message-ID: d5312bf70a97ac07bb13df0924fd8ec517587fa1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey,

On Thursday, October 16th, 2025 at 10:59 PM, Michal Pecio <michal.pecio@gma=
il.com> wrote:
> Does it happen every time on every boot?
The disconnect happens on every boot although rarely the device is able to =
reconnect again. Usually, however, the adapter just stops working until I r=
eboot again.

> May we know what 'lspci -nn' says about this 0000:02:00.0 controller?
```
02:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] 400 Serie=
s Chipset USB 3.1 xHCI Compliant Host Controller [1022:43d5] (rev 01)
```

> Yep, definitely xHCI screwup.
> Starting to suspect that an AMD chipset may be involved?
My motherboard is the ROG B450-f gaming. I am using the USB 3.0 ports of my=
 PCs case.

As I mentioned in the other message, the issue seems to be with the USB 3 m=
ode as setting `rtw88_usb.switch_usb_mode=3Dn` fixes the issue for me.
Are you using a USB 2 port for the adapter to be working properly without c=
onfiguration?=20

Best regards,
Samuil


