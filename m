Return-Path: <linux-wireless+bounces-14604-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFC49B3215
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 14:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617731C21708
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 13:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424001DD553;
	Mon, 28 Oct 2024 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="phoSQehf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D201DD54F
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123131; cv=none; b=G5QsaIeXacL/tvCIr4h0Za/+oXI9Tu4yir0Nh73e36ydNkCgZgs09+QGAp0/fpeYu1wS+tww9YfsGo6GkuV97J7vPonXBLDYJ2V6Ljcarm4UTdwWtrC03OvgdyFTZjQr5O3RiOlgsE8ZYxkkmrtk237ybbnDxatbXZZU5Rm16tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123131; c=relaxed/simple;
	bh=c9Bnie5gjWg5qAaooS0tseLbjH97xMYay6m2kR7/Gks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lk2z4OfhiG8oqNqo+PzTKzQl9tcjx54bYKrU6L6wgTzr9ePiPWqtpZmwJ1eXeeJChVwcBkA8ZpYK4uNqwHvz8ddrDuXj/VEQfoMNUYg8Xi3wUwhflVvdGUr0BvrUawV5lK22psDqRsUWEKhR4wys9d28WmK/LXNsfdfqozZdR/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=phoSQehf; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so3786442e87.3
        for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 06:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730123125; x=1730727925; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WO0RokSzStMyH39P9sh2ZF0TdhIRX16l/eJa/RyOWMM=;
        b=phoSQehfX6T9BbMLYfT6PmcTyaH/hnW1oH5mHGFj89VjR9/fVJFtB8Pqgs9ohC2cry
         /PAOALiWtcNBcbZiJTxhMLAgMZSX/KRYhkkunk7S4+4byivRVAWu9if2EG0B6uLuwHYq
         osExbALtWV4ZoEHMc+jpoguDAQ4jZhENkU4Yt6eBUd0Px7tEjuXo/0HQ2rYqY62HRs6R
         iHEFUl17YRu8wRzvd0ZpDTrpjmvG5vFNsp4IiBPxF9FX3KnLnF9d1sV9qA00H/mNy3l5
         6W8o1yp+LnroSQUKUs/TQBXgq1rDxfItYpLjzGPNPBTmn7UqkFhUiZxRfIyAh8lYe/W7
         BObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730123125; x=1730727925;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WO0RokSzStMyH39P9sh2ZF0TdhIRX16l/eJa/RyOWMM=;
        b=sNDkIp2v2vmeF5pt5sJsUB9jiZQXkEjRaLxZ4AjBX9XMGFXgiG+DX/h0X3nINLla4h
         2+dYR7vRWefbs+Q6V6M8hpw7Zg30a471l0MHfhckNmBv6a77URmKjOvwxyeaHSj5e9/m
         YBJM7jvOh40H4AbRmstINRpOf8ep4KT1IlITSiiIeZSBV6fAcklC9OESP4jYIUndU/v/
         XgXPa6sFxVvlFB09gD3WaTXfB7VQ45JBGv7uNkYU0MkRyG8+zeXqGBMpUpmC+8PIQOXA
         YjUBOT0375ObrO6tK0N0IZHj2yVNHhvsIlPWqtU9qdjIxopkjqXfqopX3BeuuV3p5v25
         7uWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5HC/dZ9AZw2y1GJIbfrRWukphbmcp5QbWC846vpWygCsXsSu+ZQwGnJExTrc2WmKKnZEIbcxQdzHmZkHa2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1yqKfMH0Czxkqb9FhPNhbeV80PkDHM+Z+OkRSNcbUqI5eNLQ9
	4W2BO9UY0qjXMSiohn0u7c47mZ+wUSf2SqOR7P3+VyvnjIJAh9lavSnqoFAuULFDil4x8VKgs2N
	/
X-Google-Smtp-Source: AGHT+IGS4vPQ+Q6HiVFBj075lT+rkxLvIyaDKK0RAmKN97y0BbJzsIWNX9GwRVdo1Fa3VJgpemPDtg==
X-Received: by 2002:a05:6512:1324:b0:539:f807:ada1 with SMTP id 2adb3069b0e04-53b34c463c1mr2702355e87.58.1730123125322;
        Mon, 28 Oct 2024 06:45:25 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1f317bsm1091035e87.286.2024.10.28.06.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:45:24 -0700 (PDT)
Date: Mon, 28 Oct 2024 15:45:22 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: kvalo@kernel.org, quic_jjohnson@quicinc.com, 
	ath11k@lists.infradead.org, linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	quic_zhichen@quicinc.com
Subject: Re: [PATCH v2 2/2] wifi: ath11k: support board-specific firmware
 overrides
Message-ID: <csqlwll36viejkp7k57r3jdejpt2kkttmzawq6y6q7i7qs25ht@n3mazu6owblv>
References: <46de0bfe-ebdd-4b37-a957-3c64e30a1376@quicinc.com>
 <CAA8EJpr4zgV4Sa4sPdCToQWs+CFJu6Xz6CPcPyHDhDczmuzj=g@mail.gmail.com>
 <06ff37ef-dfda-470f-80f7-0f54bae25686@quicinc.com>
 <CAA8EJppFCXeUAZax+jv42JrKYgLmaPQNpXhn-06q_K_uB9JZLQ@mail.gmail.com>
 <46b18b39-9e88-42f8-aa88-5b527fc92a9f@quicinc.com>
 <xp5j6kkpggfhxvzuozqcvs2ugon5xexjgzl24zjlen7kggdaju@vd3okew4vcsy>
 <49313be4-b0e2-4ec4-8663-bd4daf20f78a@quicinc.com>
 <ksyukz7oouw2ilxxpx5nhnshu3zmnd5rtgeloea2vykzzn6ii5@unvpx26neirt>
 <590b729b-a921-4ed7-af2d-326cf596ae1f@quicinc.com>
 <73916bc3-f3c8-4ef9-ab8b-d1497f228d13@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73916bc3-f3c8-4ef9-ab8b-d1497f228d13@quicinc.com>

On Mon, Oct 28, 2024 at 06:32:58PM +0800, Miaoqing Pan wrote:
> 
> 
> On 10/26/2024 10:31 AM, Miaoqing Pan wrote:
> > 
> > 
> > On 10/25/2024 11:27 PM, Dmitry Baryshkov wrote:
> > > On Fri, Oct 25, 2024 at 10:23:45PM +0800, Miaoqing Pan wrote:
> > > > 
> > > > 
> > > > On 10/25/2024 10:01 PM, Dmitry Baryshkov wrote:
> > > > > On Fri, Oct 25, 2024 at 09:43:04PM +0800, Miaoqing Pan wrote:
> > > > > > 
> > > > > > 
> > > > > > On 10/25/2024 8:21 PM, Dmitry Baryshkov wrote:
> > > > > > > On Fri, 25 Oct 2024 at 15:03, Miaoqing Pan
> > > > > > > <quic_miaoqing@quicinc.com> wrote:
> > > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > On 10/25/2024 6:20 PM, Dmitry Baryshkov wrote:
> > > > > > > > > On Fri, 25 Oct 2024 at 10:23, Miaoqing Pan
> > > > > > > > > <quic_miaoqing@quicinc.com> wrote:
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > On 10/25/2024 2:01 PM, Dmitry Baryshkov wrote:
> > > > > > > > > > > On Fri, Oct 25, 2024 at 10:56:02AM +0800, Miaoqing Pan wrote:
> > > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > On 10/25/2024 3:39 AM, Dmitry Baryshkov wrote:
> > > > > > > > > > > > > On Thu, Oct 24, 2024 at 08:25:14AM +0800, Miaoqing Pan wrote:
> > > > > > > > > > > > > > QCA6698AQ IP core is the
> > > > > > > > > > > > > > same as WCN6855 hw2.1,
> > > > > > > > > > > > > > but it has different RF,
> > > > > > > > > > > > > > IPA, thermal, RAM size
> > > > > > > > > > > > > > and etc, so new firmware
> > > > > > > > > > > > > > files used. This change
> > > > > > > > > > > > > > allows board DT files to
> > > > > > > > > > > > > > override the subdir of
> > > > > > > > > > > > > > the firmware directory
> > > > > > > > > > > > > > used to lookup the amss.bin and m3.bin.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > I have slight concerns
> > > > > > > > > > > > > regarding the _board_ DT
> > > > > > > > > > > > > files overriding the
> > > > > > > > > > > > > subdir. This opens a can of
> > > > > > > > > > > > > worms, allowing per-board
> > > > > > > > > > > > > firmware sets,
> > > > > > > > > > > > > which (as far as I
> > > > > > > > > > > > > understand) is far from
> > > > > > > > > > > > > being what driver
> > > > > > > > > > > > > maintainers
> > > > > > > > > > > > > would like to see. This was
> > > > > > > > > > > > > required for ath10k-snoc
> > > > > > > > > > > > > devices, since
> > > > > > > > > > > > > firmware for those platforms
> > > > > > > > > > > > > is signed by the vendor keys
> > > > > > > > > > > > > and it is
> > > > > > > > > > > > > limited to a particular SoC
> > > > > > > > > > > > > or SoC family. For
> > > > > > > > > > > > > ath11k-pci there is no
> > > > > > > > > > > > > such limitation.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Would it be possible to use
> > > > > > > > > > > > > PCI subvendor / subdev to
> > > > > > > > > > > > > identify affected
> > > > > > > > > > > > > cards? PCI Revision? Any
> > > > > > > > > > > > > other way to identify the
> > > > > > > > > > > > > device?  Please
> > > > > > > > > > > > > provide lspci -nnvv for the
> > > > > > > > > > > > > affected device kind. Is
> > > > > > > > > > > > > there a way to
> > > > > > > > > > > > > identify the RF part somehow?
> > > > > > > > > > > > 
> > > > > > > > > > > > It's rather difficult, for
> > > > > > > > > > > > WCN685x, there are multiple
> > > > > > > > > > > > evolved subseries for
> > > > > > > > > > > > customized products. e.g.
> > > > > > > > > > > > 
> > > > > > > > > > > > QCA6698AQ/hw2.1
> > > > > > > > > > > > QCA2066/hw2.1
> > > > > > > > > > > > WCN6855/hw2.0/hw2.1
> > > > > > > > > > > > WCN6856/hw2.1
> > > > > > > > > > > > 
> > > > > > > > > > > > They have the same PCIe ID
> > > > > > > > > > > > (17cb:1103), the commit
> > > > > > > > > > > > 5dc9d1a55e95 ("wifi:
> > > > > > > > > > > > ath11k: add support for
> > > > > > > > > > > > QCA2066") reads
> > > > > > > > > > > > TCSR_SOC_HW_SUB_VER to enumerate
> > > > > > > > > > > > all
> > > > > > > > > > > > QCA2066 cards, it lacks of
> > > > > > > > > > > > flexibility, as the list will
> > > > > > > > > > > > become longer and
> > > > > > > > > > > > longer. But it's the only choice
> > > > > > > > > > > > for QCA2066, as it's customized
> > > > > > > > > > > > for X86
> > > > > > > > > > > > platform which without DT files.
> > > > > > > > > > > 
> > > > > > > > > > > I guess, this is closer to Kalle's
> > > > > > > > > > > expectations: being able to detect
> > > > > > > > > > > the hardware instead of adding DT properties.
> > > > > > > > > > > 
> > > > > > > > > > > > So for MSM those have DT file
> > > > > > > > > > > > platforms, like SA8775P-RIDE/
> > > > > > > > > > > > QCS8300-RIDE both
> > > > > > > > > > > > attached to QCA6698AQ, we can specify the correct firmware to
> > > > > > > > > > > > 'ath11k/WCN6855/hw2.1/qca6698aq',
> > > > > > > > > > > > so it's not per-board firmware,
> > > > > > > > > > > > it depends
> > > > > > > > > > > > on the type of the products(x86 windows, IoT products or AUTO).
> > > > > > > > > > > 
> > > > > > > > > > > No-no-no and no. The firmware used
> > > > > > > > > > > must not be specific to the product
> > > > > > > > > > > type.  This is what everybody here is trying to avoid. Please try
> > > > > > > > > > > following the QCA2066 approach
> > > > > > > > > > > instead. And note that it could use
> > > > > > > > > > > new
> > > > > > > > > > > TLD as it perfectly shows itself as a different hardware kind.
> > > > > > > > > > 
> > > > > > > > > > Actually, TCSR_SOC_HW_SUB_VER is not SOC register, it's a TLMM hw
> > > > > > > > > > revision register in BAR0 space, it's hard to maintain the list.
> > > > > > > > > 
> > > > > > > > > How is it so?
> > > > > > > > 
> > > > > > > > I think QCA2066 approach is just a workaround.
> > > > > > > > Different batches of chip
> > > > > > > > manufacture has different value in TCSR_SOC_HW_SUB_VER.
> > > > > > > 
> > > > > > > Ok. So, subvendor / subdevice?
> > > > > > 
> > > > > > The 'subvendor' is fixed to 0x17cb, so it's useless. And
> > > > > > I don't have enough
> > > > > > samples to decide to use 'subdevice', it's a risk for
> > > > > > existing devices.
> > > > > 
> > > > > What kind of risk? If subvendor is fixed, then it's Qualcomm who
> > > > > enumerates subdevices.
> > > > 
> > > > It's risk for there is not enough sample card to verify.
> > > > Subdevice is never
> > > > used by ath1xk drivers.
> > > 
> > > Oh, so it's just about development. I'd say, please discuss such risks
> > > with your management, unless Kalle or Jeff disagree with using the
> > > subdevice for identification.
> > 
> > Kalle & Jeff, any idea to introduce subdevice ?
> > 
> > 
> 
> Whether 'QCA2066 approach' or 'subdevice approach', all need to introduce
> lots of redundant code, as they share the same IP code.
> 
> 'DT approach' only needs minor change, brings great flexibility. It's only
> for Snapdragon boards, will not affect default firmware for X86 platforms.
> 
> > > 
> > > > 
> > > > > 
> > > > > I'm really reluctant to bringing more DT usage into the PCIe space.
> > > > > Especially if the user is able to swap cards.
> > > > 
> > > > Understand your concern, automatic adaptation is always the best
> > > > choice. But
> > > > it may not work for MSM boards, the PCIe card (non m.2) is
> > > > customized, which
> > > > has special PMU control. User can't swap cards. And that's why power
> > > > sequencing module was introduced.
> > > 
> > > I know. Still, it's better to have less unnecessary data there for
> > > autodiscoverable devices.
> > 
> 
> We discussed internally, we have no other choice to enable NFA765 for non
> X86 boards. Could you please approve this 'DT' approach ?

If you can't use subdevice approach for some reason, then we have no
other choice that I can imagine.

-- 
With best wishes
Dmitry

