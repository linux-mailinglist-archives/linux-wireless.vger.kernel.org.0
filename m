Return-Path: <linux-wireless+bounces-25347-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27EBB0351D
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 06:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B17AC7A30F6
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 04:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80846FC3;
	Mon, 14 Jul 2025 04:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="IyAskHHC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AC71519B4
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 04:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752466756; cv=none; b=usp6CzyLBpBxayXgfeFKuHm90Mgs1knxaD6pNtv5SpRXFI0ESNRkrejO6AKUk7+jcxlcY9XLXqwRp+/VfU9GU0Hd+kBETMmvDIH1myzgSt12nLbvM34tBos3sOkkrECPkCF50kmMK3FVJ5p3qTTAcQ8I9OBKr/w4jj0fa2WECK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752466756; c=relaxed/simple;
	bh=nbHYBw+LWXGbCSvIaxx4K8ug3d/eGlMigGcA+SidZus=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZgchhXdpVEcH5lqJ3yQsdu0KAPtkIt9qDcDcR7P//a0oNorO9yWhEEHu4oEU61n6GEkoY+yMTu0quuJCRPLDq05+R8hNedOTOzavw22zlQx1CrqalfPmI7BNRvD43Jbk37n/VAtKG5ubhFo7azMSMlODcSCZ+Qv/Bpbz9r/PCY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IyAskHHC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56E4J94d81557288, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752466749; bh=nbHYBw+LWXGbCSvIaxx4K8ug3d/eGlMigGcA+SidZus=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=IyAskHHCoq2UONhbO7Ewub8e/M+xTwy3dIkHhN9c9eUkokrTu+J+0PVinLNMa4yo1
	 Ohv5viSWv4u/qOzUDd/4pS/NmqYh4FnyShihagBp0WruU3Udj1VBsRsEhJYtz6lKHv
	 Wc8UgIi+/L3ADnlBkkDHkXT71irvA2W7HvrJFlFIwFabXXGa5pa9U02yCNVKZL3p3A
	 CNGlklZocV4qHfGBBEXCkfmVK897byyuTXtzIlSHz/U46a6/zPUBgQtRlKjXE5pxLz
	 eOF7lAqD/wXDfhEU0P7hz50d0SQuf6oiFSm4Io1mfmef38y32ged247jVXDQFKnjMr
	 KQZWJel6idG4Q==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56E4J94d81557288
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 12:19:09 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Jul 2025 12:19:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 14 Jul 2025 12:19:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Mon, 14 Jul 2025 12:19:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw88: Fix macid assigned to TDLS station
Thread-Topic: [PATCH rtw-next] wifi: rtw88: Fix macid assigned to TDLS station
Thread-Index: AQHb9CwzCsc9VVCHbkSMji3xipEI87QxBCtA
Date: Mon, 14 Jul 2025 04:19:09 +0000
Message-ID: <bccc0c238d524d77bed93e62cf2788bd@realtek.com>
References: <58648c09-8553-4bcc-a977-9dc9afd63780@gmail.com>
In-Reply-To: <58648c09-8553-4bcc-a977-9dc9afd63780@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBXaGVu
IHdvcmtpbmcgaW4gc3RhdGlvbiBtb2RlLCBURExTIHBlZXJzIGFyZSBhc3NpZ25lZCBtYWNpZCAw
LCBldmVuDQo+IHRob3VnaCAwIHdhcyBhbHJlYWR5IGFzc2lnbmVkIHRvIHRoZSBBUC4gVGhpcyBj
YXVzZXMgdGhlIGNvbm5lY3Rpb24NCj4gd2l0aCB0aGUgQVAgdG8gc3RvcCB3b3JraW5nIGFmdGVy
IHRoZSBURExTIGNvbm5lY3Rpb24gaXMgdG9ybiBkb3duLg0KPiANCj4gQXNzaWduIHRoZSBuZXh0
IGF2YWlsYWJsZSBtYWNpZCB0byBURExTIHBlZXJzLCBzYW1lIGFzIGNsaWVudCBzdGF0aW9ucw0K
PiBpbiBBUCBtb2RlLg0KPiANCj4gRml4ZXM6IDkwMmNiN2IxMWY5YSAoIndpZmk6IHJ0dzg4OiBh
c3NpZ24gbWFjX2lkIGZvciB2aWYvc3RhIGFuZCB1cGRhdGUgdG8gVFggZGVzYyIpDQo+IFNpZ25l
ZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpB
Y2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg==

