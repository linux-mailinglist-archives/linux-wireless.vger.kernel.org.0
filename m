Return-Path: <linux-wireless+bounces-31342-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFiGIxT9e2lEJwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31342-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 01:36:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE653B5F4F
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 01:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87F6F3019173
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 00:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5175F27FD7D;
	Fri, 30 Jan 2026 00:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="kWw3OWKm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4F327AC31
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 00:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769733393; cv=none; b=Q4dk4RPH0J0R8uhxwSEHP9FOr5byVEqmZxeuj3MC1GXcQSMdG7DyuEvaFdxgEr8fIWopRzUx+vYKdCG3q8CbA41BKfbyetU/93yh/nO76heqhmIkmrXDvElzkdFVLIWiavh1hGMP4wU6m4x5wq+49U6k+XlFnA1vDjcJ2w1qMWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769733393; c=relaxed/simple;
	bh=qoMOLflSr4o1NGmOm6eyW3UE0vzaeeBi6PmVA2QtAXM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qSHMBkQd7gti1dph6IBS50SOuDfWaa40TUuCqc0wW1ecINPr8aQeBkjyhPmGR61zNYTM+wC/TEQmtSf/zALnOnTV4bWxw6VHG/f+wNVIdhk8wpGYNCJw86WtLYXvozc+61jHDWDYb6xmeOO/rjjkjuhtBLchBZTCPtb8gJxF6Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=kWw3OWKm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60U0aQzR54085420, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769733386; bh=qoMOLflSr4o1NGmOm6eyW3UE0vzaeeBi6PmVA2QtAXM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=kWw3OWKmVgIWliiewMsptn5xCHFU5fiY+y1Thuy27zocWDQ6cbR7SaA7CidMfRc+3
	 lAYtBuIe+yXpZbq1mWkbeqJa1y+IVN0jY54CJInucNhXX5qof836aiDGTzVtO1hQpl
	 M4TKbf4d+uWnEO0vgkIZc3SxNjhWKPDO7IEHmG7xF/MN1N5Jc+8uS0kmZUYNsuvVyY
	 lRn24iIkln74Fz0ITBK6Hf0tKg5bvjs1nIYEKJxfO4ZgsF+nnQ7fpxUlka/wXZJOnI
	 aBOIK/wuC2skUDEQZJYjI16odSt0LDpuHRjI6JdnQn+AjJYK6yhuIlXb9w5nu1j7Nx
	 gKGehQvLRjBXg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60U0aQzR54085420
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 08:36:26 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 30 Jan 2026 08:36:26 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 30 Jan 2026 08:36:26 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Fri, 30 Jan 2026 08:36:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Iohann Tachy <iohann.tachy@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: Problems building rtw89
Thread-Topic: Problems building rtw89
Thread-Index: AQHckRigK2YBsPmWJU23l7X48l+K4rVp3ZDw
Date: Fri, 30 Jan 2026 00:36:25 +0000
Message-ID: <f730f3ca7b1d4fd08795831e13cc8f2f@realtek.com>
References: <CAPVS0eKn3zEyRekrQP_K3W5n5iVZ44nXkUAAE2=KkNcpq+LeYg@mail.gmail.com>
In-Reply-To: <CAPVS0eKn3zEyRekrQP_K3W5n5iVZ44nXkUAAE2=KkNcpq+LeYg@mail.gmail.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-31342-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:mid,realtek.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CE653B5F4F
X-Rspamd-Action: no action

SW9oYW5uIFRhY2h5IDxpb2hhbm4udGFjaHlAZ21haWwuY29tPiB3cm90ZToNCj4gR29vZCBtb3Ju
aW5nLA0KPiANCj4gQ3VycmVudGx5IHRoZXJlJ3MgYW4gaXNzdWUgd2hlcmUgaXQncyBub3QgcG9z
c2libGUgdG8gYnVpbGQgdGhlIHJ0dzg5IGRyaXZlci4NCj4gVGhlIFJUTDg4NTJCRSBjYXJkIGhh
cyBhIGNvbXBhdGliaWxpdHkgcHJvYmxlbSB3aXRoIEludGVsIFg5OSBjaGlwc2V0DQo+IGFuZCBh
IGhhY2tlZCBydHc4OSBkcml2ZXIgaXMgbmVlZGVkIHRvIG1ha2UgaXQgd29yay4NCj4gDQo+IEkg
a2luZGx5IHJlcXVlc3QgdG8gcmVhZCB0aGUgR2l0aHViIGlzc3VlOg0KPiBodHRwczovL2dpdGh1
Yi5jb20vbHdmaW5nZXIvcnR3ODkvaXNzdWVzLzM5Ng0KDQpBIGZpeCBpbiBHaXRodWIgaXMgdG8g
ZGlzYWJsZSAzNi1iaXQgRE1BIFsxXS4gSSdkIGxpa2UgdG8gY29sbGVjdCBwbGF0Zm9ybQ0KaW5m
byB0byBhZGQgYSBxdWlyay4gUGxlYXNlIHNoYXJlIG91dHB1dHMgb2YgYmVsb3cgY29tbWFuZHMN
CiAtIGRtaWRlY29kZQ0KIC0gbHNwY2kgLXZ0DQogLSBsc3BjaSAteA0KDQpbMV0gaHR0cHM6Ly9n
aXRodWIuY29tL2E1YTVhYTU1NW9vL3J0dzg5LTEvY29tbWl0LzYyOTc1NmVlMDIzMjA4OWQyOThi
YjM5ODc5MGQ0YTc0NWI5NTAwNTgNCg0KDQo=

