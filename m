Return-Path: <linux-wireless+bounces-27827-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B22FBBEC79
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Oct 2025 19:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E930F4E4353
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Oct 2025 17:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE322236EE;
	Mon,  6 Oct 2025 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=govivid-ai.20230601.gappssmtp.com header.i=@govivid-ai.20230601.gappssmtp.com header.b="JpJzl9jb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEEB22423A
	for <linux-wireless@vger.kernel.org>; Mon,  6 Oct 2025 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759770509; cv=none; b=pTsPiX+TdNIvDRxScHRUOU3j89nIwuuIBxyP9/tiNR2d+ynL/cWhdup9loMGpFIdsgdPo56FH11Ktsowb8WKqaXjNc/3IuJCg5rarI1cHOLH1HCH0eIfmvLoA4yAo3UkJ/vZfyjcR9v8CASgKH9YHdtHTMzr29bLNIbGPESRQXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759770509; c=relaxed/simple;
	bh=LPfq4U82XXoYU9A5D1nK1Jhh2kciTHvkTM4GcmcSSvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nq88lW3Fp8M8NiClzHQuMevnecjeXXFlMiRHraHjfrYlbHoE0LrzIZSnDi18DZBGMjldUOmM1WAAWPxtIuUTM3yiR3Yg+g9/EYcX3TZ69BZqgzzjCJUDeoQaUaenALNu2+ytMKC9j9bOK2xOMURa/WS7QlhUF/LlqQViGGk3jXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=govivid.ai; spf=pass smtp.mailfrom=govivid.ai; dkim=pass (2048-bit key) header.d=govivid-ai.20230601.gappssmtp.com header.i=@govivid-ai.20230601.gappssmtp.com header.b=JpJzl9jb; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=govivid.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=govivid.ai
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-791fd6bffbaso63039596d6.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Oct 2025 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=govivid-ai.20230601.gappssmtp.com; s=20230601; t=1759770506; x=1760375306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B80olGo7V8PAVZoOCsY/kEK3EwMmaT8KEM2n2VEV6PY=;
        b=JpJzl9jbBz6P/Jf/n7FqjRrOsgEf3OHxs2qEcfyiLN0kIvWzmKEMHMJTcrN8GgcGbM
         Bmog68cg23BaD5r3O4NmKLifCEAEl06hwOhL+vR7cL1tKQ7e95Rns9N781dhl2G2ySxX
         MrtpvHrOfrxPIPZTfhncErL9ptYcddt+mdw4jNBIWyA0mCcWENj1qKjXXk1u4ALvK2gw
         PqczVkeXhZBofHbWfZQ015ndUCY/rZLhcfNXPOfSKaeOjnHIURObyRALpzqJyOKFfWbh
         0F1m53+03bjTn8fcokNKRRuDw4EYwlGhStGwa/Rk+mHXxo6VKJr+SgsuMiFxlLryYqYV
         dk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759770506; x=1760375306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B80olGo7V8PAVZoOCsY/kEK3EwMmaT8KEM2n2VEV6PY=;
        b=eBL8kQPJe9vnrRtcTSDgNm6dxRL2Lm1zsRlDmdHVLQwGLglUjww6DbaultWoBB8B+Q
         BeV6BRMAGl3r80vtV1l/QxkTLv2lKXDBVUvNi8GKOi2gCNMoZijWRNGehr6osK1nroLM
         Ysav/VLihSgfzhq+w1Kt2jeU+akrgO8SdYh/xh3jZWAobxI/hGgvwRF89In+d8UZT4zt
         ogWB8+Ah9YLWDhxSzFIC5tHLdiqps95Fq1wDLk6HIRPuXtXqsy0p5AYeWimORKl7hF1S
         0A5Zq1AYkfUkClZRmNO3u5BQkYLrn2ylmOOn6QmpiC0+XTY97vv9E+46To9EWvFhtbzp
         OUaw==
X-Forwarded-Encrypted: i=1; AJvYcCWaZZFH6shSWExZUnNNMyEYNzwXtAHUbSi+w28VrBCYjskZLyKlEYBSJ5F3tmgyBCmh9PShlqI6lrv0HVTmQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRSYyz05YvAoMdaJBuiYGPv6F89PFesIXU7O7ax4bbm7A2ptLt
	Nb7XS6Z0H+8E9rVpy1NeLPmISfJG8w1jzJBglOhyMmaGuxTqjSkuNdKqUk4XmRvRcQcOm1bXo25
	EnWDdzlNI9hItiyglKH8Axco/f0F3Su0w9gGNLkdQ5w==
X-Gm-Gg: ASbGnctxhqBFcVniaxoo9NX9J3s5pk/LAfX8rB7GHeu2MOr8Jn0HOokefAjWlrduvBG
	PHQYidoWJgl1LK6Ritzb4C2AcmdLawLEd3eJGqm3R4oZQzchJMi5HtHxOFDz7ZiMi+xq5ZvrcxO
	IasX3cN42UWnJQMwIZF+5QRoEhQxQqReFUbsOlpeawOR9bOtDq2jiMI0+ditdQjomRtrL5DGFe7
	Uz4eGYM/fTEeZPBATQ5/wKQrIyrQjec57pBv1V8
X-Google-Smtp-Source: AGHT+IEoVNWlBEybOWtlZ7FOae3aeEOebdtOGbgrwSy2plolnz7CqjmMItV3GWiqXcLaUQ75echVDB6w3IoMecznuWM=
X-Received: by 2002:a05:6214:258c:b0:777:4a0:9b1 with SMTP id
 6a1803df08f44-879dc861477mr188984026d6.55.1759770506227; Mon, 06 Oct 2025
 10:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b2e0bf04-f149-4a23-aba5-cad55a8923c1@broadcom.com>
 <20251002232002.124609-1-richard@govivid.ai> <199aacd7e50.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <d1510cb6-a613-4e22-91aa-4fee1fdfa29b@gmx.net> <1bb08036-2569-454a-bd26-f1d713b4c299@broadcom.com>
 <f0352cba-0810-43c3-9c53-baa012f93513@gmx.net>
In-Reply-To: <f0352cba-0810-43c3-9c53-baa012f93513@gmx.net>
From: Richard Reigh <richard@govivid.ai>
Date: Mon, 6 Oct 2025 12:08:14 -0500
X-Gm-Features: AS18NWBlXHG_JoHopNTGi0I3pkA03gVQfLpwK50etOFcZkIHrMXh7jzgXNWlUho
Message-ID: <CAFwtOaWsS5U-gb3=DM0QZ6MuZgAHV-O-qLtC9-npQEjGsog1AA@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: Fix NULL pointer dereference in P2P action
 frame handling
To: Stefan Wahren <wahrenst@gmx.net>
Cc: brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev, 
	linux-wireless@vger.kernel.org, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, chris@streetlogic.pro, s311332@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 10:47=E2=80=AFAM Stefan Wahren <wahrenst@gmx.net> wr=
ote:
>
> Hi Richard,
>
> Am 04.10.25 um 11:22 schrieb Arend van Spriel:
> > On 10/3/2025 7:02 PM, Stefan Wahren wrote:
> >> Hi,
> >>
> >> Am 03.10.25 um 18:00 schrieb Arend van Spriel:
> >>> Op 3 oktober 2025 01:20:21 schreef Richard Reigh <richard@govivid.ai>=
:
> >>>
> >>>> When iPhones query network information via the WiFi settings "i"
> >>>> button,
> >>>> the brcmfmac driver crashes with a NULL pointer dereference. This
> >>>> occurs
> >>>> because the P2P device vif is not initialized when handling certain
> >>>> action
> >>>> frames.
> >>>
> >>> That does make a lot more sense than the line that gdb gave me with
> >>> my driver rebuild attempt.
> >>>
> >>>> Add NULL check for vif before dereferencing in
> >>>> brcmf_p2p_tx_action_frame()
> >>>> and return -ENODEV when vif is NULL. Also modify
> >>>
> >>> Now I don't think it is necessary to bail out here. See my
> >>> suggestion below...
> >>>
> >>>> the retry loop in
> >>>> brcmf_p2p_send_action_frame() to stop immediately on permanent
> >>>> failures
> >>>> rather than retrying.
> >>>>
> >>>> Tested on Raspberry Pi Zero 2 W with kernel 6.1.21-v8+
> >>>>
> >>>> Signed-off-by: Richard Reigh <richard@govivid.ai>
> >>>> ---
> >>>> .../wireless/broadcom/brcm80211/brcmfmac/p2p.c   | 16 ++++++++++++++=
+-
> >>>> 1 file changed, 15 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> >>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> >>>> index 10d9d9c63..2c73156fa 100644
> >>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> >>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> >>>> @@ -1559,6 +1559,12 @@ static s32 brcmf_p2p_tx_action_frame(struct
> >>>> brcmf_p2p_info *p2p,
> >>>> else
> >>>> vif =3D p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
> >>>>
> >>>> + /* add NULL check */
> >>>> + if (!vif) {
> >>>> + brcmf_err("vif is NULL, cannot send action frame\n");
> >>>> + return -ENODEV;
> >>>> + }
> >>>
> >>> Instead of giving up and surrender we can use primary vif, ie. p2p-
> >>> >bss_idx[P2PAPI_BSSCFG_PRIMARY].vif:
> >>>
> >>> if (!vif) {
> >>>        brcmf_dbg(TRACE, "no P2P device setup\n");
> >>>        vif =3D p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
> >>> }
> >> this looks much better. But the whole patch needs a fixes tag.
> >
> > Sure.
> >
> >> In case this issue is reproducible before Linux 5.8, the tag should
> >> reference:
> >> 18e2f61db3b7 ("brcmfmac: P2P action frame tx.")
> >>
> >> otherwise it should reference:
> >> d524d5ce3655 ("brcmfmac: p2p cert 6.1.9-support GOUT handling p2p
> >> presence request")
> >
> > Both good suggestions. Looking at the code I would say that
> > 18e2f61db3b7 ("brcmfmac: P2P action frame tx.") is the best choice.
> thanks. @Richard Do you plan to submit a V2 patch?
>
> Best regards
> >
> > Regards,
> > Arend

Stefan,

Yes, I plan on submitting a V2 patch, after I finish testing the change.

I will also add the suggested fixes tag to the patch submission.

Thanks,
Richard

