Return-Path: <linux-wireless+bounces-37084-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLvACqviGGo0oggAu9opvQ
	(envelope-from <linux-wireless+bounces-37084-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 02:49:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 995685FBC34
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 02:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D34A30A9905
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 00:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BA48834;
	Fri, 29 May 2026 00:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ngRJ/gq1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FA5C2EA
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780015768; cv=none; b=sgHiS8WWfOW7P9uM8FVGMuAybwIbozAeE3embI/gFQuDHD/tkox5I2VOiNb0hGqb8ubar6PMdHqHVu8/kkJotUzb/n636Pdrj3iQv3je27gShVFe6hOpc5ece/Rg7dRUNiaNjjebSBvueGDKjSAseql1/z35R+gkifB+Yzer6JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780015768; c=relaxed/simple;
	bh=C4j/Y7DOD94viXnIkjYNIwsN2V1IPYZcZhbwudKnFFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OvQW3AxWEShEXwBGlcE0gUokZPZewUb417EqSH+39it7TembQkfgHTPpjbO6ww/Je4XBvYWgVHCii9ugIvui37rTp2qmUkzwrglrJgRbiu0OPIgg5zPj0+kI8Asg0T1drApxKG1eDBZXvRWbaGg53jkEmXJ5YYYhQ7bsAZdcsv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ngRJ/gq1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64T0nGW813743585, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780015756; bh=C4j/Y7DOD94viXnIkjYNIwsN2V1IPYZcZhbwudKnFFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ngRJ/gq1HKPmYfeAyl+tlVxODTP3Y6A31W8F0Hnx7URaKFkDMupx5RaQLWKJ/V2f/
	 ajo34a9W1binINnRood5hvDHXKYAZHvdf49Pf0hAvI/oS446Ec7jpxT0ZhOmboGAHP
	 AYQ09pVmkX1+a5tqXm5pjvDwIFmaWaxXQl1s1uVFHE3hyRwlLui0uPpZQ14CqZqA3V
	 oYQ9nKCE+QxCd764mWOX9eX1/UnIzyM5J2DZBIpTDOPm/b7MwE+m7FXeoEuvUR8cf/
	 iC4se4iDPVUwiYsYg67NMdSu3G7ErKG1ixmDhFSPwmJehMeeyNhRVTJwYK9+Sv+ztb
	 mV+1MJnduZqCQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64T0nGW813743585
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 08:49:16 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 May 2026 08:49:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 May 2026 08:49:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Fri, 29 May 2026 08:49:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: VolcomIlluminated <volcomilluminated@tuta.com>
CC: Linux Wireless <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] rtw88: tx: increase TX report timeout for USB devices
Thread-Topic: [PATCH] rtw88: tx: increase TX report timeout for USB devices
Thread-Index: AQHc7t1ShZ8qjTK3PEC+DmEoLy0uy7YkKvIA
Date: Fri, 29 May 2026 00:49:16 +0000
Message-ID: <d789d18a06a0441bb91d956fd05d2dfe@realtek.com>
References: <Otk4rgS--F-9@tuta.com>
In-Reply-To: <Otk4rgS--F-9@tuta.com>
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
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37084-lists,linux-wireless=lfdr.de];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 995685FBC34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

UGxlYXNlIHVzZSBwbGFpbiB0ZXh0IG1vZGUsIGFuZCBzZW5kIHBhdGNoIGJ5ICdnaXQgc2VuZC1l
bWFpbCcuDQoNCldlIGhhdmUgWzFdIGFscmVhZHksIGJ1dCB1bmRlciBjb25kaXRpb24gb2YgUlRM
ODcyM0RVLiBZb3UgY2FuIGV4dGVuZCBpdA0KdG8gaW52b2x2ZSBSVEw4ODIyQlUuIE1heWJlLCB3
ZSBjYW4ganVzdCBoYXZlIGxvbmdlciByZXBvcnQgdGltZSBmb3INCmFsbCBVU0IgZGV2aWNlcz8N
Cg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzLzIwMjYwNTE4MTQy
MzExLjEwMzI4LTEtbHVrYS5nZWpha0BsaW51eC5kZXYvDQoNClBpbmctS2UNCg0K

