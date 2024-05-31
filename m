Return-Path: <linux-wireless+bounces-8361-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D88B8D6930
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 20:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5021C21745
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 18:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813F37E774;
	Fri, 31 May 2024 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRXOkkXF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA031CA89;
	Fri, 31 May 2024 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717181333; cv=none; b=iu4ymB+wQK/o/T6h7h/MGZtIVRR077LE/3CO9m5Dmgpp9317ECERr+JDoiZkSj/WkBATebWliw6D+ozHLVyHxVF83Mn0fFMyNEDX0LJIsqWqD2V4L16hLABkQ9JyeDXB9bspcDHU4xO22IKPdd/1BOwmIh/5Gm3qLmIu/axxHWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717181333; c=relaxed/simple;
	bh=InHs5IlHaGH8QXWp5MZ3tO39zwGHEU52P7U+Epwe+Nk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=mmk2ShhVbQH/ac34lOusYuHhlyqDXwSyT7mjERcAdWLgu5bBqA5l55xg+fkRAicdfED/V9GzHFsUizmNYrCymt3PwSh34dvNDShLiWrGHY3RcYQP017IXD75Q/BNfUpso6G3W0vh7L00lFv9Lz+PZNTcOHPfG4DhUnrGbYqsR6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRXOkkXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC4BC116B1;
	Fri, 31 May 2024 18:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717181333;
	bh=InHs5IlHaGH8QXWp5MZ3tO39zwGHEU52P7U+Epwe+Nk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=iRXOkkXFwmarXd5Mto/pTf8VHhCebO7MFmwDWoSvgRRF76ubvDqW0E3zq+C/4LiYZ
	 vGY2BuaKzVXJ2nl2lBT0TWYH+ettez0yzrIn3wqQQ7gD04LwAPmj5PXrtxsGMhfRnD
	 BNNaaLSwMqm2+xKVL1S4wm82k3298hgqDehtn7G90wiv+AZhuUeORVeI9g7jnkowSQ
	 MJfP5pQH8VRafBAbO5mLD6gAAo5m+oOq31uTDhNltDxxfEdpOCiGlqy9oG8esdYYRq
	 ikq15qgeLJRKQMXVgFU4NFY492ixFMuan1bl6jsxGR3/Cwtmn6Pf+SxNumdyTybWep
	 pLZ4+oZNXRxlw==
From: Kalle Valo <kvalo@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,  Bjorn Andersson
 <quic_bjorande@quicinc.com>,  neil.armstrong@linaro.org,  Konrad Dybcio
 <konrad.dybcio@linaro.org>,  Loic Poulain <loic.poulain@linaro.org>,
  Mathieu Poirier <mathieu.poirier@linaro.org>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  linux-kernel@vger.kernel.org,
  linux-arm-msm@vger.kernel.org,  wcn36xx@lists.infradead.org,
  linux-wireless@vger.kernel.org,  linux-remoteproc@vger.kernel.org,
  devicetree@vger.kernel.org,  Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/12] soc: qcom: add firmware name helper
References: <20240521-qcom-firmware-name-v1-0-99a6d32b1e5e@linaro.org>
	<20240521-qcom-firmware-name-v1-1-99a6d32b1e5e@linaro.org>
	<a45b53f3-b2a5-4094-af5a-1281e0f94d2f@linaro.org>
	<CAA8EJprxYsoug0ipRHTmX45vaFLzJCUF0dQWOc=QLs4y6uZ1rA@mail.gmail.com>
	<878r03csxn.fsf@kernel.org>
	<CAA8EJpqkgpCb57DGka0ckbPz=2YiaHzxmiNzG39ad5y6smgO5A@mail.gmail.com>
	<Zk52IHqAfOnVDm50@hu-bjorande-lv.qualcomm.com>
	<CAA8EJpogG5wW2mUUkYFtnnZLMVuneU4Wie6GBfYytSYe0zQ77Q@mail.gmail.com>
	<pd3jgsd2ps73qd2h4rdxavd4zmyeqrqmslkbuwtgwlotm4tzgb@bb5japc6opcq>
Date: Fri, 31 May 2024 21:48:47 +0300
In-Reply-To: <pd3jgsd2ps73qd2h4rdxavd4zmyeqrqmslkbuwtgwlotm4tzgb@bb5japc6opcq>
	(Bjorn Andersson's message of "Tue, 28 May 2024 21:28:54 -0500")
Message-ID: <87ikytvmuo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bjorn Andersson <andersson@kernel.org> writes:

> On Mon, May 27, 2024 at 02:42:44PM GMT, Dmitry Baryshkov wrote:
>
>> On Thu, 23 May 2024 at 01:48, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>> >
>> > On Tue, May 21, 2024 at 03:08:31PM +0200, Dmitry Baryshkov wrote:
>> > > On Tue, 21 May 2024 at 13:20, Kalle Valo <kvalo@kernel.org> wrote:
>> > > >
>> > > > Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
>> > > >
>> > > > > On Tue, 21 May 2024 at 12:52, <neil.armstrong@linaro.org> wrote:
>> > > > >>
>> > > > >> On 21/05/2024 11:45, Dmitry Baryshkov wrote:
>> > > > >> > Qualcomm platforms have different sets of the firmware files, which
>> > > > >> > differ from platform to platform (and from board to board, due to the
>> > > > >> > embedded signatures). Rather than listing all the firmware files,
>> > > > >> > including full paths, in the DT, provide a way to determine firmware
>> > > > >> > path based on the root DT node compatible.
>> > > > >>
>> > > > >> Ok this looks quite over-engineered but necessary to handle the legacy,
>> > > > >> but I really think we should add a way to look for a board-specific path
>> > > > >> first and fallback to those SoC specific paths.
>> > > > >
>> > > > > Again, CONFIG_FW_LOADER_USER_HELPER => delays.
>> > > >
>> > > > To me this also looks like very over-engineered, can you elaborate more
>> > > > why this is needed? Concrete examples would help to understand better.
>> > >
>> > > Sure. During the meeting last week Arnd suggested evaluating if we can
>> > > drop firmware-name from the board DT files. Several reasons for that:
>> > > - DT should describe the hardware, not the Linux-firmware locations
>> > > - having firmware name in DT complicates updating the tree to use
>> > > different firmware API (think of mbn vs mdt vs any other format)
>> > > - If the DT gets supplied by the vendor (e.g. for
>> > > SystemReady-certified devices), there should be a sync between the
>> > > vendor's DT, linux kernel and the rootfs. Dropping firmware names from
>> > > DT solves that by removing one piece of the equation
>> > >
>> > > Now for the complexity of the solution. Each SoC family has their own
>> > > firmware set. This includes firmware for the DSPs, for modem, WiFi
>> > > bits, GPU shader, etc.
>> > > For the development boards these devices are signed by the testing key
>> > > and the actual signature is not validated against the root of trust
>> > > certificate.
>> > > For the end-user devices the signature is actually validated against
>> > > the bits fused to the SoC during manufacturing process. CA certificate
>> > > (and thus the fuses) differ from vendor to vendor (and from the device
>> > > to device)
>> > >
>> > > Not all of the firmware files are a part of the public linux-firmware
>> > > tree. However we need to support the rootfs bundled with the firmware
>> > > for different platforms (both public and vendor). The non-signed files
>> > > come from the Adreno GPU and can be shared between platforms. All
>> > > other files are SoC-specific and in some cases device-specific.
>> > >
>> > > So for example the SDM845 db845c (open device) loads following firmware files:
>> > > Not signed:
>> > > - qcom/a630_sqe.fw
>> > > - qcom/a630_gmu.bin
>> > >
>> > > Signed, will work for any non-secured sdm845 device:
>> > > - qcom/sdm845/a630_zap.mbn
>> > > - qcom/sdm845/adsp.mbn
>> > > - qcom/sdm845/cdsp.mbn
>> > > - qcom/sdm485/mba.mbn
>> > > - qcom/sdm845/modem.mbn
>> > > - qcom/sdm845/wlanmdsp.mbn (loaded via TQFTP)
>> > > - qcom/venus-5.2/venus.mbn
>> > >
>> > > Signed, works only for DB845c.
>> > > - qcom/sdm845/Thundercomm/db845c/slpi.mbn
>> > >
>> > > In comparison, the SDM845 Pixel-3 phone (aka blueline) should load the
>> > > following firmware files:
>> > > - qcom/a630_sqe.fw (the same, non-signed file)
>> > > - qcom/a630_gmu.bin (the same, non-signed file)
>> > > - qcom/sdm845/Google/blueline/a630_zap.mbn
>> >
>> > How do you get from "a630_zap.mbn" to this? By extending the lookup
>> > table for every target, or what am I missing?
>> 
>> More or less so. Matching the root OF node gives us the firmware
>> location, then it gets prepended to all firmware targets. Not an ideal
>> solution, as there is no fallback support, but at least it gives us
>> some points to discuss (and to decide whether to move to some
>> particular direction or to abandon the idea completely, making Arnd
>> unhappy again).
>> 
>
> I understand the desire to not put linux-firmware-specific paths in the
> DeviceTree

Me too.

> but I think I'm less keen on having a big lookup table in the
> kernel...

Yeah, also for me this feels wrong. But on the other hand I don't have
anything better to suggest either...

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

