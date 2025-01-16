Return-Path: <linux-wireless+bounces-17583-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BEEA132D7
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 06:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D390168910
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 05:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A5014A62A;
	Thu, 16 Jan 2025 05:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ujE2t4Hi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D21156C5E
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 05:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737006886; cv=none; b=DbJTJUyv741+bnOiOpVK7eeSm3fbw56pStdC/xz8Wl6Pjuvher6xG5wqGZXeR45NUr1E00stSpH0o2asp+d0WsfwGLaQybZa+lkx2M4y5te0TGIQ9MTpwNtXPmVC8hVmg40iocLGq8AGyWag1S7u84TOxV9kEfe/QUFoIvIaI0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737006886; c=relaxed/simple;
	bh=/RFBJCj8WdTdxKBLUZZ4IEuHsR+DW5tkaSuPqwXgeB8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=joAmCUEfWR0jbyaDZ0IRIOdAjq5pgifHpMHxdM5h9lP8JbdXWr+uXd+mKENvQKKbNSTcjiP/RfAObY62xVC+1mKvDYh/5eKwT2Hja++ooSEpeviwSa9JXiZJ2hZOPn4J2MxCGSI0jC57z+F0wh8O7CLp1pr459XMZLpyF83dnZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ujE2t4Hi; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50G5saeG7506778, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737006876; bh=/RFBJCj8WdTdxKBLUZZ4IEuHsR+DW5tkaSuPqwXgeB8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ujE2t4HiJ4oMyGJVpAnqM0Fq14685giB1MnWE79nZ/R/KmEKNwzEs6ZpDcJh+zh89
	 va62eAzI6Ck5QormmlEs7q76XjEGsg8EO6KLBodg8AkVkNtSVINtV9sKxtp4KshJGZ
	 vV9mqCa1XyQOEHg95Q8C+SR9g0HvfE1veCifvHd2+yNji2LmKdK6li6MuQiz8uCYvj
	 phNQW6nPvDj1oeEnnYkD+Y/JtVA3PjPDlvHNfR45MTX4Lj999tBlEpDXjKas8/VtxY
	 ExjCTb44968VHg3AOnfUpQ32pL0mkIk1w35WqFtkNc4/8CTwdrMpZ2/I6gSpAvouFq
	 63cMxSpSvcmog==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50G5saeG7506778
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 13:54:36 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 16 Jan 2025 13:54:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 Jan 2025 13:54:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Thu, 16 Jan 2025 13:54:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH] wifi: rtw88: add RTW88_LEDS depends on LEDS_CLASS to Kconfig
Thread-Topic: [PATCH] wifi: rtw88: add RTW88_LEDS depends on LEDS_CLASS to
 Kconfig
Thread-Index: AQHbZ9mvcCacfzes3E2TTCURefvNkbMY5Y9A
Date: Thu, 16 Jan 2025 05:54:36 +0000
Message-ID: <9b2d304b24e14699bbd5f1ddf7959e05@realtek.com>
References: <20250116054337.35723-1-pkshih@realtek.com>
In-Reply-To: <20250116054337.35723-1-pkshih@realtek.com>
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

Hi Kalle,

Ping-Ke Shih <pkshih@realtek.com> wrote:
> When using allmodconfig, .config has CONFIG_LEDS_CLASS=3Dm but
> autoconf.h has CONFIG_LEDS_CLASS_MODULE (additional suffix _MODULE)
> instead of CONFIG_LEDS_CLASS, which condition CONFIG_LEDS_CLASS in
> rtw88/led.h can't work properly.
>=20
> Add RTW88_LEDS to Kconfig, and use it as condition to fix this problem.
>=20
> drivers/net/wireless/realtek/rtw88/led.c:19:6: error: redefinition of 'rt=
w_led_init'
>    19 | void rtw_led_init(struct rtw_dev *rtwdev)
>       |      ^~~~~~~~~~~~
> In file included from drivers/net/wireless/realtek/rtw88/led.c:7:
> drivers/net/wireless/realtek/rtw88/led.h:15:20: note: previous definition=
 of 'rtw_led_init' with type
> 'void(struct rtw_dev *)'
>    15 | static inline void rtw_led_init(struct rtw_dev *rtwdev)
>       |                    ^~~~~~~~~~~~
> drivers/net/wireless/realtek/rtw88/led.c:64:6: error: redefinition of 'rt=
w_led_deinit'
>    64 | void rtw_led_deinit(struct rtw_dev *rtwdev)
>       |      ^~~~~~~~~~~~~~
> drivers/net/wireless/realtek/rtw88/led.h:19:20: note: previous definition=
 of 'rtw_led_deinit' with type
> 'void(struct rtw_dev *)'
>    19 | static inline void rtw_led_deinit(struct rtw_dev *rtwdev)
>       |                    ^~~~~~~~~~~~~~
>=20
> Fixes: 4b6652bc6d8d ("wifi: rtw88: Add support for LED blinking")

If this patch is good to you, please take it to wireless-next to fix the
problem caused by Commit 4b6652bc6d8d.

Assigned to you in patchwork. Thanks.

Ping-Ke


