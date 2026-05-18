Return-Path: <linux-wireless+bounces-36589-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIhmEMrCCmrR7gQAu9opvQ
	(envelope-from <linux-wireless+bounces-36589-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 09:42:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC9C567F55
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 09:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A837302199F
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 07:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF33327204;
	Mon, 18 May 2026 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="suR5/esq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78443D669A
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089711; cv=none; b=kPqZPWwq01er6ChKU/ZbvOx3iMBLO22+DfkVQXB04aGe25+EclPxXt4EzVkSn+zYXhDL+/B6UgSEA4ra2DZyDI6gNEDaI4bbjxowWwFtxx2rulNGmDgWyHGY3fUoUKUjFfaWEzLGqqSc3AKsrsfMlWBz9lSNa7hsy9/WvI3whfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089711; c=relaxed/simple;
	bh=9DuTTl/tsdFTrY/mpXtNaz7PTRYOCUSlRGEw8vcI+l0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n00Wk3J7oOsXKIq1xBLM4ou2VuMTuhmGtNoNQcqLd8cI4XFgC6BDhm2WkbOnuLsBDqINWK84bsCq1DoG/tSSkFNiE+fRiuOlXRfMVPqOtvT2+2i4Rxe13LY4S8K2Zc82NBoFSyqgC/DzgwgWlNA17yNPPxQLCDVFyvJcTiFJeTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=suR5/esq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64I7Z6P601603120, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779089706; bh=9DuTTl/tsdFTrY/mpXtNaz7PTRYOCUSlRGEw8vcI+l0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=suR5/esqMsAftq7VX3stozD6JE/pSolaKW8/D3LnkGcgWOjyImQbbcCQv14q4QeWm
	 T5JtO6KQWsgI4QLEXe9dAFhMhF8mSW3BBYmSk2ytTWW04cEQKIWIqtpvKlS5ekZSlk
	 rHD7jpBYM48rqakzHksoNlFykbdG3fpN81i/2MJQCK4j838uO1XRDmJjlyC62Eo/J9
	 ECYYf/mtbrMRDl2hXPg9sAgCkr9TgWf/vpYWrOI51Mp795r728iJS3ljGol0lif1cB
	 c2T/k3wmnMXhf1tCBcyDpkzMTpy69RcR0CQyVJeRqlo5zBfpJA2VSJA07GqNb2DGMZ
	 jHgs6B1Ygj5ag==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64I7Z6P601603120
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 15:35:06 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 May 2026 15:35:06 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Mon, 18 May 2026 15:35:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw89: Add missing TX queue mappings for
 RTL8922AU
Thread-Topic: [PATCH rtw-next] wifi: rtw89: Add missing TX queue mappings for
 RTL8922AU
Thread-Index: AQHc5TAJaH9ymMIbbEC4ru4sEc7iILYTZzbg
Date: Mon, 18 May 2026 07:35:06 +0000
Message-ID: <f537bfcbd1364f30927ae5bddeb7c095@realtek.com>
References: <0c8e0cf1-13e9-4c67-a67f-5f6f79fd0658@gmail.com>
In-Reply-To: <0c8e0cf1-13e9-4c67-a67f-5f6f79fd0658@gmail.com>
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
X-Rspamd-Queue-Id: AEC9C567F55
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36589-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail,realtek.com:server fail];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBBIHVz
ZXIgd2l0aCBNTE8tY2FwYWJsZSByb3V0ZXIgcmVwb3J0czoNCj4gDQo+IFsgNzUzLjA4MDQwOV0g
cnR3ODlfODkyMmF1X2dpdCAyLTI6MS4wOiBDYW5ub3QgbWFwIHFzZWwgdG8gZG1hIHYyOiAyNg0K
PiBbIDc1My4wODA0MTddIHJ0dzg5Xzg5MjJhdV9naXQgMi0yOjEuMDogQ2Fubm90IG1hcCBxc2Vs
IHRvIGRtYSB2MjogMjYNCj4gWyA4MTMuNjQ5NDI2XSBydHc4OV84OTIyYXVfZ2l0IDItMjoxLjA6
IENhbm5vdCBtYXAgcXNlbCB0byBkbWEgdjI6IDI2DQo+IFsgODEzLjY0OTQ0NV0gcnR3ODlfODky
MmF1X2dpdCAyLTI6MS4wOiBDYW5ub3QgbWFwIHFzZWwgdG8gZG1hIHYyOiAyNg0KPiBbIDgxMy44
NTU5ODNdIHJ0dzg5Xzg5MjJhdV9naXQgMi0yOjEuMDogQ2Fubm90IG1hcCBxc2VsIHRvIGRtYSB2
MjogMjYNCj4gDQo+IE1hcCBSVFc4OV9UWF9RU0VMX0IxX01HTVQgYW5kIFJUVzg5X1RYX1FTRUxf
QjFfSEkgdG8gUlRXODlfVFhDSF9DSDEwLg0KPiBUaGlzIGlzIHByb2JhYmx5IHRoZSByaWdodCBj
aGFubmVsIGZvciB0aGVzZSBxdWV1ZXMuDQo+IA0KPiBUaGlzIGZ1bmN0aW9uIGlzIGFsc28gdXNl
ZCBmb3IgUlRMODg1MkFVIGFuZCBSVEw4ODUyQ1UsIGJ1dCB0aG9zZQ0KPiBjdXJyZW50bHkgYXJl
bid0IHVzZWQgaW4gREJDQyBtb2RlIHdpdGggcnR3ODkgc28gaXQgbWFrZXMgbm8gZGlmZmVyZW5j
ZQ0KPiBmb3IgdGhlbS4NCj4gDQo+IExpbms6IGh0dHBzOi8vZ2l0aHViLmNvbS9tb3Jyb3duci9y
dHc4OS9pc3N1ZXMvODMjaXNzdWVjb21tZW50LTQzMTQ3MzU3MzQNCj4gU2lnbmVkLW9mZi1ieTog
Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQ
aW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

