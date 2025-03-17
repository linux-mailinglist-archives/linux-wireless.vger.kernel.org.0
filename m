Return-Path: <linux-wireless+bounces-20415-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F343A63C1A
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 03:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C2EB7A4511
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 02:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0111459F7;
	Mon, 17 Mar 2025 02:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Rr9XmsVP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1432D14C5AF
	for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 02:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742179983; cv=none; b=GN/b0KKstfxg7u5gfNG0JQ0wLnUxhOmpo+vb2Fr2+fPe/afuh9quybJ91pRfKa1Yysxhh0602R7CwPOKxnP8nRmpu3yPU62Wrr5I7tG+yfoQWbO26xsgqLBH5LBexVyF8sbbLWS0jv1w3abqSNXv7c2CVZVuZ+CSyc0ZGPA4XR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742179983; c=relaxed/simple;
	bh=+ctbcEwF0fyEzGujGwNg52bZ5cR8p/q7mBLUgs+DjgE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n6ijG1jacObJ00Nf0lWEtAL/kX2pxxwFva8FxuElKt5XbBKVThMBHWrfpVdv/vzycSRfKj0CAafSdakHZYXKmRJXqovFwS9a04Lv6ndSktSys7h9F9pYWZu3JDGP7cjg86qOcgB2zYi97Uqu3JYA4J7UkzyNwCQXlneOpPEM92w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Rr9XmsVP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52H2qt7zB3985850, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742179975; bh=+ctbcEwF0fyEzGujGwNg52bZ5cR8p/q7mBLUgs+DjgE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Rr9XmsVPmhbAB97pUZekk6Wpqfm/aw5J8384548OTOibAJOVfmSGkpFqGzFP1O326
	 GwBZjCJFQx7jiRurmVRETcA0vFrXyzF1dTReaxtMnHsTmo/o+uqCr+9614PwhTYSBM
	 e2wxJD6DklRC0QAdhvNzoW1IbYtnum+WriZb8K2C6GXBi2Uu4DjkQJDMP2fWGkAAqy
	 +BpIyamKUQyNi1f1clPGJ34ShTZSAEG6odmal+bOTFKBp/YvwuXm0xig3lkMPyzxhS
	 nTRsKthT16tcmVw7WAd8t3luMNx6KoEo5d23zEL2ESC33FE6DIf8aEpolOAXcyvfD6
	 RIoH+M7Od5J9w==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52H2qt7zB3985850
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 10:52:55 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Mar 2025 10:52:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 17 Mar 2025 10:52:55 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 17 Mar 2025 10:52:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 1/4] wifi: rtw88: usb: Enable switching the RTL8814AU to USB 3
Thread-Topic: [PATCH rtw-next 1/4] wifi: rtw88: usb: Enable switching the
 RTL8814AU to USB 3
Thread-Index: AQHblFTZMpgxJcigmE6uPabYa6IolrN2ppxQ
Date: Mon, 17 Mar 2025 02:52:54 +0000
Message-ID: <36912f6480c442ca9181b3b0bd8c19ca@realtek.com>
References: <c845ff10-08d9-4057-8f54-1579a548788d@gmail.com>
 <39d594a4-7099-4a6c-97be-51a7ab614777@gmail.com>
In-Reply-To: <39d594a4-7099-4a6c-97be-51a7ab614777@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGUg
UmVhbHRlayB3aWZpIDUgZGV2aWNlcyB3aGljaCBzdXBwb3J0IFVTQiAzIGFyZSB3ZWlyZDogd2hl
biBmaXJzdA0KPiBwbHVnZ2VkIGluLCB0aGV5IHByZXRlbmQgdG8gYmUgVVNCIDIuIFRoZSBkcml2
ZXIgbmVlZHMgdG8gc2VuZCBzb21lDQo+IGNvbW1hbmRzIHRvIHRoZSBkZXZpY2UsIHdoaWNoIG1h
a2UgaXQgZGlzYXBwZWFyIGFuZCBjb21lIGJhY2sgYXMgYQ0KPiBVU0IgMyBkZXZpY2UuDQo+IA0K
PiBUaGUgbWV0aG9kIHVzZWQgdG8gc3dpdGNoIHRoZSBSVEw4ODEyQVUgYWxzbyB3b3JrcyBmb3Ig
dGhlIFJUTDg4MTRBVS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0
bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhA
cmVhbHRlay5jb20+DQoNCg0K

