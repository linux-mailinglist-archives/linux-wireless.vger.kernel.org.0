Return-Path: <linux-wireless+bounces-24510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C182FAE93B4
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 03:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CD93B688C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 01:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834131A0728;
	Thu, 26 Jun 2025 01:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="L86NbbfQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DD619F420;
	Thu, 26 Jun 2025 01:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750901252; cv=none; b=EYrvzbIVEouCEEVVoY1qG5WwjjgMZprQExd3ioUfFaOJLrEGcNZrdVpMApJSyXViQWvwK40BZfCixhs/gdbjCVzmp61SUITbBoi2ebgqvzhzWUcJPL7TfeK1MdDdBVd2cTgrf823IYvPxUEhXN6ko+oyD8apgIDLIC1srUFEW5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750901252; c=relaxed/simple;
	bh=fPZ0gsVygYsjW+1TzbktA4Z5ViaQdTHsBDhUlf3V7O0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PfoskM6jVZ45Kv0FazdX3WOsdArWZRtSkMbJkp9spYg2ycWRc0+B3yagnHm+VT2079Z/zBooWCj3DnHWyyr233tW1nqd65r4SwzZuJyFFJO6hMMHuE5/+s8QogoADA6xwi8o5+72kcdBOyhC9vsWNJ8P47K9r4ptxtUvFX3Y0j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=L86NbbfQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55Q1ROAO02231675, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750901244; bh=RU9/0Bz5WWZ6rzGwAXxJX+AbfPBn445jh2KFUkXhbwE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=L86NbbfQg3azRiJd1j8h837W0KaufHAdcMUKaNHg+wfl7U5TATjRX7s54yEaFjgDY
	 47nm4pzwTFl8K/ygs66hYKhMMfyKCJto0gPW5UsaaxnWha4puQcu6NMZBjvrTAcd20
	 NRQJGfTdrB2Ryq8oa7/aCdACNuw/9+Bz5YFBI2qzaSgc2RmclfwsGc94UPpJFJiLpA
	 Q2mJ16g/EC4WEw+h/ith90oCRmSR+OXAnjr2ns5j55b8ljHkfGvrjIRKh+W2xygjMg
	 r1gyKu7UCiYXqskWFSvJjYMZHdhrSgau2p1qu4d/RoPzAxnjeZCG/yqSB3VDoMV67Y
	 hzEWoy98FPZAA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55Q1ROAO02231675
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 09:27:24 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Jun 2025 09:27:41 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 26 Jun 2025 09:27:40 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Thu, 26 Jun 2025 09:27:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtl8xxxu: toggle P2P for supported devices
Thread-Topic: [PATCH] wifi: rtl8xxxu: toggle P2P for supported devices
Thread-Index: AQHb5d0W/5wnIWjHA0qqxnL0mtReEbQUnNXA
Date: Thu, 26 Jun 2025 01:27:40 +0000
Message-ID: <0083530d59084b82bebde68a73877568@realtek.com>
References: <20250625142541.44795-1-yakoyoku@gmail.com>
In-Reply-To: <20250625142541.44795-1-yakoyoku@gmail.com>
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

Martin Rodriguez Reboredo <yakoyoku@gmail.com> wrote:
> This is a MR to see if rtl8xxxu can be made to support P2P.

Sorry. What is MR?

>=20
> Theoretically this should be handled by mac80211 but it seems that
> drivers may have to take some extra steps depending on which device we
> are talking about. I know that this patch is so basic that it might be
> missing some H2C commands or similar for this to work on Realtek chips
> but I don't have the required knowledge for me to implement it, so if
> you know a place to read about I'll be glad to hear.

The commit message looks informal. Just describe why/what patch does.=20
If you want to share more information to readers, add information after
s-o-b with "---".=20

Basically if a WiFi device can support station and AP modes, it can
also support P2P mode. To work well, it needs to support additional=20
P2P PS, such as NoA, which needs some H2C commands or registers to
achieve. I'm not sure if chips supported by rtl8xxxu have these.=20

>=20
> As of now only rtl8192ex devices have their P2P_CLIENT and P2P_GO wiphy
> interface modes ensured because those are the only ones I can test on
> my rtl8192eu card. The rest of chips have them set from what I've seen
> in a cursory Internet search, they might or might not work.

Not sure what you really tested (I have seen another thread). Please mentio=
n
what you tested in commit message.

>=20
> Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

---

(add things you want to share)

> ---
>  drivers/net/wireless/realtek/rtl8xxxu/8188e.c |  1 +
>  drivers/net/wireless/realtek/rtl8xxxu/8188f.c |  1 +
>  drivers/net/wireless/realtek/rtl8xxxu/8192c.c |  1 +
>  drivers/net/wireless/realtek/rtl8xxxu/8192e.c |  1 +
>  drivers/net/wireless/realtek/rtl8xxxu/8192f.c |  1 +
>  drivers/net/wireless/realtek/rtl8xxxu/8710b.c |  1 +
>  drivers/net/wireless/realtek/rtl8xxxu/8723a.c |  1 +
>  drivers/net/wireless/realtek/rtl8xxxu/8723b.c |  1 +
>  drivers/net/wireless/realtek/rtl8xxxu/core.c  | 29 ++++++++++++++++++-
>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  1 +
>  10 files changed, 37 insertions(+), 1 deletion(-)
>=20


