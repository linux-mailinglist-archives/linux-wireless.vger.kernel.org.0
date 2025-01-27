Return-Path: <linux-wireless+bounces-17992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC4DA1D0E4
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 07:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EABB7A2BA1
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 06:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A680870838;
	Mon, 27 Jan 2025 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="WdY8kHy6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A152B27701
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 06:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737959035; cv=none; b=YuBbr746h9OZUqdgfoi6DpKw7pthgjh4Cmjm4i9K5Xt83LadCG3HPCMW1KSeg8y8K8vhMHpqMOOrO/h/WwKkGRnIQUC2Q2yG07SzMbwsgXdUWC3Mlw6oq3rJg9tPR7Bk1CquQQlP2XXAG5KFHAnK8FgK3V5N5iDbRWz+/JRBUKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737959035; c=relaxed/simple;
	bh=tnEXO8UElEvqMzQin4eeVNzFli6NpzEAdA8GTa1wya4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XWk2qsobRMeHbnUVZ6Taw2R8bnbGQEOSQoHB4SpY0w2zX3blWDfe17GNiCvF5Cqv8WA5V4Zrg8hcKFDJdg8AgWxXSYPz04vDmGuvwN7zoqNfAsc4SKsMYKNn5AkNizKwzumhfkFXA+0g3b3bjWuqnQcW6KPprY+FnTDc4kWrmF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=WdY8kHy6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50R6NnGjA2603553, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737959029; bh=tnEXO8UElEvqMzQin4eeVNzFli6NpzEAdA8GTa1wya4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=WdY8kHy60G75mkVTo2d+fI3Z3AV5qHDKCyK8iOb/EbvZ5BX1wmkiD3AiMOuKZC9y1
	 EElF7HHcFSFYIZ/auDyA6oFNjcbfowihQf2qd52ygcsrTaWiVNdoIOpYkP0l+bCRlE
	 0l3ZhwZe07pKZ7nyQj/T3ZT5GiFRwa7WtUaQNvSbbFUmsPo6lDFLsZSRdipQv82Tom
	 yCMnybxb0RjpGzKKaEmQKzpm+tSlH8G3Ld7BXhJ75VKPvmgsrVV3gGdo4FVbE2CBgk
	 Hshn2/Yk4SopdN6SPV+uPCo6215DWUQRl+7Wf5nLFJUkx1FVJNASdGcK9WF/3G3Lej
	 BEwE/aqlWJ8rA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50R6NnGjA2603553
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 14:23:49 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 Jan 2025 14:23:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 27 Jan 2025 14:23:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Mon, 27 Jan 2025 14:23:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 3/7] wifi: rtw88: Extend struct rtw_pwr_track_tbl for RTL8814AU
Thread-Topic: [PATCH 3/7] wifi: rtw88: Extend struct rtw_pwr_track_tbl for
 RTL8814AU
Thread-Index: AQHbcEVlA6GQK0oVoEKcq3ZNVEi1EbMqJ1jn
Date: Mon, 27 Jan 2025 06:23:49 +0000
Message-ID: <f72892fe63b745179fbb4ccda7c2e1de@realtek.com>
References: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>,<02424d4b-96a8-4c30-933c-7abbefc520c5@gmail.com>
In-Reply-To: <02424d4b-96a8-4c30-933c-7abbefc520c5@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
> Currently this struct has the members required for chips with 2 RF
> paths. Add more members to support chips with 4 RF paths, like the
> RTL8814AU.
>=20
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>=20

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

