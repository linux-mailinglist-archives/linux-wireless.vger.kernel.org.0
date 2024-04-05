Return-Path: <linux-wireless+bounces-5903-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8224F899D3C
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 14:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227CC1F23599
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 12:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE7D16ABDE;
	Fri,  5 Apr 2024 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFHM2C2G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C270328DB;
	Fri,  5 Apr 2024 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320904; cv=none; b=HgsQ0EeA9g2rCOpJlnq6yM+NzOyBgjXmnMJPWHqPPwpUHkq/gbjmeUj/895SgKLvQzsTjNdG9qb0L1A/7eI3StwzpF5E3a/Cah3DlfnebSF7M5JhJUOPa2xAHRd1CPKBu4fJEI8yNFoRi0w1NJvh+hyMxUcfyyOyJlPmb6Jkc2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320904; c=relaxed/simple;
	bh=XstQV4I3hA64wkJdbVIzI8G3hTpnTOdEI888VqMr7I4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=RKmpB9TDOOPvnKRwSFD/b4n2ohnB+5AUgP64dtJ3e5/OCRQIw2fBukUOyNY661e1G+NHnFXjBOZ/kCU7A5q9kTierD8PYeTgKCecPIPhuVb2VHlLTcO4kP4Kwjl2gJc8i5hfg+gEsarvli2pKg+nCq9jhCirTvhI1WfkYEqpG+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFHM2C2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366B1C433F1;
	Fri,  5 Apr 2024 12:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712320903;
	bh=XstQV4I3hA64wkJdbVIzI8G3hTpnTOdEI888VqMr7I4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=pFHM2C2GbsBvF2xfSpXbDbaeeEthKyyQgnk3Sh1pD+g7kaPMyMOdDsUUKD8nhM5ei
	 b2Wrjp9NU01rX5iBliGumbHoX/2Uas8in0Of+sBK9wmOIK9ItUsc+0xeoYjiAFLC+M
	 3RTH2EaieomEgwH69yqkFwNxh3zfPfohpjhKZbSQMLF6eseattZCeR8jxqDjXwmJk0
	 DjsaoTkLKvG6tEvkbIOhvjBZzMqATIKYE0HqU1SIThb3v8zBpyiox4mz8CQ4rsGvnQ
	 34zZP9u3HcKyKiw6J3e3nHKstbXuWjqfbR/b5w4viCAk65sw5lYGu+5wfYmy9We2Fu
	 /hFNursI5SIog==
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
	<87cys7hard.fsf@kernel.org>
	<CAA8EJpowyEEbXQ4YK-GQ63wZSkJDy04qJsC2uuYCXt+aJ1HSOQ@mail.gmail.com>
	<87v85wg39y.fsf@kernel.org>
	<CAA8EJpq_XLUEMC67ck2tZRjqS0PazCkQWWMGmwydeWxTETHwcg@mail.gmail.com>
	<871q7k3tnq.fsf@kernel.org>
	<CAA8EJppASEmj6-Jt7OCABAeqr8umSgXaDDha9nn2nRafuZ-Gvw@mail.gmail.com>
Date: Fri, 05 Apr 2024 15:41:38 +0300
In-Reply-To: <CAA8EJppASEmj6-Jt7OCABAeqr8umSgXaDDha9nn2nRafuZ-Gvw@mail.gmail.com>
	(Dmitry Baryshkov's message of "Fri, 5 Apr 2024 15:34:29 +0300")
Message-ID: <87sf002d8d.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:

> On Fri, 5 Apr 2024 at 15:01, Kalle Valo <kvalo@kernel.org> wrote:
>
>>
>> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
>>
>> > On Fri, 8 Mar 2024 at 17:19, Kalle Valo <kvalo@kernel.org> wrote:
>> >>
>> >> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
>> >>
>> >> >> To be on the safe side using 'qcom-rb1' makes sense but on the other
>> >> >> hand that means we need to update linux-firmware (basically add a new
>> >> >> symlink) everytime a new product is added. But are there going to be
>> >> >> that many new ath10k based products?
>> >> >>
>> >> >> Using 'qcm2290' is easier because for a new product then there only
>> >> >> needs to be a change in DTS and no need to change anything
>> >> >> linux-firmware. But here the risk is that if there's actually two
>> >> >> different ath10k firmware branches for 'qcm2290'. If that ever happens
>> >> >> (I hope not) I guess we could solve that by adding new 'qcm2290-foo'
>> >> >> directory?
>> >> >>
>> >> >> But I don't really know, thoughts?
>> >> >
>> >> > After some thought, I'd suggest to follow approach taken by the rest
>> >> > of qcom firmware:
>> >>
>> >> Can you provide pointers to those cases?
>> >
>> > https://gitlab.com/kernel-firmware/linux-firmware/-/tree/main/qcom/sc8280xp/LENOVO/21BX
>> >
>> >>
>> >> > put a default (accepted by non-secured hardware) firmware to SoC dir
>> >> > and then put a vendor-specific firmware into subdir. If any of such
>> >> > vendors appear, we might even implement structural fallback: first
>> >> > look into sdm845/Google/blueline, then in sdm845/Google, sdm845/ and
>> >> > finally just under hw1.0.
>> >>
>> >> Honestly that looks quite compilicated compared to having just one
>> >> sub-directory. How will ath10k find the directory names (or I vendor and
>> >> model names) like 'Google' or 'blueline' in this example?
>> >
>> > I was thinking about the firmware-name = "sdm845/Google/blueline". But
>> > this can be really simpler, firmware-name = "blueline" or
>> > "sdm845/blueline" with no need for fallbacks.
>>
>> I have been also thinking about this and I would prefer not to have the
>> fallbacks. But good if you agree with that.
>>
>> IMHO just "sdm845-blueline" would be the most simple. I don't see the
>> point of having a directory structure when there are not that many
>> directories really. But this is just cosmetics.
>
> It is "not many directories" if we are thinking about the
> linux-firmware or open devices. But once embedded distros start
> picking this up for the supported devices, this can quickly become a
> nuisance.

Ok. Just out of curiosity, any ideas how many devices/products are there
with wcn3990 who want to use ath10k?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

