Return-Path: <linux-wireless+bounces-9522-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 830EE915DB7
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 06:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BCCAB20396
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 04:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED79C13C813;
	Tue, 25 Jun 2024 04:38:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C41135A7F;
	Tue, 25 Jun 2024 04:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719290303; cv=none; b=c8DPjwJ6npoWAja1t1swi+h6uChQ6Zj92jdF8eucIQzxo+0H1YLCnRDGTgM4jYxlX2lLRePBw9/9IBCrEnHtZb08AS45gkF6xEDdZzG2tSMpW3AGpvm5ycRs9Fs7z9CwWf2eGdL0ZgRv/BBVdyS+b435UjZP4+Sj1PLuJcb+//w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719290303; c=relaxed/simple;
	bh=q3PhuFP+sBveySBspFaBqf+QzAIvc6z9hjiHTDsRZiQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bcdMqWL/n3XPLpxBab9maJGc/2/JBeRq0OITx0e7hIjALAhA8l45DrzsaHbjm6R+Ew854Mh6tTkZmND0gZv5LpMVptBopse8U+SqhqmpFOtPgvr3wD8e1Crz8TUAjrTQlFaW0fUD9dNn+WchMynAotcyxBJcjG0HFo8daMpH8+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45P4cEwaD3893264, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45P4cEwaD3893264
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 12:38:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 12:38:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 25 Jun 2024 12:38:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 25 Jun 2024 12:38:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: kernel test robot <lkp@intel.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "Gary
 Chang" <gary.chang@realtek.com>
Subject: RE: [PATCH 1/7] wifi: rtw89: wow: append security header offset for different cipher
Thread-Topic: [PATCH 1/7] wifi: rtw89: wow: append security header offset for
 different cipher
Thread-Index: AQHawtgu6m62Hx7xqEyDZnFRPv0ijLHXXXmAgACPMpA=
Date: Tue, 25 Jun 2024 04:38:13 +0000
Message-ID: <4053ce25f6a344328b6272253d9cdab5@realtek.com>
References: <20240620055825.17592-2-pkshih@realtek.com>
 <202406251139.1GzHAlKS-lkp@intel.com>
In-Reply-To: <202406251139.1GzHAlKS-lkp@intel.com>
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

kernel test robot <lkp@intel.com> wrote:
> Hi Ping-Ke,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on wireless-next/main]
> [also build test ERROR on wireless/main linus/master v6.10-rc5 next-20240=
624]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:
> https://github.com/intel-lab-lkp/linux/commits/Ping-Ke-Shih/wifi-rtw89-wo=
w-append-security-header-offs
> et-for-different-cipher/20240624-152444
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless=
-next.git main
> patch link:    https://lore.kernel.org/r/20240620055825.17592-2-pkshih%40=
realtek.com
> patch subject: [PATCH 1/7] wifi: rtw89: wow: append security header offse=
t for different cipher
> config: i386-allmodconfig
> (https://download.01.org/0day-ci/archive/20240625/202406251139.1GzHAlKS-l=
kp@intel.com/config)
> compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
> reproduce (this is a W=3D1 build):
> (https://download.01.org/0day-ci/archive/20240625/202406251139.1GzHAlKS-l=
kp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406251139.1GzHAlKS-lkp=
@intel.com/
>=20
> All errors (new ones prefixed by >>):
>=20
>    In file included from drivers/net/wireless/realtek/rtw89/core.c:21:
>    drivers/net/wireless/realtek/rtw89/wow.h: In function 'rtw89_wow_get_s=
ec_hdr_len':
> >> drivers/net/wireless/realtek/rtw89/wow.h:82:52: error: implicit declar=
ation of function
> 'rtw89_is_rtl885xb' [-Werror=3Dimplicit-function-declaration]
>       82 |         if (!(rtwdev->chip->chip_id =3D=3D RTL8852A || rtw89_i=
s_rtl885xb(rtwdev)))
>          |                                                    ^~~~~~~~~~~=
~~~~~~
>    cc1: some warnings being treated as errors
>=20

This inline function has been in rtw tree [1], but haven't merged into wire=
less-next yet.
I will ignore this robot report.=20

[1] https://github.com/pkshih/rtw.git


