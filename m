Return-Path: <linux-wireless+bounces-36746-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFRNOL+3DmrBBgYAu9opvQ
	(envelope-from <linux-wireless+bounces-36746-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 09:43:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D015A04A0
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 09:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0951E3024C9A
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 07:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B1134E745;
	Thu, 21 May 2026 07:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="RGYywP8M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B54233958
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349108; cv=none; b=rb7crosOaNvBJm/NoThKNkCAJwSZtqlyF5+wLfvR2IGosiLvalbHWMcZEwfcmQ9Gy+V+b6RXb+ZNG0L3MN4k4c0BglNhyquwCmqMJmKvPWjdFaigyeDBR1rWa2DcVyq0ucTG3utQH8WC2RD2CcDGoHZ2BEKf+mb3FF7jJyAWAak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349108; c=relaxed/simple;
	bh=s2CYL32JDwclpVJqnmnje4du8Hngvb+RrJC3FMVCi3o=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C42z0JL3PMZIRrcrjF3zc/dWexyKNyse6sVDVZ19Z+VO3LBTCTKHyBXaEZrMADHf9+VOpVA2RiQFIP8fOkcJ8IRmIigoFStkIAPgBmOxUK7SFV1jFyOMfF+ewEI4Hwh+F4jGAUanlQM1VobxTcjO0QVb02dgaJojAnhhPIN1dO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=RGYywP8M; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64L7cDlM51122906, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779349093; bh=s2CYL32JDwclpVJqnmnje4du8Hngvb+RrJC3FMVCi3o=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=RGYywP8Mtsc17kK2clAhymRPDKlOLyE+JrW/oIILsXyLlFuC5n5lfrFCtJiu/0DC9
	 0y5CmKK1wzxeJqe1iLwwSvRje2AIeO+U+Fi4AmGsysvPvGadpy9xp383ZjLkbk3chL
	 YoJrS9JM1sRXfgLa7kF9kuvZKl5s+35Dea4yFDGWGBFHVBMpDzLF3+d4LaCqBQc3aH
	 ER72I2BcvylLQMkxSVfWD6JA/DUQaNrmcw+UV5whA5pI7bdvbLQIhmVxcxczhN7nYd
	 +AxLGyRbdZ18/d4y8+2MOrobQM45SPj6/C6bqOFLk3fYDE/fRcH92M9dUNhiNCyUZN
	 Uml2gzZBQPAEQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64L7cDlM51122906
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 15:38:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 May 2026 15:38:14 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 May 2026 15:38:14 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Thu, 21 May 2026 15:38:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Masashi Honma
	<masashi.honma@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v6 1/6] wifi: mac80211: Use struct instead of macro for
 PREQ frame
Thread-Topic: [PATCH v6 1/6] wifi: mac80211: Use struct instead of macro for
 PREQ frame
Thread-Index: AQHc5MP/zOngxkWbM0ai666I8zXda7YWRAMAgAFlUeCAAGI1LYAADEAQ
Date: Thu, 21 May 2026 07:38:13 +0000
Message-ID: <7e1aac3afd714d448e5bfba4a9a113b0@realtek.com>
References: <20260515233839.86829-1-masashi.honma@gmail.com>
	 <965eff7ec3b928f093f7891e4307ec4e4a080ac4.camel@sipsolutions.net>
	 <d2c051127e384a918ff014da02e37e1e@realtek.com>
	 (sfid-20260521_024301_935117_BC310192)
 <93ab81b4fb7130a4d4e1048581d886568086fe24.camel@sipsolutions.net>
In-Reply-To: <93ab81b4fb7130a4d4e1048581d886568086fe24.camel@sipsolutions.net>
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
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36746-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[sipsolutions.net,gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 63D015A04A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQpKb2hhbm5lcyBCZXJnIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0PiB3cm90ZToNCj4gVGhl
IHBvaW50IGlzIHRoYXQgX19wYWNrZWQgZm9yY2VzIHRoZSBjb21waWxlciB0byBlbWl0IGNvZGUg
dGhhdCBkb2Vzbid0DQo+IHJlbHkgb24gYWxpZ25tZW50Lg0KDQpJIHdhcyBub3QgYXdhcmUgdGhh
dCBfX3BhY2tlZCBpcyBhIGhpbnQgb2YgdW5hbGlnbm1lbnQgdG8gY29tcGlsZXIuDQpJIGxlYXJu
ZWQuIDopDQoNCj4gDQo+IFNvIHNheSBlLmcuIHlvdSBoYXZlDQo+IA0KPiAgICAgICAgIF9fbGUz
MiAqcHRyID0gLi4uOw0KPiANCj4gICAgICAgICB1MzIgdmFsID0gY3B1X3RvX2xlMzIoKnB0cik7
DQo+IA0KPiBJbiB0aGlzIGNhc2UsIHRoZSBjb21waWxlciBjYW4gZW1pdCBhIGxvYWQgaW5zdHJ1
Y3Rpb24gdGhhdCBhc3N1bWVzDQo+IGFsaWdubWVudCwgc28gaWYgJ3B0cicgY2FuIGJlIHVuYWxp
Z25lZCwgd2UgbmVlZCB0byB1c2UNCj4gDQo+ICAgICAgICAgdTMyIHZhbCA9IGdldF91bmFsaWdu
ZWRfbGUzMihwdHIpOw0KDQpHb3QgaXQuDQpXaXRoIHRoZSBhc3NpZ25tZW50IHRvIHBvaW50ZXIs
IHRoZSBoaW50IGRpc2FwcGVhcmVkLiANCg0KPiANCj4gaW5zdGVhZC4NCj4gDQo+IEhvd2V2ZXIs
IGlmIHdlIGhhdmUNCj4gDQo+ICAgICAgICAgc3RydWN0IGllZWU4MDIxMV9tZXNoX2h3bXBfcHJl
cV90b3AgKnB0ciA9IC4uLjsNCj4gDQo+ICAgICAgICAgdTMyIHZhbCA9IGNwdV90b19sZTMyKHB0
ci0+cHJlcV9pZCk7DQo+IA0KPiB0aGVuIHRoZSBjb21waWxlciBfY2Fubm90XyBlbWl0IGEgbG9h
ZCBpbnN0cnVjdGlvbiB0aGF0IGFzc3VtZXMNCj4gYWxpZ25tZW50IGJlY2F1c2Ugb2YgdGhlIF9f
cGFja2VkLCBhbmQgc28gdGhlIGNvbXBpbGVyIGhhcyB0byBlbWl0IGENCj4gKHBlcmhhcHMgc2Vx
dWVuY2Ugb2YpIGluc3RydWN0aW9uKHMpIHRoYXQgbG9hZCB0aGUgMzItYml0IHZhbHVlIHdpdGhv
dXQNCj4gcmVseWluZyBvbiBhbGlnbm1lbnQuIEFzIGEgY29uc2VxdWVuY2UsIHdlIGRvbid0IGhh
dmUgdG8gZXhwbGljaXRseQ0KPiB3cml0ZSBpdCB0aGUgbW9yZSBjb21wbGljYXRlZCB3YXkgYW5k
IGNhbiBqdXN0IHdyaXRlIGl0IHRoZSBtb3JlIG5hdHVyYWwNCj4gd2F5Lg0KDQpJJ2xsIHJlbWVt
YmVyIHRoaXMgaXMgYmV0dGVyIHN0eWxlIGluIHByYWN0aWNlLiBDb21waWxlciBjYW4gaGVscC4N
Cg0KDQpJbiBteSB0ZXN0cyB3aXRoIGFybS1nY2MgY29tcGlsZXIsIEkgZGlkIGEgc3BlY2lhbCBj
YXNlOiANCg0Kc3RydWN0IGZvbyB7DQoJaW50IGE7DQoJY2hhciBiOw0KfSBfX3BhY2tlZDsNCg0K
aW50IGJhcihzdHJ1Y3QgZm9vICpmb28pDQp7DQoJcmV0dXJuIGZvby0+YTsNCn0NCg0KSXQgaXMg
b2J2aW91c2x5IGFsaWduZWQgKG9mZnNldCA9IDApLCBzbyBJIGd1ZXNzZWQgYXJtLWdjYyBjYW4g
Z2VuZXJhdGUNCmEgc2luZ2xlIGxvYWQgaW5zdHJ1Y3Rpb24sIGJ1dCBhY3R1YWxseSBpdCBkb2Vz
bid0IChldmVuIHdpdGggLU8zKS4NCkJ1dCB0aGlzIGlzIG5vdCB0aGUgY291cnNlIG9mIHRoaXMg
dGhyZWFkLiA6KQ0KDQpUaGFuayB5b3UNClBpbmctS2UNCg0K

