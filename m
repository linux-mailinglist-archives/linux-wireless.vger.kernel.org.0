Return-Path: <linux-wireless+bounces-89-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E33A7F975C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 03:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07260B20A25
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 02:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A857110C;
	Mon, 27 Nov 2023 02:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B64A11C;
	Sun, 26 Nov 2023 18:05:55 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AR24I270958409, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AR24I270958409
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Nov 2023 10:04:19 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 27 Nov 2023 10:04:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 27 Nov 2023 10:04:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Mon, 27 Nov 2023 10:04:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Su Hui <suhui@nfschina.com>,
        "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com"
	<ndesaulniers@google.com>,
        "trix@redhat.com" <trix@redhat.com>
CC: "lizetao1@huawei.com" <lizetao1@huawei.com>,
        "linville@tuxdriver.com"
	<linville@tuxdriver.com>,
        "Larry.Finger@lwfinger.net"
	<Larry.Finger@lwfinger.net>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>,
        "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH wireless-next v3 2/2] wifi: rtlwifi: rtl8821ae: phy: fix an undefined bitwise shift behavior
Thread-Topic: [PATCH wireless-next v3 2/2] wifi: rtlwifi: rtl8821ae: phy: fix
 an undefined bitwise shift behavior
Thread-Index: AQHaINIRUzT9Mv+uykSNp3dE8RYddbCNaTqA
Date: Mon, 27 Nov 2023 02:04:14 +0000
Message-ID: <daf6238559114e50a673d97b3f1bab4e@realtek.com>
References: <20231127013511.26694-1-suhui@nfschina.com>
 <20231127013511.26694-2-suhui@nfschina.com>
In-Reply-To: <20231127013511.26694-2-suhui@nfschina.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
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
> From: Su Hui <suhui@nfschina.com>
> Sent: Monday, November 27, 2023 9:35 AM
> To: Ping-Ke Shih <pkshih@realtek.com>; dan.carpenter@linaro.org; kvalo@ke=
rnel.org; nathan@kernel.org;
> ndesaulniers@google.com; trix@redhat.com
> Cc: Su Hui <suhui@nfschina.com>; lizetao1@huawei.com; linville@tuxdriver.=
com; Larry.Finger@lwfinger.net;
> linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org; llvm@lists.=
linux.dev;
> kernel-janitors@vger.kernel.org
> Subject: [PATCH wireless-next v3 2/2] wifi: rtlwifi: rtl8821ae: phy: fix =
an undefined bitwise shift behavior
>=20
> Clang staic checker warning:
> drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c:184:49:
>         The result of the left shift is undefined due to shifting by '32'=
,
>         which is greater or equal to the width of type 'u32'.
>         [core.UndefinedBinaryOperatorResult]
>=20
> If the value of the right operand is negative or is greater than or
> equal to the width of the promoted left operand, the behavior is
> undefined.[1][2]
>=20
> For example, when using different gcc's compilation optimizaation options
> (-O0 or -O2), the result of '(u32)data << 32' is different. One is 0, the
> other is old value of data. Let _rtl8821ae_phy_calculate_bit_shift()'s
> return value less than 32 to fix this problem. Warn if bitmask is zero.
>=20
> [1]:https://stackoverflow.com/questions/11270492/what-does-the-c-
> standard-say-about-bitshifting-more-bits-than-the-width-of-type
> [2]:https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf
>=20
> Fixes: 21e4b0726dc6 ("rtlwifi: rtl8821ae: Move driver from staging to reg=
ular tree")
> Signed-off-by: Su Hui <suhui@nfschina.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

> +       if (WARN_ON_ONCE(!bitmask))

I test this patch with real hardware to connect 2GHz and 5GHz AP
respectively and keep ping for a while. It doesn't throw warning
by this statement.=20



