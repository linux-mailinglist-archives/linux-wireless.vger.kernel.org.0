Return-Path: <linux-wireless+bounces-38887-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mlwaCuvyUmqrVgMAu9opvQ
	(envelope-from <linux-wireless+bounces-38887-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 03:50:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9C474376C
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 03:50:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=HgyRAaNV;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38887-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38887-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F27693006B20
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 01:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EDC331A7B;
	Sun, 12 Jul 2026 01:50:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1557233263B;
	Sun, 12 Jul 2026 01:50:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783821029; cv=none; b=eFp9WCeOZhvDPsu2oUraN9M5NgVFXTlo2MdFq9gpewr19mDVhP3eCfd/DCnZ7MlT5PSAv/nvVdwxM/T1SppemUVZXXNoECiUitWWmtpxPhBrgb0q17xbBLcPzkqQXS1LyvmkrbLdtbDwWIvtKa8cyVkpAXnvGuv5fwsd7/KTuNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783821029; c=relaxed/simple;
	bh=aCAF70fjdQnvz48T1GJBIN96I7orcJxHxmUMAP6Ci/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RgZs8GzvtdorjRvRp6N1EY9c3W2TLnatVJCwZM3OaAzy8uMPsW3aogeu2vkkoMvxPMF8cUgN8JWQdgjyqbvpB/iWiNOaeyAsNuq1nDQiHVWKTxJcBvGSrh26yjksnxxG5f+YNCNqk5x/lGbRKKgjDfYvCykZVdt4fKs+y4igyQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HgyRAaNV; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66C1oExmD507499, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783821014; bh=aCAF70fjdQnvz48T1GJBIN96I7orcJxHxmUMAP6Ci/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=HgyRAaNVY2ZOi7JS/E+jLU940lrGGjofl4UbF1LkUe3wtw6V0Hfyu7MCg4btDLMWl
	 +j54+sYMdCWHJkcHKrOzJ27H1iWsWwUEglreTlNfqAjCJGGSxZ0oqpsz0RsOlbvK+b
	 +RAq8BDObm08/YXMszeni29MXfnLwdsHLxenHtLaZl1BWJszVgfQgVRWHr7bAl0L5Z
	 WKdU1FHwN95bIzQgCFAuS9PyZpZcahivNfN2SBr7xpk6e/tluwIiPD5bpiADsXSHvc
	 Xl6SRxpHAl5yCER/jsHqnQP7Sgdya54lqDGVMgX6KBkvLPAGVxmIgUqGlr7Gk5D1f2
	 ve8o0IkmWHbhA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66C1oExmD507499
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 12 Jul 2026 09:50:14 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 09:50:15 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Sun, 12 Jul 2026 09:50:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: 8852au: Add support for Mercusys MA72XH
Thread-Topic: [PATCH] wifi: rtw89: 8852au: Add support for Mercusys MA72XH
Thread-Index: AQHdEBhgIKLF4XCqRUOEqFLTRQ13TLZpIRHA
Date: Sun, 12 Jul 2026 01:50:15 +0000
Message-ID: <9bfdb983981d4bb98a4692ac6f1711f6@realtek.com>
References: <20260710030055.57438-1-abhishektamboli9@gmail.com>
In-Reply-To: <20260710030055.57438-1-abhishektamboli9@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38887-lists,linux-wireless=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:abhishektamboli9@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:from_mime,realtek.com:dkim,realtek.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A9C474376C

Abhishek Tamboli <abhishektamboli9@gmail.com> wrote:
> Add the ID 2c4e:0124 to the rtw_8852au_id_table to
> support the Mercusys MA72XH usb adapter.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221738

Not sure why I have no permission to access this. Maybe it gets broken.
I'll wait a while to see if people will fix it.




