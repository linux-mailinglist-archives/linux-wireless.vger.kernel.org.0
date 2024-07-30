Return-Path: <linux-wireless+bounces-10670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221E3940A1A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 09:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56D4282570
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 07:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72BE18EFF3;
	Tue, 30 Jul 2024 07:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="DuFs5c1r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830891684AE
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325281; cv=none; b=IbgX65Kc3yn7MCqC/ogxzHmHC2bMmhqjNsfqEGJmqefCKIpGP5KWHU/mvgR9Z1TunKo75QWCe8bkpmtR9hcZgvdu1glHhqroG5CZ0DrlOQ0HKGHmJkxxpyR3Le90KljTSiSeGI4wiQHrdiX5B5aVkcW2NWScGy2B8J5490OXcpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325281; c=relaxed/simple;
	bh=NDxlxKIyHniNqtEnr8ZSJjTPTv/uLi/EH7kvWNDrCpI=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=e0ZNfIno8stKhtqhyKc66IVMqTZrAN0vCqa2pQejPm/h2O9xfF9HCXmPLsjwlZw7XfOPcHPnf44oeFpPHyxMyMUvdMMYy2JQnyPGzfS1UJip2UY5O2PKDlzvYF0LyMF3g5wSLgwzwkOD6eQsBnVa5AZHjsLEjietyRHKrCnbmHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=DuFs5c1r; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46U7exjaF859537, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722325259; bh=NDxlxKIyHniNqtEnr8ZSJjTPTv/uLi/EH7kvWNDrCpI=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Message-ID:Date;
	b=DuFs5c1rsCyDfTuuPE+smLw1IdBIQYnye8SM/Qte/1myJX33dqXsPlFdiO/C9pves
	 hWCHbEAOpBcnDawF2kK0VMubn/4h9xZnx88X6V5prwzO1+9yySF1qYhy8BkqMnjvl6
	 F3PdUugcucrbv6kpAeephV/n3WYy6tRxk2VSujvYW2hIV4BSAHYXnPc8m1syXl7Cwj
	 IbKBAOgVW0kuckA17FKm/dQGJwf/debciEQehTHao0omfs9qqhGVC9JBbIDd8HBtSq
	 llWffjeR6MpA1HDxEfeaYzDBMVDqUjUex/GsPshti9ip7ambzJWjAGGE2AtKpsFBCa
	 842rwKKrvdC1w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46U7exjaF859537
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 15:40:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 15:40:59 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Jul
 2024 15:40:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: " =?utf-8?q?Marcin_=C5=9Alusarz?= " <marcin.slusarz@gmail.com>,
        <linux-wireless@vger.kernel.org>
CC: =?utf-8?q?Marcin_=C5=9Alusarz?= <mslusarz@renau.com>,
        Po-Hao Huang
	<phhuang@realtek.com>, Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo
	<kvalo@kernel.org>
Subject: Re: [PATCH] wifi: rtw88: usb: unbreak multicast
In-Reply-To: <20240614102835.518348-1-mslusarz@renau.com>
References: <CA+GA0_vcUneM4Uo8fg0=4sCK049uhjv+NskotRbNg9Em0cnyUQ@mail.gmail.com> <20240614102835.518348-1-mslusarz@renau.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Message-ID: <339e1162-9604-46f9-86bd-5f7aacbca4b9@RTEXMBS04.realtek.com.tw>
Date: Tue, 30 Jul 2024 15:40:58 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

IiA9P3V0Zi04P3E/TWFyY2luXz1DNT05QWx1c2Fyej89ICIgPG1hcmNpbi5zbHVzYXJ6QGdtYWls
LmNvbT4gd3JvdGU6Cgo+IEhpZ2ggcXVldWUgaXMgbm90IGZ1bmN0aW9uaW5nLCBmb3Igc29tZSBy
ZWFzb24uCj4gQnJva2VuIGJ5IDA3NmY3ODZhMGFlMTRhODFmNDAzMTRiOTZhMmQ4MTVlMjY0YmMy
MTMKPiAKPiBTaWduZWQtb2ZmLWJ5OiBNYXJjaW4gxZpsdXNhcnogPG1zbHVzYXJ6QHJlbmF1LmNv
bT4KPiBDYzogUG8tSGFvIEh1YW5nIDxwaGh1YW5nQHJlYWx0ZWsuY29tPgo+IENjOiBQaW5nLUtl
IFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4KPiBDYzogS2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVs
Lm9yZz4KClNtaXRoIHNlbnQgYSBwYXRjaCBbMV0gdGhhdCBmaW5kcyBjYXVzZSBhbmQgZml4ZXMg
dGhlIG11bHRpY2FzdCBwcm9ibGVtLgpIb3dldmVyLCB2ZW5kb3IgZHJpdmVyIGhhcyBiZWVuIGNo
YW5nZWQgdGhlIGZsb3cgYSBsaXR0bHQgYml0LCB3ZSB3aWxsIG1ha2UKYW4gbmV3IHBhdGNoIGZv
ciB0aGlzIHByb2JsZW0uCgpTbywgc2V0IHBhdGNoc2V0IHN0YXRlIHRvIFN1cGVyc2VkZWQKClsx
XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC13aXJlbGVzcy85MTc0YTc3Ni00NzcxLTQz
NTEtODVmYS00NzZlMjQwZDhhY2VAZ21haWwuY29tL1QvI21lZTJjYjhhZmIwOWY0YmVlMzMzYWIw
NDFkZWZlMjA1MjVkNzdmNTllCgo=

