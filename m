Return-Path: <linux-wireless+bounces-15030-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E26609BFCDD
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 04:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999671F21CFD
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 03:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6AF22071;
	Thu,  7 Nov 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="tZUaxeWy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB866FBF
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 03:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730949028; cv=none; b=eqSbCpT9tu3oorFoJY5/VjU06Bm3FRQsdpAZ8BsB7Ma5TykXe/A1vxpdODXqMKpeA7JrEKKKgVgn42gjysmhVT156lXeLl9+YgaPvlfJxrTAjxgJ4c3INFIKm6vnMSqVykGLByOAG0iZkuEIaEm7kWK2sgNZtQ5lAOFIMtazO4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730949028; c=relaxed/simple;
	bh=v0/5x0g2d2cQ2jRmFm+t57szf8SQcwg9peG/l7tUZRI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lJLJWp4DvBURcSZ2BWVxRQ84emuds/pxYI0gN6j2iqzxdAWC5swaaUILYyQw0tpX2OJIMrMg40IMV0tTFrrWsc6I53N7N5KEN2oMk1NpBp6vTabTx1QsGL2aNZc7Nse04eUMby33gvkLL5nJYTzRj8nRePcyvUePaO+B7kWg/6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=tZUaxeWy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A739lNK23782725, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730948987; bh=v0/5x0g2d2cQ2jRmFm+t57szf8SQcwg9peG/l7tUZRI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=tZUaxeWykSGLMaVMBTkM5bZ0sfHRSkSQiJi1XFlv1wGuSds+wFfc/zV0YaWNYVCL9
	 TKqIZce0alRxwwlbMONdwK9sxC0Aa1bWFt5oTiSzjcYC3R3PStcohgYuX8J9XbYeMd
	 RqvBF2L8LlDQQSUYQ4YcOsKUrOb0nezYq+MIt5y5VLD3VJZ5oujXdSbtc4qowm2O1o
	 RecM36ZOUdNo4HpgH5cLFvNPU3r4HPGdv9gE9EzuMVbManZXWsIv6Q11RnFzISk1r6
	 ItVoTQDf66wC4XbHOXjw+pnhx6w+AT7UqR61LJesMIL4kqw4downI/Y/WppsayorEh
	 X7Qec6hyBPxkw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A739lNK23782725
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 11:09:47 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 11:09:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Nov 2024 11:09:48 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 7 Nov 2024 11:09:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Issam Hamdi <ih@simonwunderlich.de>,
        "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "sw@simonwunderlich.de" <sw@simonwunderlich.de>,
        Kretschmer Mathias
	<mathias.kretschmer@fit.fraunhofer.de>
Subject: RE: [PATCH] wifi: mac80211: fix mbss changed flags corruption on 32 bit systems
Thread-Topic: [PATCH] wifi: mac80211: fix mbss changed flags corruption on 32
 bit systems
Thread-Index: AQHbLt5qmjJckGzEukCkGnLWXXtSI7KrJfuw
Date: Thu, 7 Nov 2024 03:09:47 +0000
Message-ID: <453ad4cc0ba24c07a02210f6a8acbd47@realtek.com>
References: <20241104172415.3790038-1-ih@simonwunderlich.de>
In-Reply-To: <20241104172415.3790038-1-ih@simonwunderlich.de>
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

Issam Hamdi <ih@simonwunderlich.de> wrote:
> diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
> index cb5f16366b9c..39cdbc11f540 100644
> --- a/net/mac80211/mesh.c
> +++ b/net/mac80211/mesh.c
> @@ -1164,7 +1164,7 @@ void ieee80211_mbss_info_change_notify(struct ieee8=
0211_sub_if_data *sdata,
>                 return;
>=20
>         /* if we race with running work, worst case this work becomes a n=
oop */
> -       for_each_set_bit(bit, &bits, sizeof(changed) * BITS_PER_BYTE)
> +       for_each_set_bit(bit, &bits, sizeof(bits) * BITS_PER_BYTE)
>                 set_bit(bit, ifmsh->mbss_changed);
>         set_bit(MESH_WORK_MBSS_CHANGED, &ifmsh->wrkq_flags);
>         wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);

The ifmsh->mbss_changed is defined as:
	unsigned long mbss_changed[64 / BITS_PER_LONG];

It seems like loop of for_each_set_bit() want to copy each bit of changed (=
u64).=20
When shrink traversal size of for_each_set_bit() from sizeof(changed) to si=
zeof(bits),=20
upper 32 bits of changed will not be copied to ifmsh->mbss_changed.
Will it be a problem?


