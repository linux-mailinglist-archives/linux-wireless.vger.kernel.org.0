Return-Path: <linux-wireless+bounces-37793-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 41Z/Ld9JL2qC+AQAu9opvQ
	(envelope-from <linux-wireless+bounces-37793-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 02:39:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46482682A3B
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 02:39:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=DVzus0OA;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37793-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37793-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD6E03001D4A
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 00:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D155C1A6834;
	Mon, 15 Jun 2026 00:39:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76251C2AA;
	Mon, 15 Jun 2026 00:39:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781483996; cv=none; b=Dx7DMLSPSxQLp/XT6MPxGj0uN4AXq2xKYpoBf8MljE6fL6Dfs85/jCjeBjxlSyjZL/gY6tEzRzCzC07gPAH67VBWlt751n1JVDoAnNSXOUv1KVRt4ISGoA35TW7lEIWYSlao/a2qNmRhT8MMlfoR6J/7Csf3pYpYka/sQUPcGSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781483996; c=relaxed/simple;
	bh=tcjB8r0cY4JiVp99EG4HDSdOxwnCsKpMj/tFpLJM6Ek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HA2vYVWJi7wDPN3/G1kSbZLs05wlIqzwurKlGbcEwrT4F4+7Ds0cKu/dU0b3O4726yUtLJfwk9lLXyV+B9l6QLlDtAK3LzTKi+lPRm62rOE89cEy397WF9yScUFDkQYEesbcANOnOv/MKD0JCjrYjdEhM5xSk3qe8MK3xNZ3gdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=DVzus0OA; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65F0dVcB5366319, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1781483971; bh=tcjB8r0cY4JiVp99EG4HDSdOxwnCsKpMj/tFpLJM6Ek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=DVzus0OAShVEvhujAh11px48YlUB1lM3fEbXuiFfsY5ZUAvqb2n7EIE3jLdN1G7k9
	 PDEDyQpY0rJmU8ivqnJ3XTbRfAd5LlSWoFy9NpnsT0BNAPtzGjGim7IYXdGg9Y85aN
	 FCbaTTX9DgEczHtMQk/R2bLaDZerxiq5B6XnplCTOp7jlX8zPcrZjJTd1MiZI60/Gc
	 fUW1ESwUII4B+sB9t9H1VKWmdDa7VUcS2Z5bWER+tqSW7AaWJGNfQBSV/UABwkdhZY
	 vDLDMwWR+McOwkV0YaLdxei9yD+P9kkbIRzQfqZyApr9SZTAyxOlJnsA2d6wJfp2iu
	 0toTbaitIccLA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65F0dVcB5366319
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jun 2026 08:39:31 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Jun 2026 08:39:32 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Jun 2026 08:39:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Mon, 15 Jun 2026 08:39:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Chen Jung Ku <ku.loong@gapp.nthu.edu.tw>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chen Jung Ku
	<cjku@proton.me>
Subject: RE: [PATCH] wifi: realtek: rtw8822c: replace msleep() with fsleep()
 for DPK delays
Thread-Topic: [PATCH] wifi: realtek: rtw8822c: replace msleep() with fsleep()
 for DPK delays
Thread-Index: AQHc+1bXUI9lQ3CMLU216yjwQVY3JbY+x5Ig
Date: Mon, 15 Jun 2026 00:39:31 +0000
Message-ID: <5183c87219e2489eb99c9015cb96a7f8@realtek.com>
References: <20260613170434.23645-1-ku.loong@gapp.nthu.edu.tw>
In-Reply-To: <20260613170434.23645-1-ku.loong@gapp.nthu.edu.tw>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37793-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ku.loong@gapp.nthu.edu.tw,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cjku@proton.me,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46482682A3B

Chen Jung Ku <ku.loong@gapp.nthu.edu.tw> wrote:
> Replace msleep() with fsleep(), because msleep() may oversleep
> to as much as 20 ms when used for a 10 ms delay.
> According to the kernel documentation, fsleep() is more suitable
> and aligns better with modern kernel style.
>=20
> Documentation link: https://docs.kernel.org/timers/delay_sleep_functions.=
html
>=20
> Signed-off-by: Chen Jung Ku <ku.loong@gapp.nthu.edu.tw>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


