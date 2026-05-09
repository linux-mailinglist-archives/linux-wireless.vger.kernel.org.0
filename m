Return-Path: <linux-wireless+bounces-36137-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UILdJqOk/2kw8wAAu9opvQ
	(envelope-from <linux-wireless+bounces-36137-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 23:18:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E008F50172E
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 23:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B79B4300B618
	for <lists+linux-wireless@lfdr.de>; Sat,  9 May 2026 21:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6986332907;
	Sat,  9 May 2026 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jS/bx7rc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AD7239567
	for <linux-wireless@vger.kernel.org>; Sat,  9 May 2026 21:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778361503; cv=pass; b=k9MOySHfAmzl7STa+/dHLTzBMTZ6Qzz027EyI8ETiBy1a5F4A2KhqWR1ke5hXKYqrDLmXA+Negk2fHPFUKoGn1hPNmD+wUnIJufQ4OpcT+XU3YXYd7elPj9UuYuWBp5kgEyuxZX1RsN2K+lKRiJpeeqFxLjqaqlLVK2NsXDQb+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778361503; c=relaxed/simple;
	bh=nrWOAnSYEX673i5cipeBRPdADdY1prXAtRjkvmshZyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mX9AQtLtIlgNIAL8Yhbh6hLsMsR+V6T3V56OEmwJeS1XRavwiwo1W75X/NUuVn+b66wYl6DyrHH7B5EN/XfhYBW4Xlxc8++LiEwf2UA2aOm0W6q0R3RpJ79MMMzczzwZxbPHK9mVU2OqQIuKLR8XGdGGC4RYcV5NkirQqIy7W1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jS/bx7rc; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67b8d9c26bbso5377663a12.2
        for <linux-wireless@vger.kernel.org>; Sat, 09 May 2026 14:18:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778361500; cv=none;
        d=google.com; s=arc-20240605;
        b=JLM5FRIHDncgln4XjSkmdB6lirzflGBt6CS9JI45p4TBDOouf+DoH6y/p9BddtXUzV
         +t9bRcIZRTUlKW3bQQ1N/Hf5mYy5IhNgxyh5nE+Oksv77EcEaTMuZLEEl7E4uqwI3bfL
         b03JTzNT7Vzu9ghr0JBSJh1h5i0OTf0Bt/kT6PeHDxIgak18aV5E1SshJsSn0SSmijcr
         m/BXvP5RZ2v2q6un/WlQf4q88GubokpAp+q4VXEB1l1vJV+yoawk6/WpHwdCxqGX1/4d
         2UMJRuavdmQ70HE7CT7mO0CgiEWi3yDCoZBVkV3ue/pTGH/barkSgu84rltrrD6NVrcr
         w77g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ViimEr794yuvDsk9+ymhix6oa3R9emm0tHlDKhI/MZE=;
        fh=C5sWzTxBEKYY/LVoEe/NunCantQBIv61beLmSuCbQmg=;
        b=aD8crvMhwzxIwYV21we73HGSY1dMO9brA2PyjHSly2u7Piook26dD5Ah1P94kVHKki
         XdJIkoObR+SouIC2CvlyRG3Yc/hPa4uv1ahit+BBng/J/3WgdHhBn89AVk7zq0ReT2md
         jpfQ9bJ3oCoiu5h6OmqbH+/3KBDgpM3mA1buO8cRmHXZg+37bBMY/i7fyFfGXP4zFtds
         EFQ+Z9/HAEpWDLrnhdjwYT8bOiX535aeHjhDT+hMu6A6n5wiYN6PIf03oc/QNP4sWA+V
         Ym+PtEr9HOiW5ob0D/nCLi7dwpUDFkyRz616arYm71hy1tHxHoVSDIUntXaEVqO9UYC/
         S3aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778361500; x=1778966300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViimEr794yuvDsk9+ymhix6oa3R9emm0tHlDKhI/MZE=;
        b=jS/bx7rcW6V+99l5eGtFXQhJFNoP7M9+RsdwJfzpNBqZmVXwlE48tuGhPWUfugMmGX
         TrGx34cOER9ncdEYjRzqDAOsEelnguUHr1nyl51uWkpKSexgHGO77L0ntn6OmXCwA2el
         ImJvoUkNbB6Sj1IGGXdb4HG2mqVLJG1gBzs531gUTfM4ePTym9yuuTiJk932fv+lYye9
         cwYJ2OiEriaznsKNogBzuZNRsFnyUWBPzA9ueIUjYr0ZYF2vrsbkr2ILxbGVB5UpsrBJ
         nvtIySg2sK3BhdNy4Ol+9uUHDMfcT8ewA7++4zJMt5PBUWhbebQEcx8pc9dkPK28zSNk
         NLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778361500; x=1778966300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ViimEr794yuvDsk9+ymhix6oa3R9emm0tHlDKhI/MZE=;
        b=Q/wiJIwH79AxiP22/ek/Wjgd3oVzRRE4VRLtvDF9I2jv2es9QB+eTRz3GBSi1sK3c4
         arGR0Gk+X1pCcgV+9Q7VT74Y7yb84NLP05vIBc6htVaUG/6GVBBtrA8uwErc1hbGC23l
         /HfbqIa7rcEwCmKaseXalC+n7phEbWCPOf5y1dR2L0eaSP/nwKPtSRYH40QxufJX0AJ8
         4kaGVjyPklcHq8kPFXugqX7HncoecBxFEpBMMlUgCwDS+hj2/Yih48u8r0FpltLhmiAQ
         ijtK+akoNJKp/lkbgypi5p3XmkWHLhMHm+x+7v4QbKI+v46si30e/uCYN54lGUvD7iV2
         CnTw==
X-Gm-Message-State: AOJu0Yzmq6soOTrXdrzkz014v/TDK9IB6v9OJF49rHuNKouOkztQX6CE
	Msej6URVhzpJoWEmwWxITN/FkJ3dqffqH/SU5igi92otETOntLStfCgi+Pr/4fbU5TnODd9v+zw
	qJU5sK6yxe2zQ2U474dg1zKaWOWJRpEg=
X-Gm-Gg: Acq92OF1TGZ7bLRohafuwOetwj7/KnSiT+UFsLhGBTvyoy4tyfRtc1gP/oiF0ryzuEe
	iss6pNRY1/JMk3MqW3FvV4YCBsisHROhe/wpflkCPl4TcQW1W4pfZ8fBudgm10X9RaLakWZwsV4
	QTVGNpQ01Ll8E8WxlZMD8lFsg0t2WEs5fS+bb5x4kvGp1mZceiXcbXzjVzOpAFUWP0bQ/8PeQqt
	e+GH7jxPDoefqJxEMlP8lhkMFVB2wJbZWJ+b5NcLzDHLuUpE4OrAtvJNkEG8lHgbphx0dObI/Xw
	+ARxpNO/cISAlIkP+DNP8nOIsxkb5ggnFDdY3XLwzQ6gJEcw+4jPsPeqFygmGlBkd5HVvbnkjot
	ANX1fg4lTrnEkP2og1M+Qhf45TdvVfDwVl1r8sN5C76Cealz3YYdxIIpeaY5szN4OTphj
X-Received: by 2002:a05:6402:534a:b0:65f:71ed:7ab9 with SMTP id
 4fb4d7f45d1cf-67d6489d358mr7137372a12.22.1778361500146; Sat, 09 May 2026
 14:18:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430232206.141461-1-rosenp@gmail.com> <20260509101326.GA2170@wp.pl>
In-Reply-To: <20260509101326.GA2170@wp.pl>
From: Rosen Penev <rosenp@gmail.com>
Date: Sat, 9 May 2026 14:18:08 -0700
X-Gm-Features: AVHnY4KL4nIKhdNL87q3am6at5vJINIZ66gow9omDBHAY3fU_rZ_ecAleq2o8e8
Message-ID: <CAKxU2N87cVTcLhPgetj0BH5asEC0mVNAJh4fcLyPrHxbZp-R4Q@mail.gmail.com>
Subject: Re: [PATCH wireless-next] wifi: rt2x00: allocate anchor with rt2x00dev
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-wireless@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E008F50172E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36137-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[wp.pl];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wp.pl:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Sat, May 9, 2026 at 3:13=E2=80=AFAM Stanislaw Gruszka <stf_xl@wp.pl> wro=
te:
>
> Hi,
>
> On Thu, Apr 30, 2026 at 04:22:06PM -0700, Rosen Penev wrote:
> > Instead of being creative with devm, allocate with rt2x00dev by using a
> > flexible array member. Simplifies code slightly.
>
> I think this patch is more creative. Using a flexible array member
> is less conventional than the current approach of allocating separately
> and storing a pointer. But OK, lets get rid of 9 LOC.
I don't see how a FAM is more creative. It's a single allocation. It
also takes up less struct space as the pointer gets removed. The other
usage of ieee80211_alloc_hw and struct_size is in ath12k:

drivers/net/wireless/ath/ath12k/mac.c: hw =3D
ieee80211_alloc_hw(struct_size(ah, radio, num_pdev_map),

Actually there are more but instead of struct_size they use manual addition=
.
>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
>
> > It's worth noting that in 25369b22223d1c56e42a0cd4ac9137349d5a898e , th=
e
> > proper device was set to the devm call as it seems there was confusion
> > there.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >
> > ---
> >  drivers/net/wireless/ralink/rt2x00/rt2x00.h    |  3 ++-
> >  drivers/net/wireless/ralink/rt2x00/rt2x00usb.c | 11 +----------
> >  2 files changed, 3 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/=
wireless/ralink/rt2x00/rt2x00.h
> > index 665887e9b118..7d313e86d3f2 100644
> > --- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
> > +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
> > @@ -1009,11 +1009,12 @@ struct rt2x00_dev {
> >       /* Extra TX headroom required for alignment purposes. */
> >       unsigned int extra_tx_headroom;
> >
> > -     struct usb_anchor *anchor;
> >       unsigned int num_proto_errs;
> >
> >       /* Clock for System On Chip devices. */
> >       struct clk *clk;
> > +
> > +     struct usb_anchor anchor[];
> >  };
> >
> >  struct rt2x00_bar_list_entry {
> > diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c b/drivers/n=
et/wireless/ralink/rt2x00/rt2x00usb.c
> > index 174d89b0b1d7..47e427ea8622 100644
> > --- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> > +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> > @@ -804,7 +804,7 @@ int rt2x00usb_probe(struct usb_interface *usb_intf,
> >
> >       usb_reset_device(usb_dev);
> >
> > -     hw =3D ieee80211_alloc_hw(sizeof(struct rt2x00_dev), ops->hw);
> > +     hw =3D ieee80211_alloc_hw(struct_size(rt2x00dev, anchor, 1), ops-=
>hw);
> >       if (!hw) {
> >               rt2x00_probe_err("Failed to allocate hardware\n");
> >               return -ENOMEM;
> > @@ -826,13 +826,6 @@ int rt2x00usb_probe(struct usb_interface *usb_intf=
,
> >       if (retval)
> >               goto exit_free_device;
> >
> > -     rt2x00dev->anchor =3D devm_kmalloc(&usb_intf->dev,
> > -                                     sizeof(struct usb_anchor),
> > -                                     GFP_KERNEL);
> > -     if (!rt2x00dev->anchor) {
> > -             retval =3D -ENOMEM;
> > -             goto exit_free_reg;
> > -     }
> >       init_usb_anchor(rt2x00dev->anchor);
> >
> >       retval =3D rt2x00lib_probe_dev(rt2x00dev);
> > @@ -843,8 +836,6 @@ int rt2x00usb_probe(struct usb_interface *usb_intf,
> >
> >  exit_free_anchor:
> >       usb_kill_anchored_urbs(rt2x00dev->anchor);
> > -
> > -exit_free_reg:
> >       rt2x00usb_free_reg(rt2x00dev);
> >
> >  exit_free_device:
> > --
> > 2.54.0
> >

