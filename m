Return-Path: <linux-wireless+bounces-16580-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21E99F7495
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 07:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8A437A178B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 06:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925F314A0AA;
	Thu, 19 Dec 2024 06:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="QXKV/5C6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0631878F4C
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 06:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734589053; cv=none; b=OCU9K6b79yyy+ICfbn3sNNada6M9NUrGTpBOnuS7elhvvy+qad+90c18pAh5Wc7wrqS8Og/9SlGAJonoNdPaYC/0VJDa3OXVmK9jvoRK4FgcHGCoymZ5dU6t9fT8vWWDR0/DmWNOLSwqgB2EhSLBQV2O8anlylA1UyzS6Za5QYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734589053; c=relaxed/simple;
	bh=NGxUcJSg8QFBsqPZawz/AJ1eI+FzvuCQ8F38b0BTWkE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Djk6pdgQ3gVhmRGwH5XgLR2nrK5U0CKs5bCX27E+53wu6gNzWde/ii400Q8Qv0UaLfO6APczc75sUR+Hugef3hyQ9CWBZmjcaBvVTEL+UkrtgWoMbDs8W20l6YxClJ5ZatZrbQ8DjvDmn8NsDdVyK0c2cef4fVB2Kg0W+3CBRbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=QXKV/5C6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BJ6HGcW43544611, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1734589036; bh=NGxUcJSg8QFBsqPZawz/AJ1eI+FzvuCQ8F38b0BTWkE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=QXKV/5C6Av+1cafI1GUhg6MjGRIxkMdN8B6hzEHpY9Tlm7+zegNPn7tefulWA8dwt
	 CfwURQrY06SOJ99szJ5ZcVaNR8sY/T5oJ+HA8m21xCei6tkpkpMSpXss/k+c6LnK74
	 kiEFwoDikRzfs9HVz3fQPOu96tLPhoNnIJ+KwXNyKEFeF0IsfnRZL2pRGXDDJxN2xU
	 pzSDQpffhUHjTFr3NCMmvN6icWhmk5eLLIajymItITudPVgg+3Pyhv4+sQiyhyZlVJ
	 cAFI2c2ammfeRNDFnlQtWxi/zmgkTj01E0EK/VUFQkhCnDKKzX9nqau7iZSuYnljS7
	 YYALkvR+tgR/w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BJ6HGcW43544611
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 14:17:16 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Dec 2024 14:17:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 19 Dec 2024 14:17:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 19 Dec 2024 14:17:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH v2 1/3] wifi: rtw88: usb: Copy instead of cloning the RX skb
Thread-Topic: [PATCH v2 1/3] wifi: rtw88: usb: Copy instead of cloning the RX
 skb
Thread-Index: AQHbUZzcrmQVskseOke32iJUF4a4cLLtF2fw
Date: Thu, 19 Dec 2024 06:17:06 +0000
Message-ID: <7c4a0c905cec4bf4ba8c3bab78342196@realtek.com>
References: <8c9d4f9d-ebd8-4dc0-a0c4-9ebe430521dd@gmail.com>
In-Reply-To: <8c9d4f9d-ebd8-4dc0-a0c4-9ebe430521dd@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHNrYiA9IGFsbG9jX3NrYihza2JfbGVuLCBHRlBfS0VSTkVM
KTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFza2IpIHsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBydHdfZGJnKHJ0d2RldiwgUlRXX0RCR19VU0IsDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiZmFpbGVkIHRvIGFsbG9jYXRlIFJY
IHNrYiBvZiBzaXplICV1XG4iLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc2tiX2xlbik7DQoNCmNoZWNrcGF0Y2ggd2FybnMgdGhpcyBpcyB1bm5lY2Vzc2FyeS4g
DQoNCldBUk5JTkc6IFBvc3NpYmxlIHVubmVjZXNzYXJ5ICdvdXQgb2YgbWVtb3J5JyBtZXNzYWdl
DQojOTQ6IEZJTEU6IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdXNiLmM6NTkx
Og0KKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFza2IpIHsNCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcnR3X2RiZyhydHdkZXYsIFJUV19EQkdfVVNCLA0KDQoNCg0K

