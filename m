Return-Path: <linux-wireless+bounces-37965-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aVkfO7/oOGrWjwcAu9opvQ
	(envelope-from <linux-wireless+bounces-37965-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 09:48:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E56FE6AD623
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 09:48:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=wPXnUcZu;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37965-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37965-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7C73300C3B1
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 07:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDEE370D52;
	Mon, 22 Jun 2026 07:46:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A6C371895
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 07:46:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782114371; cv=none; b=nq4s12sWGVzL6j45a2WR/rPy0qxfnz6LAAVCm3feGOhTAu/BVeXEQ/EnBIh+pfGANYCoV3SKAQluHY+GOdOD/yMimWG8KP+qJk+uyQFeU3VeDvdLn6C8bXIIQRL9NHp4/VzLGd4Rod31ZPPlkJu+tZmMYbSRD39CXhMs3ceFn40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782114371; c=relaxed/simple;
	bh=TSLB52M+ys/BHFQW7uWSuqoP6UxIHA+Ctbp/fOIWyHo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZuhxrS9sxHSGXi38OJZrw9cQg8gfFfrgZh9SHjopD+6AIVzk6ai0slOxHjZiGgoGNSWjR/AgB5VbvQex7XB8AvhEpBwk/OHMzEuzinNCHr3vMVBJw2oJO5Al3gAdWUVpo6n5JGFvT1Axv/owvW39nnoAQGrvOatRw2A4sV+QR3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=wPXnUcZu; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65M7jvi672368245, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782114358; bh=TSLB52M+ys/BHFQW7uWSuqoP6UxIHA+Ctbp/fOIWyHo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=wPXnUcZuk+LuQKC3QTs3TV6+7U48lJaRIkIdJ9k8MeoSQCjLMUatFDtGZcfEN89BC
	 YhgdO3DFTMeZcbXXJH2fWGylLon8vMPXCbOl1WwWR8D5U0LjfyC5mbxfDhk5Q6gY4h
	 o8fPGrGH/oPVmpR8hj0qXr1WbiUiqFCTRHJYACkXQebuaDtNT+XTbeWOmbrGBP/WH1
	 P8gAsOo0g3+5IfWMPkhYi0nu+7HPB7EmGkfEEP5+V4CcHYoJEe+d6YqqxM0vUUb4cF
	 msJyI5bNJVD728TymlWpsgLIA9tcLjsmlTdTHBUf0HyDrTrXVycKgFeym9PAPYoGuC
	 QKSMJ2dO64GWg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65M7jvi672368245
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jun 2026 15:45:57 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Jun 2026 15:45:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Mon, 22 Jun 2026 15:45:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: NIPA/wifibot disappeared
Thread-Topic: NIPA/wifibot disappeared
Thread-Index: AQHc7ceiWUwUmh0QVECGXfEz9ei6c7ZDz64AgAaJOxA=
Date: Mon, 22 Jun 2026 07:45:58 +0000
Message-ID: <c7363a78c6324d519651c7729617b725@realtek.com>
References: <a5615f2658fe31a32836d02aa0f2d69027782bea.camel@sipsolutions.net>
 <8f08a690242483a0c1026e7b006f48c9c01c6f30.camel@sipsolutions.net>
In-Reply-To: <8f08a690242483a0c1026e7b006f48c9c01c6f30.camel@sipsolutions.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37965-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E56FE6AD623

SGkgSm9oYW5uZXMsDQoNCkpvaGFubmVzIEJlcmcgPGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+
IHdyb3RlOg0KPiBJdCdzIG9uIHRoZSBuZXRkZXYgY29uZmlnLCBzbyBwZXJoYXBzIGEgbGl0dGxl
IHBpY2tpZXIgdGhhbiBpdCB1c2VkIHRvDQo+IGJlLg0KDQpOb3Qgc3VyZSBob3cgaXQgY29uc2lk
ZXJzIC1uZXh0IHRyZWUuIE15IHBhdGNoIHdpdGggc3ViamVjdA0KIltQQVRDSCBydHctbmV4dF0g
d2lmaTogcnRsOHh4eHU6IDg3MjNidTogLi4uIiBpcyB0cmVhdGVkIGFzIG5vbi1uZXh0IHRyZWUg
WzFdLg0KDQpDb3VsZCB5b3UgaGVscCB0byB1cGRhdGUgTklQQSBjb25maWd1cmF0aW9uPyBPciBz
aG91bGQgSSBjaGFuZ2UgdG8gb3RoZXINCnByb3BlciB0cmVlIHNlbGVjdGlvbiBvZiBzdWJqZWN0
IHByZWZpeD8NCg0KWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51
eC13aXJlbGVzcy9wYXRjaC8yMDI2MDYyMjAxNTQzOS45NjIxLTEtcGtzaGloQHJlYWx0ZWsuY29t
Lw0KDQpQaW5nLUtlDQoNCg==

