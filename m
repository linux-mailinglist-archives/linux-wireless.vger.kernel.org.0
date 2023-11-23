Return-Path: <linux-wireless+bounces-1-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 915C87F55AA
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 01:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B190B20D56
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 00:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA33399;
	Thu, 23 Nov 2023 00:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AD6A3;
	Wed, 22 Nov 2023 16:53:27 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AN0qIPb92600072, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AN0qIPb92600072
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Nov 2023 08:52:18 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 23 Nov 2023 08:52:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 23 Nov 2023 08:52:18 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 23 Nov 2023 08:52:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Su Hui <suhui@nfschina.com>, "kvalo@kernel.org" <kvalo@kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com"
	<ndesaulniers@google.com>,
        "trix@redhat.com" <trix@redhat.com>
CC: "lizetao1@huawei.com" <lizetao1@huawei.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH wireless-next 1/2] rtlwifi: rtl8821ae: phy: remove some useless code
Thread-Topic: [PATCH wireless-next 1/2] rtlwifi: rtl8821ae: phy: remove some
 useless code
Thread-Index: AQHaHSM/3p/4Qw0kHkiQftd5AzdylbCHE+lQ
Date: Thu, 23 Nov 2023 00:52:17 +0000
Message-ID: <ea7fc9364f0c4ec8ac9953c6de77bf79@realtek.com>
References: <20231122090210.951185-1-suhui@nfschina.com>
In-Reply-To: <20231122090210.951185-1-suhui@nfschina.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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
> Sent: Wednesday, November 22, 2023 5:02 PM
> To: Ping-Ke Shih <pkshih@realtek.com>; kvalo@kernel.org; nathan@kernel.or=
g; ndesaulniers@google.com;
> trix@redhat.com
> Cc: Su Hui <suhui@nfschina.com>; lizetao1@huawei.com; linux-wireless@vger=
.kernel.org;
> linux-kernel@vger.kernel.org; llvm@lists.linux.dev; kernel-janitors@vger.=
kernel.org
> Subject: [PATCH wireless-next 1/2] rtlwifi: rtl8821ae: phy: remove some u=
seless code

subject prefix should be "wifi: rtlwifi: ..."

>=20
> Clang static checker warning:
> Value stored to 'v1' is never read [deadcode.DeadStores]
> Value stored to 'channel' is never read [deadcode.DeadStores]
>=20
> Remove them to save some place.
>=20
> Signed-off-by: Su Hui <suhui@nfschina.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



