Return-Path: <linux-wireless+bounces-31454-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMTYAAaMgGnO9wIAu9opvQ
	(envelope-from <linux-wireless+bounces-31454-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 12:35:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A3CCBB72
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 12:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C726930252A3
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 11:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5383B35E548;
	Mon,  2 Feb 2026 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbW9X8hT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10C53624BC
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031897; cv=pass; b=etqxTOtYqZtqoJWLM/375aSil4T7QJvItpRItCs1D6BgbZJWLC0F2EOy3I5ZqfxjgNXyE/xwqYhJEs5GNoAN7kZdWhyujTO/V8mP++WFQME2hxdn8kdils5qq9FGhWZisEM9BUfA35f5qPt/1PbwpfwnylW3PKvndikVAb0r+/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031897; c=relaxed/simple;
	bh=ldeZyLToEnXKrxmF9aBeR9IUF/PKOug2Y1zFhdB3GIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxNd5zAzu9X/Yaaj808+Q9vBSyb4mpQw6xHLbHzQ4g9susR2c41qJxWjVhq+6gXl7gKI5dffK5i0g6V8Mdwsn/D2c8jbSTUwQ/0832BeiKedIkfoieCfTyzzjOOX01dsMTVcY5Tkfo0/7VLhpoYn0rGYomsNLG83m8ARe7oPc24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbW9X8hT; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-40438380b88so2594702fac.3
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 03:31:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770031895; cv=none;
        d=google.com; s=arc-20240605;
        b=EO8Nbj4xZu6P5vVZtA2ZciQR4g2BzDe60HE6IohjsgtCpvtsMpgmSCl1ZnHGzQ/5c7
         /9QOX4+jahwy+UrFD1vQTbI5nSEEE+Hm6zlLdsNanwbvv7Eso8ID71eWMOftjADeIZ/A
         TEshGA3IP9fsViNKunfSjJI7V0XXZg8X68TpaiDwriV2ez/OcXr6CItr5xGACONRc5ZF
         qXCkihF5D4Qnuna40+CJuW1mHuKK8GUWe9imhsJfUBr5II3k/c7mNP1LxQULUxlZRq1s
         o8ESTMQNA3tBFCjiyqRoGy5KOd6dthghW9TFmzK4w9pdIWe7Co/uzkgcD/UPHHetXdby
         V8Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E0vUVHH61Ck9QC//OPXl1T2NV8C1D2lLljMVnusDYgI=;
        fh=zFCB9yj6tbPtiNOgT9n/qK9LnQKfgtX1AWhCxXtoerY=;
        b=lozikE+sv3czYVzJtU19QRUn+1hrOyafioz4lUiDDkAqjCsQxlN3wpFI9sqoAyikzS
         XveOJ/VNTCr1fQlQyWWFZlfPTxl8x6BNK2vw3UiSk8FQm14tspMmhZuQhAB+LGyFQuR+
         yCtBhkOXxfgAEOcvw9sWYJvTb6DGWR0Qorsl5b1JMVknUTd+EP8Qsl2rDjxGs3MrkUFR
         UDkKf+bAuih8B2XWgVBSWl6tC07wl3DGThxS857LbOeGOoCDzA5pUGuplc4Uu3isJjQJ
         XNkx5cFMERumOO+HKffIJgcueRGy+J91Q2frFbEWnfFkdwQ88eWy04zIV2eHqsEmI97I
         LB8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770031895; x=1770636695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0vUVHH61Ck9QC//OPXl1T2NV8C1D2lLljMVnusDYgI=;
        b=gbW9X8hTjC6YBtwc62rMp5bNMNLeRR+eUAmjxiAw2PoY+jr1OPUaLg4C4YzuH2BHPj
         +yrWyhJOuunsiOVVRX/wYe6h7ZAjSSW09SWKN3K/uUlGpqTrkWv32yuWmDGZkkpbM2tD
         95cL5VnvFLakdIzPcsEBHmX7EKMrSDIwJN/292qlAtK0oaqsnO0yXOaqiFlyYNDxI3+S
         0a8pflkEwUTfDrakG49US40wJJ3braBLShuqDa3lWZStRiV3BtSDP6L0toWia3w1+3Gd
         zbM4eGo9doYdMuQt8xOIG/6fwIALTeGNDwD2stCzn4J4FE8hZmnuxONpwOd5lRt3vS0+
         8p+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770031895; x=1770636695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E0vUVHH61Ck9QC//OPXl1T2NV8C1D2lLljMVnusDYgI=;
        b=qD/GyBg45TNXkE1U2D4wdZO8FEL9mYHF2eqeNdJOJXEYUTIvGC9q1rxZ6AxQ+O00p/
         fjCr9ulmZDvxBgnJotznRnYAFeDFqYWQu8lgFZ481lSpq6/ZcrRe1iVa+yoOhdcMPl1Q
         nNY1/oO7yVpoYFGERVaquAbuKtB5f+9M4gp0ua5snV2r2pdV5bAon/UsQLXV49KeNpDO
         K33fkbhKkHOdTSBwvd10/BXAVK/GkCt+2/jsj+Tq0LalzKinelU2uW1IspuZxPyql68X
         1GcY2NznqM7UiLPfYp087+nWplPbVo/ioYpe5hOR3DbAlYbNkqjx9N9474QnqQ4eMxqc
         XM4A==
X-Gm-Message-State: AOJu0YwsgwcAtjSGb/1kNxD7wEVuF943WCpZIvadKEaa1WuXNq3bCLje
	fOk/ge4mfnETDnEdCN7o+yA5O1PnHxCf+tXW4QLCMzMDpXPhaW6mVfo/xsMZZvqaVi3ENkjhT22
	9A9Q2cnXWPEP4tJvIjtdW6Y2nveRIyt8=
X-Gm-Gg: AZuq6aKSriV9qYUVJtu9BZxfv3fIIt2DXMWr9dYu1qS2ABLil+uXa4NDPbdZdjPkhDQ
	GmsZDqBiEAmFdEvZx5S3kaYN6sONMmdpkFbr2JvYiU4dbm3GCr/gHNPWJ4qNICYaIPCWhAZA+lb
	UkgpCwHBX00IQeltvGUfCclnCGj8cZ7UT4ltBObuPpAbE/Ol+ERE7CjHPeha26oysDZt47Puirj
	Nbd2WNUCT7shxgWuXoSNOc6QosOnUB2iSfyZwGresvUqfHAwzdknHfeCAF0CsEo4pL2XlHAzmG5
	0/Ig
X-Received: by 2002:a05:6820:60f:b0:662:f660:5a1b with SMTP id
 006d021491bc7-6630ef550ccmr5068553eaf.0.1770031894746; Mon, 02 Feb 2026
 03:31:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPVS0eKn3zEyRekrQP_K3W5n5iVZ44nXkUAAE2=KkNcpq+LeYg@mail.gmail.com>
 <f730f3ca7b1d4fd08795831e13cc8f2f@realtek.com> <CAPVS0eKLicu1Y+MUpLcuwqTU0agEn9m7zyOO_5rgB3vA+gM9Bg@mail.gmail.com>
 <CAPVS0eLR5KCmBEkGHnSxwKQM0hwCSaL0TSaTMNT_GJQK1sT8hg@mail.gmail.com> <b7830d69ee2645fb9e4a3c371dcdf6eb@realtek.com>
In-Reply-To: <b7830d69ee2645fb9e4a3c371dcdf6eb@realtek.com>
From: Iohann Tachy <iohann.tachy@gmail.com>
Date: Mon, 2 Feb 2026 08:31:23 -0300
X-Gm-Features: AZwV_QgB96cAuWwVSyoRRr9nWYLcwGrsxKq5nx2RFw9-lz-MGj9ZxV2Zaxa-eiM
Message-ID: <CAPVS0e+QCSWH4np8CY4TJvzD2gvPCcDbxBsYq3CO+JXfWh+1ug@mail.gmail.com>
Subject: Re: Problems building rtw89
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31454-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iohanntachy@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51A3CCBB72
X-Rspamd-Action: no action

On Sun, Feb 1, 2026 at 10:52=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> // sort posting as expected (avoid top posting)
>
> Iohann Tachy <iohann.tachy@gmail.com> wrote:
> > > On Thu, Jan 29, 2026 at 9:36=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.=
com> wrote:
> > > >
> > > > Iohann Tachy <iohann.tachy@gmail.com> wrote:
> > > > > Good morning,
> > > > >
> > > > > Currently there's an issue where it's not possible to build the r=
tw89 driver.
> > > > > The RTL8852BE card has a compatibility problem with Intel X99 chi=
pset
> > > > > and a hacked rtw89 driver is needed to make it work.
> > > > >
> > > > > I kindly request to read the Github issue:
> > > > > https://github.com/lwfinger/rtw89/issues/396
> > > >
> > > > A fix in Github is to disable 36-bit DMA [1]. I'd like to collect p=
latform
> > > > info to add a quirk. Please share outputs of below commands
> > > >  - dmidecode
> > > >  - lspci -vt
> > > >  - lspci -x
> > > >
> > > > [1] https://github.com/a5a5aa555oo/rtw89-1/commit/629756ee0232089d2=
98bb398790d4a745b950058
> > > >
> > > >
> > On Fri, Jan 30, 2026 at 1:58=E2=80=AFPM Iohann Tachy <iohann.tachy@gmai=
l.com> wrote:
> > >
> > > Good afternoon!
> > > I'll run the " - dmidecode
> > >  - lspci -vt
> > >  - lspci -x"
> > > commands today evening.
> > > and I'll let you know what's the output results.
> > >
> > > Regards,
> > > Iohann
> > >
> > Good evening,
> >
> > I attached the results of the commands you requested.
> >
>
> I sent a patch to avoid 36-bit DMA as github did if the driver is running=
 on
> your motherboard X99. Please revert the patch you mentioned from github, =
and
> apply this one to see if it can work to you.
>
> I decide to not choose PCI bridge as a quirk rule, because the PCI bridge
> "Intel Corporation 8 Series/C220 Series Chipset Family PCI Express Root P=
ort"
> is in common use, and I believe other boards using this bridge can work w=
ith
> RTL8852BE.
>
> Another, I assume you installed RTL8852BE on X99 personally, not pre-inst=
alled
> on the board when you purchased, right?
>
> [1] https://lore.kernel.org/linux-wireless/20260202014049.11783-1-pkshih@=
realtek.com/T/#u
>
>

Thank you. Yes I did install the pcie card myself (It's a TP-Link TX20E)
I'll try in the evening to figure out how to apply and test the patch,
as I don't quite yet understand how to do it. thanks.

