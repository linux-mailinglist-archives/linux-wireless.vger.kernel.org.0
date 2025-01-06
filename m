Return-Path: <linux-wireless+bounces-17096-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCD5A01E34
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 04:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24EDC160524
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 03:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D662AE6A;
	Mon,  6 Jan 2025 03:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="iw3KAys8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF03189B83;
	Mon,  6 Jan 2025 03:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736134355; cv=none; b=u+nDkrwgmFQ3ehJ+G7qKLYuDiwHt5y+8DAr60q8ihZHf/4DHTZV1Ia8/EuFJ6DeX7CKrGhZPu6NabR439F/BipUX0L4P0FLUTGslTkjvCEgflEJ1lQNC94O0I8O71iWlWo8YCXdBFHdhnEE23qlq3GRLwmuEF4cEuuzUnIf2RsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736134355; c=relaxed/simple;
	bh=/sA1apcuf0zGIgwqqP0Bw/8pgVGlZLkA4uxQTqVfgi0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EBr+So37SJLd4kcUUaNSCCWBXPRSogQryj2ixvXUf0z0U5W4BMZyL2yFdWktDOMsV+l9vbKvVh4xNeFrFDtczLsLgaDOmjmYT7QUxrQBohdE3nkSncZNjEkC+j4BA2EcgGX4b+5ozhs5P7ag5WKgfkt4L37zItgLNEb4kuJCbA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=iw3KAys8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5063WMUt81560621, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736134342; bh=/sA1apcuf0zGIgwqqP0Bw/8pgVGlZLkA4uxQTqVfgi0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=iw3KAys85UJ1cDLGYdiy4iwlDWDKVlvt8ybpiFxphh+uOSDc+7uaxDCYJKkHn4ud3
	 pVa24ZVXOnt3sEDI8roF9u5L2vhnnOCSva26v0MOcqZ0ZuBnxTecWJRn4qcMoXRy5Y
	 MuR3HPijLtN0nZ4uZ8f2qTCgd6sbqJ3l5x63wbXZ76D24WUTSCHLq0tDtoKyTT2z4g
	 jZ6VnWZ8TBmfH0JCI8lIAdHTscmOd2sAdVnh5OIKCfFk0fWdbbhccVUV3PhUv+uzaj
	 in2APpX0+HA7IiVbAXEn9sZrKfu4wQFZrn3D7z1Af+GeeujHngqImVZmJWxKo9yvU3
	 fwej+fY7BHwyQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5063WMUt81560621
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jan 2025 11:32:22 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 6 Jan 2025 11:32:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 Jan 2025 11:32:22 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Mon, 6 Jan 2025 11:32:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: kernel test robot <lkp@intel.com>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: RE: [PATCH v2] wifi: rtw88: Add support for LED blinking
Thread-Topic: [PATCH v2] wifi: rtw88: Add support for LED blinking
Thread-Index: AQHbX6USMgYFR0rPTUaMgQ9rRgfsCbMIgpmAgACT7WA=
Date: Mon, 6 Jan 2025 03:32:22 +0000
Message-ID: <77d348b8149b4d93bfbe86108941ba07@realtek.com>
References: <57c7d192-97ee-4da1-87a8-f040e9b8e3d1@gmail.com>
 <202501061046.U1iOSkRv-lkp@intel.com>
In-Reply-To: <202501061046.U1iOSkRv-lkp@intel.com>
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
> Hi Bitterblue,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on wireless-next/main]
> [also build test ERROR on wireless/main linus/master v6.13-rc6 next-20241=
220]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:
> https://github.com/intel-lab-lkp/linux/commits/Bitterblue-Smith/wifi-rtw8=
8-Add-support-for-LED-blinkin
> g/20250106-030830
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless=
-next.git main
> patch link:    https://lore.kernel.org/r/57c7d192-97ee-4da1-87a8-f040e9b8=
e3d1%40gmail.com
> patch subject: [PATCH v2] wifi: rtw88: Add support for LED blinking
> config: sh-allmodconfig
> (https://download.01.org/0day-ci/archive/20250106/202501061046.U1iOSkRv-l=
kp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=3D1 build):
> (https://download.01.org/0day-ci/archive/20250106/202501061046.U1iOSkRv-l=
kp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202501061046.U1iOSkRv-lkp=
@intel.com/
>=20
> All error/warnings (new ones prefixed by >>):
>=20
> >> drivers/net/wireless/realtek/rtw88/led.c:19:6: error: redefinition of =
'rtw_led_init'
>       19 | void rtw_led_init(struct rtw_dev *rtwdev)
>          |      ^~~~~~~~~~~~

As led.c is built, CONFIG_LEDS_CLASS=3Dy in Makefile.
=20
>    In file included from drivers/net/wireless/realtek/rtw88/led.c:7:
>    drivers/net/wireless/realtek/rtw88/led.h:15:13: note: previous definit=
ion of 'rtw_led_init' with type
> 'void(struct rtw_dev *)'
>       15 | static void rtw_led_init(struct rtw_dev *rtwdev)
>          |             ^~~~~~~~~~~~

However, weirdly CONFIG_LEDS_CLASS isn't defined in led.h.=20

By the way, my local build with selected CONFIG_LEDS_CLASS is fine.=20


