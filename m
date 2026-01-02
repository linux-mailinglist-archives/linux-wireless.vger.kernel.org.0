Return-Path: <linux-wireless+bounces-30295-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AC2CEF072
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 18:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D12A7301397C
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 17:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E842820AC;
	Fri,  2 Jan 2026 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcXtlLBX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE67262FD0
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767373625; cv=none; b=d/x8Bnvxxo5qa/ILKkNmxI5FRipabE96EA5XzqMXMlEVu5zyrriILFhLCxlYKy8CwqyA0Rce1AtSSjCFcomqu2PQOceYbu5/U+mRxGE7sIdHF3FEsxMIU33SGqmP4NKf/yTw80VMUHcyXhyiYCprMIjddINqgDV+4TBr3QFvqEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767373625; c=relaxed/simple;
	bh=iarWZx1KlsRgp9E3GRi6XuMvkRnvVPn8FvNMJ9e/S4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JYvjWoPl0Xt+QBuHz2Ms73Qq3mfk7ypRfo15IW/rWAVHem8hUhLeSGswvsorpyQz3KSwQ/yFVstugvhNJ0Uzr3xj1N7iA09UK7Lcp0pWqvXImBOPdFXDuy9ri6eEDEv6+nPW1d8dgQcwRM0uF88wz86pHBV9HMTTJgoE7Lg2JYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcXtlLBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89FCC2BC86
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 17:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767373624;
	bh=iarWZx1KlsRgp9E3GRi6XuMvkRnvVPn8FvNMJ9e/S4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kcXtlLBXMTH+PLsKrzsnn1BKCftiotdowPx+43C2mDmDNeK+Dh1Kx8o7zYLYUJQsJ
	 lRT+f29+8sE7WK8lrknHjRUfnV7zX0zmV5BwYO09MJzBIzzlxNjdTLe3m5lN9AglGk
	 j4QfIKWcaDEM6r961TwC3dqwsB9egROCsdmZHi1O0yduhdEFTl/V+P0Aj51kIpbKH/
	 qogk9GmovrCLqun41WQiGNb2Mt+JCm1x+nCYZJ5CgqozAxBhAQ0ZzfGL6p8YIdZQNy
	 nzLKx4DIX4qJLHfvUzV4MUwirN90b5SU3IvwEZ3h3B9RtCTzMbzYzmyaDBNVWDtdXz
	 spBBxt/gDQu7g==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-595819064cdso167800e87.0
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jan 2026 09:07:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZrikEwXe+ydW+b9Dvn2HuzbkMxiMLpIWDY2XJEqQegFTyA/qLvD+tF2scyowUFoGNl9+xcJArA67bz/CxTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVDE6M6jIZHx0j0sleaKDNhzl7G7amP60j2F7gVeyA6UnfTJN0
	Lao9nfHm9HkxotDot8MVF86lMk/ALmVcmWrbOP8JJSrHXy/WpVmF8BQ19xBNCzyT6aC9As7F3mt
	ElgufYOYs6ed1Sj7i6ermWThjciA7jKx7GVw8aEbwRQ==
X-Google-Smtp-Source: AGHT+IFvH0jCrfHsGU86qSQyaKtWG6m7X68xvVItz+xwat1KYNlZLswI9WXmMoLpE+qcpLYknysIBNbQN/+lMNMdWwI=
X-Received: by 2002:a05:6512:3412:b0:59a:1443:2f72 with SMTP id
 2adb3069b0e04-59b5657e5a4mr103415e87.4.1767373623264; Fri, 02 Jan 2026
 09:07:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-4-1ff4d6028ad5@oss.qualcomm.com>
 <CAMRc=Mey1ScNmosipLFg6mmABjeG2SO2L-pyjwTuOpOYOHZjqg@mail.gmail.com> <CAO9ioeU2JjzDwkGQzxc963kakNyZCtaSRAmLu=1kOAMGQeuZRQ@mail.gmail.com>
In-Reply-To: <CAO9ioeU2JjzDwkGQzxc963kakNyZCtaSRAmLu=1kOAMGQeuZRQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 2 Jan 2026 18:06:51 +0100
X-Gmail-Original-Message-ID: <CAMRc=MdCxXg6Hbn_qPVsux2aAfN8cqpG946rS2Sb9J_Cjy0ZQg@mail.gmail.com>
X-Gm-Features: AQt7F2qM1LfACBr1uzyMAUsYIaKhzaqm_3nrsJwq14yD6V3d3exkT5MSIFxHS6o
Message-ID: <CAMRc=MdCxXg6Hbn_qPVsux2aAfN8cqpG946rS2Sb9J_Cjy0ZQg@mail.gmail.com>
Subject: Re: [PATCH 04/14] wifi: ath10k: snoc: support powering on the device
 via pwrseq
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 4:10=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Fri, 2 Jan 2026 at 13:07, Bartosz Golaszewski <brgl@kernel.org> wrote:
> >
> > On Wed, Dec 31, 2025 at 12:36=E2=80=AFAM Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > >
> > > The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spread=
ing
> > > voltages over internal rails. Implement support for using powersequen=
cer
> > > for this family of ATH10k devices in addition to using regulators.
> > >
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > ---
> >
> > [snip]
> >
> > >
> > >  static void ath10k_snoc_wlan_disable(struct ath10k *ar)
> > > @@ -1762,7 +1779,27 @@ static int ath10k_snoc_probe(struct platform_d=
evice *pdev)
> > >                 goto err_release_resource;
> > >         }
> > >
> > > -       ar_snoc->num_vregs =3D ARRAY_SIZE(ath10k_regulators);
> > > +       /*
> > > +        * Backwards compatibility, ignore the defer error from pwrse=
q, if it
> > > +        * should be used, we will get an error from regulator get.
> > > +        */
> >
> > Can you elaborate on this? I'm not exactly following. I suppose you
> > mean the regulator_get() will return -EPROBE_DEFER? One of the
> > supplies exposed by the PMU?
>
> Yes. devm_pwrseq_get() can return -EPROBE_DEFER in two cases:
> - it is not supposed to be used
> - it is supposed to be used, but the driver hasn't probed yet.
>

Yes but normally driver core would still create a devlink between the
device binding to the PMU node and the consumer of its regulators -
this device - so we can expect that it will always be the first one,
no? Unless we need this driver to be firmware-agnostic.

> There is no simple way to distinguish between these two cases, but:
> - if it is not supposed to be used, then regulator_bulk_get() will
> return all regulators as expected, continuing the probe
> - if it is supposed to be used, but wasn't probed yet, we will get
> -EPROBE_DEFER from regulator_bulk_get() too.
>
> I can write that in a comment, if you think that it makes the code more o=
bvious.
>

Yes, please make it more descriptive. Ideally I'd like to improve the
API to avoid such confusion in the future.

Bartosz

> >
> > Bart
> >
> > > +       ar_snoc->pwrseq =3D devm_pwrseq_get(&pdev->dev, "wlan");
> > > +       if (IS_ERR(ar_snoc->pwrseq)) {
> > > +               ret =3D PTR_ERR(ar_snoc->pwrseq);
> > > +               ar_snoc->pwrseq =3D NULL;
> > > +               if (ret !=3D -EPROBE_DEFER)
> > > +                       goto err_free_irq;
> > > +
> > > +               ar_snoc->num_vregs =3D ARRAY_SIZE(ath10k_regulators);
> > > +       } else {
> > > +               /*
> > > +                * The first regulator (vdd-0.8-cx-mx) is used to pow=
er on part
> > > +                * of the SoC rather than the PMU on WCN399x, the res=
t are
> > > +                * handled via pwrseq.
> > > +                */
> > > +               ar_snoc->num_vregs =3D 1;
> > > +       }
> > > +
>
>
>
> --
> With best wishes
> Dmitry

