Return-Path: <linux-wireless+bounces-22695-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F5DAAD26B
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 02:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B57985D76
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 00:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950E7335BA;
	Wed,  7 May 2025 00:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="gRq5IBSI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D461A29A
	for <linux-wireless@vger.kernel.org>; Wed,  7 May 2025 00:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746578982; cv=none; b=F/VM3GaH8H9apCtoME9aFYH2y9YTsVv8JvvYp5B87+jdebMTF8hZ/z9lHGkkLDZRqb5Fd3DXnLVEfbQyQJRCmnbgNdxxGnqQnNZJOyEnXVVTVAUvgr6gHj+agadj0HIrSnXoXQetoYS9gw5aI+HxHn9FpZgLAHcUabMLp1LdxJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746578982; c=relaxed/simple;
	bh=dyPGgkGnlCu0OEXqqpt8cR9hJz+imusHPbomxkCt0Io=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XbYMkBcBaYaSHLKj8KHoa2lqS5IubOLtMg5IIqe7z0mwXJEVZbuBXwpmP3PH4Fq/QiORZ4R/VxQGC3N2jBd6unQ3IFC7fJ34653Q5AfdBxOTxsVb13EH2QLYoVkxex/wE/KBQU8xMntyWoG4h0f/e7h5uVCpZ5zZMtMmxr+R8Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=gRq5IBSI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5470nRbhD3466409, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746578967; bh=dyPGgkGnlCu0OEXqqpt8cR9hJz+imusHPbomxkCt0Io=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=gRq5IBSIYgECtNGZ+VKg1MrbR18g6t2KFCrherYwPnp1qHFf5FPn9gFDxQ6tTF9p8
	 2b7QowPm5xyrdMKBCM/n0FUET301INCZs8est/gk9E9OwYhnHrGZo0+VqLV1QV89Ab
	 xo9ZcgRNEtq9NQEPQOJF8B53OLfPCNiFlugYflwNqrkaHzrUIGSI/v0+6D70MeYFRO
	 U1yZg+3Q7grNEfi7G22iE0fbEHBR8m/EGrYbMrGMnzNTBAFZGzsxc41hdepPY8PO6Q
	 bD1iz3mpHAYaEVw4IBh7xObj87l3n49vg9y6XJMHgT/9nnb+W6FW6TGacvSbuU5++J
	 2h6d8Kc38YTgA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5470nRbhD3466409
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 May 2025 08:49:27 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 May 2025 08:49:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 7 May 2025 08:49:28 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 7 May 2025 08:49:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Yuuki NAGAO <wf.yn386@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2] wifi:rtw88:rtw8822bu VID/PID for BUFFALO WI-U2-866DM
Thread-Topic: [PATCH v2] wifi:rtw88:rtw8822bu VID/PID for BUFFALO WI-U2-866DM
Thread-Index: AQHbu8Lf4URMlhWg0kuofo87RowCu7PDMqvggAG1/gCAAXNiEA==
Date: Wed, 7 May 2025 00:49:27 +0000
Message-ID: <a5ed7b9a3496434c897aae1e2079ca63@realtek.com>
References: <CA+Tmi=P0kFARoU3yrbMTOBhXz=1Q8MoroaSNbQDw_NZye6r60A@mail.gmail.com>
 <20250503003227.6673-1-wf.yn386@gmail.com>
 <deb6f384a0bf4f96b2c3092fd7f767e1@realtek.com>
 <df65e2a9-5430-47b2-853f-a04c404179ba@gmail.com>
In-Reply-To: <df65e2a9-5430-47b2-853f-a04c404179ba@gmail.com>
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

WXV1a2kgTkFHQU8gPHdmLnluMzg2QGdtYWlsLmNvbT4gd3JvdGU6DQo+IE9uIDIwMjUvMDUvMDUg
OTozNCwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IFl1dWtpIE5BR0FPIDx3Zi55bjM4NkBnbWFp
bC5jb20+IHdyb3RlOg0KPiA+Pg0KPiA+PiBBZGQgVklEL1BJRCAwNDExLzAzZDEgZm9yIHJlY2Vu
dGx5IHJlbGVhc2VkDQo+ID4+IEJVRkZBTE8gV0ktVTItODY2RE0gVVNCIFdpRmkgYWRhcHRlci4N
Cj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogWXV1a2kgTkFHQU8gPHdmLnluMzg2QGdtYWlsLmNv
bT4NCj4gPg0KPiA+IEZvciB0aGUgc3ViamVjdCwgbmVlZCBzcGFjZXMgYWZ0ZXIgIndpZmk6IiBh
bmQgInJ0dzg4OiIuDQo+ID4gSSBjYW4gYWRkIHNwYWNlcyB3aGVuIEkgbWVyZ2UuDQo+ID4NCj4g
PiBBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IA0KPiBTb3Jy
eSBmb3IgaW5jb252ZW5pZW5jZS4gQ291bGQgeW91IHBsZWFzZSBhZGQgc3BhY2VzIHRvIHRoZSBz
dWJqZWN0DQo+IHdoZW4geW91IG1lcmdlIHRoaXMgcGF0Y2g/DQoNClN1cmUuIEkgd2lsbCBkbyBp
dC4NCg0KDQo=

