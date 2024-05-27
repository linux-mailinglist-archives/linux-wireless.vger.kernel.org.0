Return-Path: <linux-wireless+bounces-8089-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15838CFF35
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 13:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BB91F21C7D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 11:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ED815D5D5;
	Mon, 27 May 2024 11:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7861i/q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F6F15D5C3
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810178; cv=none; b=VOaCyRIy94XKroNdf2rfhCbNl5PtLUTZQgOZGzl9RgcdgO/UeOZQXgo3L0pWYyjy3+0kj+1pt2+67I5DRPBXHV1OnJU4QsllSZ1Xije30TBzk/HIC88nMy78fU7lXcfKKr8OMwEuYKZLglwRMw2vfCPR0z1oLCM8GjHx03H4AoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810178; c=relaxed/simple;
	bh=EOsL7NiepwoktnPHVm7DC3r9sxjI4Vg8cl11xkZfn/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gpIxs0YgAeRkiDyfwWNH1RUEgy+xR58fLZ/2xDIJquvaC3vzhUX2KK+PxLKpthvbUZ8sMPAP5vRwFK9qsV5zsheIeUJimBKYp2r4rxmHVrNcukchrxJpzWHqEDiqG4zFE8pi2uQrqLA9Q3WshaAD3Mx5xX9F59S/U1gdmWCkF6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d7861i/q; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-df4e0d8fa10so5165439276.1
        for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 04:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716810176; x=1717414976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=32DpmCz616oJj3sZ30ujufGqTcF/NmhflobLHv+4XM8=;
        b=d7861i/qM8mmHt9KUfU21uZAfNVNoYbH4rxjOZpXcq38zqoiduEENgsSIH1mF6uQdP
         nRu87lIPLcmnKZlm6IKD5ZZUZXlsvxhkDwyTDYGu8ICwe8UOXAe4gFSw6LMClChr++w9
         BTCeZ12IThw0xQMUHUV7LXgrdfi7kGrlkUM9imCjA0BgAdWodaG2JrAVDYjsz6ya0yiu
         ORHTGkKDRBRo+vBYh6o7JTv0zqKoQHmbei/vAATnkJLXqyxbWPyj7NL5r38L7Wn6o5s3
         vU7Dyh72oS0Wzd6Q0DHJ0o8nJgahNaY9pIBsYKNdxkX5EtB8eLivSLrhdw/ZpV29J/B0
         k7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716810176; x=1717414976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32DpmCz616oJj3sZ30ujufGqTcF/NmhflobLHv+4XM8=;
        b=SneMOKpqrE8O1eULcXJG7tKM3VQnUA8zC/iHDzCw36ttl7G37wdce8Rzzsgjyje2fk
         Ahyji6B4ur8/ADAfUm7ThyAPBT0XjFCxdsPQji8h90Q0KayfwmqLtaX1s7tSeTH53yS0
         WBzkG0eJBccw7IFVG2lprS3bQnvoNhZsiJ0t3AOTlted9/qUN/x8JnuoMET4kLh1y8lz
         fDEXRd5fpYJiPkRur7+uXFuVvWwNEaEk7DsmCYshswwohzZF52QaSl0x4H9SVNi+l88F
         sQ7jfT4lmME5AYAqsl4S9Z3g7vwPALCMs5CImNVoP86jkTeJOeX8TnfLAhgdQT/JDa2H
         YN4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7oLTOARD/XaPEwok72CHwwJiVVKDtjSZ+XN2cAxuDJbMXEkWNEJuBmI3PjH5Ulb0zOVAR9gWdfntVrXTDWaLUPNbDMNA5oJyu9Rx7UIM=
X-Gm-Message-State: AOJu0YxncrbQTGkWxvBD06EP9Ucy31dnJU/FDZ6Cpklcm8u/KONxSYtR
	gsgxkKYTGg0Xi3D+yPDXbhwpOqG5StZVeXdiQ491PSRUF2AvE8pCxcq20gxRTSt0X6sZYF8S++q
	+MKsfofxp15qOvu2kFYSDQ9RePzyNBaE3E7hI3A==
X-Google-Smtp-Source: AGHT+IFHwGY0a+7rv/7KMXy9+d+MKKeKjUaKRmg/b92ApME6fLHQGJOLc1NGnxd/PGhiSwgle60+hRRnygz1Kpak1qw=
X-Received: by 2002:a25:e310:0:b0:de5:4b1f:7e00 with SMTP id
 3f1490d57ef6-df77215f566mr8579337276.15.1716810175995; Mon, 27 May 2024
 04:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521-qcom-firmware-name-v1-0-99a6d32b1e5e@linaro.org>
 <20240521-qcom-firmware-name-v1-1-99a6d32b1e5e@linaro.org>
 <a45b53f3-b2a5-4094-af5a-1281e0f94d2f@linaro.org> <CAA8EJprxYsoug0ipRHTmX45vaFLzJCUF0dQWOc=QLs4y6uZ1rA@mail.gmail.com>
 <878r03csxn.fsf@kernel.org> <CAA8EJpqkgpCb57DGka0ckbPz=2YiaHzxmiNzG39ad5y6smgO5A@mail.gmail.com>
 <Zk52IHqAfOnVDm50@hu-bjorande-lv.qualcomm.com>
In-Reply-To: <Zk52IHqAfOnVDm50@hu-bjorande-lv.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 27 May 2024 14:42:44 +0300
Message-ID: <CAA8EJpogG5wW2mUUkYFtnnZLMVuneU4Wie6GBfYytSYe0zQ77Q@mail.gmail.com>
Subject: Re: [PATCH 01/12] soc: qcom: add firmware name helper
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, neil.armstrong@linaro.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Loic Poulain <loic.poulain@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 May 2024 at 01:48, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> On Tue, May 21, 2024 at 03:08:31PM +0200, Dmitry Baryshkov wrote:
> > On Tue, 21 May 2024 at 13:20, Kalle Valo <kvalo@kernel.org> wrote:
> > >
> > > Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
> > >
> > > > On Tue, 21 May 2024 at 12:52, <neil.armstrong@linaro.org> wrote:
> > > >>
> > > >> On 21/05/2024 11:45, Dmitry Baryshkov wrote:
> > > >> > Qualcomm platforms have different sets of the firmware files, which
> > > >> > differ from platform to platform (and from board to board, due to the
> > > >> > embedded signatures). Rather than listing all the firmware files,
> > > >> > including full paths, in the DT, provide a way to determine firmware
> > > >> > path based on the root DT node compatible.
> > > >>
> > > >> Ok this looks quite over-engineered but necessary to handle the legacy,
> > > >> but I really think we should add a way to look for a board-specific path
> > > >> first and fallback to those SoC specific paths.
> > > >
> > > > Again, CONFIG_FW_LOADER_USER_HELPER => delays.
> > >
> > > To me this also looks like very over-engineered, can you elaborate more
> > > why this is needed? Concrete examples would help to understand better.
> >
> > Sure. During the meeting last week Arnd suggested evaluating if we can
> > drop firmware-name from the board DT files. Several reasons for that:
> > - DT should describe the hardware, not the Linux-firmware locations
> > - having firmware name in DT complicates updating the tree to use
> > different firmware API (think of mbn vs mdt vs any other format)
> > - If the DT gets supplied by the vendor (e.g. for
> > SystemReady-certified devices), there should be a sync between the
> > vendor's DT, linux kernel and the rootfs. Dropping firmware names from
> > DT solves that by removing one piece of the equation
> >
> > Now for the complexity of the solution. Each SoC family has their own
> > firmware set. This includes firmware for the DSPs, for modem, WiFi
> > bits, GPU shader, etc.
> > For the development boards these devices are signed by the testing key
> > and the actual signature is not validated against the root of trust
> > certificate.
> > For the end-user devices the signature is actually validated against
> > the bits fused to the SoC during manufacturing process. CA certificate
> > (and thus the fuses) differ from vendor to vendor (and from the device
> > to device)
> >
> > Not all of the firmware files are a part of the public linux-firmware
> > tree. However we need to support the rootfs bundled with the firmware
> > for different platforms (both public and vendor). The non-signed files
> > come from the Adreno GPU and can be shared between platforms. All
> > other files are SoC-specific and in some cases device-specific.
> >
> > So for example the SDM845 db845c (open device) loads following firmware files:
> > Not signed:
> > - qcom/a630_sqe.fw
> > - qcom/a630_gmu.bin
> >
> > Signed, will work for any non-secured sdm845 device:
> > - qcom/sdm845/a630_zap.mbn
> > - qcom/sdm845/adsp.mbn
> > - qcom/sdm845/cdsp.mbn
> > - qcom/sdm485/mba.mbn
> > - qcom/sdm845/modem.mbn
> > - qcom/sdm845/wlanmdsp.mbn (loaded via TQFTP)
> > - qcom/venus-5.2/venus.mbn
> >
> > Signed, works only for DB845c.
> > - qcom/sdm845/Thundercomm/db845c/slpi.mbn
> >
> > In comparison, the SDM845 Pixel-3 phone (aka blueline) should load the
> > following firmware files:
> > - qcom/a630_sqe.fw (the same, non-signed file)
> > - qcom/a630_gmu.bin (the same, non-signed file)
> > - qcom/sdm845/Google/blueline/a630_zap.mbn
>
> How do you get from "a630_zap.mbn" to this? By extending the lookup
> table for every target, or what am I missing?

More or less so. Matching the root OF node gives us the firmware
location, then it gets prepended to all firmware targets. Not an ideal
solution, as there is no fallback support, but at least it gives us
some points to discuss (and to decide whether to move to some
particular direction or to abandon the idea completely, making Arnd
unhappy again).

>
> Regards,
> Bjorn
>
> > - qcom/sdm845/Google/blueline/adsp.mbn
> > - qcom/sdm845/Google/blueline/cdsp.mbn
> > - qcom/sdm845/Google/blueline/ipa_fws.mbn
> > - qcom/sdm845/Google/blueline/mba.mbn
> > - qcom/sdm845/Google/blueline/modem.mbn
> > - qcom/sdm845/Google/blueline/venus.mbn
> > - qcom/sdm845/Google/blueline/wlanmdsp.mbn
> > - qcom/sdm845/Google/blueline/slpi.mbn
> >
> > The Lenovo Yoga C630 WoS laptop (SDM850 is a variant of SDM845) uses
> > another set of files:
> > - qcom/a630_sqe.fw (the same, non-signed file)
> > - qcom/a630_gmu.bin (the same, non-signed file)
> > - qcom/sdm850/LENOVO/81JL/qcdxkmsuc850.mbn
> > - qcom/sdm850/LENOVO/81JL/qcadsp850.mbn
> > - qcom/sdm850/LENOVO/81JL/qccdsp850.mbn
> > - qcom/sdm850/LENOVO/81JL/ipa_fws.elf
> > - qcom/sdm850/LENOVO/81JL/qcdsp1v2850.mbn
> > - qcom/sdm850/LENOVO/81JL/qcdsp2850.mbn
> > - qcom/sdm850/LENOVO/81JL/qcvss850.mbn
> > - qcom/sdm850/LENOVO/81JL/wlanmdsp.mbn
> > - qcom/sdm850/LENOVO/81JL/qcslpi850.mbn
> >
> > If we look at one of the recent platforms, e.g. SM8650-QRD, this list
> > also grows up:
> > - qcom/gen70900_sqe.fw (generic, non-signed)
> > - qcom/gmu_gen70900.bin (generic, non-signed)
> > - qcom/sm8650/gen70900_zap.mbn
> > - qcom/sm8650/adsp.mbn
> > - qcom/sm8650/adsp_dtb.mbn
> > - qcom/sm8650/cdsp.mbn
> > - qcom/sm8650/cdsp_dtb.mbn
> > - qcom/sm8650/ipa_fws.mbn
> > - qcom/sm8650/modem.mbn
> > - qcom/sm8650/modem_dtb.mbn
> > - qcom/sm8650/vpu33_4v.mbn (or maybe qcom/vpu-33/vpu_4v.mbn)
> >
> > --
> > With best wishes
> > Dmitry
> >
> >
> >
> >
> >
> >
> >
> >
> >



-- 
With best wishes
Dmitry

