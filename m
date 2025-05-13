Return-Path: <linux-wireless+bounces-22898-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E2FAB4BD9
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 08:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77933863BA2
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 06:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB901DE4E6;
	Tue, 13 May 2025 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="joXZntGA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A72CEC5
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 06:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747117335; cv=none; b=Apacq2Pwc/v/MZaysk/zTCp1wSR75dGJFFgzFS3JqwBVoKhasK8vIaLP+po8t6MuZmOLr5I2m2bAkeAdu2wNU4xNVvSp61eQB1drramPVOhuy0GFp4qBwVVK19RRVGkMpD6Jealg32ssePLC/BdgU6tyCZsSLArWDPNsLn2wpa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747117335; c=relaxed/simple;
	bh=LNG3CYkss/0e7trgvpaZLpI4f91q/Wvzd4GzyzCHJtY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jPZYJU4nVUBzppsc/9qyCo467QDEWz2hf8zFsVeIIIEX/gndDAU1da13HtIwkTQCH0nuOnhfENGmRiEVMwWBp+ikCIMn2LnT8FkFxmNhj9e39QEj8JUSlAmK+8ywEZajp4HE+wPIhqD6bRmORivao9HYAqjUTvClnIuwOveCNwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=joXZntGA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54D6M9RB03841497, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747117329; bh=LNG3CYkss/0e7trgvpaZLpI4f91q/Wvzd4GzyzCHJtY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=joXZntGAz4l4Pz+vEgR1++ap0UMmMI/p12wYlF2GRMtIj+nmVfDFCDWmYPxTIc8lx
	 uIp8ZAOjqjS9C+xG9mlWcXQ2eDdhpm6un8x+qbYq5Kln5YMQDBXSYfYmy2wNw8MF4f
	 WWggtnpMMo/p74TBRn1w6SY1KzB/aDsOQq/gSD8hoaPcNp4uYgqW2XAmks2fnmgvt5
	 X8z7EpTXeqsho4SaysHG776HATFTFYQWnFtnm8rnbmF6FT4z6pGJnhvRUTEPh39TiV
	 3ENlDvvn6s7vJW7zDzjJnR2zFBpjnDHha3F+Noum/gLI9Fw5owalkSUp0ZcYnnRXbH
	 5LTWAohUNlQsg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54D6M9RB03841497
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 14:22:09 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 May 2025 14:22:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 May 2025 14:22:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 13 May 2025 14:22:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v1 00/13] wifi: rtw89: Add support for USB devices
Thread-Topic: [PATCH rtw-next v1 00/13] wifi: rtw89: Add support for USB
 devices
Thread-Index: AQHbvTXQPM5g3Ac8D0CEfnCEvmiFA7PQI+gw
Date: Tue, 13 May 2025 06:22:08 +0000
Message-ID: <77f82582cb7144af950a78225068d400@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
In-Reply-To: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
QWRkIHN1cHBvcnQgZm9yIFVTQiBkZXZpY2VzLCBzdGFydGluZyB3aXRoIGp1c3QgUlRMODg1MUJV
Lg0KDQpUaGFua3MgZm9yIHlvdXIgd29yayEhDQoNCj4gUlRMODgzMkJVL1JUTDg4NTJCVSBjYW4g
YmUgc3VwcG9ydGVkIGVhc2lseSBsYXRlci4gUlRMODgzMkNVL1JUTDg4NTJDVQ0KPiBjYW4gYmUg
c3VwcG9ydGVkIGFzIHdlbGwsIGJ1dCBpdCBrZWVwcyBsb3NpbmcgdGhlIGNvbm5lY3Rpb24uDQo+
IA0KPiBUaGlzIGlzIGJhc2VkIG9uIHJ0dzg4X3VzYiBhbmQgdGhlIG9mZmljaWFsIHJ0bDg4NTFi
dSBkcml2ZXINCj4gdjEuMTkuMTAtNzAtZzg0ZTM1YzI4ZC4yMDIzMTAxOSBmcm9tIGhlcmU6DQo+
IGh0dHBzOi8vZ2l0aHViLmNvbS9mb2ZhamFyZG8vcnRsODg1MWJ1DQo+IA0KPiBJIGRpZG4ndCB0
ZXN0IHdpdGggYW55IFBDSSBkZXZpY2VzLg0KDQpJIHRlc3RlZCBSVEw4ODUxQkUuIEl0IHdvcmtz
IGFzIHVzdWFsLg0KDQo=

