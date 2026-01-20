Return-Path: <linux-wireless+bounces-30987-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 41861D3BDEE
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 04:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B987B343799
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 03:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97849326D46;
	Tue, 20 Jan 2026 03:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="F8I1/hap"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CCE32571C;
	Tue, 20 Jan 2026 03:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768879691; cv=none; b=HhAWUgXR93uT/talTpm7cxTEtBTJ4L/EVCjN4+H+LzYFYMchLE1vlMwYrMZ63YZMsjFQCxQoAlpcsJNdp21AaT0JYnsCwGqQjI0pgE4ifcQxq8wriwxsNOYEqu8qNONBhUj1VP39LuzPi/am26C3WyHPPQAQir2He8dxWAa4WQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768879691; c=relaxed/simple;
	bh=57yxWExWf9DdGJew7ZJzpPWV/JFc35CqMDeRgTOV4Ig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fq9iktHfQxw7eoFT8ePhqjO5C0fOEHoRhMN0Zy0m6WQDfO4BDp0rxQUCcPHXROEiz0K8qZpFhS0EGenhSVKMJgGSeBNgufFFDiYjYsTNTYowQcJTLbw2PgprRn+DmRUbj+N2z6H9Z6DM1Jc/hovxN63B9bfWYs7x3KRJcTT7xyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=F8I1/hap; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60K3RrroE119459, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768879673; bh=QJqnk6hd15h0kTZVHjR5QWlJawfpRsdJFCBG/95pjoQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=F8I1/hapSpck6KVeav5EbZtfxPPys2HmRcyzrtAuQrXoqi9ysghaXhQ28Q+iXxTps
	 8O2r9FaE5D1G0swFFCX0DNrP7xBOQB2YIhjYB8M8RTqI1Xd+5xHHCq/Z6DeKPgnZfI
	 C0yoAuGLidGRS1KYxHiLTXnAg59FxN8fR2cLd6EYq0zB41s6EI4njJc7T22FToTBh3
	 Xswc9z4pC0QuLEbozPx0vihzhYDCiDNDDMY0COj32pfydVfgyIGgmrsVFUPbSg8hQO
	 Hmj5opGG1jMSdfV0J8lfowW5pEpSxVUKOIlJhbkU2wF6CeK93nsGgGiYBBXdjD1+0u
	 bg43mTl3IGa9Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60K3RrroE119459
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 11:27:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 20 Jan 2026 11:27:54 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 20 Jan 2026 11:27:54 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([fe80::8bac:ef80:dea8:91d5]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::8bac:ef80:dea8:91d5%9]) with mapi id
 15.02.1748.010; Tue, 20 Jan 2026 11:27:54 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Zilin Guan <zilin@seu.edu.cn>, Ping-Ke Shih <pkshih@realtek.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jianhao.xu@seu.edu.cn" <jianhao.xu@seu.edu.cn>
Subject: RE: [PATCH v2] wifi: rtw89: debug: Fix memory leak in
 __print_txpwr_map()
Thread-Topic: [PATCH v2] wifi: rtw89: debug: Fix memory leak in
 __print_txpwr_map()
Thread-Index: AQHchulIg6QvmnQrbEyKhcpS3/LPa7VaatCg
Date: Tue, 20 Jan 2026 03:27:53 +0000
Message-ID: <e8e7b26c37084c418e2d6778c77ca100@realtek.com>
References: <20260116130834.1413924-1-zilin@seu.edu.cn>
In-Reply-To: <20260116130834.1413924-1-zilin@seu.edu.cn>
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
> Since the validation of max_valid_addr does not depend on the allocated
> memory, fix this by moving the vzalloc() call after the check.
>=20
> Compile tested only. Issue found using a prototype static analysis tool
> and code review.
>=20
> Fixes: 036042e15770 ("wifi: rtw89: debug: txpwr table supports Wi-Fi 7 ch=
ips")
> Suggested-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
> Changes in v2:
> - Move memory allocation after validation check to avoid leak.
>=20
>  drivers/net/wireless/realtek/rtw89/debug.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/debug.c
> b/drivers/net/wireless/realtek/rtw89/debug.c
> index 1264c2f82600..987eef8170f2 100644
> --- a/drivers/net/wireless/realtek/rtw89/debug.c
> +++ b/drivers/net/wireless/realtek/rtw89/debug.c
> @@ -825,10 +825,6 @@ static ssize_t __print_txpwr_map(struct rtw89_dev *r=
twdev, char
> *buf, size_t buf
>         s8 *bufp, tmp;
>         int ret;
>=20
> -       bufp =3D vzalloc(map->addr_to - map->addr_from + 4);
> -       if (!bufp)
> -               return -ENOMEM;
> -
>         if (path_num =3D=3D 1)
>                 max_valid_addr =3D map->addr_to_1ss;
>         else
> @@ -837,6 +833,10 @@ static ssize_t __print_txpwr_map(struct rtw89_dev *r=
twdev, char
> *buf, size_t buf
>         if (max_valid_addr =3D=3D 0)
>                 return -EOPNOTSUPP;
>=20
> +       bufp =3D vzalloc(map->addr_to - map->addr_from + 4);
> +       if (!bufp)
> +               return -ENOMEM;
> +
>         for (addr =3D map->addr_from; addr <=3D max_valid_addr; addr +=3D=
 4) {
>                 ret =3D rtw89_mac_txpwr_read32(rtwdev, RTW89_PHY_0, addr,=
 &val);
>                 if (ret)
> --
> 2.34.1

Looks good to me.
Thanks.

