Return-Path: <linux-wireless+bounces-21608-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6070FA910FE
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 03:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1337A7BED
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 01:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967D017CA12;
	Thu, 17 Apr 2025 01:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="u8Yc3/K9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81CA747F;
	Thu, 17 Apr 2025 01:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744851934; cv=none; b=GQ7t9wExVf0HfMJHr9E7QTZSFLEmyQLJCcwTr7hUMJkq2emmj99JBRbKY6yJ2TdTneLYN8E5mGj4eAuFw18HgJXKvB9CT/2483AVw+gW4rqNdp2m6rv/fyaxZPqj3Bac7bDWEXv4TBELob5K2/RZ7sS4l2RtLYOkLaX+TL6ROGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744851934; c=relaxed/simple;
	bh=RKi1DlQXqOO9FE+IUoMQnb4MWXE8x90HjnAOxUyYyTw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jk2z4MIsDYprOdQrj1s3CRTnG+p+gFKbAK6+/2mgb6N71Dc4cqyeGlqRh4w6+2kXChRPju6lyZtd4TZ0G9nYiy7F89laFn7yABH4vpU6EQB5/CyPs/NPwKkbOkyL5dU/jzJ4Ki6sHjuAfTamMlhLh0vB/aCEeG/SBRj7J9Fre0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=u8Yc3/K9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53H15Q3s84192752, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744851926; bh=RKi1DlQXqOO9FE+IUoMQnb4MWXE8x90HjnAOxUyYyTw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=u8Yc3/K9NwIgfmYgSwJPCWTEnvdWIVrupdtQovfKq8SodnStSMvR2YXYojDL49njD
	 lfY3LCv8xOd3+nUK6mclRj+hYr4k5p4AeealLszvgRvFIIMGtNtgGSu6Qoq9w8EJSI
	 hN51VzGnbdRHXgblhbiqU0jLtQujnqoYas004OKTOXzX0v2+5OjEzIGXXZlh9eylkU
	 9Ghj4et/s4XpfqdHGafoqRvrxhSW2Z/6iIRgU2WpMvCSU0SI/fW2oQVNtAVtu+KEiI
	 omPrnKfhMqMoslp1UHEI148+4pE+rr19g8v5TFxDvIFkiIwqVR7m6WJkGbyi82sJFq
	 cCAEW7XcbHrkg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53H15Q3s84192752
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 09:05:26 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Apr 2025 09:05:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 17 Apr 2025 09:05:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Thu, 17 Apr 2025 09:05:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <boddah8794@gmail.com>
CC: Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Bug report] rtw89: 8852b: IO_PAGE_FAULTs with beacon filter feature enabled
Thread-Topic: [Bug report] rtw89: 8852b: IO_PAGE_FAULTs with beacon filter
 feature enabled
Thread-Index: AQHbrfBpW2AH+n1rZEuyFH6rIsW1k7Olc7dQgAAnAYCAAXKcUA==
Date: Thu, 17 Apr 2025 01:05:26 +0000
Message-ID: <dcf695a6621f43e38a20eb860194191a@realtek.com>
References: <uidltsdsuujrczrtzgerhh5cw2tztxktfen6yvztnc7gttzgvk@jccomj7f4gul>
 <148ed65c53be4ef29246d372dd0fef8e@realtek.com>
 <z54thedngt3wnhr5bfer3yg7id2c4uqgw2jjvyausv6p66ys4k@guqol77fpugz>
In-Reply-To: <z54thedngt3wnhr5bfer3yg7id2c4uqgw2jjvyausv6p66ys4k@guqol77fpugz>
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

RmVkb3IgUGNoZWxraW4gPGJvZGRhaDg3OTRAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIFdl
ZCwgMTYuIEFwciAwMDo0OSwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IEFzIGJpc2VjdGlvbiwg
Y2FuIEkgc3VtbWFyaXplIGFzIGJlbG93IHRhYmxlPw0KPiA+DQo+ID4gICAgIGQ1NmMyNjFlNTIg
ICAgICAgICAgIGZpcm13YXJlICAgICAgICAgICAgIElPX1BBR0VfRkFVTFQNCj4gPiAgICAoQ1FN
IHN1cHBvcnQpDQo+ID4gICAtLS0tLS0tLS0tLS0tLS0gICAgICAtLS0tLS0tLS0tLSAgICAgICAg
ICAtLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAgICAgIG8gICAgICAgICAgICAgICAgIDAuMjkuMjku
NyAgICAgICAgICAgICAgICAgIHllcw0KPiA+ICAgICAgIG8gICAgICAgICAgICAgICAgIDAuMjku
MjkuNSAgICAgICAgICAgICAgICAgIG5vDQo+ID4gICAgICAgeCAgICAgICAgICAgICAgICAgMC4y
OS4yOS43ICAgICAgICAgICAgICAgICAgbm8NCj4gPiAgICAgICB4ICAgICAgICAgICAgICAgICAw
LjI5LjI5LjUgICAgICAgICAgICAgICAgICBubw0KPiA+DQo+ID4gSWYgdGhpcyB0YWJsZSBpcyBj
b3JyZWN0LCB3ZSB3aWxsIGNoZWNrIHRoZSBiZWFjb24gZmlsdGVyIGZlYXR1cmUgaW4gZmlybXdh
cmUuDQo+ID4NCj4gDQo+IFllcywgaXQgY29ycmVjdGx5IGRlc2NyaWJlcyB0aGUgc2l0dWF0aW9u
LiBNeSBzdXNwaWNpb24gY3VycmVudGx5IGZhbGxzIG9uDQo+IHRoZSBiZWFjb24gZmlsdGVyIGZl
YXR1cmUgaW4gZmlybXdhcmUsIHRvby4NCg0KQ291bGQgeW91IGhlbHAgdG8gdGVzdCB3aGVuIHdl
IGhhdmUgdXBkYXRlZCBmaXJtd2FyZT8NCg0K

