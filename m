Return-Path: <linux-wireless+bounces-24025-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE87AD652A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 03:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5341D164D59
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 01:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4F3847B;
	Thu, 12 Jun 2025 01:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="hDkPz4nG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5401E7DA7F
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 01:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749692020; cv=none; b=TKIR5p5l/52dfQaxNRM8yXo7qwTfg7VOktNKzHgfnKyFdH/W/MJ3e3Daa0i8wRJvaEuq7KUKlpM8o5U7rplmT4da1gbSNq/7JFx2k59VNtqD+yA1+S1A9zAeiX9ampw6Lh5uz1xawxJNFCgiKQbcR1IkFqlOsR4gOK1LtEvst14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749692020; c=relaxed/simple;
	bh=EchuUjnqiXCSOcYAS0fiB+61/agljlfNqxb+zBmv1P0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J57ZpoDTIZa/vu8/+FYtcugszPihiq3ZaoJHCAO8vSlwrPgZ9C+yicyxpz/F4RyiOUcOVBGIejdSjy2c6F8y3NWIs67IEJ6aHpTdyjiQ9F+6zkMPzdhyXhZwFNGgXvqEJeN56XNjwBaHMNKGh5jlBXVRjmVB8C3e9Q+LUlN4ccc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=hDkPz4nG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55C1XUqiC1638020, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749692010; bh=3JUOGespEQv0w0l5RmcyFIpujgCFQ3VNIZR5QgBmXCc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=hDkPz4nGA6wUwKcL0rLI8E18tvjbowKtmDHnXOqnmWOQByiDJRkqoruFSiTnPzhpd
	 VDo4cErkRux7/Glf4L26TrxKoDvTN3oFmPOdJ/cm5/ojn9Jq5uoGFDx00b1y+kehto
	 +2TA4e0eNBCPl3nikCS8fYPoteqtu4DGR0DMWYdSIsDZSqv6wz6JryGdMZDDHe4wCK
	 TAU65KLexdHE/RVxCc0s011KNs/SX3c2Ge5uyU4K5dpPSaeBQl4bj0jwdPGFzRzSbl
	 Mkyp3ciaNKVmbs1D8pU8OUli8dz6iGYS0yrDdnKOXrxYhi+/7yRRmfM1G5lkuw1rat
	 caTtoe+sH/XXg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55C1XUqiC1638020
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 09:33:30 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Jun 2025 09:33:29 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 12 Jun 2025 09:33:29 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Thu, 12 Jun 2025 09:33:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "lonthn@163.com" <lonthn@163.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [rtw89] PCI Passthrough Issue: rtl8852be on ARM VM (Ubuntu host/OpenWrt guest)
Thread-Topic: [rtw89] PCI Passthrough Issue: rtl8852be on ARM VM (Ubuntu
 host/OpenWrt guest)
Thread-Index: AQHb2t4ZVTHq2WpqB0Cl1dYfkss9mLP+soUQ
Date: Thu, 12 Jun 2025 01:33:29 +0000
Message-ID: <aca750d0c0094ba29fbef520eb1702aa@realtek.com>
References: <68499419.220006.00001@m16.mail.163.com>
In-Reply-To: <68499419.220006.00001@m16.mail.163.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

lonthn@163.com <lonthn@163.com> wrote:
> Hi rtw89 maintainers,
> I'm having trouble passing through an rtl8852be PCIe device to an ARM KVM=
 guest and hope you could help.
> Key details:
>=20
> =3D=3D=3D=3D Environment =3D=3D=3D=3D
> * Host: Ubuntu 5.10.160 (ARM)
> * Guest: Openwrt 6.6.73
> * Working case: Identical setup works for rtl8125 passthrough
>=20
> =3D=3D=3D=3D Issue =3D=3D=3D=3D
> Guest fails to initialize rtl8852be with timeout errors.
>=20
> =3D=3D=3D=3D Diagnostic snippets =3D=3D=3D=3D

[...]

> [  746.369036] rtw89_8852be 0000:06:00.0: Firmware version 0.29.29.5 (da8=
7cccd), cmd version 0, type 5
> [  746.373384] rtw89_8852be 0000:06:00.0: Firmware version 0.29.29.5 (da8=
7cccd), cmd version 0, type 3
> [  746.377254] rtw89_8852be 0000:06:00.0: [BTC] use version def[6] =3D 0x=
001d1d00
> [  747.783549] rtw89_8852be 0000:06:00.0: [ERR]FWDL path ready
> [  747.784119] rtw89_8852be 0000:06:00.0: [ERR]fwdl 0x1E0 =3D 0x23
> [  747.784652] rtw89_8852be 0000:06:00.0: [ERR]fwdl 0x83F0 =3D 0x70000

This looks like interoperability problem of 36-bit DMA.
If you have below commit in your guest OS:
1fd4b3fe52ef ("wifi: rtw89: pci: support 36-bit PCI DMA address")

Please also have below commit to rollback 32-bit DMA.
aa70ff0945fe ("wifi: rtw89: pci: early chips only enable 36-bit DMA on spec=
ific PCI hosts")

With the latest kernel, you can just comment code as below to use 32-bit DM=
A.

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireles=
s/realtek/rtw89/pci.c
index 204a3748d913..3d1a3ac4a1e6 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3141,7 +3141,7 @@ static int rtw89_pci_setup_mapping(struct rtw89_dev *=
rtwdev,
                goto err;
        }

-       if (!rtw89_pci_is_dac_compatible_bridge(rtwdev))
+       //if (!rtw89_pci_is_dac_compatible_bridge(rtwdev))
                goto try_dac_done;

        ret =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(36));

>=20
> =3D=3D=3D=3D Questions =3D=3D=3D=3D
> * Any known ARM passthrough quirks for this chip?

I have not ever tried passthrough, so I'm not sure if it can work.
Can I know how different the passthrough is?

Does rtl8852be work on host OS?

> * Suggested debug steps for error -100?

See my comment above.=20


