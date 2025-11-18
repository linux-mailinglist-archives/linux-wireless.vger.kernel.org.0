Return-Path: <linux-wireless+bounces-29076-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F27F9C67159
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 04:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C999F4E18E7
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 03:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE6A2FE04A;
	Tue, 18 Nov 2025 03:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="o0+cwoFk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6EB2EC081
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 03:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763434957; cv=none; b=Gw680d/a35DbXOxb8Mp9BpTHX10zdZ+kMcAkHZI8vm0iwNpqgqtuYJGq2cke2C30vDuCDoJDuTt8YqEC3LtaVbGEEkhE58uqt80czm2RQO9+3oQi/iILeHJJeKJp2B33tOVafubg7iuZBvNUcsbxegjGeTsCMWEp+ocwboCWboM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763434957; c=relaxed/simple;
	bh=yDr24AEX3sBPjsTjDuTuvr6v4cbneT8cka2iee/SLds=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CTlLe1h4yOSapwalOr5fKCAtoiaiMjDcOjzEZ54eldBGjGhD3OjUbTTLTaNfbyk4Aheodr6xEg2i3i4yyYsqIjTT4mzUozjWw44iC1V28HqRrwyTs8RIYzGh2rnSjyNEDWjAk8AXclme7HbGHZcpyCA1zcA8nzFF8y5JDRbUapk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=o0+cwoFk; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AI32VO80698409, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763434951; bh=yDr24AEX3sBPjsTjDuTuvr6v4cbneT8cka2iee/SLds=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=o0+cwoFkJmqFfZbleJws83dnzJbhM6KsiS1R7lQhGWA8UzQWy+qDGe3eSOLmDCp3J
	 Dmy6bjn57TzzwD6/mwzggWsXqvRVMCObb0hdpXPAENEqV1Lgl5YkEeQV5yxmzdeKZ9
	 uhspbMInYqvGQ/giEaXux+9cxpZbo3e357+S6e00WA3fPs7KbH3Me85ooV8rrekxr/
	 KAdaqARmoPNn6ZKtnrXjSV0TH8wqu16+fhYEl92QkhiRCQPLaFSnV2VWIuzvl3vn45
	 jWBr7DUkfjWc1cP/KuJXy4/cwqBhjpD4yng/RYpqGgiXLLr/+o4+lL/MUd0u2ANQdZ
	 2bUYGdRYQu+1Q==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AI32VO80698409
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 11:02:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 18 Nov 2025 11:02:32 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 18 Nov 2025 11:02:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Tue, 18 Nov 2025 11:02:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH rtw-next 4/5] wifi: rtl8xxxu: Fix RX channel width
 reported by RTL8192FU
Thread-Topic: [PATCH rtw-next 4/5] wifi: rtl8xxxu: Fix RX channel width
 reported by RTL8192FU
Thread-Index: AQHcVzfjMbkwLSTgKEOo+HgLaiSJBLT3v/NAgAAA6yA=
Date: Tue, 18 Nov 2025 03:02:31 +0000
Message-ID: <cc6f78a75c2746478191e6fe1537412d@realtek.com>
References: <b735b9c6-f17f-405a-8972-a7c98f3c89e2@gmail.com>
 <afd60ba6-4af8-4944-a915-4e2b814bbed3@gmail.com>
 <988bfe53bd5b42bbb411745f34114db1@realtek.com>
In-Reply-To: <988bfe53bd5b42bbb411745f34114db1@realtek.com>
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

SGkgQml0dGVyYmx1ZSwNCg0KPiA+ICsNCj4gPiArICAgICAgIGlmIChyeG1jcyA+IERFU0NfUkFU
RV8xMU0gJiYgcnhtY3MgPCBERVNDX1JBVEVfTUNTMCkNCj4gDQo+IE5pdDogd291bGQgaXQgYmUg
Y2xlYXIgdGhhdCAnIGlmIChyeG1jcyA+PSBERVNDX1JBVEVfNk0gJiYgcnhtY3MgPD0gREVTQ19S
QVRFXzU0TSknID8NCj4gDQoNClBsZWFzZSBsZXQgbWUga25vdyB5b3VyIHRob3VnaHQgYWJvdXQg
dGhpcyBuaXQuIA0KDQo=

