Return-Path: <linux-wireless+bounces-10164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C530892DD55
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 02:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38D5CB21AE9
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 00:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FE61C27;
	Thu, 11 Jul 2024 00:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="WsuWE1Od"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1556B10E4;
	Thu, 11 Jul 2024 00:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720657250; cv=none; b=LUe69XlllwbUcbe81hZRW0ZkV2bxBQSCAg9CT4dQixQrt9uW+8YzSokNyvYVROSN1FcaqhGmxwpGdm2qqPr8ght613Q/iNxDDjDL+5KH7wpGP0Ud5rmo6vuSqrR4oxjPBmIsDbLBgSK58/2l5VEfuhMMurofiwt3/gIDSW0HzJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720657250; c=relaxed/simple;
	bh=lu/ws/DouonfeddoseW9iBrWtLyCko/q8qWnUuEmw/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M8arzNnqJIX+Nep2do/Z92O1ERyLLziFZ9jz7pzTU9HWvk2raJOJXctITchsrilDLZbJ+PLihoX5s2h4di+9yfi9E/8/jWr4HuH0A6/FH61QdsENhZ/KdrnQYkCjOp03sfj3AaC7s7e2S5DOcp0SpgdfwsOFlTmqhYjd0MbFs1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=WsuWE1Od; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46B0KcchE2661981, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720657238; bh=lu/ws/DouonfeddoseW9iBrWtLyCko/q8qWnUuEmw/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=WsuWE1OdricOI9CChaHcsG7RoQoeBapbiroVDgKOLFxJ8yLV2psVkU1JjhvoIHoc2
	 oseIbbg4HWNXufWxKBqJM0JdZ2oJfQnAC5Es+jDVZS32NeRzMuTyU5cmyCJ4NtwfT/
	 f3WwgLDmjYZ+SR+U29ZFv3AHBe5DCEgNJgvNCo/sMy955kL6KwOE08AVzdULrA30ry
	 DA9xwGr6tKstG2AP7rhodc19zdyFtE+q0mhtaO68SjZNwa1RYBxaNuDr/m1Ihx9cym
	 8kH1Ob3izSGQkjHEyKAugtvAAdmGxmoC8NE9zx2n6lg1s1a7enjNvwO8tVysGWafk2
	 mX95jRlkmxyQA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46B0KcchE2661981
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:20:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 08:20:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jul 2024 08:20:38 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 11 Jul 2024 08:20:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thorsten Blum <thorsten.blum@toblux.com>,
        "Jes.Sorensen@gmail.com"
	<Jes.Sorensen@gmail.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtl8xxxu: Use swap() to improve rtl8xxxu_switch_ports()
Thread-Topic: [PATCH] wifi: rtl8xxxu: Use swap() to improve
 rtl8xxxu_switch_ports()
Thread-Index: AQHa0vuWToKzpFUEyEuHSaxW2LVN77HwqioQ
Date: Thu, 11 Jul 2024 00:20:37 +0000
Message-ID: <d1f56e9441ac452996a91f0b535c9e82@realtek.com>
References: <20240710190047.709843-2-thorsten.blum@toblux.com>
In-Reply-To: <20240710190047.709843-2-thorsten.blum@toblux.com>
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

Thorsten Blum <thorsten.blum@toblux.com> wrote:
> Use the swap() macro to simplify the rtl8xxxu_switch_ports() function
> and improve its readability. Remove the local variable vif.
>=20
> Fixes the following Coccinelle/coccicheck warning reported by
> swap.cocci:
>=20
>   WARNING opportunity for swap()
>=20
> Compile-tested only.
>=20
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

The same patch [1] has been applied.=20

[1] https://patch.msgid.link/20240619024017.53246-1-jiapeng.chong@linux.ali=
baba.com


