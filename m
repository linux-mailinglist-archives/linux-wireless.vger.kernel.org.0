Return-Path: <linux-wireless+bounces-30903-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25084D2DF7E
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 09:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B870B30245A2
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 08:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2AD3016E9;
	Fri, 16 Jan 2026 08:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="kxzCb6OY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960FC2F5461;
	Fri, 16 Jan 2026 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551841; cv=none; b=mThTtjp/Bts/kCNAfgbUKSsp3MUKxGxZFKAG3LQFFVM9Dasm8f+hkvu/CX5gQgyOdtK5VJRN+1xoAlA3serqfaQ8GQeVtTmCx5jAxGRcdPbFG3LzEKgeRXPZXzi0k4yz+9vfXlES2Igg2PTNLkwYk28QptJPSoJe656uwq1dX4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551841; c=relaxed/simple;
	bh=ca49IZgqV10Zwl/3iVGGXa0hdHdKchHm8reUZ2/3prk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bdn7FdWGER+5U3EabaTgxYdc5AJmcJa7CZ8o6776nVOTCBNkppYesqXhDa9WxDGie+jevo7FLGvQ4Ks8FDQqnNzydrJ+OpcCRfqflmQZJP1ys+MkG3eMSSzaoqudAc0In0v4M03q3/2REkqEopbO+1ei89Ql/j5JV5qv159awbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=kxzCb6OY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60G8NvgM6691823, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768551837; bh=IqIuquVZhXBDm1+IhN8RBzboXlwGMcahQmm4+cyTQIc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=kxzCb6OYVf/bSGvvTxf7kLNQD9nXdZfyirPrWjy5DN/EdlpArgk4HyK9hhfASMBIW
	 gFzLXeQ3b+gkABnwQMxGUeTakeA5hSWZgRmlXJ+Z7QSgY9cEj0a2A6H77DXxQF2Gp2
	 I3s4d2xn6pSfRSzdSetM0KuORGYj+CMdmADTaOLvsUaoitILI8tM7X49SSPlYai1Pn
	 pB63FWHdZ//jny/v/YKaKUeVwR7mVmN9oXOshJeB5KsAjBNBRyRKIh1Lj1ZixFT6Hd
	 eO6B5hcSmeEmIoRGkR9Ud3S14ImANZcqO6wqyyRwsRPhUe7DyX9NVjfHap+edPnrgD
	 LHuVg4pcxUCyw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60G8NvgM6691823
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 16:23:57 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 16 Jan 2026 16:23:57 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([fe80::8bac:ef80:dea8:91d5]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::8bac:ef80:dea8:91d5%9]) with mapi id
 15.02.1748.010; Fri, 16 Jan 2026 16:23:57 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Zilin Guan <zilin@seu.edu.cn>, Ping-Ke Shih <pkshih@realtek.com>
CC: "jianhao.xu@seu.edu.cn" <jianhao.xu@seu.edu.cn>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: debug: Fix memory leak in
 __print_txpwr_map()
Thread-Topic: [PATCH] wifi: rtw89: debug: Fix memory leak in
 __print_txpwr_map()
Thread-Index: AQHchr0WflTXzBa1CkaZ7RXjavv0q7VUcp3Q
Date: Fri, 16 Jan 2026 08:23:57 +0000
Message-ID: <2df4d692f5804c8ca87d3cd26b37081e@realtek.com>
References: <20260116074836.1199951-1-zilin@seu.edu.cn>
In-Reply-To: <20260116074836.1199951-1-zilin@seu.edu.cn>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Zilin Guan <zilin@seu.edu.cn> wrote:
>=20
> In __print_txpwr_map(), memory is allocated to bufp via vzalloc().
> If max_valid_addr is 0, the function returns -EOPNOTSUPP immediately
> without freeing bufp, leading to a memory leak.
>=20
> Fix this by freeing the temporary buffer bufp in the error path.
>=20
> Compile tested only. Issue found using a prototype static analysis tool
> and code review.
>=20
> Fixes: 036042e15770 ("wifi: rtw89: debug: txpwr table supports Wi-Fi 7 ch=
ips")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
>  drivers/net/wireless/realtek/rtw89/debug.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/debug.c
> b/drivers/net/wireless/realtek/rtw89/debug.c
> index 1264c2f82600..c7bd1d0212b6 100644
> --- a/drivers/net/wireless/realtek/rtw89/debug.c
> +++ b/drivers/net/wireless/realtek/rtw89/debug.c
> @@ -834,8 +834,10 @@ static ssize_t __print_txpwr_map(struct rtw89_dev *r=
twdev, char
> *buf, size_t buf
>         else
>                 max_valid_addr =3D map->addr_to;
>=20
> -       if (max_valid_addr =3D=3D 0)
> +       if (max_valid_addr =3D=3D 0) {
> +               vfree(bufp);
>                 return -EOPNOTSUPP;
> +       }

Thank you for catching this.
Since the decision for max_valid_addr doesn't depend on bufp,
how about moving vzalloc down here ?

>=20
>         for (addr =3D map->addr_from; addr <=3D max_valid_addr; addr +=3D=
 4) {
>                 ret =3D rtw89_mac_txpwr_read32(rtwdev, RTW89_PHY_0, addr,=
 &val);
> --
> 2.34.1
>=20


