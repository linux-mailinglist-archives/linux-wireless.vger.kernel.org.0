Return-Path: <linux-wireless+bounces-14528-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 827439B04E7
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 16:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE441C22497
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC6B42AA4;
	Fri, 25 Oct 2024 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="trtMk32i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AC3212168
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864929; cv=none; b=CrM53K+HPm9pQc3aWUqWpTkqSW2j2TyoKGp/K92hO9/kn1yAjBYQvv/OPu4+681+VbSH2xsZ61PsY+iaJaRUVkwHr+QiSRKtE/zQE8FDo+RVa5hA5BBJ+gbJBwofXSbQWMrx+w9NdbbfEz3U36I5X0ioU3zvYzvUaAqtCvp6fEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864929; c=relaxed/simple;
	bh=km1L8WKtCbh8DWn3RjGAq3vjkF63vfmjc3NyOlLBGB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6BBRq/K4b6oipOBgHQex4YEWFUT3ofN7jEG/CoOE4zbNEsTTqLMswNFpM1WzoNE9B5+MTsnXSSAV9Af54oo8gRtWJz0IzIyEufBHHvr5420enUEUHU6H4NzOIKjv7xpETP8vZrK4xHAD5OXnqhQXgkkWi9kyvibXYoZCSPth+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=trtMk32i; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539e690479cso2182863e87.3
        for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 07:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729864925; x=1730469725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Nfudw1Ijx/8Xpt/Kv9XtTdHSXkroBGWJBG4jEUcsrk=;
        b=trtMk32i5EBoPCoLfpLcmt0T1XqejhenBPw4JXa+7agR1Euygq60Y/1h/Jsv+CAsgR
         5QW8VG1ELINsRtSQvToLkNwQVWVK8sCisw5tD7gRcs8F62Zvg5mYFRmsHWjtnFKWu+9p
         9VP6xpNt0PIe4v5cIGGmAUc9Actz17Fz2U2S9B/HxKqDDvD8gMwzJ7SoWzZI2IZUVYg7
         8rLjdicqGAkY8cT5qhFAmucQbuxSNWI6FWGaJbGEfNh8Ke7CTTnPKOdC0gyoCHl0VENI
         7Bvg13uTz36umRAl2yW7qRxRF/glUtaF1I2ADC8Kl2eNHv6xZykq1OYEbLlrHgJVcobE
         VEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729864925; x=1730469725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Nfudw1Ijx/8Xpt/Kv9XtTdHSXkroBGWJBG4jEUcsrk=;
        b=s2gKnQU+I5XwFHxMNcgmBJiaFIg0EOfYdZPd5G9It3VXCOTPsb+mioch5BMw5JRU/V
         nbOLOHUZT5h4h50msA+85f9+X0kuJ7uzT/m2gJq1TIWQ5DKb1KdZtGWH2p9d0EAUXgcD
         lYuu1WABmbRUOTAsvKiiAXBz+wk2i0byOl+rjw90JJr2EbNwFoKKoEVwALCJ+9IjiEgg
         u5s6m57NG4gMHOuPtjmBfk8V/7uQSO/v0jE+saUVA6VRk7MGCc7K17ViHyygEgN58+L8
         SgSkD/pDesrOBAyJMVRq89uiIjIYomShraQVb7I5pojBUXMxmJt/z53AAZUL1T7RTk0O
         6ctw==
X-Forwarded-Encrypted: i=1; AJvYcCX0f+6x+rcSvk8wwQ8YfrHHRrRWU1GwMhhpiwPReJQfKpIm8LIj9LO/+aargGOAMRB4WZSrxf5hzxLFEoX8Jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YySH9AAxR3xe7uz3KvHXrRIWUwNM3ddwTSsJHOY8vnf2ev9a2ua
	Q0z4XwFNQHdlGezoNihZbMSxyqT+5PouX7T65QdtcvkIh6hVNKVlp+IloQLf3l8=
X-Google-Smtp-Source: AGHT+IGlgIINW/NRGGW5OX/pYH3iCgOXQYfEGayutQYaIB2YYqfQv9lQrWULX7nLw4cDcYMWY/7HOQ==
X-Received: by 2002:a05:6512:114f:b0:539:88f7:d3c4 with SMTP id 2adb3069b0e04-53b1a328277mr6219477e87.29.1729864923455;
        Fri, 25 Oct 2024 07:02:03 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e140dbfsm193662e87.113.2024.10.25.07.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 07:02:02 -0700 (PDT)
Date: Fri, 25 Oct 2024 17:01:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: kvalo@kernel.org, quic_jjohnson@quicinc.com, 
	ath11k@lists.infradead.org, linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] wifi: ath11k: support board-specific firmware
 overrides
Message-ID: <xp5j6kkpggfhxvzuozqcvs2ugon5xexjgzl24zjlen7kggdaju@vd3okew4vcsy>
References: <20241024002514.92290-1-quic_miaoqing@quicinc.com>
 <20241024002514.92290-3-quic_miaoqing@quicinc.com>
 <pdjhyrjoreiykv2tquvufjw3rkti5sxrjvpmkjhvkfasq7zbo4@xxntxdmhhyg5>
 <bc3c06eb-1cb2-4cbb-aaad-95c09223f0cc@quicinc.com>
 <ig3m3sgmnkgfmwrlglundhqif6rygzl7uh7rzoemrz3yxgvfpc@35a323mw2wbt>
 <46de0bfe-ebdd-4b37-a957-3c64e30a1376@quicinc.com>
 <CAA8EJpr4zgV4Sa4sPdCToQWs+CFJu6Xz6CPcPyHDhDczmuzj=g@mail.gmail.com>
 <06ff37ef-dfda-470f-80f7-0f54bae25686@quicinc.com>
 <CAA8EJppFCXeUAZax+jv42JrKYgLmaPQNpXhn-06q_K_uB9JZLQ@mail.gmail.com>
 <46b18b39-9e88-42f8-aa88-5b527fc92a9f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46b18b39-9e88-42f8-aa88-5b527fc92a9f@quicinc.com>

On Fri, Oct 25, 2024 at 09:43:04PM +0800, Miaoqing Pan wrote:
> 
> 
> On 10/25/2024 8:21 PM, Dmitry Baryshkov wrote:
> > On Fri, 25 Oct 2024 at 15:03, Miaoqing Pan <quic_miaoqing@quicinc.com> wrote:
> > > 
> > > 
> > > 
> > > On 10/25/2024 6:20 PM, Dmitry Baryshkov wrote:
> > > > On Fri, 25 Oct 2024 at 10:23, Miaoqing Pan <quic_miaoqing@quicinc.com> wrote:
> > > > > 
> > > > > 
> > > > > 
> > > > > On 10/25/2024 2:01 PM, Dmitry Baryshkov wrote:
> > > > > > On Fri, Oct 25, 2024 at 10:56:02AM +0800, Miaoqing Pan wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > On 10/25/2024 3:39 AM, Dmitry Baryshkov wrote:
> > > > > > > > On Thu, Oct 24, 2024 at 08:25:14AM +0800, Miaoqing Pan wrote:
> > > > > > > > > QCA6698AQ IP core is the same as WCN6855 hw2.1, but it has different RF,
> > > > > > > > > IPA, thermal, RAM size and etc, so new firmware files used. This change
> > > > > > > > > allows board DT files to override the subdir of the firmware directory
> > > > > > > > > used to lookup the amss.bin and m3.bin.
> > > > > > > > 
> > > > > > > > I have slight concerns regarding the _board_ DT files overriding the
> > > > > > > > subdir. This opens a can of worms, allowing per-board firmware sets,
> > > > > > > > which (as far as I understand) is far from being what driver maintainers
> > > > > > > > would like to see. This was required for ath10k-snoc devices, since
> > > > > > > > firmware for those platforms is signed by the vendor keys and it is
> > > > > > > > limited to a particular SoC or SoC family. For ath11k-pci there is no
> > > > > > > > such limitation.
> > > > > > > > 
> > > > > > > > Would it be possible to use PCI subvendor / subdev to identify affected
> > > > > > > > cards? PCI Revision? Any other way to identify the device?  Please
> > > > > > > > provide lspci -nnvv for the affected device kind. Is there a way to
> > > > > > > > identify the RF part somehow?
> > > > > > > 
> > > > > > > It's rather difficult, for WCN685x, there are multiple evolved subseries for
> > > > > > > customized products. e.g.
> > > > > > > 
> > > > > > > QCA6698AQ/hw2.1
> > > > > > > QCA2066/hw2.1
> > > > > > > WCN6855/hw2.0/hw2.1
> > > > > > > WCN6856/hw2.1
> > > > > > > 
> > > > > > > They have the same PCIe ID (17cb:1103), the commit 5dc9d1a55e95 ("wifi:
> > > > > > > ath11k: add support for QCA2066") reads TCSR_SOC_HW_SUB_VER to enumerate all
> > > > > > > QCA2066 cards, it lacks of flexibility, as the list will become longer and
> > > > > > > longer. But it's the only choice for QCA2066, as it's customized for X86
> > > > > > > platform which without DT files.
> > > > > > 
> > > > > > I guess, this is closer to Kalle's expectations: being able to detect
> > > > > > the hardware instead of adding DT properties.
> > > > > > 
> > > > > > > So for MSM those have DT file platforms, like SA8775P-RIDE/QCS8300-RIDE both
> > > > > > > attached to QCA6698AQ, we can specify the correct firmware to
> > > > > > > 'ath11k/WCN6855/hw2.1/qca6698aq', so it's not per-board firmware, it depends
> > > > > > > on the type of the products(x86 windows, IoT products or AUTO).
> > > > > > 
> > > > > > No-no-no and no. The firmware used must not be specific to the product
> > > > > > type.  This is what everybody here is trying to avoid. Please try
> > > > > > following the QCA2066 approach instead. And note that it could use new
> > > > > > TLD as it perfectly shows itself as a different hardware kind.
> > > > > 
> > > > > Actually, TCSR_SOC_HW_SUB_VER is not SOC register, it's a TLMM hw
> > > > > revision register in BAR0 space, it's hard to maintain the list.
> > > > 
> > > > How is it so?
> > > 
> > > I think QCA2066 approach is just a workaround. Different batches of chip
> > > manufacture has different value in TCSR_SOC_HW_SUB_VER.
> > 
> > Ok. So, subvendor / subdevice?
> 
> The 'subvendor' is fixed to 0x17cb, so it's useless. And I don't have enough
> samples to decide to use 'subdevice', it's a risk for existing devices.

What kind of risk? If subvendor is fixed, then it's Qualcomm who
enumerates subdevices.

I'm really reluctant to bringing more DT usage into the PCIe space.
Especially if the user is able to swap cards.

> > > > And if it is hard, can we please get to the _normal_ way how vendors
> > > > handle PCI hardware differences: the subvendor and subdevice? This is
> > > > a usual way to describe that the PCIe device is the same, but the
> > > > analog / tuner / RF / etc parts are different.
> > > 
> > > 
> > > > 
> > > > > We're going to have another problem to enable NFA765 m.2 card for IoT
> > > > > platforms, which has different feature sets with X86 platform, so also
> > > > > new firmware should be used. In this case, QCA2066 approach not works.
> > > > > Seems DT approach is only choice.
> > > > > 
> > > > > Could you advice ?
> > > > 
> > > > Hmm, The first question is _why_ does it have different feature sets?
> > > > What exactly is different?
> > > 
> > > Yeah, for IoT device will support SAP/TWT/UL-OFDMA/BSS color and etc new
> > > features, and the existing x86 firmware mainly for STA mode.
> > > 
> > > What if the user plugs a normal (laptop)
> > > > M.2 card into their IoT device?
> > > 
> > > If there is no DT file to specify the firmware, IoT device will load the
> > > default firmware, it will affect SAP and WiFi-6 advanced features.
> > 
> > Can we get all those nice features into x86 world instead?
> 
> It's out of our scope, we will not touch the existing stable firmware
> version, also it's not allowed.

If it's not allowed for laptop cards, why is it allowed for IoT M.2
cards (which then can be perfectly installed into the laptop)?

> > > > > > > 0000:01:00.0 Network controller [0280]: Qualcomm QCNFA765 Wireless Network
> > > > > > > Adapter [17cb:1103] (rev 01)
> > > > > > >        Subsystem: Qualcomm QCNFA765 Wireless Network Adapter [17cb:0108]
> > > > > > >        Device tree node: /sys/firmware/devicetree/base/pci@1c00000/pcie@0/wifi@0
> > > > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > Could you possibly clarify, how this situation is handled in Windows
> > > > > > > > world?
> > > > > > > 
> > > > > > > X86 platforms use standard m.2 PCIe card, and it will only use the default
> > > > > > > main firmware files, as they without DT files.
> > > > > > 
> > > > > > So QCA6698AQ cannot appear on an M.2 PCIe card?
> > > > > 
> > > > > No, but no m.2 PCIe card so far. It depends on power sequencing module
> > > > > to do power up.
> > > > 
> > > > You are describing software (power sequencing module), while I was
> > > > talking about the hardware. Nothing prevents OEM from adding fixed
> > > > regulators to drive necessary voltages from the PCIe slot.

-- 
With best wishes
Dmitry

