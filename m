Return-Path: <linux-wireless+bounces-12340-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFCE968C0F
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 18:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307E528388E
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 16:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFEA55887;
	Mon,  2 Sep 2024 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvS1P4Nr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B61438DC0
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725294737; cv=none; b=o8kp488cl7l6Bv39onebqCOP86ml5iDFxhqlMG7MXqmQmqAln1tDhnhPqDafeqfmZEear9vF4dh6CuoI5d79LJt6sTs+gTqpv1eekVLL1m3lQjJUFCCEiuAj8knEdkRnMpLqePiFBUPRkeReinrJy6UlMgkR7K3FUtJW8z5xFts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725294737; c=relaxed/simple;
	bh=PdrbqSpALzPXUzE3obmgLoJ70YBdVVkwjNbrswPXkkU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=KL9g8lh3kpWTEhI2SNuUage+DLfYMVdsLLlNKSO8oSwrMDqHwu6stH3n/jkwHlegfhUTclcgr5IlmMs+bMU/A9zxNo/LGsjACChIMXaUO10XEwjjXUjX8GH92xtCYdLEwT7JKZV/bmN/AbJf9A+E7lSXJ50x504at0V9eMowg5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvS1P4Nr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B81BC4CEC2;
	Mon,  2 Sep 2024 16:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725294736;
	bh=PdrbqSpALzPXUzE3obmgLoJ70YBdVVkwjNbrswPXkkU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=UvS1P4NrHBiXGzGXlUQTZP/GiCbwwqTvTBQHkTxxvs1jCs2W+g2ZjDh1V8cVsk8q2
	 dWfirC4oj0k188FrzNOjucywlKaRDBJZYvQtrRhnsJenSWyKOMH5pquwPC5WjKnM5E
	 O4rClicNbEPWs/Zorn6YhvxBGWyhWkRwDr9/K/4VBw18PVMoqd2kyUDBPoy1AYIKdx
	 MiZHtm83r22unDaiaE5TlV4aHw3Oa3cpzUxgcXIYROozLhKOy1o8k7OwNuIpeuwSsx
	 +WFF/IuIO08AB310ep+43Dunke+0WVouapQPs2rf+rxEb7wz3AJcWV/NmYEUZGuAAE
	 GvE0bd3Donyiw==
From: Kalle Valo <kvalo@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: Ajay.Kathat@microchip.com,  alexis.lothore@bootlin.com,
  linux-wireless@vger.kernel.org,  claudiu.beznea@tuxon.dev
Subject: Re: [PATCH] wifi: wilc1000: Keep slot powered on during suspend/resume
References: <20240821183823.163268-1-marex@denx.de>
	<a9e673b1-43f3-4341-a035-3e1265b8a544@bootlin.com>
	<60a52cac-964e-40d6-aa96-7bbf34d9c4ac@denx.de>
	<63266019-bbf0-4f26-9700-e0303a892b2b@bootlin.com>
	<0518770b-8975-4681-a32e-e82f540d9a73@microchip.com>
	<5229bc7c-564d-4195-a6ff-579dbe5c3a49@denx.de>
	<ae40b138-77ad-4044-9448-784be6964195@microchip.com>
	<12b79e2b-08ca-4ba0-8abb-6f1d0be65b3c@denx.de>
	<874j73e1dp.fsf@kernel.org>
	<5ba25a08-dc7f-4eb6-8982-e7a246178ba0@denx.de>
Date: Mon, 02 Sep 2024 19:32:13 +0300
In-Reply-To: <5ba25a08-dc7f-4eb6-8982-e7a246178ba0@denx.de> (Marek Vasut's
	message of "Fri, 30 Aug 2024 00:23:06 +0200")
Message-ID: <87ed62kodu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marek Vasut <marex@denx.de> writes:

> On 8/29/24 6:32 PM, Kalle Valo wrote:
>> Marek Vasut <marex@denx.de> writes:
>> 
>>> Since this driver does not reload the firmware into the card on
>>> resume, the card has to be kept powered on during suspend/resume
>>> cycle. The card can NOT be powered off during suspend/resume cycle,
>>> otherwise the firmware is lost.
>>>
>>> Without this flag, the card may be powered off during suspend/resume
>>> cycle. It possibly does not happen on the Atmel controller, but it
>>> does on the STM32MP15xx ARM MMCI one.
>>>
>>> Now, since the card does consume about the same amount of power
>>> whether it is powered OFF or whether it is powered ON but suspended, I
>>> opt for the later option -- keep the card powered ON, suspend it, and
>>> that's what this patch does. This also allows us to support WoWlan
>>> then.
>> Are you also taking into account hibernation? During hibernation the
>> device will be powered off. I can't remember the details right now but
>> wanted to mention this.
>
> I don't think I am. Isn't hibernation actually a full shutdown, so the
> hardware does get reinitialized ?

I don't know how it works exactly nor what you exactly mean with
reinitalized. But at least with ath11k hibernation didn't work when it
left the firmware running during suspend.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html

