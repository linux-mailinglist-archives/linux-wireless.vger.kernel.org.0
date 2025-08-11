Return-Path: <linux-wireless+bounces-26242-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52A5B1FF75
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 08:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 004B57A99DB
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 06:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8876B2853E2;
	Mon, 11 Aug 2025 06:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="hcoBCsR3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3823957C9F
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 06:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754894503; cv=none; b=TW/vuIE8xnq7REYK/vAQ3zeSJ0E0+MWQKkjOzccAlKKmIwqSu7C44kgOLI++l/fFLar7CEgVpiB+p+sMvKnPcWAlmRAGaKbLIJnmpSmmk4pzIlDu+SPxVq1kwt1sZxJcABcYLGprLpiJNn5tr5FGVTeYKehanpUO4A8XKntHGwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754894503; c=relaxed/simple;
	bh=OLwJsqM6Qn3cLDMWwbENeKksPYonZsFSjwBVmbYbiaI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CM5tgK0kFbIKgv/YjUMb3Db9WlGZZufEpwYGo36VbVy+ZUXEHXRKVLGAbuZ33viWAWmDKdBXHR86ykNoLQnWAsF1UHcEff1BYkVY37J/cR+ui/R44RtpLbiDZzPS1aWnoIzJOMoeKobPmPR0IiL6w0OrFYiXw69JDPoElX4puno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=hcoBCsR3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57B6fYF113862159, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754894495; bh=OLwJsqM6Qn3cLDMWwbENeKksPYonZsFSjwBVmbYbiaI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=hcoBCsR3d0v2buQ7zB85BypM1AubeHSfdfZ0/zVsWu3xCbPXzMH9U1QNoWC9pTVul
	 4d+ADdETWKplHsrrJPeI45MeGCQIsyBUQ9B2T4ykNT/z6LAjwW2RfN3Hx7i0oCr+pf
	 r+2ulrqsbcnuRsdedWITSPcymNK6RfABPUZqDKt02f0URLAMLLBOUh0DWru3xDzKgp
	 eQY8/ywakRiuEIMyHwyrDBywfIhgl/TzJaOWc2iZ3s9hmtQxtCSNUA+fpoB+ISOIMY
	 wptx85ovL7gkd+9UM8Bi/F7GfsWaahZ0LWqXGntZ7L/cJn9pzr2SVT6DPjNhjUWxpl
	 RCpevaem3nZ1Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57B6fYF113862159
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 14:41:35 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Aug 2025 14:41:34 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Aug 2025 14:41:34 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc%10]) with mapi id
 15.02.1544.011; Mon, 11 Aug 2025 14:41:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?TWFyY2luIFfDs2pjaWs=?= <wojcikmarcin49@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Suspending problem on fedora 42 with realtek wifi card
Thread-Topic: Suspending problem on fedora 42 with realtek wifi card
Thread-Index: AQHcCgqRin/3D/Q8DkSjhmugmDrGTrRc/5bg
Date: Mon, 11 Aug 2025 06:41:34 +0000
Message-ID: <c47cb60be443453d8fa1e3793c6b2857@realtek.com>
References: <CAE3x6Qi8Nku26B4aWE+jtJmHb=hO8C743_myNrrBzUAGyuUw9A@mail.gmail.com>
In-Reply-To: <CAE3x6Qi8Nku26B4aWE+jtJmHb=hO8C743_myNrrBzUAGyuUw9A@mail.gmail.com>
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

TWFyY2luIFfDs2pjaWsgPHdvamNpa21hcmNpbjQ5QGdtYWlsLmNvbT4gd3JvdGU6DQo+IEdvb2Qg
bW9ybmluZywNCj4gSSB3YXMgYXNrZWQgdG8gZW1haWwgeW91IGFib3V0IG15IHByb2JsZW0gd2l0
aCB3aWZpIGNhcmQgY29ubmVjdGl2aXR5DQo+IGFmdGVyIHN1c3BlbmRpbmc6DQo+IGh0dHBzOi8v
Z2l0aHViLmNvbS9tb3Jyb3duci9ydHc4OS9pc3N1ZXMvMTgjaXNzdWVjb21tZW50LTMwODM3ODQy
NjgNCg0KQnkgdGhlIGxvZywNCg0KICAwMDAwOjM5OjAwLjA6IFVuYWJsZSB0byBjaGFuZ2UgcG93
ZXIgc3RhdGUgZnJvbSBEM2NvbGQgdG8gRDAsIGRldmljZSBpbmFjY2Vzc2libGUNCg0KU2VlbWlu
Z2x5LCBkZXZpY2UgZ2V0cyBsb3N0IGFmdGVyIHN5c3RlbSByZXN1bWVzLg0KDQpUbyByZXNvbHZl
IHRoZSByb290IGNhdXNlLCB3ZSBuZWVkIHRvIG1lYXN1cmUgaGFyZHdhcmUgc2lnbmFscywgYnV0
IHRoaXMgaXMNCm5vdCBwb3NzaWJsZSB0byB5b3UuIFRoZW4sIEknZCBsaWtlIHRvIGFkZCBhIHF1
aXJrIGZvciB5b3VyIHBsYXRmb3JtLiBDb3VsZA0KeW91IHNoYXJlIHRoZSBvdXRwdXQgb2YgJ3N1
ZG8gZG1pZGVjb2RlJz8gSSdsbCB0cnkgdG8gbWFrZSBhIHBhdGNoLg0KDQpXaXRoIGEgcXVpcmsg
c2V0LCBjYWxsaW5nIHBjaV9kM2NvbGRfZGlzYWJsZSgpIHRvIGRpc2FibGUgZDNjb2xkIG1pZ2h0
DQpiZSBhIHBvc3NpYmxlIHNvbHV0aW9uLiANCg0KPiANCj4gSSBtYW5hZ2VkIHRvIHNvbHZlIHRo
YXQgcHJvYmxlbSBhZnRlciB3cml0aW5nIDAgdG8NCj4gL3N5cy9idXMvcGNpL2RldmljZXMvMDAw
MDozOTowMC4wL2QzY29sZF9hbGxvd2VkDQo+IA0KPiBUaGF0J3MgbXkgd2lmaSBjYXJkOg0KPiBt
YXJjaW5AZmVkb3JhOn4kIGxzcGNpIHwgZ3JlcCBSZWFsdGVrDQo+IDM5OjAwLjAgTmV0d29yayBj
b250cm9sbGVyOiBSZWFsdGVrIFNlbWljb25kdWN0b3IgQ28uLCBMdGQuIFJUTDg4NTJCRQ0KPiBQ
Q0llIDgwMi4xMWF4IFdpcmVsZXNzIE5ldHdvcmsgQ29udHJvbGxlcg0KPiANCj4gSXMgdGhlcmUg
YW55IGNoYW5jZSB0byBzb2x2ZSB0aGlzIHByb2JsZW0gd2l0aG91dCBuZWVkaW5nIHRvIHdyaXRl
IDANCj4gdG8gc3lzIGZpbGVzPw0KDQo=

