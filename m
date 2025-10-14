Return-Path: <linux-wireless+bounces-27963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDD4BD735B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 05:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13C7406610
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 03:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0914517A30A;
	Tue, 14 Oct 2025 03:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jfNRMVPF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A892BAF9
	for <linux-wireless@vger.kernel.org>; Tue, 14 Oct 2025 03:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760414085; cv=none; b=OGXx6J5+UYcyDOtkrm/j8+RwiyIue2zd5TIbKLOMzeoQJCxmIn5YkRYgCg4tVXJS4hclyGZprBaRYykhVM5lqIfuOPYtnepWsUcAIInAHpDBtw7ULaYA2LccSu29OSLb5PWHqhOC+ZNHkjN+s3+XF+8yq8JAi+582DRhG20Qz8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760414085; c=relaxed/simple;
	bh=2wd3emEDrNHkMKKReVoLeZhCg1lJOo5gKyrmwj5aX1w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lOVokdaGtYUf7W7SPAlb1+O73cqz45tU/wdJb4fDmXDxuITTnOknuzyBD1ln1gx4ZyUp9MdEz5bX5RCHBGWBB2a9lpgguI3msmvjioPTq9uhYa4M5gAAuCoxuxMzgiHzcJF+LzJKp8MyYJ2ncwbdvcgAdQhCRhd89P8dwIG9vC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jfNRMVPF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59E3sbCT32660990, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1760414077; bh=2wd3emEDrNHkMKKReVoLeZhCg1lJOo5gKyrmwj5aX1w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jfNRMVPFiEgBVStM8eWZ+eqDo1ksRpEdLXfxTOKMu+CMEZXC/tsClFNaUnQNbIV49
	 w8PLi31QopOwAac/P0rh3Cyg9q8KshNcGdCfcU00wW0vG7vECbVCF+YT4hXaZHxWSn
	 lzwV7icbp3TGa0MFfeeIXD2uKwFMxstkqz/58LwmGR+yuT9gFzchv+/ta5dwRXyi+1
	 UCD9RWX8i6yTDUdhRGz/zg7NS3hyrSa1Uzckaq8jfwG980oFsNgZjZ/siyRAaXraqZ
	 61FsUC7aZW/MLT+RdY0q2XOxTxkjVLg8rMxPc4WVZZPpzVU1dKyfpQBKd4W16mxZ1W
	 7fCsYOQ0jkCvQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59E3sbCT32660990
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 11:54:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 14 Oct 2025 11:54:38 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Tue, 14 Oct 2025 11:54:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH rtw-next 1/3] wifi: rtl8xxxu: Report the signal strength only if it's known
Thread-Topic: [PATCH rtw-next 1/3] wifi: rtl8xxxu: Report the signal strength
 only if it's known
Thread-Index: AQHcORM6buwg2Ly2qE2je2TUlB8BgLTBCZvA
Date: Tue, 14 Oct 2025 03:54:38 +0000
Message-ID: <83992604b9464559bec40b148248b779@realtek.com>
References: <cdbe1a18-f6f1-4575-bad9-e85db8101247@gmail.com>
In-Reply-To: <cdbe1a18-f6f1-4575-bad9-e85db8101247@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBTZW50
OiBUaHVyc2RheSwgT2N0b2JlciA5LCAyMDI1IDc6NTMgUE0NCj4gVGhlc2UgY2hpcHMgZG9uJ3Qg
cmVwb3J0IHRoZSBzaWduYWwgc3RyZW5ndGggZm9yIG1hbnkgKGFueT8pIGRhdGENCj4gZnJhbWVz
LiBXaGVuIHRoZSBzaWduYWwgc3RyZW5ndGggaXMgbm90IGtub3duLCBzZXQgUlhfRkxBR19OT19T
SUdOQUxfVkFMDQo+IGluIG9yZGVyIHRvIGF2b2lkIHJlcG9ydGluZyBhIHNpZ25hbCBzdHJlbmd0
aCBvZiAwLg0KPiANCj4gVGVzdGVkIHdpdGggUlRMODE5MkZVIGFuZCBSVEw4MTkyQ1UuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNv
bT4NCg0KUmV2aWV3ZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQo=

