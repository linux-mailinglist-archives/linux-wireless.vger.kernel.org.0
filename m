Return-Path: <linux-wireless+bounces-35104-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KdJEmfQ5mmJ1AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35104-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 03:18:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB4C4353D5
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 03:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55263300D962
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 01:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7781A6824;
	Tue, 21 Apr 2026 01:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="moGaANHs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DE61991D4
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 01:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776734308; cv=none; b=tiEthunjYi/fil3SdDzmo/+xf0ommP6c2Nz5JkeWFAOka6g/UVaOHEY724UnddxHzQQVnu54GYeVdEBbmlIaAHvZOiWnD+QlCJJULwVMOqyXlLTmTONxaLOd8BC1YB37/1F/zTKQ2oQvFF3DroXhvCCv8lkWkgXGmJDbKKrU2zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776734308; c=relaxed/simple;
	bh=uXuWeDfulvnY/MkiRgtmvRMXMbZUQenwdoX9k07Uvus=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MCXyidASeN8niJ021P8g21g2BgXOeBCpNg1HqK5bk5sLluvDgZN1wZ3Brx4s+8eScc8AqNYf7Owy93YVMqRBIqHD5/G+VHqiFam8urnvgP+SfFRU3zbOXfmDP5Mp25Lp4rr5hSy8149mL4SmRbs3Lx5gTHaJzJ4ICe9RO7WEMSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=moGaANHs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63L1IMygC2161005, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776734302; bh=uXuWeDfulvnY/MkiRgtmvRMXMbZUQenwdoX9k07Uvus=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=moGaANHs1L41FAnWJZ+MLh1C4psm1FUpihIYPiHUWuuM6Pg0pCr9LdaPpZqdHw4LC
	 nfTHygqD3dFdRZrQuPkRgOpQkeT/4mdl79CIcpUI0fkho2EJxdRiCaPJY6AFIUpw79
	 ekh5gOkqMTCkFDgBpMBMRCFoLtJvIyrbyBQ681kafrgJSH/PRDW4Z1b87wvbRaP0LM
	 WmLmbn6+GM5XrZdIP8zsmlc85d2X5NFcDwFYx4HYK9YN0BUeRP8t4WK53R66XE+5SE
	 0n1MgFodNRYGNKKwbE9KSRoo7pBTDdqSEPNyCS0BOxfKK2wm1ZHgt0wpWpWZX70m1g
	 S0jbCXO8yH25A==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63L1IMygC2161005
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 09:18:22 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 21 Apr 2026 09:18:22 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 09:18:22 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Tue, 21 Apr 2026 09:18:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 00/11] wifi: rtw89: Add support for RTL8922AU
Thread-Topic: [PATCH rtw-next v2 00/11] wifi: rtw89: Add support for RTL8922AU
Thread-Index: AQHc0AH0GCGMzHZNQkut68u1SnpP1rXnnM9QgAAidwCAAPO4IIAABgXQ
Date: Tue, 21 Apr 2026 01:18:21 +0000
Message-ID: <07888d2c1f9c41258627bdf6aede14d2@realtek.com>
References: <6ba2910d-020c-41bd-86fa-d1b0e0f7a2f5@gmail.com>
 <6c97027e16a5407da0031eb503219a25@realtek.com>
 <2ba61201-5e3c-4b95-88a1-38dd5812ebf0@gmail.com>
 <7c97c857607f41df912558194103d34c@realtek.com>
In-Reply-To: <7c97c857607f41df912558194103d34c@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-35104-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9DB4C4353D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiANCj4gQml0dGVyYmx1
ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+IE9uIDIwLzA0LzIw
MjYgMTE6MjAsIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPiA+DQo+ID4gPiBCaXR0ZXJibHVlIFNt
aXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPj4gVHdvIHBlb3BsZSBo
YXZlIHRlc3RlZCBNTE8gc2luY2UgdjEuIEl0IGRvZXNuJ3QgZXhwbG9kZSwgc28gSSBkcm9wcGVk
DQo+ID4gPj4gdGhlIHBhdGNoIHRvIGRpc2FibGUgTUxPLiAoSXQgZG9lc24ndCB3b3JrIHZlcnkg
d2VsbCB3aXRoIE1MTywgYnV0DQo+ID4gPj4gwq9cXyjjg4QpXy/CrykNCj4gPiA+DQo+ID4gPiBD
b3VsZCB5b3Ugc2hhcmUgdGhlIGxpbmsgdGhleSBkaWQ/IFdlIGNhbiBjaGVjayB0aGVtIGludGVy
bmFsbHkuDQo+ID4gPg0KPiA+ID4gUGluZy1LZQ0KPiA+ID4NCj4gPiA+DQo+ID4gPg0KPiA+DQo+
ID4gT25lIHJlcG9ydHMgdGhhdCBpdCB3b3JrcyBmaW5lOg0KPiA+DQo+ID4gaHR0cHM6Ly9naXRo
dWIuY29tL21vcnJvd25yL1VTQi1XaUZpL2lzc3Vlcy80OTQjaXNzdWVjb21tZW50LTQyNzY3Mjc5
MTkNCj4gPg0KPiA+IE9uZSByZXBvcnRzIGNvbnN0YW50IGRpc2Nvbm5lY3Rpb25zIGFuZCBzdHJh
bmdlIGVycm9ycyBsaWtlDQo+ID4gInNlYyBjYW0gZW50cnkgaXMgZW1wdHkiOg0KPiANCj4gSSB0
aGluayB0aGlzIGlzIGJlY2F1c2UgVFggcGFja2V0IHdpdGggYSBzZWN1cml0eSBrZXksIGJ1dCBp
dCB3YXMgZGVsZXRlZA0KPiBiZWNhdXNlIG9mICIoUmVhc29uOiAyPVBSRVZfQVVUSF9OT1RfVkFM
SUQpIi4NCg0KV2UgYXJlIGFkZHJlc3NpbmcgYSBNTE8gcHJvYmxlbSByZWxhdGVkIHRvIHBvd2Vy
IHNhdmUuIFBsZWFzZSB0cnkgdG8gZGlzYWJsZQ0KcG93ZXIgc2F2ZSB0byBzZWUgaWYgYW55IGlt
cHJvdmUuDQoNCj4gDQo+ID4NCj4gPiBodHRwczovL2dpdGh1Yi5jb20vbW9ycm93bnIvcnR3ODkv
aXNzdWVzLzIzI2lzc3VlY29tbWVudC00MjI2NzY5OTE0DQo+IA0KPiBJIHdpbGwgdHJ5IGlmIHdl
IGhhdmUgYW4gQXN1cyBCVDggKG9yZyBmaXJtd2FyZSkuDQo+IA0KPiBQaW5nLUtlDQoNCg==

