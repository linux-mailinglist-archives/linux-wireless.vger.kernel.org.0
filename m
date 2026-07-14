Return-Path: <linux-wireless+bounces-39016-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9SpLHyrrVWqPvwAAu9opvQ
	(envelope-from <linux-wireless+bounces-39016-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 09:54:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B6975218E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 09:54:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=dPdiXnjJ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39016-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39016-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 098D9301FA92
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 07:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354F13DB330;
	Tue, 14 Jul 2026 07:54:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E88B3E1D04
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 07:54:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015643; cv=none; b=sC/VqtQfbJ3UuAWPvfykRkaN6vxS/ilSe+mVIKfHU5kAR9h4rY+p4+6tg9pmxCViRMHJZHM86q6B4e1P9n39XHD8/TEdTU9tr9A07aJrW/PVGs4BVjuv4XHSw7EMHf5J6OHhKRlk792Zd/8S9LKyni23M5gkfiEjBavnlAhFcFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015643; c=relaxed/simple;
	bh=1KJjbT4EY2MXRIn8Auxwx/tKVvxqNRy8qCXE4oEQv9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KnbztDxlGQ/vPpMUMjAZZaTf0FmV8sHzD1c9k4YzQwUEz7phkItNaqQQ2n4hHu0LI1X4qlCwvv4LQpOatEDA72QM2KCuJ4IVnPCnc5Nb6WaZlm1GHKONB5YbJ38W65FpoiFgNw/IQhOQrWQ7uAQBJ9CJmlttUHpPW42hxZLVYV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dPdiXnjJ; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66E7rvQG31964068, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784015638; bh=1KJjbT4EY2MXRIn8Auxwx/tKVvxqNRy8qCXE4oEQv9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dPdiXnjJmAzJ5l+nasuri5xSr/Dx57HPBgl2IC8zKDJFNntAgv6CVdRwYspWzfygy
	 2+/fH0OUVkvxtkDT7BDkBd0nJ4nmF+dy6EflugIOK/R7a4ziYTMkx93GgmQflq8NxN
	 F++sFnyne/qbVzVr8SET3nhCVWzFjUMLUKcrlz0aNvOP0JotkHNjQ4MtGt5wYav28v
	 hAUIzV3XGu7V+0C6U0i07d9iN1MLk6Slh5Xriwj83bbmh/rpsglcGa4PAUjCZd2tu7
	 mIXDehU5ykPVD0UkcAzvAfn9gmRPyxbA1p8NxvS75bP+UgK9ShakFoOMu0vcCJIYwS
	 nB2whusUQQiUA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66E7rvQG31964068
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Jul 2026 15:53:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Jul 2026 15:53:57 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Tue, 14 Jul 2026 15:53:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Leo.Li <leo.li@realtek.com>, Gary Chang <gary.chang@realtek.com>, "Eric
 Huang" <echuang@realtek.com>, Johnson Tsai <wenjie.tsai@realtek.com>, "Bernie
 Huang" <phhuang@realtek.com>, Isaiah <isaiah@realtek.com>, Zong-Zhe Yang
	<kevin_yang@realtek.com>, Mh_chen <mh_chen@realtek.com>
Subject: RE: [PATCH rtw-next 08/16] wifi: rtw89: add IO offload support via
 firmware
Thread-Topic: [PATCH rtw-next 08/16] wifi: rtw89: add IO offload support via
 firmware
Thread-Index: AQHc0He0BaKS+P8UtUOY/lQhIivM9rZlNpIAgAfzQPA=
Date: Tue, 14 Jul 2026 07:53:57 +0000
Message-ID: <6fa6264e9a86488abfd971a32bfcf44a@realtek.com>
References: <20260420034051.17666-1-pkshih@realtek.com>
 <20260420034051.17666-9-pkshih@realtek.com>
 <c2c05574-2179-4b9e-b681-90387bea3561@gmail.com>
In-Reply-To: <c2c05574-2179-4b9e-b681-90387bea3561@gmail.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rtl8821cerfe2@gmail.com,m:linux-wireless@vger.kernel.org,m:leo.li@realtek.com,m:gary.chang@realtek.com,m:echuang@realtek.com,m:wenjie.tsai@realtek.com,m:phhuang@realtek.com,m:isaiah@realtek.com,m:kevin_yang@realtek.com,m:mh_chen@realtek.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39016-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:from_mime,realtek.com:dkim,realtek.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4B6975218E

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAy
MC8wNC8yMDI2IDA2OjQwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gK3N0YXRpYyB2b2lkIHJ0
dzg5X2Z3X2NtZF9vZmxkX3VkZWxheShzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYsIHUzMiB1cykN
Cj4gPiArew0KPiA+ICsgICAgIHN0cnVjdCBydHc4OV9md19jbWRfb2ZsZF9hcmcgY21kID0gew0K
PiA+ICsgICAgICAgICAgICAgLnNyYyA9IFJUVzg5X0ZXX0NNRF9PRkxEX1NSQ19PVEhFUiwNCj4g
PiArICAgICAgICAgICAgIC50eXBlID0gUlRXODlfRldfQ01EX09GTERfREVMQVksDQo+ID4gKyAg
ICAgICAgICAgICAudmFsdWUgPSB1cywNCj4gPiArICAgICB9Ow0KPiA+ICsgICAgIGludCByZXQ7
DQo+ID4gKw0KPiA+ICsgICAgIHJldCA9IHJ0dzg5X2Z3X2NtZF9vZmxkX2VucXVldWUocnR3ZGV2
LCAmY21kKTsNCj4gPiArICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAgdWRlbGF5KHVz
KTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgcnR3ODlfZndfY21kX29mbGRfbWRl
bGF5KHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwgdTMyIG1zKQ0KPiA+ICt7DQo+ID4gKyAgICAg
c3RydWN0IHJ0dzg5X2Z3X2NtZF9vZmxkX2FyZyBjbWQgPSB7DQo+ID4gKyAgICAgICAgICAgICAu
c3JjID0gUlRXODlfRldfQ01EX09GTERfU1JDX09USEVSLA0KPiA+ICsgICAgICAgICAgICAgLnR5
cGUgPSBSVFc4OV9GV19DTURfT0ZMRF9ERUxBWSwNCj4gPiArICAgICAgICAgICAgIC52YWx1ZSA9
IG1zICogMTAwMCwNCj4gPiArICAgICB9Ow0KPiA+ICsgICAgIGludCByZXQ7DQo+ID4gKw0KPiA+
ICsgICAgIHJldCA9IHJ0dzg5X2Z3X2NtZF9vZmxkX2VucXVldWUocnR3ZGV2LCAmY21kKTsNCj4g
PiArICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAgbWRlbGF5KG1zKTsNCj4gPiArfQ0K
PiBUaGlzIGNhbiBmYWlsIHRvIGNvbXBpbGUgd2l0aCBzb21lIGtlcm5lbCBjb25maWd1cmF0aW9u
cyBiZWNhdXNlDQo+IFJUVzg5X0ZXX0NNRF9PRkxEX1NSQ19PVEhFUiAoNCkgZG9lc24ndCBmaXQg
aW4gdGhlIG1hc2sNCj4gUlRXODlfSDJDX0NNRF9PRkxEX1cwX1NSQyAoR0VOTUFTSygwLCAxKSk6
DQoNClRoYW5rcyBmb3IgdGhlIHJlcG9ydC4NCg0KSSBzZW50IGEgcGF0Y2ggWzFdIHdpdGggZmly
c3QgZ2l0aHViIGxpbmsuIElmIHRoaXMgdGhlIGxpbmsgaXNuJ3QgZ29vZCB0byB5b3UsDQpwbGVh
c2UgbGV0IG1lIGtub3cuIEkgY2FuIGNoYW5nZSBpdC4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LXdpcmVsZXNzLzIwMjYwNzE0MDc0ODExLjMwMTI0LTEtcGtzaGloQHJlYWx0
ZWsuY29tL1QvI3UNCg0KDQoNCg0K

