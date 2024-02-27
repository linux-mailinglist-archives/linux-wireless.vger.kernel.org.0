Return-Path: <linux-wireless+bounces-4092-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5495A869544
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 15:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8193F1C23C84
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 14:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F63F1419B1;
	Tue, 27 Feb 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVFIFE0S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EBB1419AA
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042428; cv=none; b=JFQH1kfObKjZrNqghUlwwZ1bDe39T3wL97Pu8joW39FZrrQcDV2vjMr8SIKzUutv0WAFYXa2FDMoRNfQWFPiPtDfISgMhjZUZrvyW3Uqln9CY3QrCehzLlAHSU+CwJHZIRUoGkwnhPnwpeqPzv6KUs9124gpDUSo0taI7UVcrM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042428; c=relaxed/simple;
	bh=+5MU/b/gTCliFYUQtA2HPbPTDVc69mNUa8fXu3HaBBU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=W5pCWZ3xfDjxYXBFjVxYiQVoR8V5V09jBq5m28mwdI2OcQXFMkIEMrunvuweK+SoFzdP1TAGq1GaN3mUBJcvmfEy+qQ4WzQOoXY8R5wSgTvcZ6JeQFMquel4nODo8t+1HUjPn6Wu5DQf3exM3wV+q6zUDqlJNKqmUaIYFEs8qgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVFIFE0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C68C433C7;
	Tue, 27 Feb 2024 14:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709042427;
	bh=+5MU/b/gTCliFYUQtA2HPbPTDVc69mNUa8fXu3HaBBU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=KVFIFE0SuTQX0LoKm4R30acFryhXI8q/JLifRho1C0eeDwVnqqPHyIiQ/GwI612AB
	 7f2MQNreJPBfVxi7vvvV8q/Zri7bJyWN2gAFpn0tsLGDUANXVTqYIb9OpyF0GUP/pA
	 /cAwYDJkuXrsoFn5JsXcaoTxwE/2AKAHxYOYyNnJWafctzPd3p5tekLmyYW32oO39l
	 hoguw/z3+ktNoF4L9EU+3xoPKGBWmuwMGcbGs06IDtwiix8eY29o//xOhprB9Ab7yg
	 UJgf7FtryfusmdmHT1pZMJpxxWNvK0p1Y2t8UKrNF/yyuoaINC42h2oxtUafJRViON
	 +2F2pJkqH5y5g==
From: Kalle Valo <kvalo@kernel.org>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  Alexis =?utf-8?Q?Lothor?=
 =?utf-8?Q?=C3=A9?=
 <alexis.lothore@bootlin.com>,  Johannes Berg <johannes@sipsolutions.net>,
  Ajay Singh <ajay.kathat@microchip.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  linux-wireless@vger.kernel.org,  Sergey
 Matyukevich <geomatsi@gmail.com>,  kernel test robot <lkp@intel.com>,
  Claudiu Beznea <claudiu.beznea@tuxon.dev>,  srini.raju@purelifi.com,
  krystal.heaton@onsemi.com
Subject: Re: wireless: orphan qfnfmac and plfxlc drivers?
References: <20240215-nl80211_fix_akm_suites_endianness-v1-0-57e902632f9d@bootlin.com>
	<02c155ff-f880-4e88-b600-9d632019729f@bootlin.com>
	<875xypejwt.fsf_-_@kernel.org> <871q9dej8j.fsf@kernel.org>
	<89bc5ff1-b049-49d1-b15a-4e01a4659c74@quicinc.com>
	<87le7kda2a.fsf@kernel.org>
	<21846c39-b5c5-482c-97be-51e36e1ebf49@gmail.com>
Date: Tue, 27 Feb 2024 16:00:23 +0200
In-Reply-To: <21846c39-b5c5-482c-97be-51e36e1ebf49@gmail.com> (Igor
	Mitsyanko's message of "Sun, 25 Feb 2024 18:13:33 -0800")
Message-ID: <87msrmj9c8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Igor Mitsyanko <i.mitsyanko@gmail.com> writes:

> On 2/16/24 01:37, Kalle Valo wrote:
>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>>
>>> On 2/15/2024 9:21 AM, Kalle Valo wrote:
>>>> <imitsyanko@quantenna.com>: host mail.quantenna.com[50.87.249.29] said: 550 No
>>>>      Such User Here (in reply to RCPT TO command)
>>> Apparently Quantenna was acquired by ON Semi in 2019[1], and in 2022
>>> they closed it down[2]. Seems pretty abandoned to me.
>> Thanks Jeff. I do wonder is anyone even using qtnfmac and plfxlc? Maybe
>> we should just delete the drivers as nobody seems to care about them?
>>
> (replacing imitsyanko@quantenna.com with my personal email)
>
> Hi Kalle, Jeff,
>
> that's right, Quantenna division was shutdown by ON. To my knowledge
> no users of qtnfmac drivers are left after that. I would think
> removing driver altogether is the right approach. I'm not associated
> with ON anymore so it's just my personal opinion.
>
> CCing Krystal Heaton who I found on ON "contacts" web page (just in
> case someone from ON wants to comment if removing qtnfmac driver from
> Linux kernel is a concern).

Sad news but thanks for letting us know. So unless anyone else objects
the plan is to remove qtnfmac driver in the near future.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

