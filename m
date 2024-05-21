Return-Path: <linux-wireless+bounces-7900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AD48CAF0C
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 15:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082E71C21718
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 13:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B54D77113;
	Tue, 21 May 2024 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uqoFChUI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE107D3F5
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296926; cv=none; b=N7zllFZi36V9kG9QxQVyJDel8sD9zX+KCiY8BRMh9Ut0DDkBkWrmgIbIVyyLDubwaGxmPK3aTCS0TUNU5KbNvVmERI2VShAD5PgddlVFGLFeuCAEGF11FvEl05SwoKpJgHCY34jbbf1W65KhoYQPosy/zjWeEZGVca+uCp76SDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296926; c=relaxed/simple;
	bh=Vo1WEyGGZPhdnMPdwMM9V9kHG3COuto8rHsF1dB412c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fR8KxBDlm7U31JWBK0FxsZfFBWxFWmkfWf71n8oAE7yk3HTTnsyQtt+vv0EiqQD6R7CNh15xjfMaRG5u3krXYK36MX7yt4wStCJubRFj3AHX2I71rWHXE9N4Y2vJWED26k6PEEf67Xd/aE5R7x83ZXJrKsOCrEl3wxmOI67xfpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uqoFChUI; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61e0c1ec7e2so28829717b3.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 06:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716296923; x=1716901723; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d2PojWB/4MiGFiYJ2E5IG22IJxNV6CKEtX3InCIg1mk=;
        b=uqoFChUIvUq3OL/O30lMVoHetUHz3LZ1JxQ/2/tiGw9kmQytMElui9oDZX4sY5xvgZ
         /ke97AQ5pb69SVfOU2B0ih8M0DbEVylS3HULirAwZG75uKaqppFwBRwbzkPQTywAteFy
         eVWJOmyu/HwZyHBHrwZ3FFGbM0UNHZ3j1pS0kkN/m+o+z84+ODeIV/lJXrNJc9pOJ5UN
         sWNCPnVxSYN5UnC1YWdNm23lsktSYU6hsifnxqU1s/v7q0mLbvmyWoJPZNU8narSvTum
         Xpb4AG4VGqFKmSnTD9CKfgP3d5rTSRLj0L0+8mITvOHP+huR3Y/W7a94BAD1VwCCEdux
         CMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716296923; x=1716901723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d2PojWB/4MiGFiYJ2E5IG22IJxNV6CKEtX3InCIg1mk=;
        b=a5R9M2fHpsN7UAD9noLbzbc2Sh4aoY7XSM1Rys9PSnlGbtOPvH9O3bohH2r5krkuLz
         nbtkMB7U0v/s0rMao6J3FbngMU5NQut9MlsopGeT0PDkE91ZDRXYxLwPMxmqIl5Sr9wI
         7aKZpScE+0ry5FzIW9BrxqqTybytdhXz46fL/EvmgXHjSW1QRI+cOhbUNUdE+mHZA1g4
         ciXiS2atmKiC2DHEUYretmAdXDezVjMaSSVHlOv28bh14ep5ogCi2HXT5Frxre8dGrus
         PfKNiTpJLClEeWH37hkOf38I5qejSgbkeYZMMWlh5ywUEmDXqlhDLgayckkCZvUWV3mR
         RL0A==
X-Forwarded-Encrypted: i=1; AJvYcCWtbNBZwS+iDgftUZIlJyPkr3nj066JHtH8BtLZtEpxtSrnak9uU5JOXi9LlPDZ9x7M+yvkXXLlD7QeZCkr0z5B54fyymjYyYEqBKsTxVw=
X-Gm-Message-State: AOJu0YwA0FeG/31zU3ADs7sFLOVgVQnswoOwAlOCzcngVcPqc2zyLcSg
	SiL1yPV6X/z1sWKbtxxURxuDwV3mC2HkwhiTtsjK/I0NBgrYsO4QMhpNoxISZww8+hloxu2Wn5+
	vsNTkRf4p86thZD0VhI73hh9PLnxQU75RSH+rdw==
X-Google-Smtp-Source: AGHT+IH53renhcJQwt2txPS0pIBqqswFAEQrALUaZ6EkOExh3X0imx+VWniHPWvQCDwckXaGctQumizBOuMfw/NeB+E=
X-Received: by 2002:a05:690c:7442:b0:622:f7df:aa0a with SMTP id
 00721157ae682-627972d3d56mr59212357b3.22.1716296923240; Tue, 21 May 2024
 06:08:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521-qcom-firmware-name-v1-0-99a6d32b1e5e@linaro.org>
 <20240521-qcom-firmware-name-v1-1-99a6d32b1e5e@linaro.org>
 <a45b53f3-b2a5-4094-af5a-1281e0f94d2f@linaro.org> <CAA8EJprxYsoug0ipRHTmX45vaFLzJCUF0dQWOc=QLs4y6uZ1rA@mail.gmail.com>
 <878r03csxn.fsf@kernel.org>
In-Reply-To: <878r03csxn.fsf@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 21 May 2024 15:08:31 +0200
Message-ID: <CAA8EJpqkgpCb57DGka0ckbPz=2YiaHzxmiNzG39ad5y6smgO5A@mail.gmail.com>
Subject: Re: [PATCH 01/12] soc: qcom: add firmware name helper
To: Kalle Valo <kvalo@kernel.org>
Cc: neil.armstrong@linaro.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Loic Poulain <loic.poulain@linaro.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, wcn36xx@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 May 2024 at 13:20, Kalle Valo <kvalo@kernel.org> wrote:
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
>
> > On Tue, 21 May 2024 at 12:52, <neil.armstrong@linaro.org> wrote:
> >>
> >> On 21/05/2024 11:45, Dmitry Baryshkov wrote:
> >> > Qualcomm platforms have different sets of the firmware files, which
> >> > differ from platform to platform (and from board to board, due to the
> >> > embedded signatures). Rather than listing all the firmware files,
> >> > including full paths, in the DT, provide a way to determine firmware
> >> > path based on the root DT node compatible.
> >>
> >> Ok this looks quite over-engineered but necessary to handle the legacy,
> >> but I really think we should add a way to look for a board-specific path
> >> first and fallback to those SoC specific paths.
> >
> > Again, CONFIG_FW_LOADER_USER_HELPER => delays.
>
> To me this also looks like very over-engineered, can you elaborate more
> why this is needed? Concrete examples would help to understand better.

Sure. During the meeting last week Arnd suggested evaluating if we can
drop firmware-name from the board DT files. Several reasons for that:
- DT should describe the hardware, not the Linux-firmware locations
- having firmware name in DT complicates updating the tree to use
different firmware API (think of mbn vs mdt vs any other format)
- If the DT gets supplied by the vendor (e.g. for
SystemReady-certified devices), there should be a sync between the
vendor's DT, linux kernel and the rootfs. Dropping firmware names from
DT solves that by removing one piece of the equation

Now for the complexity of the solution. Each SoC family has their own
firmware set. This includes firmware for the DSPs, for modem, WiFi
bits, GPU shader, etc.
For the development boards these devices are signed by the testing key
and the actual signature is not validated against the root of trust
certificate.
For the end-user devices the signature is actually validated against
the bits fused to the SoC during manufacturing process. CA certificate
(and thus the fuses) differ from vendor to vendor (and from the device
to device)

Not all of the firmware files are a part of the public linux-firmware
tree. However we need to support the rootfs bundled with the firmware
for different platforms (both public and vendor). The non-signed files
come from the Adreno GPU and can be shared between platforms. All
other files are SoC-specific and in some cases device-specific.

So for example the SDM845 db845c (open device) loads following firmware files:
Not signed:
- qcom/a630_sqe.fw
- qcom/a630_gmu.bin

Signed, will work for any non-secured sdm845 device:
- qcom/sdm845/a630_zap.mbn
- qcom/sdm845/adsp.mbn
- qcom/sdm845/cdsp.mbn
- qcom/sdm485/mba.mbn
- qcom/sdm845/modem.mbn
- qcom/sdm845/wlanmdsp.mbn (loaded via TQFTP)
- qcom/venus-5.2/venus.mbn

Signed, works only for DB845c.
- qcom/sdm845/Thundercomm/db845c/slpi.mbn

In comparison, the SDM845 Pixel-3 phone (aka blueline) should load the
following firmware files:
- qcom/a630_sqe.fw (the same, non-signed file)
- qcom/a630_gmu.bin (the same, non-signed file)
- qcom/sdm845/Google/blueline/a630_zap.mbn
- qcom/sdm845/Google/blueline/adsp.mbn
- qcom/sdm845/Google/blueline/cdsp.mbn
- qcom/sdm845/Google/blueline/ipa_fws.mbn
- qcom/sdm845/Google/blueline/mba.mbn
- qcom/sdm845/Google/blueline/modem.mbn
- qcom/sdm845/Google/blueline/venus.mbn
- qcom/sdm845/Google/blueline/wlanmdsp.mbn
- qcom/sdm845/Google/blueline/slpi.mbn

The Lenovo Yoga C630 WoS laptop (SDM850 is a variant of SDM845) uses
another set of files:
- qcom/a630_sqe.fw (the same, non-signed file)
- qcom/a630_gmu.bin (the same, non-signed file)
- qcom/sdm850/LENOVO/81JL/qcdxkmsuc850.mbn
- qcom/sdm850/LENOVO/81JL/qcadsp850.mbn
- qcom/sdm850/LENOVO/81JL/qccdsp850.mbn
- qcom/sdm850/LENOVO/81JL/ipa_fws.elf
- qcom/sdm850/LENOVO/81JL/qcdsp1v2850.mbn
- qcom/sdm850/LENOVO/81JL/qcdsp2850.mbn
- qcom/sdm850/LENOVO/81JL/qcvss850.mbn
- qcom/sdm850/LENOVO/81JL/wlanmdsp.mbn
- qcom/sdm850/LENOVO/81JL/qcslpi850.mbn

If we look at one of the recent platforms, e.g. SM8650-QRD, this list
also grows up:
- qcom/gen70900_sqe.fw (generic, non-signed)
- qcom/gmu_gen70900.bin (generic, non-signed)
- qcom/sm8650/gen70900_zap.mbn
- qcom/sm8650/adsp.mbn
- qcom/sm8650/adsp_dtb.mbn
- qcom/sm8650/cdsp.mbn
- qcom/sm8650/cdsp_dtb.mbn
- qcom/sm8650/ipa_fws.mbn
- qcom/sm8650/modem.mbn
- qcom/sm8650/modem_dtb.mbn
- qcom/sm8650/vpu33_4v.mbn (or maybe qcom/vpu-33/vpu_4v.mbn)

-- 
With best wishes
Dmitry

