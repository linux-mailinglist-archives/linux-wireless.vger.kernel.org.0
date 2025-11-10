Return-Path: <linux-wireless+bounces-28728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B003AC45768
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 09:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B74A63B48E3
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 08:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD4B248891;
	Mon, 10 Nov 2025 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="A9Npkbys"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C823A926
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764853; cv=none; b=keQQ5ZMOmb6kHyw46DIPC4BaRLlSi6rePNuXz/8uhAr4sVv2oSH4KJdIqKHoPi4rlRFew6JBlwyUwB9bGIzDD12UKWjznwQpPPs29yvfxYoFRJmDraQomzPx/vAbN+5GfosBH7RBOLet/GvlC58Fin8ppPnzYkaNz7jWxCdTwhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764853; c=relaxed/simple;
	bh=aTU1O08Yo5rbHGBb+IndHepHy4f3itsn2/zFoaOeNuA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OTE2hHH0yDPt/qGYXsaWtJDdjIZAV7A3aEtXET3dAobDDP+lETKvi75WH8z3vuRmBC+QzqE2IHH7I6rB+5h9+2Z5srx+TmTLBO7+uMYeVLf/liJJMwUbA1RKNzjF0Gl18zB2+1HkDzAcx97DofMBVRa60Cq/Morw39HKHrUoRvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=A9Npkbys; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AA8s7yP51410708, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762764847; bh=aTU1O08Yo5rbHGBb+IndHepHy4f3itsn2/zFoaOeNuA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=A9Npkbysu80GluVhVGCYJ1xIO+I+ZXa6ngeKb59BFY0i9eP3ggAS7VIoC7xg45Nt5
	 xzvw1H5/RVNqOhANZePAJKrEmVGY34vpnNankNB05RrhN7cb7KD34en+OIybQZrgCm
	 7adVS5guxuOGuls+foKZOSei+u7HtAXFVveIhMAJyWdU1PHOr6fA8RaoravCllFUSJ
	 XU/FrlMgZb/uxGaTtPSNdBG9a2KdfANPe/TrUPnd9wHRicyygTeq2/69+LIKV9oDDn
	 5k6KZJu5/nM23h4T9HfKkmcjPjP9p1tcDVr5ENn66MUGK4rquRKRvoYELNKgNWLw5Z
	 FAxHx2coNmTSg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AA8s7yP51410708
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 16:54:07 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 10 Nov 2025 16:54:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 10 Nov 2025 16:54:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Mon, 10 Nov 2025 16:54:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 3/6] wifi: rtw89: Add rtw8852a_hfc_param_ini_usb
Thread-Topic: [PATCH rtw-next 3/6] wifi: rtw89: Add rtw8852a_hfc_param_ini_usb
Thread-Index: AQHcUAC8hbhvumAy6UiZBXUs4RJomLTrnwnA
Date: Mon, 10 Nov 2025 08:54:07 +0000
Message-ID: <be77273d7015493a8f75b7fab6cc095b@realtek.com>
References: <f0021b8c-efc7-4993-b0a8-8954c682d13b@gmail.com>
 <d1032888-2a53-4c52-a8b9-6e00cd6758dc@gmail.com>
In-Reply-To: <d1032888-2a53-4c52-a8b9-6e00cd6758dc@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiAiaGZj
IiBtZWFucyAiaGNpIGZjIiB3aGljaCBpcyAiSG9zdCBDb250cm9sIEludGVyZmFjZSBGbG93IENv
bnRyb2wiLg0KPiBUaGVzZSBhcmUgc29tZSBwYXJhbWV0ZXJzIG5lZWRlZCBmb3IgUlRMODg1MkFV
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBn
bWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4N
Cg0K

