Return-Path: <linux-wireless+bounces-17991-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9869CA1D0E0
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 07:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF233165090
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 06:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D24BA42;
	Mon, 27 Jan 2025 06:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="AaR1FvOs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373AB157E99
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737958898; cv=none; b=Sk7bEUrlu0IrOg9KsZ97RqBLUrIvYl1i0/pUWFg34UmH1esMNIVjg9L10LzLDdKkD7Vm0s+h4tLbKI4LTt7onosg4lJs2NLAC5V5Es3AM0JnyUuoeViVFCOI1ukCSWyK17JopKEBufubREMFsYy/IKJTqwJe4XPNZsTS/w+ufKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737958898; c=relaxed/simple;
	bh=J20Ya2TJeCxCebl6bhYBk/DvAiAM9FwFN21mQtJypmg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JO40QUu6N1qtMyAdkGS4o4/vJiXSfnR7xL5k7L77a6Q/pm1O4XjgbCloJVgRRIPpY9782wJ68AHtSLD4nt3ZJ/D/rnxBhyrJQTFB8tZvgDyv5ZUFR412X2P9ZUVr6hEE4gqTlPMg8rcXJ+1vABBsaqcA2XJ4h8Of/bECmtTCL8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=AaR1FvOs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50R6LVxhC2601847, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737958891; bh=J20Ya2TJeCxCebl6bhYBk/DvAiAM9FwFN21mQtJypmg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=AaR1FvOslihdFjwpeQfWAVNTzNY6/BYyMJwoyH54RB0GVd2rkz1QBnisARSyOhkeb
	 y62Vv+uQMbcwcxSsIpuM3GiijAmyrnncD+UT9HyRel6uJQZbXvVUnq+WQNZ7QSFBZ9
	 KCxZJz5ctUGnEjmJn9gMamHVMGWukuCItBQNK8tjTrIufx9DvlpLqs2Fy/3jFjv1pr
	 fw02g7EqxVe32thGCeXLTPxEUWN7XjNItNhzXR2rFD968qrbZAjtWvBCGC5pXNCZV1
	 krVYBZWcFtWqysXuS7TnJiYwL5bYRtbRQH4/J1g1bmdJHqa+uki3QEweFvpFT8j3/x
	 XG1yGVsQxPnSA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50R6LVxhC2601847
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 14:21:31 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 Jan 2025 14:21:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 27 Jan 2025 14:21:31 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Mon, 27 Jan 2025 14:21:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/7] wifi: rtw88: Fix download_firmware_validate() for RTL8814AU
Thread-Topic: [PATCH 2/7] wifi: rtw88: Fix download_firmware_validate() for
 RTL8814AU
Thread-Index: AQHbcEVW4WI+PGutCUSeZUY9/wPv/7MqJa3X
Date: Mon, 27 Jan 2025 06:21:31 +0000
Message-ID: <8b20c46bf6ae49829e6d04ff5b561482@realtek.com>
References: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>,<a157faf6-16f4-41bd-a29f-0d8db7940e1b@gmail.com>
In-Reply-To: <a157faf6-16f4-41bd-a29f-0d8db7940e1b@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
> After the firmware is uploaded, download_firmware_validate() checks some
> bits in REG_MCUFW_CTRL to see if everything went okay. The
> RTL8814AU power on sequence sets bits 13 and 12 to 2, which this
> function does not expect, so it thinks the firmware upload failed.
>=20
> Make download_firmware_validate() ignore bits 13 and 12.
>=20
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>=20

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Memo some traces from vendor driver:

For most chips, poll firmware ready by
   while (HALMAC_REG_R16(REG_MCUFW_CTRL) !=3D 0xC078)
  =20
Other chips check ready by
   while ((HALMAC_REG_R16(REG_MCUFW_CTRL) & 0xC078) !=3D 0xC078)

And, for all chips, BIT 12-13 are defined as CPU_CLK_SEL, so
I think this change is well.=20

