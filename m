Return-Path: <linux-wireless+bounces-14522-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2DB9AFFEC
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 12:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21FDCB21A92
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 10:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298CE18D655;
	Fri, 25 Oct 2024 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jaV8aXqg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51671D5ABF
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729851649; cv=none; b=Eb4g/QdYgZALTYd7TyzDX5Tpc2SWTFKy0CVZy920VxA1IuE4M/Meo90MzuHczQFULsnGMKkfd+EAxyJCUns4SFI1znEXCn8EEAO/XGXmaLZr85yDVLB/og4ZM+HuuWkTPrqaJuYpqXgOwjQpwX/AHb88C9c39yJbKdVzSmuli8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729851649; c=relaxed/simple;
	bh=1iLlAKGudjFkUN/QcEd0Uk7MU9ti5Wpd4+h+AMVeics=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcBVtHIIRov72d4RuPWXd1AjuXCa6I/sTiiaLOL4it8lKQN/YQ47bdkIy5ANkhT2fasoL7iiDa0LeVzbxBcFR1RNCw/G3HBC9UOsyUnjPyWHQlwALYolIcBLoaHI0L+tKWXORz2csJcQJHHqKQzYey/umTbi5JGUpYzySCva10s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jaV8aXqg; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e35bf59cf6so29673887b3.0
        for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 03:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729851646; x=1730456446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UZGOCvYm3rNUGn+PGYfltlg4oLnrSe3DwF5M9CLcXjE=;
        b=jaV8aXqg/VWJYTPqUgRDCTd7bO9OC8eyHa8PUrgpnAzEE5BPYJmLNqJ+rwc1+60w7D
         gYzfywaksyJlc1EU/hlESVXdAXkBpQ6rSeAq/CVJhrwPzhk8DUWVlKg1pOJVPvyBl9zr
         RmtCYKrWn2QwdO9t/htwShurBYUeK8islTUDuIW7BXLWpS/tLeeVxjZPBLjsU8oRQJD6
         aWSgCkpnXI2mX3ckiqqF2xxg7mp/fa45M7WAZYygwabd0Wl3A1kWQOIBWB4ynqHth9js
         7Orwk4+ZdY+XJWcHRXYYravLoVNKHebe7R9mK/4/Pc7vDd2S6Esy9pMszKx+5K3osCBD
         39rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729851646; x=1730456446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZGOCvYm3rNUGn+PGYfltlg4oLnrSe3DwF5M9CLcXjE=;
        b=pN/6c3NsG6GjUisX69GvD0gOGjALj5f/YhNc97ckGsuEByFsI9FG8/0+GXp9h86PCX
         vTZpG/AEnnorWq+V32FgXFKRqmFG7VGWWZ+0fh5zohk29OSZpQMgGJ1mr1W8sB5AXntM
         3MZulXSt3EKcW3DB5QkwP4W5DPHlLdgsr9dugtaIoZ0aoH97yahwEvAHSF520UnLYQ6l
         rwiBmUCv5fkCXycbI7sTSvOLTifCoUhhTA+BOa+7UdNUuL8cLK1qX9I0SkMtx9PHlntf
         cuebk9jJfNPoPxSoGZX+ehOAsHaSHaI64VYR6/gW+7XhSsWy3gY3kzpx4Dzp67EQpou6
         aVuA==
X-Forwarded-Encrypted: i=1; AJvYcCXGE/L7VnJIhBkC61UySOktRa/l5gKRLbB3TpQ2/K51OSSOnbGB27QWXNDr1/v/uOdAkyvBzolRYc0PXwXkqA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu6c4wCh4bFxn9Nso/J1rtdf+1ssu/qjZOFYo7yGkeBg5FiA4M
	+tcWtmuo/g4gNB5qZQVLqkDOuMSNf0arWH0P3tqAcVCD/CFQOtgrxJPXYgnlzc066XsZwfo8427
	mBMCm7c7jANmf2YmpKE6e8uHgKSLfi0rxJetuQQ==
X-Google-Smtp-Source: AGHT+IEK+IFBHUuYbFtTsmlZx0OQVp0kbPTqAa5jGXbCwa8RgIenukeKGRyvXq5xKgheZN8Zq0OHePmdyhBBXaHPjpY=
X-Received: by 2002:a05:690c:3584:b0:6e3:7625:15f7 with SMTP id
 00721157ae682-6e84de8edfamr42407037b3.10.1729851645875; Fri, 25 Oct 2024
 03:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024002514.92290-1-quic_miaoqing@quicinc.com>
 <20241024002514.92290-3-quic_miaoqing@quicinc.com> <pdjhyrjoreiykv2tquvufjw3rkti5sxrjvpmkjhvkfasq7zbo4@xxntxdmhhyg5>
 <bc3c06eb-1cb2-4cbb-aaad-95c09223f0cc@quicinc.com> <ig3m3sgmnkgfmwrlglundhqif6rygzl7uh7rzoemrz3yxgvfpc@35a323mw2wbt>
 <46de0bfe-ebdd-4b37-a957-3c64e30a1376@quicinc.com>
In-Reply-To: <46de0bfe-ebdd-4b37-a957-3c64e30a1376@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 25 Oct 2024 13:20:35 +0300
Message-ID: <CAA8EJpr4zgV4Sa4sPdCToQWs+CFJu6Xz6CPcPyHDhDczmuzj=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] wifi: ath11k: support board-specific firmware overrides
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: kvalo@kernel.org, quic_jjohnson@quicinc.com, ath11k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Oct 2024 at 10:23, Miaoqing Pan <quic_miaoqing@quicinc.com> wrote:
>
>
>
> On 10/25/2024 2:01 PM, Dmitry Baryshkov wrote:
> > On Fri, Oct 25, 2024 at 10:56:02AM +0800, Miaoqing Pan wrote:
> >>
> >>
> >> On 10/25/2024 3:39 AM, Dmitry Baryshkov wrote:
> >>> On Thu, Oct 24, 2024 at 08:25:14AM +0800, Miaoqing Pan wrote:
> >>>> QCA6698AQ IP core is the same as WCN6855 hw2.1, but it has different RF,
> >>>> IPA, thermal, RAM size and etc, so new firmware files used. This change
> >>>> allows board DT files to override the subdir of the firmware directory
> >>>> used to lookup the amss.bin and m3.bin.
> >>>
> >>> I have slight concerns regarding the _board_ DT files overriding the
> >>> subdir. This opens a can of worms, allowing per-board firmware sets,
> >>> which (as far as I understand) is far from being what driver maintainers
> >>> would like to see. This was required for ath10k-snoc devices, since
> >>> firmware for those platforms is signed by the vendor keys and it is
> >>> limited to a particular SoC or SoC family. For ath11k-pci there is no
> >>> such limitation.
> >>>
> >>> Would it be possible to use PCI subvendor / subdev to identify affected
> >>> cards? PCI Revision? Any other way to identify the device?  Please
> >>> provide lspci -nnvv for the affected device kind. Is there a way to
> >>> identify the RF part somehow?
> >>
> >> It's rather difficult, for WCN685x, there are multiple evolved subseries for
> >> customized products. e.g.
> >>
> >> QCA6698AQ/hw2.1
> >> QCA2066/hw2.1
> >> WCN6855/hw2.0/hw2.1
> >> WCN6856/hw2.1
> >>
> >> They have the same PCIe ID (17cb:1103), the commit 5dc9d1a55e95 ("wifi:
> >> ath11k: add support for QCA2066") reads TCSR_SOC_HW_SUB_VER to enumerate all
> >> QCA2066 cards, it lacks of flexibility, as the list will become longer and
> >> longer. But it's the only choice for QCA2066, as it's customized for X86
> >> platform which without DT files.
> >
> > I guess, this is closer to Kalle's expectations: being able to detect
> > the hardware instead of adding DT properties.
> >
> >> So for MSM those have DT file platforms, like SA8775P-RIDE/QCS8300-RIDE both
> >> attached to QCA6698AQ, we can specify the correct firmware to
> >> 'ath11k/WCN6855/hw2.1/qca6698aq', so it's not per-board firmware, it depends
> >> on the type of the products(x86 windows, IoT products or AUTO).
> >
> > No-no-no and no. The firmware used must not be specific to the product
> > type.  This is what everybody here is trying to avoid. Please try
> > following the QCA2066 approach instead. And note that it could use new
> > TLD as it perfectly shows itself as a different hardware kind.
>
> Actually, TCSR_SOC_HW_SUB_VER is not SOC register, it's a TLMM hw
> revision register in BAR0 space, it's hard to maintain the list.

How is it so?

And if it is hard, can we please get to the _normal_ way how vendors
handle PCI hardware differences: the subvendor and subdevice? This is
a usual way to describe that the PCIe device is the same, but the
analog / tuner / RF / etc parts are different.

> We're going to have another problem to enable NFA765 m.2 card for IoT
> platforms, which has different feature sets with X86 platform, so also
> new firmware should be used. In this case, QCA2066 approach not works.
> Seems DT approach is only choice.
>
> Could you advice ?

Hmm, The first question is _why_ does it have different feature sets?
What exactly is different? What if the user plugs a normal (laptop)
M.2 card into their IoT device?

> >
> >> 0000:01:00.0 Network controller [0280]: Qualcomm QCNFA765 Wireless Network
> >> Adapter [17cb:1103] (rev 01)
> >>      Subsystem: Qualcomm QCNFA765 Wireless Network Adapter [17cb:0108]
> >>      Device tree node: /sys/firmware/devicetree/base/pci@1c00000/pcie@0/wifi@0
> >>
> >>
> >>>
> >>> Could you possibly clarify, how this situation is handled in Windows
> >>> world?
> >>
> >> X86 platforms use standard m.2 PCIe card, and it will only use the default
> >> main firmware files, as they without DT files.
> >
> > So QCA6698AQ cannot appear on an M.2 PCIe card?
>
> No, but no m.2 PCIe card so far. It depends on power sequencing module
> to do power up.

You are describing software (power sequencing module), while I was
talking about the hardware. Nothing prevents OEM from adding fixed
regulators to drive necessary voltages from the PCIe slot.

-- 
With best wishes
Dmitry

