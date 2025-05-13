Return-Path: <linux-wireless+bounces-22882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B38AB49AA
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 04:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1315E466ADB
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 02:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC3B27442;
	Tue, 13 May 2025 02:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="NKggG2Fh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B7A4C6C
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 02:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747104387; cv=none; b=gTYgMrKtcx4jk9K3uxjsdKkOknE4RAymQfu6yYRkXW4suKBlgQ9dTm7OyxVfjrs2uuMpCTlQFpP0X/nQ2Sb2JtbrDSYxUHBfL7FaKTO6wFh++k1h5bJje8IjAq1ixGvgXnyjePCzfukuLv5JCQam0lrfm6q4GvllCsUpQKrTolA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747104387; c=relaxed/simple;
	bh=F02Uby7PQoO0n4PmOE3Iz1hnfFtQiiBJaxk/m3kXUs4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FmRWd+ivpPm2wQKFP7S0l0Mt0BNbLXwp/Q1Fx5lW5V+bSAvIObMNe0o+I2wlhivtjQlY/xARQtPR9QtFI7SFh/CRzzcIgJWa/Kcccz6XJ1jgF5tprO+e4ZNo7NtLbXya6sy7rc9mQXR2oYZJUukEyibJ3vavy2p5/NpM9lqlV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=NKggG2Fh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54D2kGVm93549820, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747104380; bh=F02Uby7PQoO0n4PmOE3Iz1hnfFtQiiBJaxk/m3kXUs4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=NKggG2FhvPk8as5fgXdGnG0eqL0dR7g4rNseSPz1k+0gkW/BWiM9EWMepOp3r4Pn6
	 AejZOcPuNBmCE5jApruvMwCIrI1KBWPz0WOHraKQ9QdZ8WpCkFVDZLGRG/fGiXiaty
	 Gkt94fF0/jKzmoNnOCEmQ5Op7eYmNlfG66+G/a5NQdMTROI3uhc+rk0gn/2uR0sa8D
	 69qcpiiblIjnuDLhkzsY32QrA3haTt8TP4g9sYXzF6Yptcbbd276dLfdKodh8Hl5Lp
	 Q+AntfVJL1ByEL7DOByeR69cDVIZcmzqBRmd4+3rfUdSE6pNpsG5Ovz96tV289hCc5
	 I/ixbhU15S6WA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54D2kGVm93549820
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 10:46:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 May 2025 10:46:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 May 2025 10:46:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 13 May 2025 10:46:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v1 01/13] wifi: rtw89: 8851b: Accept USB devices and load their MAC address
Thread-Topic: [PATCH rtw-next v1 01/13] wifi: rtw89: 8851b: Accept USB devices
 and load their MAC address
Thread-Index: AQHbvTYAiOiM5pQabE2yluLODNCglrPP59xA
Date: Tue, 13 May 2025 02:46:15 +0000
Message-ID: <8de9dc2e2d864094b0dd123309d5f469@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <9d8f4e50-43fe-4861-973a-460bd598d73f@gmail.com>
In-Reply-To: <9d8f4e50-43fe-4861-973a-460bd598d73f@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBNYWtl
IHJ0dzg4NTFiX3JlYWRfZWZ1c2UoKSBhY2NlcHQgVVNCIGRldmljZXMgYW5kIGxvYWQgdGhlIE1B
QyBhZGRyZXNzDQo+IGZyb20gdGhlIGNvcnJlY3Qgb2Zmc2V0Lg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5
OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0K

