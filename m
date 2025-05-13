Return-Path: <linux-wireless+bounces-22879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E9CAB48B6
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 03:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945BD3A7740
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 01:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE89170A11;
	Tue, 13 May 2025 01:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="piFci/E8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFF5EEA6;
	Tue, 13 May 2025 01:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747099140; cv=none; b=GikiP2EczUZi8bGRHI6vegN0bB1WXFokPsL2Sk4BfCQDQI56QuywQCruagZrwN/3CgOSy8QwAuF7BlccjKUxgtX0PoZPClr39jHzTRPtUv1bOLse2tyeu0CB1qIgZS3VfJHdCuUI3F34WUbIf6a9TsNxlVcej3WGk4dLAPbsnvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747099140; c=relaxed/simple;
	bh=pyfuiCMB2ninRXDR4/H6qlyDteVXJ3oMN4nnLFi0hF4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X0qO2gpUMQZyFzZUS/kIgHtApnuu1y4rZ/TxHn6LPLEvT/P2nHkbUbZFRtXV3iu049sbvKC17my+UtfKWMmuGDz10jU79KzOYP4gJi8HoqavjZdF7Yx2MJP2Mv7tfWddSgtJJZxhBch1bIFZRTwEGyMXhX0hNLlXoHXx7kyY034=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=piFci/E8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54D1IcwI63420062, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747099118; bh=pyfuiCMB2ninRXDR4/H6qlyDteVXJ3oMN4nnLFi0hF4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=piFci/E8rTC3+bCyF/i2CuiuvtpoSFL34G8RoTVyutLYVVUFqDOcITH/BzDMjOeHf
	 +yZO/W8zciLDKTdmks9KVYD0D4qE1ANsDUGgo4BlQZd6ltO/um3DWsLzPqM8Zhoxip
	 GugmBo0YxSR1XTUjhr9AnE+GP/yIMx3M36FwdHn/4QJOz6XjaPyOu1y+0sMh3m8dRW
	 SuPObChHup2LK7EqEYOdH12pgtooCRmLEYX813cUNeXbWMPA0UxdNO5u7j2mB5PRRe
	 a2wGS92j9QACEdikPQ6au78y78Vl9XU3jVeuourSy+OQmuuYvzhySULWfEAd9L8Xk1
	 N04/+HdMG9MMA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54D1IcwI63420062
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 09:18:38 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 May 2025 09:18:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 May 2025 09:18:38 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 13 May 2025 09:18:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Kalle Valo
	<kvalo@kernel.org>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>
Subject: RE: [PATCH] wifi: rtw88: fix the 'para' buffer size to avoid reading out of bounds
Thread-Topic: [PATCH] wifi: rtw88: fix the 'para' buffer size to avoid reading
 out of bounds
Thread-Index: AQHbw0sjyu5rq8WqSEO8oYP+FaXu/bPPwrVg
Date: Tue, 13 May 2025 01:18:38 +0000
Message-ID: <56143c6a5eb94431abb4431a5acdbf36@realtek.com>
References: <20250512143337.54199-1-aleksei.kodanev@bell-sw.com>
In-Reply-To: <20250512143337.54199-1-aleksei.kodanev@bell-sw.com>
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

Alexey Kodanev <aleksei.kodanev@bell-sw.com> wrote:
> Set the size to 6 instead of 2, since 'para' array is passed to
> 'rtw_fw_bt_wifi_control(rtwdev, para[0], &para[1])', which reads
> 5 bytes:
>=20
> void rtw_fw_bt_wifi_control(struct rtw_dev *rtwdev, u8 op_code, u8 *data)
> {
>     ...
>     SET_BT_WIFI_CONTROL_DATA1(h2c_pkt, *data);
>     SET_BT_WIFI_CONTROL_DATA2(h2c_pkt, *(data + 1));
>     ...
>     SET_BT_WIFI_CONTROL_DATA5(h2c_pkt, *(data + 4));
>=20
> Detected using the static analysis tool - Svace.
> Fixes: 4136214f7c46 ("rtw88: add BT co-existence support")
> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
> ---
>  drivers/net/wireless/realtek/rtw88/coex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wire=
less/realtek/rtw88/coex.c
> index c929db1e53ca..347807801270 100644
> --- a/drivers/net/wireless/realtek/rtw88/coex.c
> +++ b/drivers/net/wireless/realtek/rtw88/coex.c
> @@ -309,7 +309,7 @@ static void rtw_coex_tdma_timer_base(struct rtw_dev *=
rtwdev, u8 type)
>  {
>         struct rtw_coex *coex =3D &rtwdev->coex;
>         struct rtw_coex_stat *coex_stat =3D &coex->stat;
> -       u8 para[2] =3D {0};
> +       u8 para[6] =3D {0};

The fix is correct. However, I don't prefer 0 as initializer.
Please use this style:=20

  u8 para[6] =3D {};



