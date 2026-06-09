Return-Path: <linux-wireless+bounces-37551-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hna8CXyEJ2rlyQIAu9opvQ
	(envelope-from <linux-wireless+bounces-37551-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 05:11:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB05465BFE7
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 05:11:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=ShvqJ+7P;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37551-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37551-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82CE3308A32F
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 03:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DB336494C;
	Tue,  9 Jun 2026 03:11:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFE03655D3;
	Tue,  9 Jun 2026 03:11:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780974687; cv=none; b=IUvt55jc01KNQZsN0oFrm8bqxa0ZjzRqH0MeAIeRH8XdOjWadffo/rWOq9qKFS/n7OTS4D4m56WLwQQRxUstBSPg2uTlTYtZ/SPqIxORZ0L5jD/wrT0MFiTbQrmntlzDF5JWVrzjFvHnAO9UepL8F4PowjcsqqB/GzTyiw5yiSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780974687; c=relaxed/simple;
	bh=p0Kqbj/Ii75a1yIJ24c+73oSMQLcIkapGdSdEBJCUjQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lSR0DRwM6Z9KpRM+NZl3wGFhbTFFbs4Bx09+9bvryOuenHuPtCx2J2Grax4VBtyjSUynZN6SCZaOXXJys2UcZKRJkamlBPgSxpGdv0kwShqGODyIJNSWkOxzTS6jg3qKoBBMLt2/lWKFXcA7sT7VDfND6s+eyytjb7kmNOQmgWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ShvqJ+7P; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6593BDBa84109752, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780974673; bh=9EyRGBlLwnn3/G+5vgCQD06vpUS1Heypko0uvAUMkI4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ShvqJ+7PXUTxTyagAsrnLR1i3X/YaMQCLea0FyXmwY6+lhLTwl2hBc0gT6MBJQJS0
	 +w6JjTVtFsYwY4dRrwPLXJ9LX3WOfmMxDjaaCp5I0BTA5XWABUE+/44beqyydv9of9
	 19UqktcZZ+A0q2ef0+D8EEOBD3lIKgF3WgTxmI7LjcVmWFMxm0gl4nMZgq7JTmS2na
	 arPjQDH5Of/5geKlHEUSadBmxS2fbpezsnxoVLAFrYuJbxqXCPa/SX0K6pS51L/EUq
	 BWEt//OBT/szwEn6fo5S2jwZb0vohAQxIXoBRLpiJe6+g09Nv/9mOiYgiWlBwzR2qt
	 9QbfpX5twwAvA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6593BDBa84109752
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jun 2026 11:11:13 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Jun 2026 11:11:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Jun 2026 11:11:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Tue, 9 Jun 2026 11:11:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: William Hansen-Baird <william.hansen.baird@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "William
 Hansen-Baird" <williamhb+k@fastmail.com>
Subject: RE: [PATCH] wifi: rtlwifi: rtl8723be: Remove unnecessary irq
 save/restore in hw_init()
Thread-Topic: [PATCH] wifi: rtlwifi: rtl8723be: Remove unnecessary irq
 save/restore in hw_init()
Thread-Index: AQHc905TcIixZsauPkqjRA4rUv96cLY1h6EQ
Date: Tue, 9 Jun 2026 03:11:12 +0000
Message-ID: <8b562a921c7944819e4eea862b1b53b3@realtek.com>
References: <20260608135345.2526325-3-williamhb+k@fastmail.com>
In-Reply-To: <20260608135345.2526325-3-williamhb+k@fastmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37551-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:william.hansen.baird@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:williamhb+k@fastmail.com,m:williamhansenbaird@gmail.com,m:williamhb@fastmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,fastmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fastmail.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,k];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB05465BFE7

William Hansen-Baird <william.hansen.baird@gmail.com> wrote:
> rtl8723be hw_init() calls local_save_flags(flags) followed by
> local_irq_enable(). Later, local_irq_restore(flags) is called.
>=20
> This causes warnings from Lockdep on boot and modprobe,
> as local_irq_restore(flags) should only be called while irqs are disabled=
.
>=20
> With testing I found that all paths which call hw_init() have irqs
> already enabled for rtl8723be.

By commits you found below, current hw_init() is not in scope of
spin_lock_irqsave(), so irqs is not disabled, right?

>=20
> Furthermore, the calls were originally added for the rtl8192ce
> in commit f78bccd79ba3 ("rtlwifi: rtl8192ce: Fix too long disable of IRQs=
")
> before later being added to most other rtlwifi drivers.

This commit adding the code you are going to remove, is to resolve
"disabling for too long the local interrupts". I think current code
has no this problem, so I think removal is okay.

>=20
> Commit d3feae41a347 ("rtlwifi: Update power-save routines for 062814 driv=
er")
> then replaces the call to spin_lock_irqsave() before hw_init(),
> and thus the codepath which caused irqs to be disabled in hw_init and
> prompted the original commit has been removed.

>=20
> The same irq save/restore pattern is also present in the hw_init() of
> rtl8192ce, rtl8723ae, rtl8188ee, rtl8192se and rtl8192cu,
> however I don't have the hardware to test them,
> so I did not include them in my changes.

Okay to me.

>=20
> Tested on a Razer Blade 14 2017.
>=20
> Example of output from Lockdep prior to fix:
>=20
> [ 2305.476471] raw_local_irq_restore() called with IRQs enabled
>=20
> ...
>=20
> [ 2305.478709] Call Trace:
> [ 2305.478731]  <TASK>
> [ 2305.478753]  rtl8723be_hw_init+0x5992/0x7220 [rtl8723be]
> [ 2305.478798]  ? static_obj+0x61/0xa0
> [ 2305.478848]  rtl_pci_start+0x222/0x5c0 [rtl_pci]
> [ 2305.478891]  rtl_op_start+0x128/0x1a0 [rtlwifi]
> [ 2305.478940]  ? __kasan_check_read+0x11/0x20
> [ 2305.480082]  drv_start+0x16c/0x550 [mac80211]

Not prefer timestamp in commit message.

>=20
> ...
>=20
> [ 2305.570855] irq event stamp: 887679
> [ 2305.571569] hardirqs last  enabled at (887689): [<ffffffff96511170>] _=
_up_console_sem+0x90/0xa0
> [ 2305.572347] hardirqs last disabled at (887698): [<ffffffff96511155>] _=
_up_console_sem+0x75/0xa0
> [ 2305.573076] softirqs last  enabled at (887670): [<ffffffff962f4675>] _=
_irq_exit_rcu+0x175/0x2f0
> [ 2305.573817] softirqs last disabled at (887649): [<ffffffff962f4675>] _=
_irq_exit_rcu+0x175/0x2f0
> [ 2305.574636] ---[ end trace 0000000000000000 ]---
>=20
> Link: https://lore.kernel.org/all/20210111153707.10071-1-mark.rutland@arm=
.com/

I think this is point out the commit which introduce the detection of
"raw_local_irq_restore() called with IRQs enabled". I think this isn't
very highly related to this commit.=20

Please use below style, and describe what it is in commit message.
It can be ignored if a reviewer has understood this.=20

[1] https://lore.kernel.org/all/20210111153707.10071-1-mark.rutland@arm.com=
/

(a blank line before s-o-b line)

> Signed-off-by: William Hansen-Baird <williamhb+k@fastmail.com>

My comments are minor, so

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Please revise commit message and take my ack to v2.


By the way, subject prefix should be "[PATCH rtw-next] wifi: rtlwifi: ..."

Ping-Ke


