Return-Path: <linux-wireless+bounces-34403-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLpYEx5T1GnhtAcAu9opvQ
	(envelope-from <linux-wireless+bounces-34403-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 02:43:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A152D3A87C3
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 02:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69503300CC2C
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 00:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2879198A17;
	Tue,  7 Apr 2026 00:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Etbdxz8p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB9A192D97
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 00:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775522300; cv=none; b=jD7jlxvMIdyACLeZEjdgKocpT6JPujZJLNnG45DBnQUh27b0cz+UpwPve7IVVA1FKwWuHFkYUKDvddN2ost3RI7cmwDRB0pU9PvcMVJuP0Y7VArG7MamLshjFEmKyrprboo57HHpfV5Lr97XFXItm6wWG8qxj5CVb/Tm6p4BGrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775522300; c=relaxed/simple;
	bh=2NxjYrT/J+SLPEKmccB8ZuHilwn2Vn2MwxbLAiAnyUY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M3mkeGl3fccVqr0LmqHvLZmQZrNv1l/2FckipSrleTkj4nyxuy2PtRKe18eq5G45ko98SGuE6KH8Ta3OtFTN2aCs3SwIGHuaQyHz8pHD+rTpL+O43TD7y9gb2LcXRiiBgwpuxQysGBxaNy/KFTyayclSG9Balj/5rl+XhFKNAxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Etbdxz8p; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6370cCaC54178537, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775522293; bh=2NxjYrT/J+SLPEKmccB8ZuHilwn2Vn2MwxbLAiAnyUY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Etbdxz8pQ8RKaMQwNO2BWRZ+h7sWnGX2CdGUTjNK+9f1P6m1uHTuRHhgDDktlbZAl
	 GnNEyjiNavqZg1eUCFszXgG6P+vCxT7Ti5UYCYdZlZKqfRDkuWAxB0TSB7YcOVUWOF
	 PReZwWfR0MoE8Ya88G4QRAxnQcYgSmA0N/NxCNVmeEQQ8AjpCd3wRkNzoImIB3g2Pz
	 OMDE8YAJ2fTlkZfyX8Pg4JDHJyEp2kdX4F9L5ZwFhlTub+e5gI3Nd8dLH7yCa9DmyJ
	 SRLJiSFgjJhB0B5cMV6yH6zD5nKtRxG8ccy8kGTKwWuyc0XOgf+ux+ezU2AyFubNEq
	 Ocb//kNNi6VTg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 6370cCaC54178537
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 08:38:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 7 Apr 2026 08:38:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Tue, 7 Apr 2026 08:38:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?SmVmZnJleSBXw6RsdGk=?= <jeffrey@waelti.dev>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: wifi: rtw89: rtw8922ae: HWSI bus lockup during RF recalibration
 on AP bandwidth change
Thread-Topic: wifi: rtw89: rtw8922ae: HWSI bus lockup during RF recalibration
 on AP bandwidth change
Thread-Index: AQHcurr3ssaqHgvFgEq3QbzjT47FFLW87FxAgAIyVoCAANiPoIAJoX6AgAGDxQCAAHtUAIABGfAAgAYk1YA=
Date: Tue, 7 Apr 2026 00:38:13 +0000
Message-ID: <b53454830dfc4e2e9d43aa8689fd8f99@realtek.com>
References: <SnJ_b28_Uro9Xtlb2ew62uypaut_7wD44Qnmibm2Yj4FgSS7cayhZvqkK8-AXGNAc-xdwYST6E2GDCMcoZh33PjukvAsXwaqMzx8Z14_aA0=@waelti.dev>
 <8bf447cc627746cca6eb30ae283bbbe6@realtek.com>
 <uyjP590fzro7xuECRhUp6nlegi4hnWSBbrrFd-tcCcKeeKbDaoUThi7EkMNUMC2LYibyA0jaAqR7GrIchbJcGVh5CSgiGa39jMQkLq5F9QY=@waelti.dev>
 <f387614466ce497fb59d4ad98ef641f5@realtek.com>
 <JSFJ7Do8YsCSMLsXH6KLXADJ0-z0Dh-y99PpaSCHiCwp6aikxldPnTr9mXpEAifNezf2gFyPPiHIaobekBeqiM4XVpO8hYKyXvuei4lKVc0=@waelti.dev>
 <4b0f77fcdaf74da5a1c5e77b83f972df@realtek.com>
 <nPBjkph3lQo2eiuYIDyn7Mx8rg_pYRHNkQ-yyIVecS7isXyz4KC77Kud29sqnGKgCVgZS_IM1Jj28gx1RN4iaLuyKhS_MZVUnXhy-BVGCfQ=@waelti.dev>
 <dFJeMTbWtJdpQXoZpQRv85Z8BumU9LW5xY5D4Hnuri6Zez_Gkk8XL6zNEuCFN1djAEqsTA9-mJb1ygNXX-V72HL4Q3Vit_1JY1-xBHBm5SQ=@waelti.dev>
In-Reply-To: <dFJeMTbWtJdpQXoZpQRv85Z8BumU9LW5xY5D4Hnuri6Zez_Gkk8XL6zNEuCFN1djAEqsTA9-mJb1ygNXX-V72HL4Q3Vit_1JY1-xBHBm5SQ=@waelti.dev>
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
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34403-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,realtek.com:mid]
X-Rspamd-Queue-Id: A152D3A87C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SmVmZnJleSBXw6RsdGkgPGplZmZyZXlAd2FlbHRpLmRldj4gd3JvdGU6DQo+IA0KPiBKZWZmcmV5
IFfDpGx0aSA8amVmZnJleUB3YWVsdGkuZGV2PiB3cm90ZToNCj4gDQo+ID4gUGluZy1LZSBTaGlo
IDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiBKZWZmcmV5IFfDpGx0aSA8
amVmZnJleUB3YWVsdGkuZGV2PiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gUGluZy1LZSBTaGlo
IDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiA+IEplZmZyZXkg
V8OkbHRpIDxqZWZmcmV5QHdhZWx0aS5kZXY+IHdyb3RlOg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+IDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4gUGxlYXNlIHRyeSB0byBkaXNhYmxlIHBvd2VyIHNhdmUgYW5kIEFT
UE0gYnkNCj4gPiA+ID4gPiA+ID4gMSkgaXcgd2xhbjAgc2V0IHBvd2VyX3NhdmUgb2ZmDQo+ID4g
PiA+DQo+ID4gPiA+IEknbSBzb3JyeSwgdGhpcyBpcyBteSBmaXJzdCB0aW1lIGludGVyYWN0aW5n
IHdpdGggdGhlIG1haWxpbmcgbGlzdCBhbmQgSSBvdmVybG9va2VkIHRoZSBvdGhlcg0KPiBpbnN0
cnVjdGlvbnMuDQo+ID4gPiA+IEl0IHNlZW1zIGxpa2UgZGlzYWJsaW5nIHBvd2VyIHNhdmUgZ2V0
cyByaWQgb2YgdGhlIGlzc3VlIG9mIFdpLUZpIHRpbWVvdXRzLiBJIGhhdmVuJ3QgYmVlbiBhYmxl
DQo+IHRvDQo+ID4gPiA+IHJlcHJvZHVjZSB0aGUgaXNzdWUgd2l0aCBgaXcgd2xhbjAgc2V0IHBv
d2VyX3NhdmUgb2ZmYCB5ZXQsIGV2ZW4gd2l0aG91dCBhbnkgb2YgdGhlIG90aGVyIGZpeGVzDQo+
IG9uIGtlcm5lbA0KPiA+ID4gPiA2LjE5LjEwIGFuZCA3LjAtcmM2Lg0KPiA+ID4gPg0KPiA+ID4g
PiA+ID4gPiAyKSByZWZlcmVuY2UgYW5kIGluc3RhbGwNCj4gPiA+ID4gPiA+IGh0dHBzOi8vZ2l0
aHViLmNvbS9sd2Zpbmdlci9ydHc4OS9ibG9iL21haW4vNzAtcnR3ODkuY29uZg0KPiA+ID4gPiA+
ID4gPiAgICBhbmQgdGhlbiBjb2xkIHJlYm9vdC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEhhdmUg
eW91IHRlc3RlZCB3aXRoIHRoZXNlIGNvbmRpdGlvbnM/DQo+ID4gPiA+DQo+ID4gPiA+IFVzaW5n
IHRoaXMgcGF0Y2ggZWxpbWluYXRlcyB0aGUgaXNzdWUgb2YgQmx1ZXRvb3RoIGRldmljZXMgZGlz
Y29ubmVjdGluZywgd2hlbiBzd2l0Y2hpbmcgYmV0d2Vlbg0KPiA+ID4gPiBuZXR3b3Jrcy4NCj4g
PiA+ID4NCj4gPiA+ID4gPiBbLi4uXQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiA+IFBsZWFzZSBoZWxwIHRvIHRlc3QgdGhlIGxhdGVzdCBrZXJuZWwgNy4wLXJjIHdpdGgg
YWRkaXRpb25hbCBwYXRjaCBbMV0uDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IFsxXQ0K
PiA+ID4gPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtd2lyZWxlc3MvMjAyNjAz
MTAwODAxNDYuMzExMTMtNC1wa3NoaWhAcmVhbHRlaw0KPiA+ID4gPiA+ID4gLmNvbS8NCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IEhhdmUgeW91IGFsc28gYXBwbGllZCB0aGlzIHBhdGNoPw0KPiA+ID4g
Pg0KPiA+ID4gPiBJIHRlc3RlZCBrZXJuZWwgNy4wLXJjNiB3aXRoIHRoaXMgcGF0Y2ggYXBwbGll
ZCBvbiB0b3AgZm9yIH4xIGRheSBub3cgYW5kIGhhdmVuJ3QgYmVlbiBhYmxlIHRvDQo+IHJlcHJv
ZHVjZSwNCj4gPiA+ID4gZXZlbiB3aXRoIHBvd2VyIHNhdmUgZW5hYmxlZC4gSG93ZXZlciwgaXQg
aXMgYSBiaXQgZGlmZmljdWx0IHRvIHJlbGlhYmx5IHRyaWdnZXIgdGhlIGlzc3VlIGFzDQo+IGl0
IHNlZW1zDQo+ID4gPiA+IHRvIHRyaWdnZXIgbW9yZSBvbiBjZXJ0YWluIG5ldHdvcmtzIHRoYW4g
b3RoZXJzIGV0Yy4NCj4gPiA+ID4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gUGluZy1L
ZQ0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
IFRoYW5rIHlvdSBmb3IgY29taW5nIGJhY2sgdG8gbWUgc28gcXVpY2tseSwgSSBqdXN0IGVuY291
bnRlcmVkIHRoZSBzYW1lIHRoaW5nDQo+ID4gPiA+ID4gPiB3aXRoIGtlcm5lbCA3LjAtcmM1Lg0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFBsZWFzZSBjb25maXJtIG15IHF1ZXN0
aW9ucyBhYm92ZS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFBpbmctS2UNCj4gPiA+ID4gPg0KPiA+
ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IEluIHN1bW1hcnk6DQo+ID4gPiA+IC0gRGlzYWJsaW5n
IHBvd2VyIHNhdmUgc2VlbXMgdG8gc3RvcCB0aGUgdGltZW91dHMgYnV0IEJsdWV0b290aCBpc3N1
ZXMgcmVtYWluDQo+ID4gPiA+IC0gRGlzYWJsaW5nIEFTUE0gZmVhdHVyZXMgZml4ZXMgdGhlIEJs
dWV0b290aCBpc3N1ZQ0KPiA+ID4gPiAtIGtlcm5lbCA3LjAtcmM2IHdpdGggdGhlIGFkZGl0aW9u
YWwgcGF0Y2ggZml4ZXMgV2ktRmkgdGltZW91dHMgYnV0IG5vdCB0aGUgQmx1ZXRvb3RoIGRpc2Nv
bm5lY3RzDQo+ID4gPiA+DQo+ID4gPiA+IEkgaG9wZSB0aGF0IGFuc3dlcnMgeW91ciBxdWVzdGlv
bnMuDQo+ID4gPg0KPiA+ID4gSXQgbG9va3MgbGlrZSBhZGRpdGlvbmFsIHBhdGNoIGNhbiBmaXgg
dGhlIFdpRmkgdGltZW91dHMgcHJvYmxlbSwgYW5kDQo+ID4gPiBkaXNhYmxpbmcgQVNQTSBmZWF0
dXJlIGNhbiBmaXggQmx1ZXRvb3RoIGlzc3VlLiBJIHRoaW5rIHlvdSBjYW4ga2VlcA0KPiA+ID4g
KDIpICsgKDMpIHNldHRpbmcgYXMgd29ya2Fyb3VuZC4NCj4gPiA+DQo+ID4gPiBJJ2QgdGFsayB3
aXRoIEJUIGNvZXhpc3RlbmNlIHRlYW0gaW50ZXJuYWxseSB0byBmaWd1cmUgb3V0IHRoZSBjYXVz
ZQ0KPiA+ID4gb2YgQmx1ZXRvb3RoIGRpc2Nvbm5lY3Rpb24uDQo+ID4NCj4gPiBBcyBhbHdheXMs
IHRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIGNvbWluZyBiYWNrIHRvIG1lIHNvIHF1aWNrbHkgYW5k
IHdvcmtpbmcgb24gYSBmaXguIFBsZWFzZSBkbyBsZXQNCj4gbWUga25vdyBpZiB0aGVyZSBpcyBh
bnkgcHJvZ3Jlc3Mgb24gdGhlIGlzc3VlIG9yIGlmIHlvdSBuZWVkIGFueSBtb3JlIGhlbHAgdGVz
dGluZyBhIHBhdGNoLg0KPiANCj4gSGkgYWdhaW4sDQo+IA0KPiBJJ20gc29ycnkgZm9yIGNvbWlu
ZyBiYWNrIHRvIHlvdSBzbyBxdWlja2x5IG9uY2UgYWdhaW4sIGJ1dCBJIGFtIHNhZCB0byByZXBv
cnQsIHRoYXQgSSBqdXN0IGVuY291bnRlcmVkDQo+IHRoZSBzYW1lIGlzc3VlIGFnYWluIHdpdGgg
a2VybmVsIDcuMC1yYzYgYW5kIHRoZSBjdXN0b20gcGF0Y2ggYXBwbGllZC4gDQoNCldoYXQgZGlk
IGN1c3RvbSBwYXRjaCB5b3UgbWVudGlvbmVkPyBUaGUgYWRkaXRpb25hbCBwYXRjaCBJIG1lbnRp
b25lZD8NCg0KPiBBZnRlciByZXN1bWUgdGhlIFdpLUZpIGNvbm5lY3Rpb24NCj4gcmFuIGF0IGxl
c3MgdGhhbiAxLzEwMCBvZiB0aGUgZXhwZWN0ZWQgc3BlZWQgYW5kIHdvdWxkbid0IGNvbWUgYmFj
ayB1cCwgdW50aWwgSSByZWNvbm5lY3RlZCB0byB0aGUgc2FtZQ0KPiBuZXR3b3JrLiBJdCBzZWVt
cyBsaWtlIGp1c3QgdGhlIGN1c3RvbSBwYXRjaCB3YXMgbm90IGVub3VnaCB0byBmaXggdGhlIHVu
ZGVybHlpbmcgaXNzdWUsIGJ1dCBpdCBkaWQNCj4gZml4IHRoZSBIV1NJIGxvY2sgdXAuIFRoaXMg
aXMgd2hhdCBkbWVzZyB0ZWxscyBtZS4NCj4gDQo+IFsxMjY0NjIuMDM1NDMwXSBQTTogc3VzcGVu
ZCBleGl0DQo+IFsxMjY0NjUuNjE1OTM1XSB3bGFuMDogYXV0aGVudGljYXRlIHdpdGggNjg6Njc6
Yzc6MmE6MjA6NDMgKGxvY2FsIGFkZHJlc3M9N2M6ZmE6ODA6YzM6NWI6ZjkpDQo+IFsxMjY0NjUu
NjE1OTQ0XSB3bGFuMDogc2VuZCBhdXRoIHRvIDY4OjY3OmM3OjJhOjIwOjQzICh0cnkgMS8zKQ0K
PiBbMTI2NDY1LjYzNDgxOF0gd2xhbjA6IHNlbmQgYXV0aCB0byA2ODo2NzpjNzoyYToyMDo0MyAo
dHJ5IDIvMykNCj4gWzEyNjQ2NS42NTQwNzJdIHdsYW4wOiBzZW5kIGF1dGggdG8gNjg6Njc6Yzc6
MmE6MjA6NDMgKHRyeSAzLzMpDQo+IFsxMjY0NjUuNjczMTE1XSB3bGFuMDogYXV0aGVudGljYXRp
b24gd2l0aCA2ODo2NzpjNzoyYToyMDo0MyB0aW1lZCBvdXQNCg0KVGhpcyBzYWlkIHRoYXQgaXQg
ZmFpbGVkIHRvIFRYIGF1dGggb3IgUlggYXV0aC4gSSBzdWdnZXN0IHRvIGRpc2FibGUNCkJsdWV0
b290aCBlbnRpcmVseSB0byBzZWUgaXQgY2FuIGltcHJvdmUuIA0KDQo+IFsxMjY0NjYuMDY1Nzgw
XSB3bGFuMDogYXV0aGVudGljYXRlIHdpdGggNjg6Njc6Yzc6MmE6MjA6NDIgKGxvY2FsIGFkZHJl
c3M9N2M6ZmE6ODA6YzM6NWI6ZjkpDQo+IFsxMjY0NjYuMDY1Nzg5XSB3bGFuMDogc2VuZCBhdXRo
IHRvIDY4OjY3OmM3OjJhOjIwOjQyICh0cnkgMS8zKQ0KPiBbMTI2NDY4LjA4MjcxOF0gd2xhbjA6
IHNlbmQgYXV0aCB0byA2ODo2NzpjNzoyYToyMDo0MiAodHJ5IDIvMykNCj4gWzEyNjQ3MC4xMDc4
MDJdIHdsYW4wOiBzZW5kIGF1dGggdG8gNjg6Njc6Yzc6MmE6MjA6NDIgKHRyeSAzLzMpDQo+IFsx
MjY0NzEuMDcwNzQzXSB3bGFuMDogYWJvcnRpbmcgYXV0aGVudGljYXRpb24gd2l0aCA2ODo2Nzpj
NzoyYToyMDo0MiBieSBsb2NhbCBjaG9pY2UgKFJlYXNvbjoNCj4gMz1ERUFVVEhfTEVBVklORykN
Cj4gWzEyNjQ3NC44NTg2OTVdIHdsYW4wOiBhdXRoZW50aWNhdGUgd2l0aCA2ODo2NzpjNzoyYToy
MDo0MyAobG9jYWwgYWRkcmVzcz03YzpmYTo4MDpjMzo1YjpmOSkNCj4gWzEyNjQ3NC44NTg3MDVd
IHdsYW4wOiBzZW5kIGF1dGggdG8gNjg6Njc6Yzc6MmE6MjA6NDMgKHRyeSAxLzMpDQo+IFsxMjY0
NzQuODc5NDMwXSB3bGFuMDogYXV0aGVudGljYXRlIHdpdGggNjg6Njc6Yzc6MmE6MjA6NDMgKGxv
Y2FsIGFkZHJlc3M9N2M6ZmE6ODA6YzM6NWI6ZjkpDQo+IFsxMjY0NzQuODc5NDM5XSB3bGFuMDog
c2VuZCBhdXRoIHRvIDY4OjY3OmM3OjJhOjIwOjQzICh0cnkgMS8zKQ0KPiBbMTI2NDc0Ljg4NDYz
M10gd2xhbjA6IGF1dGhlbnRpY2F0ZWQNCj4gWzEyNjQ3NC44ODU1NzhdIHdsYW4wOiBhc3NvY2lh
dGUgd2l0aCA2ODo2NzpjNzoyYToyMDo0MyAodHJ5IDEvMykNCj4gWzEyNjQ3NC44OTk1MjFdIHds
YW4wOiBSWCBBc3NvY1Jlc3AgZnJvbSA2ODo2NzpjNzoyYToyMDo0MyAoY2FwYWI9MHgxMDExIHN0
YXR1cz0wIGFpZD0yMCkNCj4gWzEyNjQ3NS4wMDI3NDRdIHdsYW4wOiBhc3NvY2lhdGVkDQo+IFsx
MjY0NzUuMDAyNzk5XSB3bGFuMDogTGltaXRpbmcgVFggcG93ZXIgdG8gMjMgKDIzIC0gMCkgZEJt
IGFzIGFkdmVydGlzZWQgYnkgNjg6Njc6Yzc6MmE6MjA6NDMNCj4gWzEyNjQ5MC44MDIzNjVdIGlk
ZWFwYWRfYWNwaSBWUEMyMDA0OjAwOiB1bmV4cGVjdGVkIGNoYXJnZV90eXBlczogYm90aCBbRmFz
dF0gYW5kIFtMb25nX0xpZmVdIGFyZQ0KPiBlbmFibGVkDQo+IFsxMjY2MjcuNzYwNzM2XSBpZGVh
cGFkX2FjcGkgVlBDMjAwNDowMDogdW5leHBlY3RlZCBjaGFyZ2VfdHlwZXM6IGJvdGggW0Zhc3Rd
IGFuZCBbTG9uZ19MaWZlXSBhcmUNCj4gZW5hYmxlZA0KPiANCj4gKEhlcmUgSSBkZWNpZGUgdG8g
bWFudWFsbHkgcmVjb25uZWN0IHRvIHRoZSBzYW1lIG5ldHdvcmspDQo+IA0KPiBbMTI2NzM3LjU1
NjAxNV0gd2xhbjA6IGRlYXV0aGVudGljYXRpbmcgZnJvbSA2ODo2NzpjNzoyYToyMDo0MyBieSBs
b2NhbCBjaG9pY2UgKFJlYXNvbjoNCj4gMz1ERUFVVEhfTEVBVklORykNCj4gWzEyNjczOC4yMTU2
NzhdIHdsYW4wOiBhdXRoZW50aWNhdGUgd2l0aCA2ODo2NzpjNzoyYToyMDo0MyAobG9jYWwgYWRk
cmVzcz03YzpmYTo4MDpjMzo1YjpmOSkNCj4gWzEyNjczOC4yMTU2OTddIHdsYW4wOiBzZW5kIGF1
dGggdG8gNjg6Njc6Yzc6MmE6MjA6NDMgKHRyeSAxLzMpDQo+IFsxMjY3NDAuMjcyMjQ0XSB3bGFu
MDogc2VuZCBhdXRoIHRvIDY4OjY3OmM3OjJhOjIwOjQzICh0cnkgMi8zKQ0KPiBbMTI2NzQwLjI5
MTI2NF0gd2xhbjA6IGF1dGhlbnRpY2F0ZSB3aXRoIDY4OjY3OmM3OjJhOjIwOjQzIChsb2NhbCBh
ZGRyZXNzPTdjOmZhOjgwOmMzOjViOmY5KQ0KPiBbMTI2NzQwLjI5MTI3MV0gd2xhbjA6IHNlbmQg
YXV0aCB0byA2ODo2NzpjNzoyYToyMDo0MyAodHJ5IDEvMykNCj4gWzEyNjc0MC4yOTMzMTBdIHds
YW4wOiBhdXRoZW50aWNhdGVkDQo+IFsxMjY3NDAuMjk0MjE0XSB3bGFuMDogYXNzb2NpYXRlIHdp
dGggNjg6Njc6Yzc6MmE6MjA6NDMgKHRyeSAxLzMpDQo+IFsxMjY3NDAuMzAzNjc5XSB3bGFuMDog
UlggQXNzb2NSZXNwIGZyb20gNjg6Njc6Yzc6MmE6MjA6NDMgKGNhcGFiPTB4MTAxMSBzdGF0dXM9
MCBhaWQ9MjEpDQo+IFsxMjY3NDAuNDA5NDMwXSB3bGFuMDogYXNzb2NpYXRlZA0KPiBbMTI2NzQw
LjQwOTUxN10gd2xhbjA6IExpbWl0aW5nIFRYIHBvd2VyIHRvIDIzICgyMyAtIDApIGRCbSBhcyBh
ZHZlcnRpc2VkIGJ5IDY4OjY3OmM3OjJhOjIwOjQzDQo+IA0KPiBJIHdpbGwgcmVzdW1lIHRlc3Rp
bmcgd2l0aCB0aGUgcG93ZXIgc2F2ZSBmdW5jdGlvbiB0dXJuZWQgb2ZmLCB0byBjaGVjayBpZiB0
aGF0IHN0aWxsIGlzIGEgd29ya2luZw0KPiB3b3JrYXJvdW5kIGZvciBub3cuDQoNClBsZWFzZSB0
ZXN0IGl0Lg0KDQpQaW5nLUtlDQoNCg==

