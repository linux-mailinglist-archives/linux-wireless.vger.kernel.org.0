Return-Path: <linux-wireless+bounces-33908-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA9tI5d9xGmTzgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33908-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 01:28:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3E732DA44
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 01:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74E533032F64
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 00:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42A0221FB6;
	Thu, 26 Mar 2026 00:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QQLqKryV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09D9217662
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 00:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774484637; cv=none; b=piUA+BtbE3+bbrlF/uTtjklLgCyhjMI4UYx6qlf431v7emVaSWLnimUDFSAo0uJbj3FObfkEngOURjRQN7ktN58F6aqjGB/UoYiXpDe5g6TxaSYLmjMFL4+QR28CTbpVPULT1/PlFQZUIM5PzNdpQ1SHvSQ4ZjkQjewoNfcmH8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774484637; c=relaxed/simple;
	bh=sHUzO0d8N3ol8v3No1BdzEBnSKWBNEncmk4+IVqOwas=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=auX4BBhg1o6m/uwNUIhV0i9GhEgH7wzhf+m5Vh5InzY4+t7LWfgHG4IG/SZBGRO1dlHQdjmNVVH8/H2zAllJwYml5+8QKlPXC/FmNOFzFbPdeaM0hnlf4EyBhujMw7ANHZ5YuqLizNA39w3T79/yeqfepbMXTQSu3nB1SCb/ECk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QQLqKryV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62Q0NoxG6395942, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774484630; bh=sHUzO0d8N3ol8v3No1BdzEBnSKWBNEncmk4+IVqOwas=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=QQLqKryVITMEMJ+BNEuk5ackNtXeX1JuSFNxb/JFbgGH4dWWsr3A5NndZUZ/pyiLa
	 qv79Xn940xehMFhdH3NFqlCNmO/Jbyuh8OmmV8AMDBWycePdLVRQbktgn+25a/L269
	 m5Q1sB94zO9G2HtySbC1u83pJfGV7UBEObTvOnyMsHCYmfQLP4E2zdOqYLyvERwsxb
	 fO6za5/fXPwy7gWVcPcMTODwhgRCgg0YkmD5nr3WLlI/bTZbuzLljdj2vwvGBsabRZ
	 9pu7zxJY6gLd8YpCuookiKluHhJZBq/gBeroFYE0tQIJP3HqqMmkQugEv7bfSuFswB
	 AtNmIHtAlOsHw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62Q0NoxG6395942
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 08:23:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 26 Mar 2026 08:23:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::46e9:fab9:b2cf:c99b%10]) with mapi id
 15.02.1748.010; Thu, 26 Mar 2026 08:23:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?SmVmZnJleSBXw6RsdGk=?= <jeffrey@waelti.dev>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: wifi: rtw89: rtw8922ae: HWSI bus lockup during RF recalibration
 on AP bandwidth change
Thread-Topic: wifi: rtw89: rtw8922ae: HWSI bus lockup during RF recalibration
 on AP bandwidth change
Thread-Index: AQHcurr3ssaqHgvFgEq3QbzjT47FFLW87FxAgAIyVoCAANiPoA==
Date: Thu, 26 Mar 2026 00:23:50 +0000
Message-ID: <f387614466ce497fb59d4ad98ef641f5@realtek.com>
References: <SnJ_b28_Uro9Xtlb2ew62uypaut_7wD44Qnmibm2Yj4FgSS7cayhZvqkK8-AXGNAc-xdwYST6E2GDCMcoZh33PjukvAsXwaqMzx8Z14_aA0=@waelti.dev>
 <8bf447cc627746cca6eb30ae283bbbe6@realtek.com>
 <uyjP590fzro7xuECRhUp6nlegi4hnWSBbrrFd-tcCcKeeKbDaoUThi7EkMNUMC2LYibyA0jaAqR7GrIchbJcGVh5CSgiGa39jMQkLq5F9QY=@waelti.dev>
In-Reply-To: <uyjP590fzro7xuECRhUp6nlegi4hnWSBbrrFd-tcCcKeeKbDaoUThi7EkMNUMC2LYibyA0jaAqR7GrIchbJcGVh5CSgiGa39jMQkLq5F9QY=@waelti.dev>
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
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33908-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,waelti.dev:email]
X-Rspamd-Queue-Id: CC3E732DA44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SmVmZnJleSBXw6RsdGkgPGplZmZyZXlAd2FlbHRpLmRldj4gd3JvdGU6DQo+IA0KPiA8cGtzaGlo
QHJlYWx0ZWsuY29tPiB3cm90ZToNCj4gDQo+ID4NCj4gPiBQbGVhc2UgdHJ5IHRvIGRpc2FibGUg
cG93ZXIgc2F2ZSBhbmQgQVNQTSBieQ0KPiA+IDEpIGl3IHdsYW4wIHNldCBwb3dlcl9zYXZlIG9m
Zg0KPiA+IDIpIHJlZmVyZW5jZSBhbmQgaW5zdGFsbA0KPiBodHRwczovL2dpdGh1Yi5jb20vbHdm
aW5nZXIvcnR3ODkvYmxvYi9tYWluLzcwLXJ0dzg5LmNvbmYNCj4gPiAgICBhbmQgdGhlbiBjb2xk
IHJlYm9vdC4NCg0KSGF2ZSB5b3UgdGVzdGVkIHdpdGggdGhlc2UgY29uZGl0aW9ucz8NCg0KWy4u
Ll0NCg0KPiA+DQo+ID4gUGxlYXNlIGhlbHAgdG8gdGVzdCB0aGUgbGF0ZXN0IGtlcm5lbCA3LjAt
cmMgd2l0aCBhZGRpdGlvbmFsIHBhdGNoIFsxXS4NCj4gPg0KPiA+IFsxXQ0KPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC13aXJlbGVzcy8yMDI2MDMxMDA4MDE0Ni4zMTExMy00LXBrc2hp
aEByZWFsdGVrDQo+IC5jb20vDQoNCkhhdmUgeW91IGFsc28gYXBwbGllZCB0aGlzIHBhdGNoPw0K
DQo+ID4NCj4gPiBQaW5nLUtlDQo+ID4NCj4gPg0KPiANCj4gVGhhbmsgeW91IGZvciBjb21pbmcg
YmFjayB0byBtZSBzbyBxdWlja2x5LCBJIGp1c3QgZW5jb3VudGVyZWQgdGhlIHNhbWUgdGhpbmcN
Cj4gd2l0aCBrZXJuZWwgNy4wLXJjNS4NCj4gDQoNClBsZWFzZSBjb25maXJtIG15IHF1ZXN0aW9u
cyBhYm92ZS4NCg0KUGluZy1LZQ0KDQo=

