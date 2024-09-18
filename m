Return-Path: <linux-wireless+bounces-12936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB3097B897
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 09:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55BEE282E80
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 07:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7F273501;
	Wed, 18 Sep 2024 07:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="M2c14MSZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED99273DC
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 07:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726644903; cv=none; b=nUUcaPXeLgoRpnD8ZoDZtIzBJffcGa794VMOMOLNd9/t8a/nPbYNIRI8+WuHK+efVMhWr3QSW5XFgH1YwyEkY+fWENUJPaIpJ7fXcffptfl0OUyle0tqu06rdEISsWymRJ7qYXp3HwGGT4ZZw82HR7w1otG86iXmNeMywsL2mSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726644903; c=relaxed/simple;
	bh=yN/I5EboOF0LrQVSZjkQ4ekS33dqJjiiZZe67sXo7J8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sl1Kg59twv/cRKnaJ51F7LKiugrghR93KrOmicnCVQSt8ohFL5rMZfxDfqxPvDR0JD8LcX/DSQ4YgRVEs/HwFeR1n3rSQUWXi2LN9Q7j1NbzlR9Hxonxolml1eS1i7Lr3qggFCw3jsFESgjI/eT1upyT+kfskPVhUqCAILt2W04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=M2c14MSZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48I7Yo7gA1763975, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726644890; bh=yN/I5EboOF0LrQVSZjkQ4ekS33dqJjiiZZe67sXo7J8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=M2c14MSZ/+lWWpqM4bRlC6IDfHHeR5ryj6xUwmp67LAB1O5rsY1aaahv8NwKS5S9A
	 J5p6y0P/C7SkmZv/Rkx/wgsRUjzK0b/4d3k+XMAbJzGB+D5aGGU11WpSW5H6rOas20
	 6B/vXgffZK98YWvq9Im47j4eTdnySdNEi3BF4nCKllwACRxGbzTWAnULSDy15qp0LH
	 OM6Qc7vBHHmEEzKmRTcQUyanx5+R8k1Zml+hbhBnY6YKt8rQS6DLtFAKWz34Pjgfwe
	 CvNtNzjxLf+0taY3ABCLBDPlVkehUgycAosN4Cv+m1Ppme9+oSFTBBuUMD+APWDEap
	 praAlN31hrSPg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48I7Yo7gA1763975
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 15:34:50 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 18 Sep 2024 15:34:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 18 Sep 2024 15:34:50 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 18 Sep 2024 15:34:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?Q2VtIMOcTkFM?= <cemunal@linuxmail.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: RE: PCIe Bus Error from rtw_8821ce
Thread-Topic: RE: PCIe Bus Error from rtw_8821ce
Thread-Index: AQHbCNiaV91dngQR6EiAODPVjiVajbJcwL+g///croCAAIoz8A==
Date: Wed, 18 Sep 2024 07:34:50 +0000
Message-ID: <71107862cf8e451ca19c1dac72a51b4a@realtek.com>
References: <trinity-7a84c76b-e8b0-4da8-8f8c-07ad3485a23d-1726560422197@3c-app-mailcom-lxa11>
 <6d0fc72b21794f73a6017b467a102500@realtek.com>
 <trinity-154f2ef3-0df7-4802-88fc-d2ddcfb70a52-1726643761105@3c-app-mailcom-lxa04>
In-Reply-To: <trinity-154f2ef3-0df7-4802-88fc-d2ddcfb70a52-1726643761105@3c-app-mailcom-lxa04>
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

Q2VtIMOcTkFMIDxjZW11bmFsQGxpbnV4bWFpbC5vcmc+IHdyb3RlOg0KPiANCj4gVGhhbmsgeW91
IGJ1dCB0aGlzIGRpZCBub3Qgc29sdmUgdGhlIHByb2JsZW0uDQo+IA0KDQpBZnRlciByZWJvb3Rp
bmcsIGhhdmUgeW91IGNoZWNrZWQgdGhlIHZhbHVlcyBvZiBiZWxvdz8gDQoJL3N5cy9tb2R1bGUv
cnR3ODhfcGNpL3BhcmFtZXRlcnMvZGlzYWJsZV9hc3BtDQoJL3N5cy9tb2R1bGUvcnR3ODhfY29y
ZS9wYXJhbWV0ZXJzL2Rpc2FibGVfbHBzX2RlZXANCg0KSWYgdGhlcmUgaXMgb3B0aW9uIHJlbGF0
ZWQgdG8gUENJIHBvd2VyIHNhdmUgaW4gQklPUywgcGxlYXNlIHRyeSB0byB0dXJuIHRoZW0gb2Zm
Lg0KDQoNCg==

