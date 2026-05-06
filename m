Return-Path: <linux-wireless+bounces-36001-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJq0INwG+2mbVQMAu9opvQ
	(envelope-from <linux-wireless+bounces-36001-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 11:16:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD664D872E
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 11:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD615302A06D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 09:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219663DA5B1;
	Wed,  6 May 2026 09:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="GWj8n904"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D4D15B998;
	Wed,  6 May 2026 09:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778058750; cv=none; b=FB8X5u+aOxWRH8pUpNN5LGfnH5Wfika7/ArPd2MCGY25Yx6RX/J4PjuulLdAaKdXwqgSLG/hS02npeP0ZcGxpLFhW9EILzfdcH/abHhtO+Qwe4EBR1WgDly+5tNND+VgjB0LhlIJoKEaz3lU4bG2p2mlWr/pZv20++AYwhNvu48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778058750; c=relaxed/simple;
	bh=jpEPxD187a3NDJSK11dxofGkbqZ6fPtTTOfQLch2VOU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ajWy2+xsGgOmQGGg65Vql/UDqXLdizYlZDGtA5D9TZW7SAVW+J19bnNBK8z97H4sX5+3hhCuvTJCbX1nGekNzHZtUkf1w2GCz5MvnzHC2m7tWj7NBYkQ1jyY7rMQLnl3E5Qy9ETlfoB5ib07LW69zqJnAKwUzBoV0kqLLelmi6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GWj8n904; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6469COI701894902, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778058744; bh=jpEPxD187a3NDJSK11dxofGkbqZ6fPtTTOfQLch2VOU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GWj8n904c2hr9bR8qqpEhMY4sWzQR+7sDHAwpgfzslB66DwXG0OHNaEL/8b9eWXJf
	 1CkJ5dDmBvYGgdLYYFLQ9C9FnMApAQ1wfPYiBCXuOtavMeETEJP4d2MtNJRdxUZp0Q
	 Dp9OUM0k5mQziSOdoNrDsgBvsVWTJQ2QOyoYDE4tb29v5t3J7dvpZhFBJtF2yzZ93L
	 xyuMgmfZ4cTZiBQfdHRy6+mBvgM5ANcP4GtlF6tyajVkLwdAgLjr+2I82JgDXOB394
	 8um0yqalpO+jieryEDpg2vnl94dJbnWOSTlMp2f6KCHUVBrh/bRq08ciRR8dDdHpNt
	 lYdRuob6FkL+A==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 6469COI701894902
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 17:12:24 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 May 2026 17:12:24 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Wed, 6 May 2026 17:12:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Louis Kotze <loukot@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/4] wifi: rtw89: advertise WFA-certified EHT capabilities
 for 8922a
Thread-Topic: [PATCH 0/4] wifi: rtw89: advertise WFA-certified EHT
 capabilities for 8922a
Thread-Index: AQHc24E+LCWBeDxCEkyQ4AMls4NF7bYAs9gg
Date: Wed, 6 May 2026 09:12:24 +0000
Message-ID: <7e092f6cf82c4bb18b59ba5eca40dbb5@realtek.com>
References: <cover.1777832019.git.loukot@gmail.com>
In-Reply-To: <cover.1777832019.git.loukot@gmail.com>
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
X-Rspamd-Queue-Id: DFD664D872E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-36001-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wi-fi.org:url]

DQpMb3VpcyBLb3R6ZSA8bG91a290QGdtYWlsLmNvbT4gd3JvdGU6DQo+IFRoaXMgc2VyaWVzIGFk
dmFuY2VzIHJ0dzg5IEVIVCBjYXBhYmlsaXR5IGFkdmVydGlzZW1lbnQgdG8gbWF0Y2ggd2hhdA0K
PiBSZWFsdGVrJ3Mgb3duIFJUTDg5MjJBRSBzaWxpY29uIGlzIGNlcnRpZmllZCBmb3IgYnkgdGhl
IFdpLUZpIEFsbGlhbmNlDQo+IGluIFdGQSBDZXJ0IFdGQTEyOTMxMyAoUlRMODkyMkFFIDgwMi4x
MWJlIGFuZCBCbHVldG9vdGggY29tYm8gbW9kdWxlLA0KPiAyMDI0LTA1LTIzLCBGVyA2MTAyLjI0
LjEwOS4wLA0KPiBodHRwczovL2FwaS5jZXJ0LndpLWZpLm9yZy9hcGkvY2VydGlmaWNhdGUvZG93
bmxvYWQvcHVibGljP3ZhcmlhbnRJZD0xMjk3MDYpLg0KDQpXaS1GaSBDb21wb25lbnQgT3BlcmF0
aW5nIFN5c3RlbTogV2luZG93cw0KDQpUaGF0IG1lYW5zIGhhcmR3YXJlIGlzIGNhcGFibGUsIGJ1
dCBMaW51eCBkcml2ZXIgbWlnaHQgbmVlZCBtb3JlDQppbXBsZW1lbnRhdGlvbiwgbm90IGp1c3Qg
ZGVjbGFyYXRpb24uIEkgd2lsbCBhc2sgaW50ZXJuYWwgdG8gY2hlY2sgdGhlbS4NCg0KQnV0IEkg
dGhpbmsgaXQgaXMgbm90IG5lY2Vzc2FyeSB0byBhZGQgdGhpcyBsaW5rIGFzIHJlZmVyZW5jZS4N
Cg0KWy4uLl0NCg0KPiANCj4gVGVzdGVkIG9ubHkgb24gUlRMODkyMkFVIChVU0IgdmFyaWFudCk7
IHJ0dzg5X2luaXRfZWh0X2NhcCgpIGFuZCB0aGUNCj4gaWZ0eXBlLWV4dC1jYXAgc3RydWN0IGFy
ZSBzaGFyZWQgYWNyb3NzIHRoZSBydHc4OSBjaGlwIGZhbWlseS4gTm9uLUFVDQo+IHZhcmlhbnQg
dGVzdGluZyBmcm9tIGFueW9uZSB3aXRoIHJ0dzg5LXN1cHBvcnRlZCBoYXJkd2FyZSBpcyB3ZWxj
b21lLg0KDQpJJ2QgbGlrZSB0byBrbm93IGlmIHRoZXNlIHBhdGNoZXMgaGF2ZSBleHBsaWNpdCBp
bXByb3ZlbWVudCB0byB5b3U/DQpPciB5b3Ugb25seSB0ZXN0IHRoZXNlIHdpdGhvdXQgcmVncmVz
c2lvbj8NCg0KQXMgSSBrbm93LCBhdCBsZWFzdCBUVExNIG5lZWRzIHRvIGFwcGx5IGNvbmZpZ3Vy
YXRpb24gdG8gaGFyZHdhcmUgYW5kDQpmaXJtd2FyZS4gV2l0aG91dCBuZWNlc3NhcnkgY2hhbmdl
cywgaXQgc2hvdWxkIG5vdCB3b3JrIHByb3Blcmx5Lg0KDQpQaW5nLUtlDQoNCg==

