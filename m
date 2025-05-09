Return-Path: <linux-wireless+bounces-22764-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF49AB0B15
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 09:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC86502170
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 07:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BD020969A;
	Fri,  9 May 2025 07:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="SDXt3xrT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83DB1C2324
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 07:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746774036; cv=none; b=k4zAgSKQ9w9tEJS1xtik7VlG6R7MtMutmPrYQxtmToljvtRIMj1cfT+4VKxHdHuxYXQLbf+NY2Y4pHB7oO1pyHgyS3Tv3G7Uq0ihB2H+vwfwnWG+4uK7YMrbn7wIF2flNnq1ak3k+W8eF/3AvyTU/EcEykfvhGNiyukYk16c3r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746774036; c=relaxed/simple;
	bh=ZAZGYUNkN1Ugp57JvBZ+cPtarSW6l+mS43XATn/J0kM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lWr3dmn7/trpGl2gNXciQLp6cFpcDpWQIymq0TEhD7QvMhLZSqCF/y2ZRLwWdBYrDmEQQzVUgB/2UI4xswVvrGELZxZg/XyLn6G8xx1yX+5RMlM+yGNSPgZ/2jZtc8W36c2ZAV6452WgX/39M3Af717yV1ngpRQZqvkgY7gBqCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=SDXt3xrT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 54970R1i83777419, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746774027; bh=ZAZGYUNkN1Ugp57JvBZ+cPtarSW6l+mS43XATn/J0kM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=SDXt3xrTMIlV4K6JVD62iYVY+HJcj2DDCAIzRPuEkl90gNzieY7uka7WFh8tOK2y0
	 cvT2IZ9ZNDRXFo7EZdGO5LVhbZAEvgWIerG81dl04PKJg3LeGFtf/+nMR+QQOPphjl
	 v2u4lBlDhmaKUk4OdRJJWwReZ6UnZkQm5N8b8Ys14ndj/tqY7rYxMsWRAZcvnfJMrs
	 k6YOvcHRxlQYiYLhK4zXgzHhMhq0jCr5MrdihvTAG+XK/XNkIo2qCVWlIVPxgrY6ol
	 b2GTEyIUVnWZ8NwR7OS3SreZy+2UsofpiF+QiPT4gDbciiKSfASRtn3FqWA9YCybar
	 CxafbM/OSModg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 54970R1i83777419
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 15:00:27 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 May 2025 15:00:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 May 2025 15:00:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Fri, 9 May 2025 15:00:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Samuel Reyes <zohrlaffz@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: RTL8922AE driver issues
Thread-Topic: RTL8922AE driver issues
Thread-Index: AQHbvXDofJ7veYm0B0SRgsW1576rS7PDt/FQgAAI4oCAARqb4IACHsgAgAD3lUCAAL5jgIAAx0sw///bsgCAAIsmgA==
Date: Fri, 9 May 2025 07:00:26 +0000
Message-ID: <5f46a63596734dc1b2287a0ac6f2ac8b@realtek.com>
References: <CAD+XiyEJo0m8L6PbmBD=NPPa0E_wX3kk4ezn1qZ0d8JGXsS1qQ@mail.gmail.com>
 <0cf9bd4b99864f428175e34a2f2e014b@realtek.com>
 <CAD+XiyFkogCyQTk8Xhu8htGa892zFkY707+8WVCOdejb3FLNpg@mail.gmail.com>
 <ae5013a930574e68b96544df82f93157@realtek.com>
 <CAD+XiyEQPt9HGngt0XBB7Hf=0tDHHcU+3=E20vhPnC3VL1Y+vg@mail.gmail.com>
 <31b6571789b34b95aca2bca73dca2d62@realtek.com>
 <CAD+XiyEXU_cxgfk1DxFZLFMLXWbmo-cDf7d30Hb1F7_BqdBCQw@mail.gmail.com>
 <f4355539f3ac46bbaf9c586d059a8cbb@realtek.com>
 <CAD+XiyGWqu6TA==PBZaffnsABbHFycuzQDBKE4mBDWPOw9fx7Q@mail.gmail.com>
In-Reply-To: <CAD+XiyGWqu6TA==PBZaffnsABbHFycuzQDBKE4mBDWPOw9fx7Q@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

U2FtdWVsIFJleWVzIDx6b2hybGFmZnpAZ21haWwuY29tPiB3cm90ZToNCj4gT24gVGh1LCBNYXkg
OCwgMjAyNSBhdCA2OjM44oCvUE0gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdy
b3RlOg0KPiA+DQo+ID4gU2FtdWVsIFJleWVzIDx6b2hybGFmZnpAZ21haWwuY29tPiB3cm90ZToN
Cj4gPiA+IE9uIFdlZCwgTWF5IDcsIDIwMjUgYXQgNzoyM+KAr1BNIFBpbmctS2UgU2hpaCA8cGtz
aGloQHJlYWx0ZWsuY29tPiB3cm90ZToNCj4gPiBGb3IgbWUsIHRoZXNlIGRpcHMgc2VlbXMgdG8g
YmUgYWNjZXB0YWJsZS4gSWYgeW91IHdhbnQgdG8gZGlnIGZ1cnRoZXIsDQo+ID4gSSBzaG91bGQg
Y2hlY2sgUEhZIHJhdGUgZmlyc3QgdmlhIGRlYnVnZnM6DQo+ID4NCj4gPiAgICBjZCAvc3lzL2tl
cm5lbC9kZWJ1Zy9pZWVlODAyMTEvcGh5MC9ydHc4OQ0KPiA+ICAgIHdhdGNoIGNhdCBwaHlfaW5m
bw0KPiA+DQo+ID4gQW5kLCBjYXB0dXJlIHZpZGVvIGFzIGJlZm9yZS4NCj4gPg0KPiA+IEkgYWRt
aXQgdGhpcyBpcyBvbmx5IGZpcnN0IHN0ZXAgdG8gc2VlIGlmIHRoZSBzeW1wdG9tIGlzIGNhdXNl
ZCBieQ0KPiA+IFBIWSByYXRlLiBJZiB5ZXMsIEkgbmVlZCBhaXIgc25pZmZlciB0byBrbm93IGhv
dyBpdCBoYXBwZW5zLiBJZiBub3QsDQo+ID4gbWF5YmUgc3lzdGVtIGVudGVycyBwb3dlciBzYXZl
IG1vZGUgb3Igb3RoZXJzLg0KPiANCj4gSSBhZ3JlZSwgdGhleSBkb24ndCBtYWtlIGEgbWVhbmlu
Z2Z1bCBpbXBhY3Qgb24gbXkgY29ubmVjdGlvbi4gRm9yIHRoZQ0KPiBzYWtlIG9mIGdldHRpbmcg
dG8gdGhlIGJvdHRvbSBvZiB0aGUgaXNzdWUgSSB3ZW50IGFoZWFkIGFuZCBmb2xsb3dlZA0KPiB5
b3VyIGFkdmljZS4gSSByZWNvcmRlZCA1IG9mIHRob3NlIGRpcHMsIHRoZXkgY2FuIGJlIGZvdW5k
IGF0IHRoZQ0KPiBmb2xsb3dpbmcgdGltZXN0YW1wcyB3aXRoaW4gdGhlIHZpZGVvOiAyOjQ1LCA1
OjQwLCAxMDo0NywgMTM6MTIsIGFuZA0KPiAxNTo1MC4NCg0KQXQgdGhlIGZpcnN0IGRpcCAoMjo0
NSksIHRoZSBSWCBwYWNrZXRzIGRyb3AgdG8gemVyb3MuIE90aGVycycgUEhZIHJhdGUNCmxvb2tz
IG5vcm1hbCBhbmQgb25seSBSWCBjb3VudGVyIGlzIHNtYWxsZXIuIFNlZW1pbmdseSBpdCBpc24n
dCBzaW1wbGUgdG8NCmFkZHJlc3MgcHJvYmxlbXMsIHNvIEkgd291bGQgbGlrZSB0byBzdG9wIGRp
Z2dpbmcuIEhvdyBhYm91dCB5b3U/DQoNCg0K

