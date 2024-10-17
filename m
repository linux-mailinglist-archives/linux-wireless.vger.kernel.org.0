Return-Path: <linux-wireless+bounces-14183-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B8E9A310B
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 00:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E812B21803
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 22:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A8E1D798B;
	Thu, 17 Oct 2024 22:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYaz4nW9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD41D5142;
	Thu, 17 Oct 2024 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729205535; cv=none; b=GMXkTdOFLnPZYYcO1Dg6MjqCfM/Me1ItO9/dfHzLV0TVc/3zgVHRp0q4ShTDvKssfQCt3TSP4uzEjvZ61uCqIKtk574H3YQxxtxLCTy8HYVCWW8Ywv6fgpM7pwo/A2pZwLbknXxzrV2bt91ienHJw48n1ag5AhQCPJvHSyjcCWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729205535; c=relaxed/simple;
	bh=frnSwULrYETQkvbVwZEgEPiE36HANfCtPd3CbO9qsZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ob5abbcMEg9naBUnOljJG+2/Loq/SyYz3KDyCVojaNI3dAuErZIEspC0tcjumD4fR7TVlJHlFG/YAno1p57zciZ0nHgIx26HEYZbC2JTEYwhYMAU7b56u3iPn9pJnvX6WoqAVHKDqmJH58wiJ6I1erVucc50gleghl8hlnClVYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYaz4nW9; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea9739647bso1016410a12.0;
        Thu, 17 Oct 2024 15:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729205530; x=1729810330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ak09hnm3ZyKvAlgCv6Rshtaw1ScSFFpp67M4d2jxtOE=;
        b=YYaz4nW9BEKv3zZKajTdQLIX64gRyr3ffCepOocKuw5YGXHDXJ0sw/uu3lk+bDVX4g
         kPEoPqGt5660/uFr0EpUqc5ZlPM81SQwuPAFoKXfn/+d96SlHMthZsd2dJdNc+rc+kE4
         /KWKha30cJvpd3ShNDki8fGHcRfgtn882aw5Z3EJ3F9wwA1SCujgYrj6Jrq7UW2vp8iN
         7KBtiShx2N04zRxw+ynmKXZVTFxiTh1STAM6wZc+gVBZUTDZfm8d64YGfGgA+RiWdIhM
         aZCpek2EzohkrJO5KuSp1fjkOADGAzdTq9PJalTM+Nmv4ut40v1QOtnpYf/Xgi3A6p0G
         cyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729205530; x=1729810330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ak09hnm3ZyKvAlgCv6Rshtaw1ScSFFpp67M4d2jxtOE=;
        b=B6dj+o5FPeDP7L3Ri56sflQODO30jsF/VJTEeHPlWrHw1wYGrQSMEDF/MbMASaY9XL
         gIIDp6l+J7e8GM6Jiqy7n416gm35lzSkdSqhpGFutfB0hMPkDVBwLXqLSzi7rUA9Dn2j
         lw/jXro9BA2YfOxpZKia3Tl3Frijx0pTWW7tXjnyDG4TBzbDkhxXTrskiMi6ulMvRMeb
         84XiSWhHPKPuTg5Pv6DwkLzKK66Z5kTWnqmqErc/YZNTA+FRlWauxcWC5ldReleR7dyw
         wfTec3WV7Hv5GU9rG2tQAMfRJm3T/aNSGvvGgX7KvszRGnbj8C00EEXB+YMsq+dEVAZG
         InDA==
X-Forwarded-Encrypted: i=1; AJvYcCVncGm/i1AzUmy9GV8QE7rE4PuIrXE/uyuqIzK8xlUlUWDevXUmuxY5rZYRv6fh8GWb5LzMRL86nFxmQyhLMq0=@vger.kernel.org, AJvYcCWNfJpimwVzHJuvTmaxyYjtimGT0K9Exc28qvqjifVpLGlBhC+nvj/kUWk970BEc3IaeRuMUrqLgNY8cyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm8rgPy6wil/EqiVMJDZ4Ay1RB7W2ougb852Kky5C69YKXHDca
	Vpfwz6IludxvZVprz2DgJ1AXgCtxBIj1kkArteK+gLsD6ax6dAXP4VjrS7z/lBlo4ICGGxCAy1b
	+Fb5+UfML7Bz615DQJ/49K6NTqw==
X-Google-Smtp-Source: AGHT+IGgAVW5XSoMHG4e+KpIXFuLcDgPF2s1F+2Cv3K68fhHnOOm7OviGrLHhAGMq+8oKZAf3PPVXx/5ByQdbk46G4E=
X-Received: by 2002:a05:6a21:710a:b0:1d8:d880:2069 with SMTP id
 adf61e73a8af0-1d92c4ad296mr654536637.3.1729205530193; Thu, 17 Oct 2024
 15:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801202359.794035-1-frut3k7@gmail.com> <20241009065051.51143-1-frut3k7@gmail.com>
 <b58b5b2e-bf9f-480c-810b-2cef29aab82c@quicinc.com>
In-Reply-To: <b58b5b2e-bf9f-480c-810b-2cef29aab82c@quicinc.com>
From: =?UTF-8?Q?Pawe=C5=82_Owoc?= <frut3k7@gmail.com>
Date: Fri, 18 Oct 2024 00:51:59 +0200
Message-ID: <CAKEyCaDUfn4jtCdTt9JJ-Qe+CCudORPwcjj5i5=G28ANc+eCRg@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: ath10k: add channel 177 for 5 GHz band
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 6:51=E2=80=AFPM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
>
> On 10/8/2024 11:49 PM, Pawe=C5=82 Owoc wrote:> Add support for channel 17=
7 (5885
> MHz ) for the 5 GHz band.
> >
> > Tested-on: qca988x hw2.0 firmware ver 10.2.4-1.0-00047
>
> Can you elaborate on what was tested in your commit text? And more
> importantly, what is the impact on existing devices, especially given tha=
t
> existing devices would not have calibration data for this channel in the =
board
> files? Does the QCA988x board file even have calibration data for this ch=
annel?
>
In the case of ath10k we use an external regulatory database.
For the country "US" channels 169, 173 and 177 are marked as NO-IR and
we cannot run AP on them.
Even if channels are not disabled in the board files:
            * 5845.0 MHz [169] (27.0 dBm) (no IR)
            * 5865.0 MHz [173] (27.0 dBm) (no IR)
            * 5885.0 MHz [177] (27.0 dBm) (no IR)

I only tested the use as a client on channel 177:
root@OpenWrt:~# iwinfo phy1 scan
Cell 01 - Address: XX:XX:XX:XX:XX:XX
          ESSID: "ch177"
          Mode: Master  Frequency: 5.885 GHz  Band: 5 GHz  Channel: 177
          Signal: -43 dBm  Quality: 67/70
          Encryption: mixed WPA2/WPA3 PSK/SAE (CCMP)
          HT Operation:
                    Primary Channel: 177
                    Secondary Channel Offset: no secondary
                    Channel Width: 20 MHz
> >
> > Signed-off-by: Pawe=C5=82 Owoc <frut3k7@gmail.com>
> > ---
>
> what is the diff from v1?
> for future reference when you submit a new version of a patch you should
> include a patch changelog after the ---, see:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#th=
e-canonical-patch-format
>
There are no differences. My previous patch was deferred. I don't know
exactly how to proceed in such a case.

> >  drivers/net/wireless/ath/ath10k/core.h | 4 ++--
> >  drivers/net/wireless/ath/ath10k/mac.c  | 1 +
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wirel=
ess/ath/ath10k/core.h
> > index 446dca74f06a..3dff8c028526 100644
> > --- a/drivers/net/wireless/ath/ath10k/core.h
> > +++ b/drivers/net/wireless/ath/ath10k/core.h
> > @@ -39,8 +39,8 @@
> >  #define WMI_READY_TIMEOUT (5 * HZ)
> >  #define ATH10K_FLUSH_TIMEOUT_HZ (5 * HZ)
> >  #define ATH10K_CONNECTION_LOSS_HZ (3 * HZ)
> > -#define ATH10K_NUM_CHANS 41
> > -#define ATH10K_MAX_5G_CHAN 173
> > +#define ATH10K_NUM_CHANS 42
> > +#define ATH10K_MAX_5G_CHAN 177
> >
> >  /* Antenna noise floor */
> >  #define ATH10K_DEFAULT_NOISE_FLOOR -95
> > diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wirele=
ss/ath/ath10k/mac.c
> > index 646e1737d4c4..cee6a4d287b5 100644
> > --- a/drivers/net/wireless/ath/ath10k/mac.c
> > +++ b/drivers/net/wireless/ath/ath10k/mac.c
> > @@ -9543,6 +9543,7 @@ static const struct ieee80211_channel ath10k_5ghz=
_channels[] =3D {
> >       CHAN5G(165, 5825, 0),
> >       CHAN5G(169, 5845, 0),
> >       CHAN5G(173, 5865, 0),
> > +     CHAN5G(177, 5885, 0),
> >       /* If you add more, you may need to change ATH10K_MAX_5G_CHAN */
> >       /* And you will definitely need to change ATH10K_NUM_CHANS in cor=
e.h */
> >  };
>

