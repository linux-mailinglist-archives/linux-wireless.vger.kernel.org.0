Return-Path: <linux-wireless+bounces-35103-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN4pAE/O5mlR1AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35103-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 03:09:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5E74353A0
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 03:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61C20300C9BF
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 01:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E6D8F4A;
	Tue, 21 Apr 2026 01:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="U3bWq+fD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD0818FDDE
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 01:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776733772; cv=none; b=WTNk8SgKNc1foTZ6vmaAHroUkckpFJQQh2p01oWNo0sQ6votm2nD/gtJKjngKaiQX2Weeti99FNYOCwwOlyMMPvlDYCIHrpI9wy1bXoccXFggHQpDQs9Da9qd7yDXgcY0iETlug/uE5KXwMf2uF4TYufjGLN496r233UKkh/d4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776733772; c=relaxed/simple;
	bh=rbv+xreQiVFUK0RHnGIPMt5k3qONe4qRKtqSkNza2EA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WIFEr77X8WL66ErQtLNKI+QudG3k4vlRfNXsg93t2ZkZMMzRXZri7tqbZQySjzt+94Wa2F/KY/obbKr7Z5gtyyruGsVMhhRpIsyEC4qh0HJoOw6vGSGHh6ODwARu9//ItT7TJFi2vCE5Ratg1RhqT1Y+nuXyDI7D5Sz6ZxIwpyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=U3bWq+fD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63L19RcQ42152052, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776733767; bh=rbv+xreQiVFUK0RHnGIPMt5k3qONe4qRKtqSkNza2EA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=U3bWq+fD0A6GcmThaqt1e0Ll6u9KAfIw/wywyiOHs4yQDWuk7ArtwPPrwRsiwdQxv
	 TZ/o/lMkK3mDFz9sbkg/D5sMjT6LS5azDV2jgFwMpHx8Ec7A4hofYjFDnn3fSz+Op4
	 XwXGqE3FjMD/KvzucHzLepSVHJszLmHrOEKFwFAFixK4FEF6D3+IBsL2cDGEX9CVP7
	 UZTcP9bJzFKIEOVs53g8OaRIXZiMVnxEtLJeRnpLHse1Thykif8dOr+hy5Hyqmjib2
	 78uloUOalXbwTY6XWpfPpaRez8dP7MjLlr0CQVce6wWNPcetxMapl7uOTa3y9UoG/Y
	 yzT7xitVxyHxA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63L19RcQ42152052
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 09:09:27 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 21 Apr 2026 09:09:27 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Tue, 21 Apr 2026 09:09:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 00/11] wifi: rtw89: Add support for RTL8922AU
Thread-Topic: [PATCH rtw-next v2 00/11] wifi: rtw89: Add support for RTL8922AU
Thread-Index: AQHc0AH0GCGMzHZNQkut68u1SnpP1rXnnM9QgAAidwCAAPO4IA==
Date: Tue, 21 Apr 2026 01:09:27 +0000
Message-ID: <7c97c857607f41df912558194103d34c@realtek.com>
References: <6ba2910d-020c-41bd-86fa-d1b0e0f7a2f5@gmail.com>
 <6c97027e16a5407da0031eb503219a25@realtek.com>
 <2ba61201-5e3c-4b95-88a1-38dd5812ebf0@gmail.com>
In-Reply-To: <2ba61201-5e3c-4b95-88a1-38dd5812ebf0@gmail.com>
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
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-35103-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
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
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:mid]
X-Rspamd-Queue-Id: 6F5E74353A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAy
MC8wNC8yMDI2IDExOjIwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4NCj4gPiBCaXR0ZXJibHVl
IFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4+IFR3byBwZW9wbGUg
aGF2ZSB0ZXN0ZWQgTUxPIHNpbmNlIHYxLiBJdCBkb2Vzbid0IGV4cGxvZGUsIHNvIEkgZHJvcHBl
ZA0KPiA+PiB0aGUgcGF0Y2ggdG8gZGlzYWJsZSBNTE8uIChJdCBkb2Vzbid0IHdvcmsgdmVyeSB3
ZWxsIHdpdGggTUxPLCBidXQNCj4gPj4gwq9cXyjjg4QpXy/CrykNCj4gPg0KPiA+IENvdWxkIHlv
dSBzaGFyZSB0aGUgbGluayB0aGV5IGRpZD8gV2UgY2FuIGNoZWNrIHRoZW0gaW50ZXJuYWxseS4N
Cj4gPg0KPiA+IFBpbmctS2UNCj4gPg0KPiA+DQo+ID4NCj4gDQo+IE9uZSByZXBvcnRzIHRoYXQg
aXQgd29ya3MgZmluZToNCj4gDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9tb3Jyb3duci9VU0ItV2lG
aS9pc3N1ZXMvNDk0I2lzc3VlY29tbWVudC00Mjc2NzI3OTE5DQo+IA0KPiBPbmUgcmVwb3J0cyBj
b25zdGFudCBkaXNjb25uZWN0aW9ucyBhbmQgc3RyYW5nZSBlcnJvcnMgbGlrZQ0KPiAic2VjIGNh
bSBlbnRyeSBpcyBlbXB0eSI6DQoNCkkgdGhpbmsgdGhpcyBpcyBiZWNhdXNlIFRYIHBhY2tldCB3
aXRoIGEgc2VjdXJpdHkga2V5LCBidXQgaXQgd2FzIGRlbGV0ZWQNCmJlY2F1c2Ugb2YgIihSZWFz
b246IDI9UFJFVl9BVVRIX05PVF9WQUxJRCkiLg0KDQo+IA0KPiBodHRwczovL2dpdGh1Yi5jb20v
bW9ycm93bnIvcnR3ODkvaXNzdWVzLzIzI2lzc3VlY29tbWVudC00MjI2NzY5OTE0DQoNCkkgd2ls
bCB0cnkgaWYgd2UgaGF2ZSBhbiBBc3VzIEJUOCAob3JnIGZpcm13YXJlKS4NCg0KUGluZy1LZQ0K
DQo=

