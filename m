Return-Path: <linux-wireless+bounces-30025-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CDBCD308B
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 15:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A6AA302AFAF
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 14:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E450C21257E;
	Sat, 20 Dec 2025 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsT6tVcM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30451A239A
	for <linux-wireless@vger.kernel.org>; Sat, 20 Dec 2025 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766239397; cv=none; b=eFmX76vjosRJgG3jW95bx42syeR+yY5fRolhEKHgkebXi0a+orl7LCsysf5SxKhewRGFjqwmoCeFTnc357oYn6AQBLI9vRFES95fNW39AS5U8P4raOqca5BqWxLGpe/qPwJPtVYmbvxclLXsHA0bfztTmaLLooy/TwyUveOKUnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766239397; c=relaxed/simple;
	bh=U92C7ajF9y/pESK6SVDL/9uXSTMr9EvRTNP1cZpQmZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNo+a6OpHqZJ2wciVLmrNhWhS1Zg02w2JPi7AsRO0Slxm7wh5OsDGebKDBZ4HAYQ7QuzO4hY5U/0RddsFbjq+Y2/R7A9Mf5q3e/g2atQgOWILBBC2/jqpimk2ZrL6sICsgVSNk61Xm8q2HtaszTvNLz0+bbUZktyu6U21Zf+6Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsT6tVcM; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8888a444300so30682526d6.1
        for <linux-wireless@vger.kernel.org>; Sat, 20 Dec 2025 06:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766239394; x=1766844194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTIPtqzMduKujdd0veJ2LC19WzlWxxZcItU+/SfvSHQ=;
        b=jsT6tVcMNb4IkV7xg9NZmw2+gDmYL5vOhaNZy1so78ROnnVW9mF7oRbOdAIEzkcMy9
         xBDLkwrzFXtJ7yA9MhuTkL0rXBrVfmZbZG1owRbKBP4RBnJVQM4yQNmexDkCaZIej7wo
         12jWE3becB8RYY8IkbynNZqiEW5Qeip+y2jwuo4QlyIC+iMySUsnKyyQwDHVCKoDV4rd
         8r2YlhMdWz48tX5TLUEOu2uOWCgqQ45j2ICqmxi3N+6AtQwPfSMJOCnhj/FtquGRN3Wb
         0L18jv8BmZagtunARZnmtuS0+1ysqUhnps7oGaMutHcEUWiSDGP4j869IiN1YykaLkQd
         B/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766239394; x=1766844194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vTIPtqzMduKujdd0veJ2LC19WzlWxxZcItU+/SfvSHQ=;
        b=jD194EjyAI8AsyAGkTI/yIv61UzE/pDKUnrTtZECrtVFkcJH9e6A1IH/pTTZmFqYbf
         S69hAHJQkpvjRlFR3rUoddhBGE2y2ld9xGfsN/0H79Egpu3Xc1XvFnyGeaI0zxp2DaEn
         TcKpAzbXVFesFgO5hVVJq24YtEUZtilXrNz6kCp1bd/CGVJj7kX+h+ZvO9GAHSs6o3O9
         uzySKAyuf7c6lixJ0pVx8yAwHTF288hrqd2O5Opu/5yGJZ0YK+T406rAR50GBIJqo34I
         xr22n/bEDuebrk1AHbuZaDJvWajI3QdINCCszrP+boh5CxUd+mOH57XIKkq8JSvVd4U8
         dtXg==
X-Forwarded-Encrypted: i=1; AJvYcCUiiZZWGsC6PtYhacJ6OIpoUFNojlsSVRlf+yeku4SApxqvuq7mtk7CG6gM+fMrXaGlRjgSPIWp6Olz58/r5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTP8J00zWX8G2WIGukDRD6Qfh0dTRe4VcQVUHDs06UtqFPwQ/e
	wrPMt7miL8VzKuYqB1jpLc4xJ5vjKUEmD0potP9upQXxgF6ieZmxrUZzjqhM5hLfGCfSdZHXd3B
	ttgpKtJpnhVH6IbB8PFIt53heL0i2kQ==
X-Gm-Gg: AY/fxX6JFC3WioiKSlwNTBMssTNDBxQi/SD80NYzGCFTlmhbuEBA+luQA9k37fHElbO
	sZ0ovm/MApNME8K9qMRogfjSHFBGnT1fnpQFb/NZINW0z61QWHQjK7aLvCSNU/ZL8IfuZJ4Gtci
	P57OizuhId/avpoeLq1jasXQg8h2AqKJDfYkeLf4mE6f/6+ZJx9x+X38e1pwGFld8ctgskhYhXO
	fm2jy/ZAuzOIw+1uo5DVZdiKulJTW/GbOGV35JsmSHLrSs8nE2HxLsE0L+JVRbYTToEwzHIqCCX
	yj9+SLiPGFWvU9d27TCzKDfAOKI=
X-Google-Smtp-Source: AGHT+IFp4fR8Wc2qjRuYRZCvAQmroP/eyGv/wjwh1rGAG5pfcUyLHfpF6uaQ82FZr3MKIP8d6MaoUKVouxW6yw2G3dY=
X-Received: by 2002:a05:6214:248b:b0:70f:a4b0:1eb8 with SMTP id
 6a1803df08f44-88d8203f029mr99469936d6.13.1766239393583; Sat, 20 Dec 2025
 06:03:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220-surface-sp11-for-next-v5-0-16065bef8ef3@gmail.com>
 <M7kfFb5fz-WB43U_xCUwgxpmBJ4TNdp4jE6yFu6HmemIcDx5tXO6H4xnW_pEQz6DMkKm-3POdB9hIdB092zhGQ==@protonmail.internalid>
 <20251220-surface-sp11-for-next-v5-2-16065bef8ef3@gmail.com>
 <e0e9e690-c56e-4b56-90f9-2af46a7feaf3@nxsw.ie> <20251220-fervent-mamba-of-sunshine-f680a8@quoll>
In-Reply-To: <20251220-fervent-mamba-of-sunshine-f680a8@quoll>
From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>
Date: Sat, 20 Dec 2025 15:02:36 +0100
X-Gm-Features: AQt7F2qSP3aNPDvdAnYCQhdwd2yv91UgJ5ZtJLf3svJOCJgsank9Z_-67rvi34Y
Message-ID: <CA+kEDGEB-c1SuEdR4W8mnxYQLxN5bqW0v3G6wb=e+a8LY8+OTg@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] dt-bindings: wireless: ieee80211: Add
 disable-rfkill property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Bryan O'Donoghue" <bod.linux@nxsw.ie>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	ath12k@lists.infradead.org, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	Dale Whinham <daleyo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le sam. 20 d=C3=A9c. 2025 =C3=A0 10:12, Krzysztof Kozlowski <krzk@kernel.or=
g> a =C3=A9crit :
>
> On Sat, Dec 20, 2025 at 06:04:00AM +0000, Bryan O'Donoghue wrote:
> > On 20/12/2025 00:21, J=C3=A9r=C3=B4me de Bretagne via B4 Relay wrote:
> > > From: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.com>
> > >
> > > For some devices, Wi-Fi is entirely hard blocked by default making
> > > the Wi-Fi radio unusable, except if rfkill is disabled as expected
> > > on those models.
> > >
> > > Commit c6a7c0b09d5f ("wifi: ath12k: Add Support for enabling or
> > > disabling specific features based on ACPI bitflag") added a way to
> > > support features set via ACPI, including the DISABLE_RFKILL bit.
> > >
> > > Add a disable-rfkill property to expose the DISABLE_RFKILL bit
> > > equivalent for devices described by a Devicetree instead of ACPI.
> > >
> > > Signed-off-by: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.=
com>
> > > ---
> > >   Documentation/devicetree/bindings/net/wireless/ieee80211.yaml | 6 +=
+++++
> > >   1 file changed, 6 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/wireless/ieee80211=
.yaml b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> > > index d89f7a3f88a71d45d6f4ab2ae909eae09cbcaf9a..c10a4675640be947cd0b5=
eaec2c7ff367fd93945 100644
> > > --- a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> > > +++ b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> > > @@ -29,6 +29,12 @@ properties:
> > >         different 5 GHz subbands. Using them incorrectly could not wo=
rk or
> > >         decrease performance noticeably
> > >
> > > +  disable-rfkill:
> > > +    type: boolean
> > > +    description:
> > > +      Disable rfkill for some devices on which Wi-Fi would be entire=
ly hard
> > > +      blocked by default otherwise
> > > +
> > >   additionalProperties: true
> > >
> > >   examples:
> > >
> > > --
> > > 2.47.3
> > >
> > >
> > >
> >
> > Is this really a hardware description though ?
> >
> > Its really more of a logical/functional description. It tells the runti=
me
> > what todo, not what the hardware is.
> >
> > You could also have a list of quirks in ath12k for this or have a user-=
space
> > utility look for the appropriate platform device string name and disabl=
e
> > rfkill.
> >
> > I think this logic belongs in drivers/net/wireless/ath/ath12k/ triggeri=
ng on
> > a compat string.
>
> This is good point. Either this could be deducible from the compatible

Thank you Bryan and Krzysztof for your feedback, I will drop the
disable-rfkill patches from this patchset in v6 then. I will work on
a separate patch using a list of quirks in ath12k as suggested.

> or this should actually describe the hardware and whatever is there
> wired/configured, not what OS should do.
>
> Best regards,
> Krzysztof

Best regards,
J=C3=A9r=C3=B4me

