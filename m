Return-Path: <linux-wireless+bounces-5080-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B5B881C52
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 07:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0E61F21A90
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 06:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7A738DC0;
	Thu, 21 Mar 2024 06:07:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4D26FBF
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 06:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711001230; cv=none; b=iUq3dd52mNuuuwgguxqoCwsWBxXT0FntFXMo3jVFubTGXMe36y7ivIISHeLwjEN5GkYoPWAx3ZeFRX0oTgc/HjBYjar7jeAADgrXnM2i6xXDiebXHAZPY81UerYl9XyKzOumJfTftC23xTMrOvZaNGhZqkFtgaLfcWf5F2LNd3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711001230; c=relaxed/simple;
	bh=+pdIEGE9V9uYexEx7Bjdy467Ot37C/PMgtLbeLrzltE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B7HARQN2DHUZOX2vH23DfQUbTpDa2uhDXim+zcuu9MiwY2YZ1BTcIMZ+RhP0zh69oWuz/yrMokAqqb/oAhwhYs/pCekDZA7ltyFNBy+rSJkB7IBgavC0cJ1Vpua9MZAF8oChSD6l6stRatay8xevTr3V/oP4QDpbtzDgB8EqTls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42L66xo06911214, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42L66xo06911214
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 14:06:59 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 14:06:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 14:06:59 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Thu, 21 Mar 2024 14:06:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "kvalo@kernel.org" <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Leo.Li"
	<leo.li@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: disable txptctrl IMR to avoid flase alarm
Thread-Topic: [PATCH] wifi: rtw89: disable txptctrl IMR to avoid flase alarm
Thread-Index: AQHaezuD0B/f5lkmzkaOqNn1/IzumbFBpkXY//9/XgCAAI5OC///eyeA
Date: Thu, 21 Mar 2024 06:06:59 +0000
Message-ID: <01c674f6f1442494bc7ec9778bd650aa63e6ad95.camel@realtek.com>
References: <20240321025603.20614-1-pkshih@realtek.com>
	 <878r2c2mob.fsf@kernel.org>
	 <2eefd73994778c1fa1dc03acf04708d686ec3185.camel@realtek.com>
	 <87jzlw9l8y.fsf@kernel.org>
In-Reply-To: <87jzlw9l8y.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B17E140FB238141B680DCA9CCAFA2C2@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

T24gVGh1LCAyMDI0LTAzLTIxIGF0IDA4OjAxICswMjAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiAN
Cj4gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyaXRlczoNCj4gDQo+ID4gU2hv
dWxkIEkgY2hhbmdlIHRvIHdpcmVsZXNzIG1haWxpbmcgbGlzdCBhcyBUbyBmaWVsZCBhbmQgbm8g
bmVlZCB0bw0KPiA+IGFkZCB5b3UgaW4gbmVpdGhlciBUbyBmaWVsZCBub3IgQ2MgZmllbGQgaW4g
dGhlIGZ1dHVyZT8NCj4gDQo+IFllcywgcGxlYXNlIGRyb3AgbWUgZnJvbSBUbyBhbmQgQ2MgZmll
bGRzLiBBbmQgaWYgdGhlcmUncyBhbiBpbXBvcnRhbnQNCj4gZml4IHlvdSB3YW50IHRvIGdvIHRv
IHdpcmVsZXNzIHRyZWUgcGxlYXNlIGxhYmVsIGl0IGFzICJbUEFUQ0gNCj4gd2lyZWxlc3NdIiAo
b3IgY29tbWVudCBvbiB0aGUgcGF0Y2gpIGFuZCBhc3NpZ24gdG8gbWUgb24gcGF0Y2h3b3JrLg0K
PiANCg0KR290IGl0LiBCdXQsIHN0aWxsIGFkZCB5b3UgdG8gVG8tZmllbGQgZm9yIHB1bGwtcmVx
dWVzdCwgcmlnaHQ/DQoNClBpbmctS2UNCg0K

