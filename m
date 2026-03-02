Return-Path: <linux-wireless+bounces-32331-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCbxAGbopGlVvQUAu9opvQ
	(envelope-from <linux-wireless+bounces-32331-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 02:31:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D971D24CB
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 02:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A6ED300D163
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 01:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EE326290;
	Mon,  2 Mar 2026 01:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="GTwVVVZN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F96632
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 01:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772415075; cv=none; b=jZLElT6IKhFIC88qEtDdE2dwdff3zhloeG9S6pJt8tMhyThWqnjSdyFxJxZo43XUyy71iE1G3qRaxyVIyPzyuLQhh4nkeCXDWku+2Cz1DVAPiXZ47vaPHVL5AHKRu15XnOR35ppdIzS+ub4BXgedg3/kt46ek42AE5YTmpV8fZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772415075; c=relaxed/simple;
	bh=osiQqWWOfV+k6hmOvlR4P4DbQJBjURVkrseYR7/Tw70=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qI4ffvpYAhdXlHeqVHX2UQ5/g9IHeIKBWghTaoCiAG6E49WnMWNo81zdAFL9HVNGngXZYH2MKBvaHviScYw3EHTyvNs0g3ME0L/lqH6ZRhSC8ZkMPHpnlUx3mJ2mzLLYRK6f3AF2r3hHdJoYCXXK+szU8wZx6rL7AcRIaVFg1V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GTwVVVZN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6221UwdbE1994072, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1772415059; bh=osiQqWWOfV+k6hmOvlR4P4DbQJBjURVkrseYR7/Tw70=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GTwVVVZNOnf17gu9cTZkg9WPb70WaVQgcS7O1nX8sWE9xqAgmT7hC9cYUWZ0/bXV+
	 v79Imttk2R893PYLq9u6sgkiMtHyNXpDwjcK6NPO8lL+mSGaF1mP/xvrRqpHSWFsCw
	 n2USXSTTmNmPHDq8zAJnpH2dVUKf9hAnUB5WGbk6vr7vxtPF/683e11aoGIZUu/vwX
	 8WgmQLt0T12Cxsq5XlTh750qUVioLGNO/p35oA6S87xHjwO5xp2+EFyrX+L/6Qz06l
	 EYGRpgSIGkrJX5U/sldDuu+2eFyg1zhhpyBrzMaVnMMShbWbKtnqwtP2Zc05CwOZVB
	 TLeXcZfrE5bjg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6221UwdbE1994072
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 09:30:58 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Mar 2026 09:30:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Mar 2026 09:30:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Mon, 2 Mar 2026 09:30:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Chris Wituchowski <flashrift@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "kvalo@kernel.org" <kvalo@kernel.org>
Subject: RE: [REGRESSION] rtw89_8852ae: HT/VHT/HE not negotiated, stuck at 54
 Mbps since kernel 6.18
Thread-Topic: [REGRESSION] rtw89_8852ae: HT/VHT/HE not negotiated, stuck at 54
 Mbps since kernel 6.18
Thread-Index: AQHcqZ+rDn0zPp0dvU2VBguPq1U+D7WacHpA
Date: Mon, 2 Mar 2026 01:30:58 +0000
Message-ID: <b310e5e49c3448e79aeefc37744b6901@realtek.com>
References: <CAMX+G=Yd2fF+56+xFSzffO5Fq_PhkD41sBNkmFMpU5anN+QkmQ@mail.gmail.com>
In-Reply-To: <CAMX+G=Yd2fF+56+xFSzffO5Fq_PhkD41sBNkmFMpU5anN+QkmQ@mail.gmail.com>
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
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-32331-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
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
X-Rspamd-Queue-Id: 73D971D24CB
X-Rspamd-Action: no action

Q2hyaXMgV2l0dWNob3dza2kgPGZsYXNocmlmdEBnbWFpbC5jb20+IHdyb3RlOg0KPiAqcmVzZW5k
IGFzIHBsYWludGV4dCAtIHNlbnQgb3JpZ2luYWxseSBhcyBodG1sLCBzb3JyeSEqDQo+IA0KPiBI
aSwNCj4gDQo+IEknbSByZXBvcnRpbmcgYSByZWdyZXNzaW9uIGluIHRoZSBydHc4OV84ODUyYWUg
ZHJpdmVyLiBBZnRlciB1cGdyYWRpbmcgZnJvbQ0KPiBrZXJuZWwgNi4xNC54IChGZWRvcmEgNDIg
R0EpIHRvIDYuMTgueCAoRmVkb3JhIDQzKSwgbXkgUlRMODg1MkFFIFdpRmkgYWRhcHRlcg0KPiBu
byBsb25nZXIgbmVnb3RpYXRlcyBIVCwgVkhULCBvciBIRSB3aXRoIHRoZSBhY2Nlc3MgcG9pbnQu
IFRoZSBjb25uZWN0aW9uIGZhbGxzDQo+IGJhY2sgdG8gbGVnYWN5IDgwMi4xMWEgYXQgNTQgTWJw
cyBvbiA1IEdIeiwgZGVsaXZlcmluZyBvbmx5IH4yMCBNYnBzIHJlYWwtd29ybGQNCj4gdGhyb3Vn
aHB1dCBvbiBhIGdpZ2FiaXQgbGluay4NCj4gDQo+ID09IEhhcmR3YXJlID09DQo+IA0KPiAgIEFk
YXB0ZXI6IFJlYWx0ZWsgUlRMODg1MkFFIDgwMi4xMWF4IFBDSWUgKFdpRmkgNiwgMngyIE1JTU8p
DQo+ICAgUENJIElEOiAgMTBlYzo4ODUyIChzdWJzeXN0ZW06IDE3YWE6NDg1MiwgTGVub3ZvKQ0K
PiAgIFN5c3RlbTogIExlbm92byBsYXB0b3ANCj4gDQo+ID09IFNvZnR3YXJlID09DQo+IA0KPiAg
IEJyb2tlbjogICA2LjE4LjEzLTIwMC5mYzQzLng4Nl82NCAoYWxzbyA2LjE4LjEwLCA2LjE4LjEy
IOKAlCBhbGwgYnJva2VuKQ0KPiAgIExhc3QgT0s6ICA2LjE0LnggKEZlZG9yYSA0MiBHQSBrZXJu
ZWwg4oCUIFdpRmkgd29ya2VkIGF0IGZ1bGwgODAyLjExYXggc3BlZWRzKQ0KPiAgIERyaXZlcjog
ICBydHc4OV84ODUyYWUgKGluLXRyZWUpDQo+ICAgRmlybXdhcmU6IHJ0dzg4NTJhX2Z3LmJpbiAo
djAuMTMuMzYuMiAvIDUyYWNjODA3KQ0KPiAgIERpc3RybzogICBGZWRvcmEgNDMNCj4gDQo+ID09
IFN5bXB0b21zID09DQo+IA0KPiBUaGUgYWRhcHRlciBjb25uZWN0cyB0byBhIDUgR0h6IEFQIChj
aGFubmVsIDE1NykgYnV0IGZhaWxzIHRvIG5lZ290aWF0ZQ0KPiBIVC9WSFQvSEUsIGZhbGxpbmcg
YmFjayB0byBsZWdhY3kgMjAgTUh6IC8gNTQgTWJwczoNCj4gDQo+ICAgJCBpdyBkZXYgd2xwM3Mw
IGxpbmsNCj4gICBDb25uZWN0ZWQgdG8gNTI6YmI6OWY6YTI6ZDg6NGEgKG9uIHdscDNzMCkNCj4g
ICAgICAgU1NJRDogSW5uZXJuZXR0ZQ0KPiAgICAgICBmcmVxOiA1Nzg1LjANCj4gICAgICAgc2ln
bmFsOiAtMjkgZEJtDQo+ICAgICAgIHJ4IGJpdHJhdGU6IDU0LjAgTUJpdC9zDQo+ICAgICAgIHR4
IGJpdHJhdGU6IDU0LjAgTUJpdC9zDQo+IA0KPiAgICQgaXcgZGV2IHdscDNzMCBpbmZvDQo+ICAg
ICAgIGNoYW5uZWwgMTU3ICg1Nzg1IE1IeiksIHdpZHRoOiAyMCBNSHogKG5vIEhUKSwgY2VudGVy
MTogNTc4NSBNSHoNCj4gDQo+IERlYnVnZnMgY29uZmlybXMgdGhlIGRyaXZlciBpcyBub3QgcmVw
b3J0aW5nIGFueSBIVC9WSFQvSEUgY2FwYWJpbGl0aWVzDQo+IGZvciB0aGUgc3RhdGlvbjoNCj4g
DQo+ICAgL3N5cy9rZXJuZWwvZGVidWcvaWVlZTgwMjExL3BoeSovbmV0ZGV2OndscDNzMC9zdGF0
aW9ucy88YnNzaWQ+L2h0Og0KPiAgICAgICAiaHQgbm90IHN1cHBvcnRlZCINCj4gDQo+ICAgL3N5
cy9rZXJuZWwvZGVidWcvaWVlZTgwMjExL3BoeSovbmV0ZGV2OndscDNzMC9zdGF0aW9ucy88YnNz
aWQ+L3ZodDoNCj4gICAgICAgIlZIVCBub3Qgc3VwcG9ydGVkIg0KPiANCj4gICAvc3lzL2tlcm5l
bC9kZWJ1Zy9pZWVlODAyMTEvcGh5Ki9uZXRkZXY6d2xwM3MwL3N0YXRpb25zLzxic3NpZD4vaGU6
DQo+ICAgICAgICJIRSBub3Qgc3VwcG9ydGVkIg0KPiANCj4gPT0gQVAgQ2FwYWJpbGl0aWVzIChj
b25maXJtZWQgdmlhIGl3IHNjYW4pID09DQo+IA0KPiBUaGUgQVAgZnVsbHkgc3VwcG9ydHMgSFQs
IFZIVCwgYW5kIEhFOg0KPiANCj4gICAtIEhUOiBIVDIwL0hUNDAsIE1DUyAwLTE1ICgyIHNwYXRp
YWwgc3RyZWFtcykNCj4gICAtIFZIVDogdXAgdG8gODAgTUh6LCBNQ1MgMC05IGZvciAyIFNTDQo+
ICAgLSBIRSAoV2lGaSA2KTogZnVsbCA4MDIuMTFheCBzdXBwb3J0DQo+ICAgLSBNYXggYWR2ZXJ0
aXNlZCByYXRlOiAxMTcwIE1icHMNCj4gDQo+IFRoZSBBUCdzICJIVCBwcm90ZWN0aW9uIiBmaWVs
ZCBzaG93cyAibm9uLUhUIG1peGVkIG1vZGUiLCBjb25maXJtaW5nIGl0DQo+IHNlZXMgdGhlIGNs
aWVudCBhcyBhIG5vbi1IVCBsZWdhY3kgc3RhdGlvbi4NCj4gDQo+ID09IFdoYXQgSSd2ZSBSdWxl
ZCBPdXQgPT0NCj4gDQo+ICAgMS4gU2lnbmFsIHN0cmVuZ3RoOiBFeGNlbGxlbnQgKC0yNyB0byAt
NDggZEJtIGFjcm9zcyB0ZXN0cykNCj4gICAyLiBXUEEzIHZzIFdQQTI6IFNhbWUgcmVzdWx0IHdp
dGggYm90aCAoa2V5LW1nbXQgc2FlIGFuZCBwc2spDQo+ICAgMy4gd3BhX3N1cHBsaWNhbnQgdnMg
aXdkOiBTYW1lIHJlc3VsdCB3aXRoIGJvdGggYmFja2VuZHMNCj4gICA0LiBGaXJtd2FyZTogQWxy
ZWFkeSBvbiBsYXRlc3QgdmVyc2lvbiAodjAuMTMuMzYuMikNCj4gICA1LiBEcml2ZXIgcmVsb2Fk
OiBGdWxsIHVubG9hZC9yZWxvYWQgb2YgcnR3ODkgbW9kdWxlIHN0YWNrIOKAlCBubyBjaGFuZ2UN
Cj4gICA2LiBQb3dlciBzYXZlOiBEaXNhYmxlZCAoZGlzYWJsZV9wc19tb2RlIG1vZHVsZSBwYXJh
bWV0ZXIpDQo+ICAgNy4gd2wgbW9kdWxlIGNvbmZsaWN0OiBCbGFja2xpc3RlZCB2aWEgL2V0Yy9t
b2Rwcm9iZS5kL2JsYWNrbGlzdC13bC5jb25mDQo+ICAgOC4gUmVndWxhdG9yeTogVVMgZG9tYWlu
IGFjdGl2ZSwgREZTLUZDQywgY29ycmVjdCBmb3IgY2hhbm5lbCAxNTcNCj4gICA5LiBSZWdyZXNz
aW9uIHdpdGhpbiA2LjE4Lng6IENoYW5nZWxvZ3MgZm9yIDYuMTguMTDihpI2LjE4LjEzIGNvbnRh
aW4NCj4gICAgICBaRVJPIHJ0dzg5L21hYzgwMjExL2NmZzgwMjExIGNoYW5nZXMuIEJ1ZyBleGlz
dHMgYWNyb3NzIGFsbCA2LjE4LnguDQo+IA0KPiA9PSBMaWtlbHkgQ2F1c2UgPT0NCj4gDQo+IEJl
dHdlZW4ga2VybmVsIDYuMTQgYW5kIDYuMTgsIHRoZSBydHc4OSBkcml2ZXIgcmVjZWl2ZWQgaHVu
ZHJlZHMgb2YgY29tbWl0cw0KPiBmb3IgV2lGaSA3IE1MTyAoTXVsdGktTGluayBPcGVyYXRpb24p
IHN1cHBvcnQsIGluY2x1ZGluZzoNCj4gDQo+ICAgLSBtYWM4MDIxMSBwZXItbGluayBTVEEgcmVm
YWN0b3JpbmcgKEhUL1ZIVC9IRSBjYXBzIG1vdmVkIHRvIHBlci1saW5rDQo+ICAgICBsaW5rX3N0
YSBzdHJ1Y3R1cmVzKQ0KDQpUaGF0IHNob3VsZCBiZSBjb21wYXRpYmxlIHdpdGggV2lGaSA2IGFu
ZCBlYXJsaWVyLiANCg0KPiAgIC0gNTQrIGNoYW5jdHggY29tbWl0cyBpbiBydHc4OSAoImNoYW46
IG1hbmFnZSBhY3RpdmUgaW50ZXJmYWNlcyIsDQo+ICAgICAidHdlYWsgc2V0dGluZyBvZiBjaGFu
bmVsIGFuZCBUWCBwb3dlciBmb3IgTUxPIiwgZXRjLikNCg0KVGhpcyBkcml2ZXIgaXMgdG8gc3Vw
cG9ydCBXaUZpIDYvNyBjaGlwcy4gVGhlIFdpRmkgNiBjaGlwcyBzaG91bGQgd29yaw0KYXMgYmVm
b3JlIHRoZXNlIHBhdGNoZXMuIA0KDQo+ICAgLSAiZGlzYWJsZSBFSFQgcHJvdG9jb2wgYnkgY2hp
cCBjYXBhYmlsaXRpZXMiDQoNCkVIVCBpcyB1c2VkIFdpRmkgNyBjaGlwcywgc28gbm8gd29ycmll
cyBhYm91dCB0aGlzLg0KDQo+IA0KPiBUaGUgUlRMODg1MkFFIGlzIGEgZ2VuMSBXaUZpIDYgY2hp
cC4gVGhlIE1MTyB3b3JrIHdhcyBkZXZlbG9wZWQgYW5kIHRlc3RlZA0KPiBwcmltYXJpbHkgb24g
Z2VuMiBXaUZpIDcgY2hpcHMgKFJUTDg5MjJBL0UpLiBJdCBhcHBlYXJzIHRoZSBnZW4xIGNvZGUg
cGF0aA0KPiB0aHJvdWdoIHRoZSBuZXcgcGVyLWxpbmsgZnJhbWV3b3JrIGlzIG5vdCBjb3JyZWN0
bHkgcG9wdWxhdGluZyBIVC9WSFQvSEUNCj4gY2FwYWJpbGl0aWVzIGR1cmluZyBhc3NvY2lhdGlv
bi4NCj4gDQo+ID09IFN0ZXBzIHRvIFJlcHJvZHVjZSA9PQ0KPiANCj4gICAxLiBTeXN0ZW0gd2l0
aCBSVEw4ODUyQUUgKDEwZWM6ODg1MikgcnVubmluZyBrZXJuZWwgNi4xOC54DQoNCkkgdHJpZWQg
dHdvIGtlcm5lbCA2LjE4LjEgYW5kIDYuMTkuMyB3aXRoIHNhbWUgZmlybXdhcmUgMC4xMy4zNi4y
ICg1MmFjYzgwNykNCnRoYXQgYm90aCB3b3JrIHdpdGggSEUgcmF0ZXMuDQoNCkkgZGlkIGNvbm5l
Y3Rpb24gYnkgJ2l3IGNvbm5lY3QnIGNvbW1hbmQgaW5zdGVhZCwgYmVjYXVzZSBteSBBUCBpcyBu
b24tc2VjdXJlLiANCg0KPiAgIDIuIENvbm5lY3QgdG8gYW55IDUgR0h6IDgwMi4xMWF4IGFjY2Vz
cyBwb2ludA0KPiAgIDMuIE9ic2VydmU6IGl3IGRldiA8aWY+IGluZm8gc2hvd3MgIndpZHRoOiAy
MCBNSHogKG5vIEhUKSINCg0KVGhpcyBpcyB0aGUgb3V0cHV0IGluIG15IHNpZGU6DQoNCiAgICAg
ICAgY2hhbm5lbCAzNiAoNTE4MCBNSHopLCB3aWR0aDogODAgTUh6LCBjZW50ZXIxOiA1MjEwIE1I
eg0KDQo+ICAgNC4gT2JzZXJ2ZTogaXcgZGV2IDxpZj4gbGluayBzaG93cyA1NC4wIE1CaXQvcyBi
aXRyYXRlDQoNClRoaXMgaXMgdGhlIG91dHB1dCBpbiBteSBvZmZpY2UgKHRoZSByYXRlIGlzbid0
IGdvb2QsIGJ1dCBzdGlsbCBIRSByYXRlKQ0KDQogICAgICAgIHJ4IGJpdHJhdGU6IDYwMC40IE1C
aXQvcyA4ME1IeiBIRS1NQ1MgMTEgSEUtTlNTIDEgSEUtR0kgMCBIRS1EQ00gMA0KICAgICAgICB0
eCBiaXRyYXRlOiAxODMuNyBNQml0L3MgODBNSHogSEUtTUNTIDIgSEUtTlNTIDIgSEUtR0kgMiBI
RS1EQ00gMA0KDQo+ICAgNS4gT2JzZXJ2ZTogZGVidWdmcyBodC92aHQvaGUgZmlsZXMgYWxsIHJl
cG9ydCAibm90IHN1cHBvcnRlZCINCg0KVGhpcyBpcyB0aGUgb3V0cHV0IGluIHN0YXRpb25zLzxi
c3NpZD4vIGRpcmVjdG9yeToNCg0KJCBzdWRvIGNhdCAqY2FwYSB8IGdyZXAgc3VwcG9ydGVkDQpF
SFQgbm90IHN1cHBvcnRlZA0KSEUgc3VwcG9ydGVkDQpodCBzdXBwb3J0ZWQNClZIVCBzdXBwb3J0
ZWQNCg0KPiANCj4gPT0gRXhwZWN0ZWQgUmVzdWx0ID09DQo+IA0KPiBDb25uZWN0aW9uIHNob3Vs
ZCBuZWdvdGlhdGUgSFQvVkhUL0hFICg4MCBNSHosIFdpRmkgNikgYXMgaXQgZGlkIG9uDQo+IGtl
cm5lbCA2LjE0LngsIHByb3ZpZGluZyA4MDArIE1icHMgbGluayByYXRlcy4NCj4gDQoNCkkgZG9u
J3QgaGF2ZSBhIEZlZG9yYSBvbiBoYW5kLCBhbmQgSSB0ZXN0ZWQgYWJvdmUgYnkgVWJ1bnR1ICsg
dXBkYXRlZCBwcmUtYnVpbHQNCmtlcm5lbCBbMV0uIFBsZWFzZSB0cnkgaWYgVWJ1bnR1IHdpdGgg
Ni4xOC4xIG9yIDYuMTkuMyBrZXJuZWwgY2FuIHdvcmsgaW4geW91ciBzaWRlLg0KDQpbMV0gaHR0
cHM6Ly9rZXJuZWwudWJ1bnR1LmNvbS9tYWlubGluZS92Ni4xOS4zLw0KDQo=

