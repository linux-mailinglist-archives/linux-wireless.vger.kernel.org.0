Return-Path: <linux-wireless+bounces-14691-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1DB9B58B2
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 01:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71353283D9A
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 00:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9533D96A;
	Wed, 30 Oct 2024 00:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="p6aDm+cR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C873BBF2;
	Wed, 30 Oct 2024 00:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730248583; cv=none; b=cslO9mPOEII2pktDeb6aYcAFDH5y+ly1cJfflicKO9dpAdZ9p1izbDCE91ajyKTSLIRhR7oWCUyYKJ76+KV2su3dB2t6HGPsa+zKbXzwX0x8tV8kVLAZYAhYSEWq9r4xklUPVJoJhhYXbzoE7tb4FkFuWLKlp+MSma508IGTs5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730248583; c=relaxed/simple;
	bh=DDoPatrlswgvByx26TsT1yL+4Q/vLj+t4Zf6r9DyxX0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ecuDc0V2FtUYUtxpH8Ca0ErNCjCOxpwfYQ+yNq5SxovQ1aQHENwVOIPPBpyZdtEXI4POyC12lloQWtceXZwwaHwa3qaACBkkPgRg/wAPgtZqRNNyWryniKeI2LCi/69xVeLS+gTrD7zhPXEdwnyzfoicj5jDv3Eis9MhEGcDQEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=p6aDm+cR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49U0Zvm163177357, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730248557; bh=DDoPatrlswgvByx26TsT1yL+4Q/vLj+t4Zf6r9DyxX0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=p6aDm+cRkW3GxGugjNxCz/KUK9w08a4kibDIXSZigqRbNQUfFkz8zwmn6CwClT1Sq
	 /iR/xQGkc3oUVBl4URDxFDIa/P9TnkXxb/D2VAiAlZyFiyT6885r+ybyc3r+1VKuzf
	 cvNg1PhdpviPuyqbyemKQsnD5WnJURhTqLTSe30Z2ZX32kUVwlGW1W50Q2TGHlhhev
	 Nsp+OkgMm+b5MBsrY5jteZ+fAI37bnreGhMNvuCs7Y2Zrqj9w/cr4vYGxD1iBMSJ4g
	 J3TwZpA90fX9Nmruo1XtriDQ4XSbj3TKKKj6yTaLAXkxvSY31lMQsFTc37TVTA9Gj8
	 /SZJGAYvHtDTQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49U0Zvm163177357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 08:35:57 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 08:35:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 30 Oct 2024 08:35:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 30 Oct 2024 08:35:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>, Pei Xiao <xiaopei01@kylinos.cn>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xiaopeitux@foxmail.com" <xiaopeitux@foxmail.com>,
        "xiongxin@kylinos.cn"
	<xiongxin@kylinos.cn>
Subject: RE: [PATCH] net: wireless: realtek/rtw89: Add check null return of kmalloc
Thread-Topic: [PATCH] net: wireless: realtek/rtw89: Add check null return of
 kmalloc
Thread-Index: AQHbKeKmCGjwrG1Z00SxMtnPIAS54LKdiEW9gADpN+A=
Date: Wed, 30 Oct 2024 00:35:56 +0000
Message-ID: <4f5eee8cb4024571a9a78af97aecab67@realtek.com>
References: <82dd45fe7faed8f558841643a0593202b2da90c5.1730192926.git.xiaopei01@kylinos.cn>
 <8734kf2o77.fsf@kernel.org>
In-Reply-To: <8734kf2o77.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

Kalle Valo <kvalo@kernel.org> wrote:
> Pei Xiao <xiaopei01@kylinos.cn> writes:
>=20
> > kmalloc may fail, return might be NULL and will cause
> > NULL pointer dereference later.
> >
> > Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
>=20
> We use 'wifi: rtw89:' in the title, please check the documentation below
> for more.
>=20

A way to known subject prefix is to use git log with the files touched by
this patch:
   git log --oneline drivers/net/wireless/realtek/rtw89/coex.c

Also subject can point out specific function. Then my opinion is
  "wifi: rtw89: coex: check NULL return of kmalloc in btc_fw_set_monreg()"


