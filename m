Return-Path: <linux-wireless+bounces-12526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608CF96D05F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 09:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97777284DD6
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 07:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E32192B94;
	Thu,  5 Sep 2024 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJycHaev"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0402683CC1
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 07:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521263; cv=none; b=lQVYVGnkagk/DOaDX2T8rVGKFEYnIk0W8VhKSa8wBWMRtqrPVMP2H6VbzoSAzCXFJ0KA5o2VFSh4jDOyYUluZLd1jUO7jg8MLqsd2VnPoL+o1yZoM+KbBG5XeIPJNcUMraR2bi/YEAfoq2emLv8vBMxupaTfM3eOJij+byNuCz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521263; c=relaxed/simple;
	bh=bchWX3as4Mv4asstAkOdtgNcx8RzfYmjoMp0k/ZWpIE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=QQSUjBZivOwlQMniK004Ix8Kq0FNSDoqkv7cIvGrkP9LiHnSk9QCpLbmeB8oRU8QXGsdArh11/S9au8NntlZl+cT5CZZqwnsD6ILOq/neZ9wmZNfeYx57bgg3PFvEPIvYrgFMxJPeCP34YUkyXrE8qzaV6PA6vxBr6FOWobsJkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJycHaev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65566C4CEC4;
	Thu,  5 Sep 2024 07:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725521262;
	bh=bchWX3as4Mv4asstAkOdtgNcx8RzfYmjoMp0k/ZWpIE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=DJycHaevMSYveGOfaALQ6oOyL6SblEiEMuCP4pXT2wxPREEHJ5O8E1PhpLxJpPEGR
	 hIr544x33lL56fagONp2udPvT7689wuDNdEwGsw3jFHY7Ua6kdpZOn2KU/EtQldU8e
	 TeMb1LWgDGS+yEJ6ZEcUra3ACaTDWOZmczUHemXVGWNiaaHkE1AAuRR1wlk2rFR07O
	 LsfV+RCbUG2oxuKzk1V2eBdm0+ogY3ny56UIw+PryJD/AlMFsCcR7di1abFaTe/ls/
	 2F3uQexEzfWrXSiY1agBrZQk+huxM7AYXXXJUJgbW6bislX0ruckiNjeZFZ4LlmTGC
	 XY+GeTnNAprJA==
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
	<87ed62kodu.fsf@kernel.org>
	<2d5f4d63-ab91-40d6-ae0c-81d4bc847fbf@denx.de>
Date: Thu, 05 Sep 2024 10:27:39 +0300
In-Reply-To: <2d5f4d63-ab91-40d6-ae0c-81d4bc847fbf@denx.de> (Marek Vasut's
	message of "Mon, 2 Sep 2024 18:43:08 +0200")
Message-ID: <87tteuimqc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marek Vasut <marex@denx.de> writes:

>>>> Are you also taking into account hibernation? During hibernation the
>>>> device will be powered off. I can't remember the details right now but
>>>> wanted to mention this.
>>>
>>> I don't think I am. Isn't hibernation actually a full shutdown, so the
>>> hardware does get reinitialized ?
>> I don't know how it works exactly nor what you exactly mean with
>> reinitalized.
>
> My understanding is that hibernation is suspend-to-disk, isn't it ?

Yes, that's what I mean.

> (that's not something that is even available on my hardware)

Yeah, I'm guessing wilc1000 is used more in embedded enviroments where
hibernation is not really an important, it's used more in laptops. So I
guess it won't be a big problem if wilc1000 doesn't support hibernation
but please try to keep it in mind still.

> Doesn't the hardware get completely turned OFF during suspend-to-disk
> and then turned ON (and therefore initialized again) on
> resume-from-disk?

I'm not sure how it works exactly but my experience is that for
hibernation a driver cannot assume that the firmware is running during
resume.

>> But at least with ath11k hibernation didn't work when it
>> left the firmware running during suspend.
>
> Is there a thread on lore or some details of this you could point me to?

See commit 166a490f59ac ("wifi: ath11k: support hibernation") and the
commits before that. I'm sure that there's more info about hibernation
but don't have any pointers.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

