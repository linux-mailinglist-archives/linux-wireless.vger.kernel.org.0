Return-Path: <linux-wireless+bounces-39128-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kD1jGRImV2rGFwEAu9opvQ
	(envelope-from <linux-wireless+bounces-39128-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 08:17:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BC075AE73
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 08:17:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=IXAPSWNl;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39128-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39128-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24A953011BD7
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 06:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0451FECCD;
	Wed, 15 Jul 2026 06:17:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E085F1DED42;
	Wed, 15 Jul 2026 06:17:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096255; cv=none; b=PQCw8IGu1SFugHCUKybshklwMvPJv8LbqeZj5xG9VN/wTjtZ2GCpzSLwPyejeUPtpFaEFvZsu/G9VriehOH28Oxah/YK6AzpkXFi9rhQY212RRp8W5zkYko5aiCyCexEvMAYIIgdLywjHdCDuK8tJHKp9V2M0GAxW+rQD3jJKiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096255; c=relaxed/simple;
	bh=ylT8eboS7UiIP4o5dRyaD5CxYLTA07IXf2uQLxkCRY0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hdGz7YfIdHd/HYxWsWCizxP/T5tAvsYsJXkowljgDHVp0OCXWMhRSP5kYyWdP6nLZErIy/wrJDZsAAf+9NWqm4jUU+B1COEgklY6G/6OEotaLF+bgB2C1Z1biOj8ZrYbD5zk5p/YSCqR9Ubd0jDOzQqXcVNMaw2fAAn3l7DmH/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IXAPSWNl; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66F6HA1202661030, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784096230; bh=ylT8eboS7UiIP4o5dRyaD5CxYLTA07IXf2uQLxkCRY0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=IXAPSWNls9xOJH1RKOyEnGIlIEPFed+2dI0K+6zk4s7yH3MODTks9jwZbvTJmUp4H
	 vqR5DGxI8xXtMoMXMJx7gZKDYVaFTdCvmBISDyf3d71V49LM09Q8TCYjjU5AIGOFz/
	 vcxFz0RMnSIHOCGX+a7BmUwRwVxhBWq2kfED+jCTmLY5k4PoJGlUQWZL88P+ykJBPH
	 dROT4Ebl+Hb+AArokfhlm2AHkKiyHJJWtVefGz2BKpByZDnONOKncGtk7OaleFiBto
	 M+s1mHLgzcpYnz9z7La1fXeGZMF93AHCU0Wcbzk/nxhlXFgMybqomYlTjKNZI2eJk/
	 Gd2s7/vd/bOQQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66F6HA1202661030
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Jul 2026 14:17:10 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Jul 2026 14:17:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Jul 2026 14:17:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Wed, 15 Jul 2026 14:17:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "zhaoguohan@kylinos.cn" <zhaoguohan@kylinos.cn>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: wow: fix unsupported cipher debug messages
Thread-Topic: [PATCH] wifi: rtw89: wow: fix unsupported cipher debug messages
Thread-Index: AQHdFCBm0OKp5G6Dcke0LW4uT1LDObZuGqUQ
Date: Wed, 15 Jul 2026 06:17:10 +0000
Message-ID: <c2c180a2c933495796a4917ebe39a518@realtek.com>
References: <20260715060813.476245-1-zhaoguohan@kylinos.cn>
In-Reply-To: <20260715060813.476245-1-zhaoguohan@kylinos.cn>
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
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-39128-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:from_mime,realtek.com:mid,realtek.com:email,realtek.com:dkim];
	FORGED_RECIPIENTS(0.00)[m:zhaoguohan@kylinos.cn,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1BC075AE73

zhaoguohan@kylinos.cn <zhaoguohan@kylinos.cn> wrote:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
>=20
> Correct two WoWLAN debug messages to say "unsupported cipher".
>=20
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



