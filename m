Return-Path: <linux-wireless+bounces-1649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB115829374
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 06:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A70C28903C
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 05:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9454DF55;
	Wed, 10 Jan 2024 05:48:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4C3DDD5
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 05:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40A5mSuQ5860907, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40A5mSuQ5860907
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 13:48:30 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 10 Jan 2024 13:48:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 10 Jan 2024 13:48:28 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Wed, 10 Jan 2024 13:48:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Li Lin Mao <lilinmao@kylinos.cn>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "kvalo@kernel.org" <kvalo@kernel.org>
Subject: RE: [PATCH v2] wifi: rtw89: 8852b: avoid reporting errors by cppcheck
Thread-Topic: [PATCH v2] wifi: rtw89: 8852b: avoid reporting errors by
 cppcheck
Thread-Index: AQHaQ3v5NQKCFMN/G0mgePLSUJwh3rDSh6og
Date: Wed, 10 Jan 2024 05:48:28 +0000
Message-ID: <92f7e7f317bf4e6bb68ce385b0c1e119@realtek.com>
References: <20240110041736.2809393-1-lilinmao@kylinos.cn>
In-Reply-To: <20240110041736.2809393-1-lilinmao@kylinos.cn>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback


> -----Original Message-----
> From: Li Lin Mao <lilinmao@kylinos.cn>
> Sent: Wednesday, January 10, 2024 12:18 PM
> To: linux-wireless@vger.kernel.org
> Cc: Ping-Ke Shih <pkshih@realtek.com>; kvalo@kernel.org; Li Lin Mao <lili=
nmao@kylinos.cn>
> Subject: [PATCH v2] wifi: rtw89: 8852b: avoid reporting errors by cppchec=
k

The subject should specify what you are fixing. If you send two patches to
correct two different cppcheck errors, how can we address their differences
by subject? I mean your subject is too common, like checkpatch.pl will
throw out warning if cppcheck is added:

# Check email subject for common tools that don't need to be mentioned
                if ($in_header_lines &&
                    $line =3D~ /^Subject:.*\b(?:checkpatch|sparse|smatch)\b=
[^:]/i) {
                        WARN("EMAIL_SUBJECT",
                             "A patch subject line should describe the chan=
ge not the tool that found it\n" . $herecurr);
                }

>=20
> Due to some reasons in cppcheck, the following issues might be reported:

I think you can mention the "reason" -- out of bounds.=20

> drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c:1414:22: error: Array
>  'iqk_info->iqk_mcc_ch[2][4]' accessed at index iqk_info->iqk_mcc_ch[2][*=
],
> which is out of bounds. [arrayIndexOutOfBounds]
>  iqk_info->iqk_mcc_ch[idx][path] =3D chan->channel;
>                      ^
> drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c:1393:2: note: After for
> loop, idx has value 2
>  for (idx =3D 0; idx < RTW89_IQK_CHS_NR; idx++) {
>  ^
> drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c:1414:22: note: Array in=
dex
> out of bounds
>  iqk_info->iqk_mcc_ch[idx][path] =3D chan->channel;
>                      ^
> drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c:1424:38: error: Array
> 'iqk_info->iqk_mcc_ch[2][4]' accessed at index iqk_info->iqk_mcc_ch[2][*]=
,
> which is out of bounds. [arrayIndexOutOfBounds]
>       idx, path, iqk_info->iqk_mcc_ch[idx][path]);
>                                      ^
> drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c:1393:2: note: After for
> loop, idx has value 2
>  for (idx =3D 0; idx < RTW89_IQK_CHS_NR; idx++) {
>  ^
> drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c:1424:38: note: Array in=
dex
> out of bounds
>       idx, path, iqk_info->iqk_mcc_ch[idx][path]);
>                                      ^
> But actually this might be a false alarm. We avoided it in some way.
>=20
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Sorry. I have not signed this patch. Please remove my s-o-b.

> Signed-off-by: Li Lin Mao <lilinmao@kylinos.cn>
> ---
>  drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
> b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
> index 259df67836a0..03169287667c 100644
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
> +       if (idx >=3D RTW89_IQK_CHS_NR) {
>                 idx =3D iqk_info->iqk_table_idx[path] + 1;
>                 if (idx > 1)
>                         idx =3D 0;

rtw8852a has similar problem. Doesn't cppcheck report the same warning?



