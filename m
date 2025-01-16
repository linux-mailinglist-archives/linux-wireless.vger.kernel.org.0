Return-Path: <linux-wireless+bounces-17582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1BFA132BE
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 06:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6673A76C8
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 05:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F6C18A943;
	Thu, 16 Jan 2025 05:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="MDzRMlfp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABC629A1;
	Thu, 16 Jan 2025 05:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737006602; cv=none; b=BZjT0GCYA019fUdOi4IoLDEY7T6mY0YiAUv2DSV7c4lIRUvnqWP+ARCTxbI5Vrwurnn6Z4yLDa9qnLc0LzLnxC9pgJkuRuz01DPlSrE7WYrNxjsxNLyXkjkrcjN40w7VcLW/xqMPlaEdEWc8ai0qnWjK5KU6rpk5HfA2Z/nBV5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737006602; c=relaxed/simple;
	bh=aK5Qp1WtZfWb+ehb16SgewX1iBiUcmfwlo03v1oO9nU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K1tqHodSqgFXVHkbtvaP1CHOwyXPevTxfKQBHe7muKC+uAjNgQrP4Q9QW2Zx2PlvmHNZQCIAk5cLpPSoE1nag+qxWGJwjDMpN1w1wLJSP/FHi1hQeFpQtoycc9LlQHTGx3FXXDtXuuPUtFUwB9EJcBzHJN0MCsiofHyyi7KMqGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=MDzRMlfp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50G5nTvM5503241, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737006569; bh=aK5Qp1WtZfWb+ehb16SgewX1iBiUcmfwlo03v1oO9nU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=MDzRMlfppF1DW25x5i5BvMlMSCcmaBlOL6jh7dOZu0ABAaaIJbLo8+E5CsPy5qIvY
	 0Nk6GRlJXMNsSTdWrYPkPaBvftZIdth4r9FUFctTNz+AAKPqB38tCbIGpBSoxmpJpB
	 YxKL4fDm/tmf4i+/PnLn+2IeZ4umk+jBTfyr8T2/08+9XgGWgKI2ZEeRmhhBnKIRPR
	 OCENgmnNDthQ5ydtmHzi1rc42Xa8hQ0rDRg8nKkP/5864MWjl+SAfV4nIBEbqRn3BP
	 exWycJXzSf32fL+jmMbfnOqfbKE+AVHZH6TICZoL4r6gwfdjWu9Wxfa8FCTSBKII1G
	 /pGldosykpN+A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50G5nTvM5503241
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 13:49:29 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 16 Jan 2025 13:49:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 Jan 2025 13:49:29 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Thu, 16 Jan 2025 13:49:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Wireless
	<linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        Linux Next Mailing List
	<linux-next@vger.kernel.org>
Subject: RE: linux-next: build failure after merge of the wireless-next tree
Thread-Topic: linux-next: build failure after merge of the wireless-next tree
Thread-Index: AQHbZ7uDbaJxwydigkCHDMeSE6CRnrMYXzuA
Date: Thu, 16 Jan 2025 05:49:28 +0000
Message-ID: <e19a87ad9cd54bfa9907f3a043b25d30@realtek.com>
References: <20250116130812.6e6c7b3e@canb.auug.org.au>
In-Reply-To: <20250116130812.6e6c7b3e@canb.auug.org.au>
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

Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>=20
> After merging the wireless-next tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
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
> Caused by commit
>=20
>   4b6652bc6d8d ("wifi: rtw88: Add support for LED blinking")
>=20
> I have used the wireless-next tree from next-20250115 for today.

I reproduced this issue, and fixed it by a patch [1].

[1] https://lore.kernel.org/linux-wireless/20250116054337.35723-1-pkshih@re=
altek.com/T/#u


