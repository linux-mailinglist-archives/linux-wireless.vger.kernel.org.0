Return-Path: <linux-wireless+bounces-21576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79D8A8ACBF
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 02:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD28442033
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 00:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B561C862A;
	Wed, 16 Apr 2025 00:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="jGwpdxzI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE20781E;
	Wed, 16 Apr 2025 00:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744763588; cv=none; b=lSmBuuNSuTbC1ZCUZb6TpDqQ03uYibhhU6kOW2IDJjXD/TM93Z6x6vWTQlkW4R+bt6MS3CQBlgvshhMFfpFM/qD+KSH66geaTV2I+QhaNo9CpnOOwDe6NJRferzpovWtS25asaYRBqHkLOcFOdfaGaKHa0fTBlyPC6/S3Xr3UAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744763588; c=relaxed/simple;
	bh=/5FgyfoyLdyyIDMJBgE5yun8feWu4HGAH+RQrGVEgFY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eFIbnzxiyQnyv5LvMj0XtFr9NXJP1gQfJLzZph9gJggmgPiYxm/1rO1spKHmV/QUjNxLsPeg6jQtvL4rEptLC5v4RrgRjBSc8a9Mw7v1XWUCh9KW92Tfmo2pl9ExmlHbuEPMo//TGyyhk7Y65A7QFGVv7MTCqc1U8aVRDnyaiVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=jGwpdxzI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53G0Ww2M22305799, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744763578; bh=/5FgyfoyLdyyIDMJBgE5yun8feWu4HGAH+RQrGVEgFY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jGwpdxzIYmDdGjUmnQh9YpU2Tld45Dh9ChFpK//RA6h0e/PX9rpUiLz1CyMzXPv6y
	 knfjQQWxsJzI4oGOFjNkBS5UklLcr2+u5KvxoITZGz7qp+TEXGX4eGoSlqHXMkB2cp
	 +L7x1abDqLBXE+XOgGlXFajxz/gIWuMnAEUGN9cEuSnOelqeCOImAc91mzSTNBqLrV
	 m/4DC5sTuugmmTNmBVoVu5DJNAcd34KsT7YS9ZM6Odu67hXBffQ9j5xK3AUjwUTb8X
	 sl3259BoGfI+X/6SmbmnNXXwXj8JxAJtVK/6ccOhXCLYsb4HbHggvETfr0A1vru3RB
	 VWT/jI4GvSR1Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53G0Ww2M22305799
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 08:32:58 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Apr 2025 08:32:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 16 Apr 2025 08:32:58 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 16 Apr 2025 08:32:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Zhen XIN
	<zhen.xin@nokia-sbell.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -v2 2/2] wifi: rtw88: sdio: map mgmt frames to queue TX_DESC_QSEL_MGMT
Thread-Topic: [PATCH -v2 2/2] wifi: rtw88: sdio: map mgmt frames to queue
 TX_DESC_QSEL_MGMT
Thread-Index: AQHbqi/AoiBG2M0l1Umtjv/+rZii17Okn4AAgADZFsA=
Date: Wed, 16 Apr 2025 00:32:58 +0000
Message-ID: <74fe1fe102324d809d7f23b14d335bac@realtek.com>
References: <20250410154217.1849977-1-zhen.xin@nokia-sbell.com>
 <20250410154217.1849977-3-zhen.xin@nokia-sbell.com>
 <CAFBinCDVd6eVFcDzP1N8ayS6OmVZng5ti2jrHfYkbqFY4BdfLQ@mail.gmail.com>
In-Reply-To: <CAFBinCDVd6eVFcDzP1N8ayS6OmVZng5ti2jrHfYkbqFY4BdfLQ@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

TWFydGluIEJsdW1lbnN0aW5nbCA8bWFydGluLmJsdW1lbnN0aW5nbEBnb29nbGVtYWlsLmNvbT4g
d3JvdGU6DQo+IA0KPiBPbiBUaHUsIEFwciAxMCwgMjAyNSBhdCA1OjQ24oCvUE0gWmhlbiBYSU4g
PHpoZW4ueGluQG5va2lhLXNiZWxsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBSdHc4OC1zZGlvIGRv
IG5vdCB3b3JrIGluIEFQIG1vZGUgZHVlIHRvIHRoZSBsYWNrIG9mIHR4IHN0YXR1cyByZXBvcnQg
Zm9yDQo+IFBpbmctS2UsIGluIGNhc2UgeW91IHdhbnQgdG8ga2VlcCB0aGUgc3BlbGxpbmcgb2Yg
cnR3ODggY29uc2lzdGVudDoNCj4gY2FuIHlvdSB1cGRhdGUgaXQgd2hpbGUgYXBwbHlpbmcgdGhl
IHBhdGNoIChvciBkbyB3ZSBuZWVkIGEgdjMpPw0KPiBTYW1lIHF1ZXN0aW9uIGZvciB0aGUgb3Ro
ZXIgcGF0Y2ggaW4gdGhpcyBzZXJpZXMuDQoNCkkgY2FuIHVwZGF0ZSBjb21taXQgbWVzc2FnZXMg
d2hpbGUgYXBwbHlpbmcgcGF0Y2hlcy4gQnV0IG5vdCBzdXJlIHdoYXQgeW91DQptZW50aW9uZWQu
IERpZCB5b3UgbWVhbiB0byBjaGFuZ2UgJ1J0dzg4LXNkaW8nIHRvICdydHc4OC1zZGlvJz8NCg0K
DQo=

