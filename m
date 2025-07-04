Return-Path: <linux-wireless+bounces-24814-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FB1AF8751
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 07:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B84F17561A
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 05:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896841A2545;
	Fri,  4 Jul 2025 05:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="AWv++Ylz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF182347D5
	for <linux-wireless@vger.kernel.org>; Fri,  4 Jul 2025 05:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751607270; cv=none; b=lU64m0tw6NiiZ/9TIMO0NUDqvHy2nByvYq0eHCNpdOVQsUMgANp5ipCmWs0LNUhJeVGyx+ljbtFjkbko66eQEAITcvZJCaDzqs789zSc8jjDNKdhFOOje/Yu06ZfsM1Qxs3+PrAyTHwS3gbd6rUZGeuc9oSF/mFLFu44DJhTfAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751607270; c=relaxed/simple;
	bh=RT3P1Ivui4PpciRrwt9jhZLvQurvhCCNYMAoWGsUIHg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TcmtwRODXJLZb1OkS3DbTHIQVrsaqwZuGhyFjWbFcL1r+2AOByxHN/ICb3DwhoeUI42nkeWc9g2RYD+8BiAa82p/whi1TBw+Y+m0HzioxIVdSH6di9uoJqmR2aMAA7wBFmoGiG0hE+33YSDqfbeVNc9ud9Z5DWnpdG8g1NzLIeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=AWv++Ylz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5645YPd343800016, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1751607265; bh=RT3P1Ivui4PpciRrwt9jhZLvQurvhCCNYMAoWGsUIHg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=AWv++YlzrkHGN845pGVEwt+CTM/W5cOCqnrczaEvQEwv7uI0+J6JWL1JvNwN5n1Ld
	 NWqCmS+dZO6VZvzOZXQCAOng0f7HptlAdlvQjWUNdbPYE+icieQlHIWbp2YRz6bRwp
	 hcHdBM6pGi4XHQTaJ8/gJ2g2SUqmgxZgxX5fvBkC6z7mM4Eeklpt4wYY3EQYs1X9rO
	 mCkK1zfz5wSo8EnwQ4pViWuRndKckcqZdotsu1Qsy5/qNU2InUuDwtHNLBgtpywvrY
	 TbpFXSwc6o4IawkZl3hYfaPeeIonUEBR3GXjYR1mKTrYd5hTpOtm05vJvSMffmeKMN
	 +RtwA08oQGFWw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5645YPd343800016
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Jul 2025 13:34:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 4 Jul 2025 13:34:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 4 Jul 2025 13:34:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Fri, 4 Jul 2025 13:34:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 6/6] wifi: rtw89: Enable the new rtw89_8852bu module
Thread-Topic: [PATCH rtw-next 6/6] wifi: rtw89: Enable the new rtw89_8852bu
 module
Thread-Index: AQHb6qIO5JCqesK+SE60nqDLTRd7ArQhdPaw
Date: Fri, 4 Jul 2025 05:34:49 +0000
Message-ID: <4277c890c9be47ab8b2ec60bea1df73d@realtek.com>
References: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>
 <9da12cb0-d364-41bd-a62d-4c1f87e14a16@gmail.com>
In-Reply-To: <9da12cb0-d364-41bd-a62d-4c1f87e14a16@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBFbmFi
bGUgY29tcGlsYXRpb24gb2YgdGhlIG5ldyBydHc4OV84ODUyYnUgbW9kdWxlLg0KPiANCj4gVGVz
dGVkIG1vc3RseSBpbiBzdGF0aW9uIG1vZGUsIGFuZCBhIGxpdHRsZSBiaXQgaW4gQVAgbW9kZS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21h
aWwuY29tPg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoN
ClBsZWFzZSBzZW5kIHYyIHdpdGggbXkgYWNrZWQtYnkuIFNpbmNlIEkgaGF2ZSBtZXJnZWQgcGF0
Y2hzZXQgb2YgVVNCIHN1cHBvcnQsDQpuaXBhIGNhbiBoZWxwIHRvIGJ1aWxkIHRoaXMgcGF0Y2hz
ZXQgdGhlbi4NCg0KVGhhbmtzIGZvciB5b3VyIGdyZWF0IFVTQiB3b3JrLiANCg0K

