Return-Path: <linux-wireless+bounces-18679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A72FDA2E20E
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 02:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535AC164AC6
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 01:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA6217BCE;
	Mon, 10 Feb 2025 01:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="eBZMRE7C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D58179A7
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 01:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739151429; cv=none; b=n2kDscWsBs844Z5S4zZmQ4Xk90ue82kNDeHSlcm7US26VPVoCfGTbdmGsteRrOSV0lkQm+tQOPUxlEHRwGDTAFWdNmk8RLxmM1C0Ee61JOqmECyAm3mYI5yhx5cMSjaE32IpPZGfrIgvgDtYy3pjtyA80EfNakLrTXlUiA0ppiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739151429; c=relaxed/simple;
	bh=zCwpLjfrRaf5/nDzVCauNFxxsYr0x/Puw2+QlLHT+UQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G5KqxhbJN8FGueqqVvQoA7VgmRpwhrtUVljPZtNedGT/IXWfucvaj7tjWIlXfr4kIbYP4mgsyyXKqLpK1WZuxJXMYcn2wTADbl/HKFLOBfxnl2lTM0uFFCnBSWjmN6JR9h2ADDbnrGDDJeUbhxACBRslTBIlLrDmv31U12YXY/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=eBZMRE7C; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51A1b2xvD1414669, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739151422; bh=zCwpLjfrRaf5/nDzVCauNFxxsYr0x/Puw2+QlLHT+UQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=eBZMRE7CiJgU8eM0u5hvw9/0GVoYsJPDqSlliJB1g7R6CwfuCAl3TsFjzARTbGfWp
	 XvxP6TLQPWqqqwdtg8V3WVPd6erIxKnPpfGhfBZYK2VXq8ezqUsPMMq/hCgJ1hU/St
	 +BWaG/omH8gqlQt/ubvUc0d613r4o+yx9IKvsdR/rYxkHaTh9MUKWjA2BR/A2BnGhb
	 NSQb7Mf+L3cORSf9GiaN5xRJD5tflJFvNyUlyYRtVjQcyefGaFQb3OzrY51/F0NoA3
	 AWdOIm5OYpBE+XL6PPz3t85YggzKdbrsy4UQGzCMvwFgRjSiIKe0pvmRbbij3JCxOU
	 pcaDrlUbWauyQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51A1b2xvD1414669
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 09:37:02 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Feb 2025 09:37:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 10 Feb 2025 09:37:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Mon, 10 Feb 2025 09:37:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 7/9] wifi: rtw88: Rename RTW_RATE_SECTION_MAX to RTW_RATE_SECTION_NUM
Thread-Topic: [PATCH v2 7/9] wifi: rtw88: Rename RTW_RATE_SECTION_MAX to
 RTW_RATE_SECTION_NUM
Thread-Index: AQHbdzRZwZ1V6/ut20adw4S1nfhei7M/ygzw
Date: Mon, 10 Feb 2025 01:37:02 +0000
Message-ID: <f2a1908f45ee41e496a79f1ff8c3abd1@realtek.com>
References: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
 <5a1c5a46-8ebb-43b0-9ab1-b78e2a22b3d2@gmail.com>
In-Reply-To: <5a1c5a46-8ebb-43b0-9ab1-b78e2a22b3d2@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBJdCBm
aXRzIHRoZSBtZWFuaW5nIG9mIHRoZSBlbnVtIGJldHRlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpBY2tlZC1ieTog
UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg==

