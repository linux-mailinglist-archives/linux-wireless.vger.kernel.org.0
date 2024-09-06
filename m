Return-Path: <linux-wireless+bounces-12572-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B729296E700
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 02:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD6D286C49
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 00:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6834818638;
	Fri,  6 Sep 2024 00:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="NGb9wE0v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0311799F
	for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2024 00:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725584033; cv=none; b=mCUM8GXPROLY1AolrwNArTh5O0jiDiLJ8t3yjhS2Z4g7QXFoE6BIeLsnZ9o7U/lp2sF4jx7uM8fyv5jsOhImopBDMImIXCKhHCZAYw9/AJl6xJKpj5iALd1oIx3BXHL+HGdBWqZSar+dZ/a6nNVCmFyMxyaym6zb9dyIhJ7m37c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725584033; c=relaxed/simple;
	bh=JpQnGUQOrM/0SRFrxLuAl9yZgoiUN3r9dMJk8tMenxE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LNxZxmRiCiYaILInKHCKYPmVs8RrwkQJGLWVncim3PLqQ1LJL/Hx6xbQLhl9GlL7gm35r5WP9cKMEp+fdkSM6u500J83PLVzfb8ETZ0roYR4lRZkrUaaYR30Ql10KYtSE/wbycifr22/wjXHUnLRftkyuiVEnQwhpOxI+X/JCtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=NGb9wE0v; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4860rhxsF237460, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1725584023; bh=JpQnGUQOrM/0SRFrxLuAl9yZgoiUN3r9dMJk8tMenxE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=NGb9wE0vHO1/dZjiCQ9xnPb1cXMozKPeZv0AIAueMtpVNJlEi968vMPkAT6XcktT/
	 9PE1mWoqr2LXsRcwzAB3iZ9LN7o6LbfzfD2EH38IKMDk/5jUh9tMulY1sl0FnYDVlo
	 Ckb/YuK0aJ9I8nKWHq1FxR0i/QBJd2xqQ91YtG1zKxWmZ5uK/WzXcol6BO89domW/R
	 vHP4SU1kjb3uyHB1ympZvHQxGy6xeVKWbYvcltThfmpw4dH4FwdiIHtZiF82BjWbrC
	 9gc0C0cUqDs4cD2Pv7YpL7jqnL2g1apgA9nrh/r75naR/FSGZ7Sl737roVDRTji6jG
	 m/zIwFGGN8TKQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4860rhxsF237460
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Sep 2024 08:53:43 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Sep 2024 08:53:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 6 Sep 2024 08:53:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 6 Sep 2024 08:53:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Eli DeCampo <eli@decampo.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: RTW89 Driver Issues
Thread-Topic: RTW89 Driver Issues
Thread-Index: AQHa/8qGG4LZF5jXvUKFmROmayiRrrJJ7AeA
Date: Fri, 6 Sep 2024 00:53:43 +0000
Message-ID: <2973bb92992d4911a100854300060449@realtek.com>
References: <CAGCFnVBNNLgyKp_FLnvMiMnkAtwXrQbgot96Zmb_FeZNXFu+ew@mail.gmail.com>
In-Reply-To: <CAGCFnVBNNLgyKp_FLnvMiMnkAtwXrQbgot96Zmb_FeZNXFu+ew@mail.gmail.com>
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

RWxpIERlQ2FtcG8gPGVsaUBkZWNhbXBvLm9yZz4gd3JvdGU6DQoNCj4gU2VwIDA1IDE1OjIxOjUz
IENvbXBvb3Blci12MiBOZXR3b3JrTWFuYWdlcls4NzZdOiA8aW5mbz4NCj4gWzE3MjU1NjQxMTMu
ODA5OV0gZGV2aWNlICh3bHAxczApOiBzdXBwbGljYW50IGludGVyZmFjZSBzdGF0ZToNCj4gZGlz
Y29ubmVjdGVkIC0+IGF1dGhlbnRpY2F0aW5nDQo+IFNlcCAwNSAxNToyMTo1MyBDb21wb29wZXIt
djIgTmV0d29ya01hbmFnZXJbODc2XTogPGluZm8+DQo+IFsxNzI1NTY0MTEzLjgxMDBdIGRldmlj
ZSAocDJwLWRldi13bHAxczApOiBzdXBwbGljYW50IG1hbmFnZW1lbnQNCj4gaW50ZXJmYWNlIHN0
YXRlOiBkaXNjb25uZWN0ZWQgLT4gYXV0aGVudGljYXRpbmcNCj4gU2VwIDA1IDE1OjIxOjUzIENv
bXBvb3Blci12MiBOZXR3b3JrTWFuYWdlcls4NzZdOiA8aW5mbz4NCj4gWzE3MjU1NjQxMTMuODEw
MF0gZGV2aWNlICh3bHAxczApOiBzdXBwbGljYW50IGludGVyZmFjZSBzdGF0ZToNCj4gYXV0aGVu
dGljYXRpbmcgLT4gZGlzY29ubmVjdGVkDQo+IFNlcCAwNSAxNToyMTo1MyBDb21wb29wZXItdjIg
TmV0d29ya01hbmFnZXJbODc2XTogPGluZm8+DQo+IFsxNzI1NTY0MTEzLjgxMDBdIGRldmljZSAo
cDJwLWRldi13bHAxczApOiBzdXBwbGljYW50IG1hbmFnZW1lbnQNCj4gaW50ZXJmYWNlIHN0YXRl
OiBhdXRoZW50aWNhdGluZyAtPiBkaXNjb25uZWN0ZWQNCg0KSXQgbG9va3MgbGlrZSBOZXR3b3Jr
TWFuZ2VyIGNvbnRyb2wgdHdvIGludGVyZmFjZXMgZGVyaXZlZCBmcm9tIHdscDFzMC4gDQpTdWdn
ZXN0IHRvIHNpbXBseSB0aGUgdXNlIGNhc2UgdG8gaWRlbnRpZnkgcHJvYmxlbS4gUGxlYXNlIHR1
cm4gb2ZmDQpOZXR3b3JrTWFuYWdlciBhbmQgdXNlICdpdyB3bHAxczAgc2NhbicgY29tbWFuZCB0
byBzZWUgaWYgeW91IGNhbiBzZWUNCmFueSBBUC4gSWYgeWVzLCB0cnkgJ2l3IHdscDFzMCBjb25u
ZWN0IEFQX1NTSUQnIHRvIGNvbm5lY3QgYSBub24tc2VjdXJlIEFQLg0KDQpUaGUgZG1lc2cgbG9n
IHNob3VsZCBiZSBjb2xsZWN0ZWQgYWZ0ZXIgdHJ5aW5nIGNvbm5lY3Rpb24uIFRoZW4gd2UgY2Fu
DQpzZWUgaG93IHRoZSBkcml2ZXIgZ29lcyB3cm9uZy4NCg0KUGluZy1LZQ0KDQo=

