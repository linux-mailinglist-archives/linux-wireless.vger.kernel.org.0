Return-Path: <linux-wireless+bounces-34125-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JtHYBS/GyWm42QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34125-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 02:39:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5A1354751
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 02:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23801300D691
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 00:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0AA22370A;
	Mon, 30 Mar 2026 00:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="PWiQVE2I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C1B212B0A
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 00:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774831146; cv=none; b=au4t8gMXR+IqUBlHK5lIIPpC32djW3/jGjrgcqg351csx9ULIzTcQALEI4xCKok1UvDbsFEA4acc0jvSw+tJ+FGhITo6rRdaUXzrfvmbF6FkdeTavLfo5lGyPU+x96kVk+C6aUnqUzvSGC7xTK+Y9gedMkdcB0fpTB0jh24gny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774831146; c=relaxed/simple;
	bh=lGqrFn1yrGE4vyaFH2wD/fBXIJwzfPN9fu1HDfM+/Zw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jFoml/++IjVpxUo/4Zkn8ierRwR4qtIiqP6MKDJDJ/uQ97iwTcK+F4eFsGSojeOIKoC5gF5ZKdzP7xM4+Kt7LZvg6KFdYoBTuxwbQIL6x1d4cGd7Pb+jTqPxZiuSMzlitYZKofcuUPbwCB7Lqp6fR5lNDC85ae7XU7Oz1qI78rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=PWiQVE2I; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U0cINN14173076, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774831098; bh=n5/8iiWIBfE59eh+yphNk9yh114T+Qe0j0ELOQPoR3M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=PWiQVE2IpV10Kc1vkKgNSdpM/AXU26lb93auzz++876MqSVrqJXEh5rz52CCXzLd0
	 aduUlUkFQ5v3j8zQLFJ4u+5Fpdj8sb7Weo5uZRm6VyymBDvwvypN3IdxV+IVSlnEdM
	 BebAOj4VJRgVpwuovn/x18XHVVJBz1d986M8P1jhX3/RTZKPiMPkZMAJ32CcPvjTLX
	 bHUCoEJ6nestb2m9feILBeB1zVA5HObnjJZ2corMcxrcamN6s3Z8v08Xm5tU4+KiGB
	 E7abs7zVZ7SoLtlqWM5xM7KYVrjHOBkS55XOUCl5rR0opGXXexu7fMbY1Nl2eoUz2a
	 o2PO9OunA3Qow==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U0cINN14173076
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 08:38:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 08:38:19 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::46e9:fab9:b2cf:c99b%10]) with mapi id
 15.02.1748.010; Mon, 30 Mar 2026 08:38:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Lucid Duck <lucid_duck@justthetip.ca>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "morrownr@gmail.com"
	<morrownr@gmail.com>
Subject: RE: [PATCH v4] wifi: rtw89: usb: fix TX flow control by tracking
 in-flight URBs
Thread-Topic: [PATCH v4] wifi: rtw89: usb: fix TX flow control by tracking
 in-flight URBs
Thread-Index: AQHcvry9Yiq3V1R+Y0SQc94MB5ta6rXGPOag
Date: Mon, 30 Mar 2026 00:38:18 +0000
Message-ID: <5c6bb05e4e684fa3adb56ad6e9cda98d@realtek.com>
References: <20260323233347.158745-1-lucid_duck@justthetip.ca>
 <202603281411.62SEBByK43790225@rtits1.realtek.com.tw>
In-Reply-To: <202603281411.62SEBByK43790225@rtits1.realtek.com.tw>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34125-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,justthetip.ca:email,realtek.com:dkim,realtek.com:mid]
X-Rspamd-Queue-Id: 5B5A1354751
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Lucid Duck <lucid_duck@justthetip.ca> wrote:
>  usb.c | 20 ++++++++++++++++++--
>  usb.h |  3 +++
>  2 files changed, 21 insertions(+), 2 deletions(-)
>=20
> diff --git a/usb.c b/usb.c
> index eb489df..6f57788 100644
> --- a/usb.c
> +++ b/usb.c

You must use kernel tree to send this patch as before.
I'd ignore v4.


