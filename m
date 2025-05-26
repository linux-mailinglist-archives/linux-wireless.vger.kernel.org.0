Return-Path: <linux-wireless+bounces-23398-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D6CAC37BB
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 03:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E9D1891AEC
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 01:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB3981AC8;
	Mon, 26 May 2025 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="iqhnbpMT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1537163
	for <linux-wireless@vger.kernel.org>; Mon, 26 May 2025 01:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748223364; cv=none; b=diI75tiQrwrl32PuNxnlsJ92enKAMxVX7uXaifvBoq5J0WWUfUbvgFNqV/Eiw+U/aiEjb2+r7v0vq2JFwFebgC2GjAlfWbxbKvGal5p5YsZ8ZhgVudk71GLpPfT0Qp+p72ALldVY9btLkBi5MfJWmNiJWjHVHEl1snwEoakMt3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748223364; c=relaxed/simple;
	bh=LWeMiKhJUJbFmufiaUdxxkzA1zPapOBmcP1F6FuYJGo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dFUr2Lk5KkMCJcabhgMEc/ArJ1H70SYycX76WRCGlUm/D6pJmXnxVR8qdcPxwN/Worq+k+Hkecjuop73BZvCRLfZH5cpwi7MsrO+uxwiS6ROBbXpnKgT/JlXuOcI9pmxU+5PTeH1oYgjITbmj8Jy7AGFqVZv/dRl8pHbUWwHOsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=iqhnbpMT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54Q1Zt9iA2824257, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1748223355; bh=LWeMiKhJUJbFmufiaUdxxkzA1zPapOBmcP1F6FuYJGo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=iqhnbpMTQvIhYGQz5gomqQwhJlcietDf9UkDIbcMzMwGUz4MyuXpS/QYM5ELTdaq9
	 1JUx/T+6UdqduoXgY4VYcFHQZEV1+FFDsS9qdMsGXeNRxCPUesM7TJ4J0MT7ztXn4X
	 PInNpb8+UWbNy2m/vsQJxRYHFGyDzn03J3YP2p4UUPB+ZfWS5hiYb1cmImllZs5ULU
	 TtQ3SP02P31AQ8K3MIG8PDdmgUbfmnFpNgi1lT6+P1audyUu6D16WQ7JWnNk7pvbcX
	 Me1nyQdbwgfa9IuSHLqB2AXg93er0CVOBZrNT9der8vW7HqUaC3Ny8y74WnenP69O9
	 2nweIQ7tsKu7A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54Q1Zt9iA2824257
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 09:35:55 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 May 2025 09:35:56 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 May 2025 09:35:56 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Mon, 26 May 2025 09:35:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v1 00/13] wifi: rtw89: Add support for USB devices
Thread-Topic: [PATCH rtw-next v1 00/13] wifi: rtw89: Add support for USB
 devices
Thread-Index: AQHbvTXQPM5g3Ac8D0CEfnCEvmiFA7PQI+gwgAAMg5CAE1DTgIAAvnfw
Date: Mon, 26 May 2025 01:35:55 +0000
Message-ID: <90dbd65feb0e409ba45e99cbde6075ac@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <d947c391577d46a4b110cb30cfa89ad0@realtek.com>
 <3b3e10af-6b09-4943-876e-fd06f48722a1@gmail.com>
In-Reply-To: <3b3e10af-6b09-4943-876e-fd06f48722a1@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAx
My8wNS8yMDI1IDEwOjA3LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gUGluZy1LZSBTaGloIHdy
b3RlOg0KPiA+PiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3Jv
dGU6DQo+ID4+Pg0KPiA+Pj4gQWRkIHN1cHBvcnQgZm9yIFVTQiBkZXZpY2VzLCBzdGFydGluZyB3
aXRoIGp1c3QgUlRMODg1MUJVLg0KPiA+Pg0KPiA+PiBUaGFua3MgZm9yIHlvdXIgd29yayEhDQo+
ID4NCj4gPiBIYXZlIHlvdSBhbHNvIHRlc3RlZCBBUCBtb2RlPyBJZiBub3QsIHBsZWFzZSBhZGQg
YSBwYXRjaCB0byBkaXNhYmxlIGl0DQo+ID4gdGVtcG9yYXJpbHkgYXMgYSB0cmFuc2l0aW9uIHNv
bHV0aW9uLCBsaWtlIHJ0dzg4Lg0KPiA+DQo+IA0KPiBJIHRlc3RlZCBpdCBvbmx5IGZvciBhIGZl
dyBtaW51dGVzIHdpdGggUlRMODg1MUJVIGFuZCBSVEw4ODMyQlUuDQo+IE15IHBob25lIGNhbiBj
b25uZWN0IHRvIGJvdGguDQoNClRoYW5rcy4gUGxlYXNlIHBvaW50IG91dCB0aGlzIGluIHRoZSBs
YXN0IHBhdGNoIHlvdSBlbmFibGUgVVNCIHN1cHBvcnQsDQpzbyB0aGF0IHNvbWV0aW1lIHdlIGNh
biByZWNhbGwgdGhlIHN1cHBvcnRlZCBtb2RlcyBmcm9tIGNvbW1pdCBsb2cuDQoNCg0K

