Return-Path: <linux-wireless+bounces-14524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9609B0219
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 14:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC3B283E1A
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 12:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501BC2003BC;
	Fri, 25 Oct 2024 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D1/a7w3i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B161F9431
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858932; cv=none; b=RTGPuIHhvoP11Wjw5vJ8+uSY07n3v6asmL0qrg5sQ4OnnkXDRAMxNCNiggSwVmFV//5nI/XVSfLK3UlcJCHZvcMCUEh9jHdsVs0vJE0T3UkSpYf1Fx/GH1AgA4s8VfWZgoEHqPypw/U4mfPkk8De5BhcfeRyb+x+iu7+w4O9SuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858932; c=relaxed/simple;
	bh=0XLyKZA5s/QwQ+q6U7ilOWVodPo+JjWLEbx/y7TM4fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyZ8n1Kryi1AKVA25vwfRlBnbSE23PZrE8m2WkWvrMPL2jSJs+r5B/pfRK+hzUknUNDuAIc8/DfI/q9/+HxdNUp1Z0oZ8lcFgvkhckqVP/Uak5bHKH6fDtFFSg4M6ptAw7OXNmLvN4D6+x2rhV3lHgubZX6cnf9lui7c/BhpwwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D1/a7w3i; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e2e2d013f2dso2237001276.1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 05:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729858929; x=1730463729; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LxzRE0N2s/7zXVtfiA+xvApQOBfYughP6DuudM8VCDI=;
        b=D1/a7w3iZnl4FTwTqWUkrHVnS0Zqq7NhirCcgdJSOyQDkNMpnjV9M8qevQleHrQyMI
         aZigOP9CcAfEzRPjSj2xj8M0RP5Eitedr9KzgWY9U8rJCrLQzVGmgJ5Iob2Y9rGzni43
         uDkc6TzN3NqWPz6LqstpJYifdSWGgnl1Ui3rRhzCILBthKKQL61Gw8QU52HIiLndc+bE
         WgGvAQrs2HfG05qboYB+1ArO+v+x8lyXZD/CeAdyfzF5Q37LgfI6n96oBQFWzJeh1fsn
         NvNB4rFI7vjPOyunZltAn4BAfVfrof7hztjjSITDB7R1T4HAW8Hl8ZgHIlS3YZOwnWA3
         2lYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729858929; x=1730463729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxzRE0N2s/7zXVtfiA+xvApQOBfYughP6DuudM8VCDI=;
        b=cbDmdYbXAjUFXvXJOtP239KUUzwXeNn2lIgl31/MKmGcQsu7KDg/fBVDGGH1sNxSQh
         RQMT5PNOsZH5/DplZW0mT+AOIKSJjAXKzQ9+iGd/0HuihPEN3q8Zr47LOb+lumNXv5OP
         l2AgtgIMRAUeqA+vrcMFS/q2JeZcPKJDuCyF2rpE4oYMQfIdjLkWMUSmMoXMkKzVIn1f
         HpHZMvrdx5jjsQrfIwXf8+9DcD7w2NbkG4Y4MA468GHZhqSnuKFVh3lsWlytagIpQn4P
         nsoFKubIKDYuCVd2tCEYV3c606AyYdde+AkMgWtxj23YfXh9rMqBs4lvQsMjhSKu5OTY
         RoQg==
X-Forwarded-Encrypted: i=1; AJvYcCUhfyMG/vi70Df7xs3qs6oDqTorP3NEAA5V4GI37BMCrp5MpyEvWqe82yGJrHvq9u3WGy9tLGw36OOpgHjgPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLSjlV3NCHwGrnGIPCPteg1XSMDVhBL3r4NqunmM9hlWJ5Mplv
	B0XWA31II9CnUOCRN9SBg1L+2/J3IGNSotglQkHty6ovCgo25Rn40rOOlAObOIDlUeKZNo7LlR1
	+kERcv2kZaKB0Yw2l6jkfG/QNAMyFamdHYbkkwg==
X-Google-Smtp-Source: AGHT+IFwyIesELBkScq0Aizd6KHsCPs/KR8vou/Mnx8r6zG1TNlCTqPTwPa0ElcapuznuVMqbh1W4wQ2YsSD25RDf/I=
X-Received: by 2002:a05:690c:39c:b0:6e3:39ed:f029 with SMTP id
 00721157ae682-6e7f0fdc58amr111291477b3.44.1729858928907; Fri, 25 Oct 2024
 05:22:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024002514.92290-1-quic_miaoqing@quicinc.com>
 <20241024002514.92290-3-quic_miaoqing@quicinc.com> <pdjhyrjoreiykv2tquvufjw3rkti5sxrjvpmkjhvkfasq7zbo4@xxntxdmhhyg5>
 <bc3c06eb-1cb2-4cbb-aaad-95c09223f0cc@quicinc.com> <ig3m3sgmnkgfmwrlglundhqif6rygzl7uh7rzoemrz3yxgvfpc@35a323mw2wbt>
 <46de0bfe-ebdd-4b37-a957-3c64e30a1376@quicinc.com> <CAA8EJpr4zgV4Sa4sPdCToQWs+CFJu6Xz6CPcPyHDhDczmuzj=g@mail.gmail.com>
 <06ff37ef-dfda-470f-80f7-0f54bae25686@quicinc.com>
In-Reply-To: <06ff37ef-dfda-470f-80f7-0f54bae25686@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 25 Oct 2024 15:21:56 +0300
Message-ID: <CAA8EJppFCXeUAZax+jv42JrKYgLmaPQNpXhn-06q_K_uB9JZLQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] wifi: ath11k: support board-specific firmware overrides
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: kvalo@kernel.org, quic_jjohnson@quicinc.com, ath11k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Oct 2024 at 15:03, Miaoqing Pan <quic_miaoqing@quicinc.com> wrote:
>
>
>
> On 10/25/2024 6:20 PM, Dmitry Baryshkov wrote:
> > On Fri, 25 Oct 2024 at 10:23, Miaoqing Pan <quic_miaoqing@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 10/25/2024 2:01 PM, Dmitry Baryshkov wrote:
> >>> On Fri, Oct 25, 2024 at 10:56:02AM +0800, Miaoqing Pan wrote:
> >>>>
> >>>>
> >>>> On 10/25/2024 3:39 AM, Dmitry Baryshkov wrote:
> >>>>> On Thu, Oct 24, 2024 at 08:25:14AM +0800, Miaoqing Pan wrote:
> >>>>>> QCA6698AQ IP core is the same as WCN6855 hw2.1, but it has different RF,
> >>>>>> IPA, thermal, RAM size and etc, so new firmware files used. This change
> >>>>>> allows board DT files to override the subdir of the firmware directory
> >>>>>> used to lookup the amss.bin and m3.bin.
> >>>>>
> >>>>> I have slight concerns regarding the _board_ DT files overriding the
> >>>>> subdir. This opens a can of worms, allowing per-board firmware sets,
> >>>>> which (as far as I understand) is far from being what driver maintainers
> >>>>> would like to see. This was required for ath10k-snoc devices, since
> >>>>> firmware for those platforms is signed by the vendor keys and it is
> >>>>> limited to a particular SoC or SoC family. For ath11k-pci there is no
> >>>>> such limitation.
> >>>>>
> >>>>> Would it be possible to use PCI subvendor / subdev to identify affected
> >>>>> cards? PCI Revision? Any other way to identify the device?  Please
> >>>>> provide lspci -nnvv for the affected device kind. Is there a way to
> >>>>> identify the RF part somehow?
> >>>>
> >>>> It's rather difficult, for WCN685x, there are multiple evolved subseries for
> >>>> customized products. e.g.
> >>>>
> >>>> QCA6698AQ/hw2.1
> >>>> QCA2066/hw2.1
> >>>> WCN6855/hw2.0/hw2.1
> >>>> WCN6856/hw2.1
> >>>>
> >>>> They have the same PCIe ID (17cb:1103), the commit 5dc9d1a55e95 ("wifi:
> >>>> ath11k: add support for QCA2066") reads TCSR_SOC_HW_SUB_VER to enumerate all
> >>>> QCA2066 cards, it lacks of flexibility, as the list will become longer and
> >>>> longer. But it's the only choice for QCA2066, as it's customized for X86
> >>>> platform which without DT files.
> >>>
> >>> I guess, this is closer to Kalle's expectations: being able to detect
> >>> the hardware instead of adding DT properties.
> >>>
> >>>> So for MSM those have DT file platforms, like SA8775P-RIDE/QCS8300-RIDE both
> >>>> attached to QCA6698AQ, we can specify the correct firmware to
> >>>> 'ath11k/WCN6855/hw2.1/qca6698aq', so it's not per-board firmware, it depends
> >>>> on the type of the products(x86 windows, IoT products or AUTO).
> >>>
> >>> No-no-no and no. The firmware used must not be specific to the product
> >>> type.  This is what everybody here is trying to avoid. Please try
> >>> following the QCA2066 approach instead. And note that it could use new
> >>> TLD as it perfectly shows itself as a different hardware kind.
> >>
> >> Actually, TCSR_SOC_HW_SUB_VER is not SOC register, it's a TLMM hw
> >> revision register in BAR0 space, it's hard to maintain the list.
> >
> > How is it so?
>
> I think QCA2066 approach is just a workaround. Different batches of chip
> manufacture has different value in TCSR_SOC_HW_SUB_VER.

Ok. So, subvendor / subdevice?

>
> >
> > And if it is hard, can we please get to the _normal_ way how vendors
> > handle PCI hardware differences: the subvendor and subdevice? This is
> > a usual way to describe that the PCIe device is the same, but the
> > analog / tuner / RF / etc parts are different.
>
>
> >
> >> We're going to have another problem to enable NFA765 m.2 card for IoT
> >> platforms, which has different feature sets with X86 platform, so also
> >> new firmware should be used. In this case, QCA2066 approach not works.
> >> Seems DT approach is only choice.
> >>
> >> Could you advice ?
> >
> > Hmm, The first question is _why_ does it have different feature sets?
> > What exactly is different?
>
> Yeah, for IoT device will support SAP/TWT/UL-OFDMA/BSS color and etc new
> features, and the existing x86 firmware mainly for STA mode.
>
> What if the user plugs a normal (laptop)
> > M.2 card into their IoT device?
>
> If there is no DT file to specify the firmware, IoT device will load the
> default firmware, it will affect SAP and WiFi-6 advanced features.

Can we get all those nice features into x86 world instead?

>
>
> >
> >>>
> >>>> 0000:01:00.0 Network controller [0280]: Qualcomm QCNFA765 Wireless Network
> >>>> Adapter [17cb:1103] (rev 01)
> >>>>       Subsystem: Qualcomm QCNFA765 Wireless Network Adapter [17cb:0108]
> >>>>       Device tree node: /sys/firmware/devicetree/base/pci@1c00000/pcie@0/wifi@0
> >>>>
> >>>>
> >>>>>
> >>>>> Could you possibly clarify, how this situation is handled in Windows
> >>>>> world?
> >>>>
> >>>> X86 platforms use standard m.2 PCIe card, and it will only use the default
> >>>> main firmware files, as they without DT files.
> >>>
> >>> So QCA6698AQ cannot appear on an M.2 PCIe card?
> >>
> >> No, but no m.2 PCIe card so far. It depends on power sequencing module
> >> to do power up.
> >
> > You are describing software (power sequencing module), while I was
> > talking about the hardware. Nothing prevents OEM from adding fixed
> > regulators to drive necessary voltages from the PCIe slot.
> >
>


-- 
With best wishes
Dmitry

