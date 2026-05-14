Return-Path: <linux-wireless+bounces-36407-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HExDEdXBWoIVQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36407-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 07:01:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B755453DD08
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 07:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DF9D30237E0
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 05:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27422FFDFC;
	Thu, 14 May 2026 05:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjPpU7nW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BA33B8D48
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 05:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778734909; cv=pass; b=t7aKbB6VVdZaH40bdVOWNrPEFlREDWVyLAsGgUd90ROpM48itCJck0u8J2jRYKrEtTJnwVk3hcpRl33f28RtX105/lDcsCBkrpCc8pccuj6KfADpemtQwX5vuMi67sTT6DlzJTwMc3llvnWosBA0xIAdmZmu9gMeVRgqt6r02c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778734909; c=relaxed/simple;
	bh=QiZxopUfM88o+2XiK/foxP6x7LqwNpuACaUduRxpa/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MM2V0JylJ10mmCcRlT7NftaSDGC8jhvckQiTzlrCeDgdcDYuJY6quTWcp+CqTSDpnW9i5i38BLtvJP3aj24tyGGxFG7u/2JqGDvAC6hR/+nvizlC7FQGMTX649yGNmCEr822y8kYDQfkJzkNXTbCAt+D4KRb7nJaTRVPu0yimqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjPpU7nW; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-47c35be02fdso3003074b6e.3
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 22:01:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778734907; cv=none;
        d=google.com; s=arc-20240605;
        b=HWAcPw8cIyCgAyPM7O2WKQJKMun+MAtfJZBLYU4n4GPPz++3/xKuXrDOr9UbYUU1k2
         BbDK2sYVDGE9637r8v9FvgcbOsmegnVYH4pmMG0GRGPYa6R5Vud46cAncIyP74gTV75y
         nQwUf+S47hCzBjec5ztQYcvUMlhmbb9CvNCMqi55qwZ3jOJ9i9iBOeWNQFsO9WDjSV0N
         ma1iXgNw0v3xP2JvDxgSZc+QY/QKZ8pDgN+ZcVi/kHMg7i8fhPlIcNQ3k4fvJ1qU4Kvt
         MzOK/DBEiUMo6wWN3byb8TKP7WuVPZcIZ/gh4A7LBIbK71NnPkbBl/Vw8vODWEbkKG/O
         q7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yuzwaqTnGGM7aW7QOmJLmzcivKiPwogk91AON3LZsNM=;
        fh=psbx7/t/n0PtARnAk/zGezsSh4Imwh7eWC6Sfq1J8pU=;
        b=EssCAJZCuQb2pIhTO9hAO6yv5vS9JQcUwY3Uqfjsk/PrtxLyo6Bb4eyVWh+LsVhZvZ
         a7RBFitaouFkaAkNq0T22WBGEPAv419rtlPTXql+9WO/3Kd3G403J/sUnRpduQlD08Be
         YgPIFsjqHZPEiTyclN3XggzbqJUovMpF7wF4YKTH8G3oeMajwrpwtq4Gzs6F4AI6/k2X
         Xa6AmrO1RpmdBg8tUzXmYlc4Uo8RwyRmHz4re/4iytUuJAejQRBISpf29881dErl0Dch
         OZOFYnG5fHUaCArYqI1WQzaKaeCmW+cq5/SSR2jh6z1lJDBOPZvyphBYRvImfreQQRqJ
         ro1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778734907; x=1779339707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuzwaqTnGGM7aW7QOmJLmzcivKiPwogk91AON3LZsNM=;
        b=ZjPpU7nW0uEbDcdfTnVWQfZgddMxn4sYhsQR8WlrirYd95UYe3PoodXtUgDbto6zEh
         EGMeW3z+1ETYsNuSlCUgwCggWqM8JOIIuYkT3bM01sHL0gmmwkSgRFcBZRcRPYzcWZpt
         2o4T3Xkd2hYLEhUO+irBtwJiqxHdjxVs4q1dC1GmzP3kNZnDqA45khV3r8qfgXDldYEW
         nDfF2uxVNkGRzFZCXoIYoBlZKoArrrJiwUs83rAY9J09IeBE+/wU6fx37lC9+TjQrEH4
         NqJngb1sfWIzV+nK94ticxwqdzFS8688peyH4bDOw3XTdMqnc1aen6c18FD63Ipr6nFH
         myFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778734907; x=1779339707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yuzwaqTnGGM7aW7QOmJLmzcivKiPwogk91AON3LZsNM=;
        b=YR3lq3FlfvVcTLIR20KBdvxD0O7AG5FzzQCpChMAko+G96imXfkE47Dd5qv+tFWmpW
         9kyj6pYf1/l2EjoSdqyIu5BQ4GUunzgvU5X7q1ahMHZSgzxshLp9I2CtVVIyjlm/5UGn
         MFvUEuNshpUvuVDBsxbqiyel42JUGvC4z840zVWQQkq+M0QsP3MnqX76f52Vo3CYh6Ch
         /7do0FhXXzsFwbkWptimZCAThb9G/FflF5xROrMH6DUYubd5np6K/DJLtrqn9DWB9Rfm
         aaLvDZ5SHCF+3hdtn0NGrXLSTj22AG7wxc5svaGm5J6TT7AyN51Wvgj9YmRSSjXEGtYO
         dp8A==
X-Forwarded-Encrypted: i=1; AFNElJ/9/89ewb4vqa57fKW1OyVrgsWu1RLINwsqvtD/4wG1qHabUWBElJu4eYmcfo2bLwPRli/cFyDpBhRqRqEwgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfFOJDYIrWq5R7U2dpCe32IIVHScjYjiyVO2z6nFPVNt02K/ZM
	ZfNIndL/xm/u87FEXIu04+nc+PDlcsRwK85ab/wZGJUMMCAnmP63gkFiOGHu7orgpEzA7a7kaqh
	qX7rL0JQhQMxVgMHLnYNtH/M6aCU+dle5ILWTA60=
X-Gm-Gg: Acq92OGuI5wAXi5EfVH/wDyHrPmUeOleRauRTbSAOhVFS0Bix+ymAedAdzVbOxRlkdS
	qoJ2W9b6I1Qjau89gjzcEbQGtCWjLnAN/qAJ5QVx+zKaJz/kKsE7Knfeye+RSBEWfnkctNZGULJ
	46le4JKOQ7y3YFNqc5kjA2p3SiT+ONwsWp8OqK8RVJI4bwkpBBTjWANfBZLITiA7bYn7sheNSua
	J/H6plmRYq3ngztfy4/Wcgvci0wnTxRnmcCpu2cUFCDY/cnWOmAh/uzr8GBnf5xgWHD49DAk2Sx
	u2Ce0/pXkoDu6E641blA/iAW7WaDX0sOF1mETHvl2fnMsfrhHQ==
X-Received: by 2002:a05:6808:144d:b0:460:f435:2aa1 with SMTP id
 5614622812f47-482b2e43247mr3644664b6e.46.1778734906908; Wed, 13 May 2026
 22:01:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506200249.317690-1-santiagorr@riseup.net>
 <45f1c979-ea8d-4118-8551-eff93966b4e1@oss.qualcomm.com> <CAOPSVF29ofKi8fpmJxuq9F5uQXHe4RrFvGb2V-odGMNA77NWXw@mail.gmail.com>
 <agS7fr8mDI9TLpvh@voleno>
In-Reply-To: <agS7fr8mDI9TLpvh@voleno>
From: Kyle Farnung <kfarnung@gmail.com>
Date: Wed, 13 May 2026 22:01:35 -0700
X-Gm-Features: AVHnY4KMie7IknPXt13rC7yQCXAqPuhefYjAM7GsLBndz1dWNFxsmaiUpDup55s
Message-ID: <CAOPSVF2xwpR63MmngbG06_wPtQe2tOoVe87fanzXGRHBeJGYUA@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: ath11k: Add two missing Lenovo IDs to the quirk table
To: =?UTF-8?Q?Santiago_Ruano_Rinc=C3=B3n?= <santiagorr@riseup.net>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Jeff Johnson <jjohnson@kernel.org>, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kfarnung@outlook.com, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, koike@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B755453DD08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36407-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,vger.kernel.org,lists.infradead.org,outlook.com,squebb.ca,igalia.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kfarnung@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,riseup.net:email]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 10:57=E2=80=AFAM Santiago Ruano Rinc=C3=B3n
<santiagorr@riseup.net> wrote:
>
> El 12/05/26 a las 20:30, Kyle Farnung escribi=C3=B3:
> > On Tue, May 12, 2026 at 5:03=E2=80=AFPM Jeff Johnson
> > <jeff.johnson@oss.qualcomm.com> wrote:
> > >
> > > On 5/6/2026 12:54 PM, Santiago Ruano Rinc=C3=B3n wrote:
> > > > Commit 0eb002c93c3b4 ("wifi: ath11k: Add missing platform IDs for q=
uirk
> > > > table") added some Lenovo platform IDs to the quirk table to addres=
s a
> > > > wakeup from suspend issue [1].  However, at least P14s Gen 5 AMD, a=
s
> > > > reported by Kyle Farnung [2], and P14s Gen 3 AMD are missing in the
> > > > table.  This commit adds the two corresponding Lenovo version IDs f=
or
> > > > each.
> > > >
> > > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D219196
> > > > [2] https://bugzilla.kernel.org/show_bug.cgi?id=3D219196#c23
> > > >
> > > > Tested-on: P14s G3 AMD running 7.0.3.
> > > >
> > > > Fixes: ce8669a27016 ("wifi: ath11k: determine PM policy based on ma=
chine model")
> > > > Co-authored-by: Kyle Farnung <kfarnung@gmail.com>
> > >
> > > This is not a standard Linux kernel commit tag.
> > > Co-developed-by: could be used, but I'd need a Signed-off-by: from Ky=
le
> > >
> > > Kyle, if you'd like these added please reply with both a Co-developed=
-by and
> > > a Signed-off-by tag
> >
> > I re-tested the bug behavior on the v7.0.4 tag and found that I'm not a=
ble
> > to reproduce it on my device. I put the device to sleep and then unplug=
ged
> > and replugged power; it never woke up until I intentionally woke it.
> >
> > Based on discussion in [3], I narrowed my issue with wi-fi disassociati=
on
> > on wake to a suspect commit [4]. I'm developing a patch that clears the=
 rdp
> > and wrp buffers during wake to clear out any stale state in the LMAC ri=
ngs.
> > I'll submit that once I'm done testing it.
> >
> > Santiago: Are you seeing the sleep/wake bug from [1] or something simil=
ar
> > to what I was seeing around disconnections on wake?
>
> I was seeing wifi issues after wake-up, including disassociations, as
> described at https://bugs.debian.org/1132343.

Thanks for the confirmation. I went ahead and submitted a patch for the
suspected SRNG restart issue in [5].

For my P14s Gen 5 AMD, I don't think the PM quirk is the right fix at
this point, so please don't include the 21ME/21MF IDs on my account for
now. This new patch seems like a better match for the disassociation
issue I was seeing after resume.

Please try it out if you have a chance. I've done around 12 sleep/wake
cycles so far without issue.

[5] https://lore.kernel.org/all/20260513-kfarnung-ath11k-srng-clear-pointer=
-state-v1-1-bc700dd8b333@gmail.com/

>
> >
> > [3] https://lore.kernel.org/all/CAOPSVF04q6uvVdq8GTRLHBrVMdpt9=3Do9wVcF=
Mc6f-yhmSBcZqQ@mail.gmail.com/
> > [4] 32be3ca4cf78b ("wifi: ath11k: HAL SRNG: don't deinitialize and
> > re-initialize again")
> >
> > >
> > > I can apply these fixes when I process the patch in my tree.
> > >
> > > https://www.kernel.org/doc/html/latest/process/submitting-patches.htm=
l#when-to-use-acked-by-cc-and-co-developed-by
> > >
> > > > Signed-off-by: Santiago Ruano Rinc=C3=B3n <santiagorr@riseup.net>
> > > > ---
> > > > Changes in v2:
> > > > - Merged the Lenovo P14s G5 AMD #1 and #2 related changes proposed =
by
> > > >   Kyle Farnung in
> > > >   https://lore.kernel.org/all/20260330-p14s-pm-quirk-v2-1-ef18ce079=
96b@gmail.com/
> > > > - Added Kyle Farnung as Co-author of the commit
> > > > - Added the second ID of Lenovo P14s G3 AMD, and adapt the comments
> > > >   accordingly
> > > > - v1: https://lore.kernel.org/ath11k/20260423211458.458911-1-santia=
gorr@riseup.net/
> > > > ---
> > > >  drivers/net/wireless/ath/ath11k/core.c | 28 ++++++++++++++++++++++=
++++
> > > >  1 file changed, 28 insertions(+)
> > > >
> > > > diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/w=
ireless/ath/ath11k/core.c
> > > > index 3f6f4db5b7ee..c1ce0a11af44 100644
> > > > --- a/drivers/net/wireless/ath/ath11k/core.c
> > > > +++ b/drivers/net/wireless/ath/ath11k/core.c
> > > > @@ -957,6 +957,20 @@ static const struct dmi_system_id ath11k_pm_qu=
irk_table[] =3D {
> > > >                       DMI_MATCH(DMI_PRODUCT_NAME, "21K4"),
> > > >               },
> > > >       },
> > > > +     {
> > > > +             .driver_data =3D (void *)ATH11K_PM_WOW,
> > > > +             .matches =3D { /* P14s G3 AMD #1 */
> > > > +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > > > +                     DMI_MATCH(DMI_PRODUCT_NAME, "21J5"),
> > > > +             },
> > > > +     },
> > > > +     {
> > > > +             .driver_data =3D (void *)ATH11K_PM_WOW,
> > > > +             .matches =3D { /* P14s G3 AMD #2 */
> > > > +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > > > +                     DMI_MATCH(DMI_PRODUCT_NAME, "21J6"),
> > > > +             },
> > > > +     },
> > > >       {
> > > >               .driver_data =3D (void *)ATH11K_PM_WOW,
> > > >               .matches =3D { /* P14s G4 AMD #1 */
> > > > @@ -971,6 +985,20 @@ static const struct dmi_system_id ath11k_pm_qu=
irk_table[] =3D {
> > > >                       DMI_MATCH(DMI_PRODUCT_NAME, "21K6"),
> > > >               },
> > > >       },
> > > > +     {
> > > > +             .driver_data =3D (void *)ATH11K_PM_WOW,
> > > > +             .matches =3D { /* P14s G5 AMD #1 */
> > > > +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > > > +                     DMI_MATCH(DMI_PRODUCT_NAME, "21ME"),
> > > > +             },
> > > > +     },
> > > > +     {
> > > > +             .driver_data =3D (void *)ATH11K_PM_WOW,
> > > > +             .matches =3D { /* P14s G5 AMD #2 */
> > > > +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > > > +                     DMI_MATCH(DMI_PRODUCT_NAME, "21MF"),
> > > > +             },
> > > > +     },
> > > >       {
> > > >               .driver_data =3D (void *)ATH11K_PM_WOW,
> > > >               .matches =3D { /* T16 G2 AMD #1 */
> > >

