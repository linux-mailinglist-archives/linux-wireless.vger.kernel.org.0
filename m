Return-Path: <linux-wireless+bounces-36353-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOR2IoDwA2ouBAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36353-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 05:31:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E88C452CC2D
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 05:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35DDD305FB1B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 03:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA15C361657;
	Wed, 13 May 2026 03:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHCcEv2+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3701013C9C4
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 03:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643069; cv=pass; b=ghIrsxSRSumPHTz1n40EhpVDWz/UbjKd1ApfzkavkB3CdEgUT8IxeYZ0ai3x7ypSLInO6ep6jdqj0ieL61lwdISq7U+gTsDgXcc6wVzFuaxFZs2u4O4BcanSVocZTfanEj4LuYdgNi3ZjEeVILelbK/5B3L+Rjot5jUYFMwoqXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643069; c=relaxed/simple;
	bh=8yEMAmsmvgUVPcF4GVjw5fKpb9c2JiKbQJSt9u4+1Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8AksyvSwQrHEHwq4Wssh4ahtx33P5zr8Rf5qxejXVzI1yfyqPG/d8nHBlk3SpOhqsY2mrXWw2IothlIFTo+IrMT1U6ILmb/T8wlqA1u1xDcUkzHhsMPipzYZjbW3EgkvbDooZiGuKfR4RnulcCVGzTDyfs7K2hu4vtcTrPN3gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tHCcEv2+; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7dcdaf06498so4217845a34.2
        for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 20:31:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778643067; cv=none;
        d=google.com; s=arc-20240605;
        b=WjnpBrtbXdzWWGKW3vQ9Ndworj5S4ql8GfzQYDZlO7cQHCn02Vk4mGf40zVSa9yrOX
         mQWYKUnxAo+BCGbLQGB1L3lR9R7FYNI+dFPXaQKy4NJgTyMA7FsLRZsxR8M69Q38OU2m
         Q4Z+L/AGAHS7WF/VUmqW4iRVn8Y/QkQRxEz+KcRWmm6OA7uWPTd+t65HwHtuoS7U/Ik0
         HGjSG6tKwSXOoBLKBpojhwq/SItak8lANkMVhp6HVmiQUeioRGNFcVS/uq24kaNZxluY
         i7eR+uycHp4No/OE6lSn0tFO0cqz/Lod1yApcDp3T3PtLsoO9OW39HVIR+c60sEkOc8/
         z7JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mkJHePA5ylc7DrllEguE7yS7MQQUyp0sxg23OnXjj2s=;
        fh=tbyyAx0twViv8DfA8+B5FBH+dVu+C7w4Uj2PpeZakCI=;
        b=av92RAJuHNwl1/aUdU69fSZcKVq4HBJH79HI8Bo2EkrYQlTHwExa+PMF/1yPLpvyQl
         L23CFOSoY/DGLmhIBpJ0jOCs5dncGR3GP0VgoAz2580y9Uda2DfrXYbDZoiVABbx5zwo
         x1LDPxTCB9bnS9tuyhjijkm/0+d/dW4Mze/ESTXwvrh5rI5LcyOUVgFRJjXTt2NiWFjP
         YCMNm2btsz+kepQBCC4o4hVIEWlY8MCIu9OqWRWodmTnT5NLgUDykjfe1o+x3f+6pFzj
         vIeyHRcE84VUXDq65ZpHA/kKYbLAmO7hCqGi2Zw+OfZQBV8XM2YuzerCkPCQ+KBJFE00
         7XPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778643067; x=1779247867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkJHePA5ylc7DrllEguE7yS7MQQUyp0sxg23OnXjj2s=;
        b=tHCcEv2+OiRefqK6xsJDCWAgAffFADbu+F5h6mCwgS8720I8v9kGiCpYYZZy2Ocnec
         a8ZZL/Gd1EbBz4QklEr5JeBUel8hWaaQS2n+lt1Tv8bJ9OVZO7Ur3JzYHb91GPbPP+uJ
         D70VZpU5V5sr7++CbcYS/PmTtsA9jFLtAelC6a7J6uJHVlgWbOzVShX2IcBaw6+GFBmZ
         R+Yl4dqo/xwGI5NrjR4xRA6edePSzrdgvAtS5Nhrxznr8GpIoMlUqm133IE+H1Jfq8ad
         CrsOC4EnglkCLAlZDf9htiYTNMbznKiaMN/WMXa/JWFdNOrZsmnITS3usGumOsNxYPoa
         DcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778643067; x=1779247867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mkJHePA5ylc7DrllEguE7yS7MQQUyp0sxg23OnXjj2s=;
        b=LknVNNT+Dnq2m0GPWZO1CCsfHinmlfU93P4+PrNw2gGjrHVXae2PLjBbcpbJnxdJac
         b4YSbkS3gsm+9gSgsIRZGDq7bWSSIvXA4kg9qmwc6AKBMRpyUQfOINs6NshQ33XqKHlu
         ndUnKN4iMCjL20i4nh2TNjJbZ+CHdD63ccpAGdnbykKqxutR1yjhmuhcKNlI5A7iSSPv
         M9leldABIU3kBEa8GB2dP7egHNh9gwx3GJF5m+vssqr1jDm/Kejhmyjz/gM968HXqmX4
         YXS5dCTIeTNz3dtxG22cXNHcvN1XefhB0KDdH0wa6z5zntxE2OCc3rBLN3uMRK+/G7Xl
         HjOQ==
X-Forwarded-Encrypted: i=1; AFNElJ91/UWMKgVI0E8Oueu5f5zRcn//xC9ueQehyO5IAHqsR7UoEjmB52wSxzPmY/zV7St/pvASiKsbcx+O9MpZ6w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ku/mexUCPmYA5lXn2baAOqUH57jTib6zMDQ7p6gm3guwWAqT
	OTfDDMfHTCIyFjr+hpkGw3x99s3f6FGK3cBX/0+Kjm23bIi5P13RryMpFBIevFPWtUaRFaysSQf
	J//pJjOoO7dK5PE9J4KbhI2aFmsOAAZk=
X-Gm-Gg: Acq92OHsJhjSjWcsXj1cciaxrNwwBdTWWfj37N+AG9td4g0JZwUA1T6l3EHYJ4pqoOM
	7ESQeqLIYs70rGM7nZtoUAMz2h737kZf/06mYAdcEhZxqPOYOR8rJUVradGQzt88dadK1q568h7
	AcAEQSSuwAxtuSBUA67IsFL2hTYJJy8kTyJ9FGAin7T9QCszQ9h9kCRSGYQDtYu7A7wmTJ2MC1C
	3XN/RQbIVJ0H7jkhGQd2vOmoeRuV8E4F8FDC3w6zHN9w5O+3xHINuq+Znps3irRWE0l5FezYX7/
	jgjlRWMjp70X4HnHZbuVDHIRQQV0gmTz0aPkw4c=
X-Received: by 2002:a05:6830:3697:b0:7e3:7f84:4cf9 with SMTP id
 46e09a7af769-7e3da0cefcamr1048436a34.11.1778643067157; Tue, 12 May 2026
 20:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506200249.317690-1-santiagorr@riseup.net> <45f1c979-ea8d-4118-8551-eff93966b4e1@oss.qualcomm.com>
In-Reply-To: <45f1c979-ea8d-4118-8551-eff93966b4e1@oss.qualcomm.com>
From: Kyle Farnung <kfarnung@gmail.com>
Date: Tue, 12 May 2026 20:30:55 -0700
X-Gm-Features: AVHnY4LEQy64KrKEqNOZLc_Lh90vHXqKfZK_pa-aabTj8o44CzX52CeEkWtIEYo
Message-ID: <CAOPSVF29ofKi8fpmJxuq9F5uQXHe4RrFvGb2V-odGMNA77NWXw@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: ath11k: Add two missing Lenovo IDs to the quirk table
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: =?UTF-8?Q?Santiago_Ruano_Rinc=C3=B3n?= <santiagorr@riseup.net>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kfarnung@outlook.com, Mark Pearson <mpearson-lenovo@squebb.ca>, koike@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E88C452CC2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36353-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[riseup.net,kernel.org,vger.kernel.org,lists.infradead.org,outlook.com,squebb.ca,igalia.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,qualcomm.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 5:03=E2=80=AFPM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 5/6/2026 12:54 PM, Santiago Ruano Rinc=C3=B3n wrote:
> > Commit 0eb002c93c3b4 ("wifi: ath11k: Add missing platform IDs for quirk
> > table") added some Lenovo platform IDs to the quirk table to address a
> > wakeup from suspend issue [1].  However, at least P14s Gen 5 AMD, as
> > reported by Kyle Farnung [2], and P14s Gen 3 AMD are missing in the
> > table.  This commit adds the two corresponding Lenovo version IDs for
> > each.
> >
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D219196
> > [2] https://bugzilla.kernel.org/show_bug.cgi?id=3D219196#c23
> >
> > Tested-on: P14s G3 AMD running 7.0.3.
> >
> > Fixes: ce8669a27016 ("wifi: ath11k: determine PM policy based on machin=
e model")
> > Co-authored-by: Kyle Farnung <kfarnung@gmail.com>
>
> This is not a standard Linux kernel commit tag.
> Co-developed-by: could be used, but I'd need a Signed-off-by: from Kyle
>
> Kyle, if you'd like these added please reply with both a Co-developed-by =
and
> a Signed-off-by tag

I re-tested the bug behavior on the v7.0.4 tag and found that I'm not able
to reproduce it on my device. I put the device to sleep and then unplugged
and replugged power; it never woke up until I intentionally woke it.

Based on discussion in [3], I narrowed my issue with wi-fi disassociation
on wake to a suspect commit [4]. I'm developing a patch that clears the rdp
and wrp buffers during wake to clear out any stale state in the LMAC rings.
I'll submit that once I'm done testing it.

Santiago: Are you seeing the sleep/wake bug from [1] or something similar
to what I was seeing around disconnections on wake?

[3] https://lore.kernel.org/all/CAOPSVF04q6uvVdq8GTRLHBrVMdpt9=3Do9wVcFMc6f=
-yhmSBcZqQ@mail.gmail.com/
[4] 32be3ca4cf78b ("wifi: ath11k: HAL SRNG: don't deinitialize and
re-initialize again")

>
> I can apply these fixes when I process the patch in my tree.
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#wh=
en-to-use-acked-by-cc-and-co-developed-by
>
> > Signed-off-by: Santiago Ruano Rinc=C3=B3n <santiagorr@riseup.net>
> > ---
> > Changes in v2:
> > - Merged the Lenovo P14s G5 AMD #1 and #2 related changes proposed by
> >   Kyle Farnung in
> >   https://lore.kernel.org/all/20260330-p14s-pm-quirk-v2-1-ef18ce07996b@=
gmail.com/
> > - Added Kyle Farnung as Co-author of the commit
> > - Added the second ID of Lenovo P14s G3 AMD, and adapt the comments
> >   accordingly
> > - v1: https://lore.kernel.org/ath11k/20260423211458.458911-1-santiagorr=
@riseup.net/
> > ---
> >  drivers/net/wireless/ath/ath11k/core.c | 28 ++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wirel=
ess/ath/ath11k/core.c
> > index 3f6f4db5b7ee..c1ce0a11af44 100644
> > --- a/drivers/net/wireless/ath/ath11k/core.c
> > +++ b/drivers/net/wireless/ath/ath11k/core.c
> > @@ -957,6 +957,20 @@ static const struct dmi_system_id ath11k_pm_quirk_=
table[] =3D {
> >                       DMI_MATCH(DMI_PRODUCT_NAME, "21K4"),
> >               },
> >       },
> > +     {
> > +             .driver_data =3D (void *)ATH11K_PM_WOW,
> > +             .matches =3D { /* P14s G3 AMD #1 */
> > +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "21J5"),
> > +             },
> > +     },
> > +     {
> > +             .driver_data =3D (void *)ATH11K_PM_WOW,
> > +             .matches =3D { /* P14s G3 AMD #2 */
> > +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "21J6"),
> > +             },
> > +     },
> >       {
> >               .driver_data =3D (void *)ATH11K_PM_WOW,
> >               .matches =3D { /* P14s G4 AMD #1 */
> > @@ -971,6 +985,20 @@ static const struct dmi_system_id ath11k_pm_quirk_=
table[] =3D {
> >                       DMI_MATCH(DMI_PRODUCT_NAME, "21K6"),
> >               },
> >       },
> > +     {
> > +             .driver_data =3D (void *)ATH11K_PM_WOW,
> > +             .matches =3D { /* P14s G5 AMD #1 */
> > +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "21ME"),
> > +             },
> > +     },
> > +     {
> > +             .driver_data =3D (void *)ATH11K_PM_WOW,
> > +             .matches =3D { /* P14s G5 AMD #2 */
> > +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "21MF"),
> > +             },
> > +     },
> >       {
> >               .driver_data =3D (void *)ATH11K_PM_WOW,
> >               .matches =3D { /* T16 G2 AMD #1 */
>

