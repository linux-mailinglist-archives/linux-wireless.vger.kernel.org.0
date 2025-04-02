Return-Path: <linux-wireless+bounces-21065-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A0DA78A94
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 11:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBFE6188FBD9
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 09:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B648233735;
	Wed,  2 Apr 2025 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="hOKmzQqy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D2A233701;
	Wed,  2 Apr 2025 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743584573; cv=none; b=EsYG8hp2rZSSd/siaNu1C5bQIjq/plBBDBPbdInbNpzKVQ8aEv96RvJniCcf63B5p5Im+m94PkMPAkLRiImNTJmJt7amJUzXZPuyVxOXTtKGBuhULD1pGXP/IYlZ+Gmz9qrk0c77Ftg1sm5hkeKg4Ku3wzm+gno2ptpjmbe5jfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743584573; c=relaxed/simple;
	bh=JjWawIgxHYl0dQ6L/xhHpDAkfrKz2ch7rKR8aZlCMm4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E6YbThHFFRKNDtmcVLIqkktSShT63+yHz3d8Q5Gn+PVFFR6nGHQKrn1wUHgtDYXY4LMcfYjbic3RR1L5ofqxp6wx07gxmOmzWjrjDJL9xUGG+pEBELt0v6RK2nRMx/7WX/OlLkUsQAmkJgRe+aGsCJjRlPxZjFNNX85KGgH8q+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=hOKmzQqy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53292WqcC3958272, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1743584552; bh=JjWawIgxHYl0dQ6L/xhHpDAkfrKz2ch7rKR8aZlCMm4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=hOKmzQqywAR96KtmDvC0NTjLcbKoWtfZHuP1fL2bP4vLM/3zjDjB66JpVU9OkaQVQ
	 GIg5c92Aq+YjslRH42IN7hzCrdN0+p+U3Ee/Z5TKvAKkYBQj8pwxaoVPITm0GzaOD7
	 nSDHjh3uq+pjEWkhjT4DMCfNVLMYpLLsNcKZ8LbCfLQA3gbKIy9U2yGu/leM6hCH4g
	 PWMiH3wl5NxakI8F7xTRYw7mnjJkh5/1t6/PLIQDQLA8YmsUx7o/yeVs6a+BvfOmUR
	 WjnI4EeiaZkaNhpbbJqQFzb6U3vZcXa6cDHPBkB4Fr8WSFKTSPneOZ16aka03x2dRm
	 2Ng2mtzGQH20g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53292WqcC3958272
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Apr 2025 17:02:32 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Apr 2025 17:02:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 2 Apr 2025 17:02:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 2 Apr 2025 17:02:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Wentao Liang <vulab@iscas.ac.cn>, "kvalo@kernel.org" <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] rtlwifi: rtl892cu: Set limit for pwdb_all
Thread-Topic: [PATCH] rtlwifi: rtl892cu: Set limit for pwdb_all
Thread-Index: AQHbo55wvrLyXgByg0Ol6GEoOb4umbOQE82Q
Date: Wed, 2 Apr 2025 09:02:31 +0000
Message-ID: <0af1b6ed8d5c400fb41f20169d0d173a@realtek.com>
References: <20250402071040.3155-1-vulab@iscas.ac.cn>
In-Reply-To: <20250402071040.3155-1-vulab@iscas.ac.cn>
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

Wentao Liang <vulab@iscas.ac.cn> wrote:
>=20
> In _rtl92c_query_rxphystatus(), the return rtl_query_rxpwrpercentage()
> need to be checked. A proper implementation can be found in
> _rtl8723be_query_rxphystatus(). Add a value check and set the limit of
> pwdb_add as 100.

Have you tested on real hardware? Or just guess this is a potential problem=
?
If that is a real problem, please point out what it happens in commit messa=
ge.

By the way, subject should be "wifi: rtlwifi: ..."

>=20
> Fixes: 666e8457fae4 ("rtlwifi: rtl8192cu: Add routine mac")
> Cc: stable@vger.kernel.org # v2.6+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
> b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
> index a76f2dc8a977..e2145f284ec0 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
> @@ -641,6 +641,9 @@ static void _rtl92c_query_rxphystatus(struct ieee8021=
1_hw *hw,
>                         }
>                 }
>                 pwdb_all =3D rtl_query_rxpwrpercentage(rx_pwr_all);
> +               if (pwdb_all > 100)
> +                       pwdb_all =3D 100;
> +
>                 pstats->rx_pwdb_all =3D pwdb_all;
>                 pstats->recvsignalpower =3D rx_pwr_all;
>                 if (packet_match_bssid) {
> --
> 2.42.0.windows.2


