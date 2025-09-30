Return-Path: <linux-wireless+bounces-27715-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D63BAAD4A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 02:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1311922C6B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 00:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B72BC133;
	Tue, 30 Sep 2025 00:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="D0KYA8CJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A214198E91
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 00:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759193646; cv=none; b=Re7Xa52Iq3jowprHZwzhpScS6NmDTz687O2goJBZELL+jPTNhyAPf5lzOnzy/+AZUSvu5sOI6rs1KOhbzq/5c6ay2wAMGQCwo3WAuiEt/iBPe2DbeegyuOvN+9Yqn25PUldcRyLybTxEOH8xbccLuun4efKKylS6RR0qyQScapE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759193646; c=relaxed/simple;
	bh=QQx4sjQ1oFqSY6UcXFDT3yW4yv9qn/8aBMxUmoudoGs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ecldlYHy07O55zXYOw00wLqkCHByDSOuG5ljpZURcYfumu5UOzgQI/H5JduD0QDU41+ept5TWmmPEkXrSRrSxD0dOs2yQ7BoxpEUg7YkmTSE3shevaGFfqn3x2EmD3dElDX3vhv4/AAggz4YVl6yrov8OVewpi9YvzNtsT47kU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=D0KYA8CJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58U0rpWY3147133, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1759193631; bh=QQx4sjQ1oFqSY6UcXFDT3yW4yv9qn/8aBMxUmoudoGs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=D0KYA8CJx+4gWtInXxb4omnp/0Ds3kATiYlES6YTmz9e8/ss/eVEe4MSJh5zH5zDc
	 Ugpmql5hIY43x7RDleGvvy33bhT4nSjirw/yXjPi1GIAKU7BcCkAPiWwh0G9CkCsnm
	 Vv9gxaLaqxKohB804ttHyvsfdNFyrT4Vpm/WM+HWZIW27UgI55mCYpf+oGIv/yV/pi
	 C0bF0VSFjKqHdR3fAk/MH9hpIf/gCzwnTZTnF0nmqm+RRoPshqoa5cOY2OZ/EsDCX/
	 yfeuCamQv5k/UayvOefaDj3BPtDCSNQCqnZmOjref2UcnV0V+cqVmcDIT8+XEbSqCi
	 K+3bX+Nk0yi4g==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58U0rpWY3147133
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 08:53:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 30 Sep 2025 08:53:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Tue, 30 Sep 2025 08:53:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "cybersnow_2001@tutamail.com" <cybersnow_2001@tutamail.com>,
        "Linux
 Wireless" <linux-wireless@vger.kernel.org>
Subject: RE: (RTW88, RT8812AU) TXPower enforced for regulation only and not for user preference
Thread-Topic: (RTW88, RT8812AU) TXPower enforced for regulation only and not
 for user preference
Thread-Index: AQHcMKI0GQMkfcf5UUiRCSSyWH3jF7Sq5idg
Date: Tue, 30 Sep 2025 00:53:50 +0000
Message-ID: <5cb35a53131a4a1db0b13e429d9060a4@realtek.com>
References: <OaGU_Py--F-9@tutamail.com>
In-Reply-To: <OaGU_Py--F-9@tutamail.com>
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

Y3liZXJzbm93XzIwMDFAdHV0YW1haWwuY29tIDxjeWJlcnNub3dfMjAwMUB0dXRhbWFpbC5jb20+
IHdyb3RlOg0KPiBIZWxsbywNCj4gDQo+IENhbiB5b3UgbG9vayBhdCBpc3N1ZXMgcmVnYXJkaW5n
IHRoZSBXSUZJIFRYUG93ZXIgYmVpbmcgZW5mb3JjZWQgYnkgY291bnRyeSByZWd1bGF0aW9uIHRo
YXQgY2F1c2UgcHJvYmxlbXM/DQo+IFdoZW4gcGVvcGxlIHdhbnQgdG8gYnlwYXNzIDgwMjExIHJl
Z3VsYXRpb25zLCB3ZSBjYW5ub3QgZG8gaXQuIFRoZSBvcmlnaW5hbCBSZWFsdGVrIGRyaXZlcnMg
cGVybWl0IHRoaXMNCj4gYnV0IG5vdCB0aGUgaW5jbHVkZWQga2VybmVsIFJUVzg4IGRyaXZlci4g
SSBrbm93IHlvdSB3YW50IHlvdXIgZHJpdmVyIHRvIGJlIGNvbXBsaWFudCB0byA4MDIxMSBidXQg
SSBjYW5ub3QNCj4gc2V0IHRoZSB0eHBvd2VyIHRvIDMxLjVkQiBvbiBteSBSVEw4ODEyQVUgYWRh
cHRlci4gSSB3b3VsZCBsaWtlIHRoYXQgeW91IGluY2x1ZGUgdGhlIG1heCBwb3dlciBjYXBhYmls
aXR5DQo+IG9mIDMxNDkgbWRCbSBpbnRvIHRoZSBkcml2ZXIgd2l0aCBhIG1vZHVsZSBwYXJhbWV0
ZXIgdGhhdCBjb3VsZCBkaXNhYmxlIGFueSBsaW1pdHMuIEknbSBmb3JjZWQgeWV0IHRvIHN0YXkN
Cj4gd2l0aCB0aGUgb2xkIGRyaXZlciBhbmQgaSdtIGZvcmNlZCB0byBtYWtlIHBhdGNoZXMgdG8g
aXQgZm9yIG5ld2VyIGtlcm5lbHMuLi4gVFhQb3dlciBjYW5ub3QgYmUgb25seSBzZXQNCj4gYnkg
dGhlIHJlZ3VsYXRvcmllcy4gSXQgbGltaXRzIG15IGhhcmR3YXJlIGlmIGknbSBzb21ld2hlcmUg
ZWxzZS4gSWYgZm9yIGV4YW1wbGUgSSBzZXQgdGhlIGNvdW50cnkgSEssIHRoZQ0KPiBtYXggcGVy
bWl0dGVkIGlzIDM2ZEIgZm9yIDJHIGFuZCA1Ry4gQnV0IGhvdyB0aGUgZHJpdmVyIGtub3cgdGhl
IGhhcmR3YXJlIGlzIGxpbWl0ZWQgdG8gMzEuNWRCPw0KPiANCg0KQXMgSSBrbm93LCBkcml2ZXIg
bXVzdCBiZSBub3Qgb25seSBjb21wbGlhbnQgdG8gVFggcG93ZXIsIGJ1dCBhbHNvIGJhbmQgZWRn
ZQ0KYW5kIGV0YyAobmVlZCBSRiBpbnN0cnVtZW50IHRvIG1lYXN1cmUgdGhlIHNpZ25hbCkuIEFs
c28sIGxhcmdlciBUWCBwb3dlcg0KY2F1c2UgbG93ZXIgRVZNIG5vcm1hbGx5LCBzbyB1bmxpbWl0
ZWRseSBlbmxhcmdpbmcgVFggcG93ZXIgaXMgbm90IGEgZ29vZA0KaWRlYS4gVGhhdCBtZWFucyBp
ZiB5b3Ugd2FudCB0byBsb3dlciBUWCBwb3dlciB0aGFuIHdoYXQgZHJpdmVyIGRlZmluZWQsIGl0
DQptaWdodCBiZSBmaW5lIChidXQgc3RpbGwgbm8gZXhpc3RpbmcgaW50ZXJmYWNlIHlldCkuIEhp
Z2hlciBUWCBwb3dlciB3aWxsIGJlDQpwcm9ibGVtcyBvZiByZWd1bGF0aW9uIGFuZCBwZXJmb3Jt
YW5jZS4gDQoNCg0K

