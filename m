Return-Path: <linux-wireless+bounces-17202-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 804D0A069F8
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 01:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F85C1887FEC
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 00:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9204400;
	Thu,  9 Jan 2025 00:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="bq8zj36q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5CF290F;
	Thu,  9 Jan 2025 00:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736382966; cv=none; b=RhFh3rraA1ZAX6YEeHl3qZvvzSwtcbndI3XFx1LMJ5R+prnth6j3yOb5JxBrnaY1kNSjpZ4wFhw4Z5FH9SXkWtwhxMC/YYvGg83GL9tCS7Sek43kOIsJTdD451GuPmUrNcvrC2+WUrFkl0Pcl424mL9OtH9MV1XNmQlsrKT+zF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736382966; c=relaxed/simple;
	bh=9Q1N5J/1NEcKgDADZA9Vi+6K+DjGmntd/t4NYUvYmfE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P/AX/fU/Pd9HvOsirdE02JBE3XpFsN9nJQNCS3JGQNhA5ZcUZgaZQnR5b2n08la2EtYdoZlm551TuX4l+xUx7YPn+EwzxqSBJNYC6Ni4uCPY0Gq5Io1BmNtCva6ZAzK/xtf/3Y95b8uEW59zY98c9xAh0vg42q/sCmdNzrEETuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=bq8zj36q; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5090ZcZgA2164847, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736382938; bh=9Q1N5J/1NEcKgDADZA9Vi+6K+DjGmntd/t4NYUvYmfE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=bq8zj36qxCQH8fLkRre/dtd9vl2hCm+UiR3aaiLUVWBLOmynsQB4U3JBVR3rOyPNp
	 3xoMJtZnrPjSimndtsJANasnAI/e6hEsdxaW/tp4x3kHKO8AZNjTyztK0uCR7Ayljk
	 uNuqqL7EaTSbiMNzmNgkN7PhlM3M/xcyFamO7ak5mE2vHCjWb+VZFIwVp5YWH0UMvO
	 Tn4Va7yu1wxO7nkS2/rrW5rNocBHmhXlge2iWcvqxtcwr52tNSui54qe4o8xsT/MkG
	 tOECKq2KaoUExjddmFkGiEv5zfDPnMUxQfE7C3KQVJTmw0vDs3OjAnvgbcyHZkRJ+C
	 AWgkwDdGc/LDQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5090ZcZgA2164847
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2025 08:35:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 9 Jan 2025 08:35:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 Jan 2025 08:35:38 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 9 Jan 2025 08:35:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Liang Jie <buaajxlj@163.com>
CC: "kvalo@kernel.org" <kvalo@kernel.org>, Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liang Jie
	<liangjie@lixiang.com>
Subject: RE: [PATCH] wifi: rtw89: Correct immediate cfg_len calculation for scan_offload_be
Thread-Topic: [PATCH] wifi: rtw89: Correct immediate cfg_len calculation for
 scan_offload_be
Thread-Index: AQHbYbelQD6nlBZ8kEODdyqjTuTgYrMNlu2Q
Date: Thu, 9 Jan 2025 00:35:38 +0000
Message-ID: <9d4e83ffc0d348f2965390e8dab4f25e@realtek.com>
References: <20250108102512.3477461-1-buaajxlj@163.com>
In-Reply-To: <20250108102512.3477461-1-buaajxlj@163.com>
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

Liang Jie <buaajxlj@163.com> wrote:=20
> From: Liang Jie <liangjie@lixiang.com>
>=20
> This patch ensures the correct calculation of `cfg_len` prior to the

No "This patch". Just in imperative tense -- "Ensure ..."

> allocation of the skb in the `rtw89_fw_h2c_scan_offload_be` function,
> particularly when the `SCAN_OFFLOAD_BE_V0` firmware feature is enabled.
> It addresses an issue where an incorrect skb size might be allocated
> due to a delayed setting of `cfg_len`, potentially leading to memory
> inefficiencies.
>=20
> By moving the conditional check and assignment of `cfg_len` before skb
> allocation, the patch guarantees that `len`, which depends on `cfg_len`,
> is accurately computed, ensuring proper skb size and preventing any
> unnecessary memory reservation for firmware operations not supporting
> beyond the `w8` member of the command data structure.
>=20
> This correction helps to optimize memory usage and maintain consistent
> behavior across different firmware versions.
>=20
> Fixes: 6ca6b918f280 ("wifi: rtw89: 8922a: Add new fields for scan offload=
 H2C command")
>=20

No this blank line.=20

> Signed-off-by: Liang Jie <liangjie@lixiang.com>
> ---
>  drivers/net/wireless/realtek/rtw89/fw.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wirele=
ss/realtek/rtw89/fw.c
> index 2191c037d72e..5eb4beb9e485 100644
> --- a/drivers/net/wireless/realtek/rtw89/fw.c
> +++ b/drivers/net/wireless/realtek/rtw89/fw.c
> @@ -5169,7 +5169,7 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *=
rtwdev,
>         u8 macc_role_size =3D sizeof(*macc_role) * option->num_macc_role;
>         u8 opch_size =3D sizeof(*opch) * option->num_opch;
>         u8 probe_id[NUM_NL80211_BANDS];
> -       u8 cfg_len =3D sizeof(*h2c);
> +       u8 cfg_len;

In fact, SCAN_OFFLOAD_BE_V0 means `old` format used by `old' firmware versi=
on,
which isn't a main flow. I prefer to keep here unchanged, and modify cfg_le=
n
along with SCAN_OFFLOAD_BE_V0 for v0 firmware.=20

As existing patterns, this will be

	u8 cfg_len =3D sizeof(*h2c);
	u8 ver =3D U8_MAX;

	if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD_BE_V0, &rtwdev->fw))
		ver =3D 0;

	...

	if (ver =3D=3D 0)
		cfg_len =3D offsetofend(typeof(*h2c), w8);

	...

	if (ver =3D=3D 0)
		goto flex_member;

	...


>         unsigned int cond;
>         void *ptr;
>         int ret;
> @@ -5178,6 +5178,11 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev =
*rtwdev,
>=20
>         rtw89_scan_get_6g_disabled_chan(rtwdev, option);
>=20
> +       if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD_BE_V0, &rtwdev->fw))
> +               cfg_len =3D offsetofend(typeof(*h2c), w8);
> +       else
> +               cfg_len =3D sizeof(*h2c);
> +
>         len =3D cfg_len + macc_role_size + opch_size;
>         skb =3D rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
>         if (!skb) {
> @@ -5246,10 +5251,8 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev =
*rtwdev,
>                                            RTW89_H2C_SCANOFLD_BE_W8_PROBE=
_RATE_6GHZ);
>         }
>=20
> -       if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD_BE_V0, &rtwdev->fw)) {
> -               cfg_len =3D offsetofend(typeof(*h2c), w8);
> +       if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD_BE_V0, &rtwdev->fw))
>                 goto flex_member;
> -       }
>=20
>         h2c->w9 =3D le32_encode_bits(sizeof(*h2c) / sizeof(h2c->w0),
>                                    RTW89_H2C_SCANOFLD_BE_W9_SIZE_CFG) |
> --
> 2.25.1


