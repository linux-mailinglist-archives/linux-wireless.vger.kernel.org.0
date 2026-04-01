Return-Path: <linux-wireless+bounces-34274-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPUvINkCzWmSZQYAu9opvQ
	(envelope-from <linux-wireless+bounces-34274-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 13:34:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D431C379889
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 13:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3920E31B623B
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2026 11:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F662E2850;
	Wed,  1 Apr 2026 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waelti.dev header.i=@waelti.dev header.b="EtcBTmLx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658DD3F8817
	for <linux-wireless@vger.kernel.org>; Wed,  1 Apr 2026 11:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042713; cv=none; b=mhnRxAC4xvQeQK5i+vwFGkEJvN2jgyox56WCzgGF2IivU5DKmYpvpEfVhoQE2nj4JYe6K95RUrT+Pzu0acW4Wu7h3mcd+lrgF44AgfmhmmlvSz1UoqxnKFQshaA+49JngXhoZ1iAXLs/amYKEgmCEpoXjPrfKxSAIl321QuWPws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042713; c=relaxed/simple;
	bh=ipPEfK7NlEqBhzoBJtxtt8qkWpGYKiXdfgbWtqR9D2M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BSdzvPd8UNXR+zXRvqufYSj22n8KqWGsEDeyfQsofZmyJVskHEJWiMyQeY07Bo1Gi9hi0jFZrUyzeTEsFPrvVHbmgBaXE+JmO3exEfpU9pEC2GqJFc33docZpO4C0cKzUF4DU4YXKoOs5baC0KPEY0Bi6mIdAiBQu03cXAwQzZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=waelti.dev; spf=pass smtp.mailfrom=waelti.dev; dkim=pass (2048-bit key) header.d=waelti.dev header.i=@waelti.dev header.b=EtcBTmLx; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=waelti.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waelti.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=waelti.dev;
	s=protonmail; t=1775042696; x=1775301896;
	bh=y9msRcAwdpUmuJpqfpVKNgXlt1byXts+9+5qQENXhQc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EtcBTmLxYhFbE1mE6htRR7USp56dHE2AvKaKxwBDQ8uBz9vyc/VSVS7FqSalo2Pf6
	 ORxAPUow8MdjiBr5C9NKOneADZUR2kJ1K4WQ3as0vptslnlOlyMz2Zoy6SzcJZ1mB+
	 1yMgHAkCuL7Pk66oZSt12ZdmYwocU+nMWyOUyRg0028qRnkLdA6NLCosQ+XIqQ3B1+
	 2/6nq0rGLH3ajWJqN5XYRD+OVnBOgwpvonHhf+y1Uw7MFcpM1lg7HiPwxdnpIiEtRD
	 YILINz95TDfmzUB8/J4jmTiq3QTfFakpymtFH8AwQePXROa+Knb2BJBjerZTd8muB7
	 eih991Z7di5wQ==
Date: Wed, 01 Apr 2026 11:24:53 +0000
To: Ping-Ke Shih <pkshih@realtek.com>
From: =?utf-8?Q?Jeffrey_W=C3=A4lti?= <jeffrey@waelti.dev>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: wifi: rtw89: rtw8922ae: HWSI bus lockup during RF recalibration on AP bandwidth change
Message-ID: <JSFJ7Do8YsCSMLsXH6KLXADJ0-z0Dh-y99PpaSCHiCwp6aikxldPnTr9mXpEAifNezf2gFyPPiHIaobekBeqiM4XVpO8hYKyXvuei4lKVc0=@waelti.dev>
In-Reply-To: <f387614466ce497fb59d4ad98ef641f5@realtek.com>
References: <SnJ_b28_Uro9Xtlb2ew62uypaut_7wD44Qnmibm2Yj4FgSS7cayhZvqkK8-AXGNAc-xdwYST6E2GDCMcoZh33PjukvAsXwaqMzx8Z14_aA0=@waelti.dev> <8bf447cc627746cca6eb30ae283bbbe6@realtek.com> <uyjP590fzro7xuECRhUp6nlegi4hnWSBbrrFd-tcCcKeeKbDaoUThi7EkMNUMC2LYibyA0jaAqR7GrIchbJcGVh5CSgiGa39jMQkLq5F9QY=@waelti.dev> <f387614466ce497fb59d4ad98ef641f5@realtek.com>
Feedback-ID: 168448313:user:proton
X-Pm-Message-ID: c103dfadeb7c20f78095a3a4db931ffb2cd69706
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[waelti.dev,quarantine];
	R_DKIM_ALLOW(-0.20)[waelti.dev:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34274-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrey@waelti.dev,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[waelti.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:email,waelti.dev:dkim,waelti.dev:email,waelti.dev:mid]
X-Rspamd-Queue-Id: D431C379889
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Jeffrey W=C3=A4lti <jeffrey@waelti.dev> wrote:
> >
> > <pkshih@realtek.com> wrote:
> >
> > >
> > > Please try to disable power save and ASPM by
> > > 1) iw wlan0 set power_save off

I'm sorry, this is my first time interacting with the mailing list and I ov=
erlooked the other instructions. It seems like disabling power save gets ri=
d of the issue of Wi-Fi timeouts. I haven't been able to reproduce the issu=
e with `iw wlan0 set power_save off` yet, even without any of the other fix=
es on kernel 6.19.10 and 7.0-rc6.

> > > 2) reference and install
> > https://github.com/lwfinger/rtw89/blob/main/70-rtw89.conf
> > >    and then cold reboot.
>
> Have you tested with these conditions?

Using this patch eliminates the issue of Bluetooth devices disconnecting, w=
hen switching between networks.

> [...]
>
> > >
> > > Please help to test the latest kernel 7.0-rc with additional patch [1=
].
> > >
> > > [1]
> > https://lore.kernel.org/linux-wireless/20260310080146.31113-4-pkshih@re=
altek
> > .com/
>
> Have you also applied this patch?

I tested kernel 7.0-rc6 with this patch applied on top for ~1 day now and h=
aven't been able to reproduce, even with power save enabled. However, it is=
 a bit difficult to reliably trigger the issue as it seems to trigger more =
on certain networks than others etc.

> > >
> > > Ping-Ke
> > >
> > >
> >
> > Thank you for coming back to me so quickly, I just encountered the same=
 thing
> > with kernel 7.0-rc5.
> >
>
> Please confirm my questions above.
>
> Ping-Ke
>
>

In summary:
- Disabling power save seems to stop the timeouts but Bluetooth issues rema=
in
- Disabling ASPM features fixes the Bluetooth issue
- kernel 7.0-rc6 with the additional patch fixes Wi-Fi timeouts but not the=
 Bluetooth disconnects

I hope that answers your questions.

Jeffrey



