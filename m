Return-Path: <linux-wireless+bounces-33747-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLC1JJ7hwWlhXgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33747-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 01:58:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AC4300161
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 01:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2E8E3021996
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 00:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A4823BD06;
	Tue, 24 Mar 2026 00:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="CHjJRSL/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7303881AA8
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 00:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313383; cv=none; b=kTjEcA+3p8bRIdUetLGeo+9sBO4VC3ZglSu4TcLdR3B/sIJjU3Ve08dfSfNvIsTAYemgUcf/7iTpi79jPDD5SGxB2rkFDO++zgW2Ow96DPR+lhfVRQWosfBan0PV0pfhs14+ce+KuD/pE44nHhS8VRauHI3M0EavP8Ec39hgR/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313383; c=relaxed/simple;
	bh=vw+I3SvFB5AcaAd31a5ecswwBPBIXGZ1jH95XqwOnBY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tySM/Bief7kDTW443OPF93/rdqwSGtvYTdcWrIcZAcNRofU8syU+XDFH7UVs0N4Y/yx1HhwuhGDsi31nEmwf7+h0rKBRouRSNegqs3GaBA9IINeE36vQuKxwkNp38GGY5zeGxvQiHgIfJm/LQCXdqRkufjn/2M/L6PqOr7Prheg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=CHjJRSL/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62O0nbc47060346, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774313377; bh=vw+I3SvFB5AcaAd31a5ecswwBPBIXGZ1jH95XqwOnBY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=CHjJRSL/KVZwWBBfoBZJmskOH5PznDaFJgnCGMh15vAG/MVc4bcCK5dUPUUTK5SlQ
	 StdERowGW8RuIveHmMDEfsI5YzVB3A1bq0nl/AaXZRBzxGauYSW44Ld+rMBlXTiguE
	 oI65WVe6f4Vgwq+dZ10mAMKD5tQ/wWKHHc5zBtBUt/CvWKGGuXgyky8cymOFq7kS6h
	 L1KeI8+7mT1hEY5Db6uw0mpOxat7A09XKZwGhC32j6fWnsMqTpMZPNcL32N/fEwdk1
	 pDKZTRfneUp1I9EWl+LBZ7aBGWvRUCh6DVkSDBWXySSSy7FnRQAEcSAL70oOKEKSqd
	 4bfd1isu6Zwvg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62O0nbc47060346
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 08:49:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Mar 2026 08:49:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Mar 2026 08:49:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Tue, 24 Mar 2026 08:49:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 6/7] wifi: rtw89: 8922d: add set channel of BB
 part
Thread-Topic: [PATCH rtw-next 6/7] wifi: rtw89: 8922d: add set channel of BB
 part
Thread-Index: AQHcunTqvmnh4fhR5EmJhY2ijpjOTLW7a5oAgAFviqA=
Date: Tue, 24 Mar 2026 00:49:37 +0000
Message-ID: <620d877ececd4af497e196166102f06d@realtek.com>
References: <20260323032556.19825-1-pkshih@realtek.com>
 <20260323032556.19825-7-pkshih@realtek.com>
 <897a086c-437b-44d7-8433-8c0feea814f3@gmail.com>
In-Reply-To: <897a086c-437b-44d7-8433-8c0feea814f3@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-33747-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 28AC4300161
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAy
My8wMy8yMDI2IDA1OjI1LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gVGhlIHNldCBjaGFubmVs
IG9mIEJCIHBhcnQgaXMgdGhlIG1haW4gcGFydCwgd2hpY2ggYWNjb3JkaW5nIHRvIGNoYW5uZWwN
Cj4gPiBhbmQgYmFuZHdpZHRoIHRvIGNvbmZpZ3VyZSBDQ0sgU0NPLCBSWCBnYWluIG9mIExOQSBh
bmQgVElBIHByb2dyYW1tZWQNCj4gPiBpbiBlZnVzZSBmb3IgQ0NLIGFuZCBPRkRNIHJhdGUsIGFu
ZCBzcHVyIGVsaW1pbmF0aW9uIG9mIENTSSBhbmQgTkJJIHRvbmVzLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+ID4gLS0tDQo+ID4g
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvY29yZS5oICAgICB8ICAgMiArDQo+
ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcmVnLmggICAgICB8ICA2NCAr
LQ0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3J0dzg5MjJkLmMgfCA4
MjAgKysrKysrKysrKysrKysrKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgODg1IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiANCj4gWy4uXQ0KPiANCj4gPiArDQo+ID4gK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgcnR3ODlfbmJpX3JlZ19kZWYgcnR3ODkyMmRfbmJpX3JlZ19kZWZb
XSA9IHsNCj4gPiArICAgICBbUkZfUEFUSF9BXSA9IHsNCj4gPiArICAgICAgICAgICAgIC5ub3Rj
aDFfaWR4ID0gezB4MjQxQTAsIDB4RkZ9LA0KPiA+ICsgICAgICAgICAgICAgLm5vdGNoMV9mcmFj
X2lkeCA9IHsweDI0MUEwLCAweEMwMH0sDQo+ID4gKyAgICAgICAgICAgICAubm90Y2gxX2VuID0g
ezB4MjQxQTAsIDB4MTAwMH0sDQo+ID4gKyAgICAgICAgICAgICAubm90Y2gyX2lkeCA9IHsweDI0
MUFDLCAweEZGfSwNCj4gPiArICAgICAgICAgICAgIC5ub3RjaDJfZnJhY19pZHggPSB7MHgyNDFB
QywgMHhDMDB9LA0KPiA+ICsgICAgICAgICAgICAgLm5vdGNoMl9lbiA9IHsweDI0MUFDLCAweDEw
MDB9LA0KPiA+ICsgICAgIH0sDQo+ID4gKyAgICAgW1JGX1BBVEhfQl0gPSB7DQo+ID4gKyAgICAg
ICAgICAgICAubm90Y2gxX2lkeCA9IHsweDI0NUEwLCAweEZGfSwNCj4gPiArICAgICAgICAgICAg
IC5ub3RjaDFfZnJhY19pZHggPSB7MHgyNDFBMCwgMHhDMDB9LA0KPiANCj4gSXMgdGhhdCBzdXBw
b3NlZCB0byBiZSAweDI0NUEwID8NCg0KVGhhbmtzIGZvciB0aGUgZmluZGluZy4gSSdsbCBmaXgg
aXQgYnkgdjIuDQoNCj4gDQo+ID4gKyAgICAgICAgICAgICAubm90Y2gxX2VuID0gezB4MjQ1QTAs
IDB4MTAwMH0sDQo+ID4gKyAgICAgICAgICAgICAubm90Y2gyX2lkeCA9IHsweDI0NUFDLCAweEZG
fSwNCj4gPiArICAgICAgICAgICAgIC5ub3RjaDJfZnJhY19pZHggPSB7MHgyNDVBQywgMHhDMDB9
LA0KPiA+ICsgICAgICAgICAgICAgLm5vdGNoMl9lbiA9IHsweDI0NUFDLCAweDEwMDB9LA0KPiA+
ICsgICAgIH0sDQo+ID4gK307DQo+ID4gKw0KPiANCj4gWy4uLl0NCg==

