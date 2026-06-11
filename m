Return-Path: <linux-wireless+bounces-37664-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LKrtFxF9KmrZqwMAu9opvQ
	(envelope-from <linux-wireless+bounces-37664-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 11:17:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B07E167052B
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 11:17:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b="eLYORIf/";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37664-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37664-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75DE9325FA9B
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 09:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114963A254C;
	Thu, 11 Jun 2026 09:12:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB9B374E7D;
	Thu, 11 Jun 2026 09:12:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781169147; cv=none; b=BedllUG2DHLyyWGUVY/LFs9XqAVu0sRJpWBNGHVFAHBdaIfTCJY5bowr0AhrLtTCztlsa4BP1c9cK7s9N/sKoPpcl0/T48wd5McTiKx2Z77iyVtFx9cjlrvVwXBthGsrooqnsoMM7n3YlFbmJQmBVJiFVfAmThu6cBFfg4EbpFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781169147; c=relaxed/simple;
	bh=tpIWT8a+e+yaRPdk5xyXngd/dJCe5Glj1lZfp+rwbJg=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=le1vJqjAV5gmG76kYs37ssNzGJbKnUSr6MhGVkkXjwHIgHDUxKuyzt2XntWpkJETrSKa48DCl/kWQ24FVjwO4nibqiMuE4T/P81/Ic+7uktjTMhblSS8k8iQGuZiWimdZ8t8uR91w5BqMEDUy3nQQ5k9IyrH4IQVrOr63csfLGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=eLYORIf/; arc=none smtp.client-ip=54.207.22.56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781169120;
	bh=tpIWT8a+e+yaRPdk5xyXngd/dJCe5Glj1lZfp+rwbJg=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=eLYORIf/FdLD+sA9WoljriOGzkvKTBZ9X8lPCZeTojbcDSjTAYK47Pxe0kzLEIpDH
	 z3fK01QReHHwBjNr9cU14N/n4lAmnAeiw5CQXoXMao9ObhJqryrYKnD3P2gtijwDHN
	 tP/5cqnEiXbCBgHPeEdd5juHmMcZAoErcsuhOHCg=
EX-QQ-RecipientCnt: 6
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqSYScHvcdjMLM1Y+xZqzQ9cC+I23XEKuwU=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: NLvNdibSFyjc+s3tB4uHt7g1dgpJxs4+I/vSfKNLFHc=
X-QQ-STYLE: 
X-QQ-mid: lv3gz7b-6t1781169114t2a4545c1
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?UGluZy1LZSBTaGloIChwa3NoaWhAcmVhbHRlay5jb20=?=" <pkshih@realtek.com>
Cc: "=?utf-8?B?bGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3Jn?=" <linux-wireless@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?ZGlhbl9zeXVhbjAxMTYgKGRpYW5fc3l1YW4wMTE2QHI=?=" <dian_syuan0116@realtek.com>, "=?utf-8?B?5Y2g5L+K?=" <zhanjun@uniontech.com>, "=?utf-8?B?6IGC6K+a?=" <niecheng1@uniontech.com>
Subject: Re:RE: [PATCH] wifi: rtw89: fw: correct rtw89_fw_h2c_default_cmac_tbl_be()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 11 Jun 2026 17:11:53 +0800
X-Priority: 3
Message-ID: <tencent_222927A16FE544771FBB4342@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20260611082021.46650-1-guanwentao@uniontech.com>
	<60dbac65771f46ae85efb922dd9f319e@realtek.com>
	<1017648a65ec4b139b76e2eb7583da26@realtek.com>
In-Reply-To: <1017648a65ec4b139b76e2eb7583da26@realtek.com>
X-QQ-ReplyHash: 2801353395
X-BIZMAIL-ID: 2180884400756276887
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Thu, 11 Jun 2026 17:11:55 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MAX2iJCxWiMT9iUGkXYtqJ2BVYDtx8fcDmkm0KhAm/zDJOF3g8Pv9qBm
	0R4+U5kKe8P4rbYpNX1v0WO8irORf0yPGZck+KnmPVDBYZiKEo917n9PExhJI9aBBuEY8zm
	Xp6i37qNXQr8cW1fUBehGvVvGGG0SVpi8w1x27LvuRu6EQn8AEf0F0+062Z68Af5BUQx6IE
	GXu+lz6q5RYoHp2gIICWSsGJo/a7kQyeVSHNO1NYrB9Zv828EWRBaFJB5gSz4/u/G0uzl8C
	TGjLjh5GdbaeolL68BKyvEl+AcWut7R8mQzrXGInwYIJ4Lnb6PheQMYK0BZIivvHOHJ06i+
	3TbTN2J/xOdhokjsUqQZPw3cz5lsXE+0D3/EN7DpjTa+SX8UoiDHVL88rKWhJe4rO/uUa+I
	p666h9hZyyi/E0TgECuYObXUUwlfva1pyyZrVKdFnTkh/6AMWHGuOFueOmUqyMD7xLhJgTY
	8b/1Xq5ZsAL+ksjCEDP1l+Y5VIxHzX5QO0YpSgHSxaEg0IV7XpLOSjYjt5jHgS6KTKtJkC4
	tIZV00bnS+DZyVQNLuF7wdApGXF0D7hojsOdfWl9l9YBpAi4w+FsECxf7qc0MdRnGgDjJsG
	yPeywEiwrazIf4iNidrCNvjhgGXSAdlmd2xXhllmI3/nU2+QKQDW8QuHTQuPFSkvZFtjwi7
	JjLUGYSoS644aqYY7fQ1rEJF0DtwMLGLJqwBNoVRSGAwCOzkEzOK43mJcnYOvh+GO/Vp/Td
	cd6HvSWvnA/bBWUq5ij5fo0+4FchzD+T2Nwuvi6ecvr0riSneyDPqTyS6bnI8wCU2DNw82P
	hif8iGu8cGw/40hXi/aJ+gDpO5n4oxqzmMymIrszTy9WgRtZ0mG/63w0vLgW3fS8ruCgeqf
	dZwDsLujlvjWjyelgkBsVcCs44GI0ZAgbbFoyCO9JraVQLynoMaupF6qqFO9RXx7mo6XCxM
	bAM+DWQy89bLjZ5QGcAj6LUeuau1QXNGVEpqfCm4voviuD9VpLJoPEYA71IBhMnne8OztHV
	butWEHjkUi0Lbv1OzbfaHH7zvCJ3vmZPACE3OdklE8vhIa7B/83vmXLKa3CKr7Yrdxwjsx+
	+GtYKy2m9Ohj7SEUMBLXXZqyug9piKAEh1FRaBoAyCmPS6IgBw8Mlp5elycza3qLxEXnhuA
	s6G5azBJ348YKxEtcVDzOcC6bA==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	TO_EXCESS_BASE64(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dian_syuan0116@realtek.com,m:zhanjun@uniontech.com,m:niecheng1@uniontech.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	HAS_X_PRIO_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-37664-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:dkim,uniontech.com:email,uniontech.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:email,vger.kernel.org:from_smtp,qq.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B07E167052B

PiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4gU2VudDog
VGh1cnNkYXksIEp1bmUgMTEsIDIwMjYgNTowNiBQTQ0KPiA+IFRvOiBXZW50YW8gR3VhbiA8
Z3VhbndlbnRhb0B1bmlvbnRlY2guY29tPg0KPiA+IENjOiBsaW51eC13aXJlbGVzc0B2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IERhdmlkIFlhbmco
5qWK5YW46LuSKQ0KPiA+IDxkaWFuX3N5dWFuMDExNkByZWFsdGVrLmNvbT47IHpoYW5qdW5A
dW5pb250ZWNoLmNvbTsgbmllY2hlbmcxQHVuaW9udGVjaC5jb20NCj4gPiBTdWJqZWN0OiBS
RTogW1BBVENIXSB3aWZpOiBydHc4OTogZnc6IGNvcnJlY3QgcnR3ODlfZndfaDJjX2RlZmF1
bHRfY21hY190YmxfYmUoKQ0KPiA+DQo+ID4gV2VudGFvIEd1YW4gPGd1YW53ZW50YW9AdW5p
b250ZWNoLmNvbT4gd3JvdGU6DQo+ID4gPiBCRV9DQ1RMX0lORk9fVzJfUFJFTE9BRF9FTkFC
TEUgaXMgZm9yIGgyYy0+dzIsIG5vdCBoMmMtPncxLg0KPiA+ID4gVGhlc2Ugd2lsbCBjYXVz
ZSBoMmMtPncxIHdyb25nIG92ZXJsYXAgYnkgdzIgYW5kIHcyIG5vdCBpbml0aWFsaXplZC4N
Cj4gPg0KPiA+IFRoYW5rcyBmb3IgdGhlIGNhdGNoLg0KPiA+DQo+ID4gPg0KPiA+ID4gRml4
ZXM6IGM3MzYwN2IzYThlZiAoIndpZmk6IHJ0dzg5OiBmdzogYWRkIENNQUMgSDJDIGNvbW1h
bmQgdG8gaW5pdGlhbGl6ZSBkZWZhdWx0IHZhbHVlIGZvciBSVEw4OTIyRCIpDQo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBXZW50YW8gR3VhbiA8Z3VhbndlbnRhb0B1bmlvbnRlY2guY29tPg0K
PiA+DQo+ID4gQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0K
PiA+DQo+IA0KPiBUbyBsZXQgc3ViamVjdCBjbGVhciwgSSdsbCBjaGFuZ2UgaXQgdG8NCj4g
IiB3aWZpOiBydHc4OTogZnc6IGNvcnJlY3QgcHJlbG9hZCBmaWVsZCBvZiB3MiBpbiBydHc4
OV9md19oMmNfZGVmYXVsdF9jbWFjX3RibF9iZSgpICINCk9LLCB0aGFua3MgZm9yIHlvdSBy
ZXZpZXcuDQoNCkJScw0KV2VudGFvIEd1YW4=


