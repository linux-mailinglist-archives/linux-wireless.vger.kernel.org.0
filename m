Return-Path: <linux-wireless+bounces-8075-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 351F18CFA6D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 09:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA90CB212C2
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 07:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4BE3B298;
	Mon, 27 May 2024 07:47:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D936A2E62C
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 07:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796059; cv=none; b=gGkX/o8Fh4+/EMeIsFnrFm/ibHCBCBwlH5QIexsVOyfPjrZ0mO1GNNrjyHvDw2YQs+LJaBCxAhmLRQsvsIWCT2wi5v6eMzRZ1XwNU5wbMGfdC99RLH0xws/FL5Dc/EmoUipbIh4RlT9R2RwxGhE0eqe2SiUw3wqZfjK2z50sGdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796059; c=relaxed/simple;
	bh=XuQaFeY2dr8hIMkymPZjV1FnZ+qP2iot+4nFNnNhjPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DD+zo18j9q1UbqgLPaMaPNQT2JU9qWFkqnmHVIVHPddi5o74LzBp2KhGKKKdUWmPL7/4DqDsKiwqmQ0Ap3Er+JkUSKa9N95T8fJekdVszOb4Rv39qHxAnhJOxTDTt7/Ze7O+HST8TnqHLZdgE/h7IF4U8+HJuznGtb/icbuX4XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44R7lA0y9913122, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44R7lA0y9913122
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 May 2024 15:47:10 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 15:47:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 27 May 2024 15:47:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 27 May 2024 15:47:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Stefan
 Lippers-Hollmann" <s.l-h@gmx.de>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        Christian Hewitt
	<chewitt@libreelec.tv>
Subject: RE: [PATCH v7 12/12] wifi: rtlwifi: Enable the new rtl8192du driver
Thread-Topic: [PATCH v7 12/12] wifi: rtlwifi: Enable the new rtl8192du driver
Thread-Index: AQHarSBdbyWf9lKLLkKgqAnWSxDd/bGquXUA
Date: Mon, 27 May 2024 07:47:09 +0000
Message-ID: <0002749a3b584bc39fa18b3137153fdf@realtek.com>
References: <8805826b-60b9-4026-9509-7d92c3a43577@gmail.com>
 <5f2da7ee-876a-42fc-8fec-ec5386fa8c26@gmail.com>
In-Reply-To: <5f2da7ee-876a-42fc-8fec-ec5386fa8c26@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgU3RlZmFuLA0KDQpCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4g
d3JvdGU6DQo+IFRoZSBSVEw4MTkyRFUgaXMgYW4gb2xkZXIgV2lmaSA0IGR1YWwgYmFuZCBjaGlw
LiBJdCBjb21lcyBpbiB0d28NCj4gZmxhdm91cnM6IHNpbmdsZSBNQUMgc2luZ2xlIFBIWSAobGlr
ZSBtb3N0IFJlYWx0ZWsgV2lmaSA0IFVTQiBkZXZpY2VzKSwNCj4gYW5kIGR1YWwgTUFDIGR1YWwg
UEhZLg0KPiANCj4gVGhlIHNpbmdsZSBNQUMgc2luZ2xlIFBIWSB2ZXJzaW9uIGlzIDJUMlIgYW5k
IGNhbiB3b3JrIGVpdGhlciBpbiB0aGUNCj4gMi40IEdIeiBiYW5kIG9yIHRoZSA1IEdIeiBiYW5k
Lg0KPiANCj4gVGhlIGR1YWwgTUFDIGR1YWwgUEhZIHZlcnNpb24gaGFzIHR3byBVU0IgaW50ZXJm
YWNlcyBhbmQgYXBwZWFycyB0byB0aGUNCj4gc3lzdGVtIGFzIHR3byBzZXBhcmF0ZSAxVDFSIFdp
ZmkgZGV2aWNlcywgb25lIHdvcmtpbmcgaW4gdGhlIDIuNCBHSHoNCj4gYmFuZCwgdGhlIG90aGVy
IGluIHRoZSA1IEdIeiBiYW5kLg0KPiANCj4gVGhpcyB3YXMgdGVzdGVkIG9ubHkgd2l0aCBhIHNp
bmdsZSBNQUMgc2luZ2xlIFBIWSBkZXZpY2UsIG1vc3RseSBpbg0KPiBzdGF0aW9uIG1vZGUuIFRo
ZSBzcGVlZHMgaW4gdGhlIDIuNCBHSHogYmFuZCB3aXRoIDIwIE1IeiBjaGFubmVsIHdpZHRoDQo+
IGFyZSBzaW1pbGFyIHRvIHRoZSBvdXQtb2YtdHJlZSBkcml2ZXI6IDg1LzUxIG1lZ2FiaXRzL3Nl
Y29uZC4NCj4gDQo+IFN0ZWZhbiBMaXBwZXJzLUhvbGxtYW5uIHRlc3RlZCB0aGUgc3BlZWQgaW4g
dGhlIDUgR0h6IGJhbmQgd2l0aCA0MCBNSHoNCj4gY2hhbm5lbCB3aWR0aDogMTczLzk5IG1lZ2Fi
aXRzL3NlY29uZC4NCg0KQ291bGQgeW91IHBsZWFzZSBjb25maXJtIHRoaXMgZGVzY3JpcHRpb24g
aXMgc3RpbGwgY29ycmVjdCBpbiB2Nz8NCklmIHNvLCB5b3VyIFRlc3RlZC1ieSB0YWcgaXMgd2Vs
Y29tZS4gDQoNCg0K

