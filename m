Return-Path: <linux-wireless+bounces-27232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D0FB5232C
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 23:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F6947BA83F
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 21:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41492F0661;
	Wed, 10 Sep 2025 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQshznS2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB031204F99
	for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757538308; cv=none; b=Er6I+YFaeiivbondliyZndiGTwrg+hMiGvbYB42nLOxwNvcYWyeK2qI5p/y89UxpiAm6LtkuQSIJ2+hL3vKwigEmsBewaWQdG80KFnV57dOzXq8k7CCgoKSxlzDo8gtZBgTq1y5peVmTSlcvPxIRkMfxAGUdBCRIXdGGswujtms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757538308; c=relaxed/simple;
	bh=F7ZcfIvsrTeYa84UyohEvC0AY6Ptsz2ykU70MB1Fe8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xn7mC6igid3EQZUQ2wuT5x7BkJesXm8h+yd1ppxdzBrTvYbQsSJiK04lkpXGY6tLtHTqhGYHu6nI1pEbBMjaqiCOGBkDJCRBD+eC1yAxskHjbWFc+wTz6KTsMklZ1WdOYxzY1sQmb72bWdnD8mBbriDnW4mySCLpmebQUqrCEWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQshznS2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dfe95bbb7so470335e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 14:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757538305; x=1758143105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7ZcfIvsrTeYa84UyohEvC0AY6Ptsz2ykU70MB1Fe8Q=;
        b=eQshznS2UmxQF0wwmRH3P0U3E//o0cH9efWCNbces5ZpcYxLyUVBwprzc8sCvC7+DJ
         s8g5W30xCjhbaH3x7lfYfm2xC+K1gyofycW6KybozEWtSPcMw0KfUzDvhKzC7SEJzVHs
         Il/wc+iNIKTV6CvY0PkBT+hlsSqgFqDkpY4Z2nQ8HwZoYe2vMiQ+NWkz5C6dogpziBna
         ssTB1I7PbG8ghd508NfFY07j/wImnTDsdZCJ8y2Ri0aUiptZtn9uyUy0q6dveHowyLIH
         DvZYbSViYz9xZ/lL5fKK12yx4Ipk9S6bVMvytllOLdLtO3RgiQcKUGgYs8fgbbEbj1DA
         0vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757538305; x=1758143105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7ZcfIvsrTeYa84UyohEvC0AY6Ptsz2ykU70MB1Fe8Q=;
        b=KbefLu6xS3nGNC2xCxE83koj0f8JzvXW0M9OKThAtwx9pHusUCZSpuy2IecZ4TxHaW
         pAkdeqUlf6IAd5JA1qe765UUJPv0Ne97JONXJGMUu9pPPO4kBsMtuzrrl21Q6tl/99GC
         ls5d0JmUfp6Z5pQ9qar4nP2eL/TzVV6aRlQ/eyuRshjZv1t4l/WfKF7x2VT0DpGiaFis
         JOxy3oO0eFGtQgmvO861EmQRTW4tqY6ngUXAgJjBPeOIGdXcj8cXl35fmCM29EfE7XpX
         DDy2VVRChBs465Wx2GxnotgL6IxbjgmHiXK97Wkah7eSDkMhkzvnCdI/2sshrlnQmAWa
         yRBg==
X-Gm-Message-State: AOJu0Yx9yGwespe45NghFqC2XtWc8H4f/kGFSK/v+RZyWU0CtoXsCxqp
	OBJzUiMnQYzLJ6OmC9CDc3CJlCY9c0nfz0MupX9yxMPs0peuB8l5h3v6SESY1Wjqy/OkeSPU2hx
	HeycW2jK6AOZdJR88PjKu1txsUVSJo45zwoWgEexH8A==
X-Gm-Gg: ASbGncsh77cv9V97NVT/GTXBrDbfxgClyFlM5q+IZk6p3whX3V1Q504M4QgIpogt6Pt
	Z40Aaq46NXWrHp0QpqXl47tWQFzC7MyAeRDMuA06oRfcL5J3mAE9+MFwXLVQrAUP8aGfxRlgHQa
	qpbbKtL5W6c/Na89CafuCjh0XrfB1X/dxyugOeg4bAyBqqQtAqeX9Q4QkQx5PEKBnmAmG0Wos83
	ALi0VZxP4Q79xqt/DlO3v2kOOlZdTxCR2DfyWDy
X-Google-Smtp-Source: AGHT+IEtNk4I5wapbKR4HHPhJwnTtYIyLG/UV+uPVat38UsiMj8bpWLGCgoHPSjUufDl1Ne6bIdneo/4QABRiWpDEVk=
X-Received: by 2002:a05:600c:4fc1:b0:456:f1e:205c with SMTP id
 5b1f17b1804b1-45ddde6a4a7mr155434175e9.4.1757538304703; Wed, 10 Sep 2025
 14:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909135510.757750-1-scaasiffej@gmail.com> <8d5d8339f1dd568f43d97c4ed60817df1838fc13.camel@sipsolutions.net>
 <CAOYMkPqAt-ETcwL7ZzUUB=0YO-ML+Mh60cB_-8MZj6zcp_-Cxg@mail.gmail.com> <2735aec6379159923299d6cfb916a2bf03aecf18.camel@sipsolutions.net>
In-Reply-To: <2735aec6379159923299d6cfb916a2bf03aecf18.camel@sipsolutions.net>
From: Jeff Isaacs <scaasiffej@gmail.com>
Date: Wed, 10 Sep 2025 17:04:52 -0400
X-Gm-Features: AS18NWBIV93O1H5D1t_hZ3zJcf51o7cWdO6R6dDTgFWZHxz9nNeF6d2PZg64PwM
Message-ID: <CAOYMkPpsLa9dBeAwrS7o3--0D9O4is7D8qU_OAjLyh9hwJpBLA@mail.gmail.com>
Subject: Re: [PATCH] wifi: mac80211: always mark 6 GHz BSS as QoS/EDCA capable
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the very detailed explanation. I completely understand your
reasoning to leave things the way they are, and agree that the best course
of action is to hold vendors accountable. I will continue pushing Ruckus fo=
r
a fix in their firmware.

FWIW (probably nothing), after applying the patch and getting past
authentication, the association response has the WMM IE and also includes
the MU EDCA parameter set, so everything seems to be within spec from that
point forward. The sole problem really is the incorrect assumption of
inheritance to the non-Tx profiles.

I spent quite a bit of time turning knobs in the Ruckus controller and AP
CLI trying to define a different QoS profile per SSID, so that maybe it
would be explicit in the non-Tx profile, but it still wouldn't show up unti=
l
the association response.

I also tried to use iw to set the SSID within a directed probe to the AP
over its 6 GHz channel. At least in theory, the AP is supposed to include
all QoS params in the response. It didn't work, but even if it did, it's st=
ill
not an excuse to disclude the params in the beacon frames.

Thanks again for the very detailed response!

Jeff

On Wed, Sep 10, 2025 at 3:01=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Tue, 2025-09-09 at 19:19 -0400, Jeff Isaacs wrote:
> > Ok yeah I should have included a bit more info to begin with. First, I =
will
> > defend my assertion, then I will give more details on the motivation be=
hind
> > this patch.
>
> :)
>
> I'll point out first that this area is actually rather complex because
> nobody is actually implementing QoS as written in the spec, but rather
> WMM as documented by the relevant WFA spec, and then assumes it
> satisfies the QoS requirements in the 802.11 spec (e.g. for HT/... STAs)
>
> > [snip]
>
> Sure, a 6G STA is a QoS STA. That doesn't mean a 6G AP STA is exempt
> from actually announcing the QoS parameters.
>
> > So the current logic in mac80211 to downgrade to legacy in absence of
> > the WMM IE is flawed when the beacon is captured on 6 GHz, because
> > any STA operating in 6 GHz must be at least implement HE and all of its
> > required features.
>
> It isn't: we internally first downgrade to legacy (because all of HT and
> higher require QoS/WMM) and then don't connect because HE is required
> and we cannot connect as a non-HE STA on 6 GHz.
>
> > One more supporting item from the spec.
> >
> > 802.11-2020 =C2=A710.2.3.2 -
> > "The QoS AP shall announce the EDCA parameters in selected Beacon
> > frames and in all Probe Response and (Re)Association Response frames
> > by the inclusion of the EDCA Parameter Set element using the informatio=
n
> > from the MIB entries in dot11EDCATable. If no such element has been
> > received (e.g., prior to association in an infrastructure BSS), a non-A=
P
> > QoS STA shall use the default values for the parameters."
> >
> > So it is explicitly stated that it is possible that a beacon frame can =
be
> > received from a QoS AP without the EDCA parameters included. And
> > since a non-AP STA cannot initiate a probe request with a wildcard for
> > the SSID in 6 GHz, it has no choice but to use the default parameter
> > values outlined in the spec until the QoS AP instructs otherwise.
>
> Here in some way the difference between WMM and QoS becomes relevant,
> but even if we read this as WMM=3D=3DQoS, I'm not sure I agree.
>
> I suppose this is an interpretation matter, but "[t]he QoS AP shall"
> already _requires_ the QoS AP to include that element. Any deviation
> from that makes it non-compliant, and there's not much of an assumption
> on STA behaviour from that point on.
>
> The example in the "If not such element has been received [...]"
> sentence to me at least implies that these are not meant to be cases
> where the AP misbehaves if it doesn't include it (which is already
> established by the first sentence), but is meant for the cases where
> there's no QoS AP that controlled the parameters, "e.g., prior to
> association in an infrastructure BSS", or also perhaps when associating
> to a non-QoS infrastructure BSS, or similar cases.
>
> > Now for my motivation for introducing this patch. I have observed that =
the
> > WMM element is not present in beacon frames in the 6 GHz spectrum on
> > the Ruckus R770 when multiple BSSs are packed together using the
> > MBSSID feature. The WMM IE is included in the top-level profile, but no=
t
> > in the non-Tx profiles defined within the MBSSID element.
>
> This is a pretty common AP bug around element inheritance [1]. They
> assume that it's inherited from the transmitting BSS, which is not true.
> Actually, this is precisely _because_ of the difference between WMM and
> QoS. If it were QoS elements, it _would_ be inherited, because all
> elements are inherited unless overwritten in the specific profile. Since
> it's WMM carried in a vendor element, any other vendor element overrides
> the inheritance. Therefore, either _none_ or _all_ (intended) vendor
> elements including WMM must be included in each non-transmitting
> profile.
>
> [1] Sometimes in MBSSID non-transmitting profiles, sometimes in multi-
> link profiles, sometimes maybe even both.
>
> > I am in contact
> > with support, but the initial response I got from Ruckus is that this i=
s
> > intentional.
>
> They're wrong, and even the language you quoted above makes that crystal
> clear, as does the WMM spec [2]. We've (indirectly) actually discussed
> this with Ruckus, and they have in fact acknowledged that this is a bug
> in the AP and that they will fix it.
>
> [2] though that never talks about MBSSID (I think) so you have to read a
> whole bunch of cross-spec text wrt. inheritance etc.
>
>
> > And well it makes sense I guess. If the spec defines default values, an=
d
> > the whole point behind MBSSID is to save airtime for data transmission,
> > then why repeat the same unchanged default QoS values for every BSS.
>
> No, see all the discussion above. The default values (in the BSS case)
> are for when you're connecting to a non-QoS AP and pre-association use
> cases etc.
>
> > I also figured that they had to go through a lot to get the WiFi 7
> > certification. If this is truly an error, I would be surprised if I'm
> > the first to notice it, given that the R770 shipped out beginning in 20=
23 :)
>
> They cannot pass certification with this bug, but it's possible that
> either they started including more vendor elements since, or changed the
> configuration in other ways, or the specific MBSSID configuration isn't
> tested in the certification, etc. But this _is_ validated as part of the
> certification, if the scenario arises.
>
> > So I dug through the spec, and ended up with this chain of reasoning fo=
r
> > why the WMM IE is not required in 6 GHz.
>
> ... but it's still wrong since it's a clear *shall* requirement. I hope
> I've been able to convey that.
>
> Right now, as annoying that may be for you, I'm inclined to not change
> anything here since multiple AP vendors confronted with this issue have
> agreed that it's their issue and will be fixed. If we work around it
> now, they have no incentive to fix their implementation. We have a bit
> of market power here to push in the right direction, rather than piling
> on workarounds on our side.
>
>
> However, if in fact it later turns out that there are unfixable APs out
> there, then given the reasoning I outlined above for how your
> argumentation is wrong, I think the only plausible workaround would be
> to (erroneously!) inherit the vendor WMM element from the transmitting
> BSS, rather than making assumptions about it. We'd also have to do this
> for change tracking which makes it all the more complex, and certainly
> wouldn't want to apply it in strict mode.
>
> johannes

