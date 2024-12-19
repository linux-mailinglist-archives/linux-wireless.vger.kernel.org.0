Return-Path: <linux-wireless+bounces-16576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93EE9F73EC
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 06:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29FD7164205
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 05:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE3F208961;
	Thu, 19 Dec 2024 05:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="fnLq51fp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2312165E9
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 05:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734586221; cv=none; b=tO/w8noViFkvrImgt5qgZVfWwiSLk6DJGdblJH38Igkao8RxV2LwC8WGUBrMK0X88cvdaTBc7opAORLwwI7KFhip9XSRkxjbti739NyNVEQ48BGLnQGt45qKVHhvrjhw7EpnyQD2UpSg/h+f+3G0PYxJ0tU7WJz6vxOa4K0LG3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734586221; c=relaxed/simple;
	bh=Sj6aCXWnL+T2pzMtFwfOMPGoEpHO4bREMpu94ASRpeE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WC379Xkr76cQ8DjzrcbqprEm3eA2PHb1BWBbhHADNe/ahH5Hu41IIbn0OMyXlM3JFfu0fnqudfvgl5Zp5L39PDgs5pcChdIpD80mtBnDV+Y3CzbKu9Ju0zRltwT1ecTqQqXoDwqQM7UpzgoFNf13qQDxcens2MshMMkWaGODdCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=fnLq51fp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BJ5UFOU03490135, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1734586215; bh=Sj6aCXWnL+T2pzMtFwfOMPGoEpHO4bREMpu94ASRpeE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=fnLq51fpzjpDd7htHbEF2XQ0vqmm8AfW+r7hq52dNaP8QpUQDyvsSOsaQmgnGWkWR
	 aG2cZCz8graXsl0K3BtfynlXKThfPvNrYqVQhNYRBTIvAqlNxKEPkQG/mO/F18b77p
	 zRkT8X/t5+QG15Dob82L1mWBZNyWrPE1SHxk6h8wTBM7gpisWXv8vPi0ZrznI5VqEl
	 H67V8NgIxQ1gliyzu5BnO8gOvv0MWelwpCnCFDLYbXFSQxtlV5nAsZ8F4pnjYr3cTE
	 2Xb9yIjnhXz3OC2E3uMrluWpyEKx4e4hY7rPgklADVTo4l1qvvXYhcYHVN2ybAfM12
	 gT5y+4WYQmT9Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BJ5UFOU03490135
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 13:30:15 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Dec 2024 13:30:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 19 Dec 2024 13:30:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 19 Dec 2024 13:30:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 2/2] wifi: rtw88: 8821a/8812a: Set ptct_efuse_size to 0
Thread-Topic: [PATCH 2/2] wifi: rtw88: 8821a/8812a: Set ptct_efuse_size to 0
Thread-Index: AQHbUOIOaQL8BOg9aEWYSQVnL+VN3LLtDEkg
Date: Thu, 19 Dec 2024 05:30:15 +0000
Message-ID: <f6cb3bdad8554031bdca33d367b0ef5c@realtek.com>
References: <2917c7fc-6d88-4007-b6a6-9130bd1991e5@gmail.com>
 <1a477adb-60c3-463c-b158-3f86c94cb821@gmail.com>
In-Reply-To: <1a477adb-60c3-463c-b158-3f86c94cb821@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBTb21l
IFJUTDg4MTJBVSBkZXZpY2VzIGZhaWwgdG8gcHJvYmU6DQo+IA0KPiBbICAgMTIuNDc4Nzc0XSBy
dHdfODgxMmF1IDEtMS4zOjEuMDogZmFpbGVkIHRvIGR1bXAgZWZ1c2UgbG9naWNhbCBtYXANCj4g
WyAgIDEyLjQ4NzcxMl0gcnR3Xzg4MTJhdSAxLTEuMzoxLjA6IGZhaWxlZCB0byBzZXR1cCBjaGlw
IGVmdXNlIGluZm8NCj4gWyAgIDEyLjQ4Nzc0Ml0gcnR3Xzg4MTJhdSAxLTEuMzoxLjA6IGZhaWxl
ZCB0byBzZXR1cCBjaGlwIGluZm9ybWF0aW9uDQo+IFsgICAxMi40OTEwNzddIHJ0d184ODEyYXU6
IHByb2JlIG9mIDEtMS4zOjEuMCBmYWlsZWQgd2l0aCBlcnJvciAtMjINCj4gDQo+IEl0IHR1cm5z
IG91dCB0aGVzZSBjaGlwcyBkb24ndCBuZWVkIHRvICJwcm90ZWN0IiBhbnkgYnl0ZXMgYXQgdGhl
IGVuZCBvZg0KPiB0aGUgZWZ1c2UuDQo+IA0KPiBUaGUgb3JpZ2luYWwgdmFsdWUgb2YgOTYgd2Fz
IGNvcGllZCBmcm9tIHJ0dzg4MjFjLmMuDQo+IA0KPiBObyBvbmUgcmVwb3J0ZWQgYW55IGZhaWx1
cmVzIHdpdGggUlRMODgyMUFVIHlldCwgYnV0IHRoZSB2ZW5kb3IgZHJpdmVyDQo+IHVzZXMgdGhl
IHNhbWUgZWZ1c2UgcmVhZGluZyBjb2RlIGZvciBib3RoIGNoaXBzLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFja2Vk
LWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

