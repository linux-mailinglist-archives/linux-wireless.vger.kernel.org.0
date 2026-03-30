Return-Path: <linux-wireless+bounces-34149-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id n1UROBj0yWlO3gUAu9opvQ
	(envelope-from <linux-wireless+bounces-34149-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 05:55:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA1635514B
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 05:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C78F430068F0
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 03:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E71258CCC;
	Mon, 30 Mar 2026 03:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="KCR4CJDu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614F31A9B46
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 03:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774842899; cv=none; b=IVNyzsLuVvVVQXJ+GiYq39WdNy87n0rWfBRIFX4oICgGE9tRQWjTYmG373Kuzm7XIyxdezy47w8Wc0h7ISg8wYBXW5eb7eHrGORvHgAH2CsPZ1NG2hOEUuUdK2vh98KlbacIuvqh2+rsNc02tCmjNa129D4ODOboVjK7pvn7W98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774842899; c=relaxed/simple;
	bh=oqN1qhDlSogFnQ16xjE9UCzRRQKSfBfR7UVYIM7jUv4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jJ2qEwDuzi2AsUPo5zFrtLPn0hTpS551VG/GlUZTo5f4uVdyVnB7EbiEpRKjfXmXCgfcf19WSUN7AtWFExdEpBFomGYuIDtX4MU3UcYqtbuKwzyWKCyQ+vCHIGWelFyHH7QlNekVSQMil9T8PHwUS++6rhR/gRZNE75vhmba4lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=KCR4CJDu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U3ss3vB296092, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774842894; bh=oqN1qhDlSogFnQ16xjE9UCzRRQKSfBfR7UVYIM7jUv4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=KCR4CJDuCUZgL17UozYEzSQytc3ubhOSXWsS+m1x5eHqjrshOq6JvzS3Lffy7vfBc
	 gaI9v21VCO5RwjqgjmNqPPKN1VKptmpU9Vh9mPjhMH1qer6XOAbbiWJooqdK0AFwI4
	 ZTxU/YnIcgIZRB7d/T80OUNIttFMPh5RQ0jHcjmR7LRvfUt0NPk/uwvom06Qo+YGkM
	 i5XLQWb/70xMmY1yCZxiEikmiOcRRbHqFeNvKtihcEo42CINK7FxJUhLMma6aIzHLW
	 0MgeeR4J5g4s2gwG1yyNTudqEd3Yr99vxO7MtqOrGpTTXoZwx1D7IgKpLc+wkipdXj
	 1i06bZPinLLzQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U3ss3vB296092
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 11:54:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 11:54:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::46e9:fab9:b2cf:c99b%10]) with mapi id
 15.02.1748.010; Mon, 30 Mar 2026 11:54:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 07/12] wifi: rtw89: Fix
 rtw8922a_pwr_{on,off}_func() for USB
Thread-Topic: [PATCH rtw-next 07/12] wifi: rtw89: Fix
 rtw8922a_pwr_{on,off}_func() for USB
Thread-Index: AQHcvUL0QNu1bapE2k6rtuOS3OJRyrXGdyyw
Date: Mon, 30 Mar 2026 03:54:54 +0000
Message-ID: <93fbf83fb3674144823c0bd6c1feef2e@realtek.com>
References: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
 <d8a90345-ba4d-49a5-a967-af07e7390aab@gmail.com>
In-Reply-To: <d8a90345-ba4d-49a5-a967-af07e7390aab@gmail.com>
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
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-34149-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 4AA1635514B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGVy
ZSBhcmUgYSBmZXcgZGlmZmVyZW5jZXMgaW4gdGhlIHBvd2VyIG9uL29mZiBmdW5jdGlvbnMgYmV0
d2VlbiBQQ0lFDQo+IGFuZCBVU0IuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNt
aXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8
cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNClsuLi5dDQoNCj4gQEAgLTM3MSw2ICszODAsMTAgQEAg
c3RhdGljIGludCBydHc4OTIyYV9wd3Jfb25fZnVuYyhzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYp
DQo+ICAgICAgICAgaWYgKHJldCkNCj4gICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+IA0K
PiArICAgICAgIHJldCA9IHJ0dzg5X21hY193cml0ZV94dGFsX3NpKHJ0d2RldiwgWFRBTF9TSV9T
UkFNX0NUUkwsIDAsIFhUQUxfU0lfU1JBTV9ESVMpOw0KPiArICAgICAgIGlmIChyZXQpDQo+ICsg
ICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiArDQoNClRoYW5rcyBmb3IgdGhpcyBtaXNzZWQg
ZW50cnkuDQoNCj4gICAgICAgICBpZiAoaGFsLT5jdiAhPSBDSElQX0NBVikgew0KPiAgICAgICAg
ICAgICAgICAgcnR3ODlfd3JpdGUzMl9zZXQocnR3ZGV2LCBSX0JFX1BNQ19EQkdfQ1RSTDIsIEJf
QkVfU1lTT05fRElTX1BNQ1JfQkVfV1JNU0spOw0KPiAgICAgICAgICAgICAgICAgcnR3ODlfd3Jp
dGUzMl9zZXQocnR3ZGV2LCBSX0JFX1NZU19JU09fQ1RSTCwgQl9CRV9JU09fRUIyQ09SRSk7DQoN
Cg0KDQo=

