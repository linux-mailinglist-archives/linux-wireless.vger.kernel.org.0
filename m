Return-Path: <linux-wireless+bounces-12613-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5279596FC58
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 21:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB4B1C20F0F
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 19:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A9C157494;
	Fri,  6 Sep 2024 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FC/E84qP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBE96EB7C
	for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2024 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725652182; cv=none; b=Vd7MyeDzUX8aDn741DQEScrqGZ34tnn9WDq/ggfxOFEXbSQWFNTFC8r+qcv0kkJW5ru+qSbZJnE5Fes3mbbNy5XTFJe7DSj9g9uTiIzZ5NTjsARIl3Obl+A53/w7rtQ32HQwR9t3rit2U0Ky0VDM8/8zObTwQM3h8J4RuYxIPCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725652182; c=relaxed/simple;
	bh=g8NquaYswK2He4LqxY7tYLpw63f6mWpxBGp2IEjqAc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWqzGrfgi0cQhjM2OuYmXy7vUljxG2KD8tDFHXQj9Ny/AnNsATVblKDVI209A4NLfpBnS2XQwulJ+dQkDlEOKj6VZmAeJo0jYA3fEdNk6+Aoq4Rpg58bTmLwYzqijOg5boiys+t0AQyCS1oBPgMIk6LRas5KCjvirMwtrloZbiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FC/E84qP; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6d47d860fc4so19838527b3.3
        for <linux-wireless@vger.kernel.org>; Fri, 06 Sep 2024 12:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725652180; x=1726256980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pqy0BR+oHLzwn7Hg1CaytGNGMKYu50/WwW+FZub/dx4=;
        b=FC/E84qPGdBU4f72dKDImCTKrz7FudRdXbZm4yWezLprrdRtTYk/kzvqSPVZRIvy4g
         LfE50ou+uSJLurTTZNHkRSu59uyXhX9WH9vfUdar09fuglewlz0UayLQIazU6naRdqf/
         8wBkArvciNPUe5C9QvD0AenBZjkvmWOo/NKHUMowH5h3DhnWzn6X80exBFqY1ijsEfrN
         xGSJfGznJj5l9J46VcM2I+MtSZ9u77HpKICs3zAI5qw5aFxuX6ceoJZujLIixH1HBG2f
         RPttjmz0HFQ8YDqHE3ZjHJ2RYwOmRezld/71pqSxEvmWSKKFluK61AA1GNAIYdWM3oWI
         b9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725652180; x=1726256980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pqy0BR+oHLzwn7Hg1CaytGNGMKYu50/WwW+FZub/dx4=;
        b=Se3d5CcvgHkDctX9XPrBb3/yt3GKcWupSv0knqPjlyd+cOuuKisG2Apa6Pzv0pb6UN
         O3OCd/xPxwoXVgbNzQTHlNBReajASHcNy/YwJhEHC13oX9KuZccBPE8i5wCrwORer6xj
         +WM9zCkXm4PMkg+DFj6oj1UFFm2B4A0BW4dtUpfK9DMJ0zJPpjKSVhyF+1lgDLQ/rtpL
         qL9r06Rs+3bEBDpdOvMAxFO1CMM4GJn7DrR1CUlN7X3I2qFs1Px6UyuHmgIfm2+DJe5x
         wpv4cNzgpc6owjyPGg4CCDKJkW5WbqWep0qcMeYBCTdvXJ1Y8YbY/jYo2gyZXww0RT98
         DNQQ==
X-Gm-Message-State: AOJu0Yw0jD8VO/AGYe37BdjDqXGVUxzloJ92AjhSHUgkJPPSiJMNWghy
	oCQ6ebaoh5rHZXPTZ7lQnR22pVdr8S0aSbi92L52vWf1OZZfE+OdVT0KWh4m0YFj1Iem4Tct1Ki
	mu3tKsCkaqObmTKiv6kfABvSHpVbpJ0fU
X-Google-Smtp-Source: AGHT+IFtEA73oUwbmzyd1heF4Z87Ri7wKfJ1AAkRbwOoWt+AbyIcZ2OwNhUwxFfASMeV8Uot+PzlmyjWxP0Dl3BB4Kg=
X-Received: by 2002:a05:690c:2b05:b0:6b0:d9bc:5a29 with SMTP id
 00721157ae682-6db452c39dbmr40255167b3.32.1725652180169; Fri, 06 Sep 2024
 12:49:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905180928.382090-1-rosenp@gmail.com> <20240905180928.382090-5-rosenp@gmail.com>
 <b666cc28-af93-4b7b-a446-adf3d1ef0fe0@kernel.org> <CAKxU2N_nAor8SjzSH2_0ch3Sp1XScP64DK6Ni6j-2wa8nBrMUw@mail.gmail.com>
 <4241565c-c09a-4364-be02-d11d80d57b2c@kernel.org>
In-Reply-To: <4241565c-c09a-4364-be02-d11d80d57b2c@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 6 Sep 2024 12:49:29 -0700
Message-ID: <CAKxU2N9C28YAFEkV39gNaADZOcqNKGCrzgf=jbNyzLs7LfD99A@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: net: wireless: ath9k: add new options
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-wireless@vger.kernel.org, kvalo@kernel.org, toke@toke.dk, 
	nbd@nbd.name, yangshiji66@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 12:18=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 06/09/2024 00:35, Rosen Penev wrote:
> > On Thu, Sep 5, 2024 at 2:29=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel=
.org> wrote:
> >>
> >> On 05/09/2024 20:09, Rosen Penev wrote:
> >>> These platform_data options are now available for OF.
> >>
> >> This explains nothing. Describe the hardware, not driver.
> >>
> >>>
> >>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >>
> >> <form letter>
> >> Please use scripts/get_maintainers.pl to get a list of necessary peopl=
e
> >> and lists to CC. It might happen, that command when run on an older
> >> kernel, gives you outdated entries. Therefore please be sure you base
> >> your patches on recent Linux kernel.
> >>
> >> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> >> people, so fix your workflow. Tools might also fail if you work on som=
e
> >> ancient tree (don't, instead use mainline) or work on fork of kernel
> >> (don't, instead use mainline). Just use b4 and everything should be
> >> fine, although remember about `b4 prep --auto-to-cc` if you added new
> >> patches to the patchset.
> >>
> >> You missed at least devicetree list (maybe more), so this won't be
> >> tested by automated tooling. Performing review on untested code might =
be
> >> a waste of time.
> >>
> >> Please kindly resend and include all necessary To/Cc entries.
> > Will do.
> >> </form letter>
> >>
> >>> ---
> >>>  .../devicetree/bindings/net/wireless/qca,ath9k.yaml  | 12 ++++++++++=
++
> >>>  1 file changed, 12 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k=
.yaml b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> >>> index 0e5412cff2bc..5c293d558a94 100644
> >>> --- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> >>> +++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> >>> @@ -44,6 +44,16 @@ properties:
> >>>
> >>>    ieee80211-freq-limit: true
> >>>
> >>> +  qca,led-active-high:
> >>> +    $ref: /schemas/types.yaml#/definitions/flag
> >>> +    description:
> >>> +      Indicates that the LED pin is active high instead of low
> >>
> >> Where is DTS user of it?
> > None at this time. There are only downstream users.
>
> We do not add stuff for downstream.
>
> >
> > This maps to the led_active_high in ath9k_platform_device , which gets
> > removed in a subsequent commit.
> >
> > drivers/net/wireless/mediatek/mt76/mac80211.c uses led-sources as the
> > name for the same purpose. Maybe rename?
>
> Again, you add undocumented, unused compatibles along with unused
> properties. We don't care about downstream kernels. You need upstream use=
rs.
OK. Will remove in v2.
>
> Best regards,
> Krzysztof
>

