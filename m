Return-Path: <linux-wireless+bounces-37645-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kThOD0IIKmpZhgMAu9opvQ
	(envelope-from <linux-wireless+bounces-37645-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 02:58:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A08F66D927
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 02:58:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=OpFabeo6;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37645-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37645-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CCDE30DB1BA
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 00:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E816B35893;
	Thu, 11 Jun 2026 00:58:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ACC1519B4
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 00:58:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781139519; cv=none; b=CVikiKnNNGb7ItJn7TMWINkxr1Eo7G+d8L3yr3qR2mEbdmuk/htE92AC5RFs0SbznOPPq45N44N6Zf9brqNC9SuPbrecQdrn+LRoPIAbXoxLMhHaa1LO7GPG9UytjGvGdBWKNRgAyCs9gXbtKUFhCiAlZQNY356eIp11ddJECjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781139519; c=relaxed/simple;
	bh=ujO7byPJ5iV5Dx0y5GseZHYqm2h8jQBo0lahwfVBqCU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ax6eZN7mfMaBNas9j5TZdxQ8iZiRUWhfJIDajodPlZu7CpmUtKOUVcyUWkzRdymTMtE9ofcsdZZ/L4ZOiMC4bCRPLUTVVaQCFpYSTHnuFDo7N2+vcyiKT9Wr2Z42aTjPuZ6em9evAeK6PW4/WTJ7h9Ohsu8OCQsueQyGV0z5uEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=OpFabeo6; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65B0wY1P11497015, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1781139514; bh=ujO7byPJ5iV5Dx0y5GseZHYqm2h8jQBo0lahwfVBqCU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=OpFabeo6j4ypEQU9/JGQornGyAyJxIeRZSMMEsX3DEJa9aCpeXEQDztrQ7X8Kjbcn
	 //NtpPt0YUhZbmcXEUX5cT4zQyyef41NG/Tc1sWh9SKnlStmTrLKKretJHOlGfjwfS
	 QMdhtS4uYWCXpZGTo3bhjwK3uwDA+h+XfW86RCzi4wSvLVUDO5J6GshMLF5nUKvdJu
	 GLbdt8/6Fema6Ui14xg4FK0mMC6uTptwamGXlYUEUQ6GRL/fbLbxkjmsAncfarAQPr
	 iVEEsggY8zGyoqw+M0S2K/5RLk6anocKaqBbEUlxyY4Y7GZLrdF+DhkNE1wtNgAB0y
	 U558O8gelSPjA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65B0wY1P11497015
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Jun 2026 08:58:34 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Jun 2026 08:58:34 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Thu, 11 Jun 2026 08:58:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 2/2] wifi: rtw88: 8822b: Don't process RF path C
 in query_phy_status_page1
Thread-Topic: [PATCH rtw-next 2/2] wifi: rtw88: 8822b: Don't process RF path C
 in query_phy_status_page1
Thread-Index: AQHc+NlmI5RszDDEn0+/+c7N19D81LY4iRUA
Date: Thu, 11 Jun 2026 00:58:34 +0000
Message-ID: <0685e76052aa4fff87a95ee2465e5d7c@realtek.com>
References: <ee30b95f-bc68-4711-9b15-cf5fd23c3c48@gmail.com>
 <9c4beb36-2954-4db0-844a-74ba5eacf21b@gmail.com>
In-Reply-To: <9c4beb36-2954-4db0-844a-74ba5eacf21b@gmail.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rtl8821cerfe2@gmail.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37645-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A08F66D927

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBSZXBs
YWNlIDw9IHdpdGggPCBpbiB0aGUgbG9vcCBpbiBxdWVyeV9waHlfc3RhdHVzX3BhZ2UxKCkuIEl0
IHdhcw0KPiBwcm9jZXNzaW5nIGRhdGEgcmVsYXRlZCB0byBSRiBwYXRoIEMsIHdoaWNoIHRoaXMg
Y2hpcCBkb2Vzbid0IGhhdmUuDQo+IFRoZSBvbmx5IGJhZCBlZmZlY3Qgc2VlbXMgdG8gYmUgdGhh
dCB0aGUgcGh5X2luZm8gZmlsZSBpbiBkZWJ1Z2ZzIHdhcw0KPiBwcmludGluZyB1bmV4cGVjdGVk
IHZhbHVlcyBmb3IgUkYgcGF0aCBDLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBT
bWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWgg
PHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

