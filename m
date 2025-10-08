Return-Path: <linux-wireless+bounces-27893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60779BC690B
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 22:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DED584E24E6
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 20:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021F127AC45;
	Wed,  8 Oct 2025 20:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=govivid-ai.20230601.gappssmtp.com header.i=@govivid-ai.20230601.gappssmtp.com header.b="ejrUHRvP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AF628642B
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759954930; cv=none; b=HUdEN/ni+ESuay3OcPZZIL6GGgF4CUisRPgzLhjxjnKQOdXBjSHC9MMhK3nbv0eJjzYc6Uxz/9RxTJSO86lwiha5pQTy5GsLS5SCOWPZkQs3oQGMg3vG8CFH+vx3Qn8ALT/TGR8KApiSDkV+23WGaT15rE0kForcVxRFLPWGLwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759954930; c=relaxed/simple;
	bh=puSg/lQO8ygBa3eA22URg5jUY+paghrDl1XlMy1GSqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEzUENI1LlAyjEKbm7GDsnQ5QhHv0bgW+989lwfYf9OMUgr/fHj+i/SY8ChHxoLZ/Rz/Xyc3/7Tz2q59WJ8Bkd7d127WwbYa7y6/QwoQkGGCzmCNNu94SLgc+XmEblhgOLAaZs9JKLrCAV3wMvgIcqcq9UDkELwzXoGFEIbmQX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=govivid.ai; spf=pass smtp.mailfrom=govivid.ai; dkim=pass (2048-bit key) header.d=govivid-ai.20230601.gappssmtp.com header.i=@govivid-ai.20230601.gappssmtp.com header.b=ejrUHRvP; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=govivid.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=govivid.ai
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-79390b83c7dso2562726d6.1
        for <linux-wireless@vger.kernel.org>; Wed, 08 Oct 2025 13:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=govivid-ai.20230601.gappssmtp.com; s=20230601; t=1759954926; x=1760559726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25qMuzpGcNHSTEbT3R9d9+5ATFcD7MyEFcRkiV8vMp0=;
        b=ejrUHRvPWwQpddwq594cE3rV3RzJtr0yPHIteMNMKQfgovZyMGu42uPrnq4gzxaPK5
         nKi6YbP8hike9IamKEdDpNsOhQJXlDWbXrNqFouJXbuNfZGnXfJZYomk58L7WEzR0Sjc
         5FeJzmU63Kqk/zNchChZJyXhkMn7RExHRfzlxpwmKPPJpfi8s7avPrZm14WdSFnBclPg
         xb8bJPtjlpnooxLpuPhuTKaRVS/RWjS30AEPSL5uHktmjCYfVDiPUDvyppR1KJ3QvDGo
         Gs3c8eENGHwn65U96hbe+s+GihnVsWmIkHGL6B7Nmkw8hBE9YIj8eOfLOBd37Wp75iRq
         /kZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759954926; x=1760559726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25qMuzpGcNHSTEbT3R9d9+5ATFcD7MyEFcRkiV8vMp0=;
        b=qSDE8NEqufnyGeGQzdwDR9BoYoEuwgBkA/lI3LdIUlHWKQ1O8OdGm+HzExUzlx6F9P
         /8d48VAfsXT1lu8we9/6mersvG694jmftEAPAIeRbSh7pDUD966Ik+4IPXBcHV2X1S8C
         TnEuHJGazP4zQ9yL4lxiR/aazZm5WnTVgP86t9CK+1Ss2ZkjfTz83vgoQ+esOoAXZWtT
         urefkOSUwPdFjRhGimZoAm+yCs46q49ANHtyplcxgKtRZDaQm7mMGNIFYoCewBMxDwyk
         VLz22RtKDB6oqUMycvFGEQG6SV1r4uHHJvv0fdcoQxitib15hgRfN3e/h9BFgX0UF+sZ
         VrSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQj7g4Ws8zNBTTD8zogmrajPw63kxxiBhIG/fg7U2zlQ440ja4pcCglrreIf3SCl+aJAk7Z+VkWmXTPTYLgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywep2HoRKPl9hdiQYyyQi8gtAdzZ1jrtEF5cvbDXDEwczAF4+Vp
	NiWqgqJW8rZGOKYyS5zmEySJ9Zui8oIyHAaxyBbJigEI+5X6Bfq9qYGGYvOqxrJrSwU4khaKz+w
	mO6KnnFt/CpytuRqsZuX1bDtTDJ04E/t87UYu6BHH7g==
X-Gm-Gg: ASbGncsJq742tSPjou4GYL1V7Ik+Nk6O1EgeQi63YF4nT/6JW/xkjBtKHBTchi5ZOPU
	kdiTgUmf1/V3j/8hKO+b1lDseJXDLwLB4jQP/5dhlXyVCZMq9fb922PHEPhV5n3i3xq+weADSnF
	Lj5pttVs6oKQ4PpFPfTfQwujZoH3fGqS48KL2641jhlIoFWDPjm/cKAbC82//op1W3iTCxcf9oD
	+jBg91hYyfr89JKXQBUsKbjwrKkeARTY6rGIMKQ
X-Google-Smtp-Source: AGHT+IEcBAAvWdzvqH7WgyMVJiYVQXJj0ztgGwGMsV1ShSizbLJ+8NOGOnYK6J4Pq89/DB4JuHumtxxs9uhfZkJJn6A=
X-Received: by 2002:ad4:4ee5:0:b0:86c:1f66:e2eb with SMTP id
 6a1803df08f44-87b2ef6c75amr57102176d6.33.1759954926359; Wed, 08 Oct 2025
 13:22:06 -0700 (PDT)
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
 <281c880e-9e7b-4826-a275-0d02a040a37c@gmx.net> <CAFwtOaU3tDrKhwdAGi=C0-YJiZJzatBQiRRjsLQSiGC_4CUWPw@mail.gmail.com>
 <77ace9a0-ca88-473a-85f3-967d90f28411@broadcom.com>
In-Reply-To: <77ace9a0-ca88-473a-85f3-967d90f28411@broadcom.com>
From: Richard Reigh <richard@govivid.ai>
Date: Wed, 8 Oct 2025 15:21:55 -0500
X-Gm-Features: AS18NWCf9iFwWA-dGVCQJHBC-rl2zDD6qWy8xKDaVyOuufS6WS_jau41UkS2Asc
Message-ID: <CAFwtOaXYUtP0kO4+v=RL+6oKHw5t0tXb-MDms7tbnJJXS9c9SA@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: Fix NULL pointer dereference in P2P action
 frame handling
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, brcm80211-dev-list.pdl@broadcom.com, 
	brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org, 
	chris@streetlogic.pro, s311332@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 1:47=E2=80=AFPM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 10/6/2025 8:37 PM, Richard Reigh wrote:
> > On Mon, Oct 6, 2025 at 12:28=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net=
> wrote:
> >>
> >> Am 06.10.25 um 19:08 schrieb Richard Reigh:
> >>> On Mon, Oct 6, 2025 at 10:47=E2=80=AFAM Stefan Wahren <wahrenst@gmx.n=
et> wrote:
> >>>> Hi Richard,
> >>>>
> >>>> Am 04.10.25 um 11:22 schrieb Arend van Spriel:
> >>>>> On 10/3/2025 7:02 PM, Stefan Wahren wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> Am 03.10.25 um 18:00 schrieb Arend van Spriel:
> >>>>>>> Op 3 oktober 2025 01:20:21 schreef Richard Reigh <richard@govivid=
.ai>:
> >>>>>>>
> >>>>>>>> When iPhones query network information via the WiFi settings "i"
> >>>>>>>> button,
> >>>>>>>> the brcmfmac driver crashes with a NULL pointer dereference. Thi=
s
> >>>>>>>> occurs
> >>>>>>>> because the P2P device vif is not initialized when handling cert=
ain
> >>>>>>>> action
> >>>>>>>> frames.
> >>>>>>> That does make a lot more sense than the line that gdb gave me wi=
th
> >>>>>>> my driver rebuild attempt.
> >>>>>>>
> >>>>>>>> Add NULL check for vif before dereferencing in
> >>>>>>>> brcmf_p2p_tx_action_frame()
> >>>>>>>> and return -ENODEV when vif is NULL. Also modify
> >>>>>>> Now I don't think it is necessary to bail out here. See my
> >>>>>>> suggestion below...
> >>>>>>>
> >>>>>>>> the retry loop in
> >>>>>>>> brcmf_p2p_send_action_frame() to stop immediately on permanent
> >>>>>>>> failures
> >>>>>>>> rather than retrying.
> >>>>>>>>
> >>>>>>>> Tested on Raspberry Pi Zero 2 W with kernel 6.1.21-v8+
> >>>>>>>>
> >>>>>>>> Signed-off-by: Richard Reigh <richard@govivid.ai>
> >>>>>>>> ---
> >>>>>>>> .../wireless/broadcom/brcm80211/brcmfmac/p2p.c   | 16 ++++++++++=
+++++-
> >>>>>>>> 1 file changed, 15 insertions(+), 1 deletion(-)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2=
p.c
> >>>>>>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> >>>>>>>> index 10d9d9c63..2c73156fa 100644
> >>>>>>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> >>>>>>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> >>>>>>>> @@ -1559,6 +1559,12 @@ static s32 brcmf_p2p_tx_action_frame(stru=
ct
> >>>>>>>> brcmf_p2p_info *p2p,
> >>>>>>>> else
> >>>>>>>> vif =3D p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
> >>>>>>>>
> >>>>>>>> + /* add NULL check */
> >>>>>>>> + if (!vif) {
> >>>>>>>> + brcmf_err("vif is NULL, cannot send action frame\n");
> >>>>>>>> + return -ENODEV;
> >>>>>>>> + }
> >>>>>>> Instead of giving up and surrender we can use primary vif, ie. p2=
p-
> >>>>>>>> bss_idx[P2PAPI_BSSCFG_PRIMARY].vif:
> >>>>>>> if (!vif) {
> >>>>>>>          brcmf_dbg(TRACE, "no P2P device setup\n");
> >>>>>>>          vif =3D p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
> >>>>>>> }
> >>>>>> this looks much better. But the whole patch needs a fixes tag.
> >>>>> Sure.
> >>>>>
> >>>>>> In case this issue is reproducible before Linux 5.8, the tag shoul=
d
> >>>>>> reference:
> >>>>>> 18e2f61db3b7 ("brcmfmac: P2P action frame tx.")
> >>>>>>
> >>>>>> otherwise it should reference:
> >>>>>> d524d5ce3655 ("brcmfmac: p2p cert 6.1.9-support GOUT handling p2p
> >>>>>> presence request")
> >>>>> Both good suggestions. Looking at the code I would say that
> >>>>> 18e2f61db3b7 ("brcmfmac: P2P action frame tx.") is the best choice.
> >>>> thanks. @Richard Do you plan to submit a V2 patch?
> >>>>
> >>>> Best regards
> >>>>> Regards,
> >>>>> Arend
> >>> Stefan,
> >>>
> >>> Yes, I plan on submitting a V2 patch, after I finish testing the chan=
ge.
> >>>
> >>> I will also add the suggested fixes tag to the patch submission.
> >> Sure, take your time.
> >>
> >> Thanks
> >>>
> >>> Thanks,
> >>> Richard
> >
> > Hi Arend and Stefan,
> >
> > Thank you for the feedback on V1. I've tested the suggested fallback
> > to PRIMARY vif, but unfortunately it still crashes with a NULL pointer
> > dereference.
> >
> > The PRIMARY vif itself is not NULL (confirmed via debug output), but
> > using it for P2P action frames causes a crash later in
> > brcmf_p2p_tx_action_frame(). It appears the PRIMARY vif may not have
> > the necessary P2P-specific structures initialized.
> >
> > Should I:
> >
> > 1. Investigate which specific pointer/structure is NULL when using
> > PRIMARY vif for P2P operations, or
>
> I would be interested to see the log of the "PRIMARY vif" tesing if you
> still have it.
>
> Regards,
> Arend

Unfortunately, I don't have any logs for this test. When the bug occurs, th=
e
Pi immediately becomes unstable and is unable to sync files to disk, so no
logs are preserved.

Richard

