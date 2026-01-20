Return-Path: <linux-wireless+bounces-30988-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C11D3BDF1
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 04:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B46634E4C24
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 03:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B9719F12D;
	Tue, 20 Jan 2026 03:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="O5n64w38"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE06249E5;
	Tue, 20 Jan 2026 03:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768879869; cv=none; b=RxnlY0s3P39PR5OYhXAHfFu0rwxy4VT3SG73G5BC/1X5hfEsBfhwquxfaKymX4Hg7pIruIeSI8OhGTnrRUKqvp8tK2b47Je3d78EPyiSUUqjyNY+PyMexlB1rmb3RTYrIFZTOsadAbAUXbrLW2Q6PhFebNU0UVPz8xwuBwwNUS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768879869; c=relaxed/simple;
	bh=89SNeZSKIZnrhOxheos4qC+ZPvul7P4OwKPJaKpjUs0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FqzCZ66nhYKBP7xUyknbO2be7B9GIg8sBEXYbLHtRZ23orkkK3iW/0Gb4nj5rJpxB3ykCro9XBRmSGqfKUNzYCuMf+bOm6iUIbMr2j0qzYz/I9i9oIWQ1Nr6UYCb9tpoaSSwyTaz0/H/riDHs/mJQtMTpNfFS6TkIWmmxIufHIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=O5n64w38; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60K3V3JJ0122998, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768879863; bh=Zho3RKAqUNMAsvP1xZPhsLMthJD5aNQUoVvDSeiiEhI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=O5n64w38AB4sHIwcqr02dykEdRl4N1bWMMnkDJ8GT1n3EcN2McrOIHxTKPRsjBOlP
	 SPHLauGQMhSOVoXWL85BKri/ZVSSAqRaCL2Kyf0QaQRx1I6cUWNM8KD6wlGAdQ6N7v
	 d9Fw6Xnx7b9ztDzzxdzuhGVwu3WNe6+xbcvUovzl1hBCSO5MQZS6YZvJRh8m+yAlln
	 p3UqtiOsmoWTiHFVyIboQkJGI0+zaYokz+oGwBlOESEjtecBzXIRYnIwJQlugDSsQL
	 JTRL9y3IDuN1GLSkDPJC3EwXQViBGly45SQkNx743/x6Uu4D7yZ/XR8zsUtPIhU/Bq
	 92hHrW63keIvQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60K3V3JJ0122998
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 11:31:03 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 20 Jan 2026 11:31:03 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 20 Jan 2026 11:31:03 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Tue, 20 Jan 2026 11:31:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zong-Zhe Yang <kevin_yang@realtek.com>, Zilin Guan <zilin@seu.edu.cn>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jianhao.xu@seu.edu.cn" <jianhao.xu@seu.edu.cn>
Subject: RE: [PATCH v2] wifi: rtw89: debug: Fix memory leak in
 __print_txpwr_map()
Thread-Topic: [PATCH v2] wifi: rtw89: debug: Fix memory leak in
 __print_txpwr_map()
Thread-Index: AQHchulI9KtNnd3ZlECoRUKHPhUG5rVZ5ZaAgACGo7A=
Date: Tue, 20 Jan 2026 03:31:02 +0000
Message-ID: <1127a2bb3b86437e82cf4b46c1a73f44@realtek.com>
References: <20260116130834.1413924-1-zilin@seu.edu.cn>
 <e8e7b26c37084c418e2d6778c77ca100@realtek.com>
In-Reply-To: <e8e7b26c37084c418e2d6778c77ca100@realtek.com>
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


Zong-Zhe Yang <kevin_yang@realtek.com> wrote:
> Zilin Guan <zilin@seu.edu.cn> wrote:
> >
> > In __print_txpwr_map(), memory is allocated to bufp via vzalloc().
> > If max_valid_addr is 0, the function returns -EOPNOTSUPP immediately
> > without freeing bufp, leading to a memory leak.
> >
> > Since the validation of max_valid_addr does not depend on the allocated
> > memory, fix this by moving the vzalloc() call after the check.
> >
> > Compile tested only. Issue found using a prototype static analysis tool
> > and code review.
> >
> > Fixes: 036042e15770 ("wifi: rtw89: debug: txpwr table supports Wi-Fi 7 =
chips")
> > Suggested-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> > Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> > ---
> > Changes in v2:
> > - Move memory allocation after validation check to avoid leak.
> >
> >  drivers/net/wireless/realtek/rtw89/debug.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/wireless/realtek/rtw89/debug.c
> > b/drivers/net/wireless/realtek/rtw89/debug.c
> > index 1264c2f82600..987eef8170f2 100644
> > --- a/drivers/net/wireless/realtek/rtw89/debug.c
> > +++ b/drivers/net/wireless/realtek/rtw89/debug.c
> > @@ -825,10 +825,6 @@ static ssize_t __print_txpwr_map(struct rtw89_dev =
*rtwdev, char
> > *buf, size_t buf
> >         s8 *bufp, tmp;
> >         int ret;
> >
> > -       bufp =3D vzalloc(map->addr_to - map->addr_from + 4);
> > -       if (!bufp)
> > -               return -ENOMEM;
> > -
> >         if (path_num =3D=3D 1)
> >                 max_valid_addr =3D map->addr_to_1ss;
> >         else
> > @@ -837,6 +833,10 @@ static ssize_t __print_txpwr_map(struct rtw89_dev =
*rtwdev, char
> > *buf, size_t buf
> >         if (max_valid_addr =3D=3D 0)
> >                 return -EOPNOTSUPP;
> >
> > +       bufp =3D vzalloc(map->addr_to - map->addr_from + 4);
> > +       if (!bufp)
> > +               return -ENOMEM;
> > +
> >         for (addr =3D map->addr_from; addr <=3D max_valid_addr; addr +=
=3D 4) {
> >                 ret =3D rtw89_mac_txpwr_read32(rtwdev, RTW89_PHY_0, add=
r, &val);
> >                 if (ret)
> > --
> > 2.34.1
>=20
> Looks good to me.

I suppose I can add=20
Reviewed-by: Zong-Zhe Yang <kevin_yang@realtek.com>

Okay?


