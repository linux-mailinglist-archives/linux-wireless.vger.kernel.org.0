Return-Path: <linux-wireless+bounces-21219-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24290A7F1A0
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 02:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CFE174786
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 00:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734BAD2FB;
	Tue,  8 Apr 2025 00:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="cvF7i7dU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22AD12E7F;
	Tue,  8 Apr 2025 00:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744072139; cv=none; b=VeVGRj0Ie2/c5LPvdwSzE6G7OPmH+koK4Ea28Bh1VsPvwGIuPBw55L0FwVNpGlD7zmHNnl5W/o6vI16ZSJUfKHtUQl05yCisyFQ86zIvVGuZyVT6GTftI1LhmoKFR9eWfgEaLc5aVXPEUuD8y3p9vYDBsj/dDhmSE42nKDRoZ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744072139; c=relaxed/simple;
	bh=PyZ1cQ8Jh+NlsL//fjMKMfyETq9G8zTC5acak2Wp7rY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PqEUVqe7ZM2WcsYct8Jk9rDAL8husoKzRNtGhxCsGWsPSXDzJSHWpKgnIDSW0qEA+qb6u+mjX2M5BvYCrLkEAdSBOCpueObNR6PYYeXvnhd+uVYsRu6M90bvjqR5exvjTCCFis4x6Kuu6N5jVbyjTnN4dN/fzPHHRUWRvXD06KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=cvF7i7dU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5380Sif962101352, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744072124; bh=PyZ1cQ8Jh+NlsL//fjMKMfyETq9G8zTC5acak2Wp7rY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=cvF7i7dUNLts+uc8myIuOw8cyTU+z60tTUG3e2CoCAJfL2CcTjKAwz6Uhe4zcxgK2
	 Voqz77YhnQGMn9XDUMd5ZsslB1kbpHyMNGPenk5Kt7RG0Z7055bMhFHCL0eQKxBzRE
	 WHgUeAt7OAYwdgFYpk2icw5y+yrFn4OS+uvca10OVf83URm6VXr1KJL9cXoAmmoyAl
	 /MwewGi6PfWVKM/Z1QXkd/hGCwWflaV9sKMbEFj+8zSwketR8dejfegl7NO8PF/7b9
	 3gA2NB7ShvtOvocjLtpWtxUb5l/Kwcq1eftolH1S8FZ/ywTTR/AbxYxVGvO5+dRaQB
	 1tTpi3n1fylBQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5380Sif962101352
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Apr 2025 08:28:44 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Apr 2025 08:28:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 8 Apr 2025 08:28:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 8 Apr 2025 08:28:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC: Zhen XIN <zhen.xin@nokia-sbell.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC -v1] wifi: rtw88: sdio: Tx status for management frames
Thread-Topic: [RFC -v1] wifi: rtw88: sdio: Tx status for management frames
Thread-Index: AQHbo+jJuNfRBVSN0k+LjlPmG1YP3LOXjoewgACk5QCAAL5oEA==
Date: Tue, 8 Apr 2025 00:28:44 +0000
Message-ID: <c6d200bad399484b9ebe8a265bcaa038@realtek.com>
References: <20250402160310.996141-1-zhen.xin@nokia-sbell.com>
 <9d908c7c77684260818470225b8a0980@realtek.com>
 <CAFBinCD6fcTaJ3VE-0HBv=Vd_yhkqAgMH_8v9MVV1UMCO5m6vw@mail.gmail.com>
In-Reply-To: <CAFBinCD6fcTaJ3VE-0HBv=Vd_yhkqAgMH_8v9MVV1UMCO5m6vw@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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
d3JvdGU6DQo+IA0KPiBIaSBQaW5nLUtlLA0KPiANCj4gT24gTW9uLCBBcHIgNywgMjAyNSBhdCA1
OjMw4oCvQU0gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+DQo+
ID4gSGkgTWFydGluLA0KPiA+DQo+ID4gSSByZXBsaWVkIG9yaWdpbmFsIG1haWwsIGJlY2F1c2Ug
SSB0aGluayBkaXNjdXNzaW9uIHdvdWxkIGJlIGNsZWFyZXIuDQo+IG1ha2VzIHNlbnNlLCB0aGFu
ayB5b3UhDQo+IA0KPiBbLi4uXQ0KPiA+ID4gQEAgLTExOTUsNyArMTE5NSw3IEBAIHN0YXRpYyB2
b2lkIHJ0d19zZGlvX2luZGljYXRlX3R4X3N0YXR1cyhzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LA0K
PiA+ID4gICAgICAgICBza2JfcHVsbChza2IsIHJ0d2Rldi0+Y2hpcC0+dHhfcGt0X2Rlc2Nfc3op
Ow0KPiA+ID4NCj4gPiA+ICAgICAgICAgLyogZW5xdWV1ZSB0byB3YWl0IGZvciB0eCByZXBvcnQg
Ki8NCj4gPiA+IC0gICAgICAgaWYgKGluZm8tPmZsYWdzICYgSUVFRTgwMjExX1RYX0NUTF9SRVFf
VFhfU1RBVFVTKSB7DQo+ID4gPiArICAgICAgIGlmIChpbmZvLT5mbGFncyAmIElFRUU4MDIxMV9U
WF9DVExfUkVRX1RYX1NUQVRVUyAmJiBxdWV1ZSA8PSBSVFdfVFhfUVVFVUVfVk8pIHsNCj4gPg0K
PiA+IElzIHRoaXMgYmVjYXVzZSB5b3UgaGF2ZSBzZWVuICJmYWlsZWQgdG8gZ2V0IHR4IHJlcG9y
dCI/DQo+ID4gSGF2ZSB5b3UgdHJpZWQgdG8gaW5jcmVhc2luZyBSVFdfVFhfUFJPQkVfVElNRU9V
VD8NCj4gPg0KPiA+IElmIGl0IHN0aWxsIGNhbid0IGdldCBUWCByZXBvcnQsIHdlIG1pZ2h0IHRh
a2UgdGhpcyB3b3JrYXJvdW5kIHdpdGggY29tbWVudHMNCj4gPiB0byBtZW50aW9uIHdoeSB3ZSBu
ZWVkIGl0LiBPciBhIGxvY2FsIHZhcmlhYmxlIHdpdGggcHJvcGVyIG5hbWluZyB0byBwb2ludCBv
dXQNCj4gPiB0aGlzLCBsaWtlDQo+ID4NCj4gPiAgICAgICAgIGJvb2wgcXVldWVfaGFzX25vX3R4
X3JlcG9ydCA9IHF1ZXVlID4gUlRXX1RYX1FVRVVFX1ZPOw0KPiA+DQo+ID4NCj4gPiBCeSB0aGUg
d2F5LCBVU0IgYmVoYXZpb3IgaXMgdmVyeSBsaWtlIHRvIFNESU8sIGJ1dCBUWCByZXBvcnQgc2Vl
bXMgdG8gd29yayB3ZWxsLg0KPiBPbiBteSBSVEw4ODIyQ1MgSSBjYW4gY29uZmlybSB5b3VyIHRo
b3VnaHQ6DQo+IEkgZG9uJ3Qgbm90aWNlIGFueSBleHRyYSAiZmFpbGVkIHRvIGdldCB0eCByZXBv
cnQiIG1lc3NhZ2VzIHJlZ2FyZGxlc3MNCj4gb2Ygd2hldGhlciBJIGhhdmUgIiYmIHF1ZXVlIDw9
IFJUV19UWF9RVUVVRV9WTyIgb3Igbm90Lg0KPiANCg0KVGhpcyB3b3JrYXJvdW5kIG1pZ2h0IG5l
ZWQgYW4gY2hpcCBhdHRyaWJ1dGUgdG8gZW5hYmxlIHRoZW4uIA0KTm90IHN1cmUgaWYgcGVvcGxl
IGluIHRoZSBHaXRIdWIgdGhyZWFkIGhhdmUgZXhwZXJpbWVudHMgb24gYWxsDQpzdXBwb3J0ZWQg
U0RJTyBXaUZpIGNoaXBzLiANCg0K

