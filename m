Return-Path: <linux-wireless+bounces-38537-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 16lTKFYcR2pKTQAAu9opvQ
	(envelope-from <linux-wireless+bounces-38537-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 04:20:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FADE6FDE39
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 04:20:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=Xz4gfLtA;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38537-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38537-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9CD003001F86
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 02:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8A9242D6C;
	Fri,  3 Jul 2026 02:20:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2411DE4E0;
	Fri,  3 Jul 2026 02:19:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783045200; cv=none; b=GZBoZxZH1eKDHpDQZWhMxkXfwlqp9sDk9apLXW641vNw1tN4qJbpBc2RvpFQ3sEjDqIj6aNlKwxN8HBNBvARwBoZOxaxkF97JdfClIrwDZ29QlMpwI8rCBHLkKMbOR9uV9FkbfpsPL1LMTQ1sCIGMdhk3eAJvRD4bDmC8NSL/3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783045200; c=relaxed/simple;
	bh=UCFNc6Cad1hcYKM6Adj5c0Yg6fpZGElEePq8RXYkKX8=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=HvnJKNO3A5pipB/zECKLAn1WvW4RE937lugcpNp6/akZDbUThxHCx1MvxSn7te7fQ1JSHSvIu0SCdIL7eipDXsoOKXjrubTT5RslRDvdvKLppe6bf1mBWepL9goco3SRJgaquzBEprKk2JKgjWZTUvHIbQHO6/8SJMJ+2zMZ3m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Xz4gfLtA; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6632JsrM62383288, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783045194; bh=O0oBdiyNfZVjoTizLZNk4aJnfht9tFJPmB94C/eIcRE=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=Xz4gfLtA/rrOAkGBQHRRlqWpQLumJq6+CYjSBflFXEya4/S9CfdxOhUpTtBntDBKn
	 eg1worQB+qAK/s//s9JinZLuVe19uyU6Yue0vDu4DdyzdaFL/frVaSate6kI+Kp9hE
	 pRXLmZYGnoMsKwLJgGu6AKPcMEwqZz/XiTZSPeJ2hiV/XNiSXgNtBCw+EuwMU8vsnM
	 /5I7yNwgqtkKkxkWa8XYIj8tzOisogUpf5Ms3Q07yATdV0hsR17FoBaxE4QPfFuwu4
	 UMm5TlUffxcKlhRnrU/wajmXdaMoBPaw333e6p4ECEF7A2Y1W7FZJyLim7cUg9BK8c
	 ShAKMr3s/okug==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6632JsrM62383288
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 10:19:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 10:19:54 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 10:19:53 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Jul 2026 10:19:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dan Carpenter <error27@gmail.com>, Kuan-Chung Chen
	<damon.chen@realtek.com>
CC: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH next] wifi: rtw89: debug: fix off by on in rtw89_ppdu_str()
In-Reply-To: <aia25i0ds3B6QF6c@stanley.mountain>
References: <aia25i0ds3B6QF6c@stanley.mountain>
Message-ID: <70d4464e-8878-4049-a7b2-61e25cddab00@RTKEXHMBS03.realtek.com.tw>
Date: Fri, 3 Jul 2026 10:19:53 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38537-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:error27@gmail.com,m:damon.chen@realtek.com,m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:kernel-janitors@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:from_mime,realtek.com:email,realtek.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,RTKEXHMBS03.realtek.com.tw:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FADE6FDE39

Dan Carpenter <error27@gmail.com> wrote:

> This > comparison should be >= to avoid an out of bounds access.
> 
> Fixes: 419ed7f4a053 ("wifi: rtw89: debug: extend bb_info with TX status and PER")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

1908534deb53 wifi: rtw89: debug: fix off by on in rtw89_ppdu_str()

---
https://github.com/pkshih/rtw.git


