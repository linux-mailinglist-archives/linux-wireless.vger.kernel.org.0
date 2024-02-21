Return-Path: <linux-wireless+bounces-3838-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0718485D1F3
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 08:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6340286977
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 07:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015223B787;
	Wed, 21 Feb 2024 07:58:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C053B785
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502331; cv=none; b=c1yKNxUdyVUgUjupCLlYqkfKvCFJM8wCnSvO16J/Qgr5F2miyUP8xBWvQHyhO7BrDjXxu2ZqldsLxQmVzopKsKGz/vKt49vNZQLaDPNWmwRBbEf/bDYMRa/QBNQyUsAXq7pvORSCSROX2U6zB016UrRY09ROTyhnqzqS4DOZk3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502331; c=relaxed/simple;
	bh=lU97ICEr2Q7XxRgtPCL5qkh8h6B3sDqEuKgB7ZY67xk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hqovEIeyXXUmF7b6uNys3F2sJvX9epL6c74FRU/9undzDSibejUttjS+VI/VtMqSeUCuOo1Z/NRTBL0HyqTw/aDLnGa5hw9BO/EAajeL7NASCrcrMDXzPJsMymL3wRBAy3aOjmsU3+zj5N1Nfy0yx6LvzaPfl53txQ1aU1JyPhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41L7wS7Q1903549, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41L7wS7Q1903549
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 15:58:28 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Wed, 21 Feb 2024 15:58:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 15:58:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Wed, 21 Feb 2024 15:58:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>,
        Ilan Peer <ilan.peer@intel.com>, "Jouni
 Malinen" <j@w1.fi>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: RE: [PATCH v8 4/5] wifi: mac80211: start and finalize channel switch on link basis
Thread-Topic: [PATCH v8 4/5] wifi: mac80211: start and finalize channel switch
 on link basis
Thread-Index: AQHaU4YW43ZUC/cFnUyW8JfF3/48hLD//cCAgAAEzoCABc0KgIAACpsAgAB9JYCAAPMbgIAAOXcAgAAazYCAAAqOAIAAHYkAgAACHICADMP6oA==
Date: Wed, 21 Feb 2024 07:58:27 +0000
Message-ID: <5a89e63fb7644d12be72154c90c96199@realtek.com>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
	 <20240130140918.1172387-5-quic_adisi@quicinc.com>
	 <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
	 <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
	 <26df9aa6-e497-4040-ad5c-c647454acca6@quicinc.com>
	 <b2cf5c1d-7842-4e59-b25a-904a6879fa9c@quicinc.com>
	 <f7174207668cac149246cafa0e4b4749ee3289f0.camel@sipsolutions.net>
	 <ac5825e8-0cb1-476e-be5c-ad0170122f77@quicinc.com>
	 <fe2100dcfe9ae9b4517f239faf25374c27f473a5.camel@sipsolutions.net>
	 <5c0fd2eb-eb19-4b69-a325-ad9eef633336@quicinc.com>
	 <bc81466177afd0014ccdd9030c5807339bb288db.camel@sipsolutions.net>
	 <18c0d4de-392a-420c-8a05-466a83cd2eb8@quicinc.com>
 <3c550ae335a9762a9cbd0c8109b6dd99faeb8f6f.camel@sipsolutions.net>
In-Reply-To: <3c550ae335a9762a9cbd0c8109b6dd99faeb8f6f.camel@sipsolutions.net>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9oYW5uZXMgQmVyZyA8
am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMTMs
IDIwMjQgODo0OSBQTQ0KPiBUbzogQWRpdHlhIEt1bWFyIFNpbmdoIDxxdWljX2FkaXNpQHF1aWNp
bmMuY29tPg0KPiBDYzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBKZWZmIEpvaG5z
b24gPHF1aWNfampvaG5zb25AcXVpY2luYy5jb20+OyBJbGFuIFBlZXINCj4gPGlsYW4ucGVlckBp
bnRlbC5jb20+OyBKb3VuaSBNYWxpbmVuIDxqQHcxLmZpPjsgUGluZy1LZSBTaGloIDxwa3NoaWhA
cmVhbHRlay5jb20+OyBSeWRlciBMZWUNCj4gPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjggNC81XSB3aWZpOiBtYWM4MDIxMTogc3RhcnQgYW5kIGZpbmFs
aXplIGNoYW5uZWwgc3dpdGNoIG9uIGxpbmsgYmFzaXMNCj4gDQo+ICBiKSBsZXQncyB3YWl0IGZv
ciBSZWFsdGVrIHRvIGNvbW1lbnQgYWxzbyBhZnRlciB0aGUgTHVuYXIgTmV3IFllYXIgOikNCj4g
DQoNClNvcnJ5IGZvciB0aGUgbGF0ZS4gDQoNClJlYWx0ZWsgZmlybXdhcmUgY2FuIHVwZGF0ZSBw
YXJ0bmVyIGxpbmtzJyBDU0EvRUNTQSBieSBnaXZlbiBvZmZzZXQgb2YNCmJlYWNvbiB0ZW1wbGF0
ZSwgd2hpY2ggbWF0Y2hlcyB0aGUgY29uY2x1c2lvbiBvZiB0aGlzIHRocmVhZCwgYW5kIFJlYWx0
ZWsgdmVuZG9yDQoob3V0IG9mIHRyZWUpIGRyaXZlciBoYXMgdmVyaWZpZWQgdGhlIGZpcm13YXJl
IGludGVyZmFjZS4gU28gdGhhdCB3aWxsDQp3b3JrIHRvIFJlYWx0ZWsgV2lGaSA3IGNoaXBzLiAN
Cg0KUGluZy1LZSANCg0K

