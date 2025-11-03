Return-Path: <linux-wireless+bounces-28476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 826CFC29C52
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 02:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2B7533450D5
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 01:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA3A271443;
	Mon,  3 Nov 2025 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="bpfadUeE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF7086334;
	Mon,  3 Nov 2025 01:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762132636; cv=none; b=kjbSTb0Wbv2fdcpBzt4C4mlk2wve71SR1dePgv1rNTzAQnEDaFS2VzdoeG69jNCRvmzFVCajR8ZwthOANke/mDCP0nj8RTgoJOgOMeB3fhaJs7ifYdXmWDknohstxHjTF16tUdo4lei1RdnPHx5dv1TapCFgYeS67Q6qTAmgkbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762132636; c=relaxed/simple;
	bh=4R7tTrPB599Lq1pscObtmhgAovA9NIF1vQfHeXM8dpc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iiMFX4iuFHP/ZvRTEl5FDfD8C14SYy51ae6GRv3q9mTlIDaOtjwSUmFX0tXV6vXFiPhYDSE2KRPwJ0X/u4PbwOkx1TM7a33e1dcVTsQJV8gi6AqFIsC6grU/pUw6iSgA9fzdVXLwo4ZgkOrMoGn0xkD8tmV3TC5oE2HmFshwJXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=bpfadUeE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A31H7F20538960, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762132627; bh=UuF+p8aMoeYMKRW3GJPXUnskNsyDTfAWc5P8vQuQO9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=bpfadUeEhHGjmwdJogrpLzWHKVeE6BdKoQ/u9+3rMuG9piESZbousx9DuiPchxg0g
	 iAaf3ypIUaMDrDap8M1lLQsFGtY9s443BhXGMV74x3zCaEOdGrzWcNiunlzI8NZZtf
	 eErkK4mICBp2IixLOWw2B2Q/SQeHFsRtjTwSEWrqXKHz88cSklX6UTEbeUP4jWRYt1
	 Zao3/h+uICEqJ/trIyCuXtbth5UACp3bssScGZNR/G0YePtEWJATNDaFeyXJhL1V/u
	 d7DCEf1FFDVycHYXV2Z4kwtLUkz7acBz7dmfTkJ/e2GS1gn7/KPOhhVFN4DEKwxf/K
	 UW1uy0ilfAyxA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A31H7F20538960
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Nov 2025 09:17:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 3 Nov 2025 09:17:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 3 Nov 2025 09:17:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Mon, 3 Nov 2025 09:17:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Harshit Mogalapalli
	<harshit.m.mogalapalli@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] rtlwifi: rtl8188ee: remove an accidental '-' character
Thread-Topic: [PATCH] rtlwifi: rtl8188ee: remove an accidental '-' character
Thread-Index: AQHcSmbpgJ0klacK4UCTMB6Tyko8vbTgKWCw
Date: Mon, 3 Nov 2025 01:17:07 +0000
Message-ID: <8d6962531a9545fd8279fbc7cd04340c@realtek.com>
References: <aQSz3KnK4wFIJoe3@stanley.mountain>
In-Reply-To: <aQSz3KnK4wFIJoe3@stanley.mountain>
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

Dan Carpenter <dan.carpenter@linaro.org> wrote:
> Sent: Friday, October 31, 2025 9:04 PM
> The "->allstasleep" variable is a 1 bit bitfield.  It can only be
> 0 or 1.  This "=3D -1" assignement was supposed to be "=3D 1".  This
> doesn't change how the code works, it's just a cleanup.

Yes, this patch doesn't change logic at all. However, it looks like existin=
g
code is wrong, since other places in the same pattern in this driver set to=
 0.
More, I check vendor driver which also sets this value to 0.

>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> Found with a static checker rule that Harshit and I wrote.
>=20
>  drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
> b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
> index 7252bc621211..7ef57b1c674c 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
> @@ -694,7 +694,7 @@ void rtl88e_set_p2p_ps_offload_cmd(struct ieee80211_h=
w *hw, u8 p2p_ps_state)
>=20
>                         if (P2P_ROLE_GO =3D=3D rtlpriv->mac80211.p2p) {
>                                 p2p_ps_offload->role =3D 1;
> -                               p2p_ps_offload->allstasleep =3D -1;
> +                               p2p_ps_offload->allstasleep =3D 1;
>                         } else {
>                                 p2p_ps_offload->role =3D 0;
>                         }
> --
> 2.51.0


