Return-Path: <linux-wireless+bounces-27998-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE102BE5FD2
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 02:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BC654E1A24
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 00:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1132B9BA;
	Fri, 17 Oct 2025 00:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QQ62NopO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D74168BD
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 00:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760662111; cv=none; b=u11Xs6IUfMwyORmE0eG8TYmkUGdfXr9GeR+WS+v/goFmkt9Uoerno3gdfxzgxrMK8fIJ3wDSpHixs03OlQXlhZln57CEstu1wBWpGReXUTvVU/c2rV5XPONV+GbUBxe77fMS3dzWxH0nqyQdEnKlfYHzHXbaTF//LQq8hoYMkPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760662111; c=relaxed/simple;
	bh=05zMPy732cFWR7+H1klUmEgoQZElm6YIZ+pWkTrvMt0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kmXbgLGFZbC89WwgGO7M4GdBhZdmUN2GCToTPg18rEU0Rjzhx7ks6ktImTUs9Q4MfaJFJk96dJVmAsp08lpJ5S2d/gNStWrZljTDwn5Atpgj084PqJ3g/1gTHQ/iiwfLi6FV49gXQDQmSTdS+BKDLmiFBwnrIbPsMvs8DUpkds8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QQ62NopO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59H0loalF3577994, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1760662070; bh=05zMPy732cFWR7+H1klUmEgoQZElm6YIZ+pWkTrvMt0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=QQ62NopOBe2nfRE6jk/UT7Po/lFf7d0XCvVMRiDk89LheIPtCAgRdt13ed8qhtHWY
	 13EfzRjmERxxji7BNWk6+QZnJ9I793AVH8+YmbLjMLkssTIat3xJwqvi7AisN0T+Xg
	 Lbdwe0pKxLzkcyxD5FezK4OOLIte+D8r5AJxC2YBH7hgkHABX2hiIBQ+2p1l7cWbZt
	 RC24PDltCT0us4lIVJZOUeqy5ANwLJrvQW6RUfwIwPC0SgRHuHw1tA9PguU3At196Y
	 lxfmm4kaM2IyVTPVS7E34JCXMPI4BDt4AgqUVycQj91X5U4eW0PpMxnW3UDdXUqEpD
	 Kozxl0LF7deug==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59H0loalF3577994
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 08:47:50 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 17 Oct 2025 08:47:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 17 Oct 2025 08:47:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Fri, 17 Oct 2025 08:47:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Samuil <samuilsgames@protonmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: RTW88 USB Wi-Fi Adapter (8822BU) Disconnects and Fails with USB Write Errors - Status -71 & -110
Thread-Topic: RTW88 USB Wi-Fi Adapter (8822BU) Disconnects and Fails with USB
 Write Errors - Status -71 & -110
Thread-Index: AQHcPuR0y/3ltR3JykSB+vR7Nr9eULTFfwPw
Date: Fri, 17 Oct 2025 00:47:50 +0000
Message-ID: <9d4086b0e8134084a8bb7800db56db2b@realtek.com>
References: <zjR8G0R1ZUFe9h8_ibO-LWc9OOJyMThA9jp9ftYbETLG3IN0cHPvhCAaC9ypGKPbapsbzTH5VqnDhFcX93GkwnG1BEyETplFQmRiGGshBz8=@protonmail.com>
In-Reply-To: <zjR8G0R1ZUFe9h8_ibO-LWc9OOJyMThA9jp9ftYbETLG3IN0cHPvhCAaC9ypGKPbapsbzTH5VqnDhFcX93GkwnG1BEyETplFQmRiGGshBz8=@protonmail.com>
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

U2FtdWlsIDxzYW11aWxzZ2FtZXNAcHJvdG9ubWFpbC5jb20+IHdyb3RlOg0KPiANCj4gS2VybmVs
IHZlcnNpb246IDYuMTcuMyAobGF0ZXN0IHN0YWJsZSkNCj4gDQo+IE1vc3QgcmVjZW50IGtlcm5l
bCB2ZXJzaW9uIHdoaWNoIGRpZCBub3QgaGF2ZSB0aGUgYnVnOiA2LjExLioNCg0KSXMgaXQgcG9z
c2libGUgdG8gYmlzZWN0IGN1bHByaXQ/IFNpbmNlIHRoZXJlIGFyZSAxMDArIGNvbW1pdHMgc2lu
Y2UgdjYuMTEuDQoNCj4gT2t0IDE2IDIyOjEwOjA2IGJhdGNvbXB1dGVyIGtlcm5lbDogcnR3ODhf
ODgyMmJ1IDItNDoxLjA6IEZpcm13YXJlIHZlcnNpb24gMjcuMi4wLCBIMkMgdmVyc2lvbiAxMw0K
DQpUaGUgODgyMkIgZmlybXdhcmUgaGFzIG9ubHkgb25lIHZlcnNpb24sIHNvIGNhdXNlIHNob3Vs
ZCBub3QgYmUgdGhlIGNoYW5nZSBvZiBmaXJtd2FyZS4gDQoNCg==

