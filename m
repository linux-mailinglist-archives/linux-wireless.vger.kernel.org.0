Return-Path: <linux-wireless+bounces-26857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECA4B3B34D
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 08:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18864685C7C
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 06:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B7721C194;
	Fri, 29 Aug 2025 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="JaXC6RxM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7C37404E
	for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 06:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756448597; cv=none; b=gZXOsPo71zc7/sPh3AjDl5+YfIKEgxxONV45TxSQyhQ0VuEeHnweFPfW3zfbSFL/VEWsTnBvfPKTS4kst9IBNU62J2cnBo0ZdB1DM7jvKTW8q28yIXhUTpMLOc7epAPVOwNPef3sY80DC4G7ArLz3cQxwTaHOZQu0U817jvyoBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756448597; c=relaxed/simple;
	bh=8YCa5+prd3vwlR37AXdSwzxIqUeggn0QDHv04PXAl9Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ThCkG94vE8YnIJMHOIKa7GWTzekj5FUL5D3cPAHzAeAjb/N0AaKAYG9OTGOcO1xu0/fXndlIB4+2VKGrjrqgR2ohopDC1LgyCTu2hdo9smXXe+qsieqlKIRLSGsXBF1O71P4LCLXmIexr4DHzA/w0W6iH0URraS0lnQhU1Xo1Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=JaXC6RxM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57T6NBM703127002, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756448591; bh=8YCa5+prd3vwlR37AXdSwzxIqUeggn0QDHv04PXAl9Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=JaXC6RxMuvIyrEqSJC0RhL8iNMxk+9IRlGkF74Sh04FQziq+r63zB0sWV7JJegRNb
	 KqOddQzMa0TaeUWJYVEJ4knT9dAAY/lM8iA3uyCPjHfCJenvOwxgsdGpMlzfH31G/M
	 /W5jnVJkxGUgK3tpf7DUj0OwtO+slnLnsZ4m5VTVj2wv/ly1iRW8vQa64dOrGs4BxA
	 6eHCtJltNvcsk3uVwFUC+HU3pMlHkcr8PRKvMn2gVFCyU0wJm0tsdq86ZsJjFLB6Nj
	 rn8jLmyerhOIF84jxUcOx+4ABo8vRX+O237iunuS5suSZhGDElePUImEzSwlgbjtCZ
	 mfNxVqRJZE2IA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57T6NBM703127002
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 14:23:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 29 Aug 2025 14:23:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Fri, 29 Aug 2025 14:23:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v3 00/11] wifi: rtw89: Add support for RTL8852CU
Thread-Topic: [PATCH rtw-next v3 00/11] wifi: rtw89: Add support for RTL8852CU
Thread-Index: AQHcF3JiHh9TMEvBrkmiQiJfPugsk7R5KnRg
Date: Fri, 29 Aug 2025 06:23:11 +0000
Message-ID: <a81f6725b183401d8973bc648c3ecbc2@realtek.com>
References: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
In-Reply-To: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBBZGQg
c3VwcG9ydCBmb3IgUlRMODg1MkNVLiBJdCB3b3JrcyB3ZWxsIGJ1dCBzb21ldGltZXMgaXQgbG9z
ZXMgdGhlDQo+IGNvbm5lY3Rpb246DQo+IA0KPiBKdWwgMDQgMTY6MDU6NTYgaWRlYXBhZDIga2Vy
bmVsOiB3bHAzczBmM3U0OiBDb25uZWN0aW9uIHRvIEFQIC4uLiBsb3N0DQo+IEp1bCAxNCAxMzo0
NToyNiBpZGVhcGFkMiBrZXJuZWw6IHdscDNzMGYzdTQ6IENvbm5lY3Rpb24gdG8gQVAgLi4uIGxv
c3QNCj4gSnVsIDE1IDE3OjUxOjI4IGlkZWFwYWQyIGtlcm5lbDogd2xwM3MwZjN1NDogQ29ubmVj
dGlvbiB0byBBUCAuLi4gbG9zdA0KPiBKdWwgMTggMTQ6NDM6MzAgaWRlYXBhZDIga2VybmVsOiB3
bHAzczBmM3U0OiBDb25uZWN0aW9uIHRvIEFQIC4uLiBsb3N0DQo+IEp1bCAyNCAxNDo1ODowNyBp
ZGVhcGFkMiBrZXJuZWw6IHdscDNzMGYzdTQ6IENvbm5lY3Rpb24gdG8gQVAgLi4uIGxvc3QNCj4g
DQo+IFdoZW4gdGhhdCBoYXBwZW5zIGl0IHJlY29ubmVjdHMgaW1tZWRpYXRlbHkuDQoNCkludGVy
bmFsIGV4cGVydHMgdG9sZCBtZSB0aGV5IG5lZWQgbW9yZSBkYXRhIHRvIGFuYWx5emUgdGhlIHBy
b2JsZW0sIEknbGwNCnNoYXJlIHlvdSBhIGRlYnVnIHBhdGNoIGxhdGVyLiBCZWZvcmUgdGhhdCwg
cGxlYXNlIHJlYWQgNCBieXRlcyBvZiAweEYwIHJlZ2lzdGVyDQp2aWEgZGVidWdmcy4gaS5lLiAn
ZWNobyAweEYwIDQgPiByZWFkX3JlZzsgY2F0IHJlYWRfcmVnJy4NCg0KQW5vdGhlciB0aGluZyBp
cyB3b3VsZCB5b3UgbGlrZSBtZSBtZXJnZSB0aGlzIHBhdGNoc2V0IGJlZm9yZSB0aGUgcHJvYmxl
bQ0KZ2V0IHJlc29sdmVkPyBJZiBzbywgZW5kIHVzZXJzIG1pZ2h0IHJlcG9ydCBwcm9ibGVtcyBm
cmVxdWVudGx5LiBNYXliZSwgd2UNCmNhbiBqdXN0IG1lcmdlIG1vc3QgcGF0Y2hlcywgYnV0IG5v
dCBhY3R1YWxseSBlbmFibGUgUlRMODg1MkNVIGJ5IHRoZSBsYXN0DQpwYXRjaC4gUGxlYXNlIGxl
dCBtZSBrbm93IHdoYXQgeW91IHRoaW5rLg0KDQo=

