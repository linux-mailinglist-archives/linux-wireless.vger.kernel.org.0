Return-Path: <linux-wireless+bounces-7459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 591268C2621
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 15:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6531F2280D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 13:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F47212C49C;
	Fri, 10 May 2024 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNmFT3id"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550CE5027F;
	Fri, 10 May 2024 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349434; cv=none; b=QPB8adnUwWtGvV/ayiFwH1xUhtiWDO5hKuckfrUWjUxfGr8e0LgiaHj35fBas7343VR4cSiBGInM5ZIk9ksr+PxOpYmRZ610PG0bH6jF8q1o7WGLflaHAnW1S+Fjnonrdpwdv4hGOX8VoNmfWCNVhaotWs/04fKFynbSPyyCJog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349434; c=relaxed/simple;
	bh=SRZxgrNyAWX83L2b3Fpq/g2RtgbTj4vvYCwVMmud+JA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gt5roPR8/K2+rUnQwWNHknALn57Ndtx81br7FsEzYiUasG0nhUROYtsHdxWJQvl7YoBnSTIoktgeo178RoeF5l40mUTdWiOghBoJWya2gR6fVHHTN/NnYh6zaEiQfhUpuqCQ3S0fLRAJe8QDWwxFQNqw64q4wo7D/IaxEIvPMck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNmFT3id; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E710C2BBFC;
	Fri, 10 May 2024 13:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715349433;
	bh=SRZxgrNyAWX83L2b3Fpq/g2RtgbTj4vvYCwVMmud+JA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=HNmFT3idLNTooLyZJ486hvxgou+od5G9023yjgOVltyGiaE56GRH48CPaDwIA3R2Z
	 HhaHTK6R42/ngFDoytf2Ur13J1x1BqDZtiIMTzieOdwZLoaHULUPD3tmRmPKBVcvrA
	 ZY3cT84MF5guo6rmueyeDIUpObpyZ7Zd5GG5aGsyyOQcYkxWuwrK6S09HP5Gna6QJb
	 yOn3z1bWfvCVCM+sCI4gCd2+kaLAW6GWzQ7X8u1QPpLXCY7d9lN8/rKEGYde39tzyw
	 XU5BVjuLw/i/hvdUd8XMs1BHuoWE34km7tYbVbB4saaojn3Pm3hIF9dCrpbyyCWAza
	 E2cZLkIibhWDQ==
From: Kalle Valo <kvalo@kernel.org>
To: Carl Huang <quic_cjhuang@quicinc.com>
Cc: Luca Weiss <luca.weiss@fairphone.com>,  <ath11k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>,  <regressions@lists.linux.dev>
Subject: Re: [PATCH 1/2] wifi: ath11k: supports 2 station interfaces
References: <20230714023801.2621802-1-quic_cjhuang@quicinc.com>
	<20230714023801.2621802-2-quic_cjhuang@quicinc.com>
	<D15TIIDIIESY.D1EKKJLZINMA@fairphone.com> <87jzk2km0g.fsf@kernel.org>
	<93c15c59-f24c-4472-ae7e-969fd1e3bfec@quicinc.com>
Date: Fri, 10 May 2024 16:57:10 +0300
In-Reply-To: <93c15c59-f24c-4472-ae7e-969fd1e3bfec@quicinc.com> (Carl Huang's
	message of "Fri, 10 May 2024 20:03:28 +0800")
Message-ID: <871q69lqh5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Carl Huang <quic_cjhuang@quicinc.com> writes:

> On 2024/5/10 18:18, Kalle Valo wrote:
>> "Luca Weiss" <luca.weiss@fairphone.com> writes:
>> 
>>> On Fri Jul 14, 2023 at 4:38 AM CEST, Carl Huang wrote:
>>>> Add hardware parameter support_dual_stations to indicate
>>>> whether 2 station interfaces are supported. For chips which
>>>> support this feature, limit total number of AP interface and
>>>> mesh point to 1. The max interfaces are 3 for such chips.
>>>>
>>>> The chips affected are:
>>>>   QCA6390 hw2.0
>>>>   WCN6855 hw2.0
>>>>   WCN6855 hw2.1
>>>> Other chips are not affected.
>>>>
>>>> For affected chips, remove radar_detect_widths because now
>>>> num_different_channels is set to 2. radar_detect_widths can
>>>> be set only when num_different_channels is 1. See mac80211
>>>> function wiphy_verify_combinations for details.
>>>>
>>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>>>
>>> Hi Carl,
>>>
>>> Unfortunately this commit breaks wifi on a QCM6490 smartphone
>>> (qcm6490-fairphone-fp5) and makes the board crash.
>>>
>>> Reverting this commit (plus for conflict resolution 5dc9d1a55e95 ("wifi:
>>> ath11k: add support for QCA2066") and 24395ec11707 ("wifi: ath11k:
>>> provide address list if chip supports 2 stations")) makes wifi work
>>> again.
>> Thanks for the report. So the broken commit is:
>> f019f4dff2e4 wifi: ath11k: support 2 station interfaces
>> This went into v6.9-rc1 so I'm guessing that WCN6750 support will be
>> fully broken in v6.9? Not good. And most likely Linus will release v6.9
>> on Sunday so it's too late to get a fix included in the final release.
>> Carl, can you fix this ASAP? Or should we just revert the broken
>> commits?
>> Adding this to our regression tracking:
>> #regzbot introduced: f019f4dff2e4 ^
>> #regzbot title: ath11k: WCN6750 firmware crashes during initialisation
>
> Kalle, looks we're not able to fix it before Sunday as I don't have
> WCN6750 setup to verify the fix.

We are so late in the cycle that we would have to send the fix directly
to Linus and ask him to apply the fix before he tags the release. I
prefer that we are on the safe side here and send the fix to v6.10-rc1
via the usual route (the wireless tree). We get more testing time that
way.

> The fix could be to define a dedicated function
> ath11k_init_wmi_config_wcn6750() for WCN6750. I'll send the patch out
> so others like Luca can have a try.

Thanks for the quick patches!

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

