Return-Path: <linux-wireless+bounces-16100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D379E9D04
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 18:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0730E1881E6E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 17:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC4F14F9F8;
	Mon,  9 Dec 2024 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQdbv32M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE4D4409;
	Mon,  9 Dec 2024 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733765178; cv=none; b=W75JfrV1VI4TwZY6bosEiKrK8/Bz7NuCl7b+ujM9UVhc+/nAwkKrOjlm5rVYUmOjFHhPAuFRDfYL4gvXUmNX0zzK+RecmhJw3AUMk44v3b6tvxtc0fUrzfUjrW6UG0wb4JceTwY/rxqfjo26KZXNa0pjbfGt6Ik32R01QQR0xkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733765178; c=relaxed/simple;
	bh=DbEW8HiEN8UrWTm2ai5cXE5Unx4Lt0hypX28FJ3zTkI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=biBGoq19RYR6n5VnHM9RCG1Lg5IitlxsYIyVbc/OfFPlOfC6Kjt7D+NAY3MAf0JvQE18BeUtybRB9Bd+Pn/tjmKbaL8zzdv1qwZPdilpz/GNd6Le45lj2ClBBCge0mFJU69q95RloCUG35sSTItQuQREVlly3z6cmC0Lv648778=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQdbv32M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1F1C4CED1;
	Mon,  9 Dec 2024 17:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733765177;
	bh=DbEW8HiEN8UrWTm2ai5cXE5Unx4Lt0hypX28FJ3zTkI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=SQdbv32M4gQfi9aL+m0N6a0fpwF6PUXBwwdopOppQ3QfliOy+UR05w1z7Aew+lk8w
	 tBF9Yrqe1thB/xvp707bYe6Vd0m+O0WMa+BdLluei4HltbGcR38U2jb2p+V8GbjB7m
	 pQVMeVr6WeFGjt9tB2yJ0i9MVRw0wsV3nzNu6cn/q7bhr/KciaOHKrPrr3W/Z0XDoS
	 EQ4NoG542UvaMERya0nKonWZ/nboV1147wMcNe3ZxUcx8FG8+68Rqb53ikI/Lk7Mph
	 Y/j/fYA7dAxAlAWRi+duqZlxLyoMM7Yio/4yxC5RhCqNOPnLeRqV+RlxtZML8djoR8
	 5K6LpBoog8cTg==
From: Kalle Valo <kvalo@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org,
  devicetree@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: net: wireless: Describe ath12k PCI
 module with WSI
References: <20241205203044.589499-1-kvalo@kernel.org>
	<20241205203044.589499-2-kvalo@kernel.org>
	<20241206-sugar-surely-9efffa93aa5c@spud> <87zfl5rxt7.fsf@kernel.org>
Date: Mon, 09 Dec 2024 19:26:15 +0200
In-Reply-To: <87zfl5rxt7.fsf@kernel.org> (Kalle Valo's message of "Mon, 09 Dec
	2024 11:49:08 +0200")
Message-ID: <87a5d4sr7s.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Conor Dooley <conor@kernel.org> writes:
>
>> On Thu, Dec 05, 2024 at 10:30:37PM +0200, Kalle Valo wrote:
>>> +  qcom,wsi-controller:
>>> +    type: boolean
>>> +    description:
>>> +      The WSI controller device in the WSI group aids (is capable) to
>>> +      synchronize the Timing Synchronization Function (TSF) clock across
>>> +      all devices in the WSI group.
>>
>> This should be type: flag btw.
>
> Just so that I understand correctly, do you mean it should be like this:
>
>   qcom,wsi-controller:
>     $ref: /schemas/types.yaml#/definitions/flag
>     description:
>       The WSI controller device in the WSI group aids (is capable) to
>       synchronize the Timing Synchronization Function (TSF) clock across
>       all devices in the WSI group.
>
> And no changes in the code?

I submitted v2 now:

https://lore.kernel.org/ath12k/20241209153034.50558-1-kvalo@kernel.org/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

