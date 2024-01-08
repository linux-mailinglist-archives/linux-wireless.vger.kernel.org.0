Return-Path: <linux-wireless+bounces-1561-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7865C826732
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 02:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F3DCB21557
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 01:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90104B642;
	Mon,  8 Jan 2024 01:49:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73F4B641
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 01:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4081n7I313626579, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4081n7I313626579
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jan 2024 09:49:08 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 8 Jan 2024 09:49:07 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 8 Jan 2024 09:49:07 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8]) by
 RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8%5]) with mapi id
 15.01.2375.007; Mon, 8 Jan 2024 09:49:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: lilinmao <lilinmao@kylinos.cn>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "kvalo@kernel.org" <kvalo@kernel.org>
Subject: RE: [PATCH] wifi: rtw89: 8852b: fix cppcheck issues
Thread-Topic: [PATCH] wifi: rtw89: 8852b: fix cppcheck issues
Thread-Index: AQHaP8RbPkhvE92icEK7ZcmuR2v5v7DPJ5RQ
Date: Mon, 8 Jan 2024 01:49:07 +0000
Message-ID: <fa53ebc977c9494496c16e311f5a3ad2@realtek.com>
References: <20240105104542.463834-1-lilinmao@kylinos.cn>
In-Reply-To: <20240105104542.463834-1-lilinmao@kylinos.cn>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback



> -----Original Message-----
> From: lilinmao <lilinmao@kylinos.cn>
> Sent: Friday, January 5, 2024 6:46 PM
> To: linux-wireless@vger.kernel.org
> Cc: Ping-Ke Shih <pkshih@realtek.com>; kvalo@kernel.org; lilinmao <lilinm=
ao@kylinos.cn>
> Subject: [PATCH] wifi: rtw89: 8852b: fix cppcheck issues

The subject doesn't address the problem or describe the changes you made.=20
Maybe, you can say "fix out of bounds of iqk_mcc_ch[][] array", but actuall=
y
cppcheck reported a false alarm, doesn't it?

[...]

> Signed-off-by: lilinmao <lilinmao@kylinos.cn>

You should give your real name here as well as "From:" field.=20

> ---
>  drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
> b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
> index 259df67836a0..03dec3f4e7ba 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
> @@ -1388,17 +1388,15 @@ static void _iqk_get_ch_info(struct rtw89_dev *rt=
wdev, enum rtw89_phy_idx phy, u
>         u32 reg_rf18;
>         u32 reg_35c;
>         u8 idx;
> -       u8 get_empty_table =3D false;
>=20
>         for (idx =3D 0; idx < RTW89_IQK_CHS_NR; idx++) {
>                 if (iqk_info->iqk_mcc_ch[idx][path] =3D=3D 0) {
> -                       get_empty_table =3D true;
>                         break;
>                 }
>         }
>         rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] (1)idx =3D %x\n", idx);
>=20
> -       if (!get_empty_table) {
> +       if (idx > RTW89_IQK_CHS_NR - 1) {
>                 idx =3D iqk_info->iqk_table_idx[path] + 1;
>                 if (idx > 1)
>                         idx =3D 0;

The original logic looks like

bool found =3D false;

for (idx =3D 0; idx < RTW89_IQK_CHS_NR; idx++)
     if (expr) {
		found =3D true;
		break;
	}

if (!found) {=20
	... [A]
}

So, idx >=3D RTW89_IQK_CHS_NR must fall into branch [A]. Can you report thi=
s
pattern to cppcheck?

Ping-Ke=20


