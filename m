Return-Path: <linux-wireless+bounces-35328-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Zh3bChTP7mkFyAAAu9opvQ
	(envelope-from <linux-wireless+bounces-35328-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 04:51:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8771C46C3C8
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 04:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAA503009F31
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 02:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6ED34A3BC;
	Mon, 27 Apr 2026 02:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="JIFQ5Ce5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6014234A3BF
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777258254; cv=none; b=LlustCMmn4jFIYGIUp7ErYhqoe2wG/uRkIcKC2+CrJMY6HEpYtSM76sisFLmNCvUmuF+K15nmrOSQ3wyA2v7AlQQgoSu7LEbl+M+2Jd9s1nya0ET1JU/8oQQfzUsqAlmL9+7WBCq+aU3XZLNjXgUaLTqDwSYb3IMoel9AYFuYIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777258254; c=relaxed/simple;
	bh=Tad2PnUfARDs4ybjr7pQ7kLPrAcGTyAvHMe0Zube5Hw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qQ99ZP8hKdB93+vhX0iah6BRc46X50z0V0H72QnrNSlVErHr1SmOOMzzeNpqmHtJPTou6TXwxMHYHLYuzTwBs+wroXNc6HTIdEPum10ROk5/biRw72FxCaJQHac+tcSJIHJ1iLMSfW5e0dNiznwlpS90ygppiBddrgUWS1g/4CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=JIFQ5Ce5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63R2oZkbD3264395, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777258235; bh=Tad2PnUfARDs4ybjr7pQ7kLPrAcGTyAvHMe0Zube5Hw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=JIFQ5Ce5j9doKnPBTReHVsqD2cF1QZmwj/QYpDpQUP+EpuLY22iGz7wEZNx9cx+18
	 0xlsrSHw9b8ZuDI63lzLvH65Fr6Oz/B8AJNKC2AqAvjZnw2B/0hqMYHWKklDe5K93L
	 gaQ99Ge9xi74/qQ1QJPiwdlHXE03zUwaxQHPe73X5zk9XiZvzsUB0e6qZsOLVcPG9E
	 m9DG7AB4RgjrpPH6JnbexQCWOGD9AsRXffdHKkSrQf5gRM1eTpeQ8wyWelRU2swpDh
	 vTmURfOZsKDXO9o5ySqyceHS9opDK0stigMIo2IFagbBXW8r8wizCyV1DZrGHyHoRq
	 wVTprl7Er/06Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63R2oZkbD3264395
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 10:50:35 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 27 Apr 2026 10:50:35 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 27 Apr 2026 10:50:35 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Mon, 27 Apr 2026 10:50:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>,
        "art1310@proton.me"
	<art1310@proton.me>
Subject: RE: [PATCH rtw-next] wifi: rtl8xxxu: Detect the maximum supported
 channel width
Thread-Topic: [PATCH rtw-next] wifi: rtl8xxxu: Detect the maximum supported
 channel width
Thread-Index: AQHc1Osi0HRuc90B2kSrIVCFaxmHA7XyNzoQ
Date: Mon, 27 Apr 2026 02:50:35 +0000
Message-ID: <df316654c31c4c6684e88dadbf07be1f@realtek.com>
References: <092f18cd-f3a6-4e3b-b0de-1cb23615e86b@gmail.com>
In-Reply-To: <092f18cd-f3a6-4e3b-b0de-1cb23615e86b@gmail.com>
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
X-Rspamd-Queue-Id: 8771C46C3C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35328-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,proton.me];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBTb21l
IGRldmljZXMgbWFsZnVuY3Rpb24gd2hlbiBjb25uZWN0ZWQgdG8gYSBuZXR3b3JrIHdpdGggNDAg
TUh6IGNoYW5uZWwNCj4gd2lkdGgsIGJlY2F1c2UgdGhleSBkb24ndCBzdXBwb3J0IHRoYXQuDQo+
IA0KPiBSVEw4MTg4RlUsIFJUTDgxOTJGVSwgYW5kIFJUTDg3MTBCVSAoUlRMODE4OEdVKSBoYXZl
IGEgd2F5IHRvIHNpZ25hbA0KPiB0aGlzIChhbmQgc29tZSBvdGhlciBjYXBhYmlsaXRpZXMpIHRv
IHRoZSBkcml2ZXIuIEdldCB0aGlzIGluZm9ybWF0aW9uDQo+IGZyb20gdGhlIGhhcmR3YXJlIGFu
ZCBhZHZlcnRpc2UgNDAgTUh6IHN1cHBvcnQgb25seSB3aGVuIHRoZSBoYXJkd2FyZQ0KPiBjYW4g
aGFuZGxlIGl0LiBXZSBhc3N1bWUgdGhlIG90aGVyIGNoaXBzIGNhbiBhbHdheXMgaGFuZGxlIGl0
Lg0KPiANCj4gUlRMODcxMEJVIG5lZWRzIGEgZGlmZmVyZW50IHdheSB0byByZXRyaWV2ZSB0aGlz
IGluZm9ybWF0aW9uLCB3aGljaCB3aWxsDQo+IGJlIGltcGxlbWVudGVkIHNvbWUgb3RoZXIgdGlt
ZS4NCj4gDQo+IEZpeGVzOiBkYmY5YjdiYjBlZGYgKCJ3aWZpOiBydGw4eHh4dTogRW5hYmxlIDQw
IE1IeiB3aWR0aCBieSBkZWZhdWx0IikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2xvc2VzOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIyMTM5
NA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWls
LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0K
DQoNCg==

