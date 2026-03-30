Return-Path: <linux-wireless+bounces-34140-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIImL8nlyWlC3QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34140-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 04:54:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B47354EB2
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 04:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 327EB30039AB
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 02:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B224C2D3A7C;
	Mon, 30 Mar 2026 02:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="RE7DMHek"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4540A393DC7
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 02:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774839233; cv=none; b=XpQB6SeyXSknPsCX1JGiF39r77/PS1atFanlRU3+iHoNNraGumJ5csdIed743pc5rbyhGiJPERatsNW1JQ3OjeMXH4oadCCz0g/MlqPJsQnbO/qUppzJrNVuBGMNBXPx6ip5c1UiB9mOhene6NQTz6CKuvLdVEoloni6HSSqynM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774839233; c=relaxed/simple;
	bh=AiPXs6LuDSvOxPO+6z37SSPX6jbgfccQ0rYnqiJnFIg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oigZcOpiagU1z2LXb/+KL3J8piN86pm0SOSNnz10lxp1C1xgkgzQzjDbxPml3k0lcOCf0rujtVdqofaTOtbjujXzWo75gNWq9Q0TT+gsHte89mUxpg7DMOKqubQ457eFmCoLZpDQi5Ace/QZcPlE3Bz2vgE3pc7pM7+G772xAiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=RE7DMHek; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U2rmqK7195174, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774839228; bh=AiPXs6LuDSvOxPO+6z37SSPX6jbgfccQ0rYnqiJnFIg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=RE7DMHekFkjyM1lkARaxzsxDZ85mXRKFI2Y5yQcpHvvTEgH/ZjubDRfG3UA3T3fkk
	 jy8oVJKeEOP60giWygLosWhlyNFIgOAF/UxR8dEZp5U6MubAjgOWygI9HOnR8ELeaD
	 XUeikD0+QQsTLaCrwah4caReW579/yQ6LhUK/iqST7Z1hwkbIubZJWqARqA2mxxRTy
	 +V+m64SyTRzbnyXZjslFfMuiuplW50W6c+yQsaGgjhTVaBOOAcNZWDaDVhDiNhq1l0
	 93mf3fSc5iu9lI/7nDiz0IGgJJgc9ajNz/CPZCJbIIqN7JvtRU6Wcn8JhS8PCOLXq1
	 2mCcRDVR6k0oA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U2rmqK7195174
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 10:53:48 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 10:53:45 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::46e9:fab9:b2cf:c99b%10]) with mapi id
 15.02.1748.010; Mon, 30 Mar 2026 10:53:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 00/12] wifi: rtw89: Add support for RTL8922AU
Thread-Topic: [PATCH rtw-next 00/12] wifi: rtw89: Add support for RTL8922AU
Thread-Index: AQHcvUJaf1EFq86SyU2PseRbtxmFrLXGZTQg
Date: Mon, 30 Mar 2026 02:53:45 +0000
Message-ID: <25781f4aa6cc427caf396374ca46d380@realtek.com>
References: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
In-Reply-To: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34140-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 58B47354EB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPZnRl
biBvbmUgb3IgbW9yZSBvZiB0aGVzZSBtZXNzYWdlcyBhcHBlYXJzIHdoZW4gdGhlIGNoaXAgcG93
ZXJzIG9uOg0KPiANCj4gWyAgKzIuMTY3MDM3XSBydHc4OV84OTIyYXUgMS0yOjEuMDogZmFpbGVk
IHRvIHdhaXQgUkYgREFDSw0KPiANCj4gWyAgKzIuOTQyNzQ5XSBydHc4OV84OTIyYXUgMS0yOjEu
MDogZmFpbGVkIHRvIHdhaXQgUkYgVFNTSQ0KPiANCj4gWyAgKzAuMDE5MDA2XSBydHc4OV84OTIy
YXUgMi00OjEuMDogZmFpbGVkIHRvIHdhaXQgUkYgUFJFX05URlkNCj4gDQo+IFsgICs1Ljk4NTkw
MF0gcnR3ODlfODkyMmF1IDItNDoxLjA6IGZhaWxlZCB0byB3YWl0IFJGIERQSw0KPiANCj4gSXQn
cyB1bmNsZWFyIHdoeS4NCg0KUlRMODkyMkQgZG9uZSBSRiBjYWxpYnJhdGlvbnMgYnkgZmlybXdh
cmUgb25lIGJ5IG9uZSwgc28gZHJpdmVyIHNob3VsZA0Kd2FpdCBmb3IgcHJldmlvdXMgb25lIGRv
bmUsIGFuZCB0cmlnZ2VyIG5leHQgb25lLiBIb3dldmVyLCBpdCdkIGJlDQp3ZWxsIHRvIGp1c3Qg
ZG8gd2FpdGluZyBhdCB0aGUgbGFzdCB0byB3YWl0IGZvciBhbGwgY2FsaWJyYXRpb25zLiANCg0K
VHJ5IHRvIGVubGFyZ2Ugd2FpdGluZyB0aW1lIGluIHJ0dzg5MjJhX3Jma19jaGFubmVsKCkuDQoN
Cj4gDQo+IEl0IHNlZW1zIHRvIHdvcmsgd2VsbCBhbnl3YXkuDQo+IA0KDQpJZiB5b3UgY2FuIHlp
ZWxkIHRoZSBoaWdoZXN0IHJhdGUgKE1DUzEzKSwgSSdkIHNheSBpdCBpcyBmaW5lLg0KDQpQaW5n
LUtlDQoNCg==

