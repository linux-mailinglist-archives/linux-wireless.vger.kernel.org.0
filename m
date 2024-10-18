Return-Path: <linux-wireless+bounces-14206-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B421F9A3751
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 09:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D801F2124E
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 07:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E4A175D5F;
	Fri, 18 Oct 2024 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="WdmLB/PD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801A42BAEF
	for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 07:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729236971; cv=none; b=nqoEvlnq7S0ypA4sPCK/kravSI0bPg12+otsuiWm+5NlN/m1XyUHUNgwmSD0mj4dSV1VHZKOFuiJPk6ZJProZdbw1+OjzHiBiaqqGchC0nQOGKU1aPVW8rsEIMHUp3RKgZ3jvkRKkF6kTmCpK5vbKsN4fQvCFoWeFSlER0r3BVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729236971; c=relaxed/simple;
	bh=fLT0mVqM2geNxzKKOqjp6+6y1Aa2q6SMavRs5WeXTU0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IvRXBercHgUnnzztinivlOqaysANdvr3IzKZDgqWK308eLE0uBgptObYQpiLxYU2t8tzdAvheQ3AORxNPsad07fxBElJT40Qzw1WfyWV1r6e8XpsILq+Rlmw2BXFulyqcTnfWQy9914flSfEL/HiIRHMhjIzlbp/297rejVNfJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=WdmLB/PD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49I7a5qS51685859, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729236965; bh=fLT0mVqM2geNxzKKOqjp6+6y1Aa2q6SMavRs5WeXTU0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=WdmLB/PDPM7pBAF5BnQCQ2uPRXVekHMiDfWNOR2oFPjwVGshDs5TX7nDlMeyjE2+f
	 9NKxdkcfeFjkhFNiGJASdlsCpIrAmg5Ss4XG4go4DKsCce8koAHxhCimhdU1lhfefx
	 KHWw9UbX0Jk8+mAPSqGKGFSPcw1U7LqM9BMf4bzOmPKASEYU55tR8SykhZ4WnjyXec
	 LYeDHtI8HGof+ztc69r983atBNPEMYPoUSltM7SVcBE0TZyeNM1k1WHN3LAqXYoQML
	 pCLrLIzpYD5AfTN9zdOrdQnvYcfmj+UinkmmIoKtMTmY6dCJy/qqWprPhWuSaM1ewX
	 9MpBkMcUaYMRA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49I7a5qS51685859
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 15:36:05 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 15:36:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 18 Oct 2024 15:36:04 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 18 Oct 2024 15:36:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 21/22] wifi: rtw88: Add rtw8821au.c and rtw8812au.c
Thread-Topic: [PATCH v2 21/22] wifi: rtw88: Add rtw8821au.c and rtw8812au.c
Thread-Index: AQHbHCA/+YUbaMa4ukSVOvzZea5f07KMKB0Q
Date: Fri, 18 Oct 2024 07:36:04 +0000
Message-ID: <5222819febaf463797e11fd64d87f7fe@realtek.com>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
 <45604f31-a992-4188-b8c6-2d8e43981d77@gmail.com>
In-Reply-To: <45604f31-a992-4188-b8c6-2d8e43981d77@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiArDQo+
ICtzdGF0aWMgY29uc3Qgc3RydWN0IHVzYl9kZXZpY2VfaWQgcnR3Xzg4MjFhdV9pZF90YWJsZVtd
ID0gew0KPiArICAgICAgIHsgVVNCX0RFVklDRV9BTkRfSU5URVJGQUNFX0lORk8oMHgyMzU3LCAw
eDAxMWUsIDB4ZmYsIDB4ZmYsIDB4ZmYpLA0KPiArICAgICAgICAgLmRyaXZlcl9pbmZvID0gKGtl
cm5lbF91bG9uZ190KSYocnR3ODgyMWFfaHdfc3BlYykgfSwNCg0KTW9kdWxlIGRlc2NyaXB0aW9u
IHNheXMgIjg4MjFhdS84ODExYXUiLCBidXQgb25seSBvbmUgZGV2aWNlIElELiBEbyB0aGV5DQpz
aGFyZSB0aGUgc2FtZSBJRD8NCg0KPiArICAgICAgIHt9LA0KPiArfTsNCj4gK01PRFVMRV9ERVZJ
Q0VfVEFCTEUodXNiLCBydHdfODgyMWF1X2lkX3RhYmxlKTsNCj4gKw0KPiArc3RhdGljIHN0cnVj
dCB1c2JfZHJpdmVyIHJ0d184ODIxYXVfZHJpdmVyID0gew0KPiArICAgICAgIC5uYW1lID0gInJ0
d184ODIxYXUiLA0KPiArICAgICAgIC5pZF90YWJsZSA9IHJ0d184ODIxYXVfaWRfdGFibGUsDQo+
ICsgICAgICAgLnByb2JlID0gcnR3X3VzYl9wcm9iZSwNCj4gKyAgICAgICAuZGlzY29ubmVjdCA9
IHJ0d191c2JfZGlzY29ubmVjdCwNCj4gK307DQo+ICttb2R1bGVfdXNiX2RyaXZlcihydHdfODgy
MWF1X2RyaXZlcik7DQo+ICsNCj4gK01PRFVMRV9BVVRIT1IoIkJpdHRlcmJsdWUgU21pdGggPHJ0
bDg4MjFjZXJmZTJAZ21haWwuY29tPiIpOw0KPiArTU9EVUxFX0RFU0NSSVBUSU9OKCJSZWFsdGVr
IDgwMi4xMWFjIHdpcmVsZXNzIDg4MjFhdS84ODExYXUgZHJpdmVyIik7DQo+ICtNT0RVTEVfTElD
RU5TRSgiRHVhbCBCU0QvR1BMIik7DQo+IC0tDQo+IDIuNDYuMA0KDQo=

