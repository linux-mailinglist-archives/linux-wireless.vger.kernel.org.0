Return-Path: <linux-wireless+bounces-33913-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CARqLxeZxGll1QQAu9opvQ
	(envelope-from <linux-wireless+bounces-33913-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 03:25:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C6C32E591
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 03:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A50613037984
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 02:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC222550AF;
	Thu, 26 Mar 2026 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="e+TQHRp3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D872116F6
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 02:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774491625; cv=none; b=Ec4v4b/8V/kXB3Sx7iypvbLtQFpU0QS27NEcd0oOaJvpMHOI3aNNpCZPTrj3kLyZtwyueRmZS8CEeDKB/ftzOvjucNo7rULCs5y6Rl94f1PlOlRlxslfOVjDU1e8b/U6wOxSgv964jxrOMm7+d+okJZ7SwgeWziyeYF/6M90OmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774491625; c=relaxed/simple;
	bh=rnhPnnCKaEmZbT6bt09oZeM9R0yVVw/5V/BPpjvS530=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DmISWC8iHacXNh0i1I32Kox+WBIcxtnKGbSEkb2yVW5M5qlCoakLO0967dsFfc4+/cOVui1EScTsiXQDsRsAb7zMmWHkgFujQ0kylnQeD3tcvQKT/UVhcwbZmDOhNWDj32O8WDoVac9VBa8Z1zni/RzvDeM5u+5qFFiopgIkx/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=e+TQHRp3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62Q2KK5l8586707, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774491620; bh=rnhPnnCKaEmZbT6bt09oZeM9R0yVVw/5V/BPpjvS530=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=e+TQHRp3XxiouVtZVXIkVXQ9wafKKh3VmhRoQQk/RiOCFoQsPlwTNFdvJE97Ml8iM
	 W0SigRI/aRmBb1t+2TIZoiIU1JUjYbhzmLi/H0CkF1BacsFg6cQfpaCKxsjkRgWa7j
	 64EZxO6GCZ2hODMXKeQTECBYW9ic0zh+CGDFWdRxGzQub4+ymQEc17pcjuhYObnzV7
	 W9LnUgfKiwBwWotsOdAzePBsPXEd/QDHsb2pLiE2T/1btxACwJBu1qSQX5Jpb0DBob
	 E98+qwYuQJovPL6FEp/NEIFyHKsMSV5XrS4dSMkbZiIFsUd6XMCWY7VGcuHFQvl9SK
	 NHpAO69YgMbaA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62Q2KK5l8586707
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 10:20:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 26 Mar 2026 10:20:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::46e9:fab9:b2cf:c99b%10]) with mapi id
 15.02.1748.010; Thu, 26 Mar 2026 10:20:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw88: coex: Ignore BT info byte 5 from
 RTL8821A
Thread-Topic: [PATCH rtw-next] wifi: rtw88: coex: Ignore BT info byte 5 from
 RTL8821A
Thread-Index: AQHcvKaMc8TzK4wBJEKTuKV2yC8AorXAFHzA
Date: Thu, 26 Mar 2026 02:20:20 +0000
Message-ID: <54376df8f7e3456bb53768fecbcb0638@realtek.com>
References: <bbf06c83-d2ee-4205-8fbb-829e2347586f@gmail.com>
In-Reply-To: <bbf06c83-d2ee-4205-8fbb-829e2347586f@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33913-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,realtek.com:mid]
X-Rspamd-Queue-Id: 41C6C32E591
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBTb21l
dGltZXMgd2hpbGUgd2F0Y2hpbmcgYSBZb3V0dWJlIHZpZGVvIHdpdGggQmx1ZXRvb3RoIGhlYWRw
aG9uZXMgdGhlDQo+IGF1ZGlvIGhhcyBhIGxvdCBvZiBpbnRlcnJ1cHRpb25zLCBiZWNhdXNlIHRo
ZSA1dGggYnl0ZSBvZiB0aGUgQlQgaW5mbw0KPiBzZW50IGJ5IFJUTDg4MjFBVSBoYXMgc3RyYW5n
ZSB2YWx1ZXMsIHdoaWNoIHJlc3VsdCBpbg0KPiBjb2V4X3N0YXQtPmJ0X2hpZF9wYWlyX251bSBi
ZWluZyAyIG9yIDMuIFdoZW4gdGhpcyBoYXBwZW5zDQo+IHJ0d19jb2V4X2ZyZWVydW5fY2hlY2so
KSByZXR1cm5zIHRydWUsIHdoaWNoIGNhdXNlcw0KPiBydHdfY29leF9hY3Rpb25fd2xfY29ubmVj
dGVkKCkgdG8gY2FsbCBydHdfY29leF9hY3Rpb25fZnJlZXJ1bigpIGluc3RlYWQNCj4gb2YgcnR3
X2NvZXhfYWN0aW9uX2J0X2EyZHAoKS4NCj4gDQo+IFRoZSBSVEw4ODIxQVUgdmVuZG9yIGRyaXZl
ciBkb2Vzbid0IGRvIGFueXRoaW5nIHdpdGggdGhlIDV0aCBieXRlIG9mIHRoZQ0KPiBCVCBpbmZv
LCBzbyBpZ25vcmUgaXQgaGVyZSBhcyB3ZWxsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVy
Ymx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtl
IFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0K

