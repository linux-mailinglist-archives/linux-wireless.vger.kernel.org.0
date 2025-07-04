Return-Path: <linux-wireless+bounces-24807-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EFDAF860F
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 05:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3047561EBA
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 03:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B72433E1;
	Fri,  4 Jul 2025 03:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QXAQ0zJq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35812DE710
	for <linux-wireless@vger.kernel.org>; Fri,  4 Jul 2025 03:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751600183; cv=none; b=hcyN6IfAYFUIzRnB+nheO8mjsPTMEm3Qm7nmjiMXalfa7bItTbjmUomBXy+W0aj3fGAek/VGG7lq7KU/P4zEAakAbPEf2gxp30uxGTLVxEabkVquVlQfufqrArNK/Fts+yIOyBf4Q7kTvhKDXDV1+MmHgT+fiCdf1pM0LkTv3NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751600183; c=relaxed/simple;
	bh=PrYJwFbiRrySno+LiWN1F9s1eiwHCdJKO+v+lkGfinc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZZ+U075dZworrWQZck5p7yaDodDyvNHlhmpnV+QRzWmQMF+c5XjmvkRY6JdxOP8ktZOj8II+4roeDAQqCpR2Pbb2gpgrjbpC48NFX24MwRWZMD835Mg+gl7tGbbbVCoJjfuohZ8bdhHRsAyxhVo1pJyRHIdoW4g01CByeLlZeSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QXAQ0zJq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5643aGWT13659985, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1751600176; bh=ZspDmW5LTKBo9XfYMiB5jp7BomMKiL3nhprriTm6KBc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=QXAQ0zJqtnxUU9jl23cUeSBD8HzzDha7fXmVGbQP6u18WWTYRE0PnFQNRE8KMqS7r
	 p3xj9rVaNG2gwB4Z4hdhJy2obQGaWkOJBkQI7bKyRyf64p5TH+c+mciBLPSkMg10/J
	 D9eoxsXOi7jPg/UBDYMMbNvpIMYIhFm79StdX5I0LlaOPhnZcD2JrKcpXp6oS/TCUV
	 0rMtYyTQdOhKYsDl/HEpNQvpacbjgE3v/p25l8iUA/4pdBDo23TTOMTVORwGVcvWEA
	 Jx23QmJ6KxLjaWWT8EL2C7jXEq1UZsmF7dpzOpvXNd/sx5pFPmY3kZIJ5bEoXHMQc6
	 JN5IZKZooLGNQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5643aGWT13659985
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Jul 2025 11:36:16 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 4 Jul 2025 11:36:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 4 Jul 2025 11:36:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Fri, 4 Jul 2025 11:36:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v4 01/14] wifi: rtw89: 8851b: Accept USB devices and load their MAC address
Thread-Topic: [PATCH rtw-next v4 01/14] wifi: rtw89: 8851b: Accept USB devices
 and load their MAC address
Thread-Index: AQHb6f9ZonqUxzrxbE24spig7b0ZnrQgx8YAgACMDBA=
Date: Fri, 4 Jul 2025 03:36:40 +0000
Message-ID: <dde8077adb654294901a42ac078e5751@realtek.com>
References: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
 <6b2a1382-3be4-4038-8005-cf96922e4332@gmail.com>
 <69ad0a30-b5f6-4312-b4f4-317d715d5a25@RTEXMBS04.realtek.com.tw>
In-Reply-To: <69ad0a30-b5f6-4312-b4f4-317d715d5a25@RTEXMBS04.realtek.com.tw>
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

Ping-Ke Shih <pkshih@realtek.com> wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>=20
> > Make rtw8851b_read_efuse() accept USB devices and load the MAC address
> > from the correct offset.
> >
> > Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> > Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>=20
> 14 patch(es) applied to rtw-next branch of rtw.git, thanks.
>=20
> 4b6ea5a38197 wifi: rtw89: 8851b: Accept USB devices and load their MAC ad=
dress
> ee47816f24a1 wifi: rtw89: Make dle_mem in rtw89_chip_info an array
> 82870ba25f32 wifi: rtw89: Make hfc_param_ini in rtw89_chip_info an array
> 3c63450c8723 wifi: rtw89: Add rtw8851b_dle_mem_usb{2,3}
> 02a44c263031 wifi: rtw89: Add rtw8851b_hfc_param_ini_usb
> a3b871a0f7c0 wifi: rtw89: Disable deep power saving for USB/SDIO
> ec542d5e4bf6 wifi: rtw89: Add extra TX headroom for USB
> 0740c6beefae wifi: rtw89: Hide some errors when the device is unplugged
> e906a11753c9 wifi: rtw89: 8851b: Modify rtw8851b_pwr_{on,off}_func() for =
USB
> e2b71603333a wifi: rtw89: Fix rtw89_mac_power_switch() for USB
> ed88640ea1ac wifi: rtw89: Add some definitions for USB
> bd569751baff wifi: rtw89: Add usb.{c,h}

My work flow missed to build newly added usb.c, causing sparse warning.

Fixed by:

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireles=
s/realtek/rtw89/usb.c
index 72870a80f801..6cf89aee252e 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -210,7 +210,7 @@ static void rtw89_usb_write_port_complete(struct urb *u=
rb)
                txdesc =3D (struct rtw89_txwd_body *)skb->data;

                txdesc_size =3D rtwdev->chip->txwd_body_size;
-               if (u32_get_bits(txdesc->dword0, RTW89_TXWD_BODY0_WD_INFO_E=
N))
+               if (le32_get_bits(txdesc->dword0, RTW89_TXWD_BODY0_WD_INFO_=
EN))
                        txdesc_size +=3D rtwdev->chip->txwd_info_size;

                skb_pull(skb, txdesc_size);

And push out (force update):

ed88640ea1ac wifi: rtw89: Add some definitions for USB
2135c28be6a8 wifi: rtw89: Add usb.{c,h}
52cf44323785 wifi: rtw89: Add rtw8851bu.c
0030088148d5 wifi: rtw89: Enable the new USB modules


