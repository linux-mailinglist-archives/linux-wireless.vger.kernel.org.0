Return-Path: <linux-wireless+bounces-1935-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8610782DC51
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 16:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7C51C20898
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 15:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93EB17983;
	Mon, 15 Jan 2024 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnjFJtSU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6C417981
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 15:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9D5C433C7;
	Mon, 15 Jan 2024 15:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705332478;
	bh=83Kwxp4mOs4b7IHvqtRZuMJdTUukpnkqxu557swleIs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=TnjFJtSUyGh2PJLnoF+yvF/yRixUtkfXtalmww1XZOrq24RFQ0TKmrFVFtf+QmqKe
	 AcMj1lm5+MYLEy79m60g0+0tMtYtYKR2d0wwapRR6Sqpsk1r3axcq1rC6b33/7OSzV
	 uX9j5Q/7zghzDcG5Z4aH9qe5HGKnvB3FrnkpDO0HJckByTngm9mFXaPgPg71CfqDG8
	 Up/Y+zERPYlPOPUv1AJaJ0uWB25Sr6JS+L8Bt8sCnSEOqUwgGzCdyITXgSVRH7h1Ec
	 CiwKoSI3i76TvX0qWl8sDNXQst+zEhwX69gRZL12/mLTatIAPeulImvYlxJXA1+Moh
	 YLFPIaFUbrqEA==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 4/4] wifi: ath12k: Refactor MAC un/register helper function
References: <20231206034920.1037449-1-quic_periyasa@quicinc.com>
	<20231206034920.1037449-5-quic_periyasa@quicinc.com>
	<87bk9uej0b.fsf@kernel.org>
	<269ea05b-d665-eceb-d7a1-d0ac20d341a7@quicinc.com>
Date: Mon, 15 Jan 2024 17:27:55 +0200
In-Reply-To: <269ea05b-d665-eceb-d7a1-d0ac20d341a7@quicinc.com> (Karthikeyan
	Periyasamy's message of "Tue, 9 Jan 2024 19:11:38 +0530")
Message-ID: <87v87u7h1g.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

>> Is there a reason why you moved these two functions from mac.c to
>> core.c? This is mac level code anyway, right?
>
> This is not fully mac level code, some parts of SoC/chip level code
> bindup in the mac level. So i segregated the SoC level code like ab
> related param initialization handling from the mac level procedure.
>
> Now, mac/radio should take care only radio level handling procedure.
>
> In future for MLO, SoC level can be extend easily.

But is there a concrete reason to have the functions in core.c? In your
following patches I couldn't see why to move these functions to core.c,
everything seems to be suitable for mac.c.

I experimented this in the pending branch and moved the functions to
mac.c (tag ath-pending-202401151424):

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=bee89ac2b5755754849deaf7054828e982cc6658

I also fixed your other patchsets to match that and to me it makes more
sense to have everything in mac.c. I prefer to make core.c as simple as possible.

As you can see I also made changes to the patch titles to make them more
understandable:

wifi: ath12k: refactor ath12k_mac_register() and ath12k_mac_unregister()

Thoughts?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

