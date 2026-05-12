Return-Path: <linux-wireless+bounces-36273-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJL9FzKCAmpDtwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36273-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 03:28:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5155183FF
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 03:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AC813043FC1
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 01:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDE3274FDC;
	Tue, 12 May 2026 01:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="RNCKTdJl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7201E274652;
	Tue, 12 May 2026 01:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549143; cv=none; b=tNUIx9JgTbHddr6D3r056atpb7Uema0Yn4qEpLH2Z2T8ksMhQPR4O0dZnX9Py1iYQSLxoK128bsYKJlQOfIw6t7ILuWfVMdl7eqLtktcWUvOhBEWrZudLtI12VyVXRBzRiJA+PLz9qfMNiVJplg7x6HV4wv/Mzd+K7XSVvDf8Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549143; c=relaxed/simple;
	bh=sD7THkCpyvctCNkFb8gP1aEmsezKLo+ZkzrPZYiiiUo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QYH+cP0fM5e2cRHSyJzFp3TVLU4hWgR0GLsv1hIzx249XNOQERMDQOzzogTo7Ed/LUvlV7Dz+LRJWdvxu8+86itSkGIziCH3x5s83GbnMNcn6j1yerfw+cKsmk3cm/6PJX7NYkBmuvrkEklZlJYHMuXdXgFaWmD2XKN2wnshQrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=RNCKTdJl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64C1PFa743450606, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778549115; bh=xNkS2Oo1SRFZ1oqGWqT65dkADUGTE0syKdbbupWyRjo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=RNCKTdJlu+6UyMLbpLFdtTmVDUYqCUvTtVVBEKa5tQxBlyFj8l0NWoNYty5ql39o4
	 g6aV6BpGicNlgpWLoA0OCiiyPodfFaw7KvjF/T1m4+nHzCJPycgSFTrHrcmPRLXaYt
	 iZ/CiLm7wgP18kOts94Og9rTIvrBPyMyYc9x6FCXu6+wh4WuzfDeTy56vE2KQcv31P
	 nCWcLH3lXTId6NnckCHt9iwvGIgiO11+L1cgjAFpuH0GHTQdRdWDEsrYG4JDoSJl8B
	 3wGcoPMznw3bOU1tBkEK8QtVBbGcdv2k9zszUQuMrblmpQN8qRUeLGPwX/YD/zgH9r
	 DDUwGGFDFAwUQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64C1PFa743450606
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 09:25:15 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 12 May 2026 09:25:16 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Tue, 12 May 2026 09:25:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Devin Wittmayer <lucid_duck@justthetip.ca>,
        "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 1/1] wifi: rtw89: usb: Support switching to
 USB 3 mode
Thread-Topic: [PATCH rtw-next v2 1/1] wifi: rtw89: usb: Support switching to
 USB 3 mode
Thread-Index: AQHc4WBnvzkVdckSH0mw5MmxdTZUKbYIjd+AgAAKT4CAAP2NcA==
Date: Tue, 12 May 2026 01:25:16 +0000
Message-ID: <c71a1459979040f0a33b3f0b839deb76@realtek.com>
References: <6d553cffcb0ae84e141006ae1430f6f37909ad2b.camel@sipsolutions.net>
 <20260511180351.26471-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260511180351.26471-1-lucid_duck@justthetip.ca>
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
X-Rspamd-Queue-Id: BA5155183FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-36273-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,justthetip.ca:email,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Action: no action

Devin Wittmayer <lucid_duck@justthetip.ca> wrote:=20
>=20
> On Mon, 2026-05-11 at 19:26 +0200, Johannes Berg wrote:
> > > +static bool rtw89_switch_usb_mode =3D true;
> > > +module_param_named(switch_usb_mode, rtw89_switch_usb_mode, bool, 064=
4);
> > > +MODULE_PARM_DESC(switch_usb_mode,
> > > +         "Set to N to disable switching to USB 3 mode to avoid poten=
tial interference in the 2.4
> GHz band (default: Y)");
> >
> > We shouldn't really add new module parameters.
 This module parameter follows the pattern Bitterblue established for
> rtw88: same user-facing name (switch_usb_mode), same description, same
> default. Commit 315c23a64e99 "wifi: rtw88: usb: Support USB 3 with
> RTL8822CU/RTL8822BU" (2024-07-10) added it to rtw88/usb.c and it
> remains in-tree.

I took the patch of rtw88 because we switch USB mode at probe stage, but
USB 3 mode has interference on 2.4GHz band (as the comment says). If a user
insist on 2.4GHz with a good performance, this is an option to keep USB 2
mode.

>=20
> Three v3 paths I see:
>=20
> 1. Drop the param. Users hitting USB3 2.4 GHz harmonic interference
>    would need to use a USB 2 port instead.
> 2. Move the escape hatch behind a sysfs or nl80211 control. New UABI
>    surface; open to design suggestions on that.
> 3. Keep it for rtw89/rtw88 symmetry on the same USB3 / 2.4 GHz
>    harmonic interference issue.

An additional option might be to not support 2.4GHz channels when switching
to USB 3. But I'm not really sure if it is acceptable to USB users.

Ping-Ke


