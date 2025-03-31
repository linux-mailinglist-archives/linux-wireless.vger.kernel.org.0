Return-Path: <linux-wireless+bounces-20984-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF8FA75E9F
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 07:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B2F3A8BF7
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 05:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF635FB95;
	Mon, 31 Mar 2025 05:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Udftjzo0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8813F3C30
	for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 05:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743400101; cv=none; b=dOQgBF1ZYZnHj4N281ZoIU3Kkz3U2IVs8aKQgbsaCr6oroU9Wk57WEw0mRaW3G1YROZuP2JAkix8bUw8nYxUawcQnthHhiqHNZdyn6K+MH63RCl1j6p3MUpFMYDbvcZyOH7ofWtBYlvnScVItjs63OG6n+P1P7BDJC0ZwjGc1h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743400101; c=relaxed/simple;
	bh=6H7s4/8Jw/Om8aWnIDuUl970KdIsnqUrgDDFI5P5y8c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r4qs7PMIbIAGggGaTzzKRIwlC2tV/njivEdneKBjkQ0JdIB6Gg+jljVy0XOFKJ12bY9EeiBl0EihO71PvxK3LWV/1yMY4QjPnOco2+dfyh5FeKt2hyIf9M1xYCUPSfRT0cJtWNRWS0xEVwLdBdb/e9Nii753gXqkQge/b/65EWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Udftjzo0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52V5le6P32851251, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1743400060; bh=6H7s4/8Jw/Om8aWnIDuUl970KdIsnqUrgDDFI5P5y8c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Udftjzo03uOZcosid37CyE8ylNUNCK1dqFoXaSJEb5HjC9hCIPUS9poCJ/9diAX9f
	 yZyWXNTsn7S9r/RwuuaMfQe3lSxJDNhqfb3/riMjucleR+q3/9i8oAPGX0hSCRJm/f
	 BlNjtmdAoOM5AWQnxKbtszgzozzz9USdtCf+jTN5HjzAUB1+U4oOsN7TFmgmAsFo1L
	 gCPds/ouopEFeeAEOIe+GsxbqFy4FGmkaLEeh929Mx0ZhzwZRrKET8epOEZ8N7WVSB
	 0BEg5wor8aFg0KzNcEWIwML7GFs1Im2ZixEc75BjOPGDZUnCOc2JQp0O9N7m3KC30H
	 fR0ckXLwJyn9g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52V5le6P32851251
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 13:47:40 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 31 Mar 2025 13:47:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 31 Mar 2025 13:47:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 31 Mar 2025 13:47:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Shayne Chen <shayne.chen@mediatek.com>, Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai
	<evelyn.tsai@mediatek.com>,
        linux-mediatek
	<linux-mediatek@lists.infradead.org>,
        Peter Chiu
	<chui-hao.chiu@mediatek.com>,
        StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Subject: RE: [PATCH 04/10] wifi: mt76: mt7996: rework DMA configuration for mt7990
Thread-Topic: [PATCH 04/10] wifi: mt76: mt7996: rework DMA configuration for
 mt7990
Thread-Index: AQHbn6Xl6K4aNRUcTE+Ls5jBcPcQ4LOMwOkQ
Date: Mon, 31 Mar 2025 05:47:39 +0000
Message-ID: <2f4874d10d86432693c73bfcb76e56dc@realtek.com>
References: <20250328055058.1648755-1-shayne.chen@mediatek.com>
 <20250328055058.1648755-5-shayne.chen@mediatek.com>
In-Reply-To: <20250328055058.1648755-5-shayne.chen@mediatek.com>
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

Shayne Chen <shayne.chen@mediatek.com> wrote:

[...]

> -       if (is_mt7996(&dev->mt76)) {
> +       switch (mt76_chip(&dev->mt76)) {
> +       case MT7992_DEVICE_ID:
> +               RXQ_CONFIG(MT_RXQ_BAND1_WA, WFDMA0, MT_INT_RX_DONE_WA_EXT=
, MT7996_RXQ_MCU_WA_EXT);
> +               RXQ_CONFIG(MT_RXQ_BAND1, WFDMA0, MT_INT_RX_DONE_BAND1, MT=
7996_RXQ_BAND1);
> +               break;
> +       case MT7990_DEVICE_ID:

Does it mean MT7990_DEVICE_ID_2/MT7992_DEVICE_ID_2 (suffix with _2) has dif=
ferent
behavior from MT7990_DEVICE_ID/MT7992_DEVICE_ID ?

> +               RXQ_CONFIG(MT_RXQ_BAND1, WFDMA0, MT_INT_RX_DONE_BAND1, MT=
7996_RXQ_BAND1);
> +               RXQ_CONFIG(MT_RXQ_TXFREE_BAND0, WFDMA0,
> +                          MT_INT_RX_TXFREE_BAND0_MT7990, MT7990_RXQ_TXFR=
EE0);
> +               if (dev->hif2)
> +                       RXQ_CONFIG(MT_RXQ_TXFREE_BAND1, WFDMA0,
> +                                  MT_INT_RX_TXFREE_BAND1_MT7990, MT7990_=
RXQ_TXFREE1);
> +               break;
> +       case MT7996_DEVICE_ID:
> +       default:
>                 /* mt7996 band2 */
> -               RXQ_CONFIG(MT_RXQ_BAND2, WFDMA0, MT_INT_RX_DONE_BAND2, MT=
7996_RXQ_BAND2);
>                 RXQ_CONFIG(MT_RXQ_BAND2_WA, WFDMA0, MT_INT_RX_DONE_WA_TRI=
, MT7996_RXQ_MCU_WA_TRI);
> -       } else {
> -               /* mt7992 band1 */
> -               RXQ_CONFIG(MT_RXQ_BAND1, WFDMA0, MT_INT_RX_DONE_BAND1, MT=
7996_RXQ_BAND1);
> -               RXQ_CONFIG(MT_RXQ_BAND1_WA, WFDMA0, MT_INT_RX_DONE_WA_EXT=
, MT7996_RXQ_MCU_WA_EXT);
> +               RXQ_CONFIG(MT_RXQ_BAND2, WFDMA0, MT_INT_RX_DONE_BAND2, MT=
7996_RXQ_BAND2);
> +               break;
>         }
>=20
>         if (dev->has_rro) {




