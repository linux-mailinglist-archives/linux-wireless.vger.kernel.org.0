Return-Path: <linux-wireless+bounces-1878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1B582CDC1
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 17:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95039283CB8
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 16:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624944414;
	Sat, 13 Jan 2024 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPwbqGV6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459BD4400
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jan 2024 16:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3732DC433F1;
	Sat, 13 Jan 2024 16:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705163232;
	bh=qblQW5XDnpppWfw0b6l4LJ9y0tIhQAkzMvTMSnJOacM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=MPwbqGV6U2r4+cE1UN3X6KvVosRLizhDTMwqmhs0HpW9xmS5c4PRYQ4+Rji7x9LoW
	 7JrqSZu8sC1QSK9emeQgXVECeJTUoiuO2XSJ0dwb/J8ubuX9OnBfKE0vKCmvUvL/vF
	 yHrsYQ3X85oYMq3RCNOjeixfHveb8CRB0IDr39FI28Wyh80QSva0NFw/VVikH0m2X8
	 f1wfS6toPnzG8NQ6rBt77D/nx0elx1qOoCz+j+UCcpvM/dX1hkIl3zJtDpZcHXM+Kr
	 tbs2lSzoX1noqUZf9Kj9ehnjYidVsG+HHsuAnOYSLKdPPGYCbWYdX0PxJadIuCrqtD
	 6dozNdMyG23/g==
From: Kalle Valo <kvalo@kernel.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, Fernando Piacente
 <nandopiacente@gmail.com>, Paolo Perego <pperego@suse.de>, Sreekanth
 <chvsreekanth@gmail.com>, Eric Curtin <ecurtin@redhat.com>
Subject: Re: [PATCH] wifi: orphan brcm80211 broadcom drivers
References: <20231220095750.307829-1-arend.vanspriel@broadcom.com>
	<87h6kcq1yn.fsf@kernel.org>
	<ec670eed-cd63-470c-b37b-76925a1ec6d5@broadcom.com>
Date: Sat, 13 Jan 2024 18:27:09 +0200
In-Reply-To: <ec670eed-cd63-470c-b37b-76925a1ec6d5@broadcom.com> (Arend van
	Spriel's message of "Sat, 23 Dec 2023 21:20:21 +0100")
Message-ID: <87r0il8ahu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

(sorry for the really late reply, I was on a long vacation)

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> On 12/20/2023 5:21 PM, Kalle Valo wrote:
>
>> I am so sad about this but I fully understand your decision. You have
>> the best knowledge of Broadcom devices and you were involved with
>> brcm80211 from the beginning. I can guess how difficult lately it has
>> been for you to find time for upstream work but even still you
>> replied to my mails and tried to support the community the best you
>> can, which I appreciated so much. Everyone else in the corporate
>> world usually just ignore, you did not do that.
>
> Hi Kalle,
>
> Maybe I should reconsider, because it feels a bit like high school and
> the bullies won. I agreed that I can not meet expectations and the
> main aspect being testing patch series on fair amount of devices.

Yes, please reconsider! I didn't apply your patch because I was hoping I
could still convince you to continue maintaining it :)

I fully understand the challenges of maintaining a huge driver like
brcm80211: no proper documentation available, several companies
involved, a plethora of firmware branches which might work a bit
different and so many hardware variants.

> Do you think we can address that with some help? For instance by
> reaching out to several people in the community that use brcmfmac and
> ask them if they are willing to regularly test on wireless-testing. My
> experience with community members is not so great as they tend to
> loose interest and move on, but it may be worth a try. Let me know
> what you think.

I definitely think that getting a small community around brcm80211 would
be beneficial. For example, a good start would be to create a dedicated
list for brcm80211 where people can discuss about anything from testing
to developing patches and all between. lists.infradead.org is one good
place and there's also lists.linux.dev.

Let me know if there's anything I can help with. I have also CCed people
who expressed interest in helping brcm80211 development before the
holidays.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

