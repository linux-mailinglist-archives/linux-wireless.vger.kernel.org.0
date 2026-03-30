Return-Path: <linux-wireless+bounces-34143-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UN0BDRPryWml3QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34143-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 05:16:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DBC354FEC
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 05:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75F3B3006513
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 03:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4D11C84A0;
	Mon, 30 Mar 2026 03:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="RLVivXER"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BE91C5F11
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 03:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774840591; cv=none; b=bN6IMHSCTSQOtYMkDqvoID9xURUeVVUUCKn+OTP7yqVNAudh2nXzchIljma+F1z7KpbxRBCPCJQ9G5dbcwaCGkcXBGE/z3hfKH8foPkS5pZF7BKsHv2tu/URSwA11CJ8aQBUhcXgkOWvfRA0LNQetB+kUoeKgBLJa5KVGTTD81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774840591; c=relaxed/simple;
	bh=3UJKSyOTijXXp8aPMSrshRhGxHAwTvzLBZr6frsZ8r4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S0+F6KgsswbVi0PVu5z96YjLRVl8aT7odcla0bDEnk24FSgy9uDBGaMPxy4W2g5QVeu7wC4P/oIaUwlezdWGFH1bSvRXrrvMkkjV1hez7a/XttYoc41hrLVE06XbZz55LluE78BGZweAHoUX35EqELTWe74U37GaMbKMW9vVH7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=RLVivXER; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U3GPfmC221535, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774840585; bh=3UJKSyOTijXXp8aPMSrshRhGxHAwTvzLBZr6frsZ8r4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=RLVivXERanVD80RFQ25zf9ivFSJKiHlN6XGKwbW1YTl4bjKxThEsqwZ3/pNmunhxl
	 EqUJEcAA8t25wW+nMJxVYV6I8efM+WsqlubLkbG6iI/AGl3IpOvPvwN6vV24tc5y9U
	 AnZ+y5XvYwfHjTF4rFr1absgqAJn32xLRA74vYsyfnj82In5nEcn58IC/NaV7EdQ5e
	 5V151Bw9v7DVGTwZCcZ0bG4ABAW7pXxzXvwy6CmjLqvH/D5eRxsEcKWY6DI2PgBnF7
	 TXUQP2p826bmKHktKbrb+p/Ja/p4wMtkNpV48AF6XBagPSRbMOqqMdmy9f6tnLuhpU
	 8QYfG2N6oNAQw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U3GPfmC221535
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 11:16:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 11:16:24 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::46e9:fab9:b2cf:c99b%10]) with mapi id
 15.02.1748.010; Mon, 30 Mar 2026 11:16:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 02/12] wifi: rtw89: usb: Support 2 bulk in
 endpoints
Thread-Topic: [PATCH rtw-next 02/12] wifi: rtw89: usb: Support 2 bulk in
 endpoints
Thread-Index: AQHcvUKWyUKLS66j0EyHsDXkxrm6ALXGa/gQ
Date: Mon, 30 Mar 2026 03:16:24 +0000
Message-ID: <8b92b2a31bba499986dda0d50fa3cb5d@realtek.com>
References: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
 <7cb8e2b1-0f87-4ef9-9dc0-f4ceda5cdd8e@gmail.com>
In-Reply-To: <7cb8e2b1-0f87-4ef9-9dc0-f4ceda5cdd8e@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34143-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,realtek.com:mid]
X-Rspamd-Queue-Id: A2DBC354FEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBSVEw4
OTEyQVUgaGFzIDIgYnVsayBpbiBlbmRwb2ludHMsIG5vdCAxLCBzbyByYWlzZSB0aGUgbGltaXQu
DQo+IA0KPiBJdCdzIG5vdCB5ZXQgY2xlYXIgd2hhdCB0aGUgc2Vjb25kIGJ1bGsgaW4gZW5kcG9p
bnQgaXMgZm9yLg0KDQpUaGUgc2Vjb25kIGJ1bGstaW4gaXMgZm9yIFVTQiBpbnRlcnJ1cHQgbW9k
ZSBmb3IgU0VSIChzeXN0ZW0gZXJyb3IgcmVjb3ZlcnkpDQpmbG93LCB3aGljaCB5b3UgY2FuIHJl
ZmVyZW5jZSBzZXIuYyB0byB1bmRlcnN0YW5kIGhvdyBpdCB3b3JrcyBmb3IgUENJIFdpRmkNCmRl
dmljZXMuIEZvciBub3csIHlvdSBjYW4gdG90YWxseSBpZ25vcmUgdGhpcy4NCg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoN
CkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

