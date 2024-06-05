Return-Path: <linux-wireless+bounces-8523-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BEE8FC6E9
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 10:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C493B24525
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 08:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810BF18C348;
	Wed,  5 Jun 2024 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yzvJC92G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774BC49656
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577267; cv=none; b=TFYGvwUnmPXOxK+sAqK74TJUrtr/iuXmrWVePrP/LbAHxWJECHRGs9PkiH0mE6aplw3EeKGsb4zKKnjxE39hEF9nlW1DPh5WchRG5Qv/c+HCeFQxoD1PclDAB242k1wXn85Ga7/1UoKTVrgN7zfBEvAEFzFehdfVCVUELQdRAGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577267; c=relaxed/simple;
	bh=uSKkoIGoa2SrkckhNzNgT8KTYQPaLTtB710iSC/tAE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ReZVw4uiKPJ5gqQbQR44VwZ6IC0pKb/NwC1eEoOF5d6PDnTre1taCL4usD4GeAODwnFwgGMr4btxrD6ZoJYRqD5jXwDn1XMM7DUV9QRSY0PVXh5O8iHNvRFiJgVnBwAJy6kSxF5P5qDCgmHH8WdfNx/Wxly7DhDopAM+pTN48sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yzvJC92G; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eaa80cb550so25653601fa.0
        for <linux-wireless@vger.kernel.org>; Wed, 05 Jun 2024 01:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717577264; x=1718182064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPra9VnPeBiNtl2fHAj/AHY/htZJd5zpefm5z/7mvlE=;
        b=yzvJC92GX+CnQx7m4LPXyXYsNpBvK/idur5bYDpywh8Go7jQHrXy2gFaqm1K9hDcp+
         RxJgnqtVk1pwaF88JnMjI68vVZuPrK3wPVivjqPPQrjHbPT8EqHKLt+7THl2eNqqUtku
         A3Xz6vhJGFl1D+NVsA+4ugRneDGyK/wDAjILU/Trg1wqc9c4y+tcvmoD0PJuKKNqmoWY
         NHoh1GL1anfB2oaJlnMuNZsi1syUrrgOdDe3NRxMe08Q+pd1IsXVryykPVrFCVT0avuf
         W3WSu/oCgsVzfqKlx+V4PK4jmd6hAlfYSzFa5murwfQd4FvoqTlDsVOdCC6wTyvn3YGq
         qpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717577264; x=1718182064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPra9VnPeBiNtl2fHAj/AHY/htZJd5zpefm5z/7mvlE=;
        b=iwbHt0jJWkCQKhxCIH06+JMGcemAPyaVUIS6u0sdmQtosJk9PqKV4HTSuQr+KgdtMr
         Z68r5f4D1VfWYXbaYnMJl3DocsGs7Dc3V9qadpTO0PYNwxTk3pAv0L/ITZWb3QyzkRcB
         ZFiyu1wfXtqWtJ2XT016uYGW1kvh3JzVIXQxluYoYjOkCq5MAVZqp1FbKXsQEwLJhr26
         etRzD1/HrxLPwaZn8HoZFNVdJrpCZunShNIz/Db0+ybiTRf3y8ra89V/Hbrr/Y+OT63o
         5nIJHDozUfR/ttA/aaQt542kLafqdfDiLPiB3bN/zCma0m+fW/i+6wTdcCl7hG8Qyzce
         ZZZA==
X-Forwarded-Encrypted: i=1; AJvYcCW/lvSc+s7ObmZN3Hapo7n8hF50xFzca2E2FLe0MbXrsmhePlb1EBX3KH1ohy/rx/yw+0/11TuTVrOgabDNjwuJ83xArJ0TTPACtNwcN3U=
X-Gm-Message-State: AOJu0YxJDZaaubB7cKk9XKsVAJ0+kKHv4U/A0DLEXJM2nK2H66ORkA9r
	iU8ju2hkzYpPWVqP6ZhFiQo/H83cDB+vbJA/LCX3PEzpOhqm9QEsC4DmYoe32OojIZrqMnEstXt
	HgVynptKA2yOhi38kDFeShlXdG3+XTaRl175AgQ==
X-Google-Smtp-Source: AGHT+IFvAhNmZjR8e0W7tisE1L2rItCbACVQEOeSPIHCQ/2JT5Lzac0kUX9ZWXyqBUxDLGDW1jONb8JYHYsrWH/7fyo=
X-Received: by 2002:a2e:7a0a:0:b0:2da:b59c:a94b with SMTP id
 38308e7fff4ca-2eac7a2299fmr11245531fa.25.1717577263571; Wed, 05 Jun 2024
 01:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA8EJpomPLQmQbW8w3_ms_NMKHoSPcqBa7f2OhNTTOUSdB+9Eg@mail.gmail.com>
 <20240605021346.GA746121@bhelgaas>
In-Reply-To: <20240605021346.GA746121@bhelgaas>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 5 Jun 2024 10:47:32 +0200
Message-ID: <CAMRc=Mckab1QYoBuE3iSv0x+GEjFNBQS5Hw_Mry=r7h5XGHZEQ@mail.gmail.com>
Subject: Re: [PATCH v8 16/17] PCI/pwrctl: add a PCI power control driver for
 power sequenced devices
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Elliot Berman <quic_eberman@quicinc.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Alex Elder <elder@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	ath12k@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel@quicinc.com, 
	Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 4:13=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Wed, Jun 05, 2024 at 02:34:52AM +0300, Dmitry Baryshkov wrote:
> > On Wed, 5 Jun 2024 at 02:23, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Tue, May 28, 2024 at 09:03:24PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > Add a PCI power control driver that's capable of correctly powering=
 up
> > > > devices using the power sequencing subsystem. The first users of th=
is
> > > > driver are the ath11k module on QCA6390 and ath12k on WCN7850.
>
> > > > +static const struct of_device_id pci_pwrctl_pwrseq_of_match[] =3D =
{
> > > > +     {
> > > > +             /* ATH11K in QCA6390 package. */
> > > > +             .compatible =3D "pci17cb,1101",
> > > > +             .data =3D "wlan",
> > > > +     },
> > > > +     {
> > > > +             /* ATH12K in WCN7850 package. */
> > > > +             .compatible =3D "pci17cb,1107",
> > > > +             .data =3D "wlan",
> > > > +     },
> > >
> > > IIUC, "pci17cb,1101" and "pci17cb,1107" exist partly so we can check
> > > that a DTS conforms to the schema, e.g., a "pci17cb,1101" node
> > > contains all the required regulators.  For that use, we obviously nee=
d
> > > a very specific "compatible" string.
> > >
> > > Is there any opportunity to add a more generic "compatible" string in
> > > addition to those so this list doesn't have to be updated for every
> > > PMU?  The .data here is "wlan" in both cases, and for this purpose, w=
e
> > > don't care whether it's "pci17cb,1101" or "pci17cb,1107".
> >
> > These two devices have different set of regulators and different
> > requirements to power them on.
>
> Right, but I don't think pci_pwrctl_pwrseq_probe() knows about those
> different sets.  It basically looks like:
>
>   pci_pwrctl_pwrseq_probe(struct platform_device *pdev)
>   {
>     struct pci_pwrctl_pwrseq_data *data;
>     struct device *dev =3D &pdev->dev;
>
>     data->pwrseq =3D devm_pwrseq_get(dev, of_device_get_match_data(dev));
>     pwrseq_power_on(data->pwrseq);
>     data->ctx.dev =3D dev;
>     devm_pci_pwrctl_device_set_ready(dev, &data->ctx);
>   }
>
> I think of_device_get_match_data(dev) will return "wlan" for both
> "pci17cb,1101" and "pci17cb,1107", so devm_pwrseq_get(),
> pwrseq_power_on(), and devm_pci_pwrctl_device_set_ready() don't see
> the distinction between them.
>

These are only the first two users of this generic driver. We may end
up adding more that will use different targets or even extend the
match data with additional fields.

> Of course, they also get "dev", so they can find the device-specifc
> stuff that way, but I think that's on the drivers/power/sequencing/
> side, not in this pci-pwrctl-pwrseq driver itself.
>
> So what if there were a more generic "compatible" string, e.g., if the
> DT contained something like this:
>
>   wifi@0 {
>     compatible =3D "pci17cb,1101", "wlan-pwrseq";

What even is "pwrseq" in the context of the hardware description? DT
maintainers would like to have a word with you. :)

>     ...
>   }
>
> and pci_pwrctl_pwrseq_of_match[] had this:
>
>   { .compatible =3D "wlan-pwrseq", .data =3D "wlan", }
>
> Wouldn't this pci-pwrctl-pwrseq driver work the same?  I'm not a DT
> whiz, so likely I'm missing something, but it would be nice if we
> didn't have to update this very generic-looking driver to add every
> device that needs it.
>

Device-tree describes hardware, not the implementation. You can see
elsewhere in this series that we have the PMU described as a PMIC on
the device tree but we never register with the regulator subsystem nor
do we create actual regulators in C. The HW description does not have
to match the C implementation 1:1 but has to be accurate. There's not
such HW component as "wlan-pwrseq". If you want a good example of such
generic fallback - it'll be the C45 ethernet PHYs as they actually
exist: there's a HW definition of what a broader C45 PHY is, even
though it can be extended in concrete HW designs.

I'd leave this as is.

Bart

