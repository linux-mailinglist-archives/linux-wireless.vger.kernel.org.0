Return-Path: <linux-wireless+bounces-14544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F419B0833
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 17:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58868284321
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 15:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89028136E37;
	Fri, 25 Oct 2024 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jv1cRHiS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF98290F
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870061; cv=none; b=NPb+EAq1lsDBKdof2knN4sTET3kOsOIGhGqPGxO993i4h5iqhs51E22M2kqJxiBT1MfT5VWZkiQ0+BcULxCrDipTq8lPfUZOQdbJzpfVD4y9E7WlfcC62eazZzVaxMKXQNIbENtRZ7jF7E7JpZDsFdcOK5U3utEQwdUm6MH5Jw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870061; c=relaxed/simple;
	bh=YPz8n32v4Or352YKfavyNO4WwbwT2nTFjcL2sYaypOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0qBND0wTj2jWXZ1liS1+8lSpVuOXGIIWSXvfmueejiZjg0Wlw1jI1SMBMK3zI3bdA+IxYDbU80hUrGUD0TGwM2Amc+TWFjd03dplntIgYEA0xP4hx7GFTWQ2uLrw4O2SADKuKzTYoQYp8FJ9BA8Wn9Jwv2nssDwCjBxV/TfEO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jv1cRHiS; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so21093211fa.3
        for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 08:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729870057; x=1730474857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLxMD3LYpw0aYM0hbqBZVGj7CYv7DfIj6AfWn1gCd9U=;
        b=Jv1cRHiS2xIU411IJzoF9y9SxLZT1kxnTkxAMTb20G3CU1ehHalH7mmJTu0BpLSKcp
         bH8jBmUzGQaMuMs7WqHWd1RwK1co0ekjzifdhMOQmmTE5ADc5QhX5DUMAt16xf1Bxxc9
         ++4WuYf0r/Q/gDxXMoburDK2sWbZhxg3DvFeu80PEIbo6hxjLJFgbOs7g1Bikc9SQRwB
         pF4ItVgWdATSmhHoc3DLJuSNbiG83l5Gzqc4Jkj4EdD5JkmTRUEgaJl+YJyNcqhcdmbj
         b++ne/FSRFy4RTiwjvXrGPdVgI3/auWvOLHsKdy8Sf0ldoCx/49MwrbU3vx7WrOJaff4
         K89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729870057; x=1730474857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLxMD3LYpw0aYM0hbqBZVGj7CYv7DfIj6AfWn1gCd9U=;
        b=i1A2L3DCk5EyaT+C+nu7wy4r2bIxZgTqzWHw+aYv/zq/x8i6unrf6fu+PRYjVUeP6d
         amvHFJmjUXV6yaKpva/MMG9G7yox/KRgv1K0jRLolpn7wkaf3yLtWF9W384Y+OFs9Lfh
         qRYdlJtnpIktc021GuNVMIaVInp7gG+k7R9DfhwSF64om+abZNw1qLrngTXVS7X7LYL4
         dZqQ8gARfRrGqSK+7p4cGIpSqNVFQGsUdJslAzzVZhA5PRBV71X5m2aMrplDDSK9f+Zq
         ZOhObCWUVjkUvOzOJaNfJxZSfu1KqURYyXuvho7l+93zpuUum2UTWSCeoKtfqeOKRKrQ
         jeLw==
X-Forwarded-Encrypted: i=1; AJvYcCUjW0J/+brNd2wEG/RBXuClPqEXG+dKrAAgxOiSb8hBJVRj5xqjYsMotVDWEPWd8PPg5Qf7WArjmsZozgzAJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFrw4SghAYbRC33QekdAqvrJ1EQnPZaeYAlMkClQi9lVxv94Gw
	DcdNGkHiYpdFh6etgam0xVI5zY1N4VZXMjeIeQ8mTDjgdCzIAA++gIUldkGbUQU=
X-Google-Smtp-Source: AGHT+IHymibtLZvbqHExD9TlPcDKRRIDD1wUReJVGtgRQre4wReQTIklKIuoBWC9W7yPTptEs0wKaw==
X-Received: by 2002:a2e:8507:0:b0:2fb:51e0:91b with SMTP id 38308e7fff4ca-2fca828d9ebmr33654021fa.43.1729870056799;
        Fri, 25 Oct 2024 08:27:36 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb4519adfsm2236771fa.41.2024.10.25.08.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:27:35 -0700 (PDT)
Date: Fri, 25 Oct 2024 18:27:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: kvalo@kernel.org, quic_jjohnson@quicinc.com, 
	ath11k@lists.infradead.org, linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] wifi: ath11k: support board-specific firmware
 overrides
Message-ID: <ksyukz7oouw2ilxxpx5nhnshu3zmnd5rtgeloea2vykzzn6ii5@unvpx26neirt>
References: <pdjhyrjoreiykv2tquvufjw3rkti5sxrjvpmkjhvkfasq7zbo4@xxntxdmhhyg5>
 <bc3c06eb-1cb2-4cbb-aaad-95c09223f0cc@quicinc.com>
 <ig3m3sgmnkgfmwrlglundhqif6rygzl7uh7rzoemrz3yxgvfpc@35a323mw2wbt>
 <46de0bfe-ebdd-4b37-a957-3c64e30a1376@quicinc.com>
 <CAA8EJpr4zgV4Sa4sPdCToQWs+CFJu6Xz6CPcPyHDhDczmuzj=g@mail.gmail.com>
 <06ff37ef-dfda-470f-80f7-0f54bae25686@quicinc.com>
 <CAA8EJppFCXeUAZax+jv42JrKYgLmaPQNpXhn-06q_K_uB9JZLQ@mail.gmail.com>
 <46b18b39-9e88-42f8-aa88-5b527fc92a9f@quicinc.com>
 <xp5j6kkpggfhxvzuozqcvs2ugon5xexjgzl24zjlen7kggdaju@vd3okew4vcsy>
 <49313be4-b0e2-4ec4-8663-bd4daf20f78a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49313be4-b0e2-4ec4-8663-bd4daf20f78a@quicinc.com>

On Fri, Oct 25, 2024 at 10:23:45PM +0800, Miaoqing Pan wrote:
> 
> 
> On 10/25/2024 10:01 PM, Dmitry Baryshkov wrote:
> > On Fri, Oct 25, 2024 at 09:43:04PM +0800, Miaoqing Pan wrote:
> > > 
> > > 
> > > On 10/25/2024 8:21 PM, Dmitry Baryshkov wrote:
> > > > On Fri, 25 Oct 2024 at 15:03, Miaoqing Pan <quic_miaoqing@quicinc.com> wrote:
> > > > > 
> > > > > 
> > > > > 
> > > > > On 10/25/2024 6:20 PM, Dmitry Baryshkov wrote:
> > > > > > On Fri, 25 Oct 2024 at 10:23, Miaoqing Pan <quic_miaoqing@quicinc.com> wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > On 10/25/2024 2:01 PM, Dmitry Baryshkov wrote:
> > > > > > > > On Fri, Oct 25, 2024 at 10:56:02AM +0800, Miaoqing Pan wrote:
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > On 10/25/2024 3:39 AM, Dmitry Baryshkov wrote:
> > > > > > > > > > On Thu, Oct 24, 2024 at 08:25:14AM +0800, Miaoqing Pan wrote:
> > > > > > > > > > > QCA6698AQ IP core is the same as WCN6855 hw2.1, but it has different RF,
> > > > > > > > > > > IPA, thermal, RAM size and etc, so new firmware files used. This change
> > > > > > > > > > > allows board DT files to override the subdir of the firmware directory
> > > > > > > > > > > used to lookup the amss.bin and m3.bin.
> > > > > > > > > > 
> > > > > > > > > > I have slight concerns regarding the _board_ DT files overriding the
> > > > > > > > > > subdir. This opens a can of worms, allowing per-board firmware sets,
> > > > > > > > > > which (as far as I understand) is far from being what driver maintainers
> > > > > > > > > > would like to see. This was required for ath10k-snoc devices, since
> > > > > > > > > > firmware for those platforms is signed by the vendor keys and it is
> > > > > > > > > > limited to a particular SoC or SoC family. For ath11k-pci there is no
> > > > > > > > > > such limitation.
> > > > > > > > > > 
> > > > > > > > > > Would it be possible to use PCI subvendor / subdev to identify affected
> > > > > > > > > > cards? PCI Revision? Any other way to identify the device?  Please
> > > > > > > > > > provide lspci -nnvv for the affected device kind. Is there a way to
> > > > > > > > > > identify the RF part somehow?
> > > > > > > > > 
> > > > > > > > > It's rather difficult, for WCN685x, there are multiple evolved subseries for
> > > > > > > > > customized products. e.g.
> > > > > > > > > 
> > > > > > > > > QCA6698AQ/hw2.1
> > > > > > > > > QCA2066/hw2.1
> > > > > > > > > WCN6855/hw2.0/hw2.1
> > > > > > > > > WCN6856/hw2.1
> > > > > > > > > 
> > > > > > > > > They have the same PCIe ID (17cb:1103), the commit 5dc9d1a55e95 ("wifi:
> > > > > > > > > ath11k: add support for QCA2066") reads TCSR_SOC_HW_SUB_VER to enumerate all
> > > > > > > > > QCA2066 cards, it lacks of flexibility, as the list will become longer and
> > > > > > > > > longer. But it's the only choice for QCA2066, as it's customized for X86
> > > > > > > > > platform which without DT files.
> > > > > > > > 
> > > > > > > > I guess, this is closer to Kalle's expectations: being able to detect
> > > > > > > > the hardware instead of adding DT properties.
> > > > > > > > 
> > > > > > > > > So for MSM those have DT file platforms, like SA8775P-RIDE/QCS8300-RIDE both
> > > > > > > > > attached to QCA6698AQ, we can specify the correct firmware to
> > > > > > > > > 'ath11k/WCN6855/hw2.1/qca6698aq', so it's not per-board firmware, it depends
> > > > > > > > > on the type of the products(x86 windows, IoT products or AUTO).
> > > > > > > > 
> > > > > > > > No-no-no and no. The firmware used must not be specific to the product
> > > > > > > > type.  This is what everybody here is trying to avoid. Please try
> > > > > > > > following the QCA2066 approach instead. And note that it could use new
> > > > > > > > TLD as it perfectly shows itself as a different hardware kind.
> > > > > > > 
> > > > > > > Actually, TCSR_SOC_HW_SUB_VER is not SOC register, it's a TLMM hw
> > > > > > > revision register in BAR0 space, it's hard to maintain the list.
> > > > > > 
> > > > > > How is it so?
> > > > > 
> > > > > I think QCA2066 approach is just a workaround. Different batches of chip
> > > > > manufacture has different value in TCSR_SOC_HW_SUB_VER.
> > > > 
> > > > Ok. So, subvendor / subdevice?
> > > 
> > > The 'subvendor' is fixed to 0x17cb, so it's useless. And I don't have enough
> > > samples to decide to use 'subdevice', it's a risk for existing devices.
> > 
> > What kind of risk? If subvendor is fixed, then it's Qualcomm who
> > enumerates subdevices.
> 
> It's risk for there is not enough sample card to verify. Subdevice is never
> used by ath1xk drivers.

Oh, so it's just about development. I'd say, please discuss such risks
with your management, unless Kalle or Jeff disagree with using the
subdevice for identification.

> 
> > 
> > I'm really reluctant to bringing more DT usage into the PCIe space.
> > Especially if the user is able to swap cards.
> 
> Understand your concern, automatic adaptation is always the best choice. But
> it may not work for MSM boards, the PCIe card (non m.2) is customized, which
> has special PMU control. User can't swap cards. And that's why power
> sequencing module was introduced.

I know. Still, it's better to have less unnecessary data there for
autodiscoverable devices.

> 
> > 
> > > > > > And if it is hard, can we please get to the _normal_ way how vendors
> > > > > > handle PCI hardware differences: the subvendor and subdevice? This is
> > > > > > a usual way to describe that the PCIe device is the same, but the
> > > > > > analog / tuner / RF / etc parts are different.
> > > > > 
> > > > > 
> > > > > > 
> > > > > > > We're going to have another problem to enable NFA765 m.2 card for IoT
> > > > > > > platforms, which has different feature sets with X86 platform, so also
> > > > > > > new firmware should be used. In this case, QCA2066 approach not works.
> > > > > > > Seems DT approach is only choice.
> > > > > > > 
> > > > > > > Could you advice ?
> > > > > > 
> > > > > > Hmm, The first question is _why_ does it have different feature sets?
> > > > > > What exactly is different?
> > > > > 
> > > > > Yeah, for IoT device will support SAP/TWT/UL-OFDMA/BSS color and etc new
> > > > > features, and the existing x86 firmware mainly for STA mode.
> > > > > 
> > > > > What if the user plugs a normal (laptop)
> > > > > > M.2 card into their IoT device?
> > > > > 
> > > > > If there is no DT file to specify the firmware, IoT device will load the
> > > > > default firmware, it will affect SAP and WiFi-6 advanced features.
> > > > 
> > > > Can we get all those nice features into x86 world instead?
> > > 
> > > It's out of our scope, we will not touch the existing stable firmware
> > > version, also it's not allowed.
> > 
> > If it's not allowed for laptop cards, why is it allowed for IoT M.2
> > cards (which then can be perfectly installed into the laptop)?
> > 
> 
> Only specific IoT M.2 cards.

But they are (or are going to be available) for purchase? And more
importantly, what prevents the user of a normal card to use "featureful"
firmware with the laptop card?

-- 
With best wishes
Dmitry

