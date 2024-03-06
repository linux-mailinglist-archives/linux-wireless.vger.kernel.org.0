Return-Path: <linux-wireless+bounces-4428-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF8E873575
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 12:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00AB91C22F1B
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 11:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF6C60B88;
	Wed,  6 Mar 2024 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMmObzNl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3A3605B4;
	Wed,  6 Mar 2024 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709723724; cv=none; b=hCtQ6QBl1FdgmYxD+XC/iE0smx1264tkWH/6WIRT8XSqixW5T2mZZm2jU6L8yQJrTRlHJ+Qs8Mv2kCa7mmZRIUWDUXYkQhFu9IHq5CRe+IWABKA6qhw0+rdaEGXK+C58rolARWsvaO9B+KVF/BiJdxDxqktEhzAsoPTwiqRU9UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709723724; c=relaxed/simple;
	bh=YC1JZzUSGm90LAa8typocXvGi3dcuKhnwtfIEXMfegA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=d/wZwqSry1aorr4MqKBU/boJ6BtOrGaowugjDpXeUNSLtNi744pjDv59RloXJkGrG+HKD9+Je/Xp3URdaiNCzIp2wwMSV9DhotxHKjT6S1QAdrthOJX56tY+KGoQQKwbfDnYoBvHwhv4h2/R/iIOZfHAX2ZnH2OMdSMoR2yKYIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMmObzNl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C5FC433C7;
	Wed,  6 Mar 2024 11:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709723724;
	bh=YC1JZzUSGm90LAa8typocXvGi3dcuKhnwtfIEXMfegA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=vMmObzNlM9Tbn7pDK2KR94nuzJA+dkX/WTBV9JAHY7Zq6pgtm9EWAr8uauJqUg2Fw
	 PQ2GNr12JQkL2VIlIu1gaL6rQsr1KJkhS/0Wau+AeicDKCWf8B4cpfRHDWaYzRdz9/
	 jQWAkUJO+clPilmjGVk/JO8AKzdjmdVS1tQJb1DrLIyfr9VJgamMaI9kGkb/BcQWUC
	 DNeXHgiEEikyZZBU1BOPHyjpN5gVdP2eeLh97OQyDR+CC/G3gJVqFIxNWjPgGpEEGq
	 c8yYEAOZCz1kNUNwB7pD3+QUES9AnH4qu1uUyQoMAW7hhBHBkirC6CRXsFDinpVcKG
	 S/KcJa5KFduBg==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Rob Herring
 <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Bjorn Andersson <andersson@kernel.org>,  Konrad Dybcio
 <konrad.dybcio@linaro.org>,  ath10k@lists.infradead.org,
  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-arm-msm@vger.kernel.org,  Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RFC v2 0/4] wifi: ath10k: support board-specific
 firmware overrides
References: <20240306-wcn3990-firmware-path-v2-0-f89e98e71a57@linaro.org>
	<87plw7hgt4.fsf@kernel.org>
	<CAA8EJpr6fRfY5pNz6cXVTaNashqffy5_qLv9c35nkgjaDuSgyQ@mail.gmail.com>
Date: Wed, 06 Mar 2024 13:15:18 +0200
In-Reply-To: <CAA8EJpr6fRfY5pNz6cXVTaNashqffy5_qLv9c35nkgjaDuSgyQ@mail.gmail.com>
	(Dmitry Baryshkov's message of "Wed, 6 Mar 2024 11:23:21 +0200")
Message-ID: <87cys7hard.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:

> On Wed, 6 Mar 2024 at 11:04, Kalle Valo <kvalo@kernel.org> wrote:
>
>>
>> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
>>
>> > On WCN3990 platforms actual firmware, wlanmdsp.mbn, is sideloaded to the
>> > modem DSP via the TQFTPserv. These MBN files are signed by the device
>> > vendor, can only be used with the particular SoC or device.
>> >
>> > Unfortunately different firmware versions come with different features.
>> > For example firmware for SDM845 doesn't use single-chan-info-per-channel
>> > feature, while firmware for QRB2210 / QRB4210 requires that feature.
>> >
>> > Allow board DT files to override the subdir of the fw dir used to lookup
>> > the firmware-N.bin file decribing corresponding WiFi firmware.
>> > For example, adding firmware-name = "qrb4210" property will make the
>> > driver look for the firmware-N.bin first in ath10k/WCN3990/hw1.0/qrb4210
>> > directory and then fallback to the default ath10k/WCN3990/hw1.0 dir.
>> >
>> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> > ---
>> > Changes in v2:
>> > - Fixed the comment about the default board name being NULL (Kalle)
>> > - Expanded commit message to provide examples for firmware paths (Kalle)
>> > - Added a note regarding board-2.bin to the commit message (Kalle)
>> > - Link to v1:
>> > https://lore.kernel.org/r/20240130-wcn3990-firmware-path-v1-0-826b93202964@linaro.org
>>
>> From my point of view this looks good now but let's see what others say.
>> Is there a specific reason why you marked this as RFC still?
>
> No, I just forgot to remove it from the series settings, so you can
> consider it as final.

Good, so let's ignore the RFC label for this v2.

> I had one minor question in my head (but that's mostly for patches 3
> and 4): in linux-firmware we will have ath10k/WCN3990/hw1.0/qcm2290
> and make qrb4210 as a symlink to it. Is that fine from your POV? 

Yes, I think using a symlink is a good idea.

> Or should we use sensible device names (e.g. qcom-rb1)?

I guess 'qcom-rb1' refers to 'Qualcomm Robotics RB1' board? In other
words, the question is that should we use chipset specific names like
'qcm2290' or product based names like 'qcom-rb1'?

That's a good question for which I don't have a good answer :) I'm not
very familiar with WCN3990 hardware and SoCs to have a full picture of
all this, especially how the firmware images are signed or what
different firmware branches there are etc.

To be on the safe side using 'qcom-rb1' makes sense but on the other
hand that means we need to update linux-firmware (basically add a new
symlink) everytime a new product is added. But are there going to be
that many new ath10k based products?

Using 'qcm2290' is easier because for a new product then there only
needs to be a change in DTS and no need to change anything
linux-firmware. But here the risk is that if there's actually two
different ath10k firmware branches for 'qcm2290'. If that ever happens
(I hope not) I guess we could solve that by adding new 'qcm2290-foo'
directory?

But I don't really know, thoughts?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

