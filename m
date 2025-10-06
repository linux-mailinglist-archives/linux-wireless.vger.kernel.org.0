Return-Path: <linux-wireless+bounces-27830-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 980C0BBF003
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Oct 2025 20:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7515E3C4BBB
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Oct 2025 18:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0051323A58E;
	Mon,  6 Oct 2025 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=govivid-ai.20230601.gappssmtp.com header.i=@govivid-ai.20230601.gappssmtp.com header.b="0c+opanG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D172423F405
	for <linux-wireless@vger.kernel.org>; Mon,  6 Oct 2025 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775870; cv=none; b=opBNv2b7I1VS2BUFbBKEaGM00VEDPrRH1re/SgcrM8hn/kRbUt47E8mQypAtKG3mXYB8J5uL4qFbCMKjHTcUvXo9Bke04L8NNo+0N1n54OP9krd2QVnSIBO++L4M8A+iItksP1qaD2IVHh+Q6/VHFDvtt3exVfrWzs07PXWmTR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775870; c=relaxed/simple;
	bh=MDBrUUeUYoZuosC84hXXTbvcdw4O64pL/DYatZlsBi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bciazdjo6B7VvPGWm13leo3y9+YZGFHLCBPvzN91W4zD+f2X/FK0AKtF9ciBSJUBFFlSYHLP7oLUje400UjIEGW27T6ZIFZlvOX1Hq92GTlPWPDME0RSDNZOOP+CK3xkytVd25XQNAv1ClyxDBbNRqajEtxl+c3pLsVWpWPrTos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=govivid.ai; spf=pass smtp.mailfrom=govivid.ai; dkim=pass (2048-bit key) header.d=govivid-ai.20230601.gappssmtp.com header.i=@govivid-ai.20230601.gappssmtp.com header.b=0c+opanG; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=govivid.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=govivid.ai
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70ba7aa131fso57688186d6.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Oct 2025 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=govivid-ai.20230601.gappssmtp.com; s=20230601; t=1759775868; x=1760380668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdQkf2W/SITDYUv48mISnVDm8Y7RJzreE8w3WJ7uoGQ=;
        b=0c+opanGOFHA6kDlTtZ0MOGee0GyjmN2SwQjoPVNtnv01vr+z9e0WTRdZ5jCZ6EKrw
         f7wSmBfbPtatMKUgy7fgySa0kXKGxgaOBbEZ4qO+YOw7wFJA5A28Q9Wsv27c/oaZ/2Vc
         ouFmb7t+ybe2LynrXmF6mlEVsDgR7s6CJ/Bsw97PhNRe+dOMJclCoxYDwro8GyU/8GPp
         u1rjRsA8T0O/tIwZjPCSfzheOcMPCb25qwLTswy9PHnsS2+QmjXN3igid5Ble/MPXSyG
         06dBUdHSmK5bf+MSzANyQf48wWUj1qiaoY43mu8PBDpRIg/RgPzXZ/JmWaf6TfitVqm5
         mPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759775868; x=1760380668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdQkf2W/SITDYUv48mISnVDm8Y7RJzreE8w3WJ7uoGQ=;
        b=WFRiQY84+MaZSaybBdef2aEvMDeC3NarbjTIIsbPBfxbxtsM1vgc/vILXHAFHsiQmJ
         1WvbnZj54ZBLcjvKRq7D/+WLV8GwfUMDlg31Urw8fST7f8Ir9VbhPiTE0Ry1ACACv+6+
         VccCMQjHq3d0GOCRl1XN5P8xA5oed1sdeIIFoVCztgikzk3pRCWvdrI9EaztwYZA08j6
         6xTLnWXD556xSgaoxw967fM4ox/ZbI7kz0KzxV3YFDukiMbdZv/MHg4oAJ/jrwC2QQ9l
         1Qxr5xDfKr8v/jXt5OxnYltEkkmEKgWxl4Xi63CnPngkIlASEdba0nWJZKnLY1ZcHtgz
         KsOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPchb7DhA+X8F7yk73RXQxhWx4HuslQdL3vPxE2dlbTGznjg3zKaAdjlA8IkiBhLIHxHYZvS36VyCJupy1Lw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFD1hVlK2bSE5bZ0StGXxIyH83tNRCfKBYOT43hpP3W7D2SDhN
	f+mTQtn5aNbnbj4m1krufxt+WLEnPIUVV6ea9MHcAFoBacfrCR4a+LBLtdTWBJcsU8X6e5p5Hjg
	09Re10dbkS1e5JCAFgfTLMCQRmlCnRkA+p2upTjZSikIEqNj5hd5fqS0=
X-Gm-Gg: ASbGncvBYRLMWEd1L4EtRXLZuH3Ap1kkpIyBDx2y1UNVF+Zq7uFNpH82Kk+xDklsmFh
	MhbFNnSVLHGYv4dK4nQE/dTfaFRJirKeGwZ1/qjY6V2Js+XhU8TYimlJvgSejaYWr0BrF37hAxg
	SG2ot9YeklJBuMBOac2NDUQATpOJWjDYohWnOxAaDLZ/exp+o2M4IWYglKCvVJefndn1gBVlwoJ
	MVQ5Tl8K8W79xGhEhO0COLGrVYQKv5E6FYDIH6/
X-Google-Smtp-Source: AGHT+IEwTAsifaAhROaXwdZq0PpWhBQB02fOTwducUYRuIMNyBrqwAdM/26sHeGR3NxhZHe/U2Z/ogZzVjt+PUfEykk=
X-Received: by 2002:a05:6214:5299:b0:80d:82af:c3dc with SMTP id
 6a1803df08f44-879dc79bacemr196514756d6.25.1759775867414; Mon, 06 Oct 2025
 11:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b2e0bf04-f149-4a23-aba5-cad55a8923c1@broadcom.com>
 <20251002232002.124609-1-richard@govivid.ai> <199aacd7e50.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <d1510cb6-a613-4e22-91aa-4fee1fdfa29b@gmx.net> <1bb08036-2569-454a-bd26-f1d713b4c299@broadcom.com>
 <f0352cba-0810-43c3-9c53-baa012f93513@gmx.net> <CAFwtOaWsS5U-gb3=DM0QZ6MuZgAHV-O-qLtC9-npQEjGsog1AA@mail.gmail.com>
 <281c880e-9e7b-4826-a275-0d02a040a37c@gmx.net>
In-Reply-To: <281c880e-9e7b-4826-a275-0d02a040a37c@gmx.net>
From: Richard Reigh <richard@govivid.ai>
Date: Mon, 6 Oct 2025 13:37:36 -0500
X-Gm-Features: AS18NWBoV71-FXxOb20Pb0lPHotllN7kxx0O2j9pHRk2-OKvCL4iWkwHY-QS1_c
Message-ID: <CAFwtOaU3tDrKhwdAGi=C0-YJiZJzatBQiRRjsLQSiGC_4CUWPw@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: Fix NULL pointer dereference in P2P action
 frame handling
To: Stefan Wahren <wahrenst@gmx.net>
Cc: brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev, 
	linux-wireless@vger.kernel.org, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, chris@streetlogic.pro, s311332@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 12:28=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net> wr=
ote:
>
> Am 06.10.25 um 19:08 schrieb Richard Reigh:
> > On Mon, Oct 6, 2025 at 10:47=E2=80=AFAM Stefan Wahren <wahrenst@gmx.net=
> wrote:
> >> Hi Richard,
> >>
> >> Am 04.10.25 um 11:22 schrieb Arend van Spriel:
> >>> On 10/3/2025 7:02 PM, Stefan Wahren wrote:
> >>>> Hi,
> >>>>
> >>>> Am 03.10.25 um 18:00 schrieb Arend van Spriel:
> >>>>> Op 3 oktober 2025 01:20:21 schreef Richard Reigh <richard@govivid.a=
i>:
> >>>>>
> >>>>>> When iPhones query network information via the WiFi settings "i"
> >>>>>> button,
> >>>>>> the brcmfmac driver crashes with a NULL pointer dereference. This
> >>>>>> occurs
> >>>>>> because the P2P device vif is not initialized when handling certai=
n
> >>>>>> action
> >>>>>> frames.
> >>>>> That does make a lot more sense than the line that gdb gave me with
> >>>>> my driver rebuild attempt.
> >>>>>
> >>>>>> Add NULL check for vif before dereferencing in
> >>>>>> brcmf_p2p_tx_action_frame()
> >>>>>> and return -ENODEV when vif is NULL. Also modify
> >>>>> Now I don't think it is necessary to bail out here. See my
> >>>>> suggestion below...
> >>>>>
> >>>>>> the retry loop in
> >>>>>> brcmf_p2p_send_action_frame() to stop immediately on permanent
> >>>>>> failures
> >>>>>> rather than retrying.
> >>>>>>
> >>>>>> Tested on Raspberry Pi Zero 2 W with kernel 6.1.21-v8+
> >>>>>>
> >>>>>> Signed-off-by: Richard Reigh <richard@govivid.ai>
> >>>>>> ---
> >>>>>> .../wireless/broadcom/brcm80211/brcmfmac/p2p.c   | 16 ++++++++++++=
+++-
> >>>>>> 1 file changed, 15 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.=
c
> >>>>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> >>>>>> index 10d9d9c63..2c73156fa 100644
> >>>>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> >>>>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> >>>>>> @@ -1559,6 +1559,12 @@ static s32 brcmf_p2p_tx_action_frame(struct
> >>>>>> brcmf_p2p_info *p2p,
> >>>>>> else
> >>>>>> vif =3D p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
> >>>>>>
> >>>>>> + /* add NULL check */
> >>>>>> + if (!vif) {
> >>>>>> + brcmf_err("vif is NULL, cannot send action frame\n");
> >>>>>> + return -ENODEV;
> >>>>>> + }
> >>>>> Instead of giving up and surrender we can use primary vif, ie. p2p-
> >>>>>> bss_idx[P2PAPI_BSSCFG_PRIMARY].vif:
> >>>>> if (!vif) {
> >>>>>         brcmf_dbg(TRACE, "no P2P device setup\n");
> >>>>>         vif =3D p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
> >>>>> }
> >>>> this looks much better. But the whole patch needs a fixes tag.
> >>> Sure.
> >>>
> >>>> In case this issue is reproducible before Linux 5.8, the tag should
> >>>> reference:
> >>>> 18e2f61db3b7 ("brcmfmac: P2P action frame tx.")
> >>>>
> >>>> otherwise it should reference:
> >>>> d524d5ce3655 ("brcmfmac: p2p cert 6.1.9-support GOUT handling p2p
> >>>> presence request")
> >>> Both good suggestions. Looking at the code I would say that
> >>> 18e2f61db3b7 ("brcmfmac: P2P action frame tx.") is the best choice.
> >> thanks. @Richard Do you plan to submit a V2 patch?
> >>
> >> Best regards
> >>> Regards,
> >>> Arend
> > Stefan,
> >
> > Yes, I plan on submitting a V2 patch, after I finish testing the change=
.
> >
> > I will also add the suggested fixes tag to the patch submission.
> Sure, take your time.
>
> Thanks
> >
> > Thanks,
> > Richard

Hi Arend and Stefan,

Thank you for the feedback on V1. I've tested the suggested fallback
to PRIMARY vif, but unfortunately it still crashes with a NULL pointer
dereference.

The PRIMARY vif itself is not NULL (confirmed via debug output), but
using it for P2P action frames causes a crash later in
brcmf_p2p_tx_action_frame(). It appears the PRIMARY vif may not have
the necessary P2P-specific structures initialized.

Should I:

1. Investigate which specific pointer/structure is NULL when using
PRIMARY vif for P2P operations, or
2. Stick with the original approach of failing gracefully with -ENODEV
when DEVICE vif is unavailable?

My original fix (returning -ENODEV) does prevent the crash and allows
the system to continue operating normally, just without responding to
that particular iPhone query.

Best regards,
Richard

