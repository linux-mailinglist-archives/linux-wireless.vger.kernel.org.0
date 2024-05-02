Return-Path: <linux-wireless+bounces-7086-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D33668B9312
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 03:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A1F1F22679
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 01:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810661172C;
	Thu,  2 May 2024 01:16:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5B917543;
	Thu,  2 May 2024 01:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714612596; cv=none; b=HjssS+GAKfUd40H9yQaok8utNmtGlYqknczuaYVUnH/IChj65IjB5NiJlCYKyRfBzNQG7MoXEpyK+AMGq57L1OlnwvvcrVhpXVMXnQq4IbdB7PzZS/+mOhjxq4RYlVzHJI39q+Un/rmikSGAeZcIdXS58LJE1VDgUYj7E8XNLzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714612596; c=relaxed/simple;
	bh=qvOtECN4Pb0C2oRpX6+idlo9APhFKqH0ezXUnZi+GfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cAx93KJErgUuqup7YqoIIhnCAU7HnkyecjNNUB4DVsnzah8KpNEH0xGlnOi3cAQv+Qs6yuThGx4fJVYaouEtbdCvQMi4S5y+iAy14RsXgM/xRQSGDp5bryilrImhvxG3xdoby8SpuZsWLty5iWxlBh68jzlml1Q3U192VZTXvUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4421GLPT01945611, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4421GLPT01945611
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 May 2024 09:16:21 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 09:16:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 09:16:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 2 May 2024 09:16:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: kernel test robot <lkp@intel.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "Gary
 Chang" <gary.chang@realtek.com>, Timlee <timlee@realtek.com>
Subject: RE: [PATCH 03/12] wifi: rtw89: wow: parsing Auth Key Management from associate request
Thread-Topic: [PATCH 03/12] wifi: rtw89: wow: parsing Auth Key Management from
 associate request
Thread-Index: AQHalwPGgPCu/ZF8nU6i2/68lwbLX7GB9h8AgAEyJmA=
Date: Thu, 2 May 2024 01:16:21 +0000
Message-ID: <0926e8b0b0a24f3691e6ae5b09f14f02@realtek.com>
References: <20240425112816.26431-4-pkshih@realtek.com>
 <202405012221.MONGVGmf-lkp@intel.com>
In-Reply-To: <202405012221.MONGVGmf-lkp@intel.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

kernel test robot <lkp@intel.com> wrote:
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on wireless-next/main]
> [also build test ERROR on wireless/main linus/master v6.9-rc6 next-202405=
01]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]

The development tree of Realtek WiFi drivers has changed to
https://github.com/pkshih/rtw.git, which I documented entry T in MAINTAINER=
 file.
How can I tell robot about that?

> All errors (new ones prefixed by >>):
>=20
>    alpha-linux-ld: drivers/net/wireless/realtek/rtw89/core.o: in function=
 `rtw89_traffic_stats_accu':
> >> (.text+0x11e8): undefined reference to `rtw89_wow_parse_akm'
> >> alpha-linux-ld: (.text+0x11f8): undefined reference to `rtw89_wow_pars=
e_akm'
>=20

The function rtw89_wow_parse_akm() is built only if CONFIG_PM is defined.
I will send v2 to correct it. Thanks for the finding.=20

Ping-Ke=20


