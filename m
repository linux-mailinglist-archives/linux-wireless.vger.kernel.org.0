Return-Path: <linux-wireless+bounces-1966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F84B82EAC8
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 09:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30321F21F50
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 08:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FAB11720;
	Tue, 16 Jan 2024 08:19:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE551171E;
	Tue, 16 Jan 2024 08:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40G8J4KJ0154508, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40G8J4KJ0154508
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 16:19:04 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 16 Jan 2024 16:19:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 16 Jan 2024 16:19:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Tue, 16 Jan 2024 16:19:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>, kernel test robot <lkp@intel.com>
CC: Martin Kaistra <martin.kaistra@linutronix.de>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "Johannes
 Berg" <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [wireless-next:main 32/56] drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5623:40: sparse: sparse: invalid assignment: |=
Thread-Topic: [wireless-next:main 32/56]
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5623:40: sparse:
 sparse: invalid assignment: |=
Thread-Index: AQHaSD+It1T//jaidk6ElNqnaDHlRrDb+H+JgAAfIPA=
Date: Tue, 16 Jan 2024 08:19:03 +0000
Message-ID: <0337a8c9c9224ec8852e8ec03bf21560@realtek.com>
References: <202401161318.YtXoCkjU-lkp@intel.com> <877ck9hk4z.fsf@kernel.org>
In-Reply-To: <877ck9hk4z.fsf@kernel.org>
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
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Tuesday, January 16, 2024 2:23 PM
> To: kernel test robot <lkp@intel.com>
> Cc: Martin Kaistra <martin.kaistra@linutronix.de>; oe-kbuild-all@lists.li=
nux.dev; Johannes Berg
> <johannes@sipsolutions.net>; linux-wireless@vger.kernel.org; Ping-Ke Shih=
 <pkshih@realtek.com>
> Subject: Re: [wireless-next:main 32/56] drivers/net/wireless/realtek/rtl8=
xxxu/rtl8xxxu_core.c:5623:40:
> sparse: sparse: invalid assignment: |=3D
>=20
> kernel test robot <lkp@intel.com> writes:
>=20
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wirele=
ss-next.git main
> > head:   ece90a8622320bf5a24d3326da1f8e109891573c
> > commit: b837f78fbffa5f8e7e7c59879db54793abf161ec [32/56] wifi: rtl8xxxu=
: add hw crypto support for AP
> mode
> > config: riscv-randconfig-r132-20240116
> (https://download.01.org/0day-ci/archive/20240116/202401161318.YtXoCkjU-l=
kp@intel.com/config)
> > compiler: riscv64-linux-gcc (GCC) 13.2.0
> > reproduce:
> (https://download.01.org/0day-ci/archive/20240116/202401161318.YtXoCkjU-l=
kp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202401161318.YtXoCkjU-l=
kp@intel.com/
> >
> > sparse warnings: (new ones prefixed by >>)
> >>> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5623:40: sparse=
: sparse: invalid assignment: |=3D
> >    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5623:40: spars=
e:    left side has type
> restricted __le32
> >    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5623:40: spars=
e:    right side has type
> unsigned long
>=20
> Martin, could you send a fix for this ASAP?
>=20

I help to prepare a patch [1]. Because sparse reports two warnings, I fix
them by two patches in the same patchset. =20

[1] https://lore.kernel.org/linux-wireless/20240116080945.20172-1-pkshih@re=
altek.com/T/#t

Ping-Ke=20


