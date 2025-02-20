Return-Path: <linux-wireless+bounces-19162-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7E9A3D10E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 06:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2413B8937
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 05:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00F8A930;
	Thu, 20 Feb 2025 05:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="vBLahzhP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B711DFE3A
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 05:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740031181; cv=none; b=XK5kCMktPjFRB+/49uKt822MrV8fgy651hNLPjMLRdL4LXvdEL6lNxF2Zk78pmG5k3tLVOma5XsXUSgsrVQxGcHk/JAIJznSLVkSB1Gb89hRGERKBmGFGHOckzGRo8ualqsqllWt6klKkg+rj9emkSUFsImKimd3lQ4e2vOvXvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740031181; c=relaxed/simple;
	bh=ANwUqt/kFklhu1/Qe0bC1+QScla73JVxrJjYpIZEMq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=irRzoMtHuyMjBNwKRyBACHmMXU/xXQefQ9RY5fFeZPCxXSIXSn/uiQUhLV07RrGtVPFR2I587qGf17UMUeumX/LJ8ODBN6pCiHlUANe0dR9IX+tQjvfJZHAz29ISQKK+2lTK9AmN7qbzcJI8RPqBPi6SzxFRJo4pk3yTByj7w5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=vBLahzhP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51K5wjmyF641757, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740031125; bh=ANwUqt/kFklhu1/Qe0bC1+QScla73JVxrJjYpIZEMq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=vBLahzhP883HnOtPPKNCTN/9IjcSHMGOIhucDJlkHlp2rLVvqjgjtwXR7ZwwPyAte
	 8XzVufdre1LsAk6kfRBiw3PR3LtABfMxsI1vsGd2dCfJkoElutEtzP2cKffE/chJAZ
	 byQrpKXim84Yji7LxsD2dDM9KC2apZn9CA4ri8DlxV3WSPVZA9SpQd+kRszYCkNI60
	 HPX4Uv+DownaOXfb7I57TxBObbyfZTqjOS2PjpWSN3sVnlXk+qR7Gti8kRSdGYP+tl
	 iGUQNaIis5C6kMPA3igQ6R8DWBYCPL3IvL6UueI7DvWerHC3Rvy3GiuaB+40bkA9zl
	 t0XnE0NYwC3AA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51K5wjmyF641757
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 13:58:45 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Feb 2025 13:58:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 20 Feb 2025 13:58:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Thu, 20 Feb 2025 13:58:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ezra Buehler <ezra@easyb.ch>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Martin Kaistra <martin.kaistra@linutronix.de>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        "Reto
 Schneider" <reto.schneider@husqvarnagroup.com>,
        Ezra Buehler
	<ezra.buehler@husqvarnagroup.com>
Subject: RE: [PATCH v1 1/3] wifi: rtl8xxxu: Use macid in rtl8xxxu_update_rate_mask()
Thread-Topic: [PATCH v1 1/3] wifi: rtl8xxxu: Use macid in
 rtl8xxxu_update_rate_mask()
Thread-Index: AQHbgvcQVMMTakvYoUuUBi0LqFGun7NPshHw
Date: Thu, 20 Feb 2025 05:58:45 +0000
Message-ID: <f074400009fd41efaeadabca58b9f21b@realtek.com>
References: <20250219175228.850583-1-ezra@easyb.ch>
 <20250219175228.850583-2-ezra@easyb.ch>
In-Reply-To: <20250219175228.850583-2-ezra@easyb.ch>
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

Ezra Buehler <ezra@easyb.ch> wrote:
> From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
>=20
> This is needed in order for AP mode to work correctly on gen1 devices
> like the RTL8192CU.
>=20
> For more information, see the corresponding change for gen2 devices,
> commit 769f326322e7 ("wifi: rtl8xxxu: Add parameter macid to
> update_rate_mask").
>=20
> Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> index 569856ca677f..cbd9efd22e3f 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> @@ -4606,7 +4606,7 @@ void rtl8xxxu_update_rate_mask(struct rtl8xxxu_priv=
 *priv,
>         h2c.ramask.mask_lo =3D cpu_to_le16(ramask & 0xffff);
>         h2c.ramask.mask_hi =3D cpu_to_le16(ramask >> 16);
>=20
> -       h2c.ramask.arg =3D 0x80;
> +       h2c.ramask.arg =3D macid | 0x80;

Vendor driver fills macid and sgi as below:=20

		arg =3D mac_id&0x1f;//MACID
	=09
		arg |=3D BIT(7);
	=09
		if (shortGIrate=3D=3D_TRUE)
			arg |=3D BIT(5);

So, I suggest to define a mask and use u8_encode_bit() for macid.



