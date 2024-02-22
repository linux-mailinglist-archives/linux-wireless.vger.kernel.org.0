Return-Path: <linux-wireless+bounces-3915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CED85F82B
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 13:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05DE01F25F01
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 12:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A336C60BB0;
	Thu, 22 Feb 2024 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2eHmZLCC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9542E60B92
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604872; cv=none; b=ihyCMtW2sc45suFsdEEU7R1PhIaw/wAGjXVrWujfy2WPJfejt4Jtqop62AbeaRLvSbPDN3bFPiYajk5rXC2MOeDI4J5nEgGiJOcIIUXfIOleXn7T6GVr3MSZAjRlWcYWe8CWqAanYri80Iku26TRDm65vhR2ermJH5kNcCMW8+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604872; c=relaxed/simple;
	bh=wSHsjtGyIG8Oy03Ay1/8wBYOX3m/TamMnf+lgB3hfcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdHV/fTKFsUjynKF/EKZfNj9v+YqbepCVYdi7gCHnH3MEh/cDXclkQy+lZ1GIQobn2cltnHhDe5O6zTFaDRVkF/pm066VeUv/CF6NCMHrQgOWeJ+TSy9TgijaOCGrjjvh8VRtcLBotHekpNmq6P88dBYgF4OoSOyiGaia81F4bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2eHmZLCC; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-46d60c75683so1112539137.1
        for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 04:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708604869; x=1709209669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87z6zq0uGbrgFYkt6YA8mx0pzsMb/ayOMfEcY0+aFV8=;
        b=2eHmZLCC9NwBA2UI5DGC/Jym4gQdwpEaB5dYGg8BPMMcWhUag3yJ3LSPgIglBODGNj
         laSYuL9M50I3fQqKy/BcYy47MEVvy3cess5Mxj7FT5D3JD1yFF0gn3grXrPklA1UvB9U
         uXepih9fGlDcxDC4iZpDtdhIjBvo7P6APwamwvC4ADjSipEHq2p+q9/cVXrgYjNrdUbP
         xWXmzTGJ8evLKWkV9psjTd4sDs5ujxHAUQ0PRtGihxttBlvBP6VHOLY0Luxi0yIOCKUM
         sgy4vPS7GBZStZBLdL+KJwQj/JYcnH7ZKAP8Vw+2CY93nFdd7epamkepxOlFfaqdpD/P
         1g0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708604869; x=1709209669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87z6zq0uGbrgFYkt6YA8mx0pzsMb/ayOMfEcY0+aFV8=;
        b=CBNu/lfaWWRWxC1ilB95L+YEUAfPIRuqplHuNIiUuRlbYNKqxYiV99Nq3XHL9vUYDu
         CZawqWohRR03jkmANdY4hr283VlQGK0KraK0k4JmOO+GFHgXYIXXdmNMNq8lHJTdOlw3
         LIkB/fYPoirp9/+8OfKNihQtUxqFtlZQbfQfOg8VlTMq56h6PcbIRBivxjWcG+uNWO+b
         f/lqKso2QEcdxiSgsM6nMeEslDlP8yekhgcn3xmitAzpZToaKsTIhsU+huQBzamGX0Am
         JJMAPe/E/Iv/Q8a+hCBiZtrDhwF0FyOn1bC+K4yryc1kBawWVEEZGZH3eljk2ujUeE5a
         sLxg==
X-Forwarded-Encrypted: i=1; AJvYcCXUqS0aRMalAR61+gnZPjV6XCzPHWxqxyLcilnDvukfCb1pR86TAO89091M1BNyLeGThio9U+x2F1JZFyrxQ9qTs5ZRa7Hv9QtLK72L3MI=
X-Gm-Message-State: AOJu0Yzs9XrwQeAF7cZx9IEKD/F5SdnLJz4twGNm+v+ogG1VmEzm/wKV
	7hGjXETstKnRCqSp3C6hLQsTLYbeUecvHrMRCJCNIMdZifsyZY4KRz+8HHAY2wKCr2ctAECnKRj
	OgBC1+sSd5gYal1DNslyhR90Z9gK+RASNeQfmnQ==
X-Google-Smtp-Source: AGHT+IEX89w8BA5MRuF+hYzsldrzWJL7R30+wWpJcrmQgBmAJsacwJX7Ls13cXFgRWb101UOeMKn5UqfoaZY6qWXHKw=
X-Received: by 2002:a05:6102:c50:b0:471:bde0:4050 with SMTP id
 y16-20020a0561020c5000b00471bde04050mr1095401vss.8.1708604869551; Thu, 22 Feb
 2024 04:27:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <CAA8EJppt4-L1RyDeG=1SbbzkTDhLkGcmAbZQeY0S6wGnBbFbvw@mail.gmail.com>
 <e4cddd9f-9d76-43b7-9091-413f923d27f2@linaro.org> <CAA8EJpp6+2w65o2Bfcr44tE_ircMoON6hvGgyWfvFuh3HamoSQ@mail.gmail.com>
 <4d2a6f16-bb48-4d4e-b8fd-7e4b14563ffa@linaro.org> <CAA8EJpq=iyOfYzNATRbpqfBaYSdJV1Ao5t2ewLK+wY+vEaFYAQ@mail.gmail.com>
 <CAMRc=Mfnpusf+mb-CB5S8_p7QwVW6owekC5KcQF0qrR=iOQ=oA@mail.gmail.com>
 <CAA8EJppY7VTrDz3-FMZh2qHoU+JSGUjCVEi5x=OZgNVxQLm3eQ@mail.gmail.com>
 <b9a31374-8ea9-407e-9ec3-008a95e2b18b@linaro.org> <CAA8EJppWY8c-pF75WaMadWtEuaAyCc5A1VLEq=JmB2Ngzk-zyw@mail.gmail.com>
 <CAMRc=Md6SoXukoGb4bW-CSYgjpO4RL+0Uu3tYrZzgSgVtFH6Sw@mail.gmail.com> <CAA8EJprUM6=ZqTwWLB8rW8WRDqwncafa-szSsTvPQCOOSXUn_w@mail.gmail.com>
In-Reply-To: <CAA8EJprUM6=ZqTwWLB8rW8WRDqwncafa-szSsTvPQCOOSXUn_w@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 Feb 2024 13:27:38 +0100
Message-ID: <CAMRc=Metemd=24t0RJw-O9Z0-cg4mESouOfvMVLs_rJDCwRBPQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] power: sequencing: implement the subsystem and
 add first users
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: neil.armstrong@linaro.org, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 12:27=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, 22 Feb 2024 at 13:00, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > On Mon, Feb 19, 2024 at 11:21=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Mon, 19 Feb 2024 at 19:18, <neil.armstrong@linaro.org> wrote:
> > > >
> > > > On 19/02/2024 13:33, Dmitry Baryshkov wrote:
> > > > > On Mon, 19 Feb 2024 at 14:23, Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
> > > > >>
> > > > >> On Mon, Feb 19, 2024 at 11:26=E2=80=AFAM Dmitry Baryshkov
> > > > >> <dmitry.baryshkov@linaro.org> wrote:
> > > > >>>
> > > > >>
> > > > >> [snip]
> > > > >>
> > > > >>>>>>>>
> > > > >>>>>>>> For WCN7850 we hide the existence of the PMU as modeling i=
t is simply not
> > > > >>>>>>>> necessary. The BT and WLAN devices on the device-tree are =
represented as
> > > > >>>>>>>> consuming the inputs (relevant to the functionality of eac=
h) of the PMU
> > > > >>>>>>>> directly.
> > > > >>>>>>>
> > > > >>>>>>> We are describing the hardware. From the hardware point of =
view, there
> > > > >>>>>>> is a PMU. I think at some point we would really like to des=
cribe all
> > > > >>>>>>> Qualcomm/Atheros WiFI+BT units using this PMU approach, inc=
luding the
> > > > >>>>>>> older ath10k units present on RB3 (WCN3990) and db820c (QCA=
6174).
> > > > >>>>>>
> > > > >>>>>> While I agree with older WiFi+BT units, I don't think it's n=
eeded for
> > > > >>>>>> WCN7850 since BT+WiFi are now designed to be fully independe=
nt and PMU is
> > > > >>>>>> transparent.
> > > > >>>>>
> > > > >>>>> I don't see any significant difference between WCN6750/WCN685=
5 and
> > > > >>>>> WCN7850 from the PMU / power up point of view. Could you plea=
se point
> > > > >>>>> me to the difference?
> > > > >>>>>
> > > > >>>>
> > > > >>>> The WCN7850 datasheet clearly states there's not contraint on =
the WLAN_EN
> > > > >>>> and BT_EN ordering and the only requirement is to have all inp=
ut regulators
> > > > >>>> up before pulling up WLAN_EN and/or BT_EN.
> > > > >>>>
> > > > >>>> This makes the PMU transparent and BT and WLAN can be describe=
d as independent.
> > > > >>>
> > > > >>>  From the hardware perspective, there is a PMU. It has several =
LDOs. So
> > > > >>> the device tree should have the same style as the previous
> > > > >>> generations.
> > > > >>>
> > > > >>
> > > > >> My thinking was this: yes, there is a PMU but describing it has =
no
> > > > >> benefit (unlike QCA6x90). If we do describe, then we'll end up h=
aving
> > > > >> to use pwrseq here despite it not being needed because now we wo=
n't be
> > > > >> able to just get regulators from WLAN/BT drivers directly.
> > > > >>
> > > > >> So I also vote for keeping it this way. Let's go into the packag=
e
> > > > >> detail only if it's required.
> > > > >
> > > > > The WiFi / BT parts are not powered up by the board regulators. T=
hey
> > > > > are powered up by the PSU. So we are not describing it in the acc=
urate
> > > > > way.
> > > >
> > > > I disagree, the WCN7850 can also be used as a discrete PCIe M.2 car=
d, and in
> > > > this situation the PCIe part is powered with the M.2 slot and the B=
T side
> > > > is powered separately as we currently do it now.
> > >
> > > QCA6390 can also be used as a discrete M.2 card.
> > >
> > > > So yes there's a PMU, but it's not an always visible hardware part,=
 from the
> > > > SoC PoV, only the separate PCIe and BT subsystems are visible/contr=
ollable/powerable.
> > >
> > > From the hardware point:
> > > - There is a PMU
> > > - The PMU is connected to the board supplies
> > > - Both WiFi and BT parts are connected to the PMU
> > > - The BT_EN / WLAN_EN pins are not connected to the PMU
> > >
> > > So, not representing the PMU in the device tree is a simplification.
> > >
> >
> > What about the existing WLAN and BT users of similar packages? We
> > would have to deprecate a lot of existing bindings. I don't think it's
> > worth it.
>
> We have bindings that are not reflecting the hardware. So yes, we
> should gradually update them once the powerseq is merged.
>
> > The WCN7850 is already described in bindings as consuming what is PMUs
> > inputs and not its outputs.
>
> So do WCN6855 and QCA6391 BlueTooth parts.
>

That is not true for the latter, this series is adding regulators for it.

Bart

> >
> > Bart
> >
> > > >
> > > > Neil
> > > >
> > > > >
> > > > > Moreover, I think we definitely want to move BT driver to use onl=
y the
> > > > > pwrseq power up method. Doing it in the other way results in the =
code
> > > > > duplication and possible issues because of the regulator / pwrseq
> > > > > taking different code paths.
> > >
> > > --
> > > With best wishes
> > > Dmitry
>
>
>
> --
> With best wishes
> Dmitry

