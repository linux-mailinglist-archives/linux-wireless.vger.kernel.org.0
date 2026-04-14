Return-Path: <linux-wireless+bounces-34722-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OwOKTG73WmCiQkAu9opvQ
	(envelope-from <linux-wireless+bounces-34722-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 05:57:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 090403F5606
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 05:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 588B2301A925
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 03:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3398A33A6F1;
	Tue, 14 Apr 2026 03:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="locBVVXl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB60933986F
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 03:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776139053; cv=none; b=PAR7yDlh/aD6Z30P+GHOShU3mBnrXZuDGGEp3zzs5Kyl2rUnbpX73//eFa0pSweISnG0hAYXftTmHnm9j0tEQRvbEmddvQrFEJ2d3lCNxmNaTgDgGXBhjt5aw5H7QnEMQCU0ArqIZFAKA1F5+4elUpOlpQqytB7ifZ4JZE8T4Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776139053; c=relaxed/simple;
	bh=dQCzcMwHbpL4/HL92Ve0p6qrInseSpDjRGvHeLyXwbY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dTVOY3m9+CISyJLRbiH7qOWGPZcNfl6QQlTnJzPYCapa0Qtr5IEQgEGFMerMzdajOzxoa8j6btgI8INwd0bUlBrJzzRAI8uoFxwssaGX0mHvoj4i6g00ycWbuwaqA8/dHqexQFhSGpsjQqJ+TPgd3IIDftWR4f7FvCK4XADWbH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=locBVVXl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63E3vHtpD1323972, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776139037; bh=dQCzcMwHbpL4/HL92Ve0p6qrInseSpDjRGvHeLyXwbY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=locBVVXl62mbe0NigcQg+hJyWfK4jnCg7cVajHdKxD0Sirxb0Mh7qPWTP4WFKBAfh
	 1FkLfYmPVihu6VhJWTixPcWiL3QkfrxAHv1APbpRdvow2LKg5CtBCdOb1b8FchB6p3
	 YL7Nws30jQHA0fugPaGJI6eMLaN3V43sZ2IrSNWvoKt2OTk8LkSotuP4YeO9ylWtW6
	 HveFU2fYN5rpyYiB4liQDsXR4fobFQzXH7y2er8YvLOaOu5l8e6l65IP8AptfA/M04
	 dMEetWfaEq2qmLCeaXXFGfrLFgG/pdfKPUt0+ZEpgxeXN+u5N1ziqeIQY7Z+s3l2xv
	 tPsqU8tjqyCXA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63E3vHtpD1323972
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 11:57:17 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 14 Apr 2026 11:57:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Apr 2026 11:57:05 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Tue, 14 Apr 2026 11:57:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
CC: Kalle Valo <kvalo@kernel.org>, Yan-Hsuan Chuang <yhchuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: RE: [PATCH] rtw88: add TX power limit support to 114 and 130 channels
Thread-Topic: [PATCH] rtw88: add TX power limit support to 114 and 130
 channels
Thread-Index: AQHcrZj6b0aZaPK17kqRjXoafOBZKbXX3tPQ///l4ICABPIGEP//9mWAgAF6RrA=
Date: Tue, 14 Apr 2026 03:57:05 +0000
Message-ID: <c357b4d0f3fa4f57afee7016ee756b11@realtek.com>
References: <20260306-rtw88_channel130-v1-1-ff25a5bc930a@igalia.com>
 <55c23c5551354c6f8752d620f268b37b@realtek.com>
 <adjN1Tl1N_xpzBHd@quatroqueijos.cascardo.eti.br>
 <f347beb33eb142cba384bbe9378a061c@realtek.com>
 <adzry4z-LLhfor4e@quatroqueijos.cascardo.eti.br>
In-Reply-To: <adzry4z-LLhfor4e@quatroqueijos.cascardo.eti.br>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:mid];
	TAGGED_FROM(0.00)[bounces-34722-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 090403F5606
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> On Mon, Apr 13, 2026 at 05:56:17AM +0000, Ping-Ke Shih wrote:
> > Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> > > On Fri, Apr 10, 2026 at 03:56:11AM +0000, Ping-Ke Shih wrote:
> > > > Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> > > > > Though 114 and 130 are not usual channels, they are found in the =
wild with
> > > > > setups using 5350MHz as the center frequency of a 80MHz setup.
> > > >
> > > > What did the AP setup? channel 114 160MHz?
> > > > I wonder why rtw88 can select a not usual channel 114 80MHz.
> > > >
> > > > Please share your environment setup.
> > > >
> > >
> > > This is a Mikrotik that uses channel 130 at 80MHz.
> >
> > I'm surprised that an AP can work on this not usual channel/bandwidth.
> > Can you change the setting to usual channel/bandwidth? We'd avoid using
> > this unsupported channel/bandwidth by [1].
> >
>=20
> It seems to be "well-known" that some APs do it and it has caused other
> issues in other drivers. But it works just fine with a lot of other
> drivers. So, I would rather make rtw88 work with that setting, even if it
> falls back to 40MHz, for example.
>=20
> Let me check what happens when using the proposed patch and I will report
> back to you.
>=20
> > >
> > > > >
> > > > > rtw88 supports that, but issues a WARNING because it cannot find =
the TX
> > > > > power limit for those channels.
> > > >
> > > > Actually, rtw88 hardware can't support that, so we are working on p=
atch
> > > > to avoid selecting unusual channels. Can it work properly with
> > > > the AP after this patch?
> > > >
> > >
> > > It does work just fine even without the patch. The only issue is the
> > > WARNING that is triggered.
> > >
> >
> > As internal discussion, hardware doesn't work on channel 130 80M,
> > which means connection might be well, but it can't yield expected perfo=
rmance.
> > More, the power limit is not really verified on ch130 80M, so we wonder
> > that the signal might not in expectation.
> >
>=20
> The rationale behing my patch was exactly to try to set the power limit t=
o
> the lesser one of the adjacent channels.=20

The hardware setting of channel 130 80M is unknown, since we have never
verified that, so I can't say use the lesser one is always correct.=20
(Personally I'd make this choice if I have no more information from interna=
l
hardware experts.)

> I am not sure that the expected
> performance was not achieved. How would you suggest that I verify?

I think you can check if RX rate is 80MHz or not. If it really works
properly on 80MHz, you can yield TX/RX UDP throughput about 0.7 *
PHY rates.

Ping-Ke


