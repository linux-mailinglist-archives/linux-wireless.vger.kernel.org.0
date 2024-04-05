Return-Path: <linux-wireless+bounces-5909-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB22D899E16
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 15:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8767D28509D
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 13:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6FE16D4E1;
	Fri,  5 Apr 2024 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYAiBhM3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B4B16D4C5;
	Fri,  5 Apr 2024 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322716; cv=none; b=NeU5wMLJR30VWXtTsbGGggnn5+cH35cGn/m2KXdzsfu/WAC1l6hyfma70KhtR33pVi/w6gu0rBIr3Cq9F6iFwfDtUyHPOmDN2JbamLeSx62PKPrsbZnZUWkXOzZMq/5i2AWDOk4TBR/BoGAwPKoJRSZ0414e4Cz8TxhtryG+QQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322716; c=relaxed/simple;
	bh=TnXMU4f/t+D3MLK1a/iIO51tx3i8Q3ak6lF0vvJQgks=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ihDJ3wjxh2OXLqnbQa3MesBu5zVmL8CGDSLqHX4z+yknyh0hOD0piAxYKnywlygR9mK+Nj85vqmsCLB13VsRcxEsQECudJkVshG0dQeOeJWq0zDFJWExm2UyKKbaqT8vAYGYc7cur2OsSftNzlecTPBbUnwYqDanUJ3JwfYQ40g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYAiBhM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0C7C433F1;
	Fri,  5 Apr 2024 13:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712322715;
	bh=TnXMU4f/t+D3MLK1a/iIO51tx3i8Q3ak6lF0vvJQgks=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=nYAiBhM3aAgL+JSn3kHh7cAYfNy/jRvew0og/9mA0h2j87HIVX0bSu+rRs9lj5Ueu
	 GGvoEfyxeQD5+jCSzH5q/IdQ/bsxznZQDh3q5GnGuatcE4j4J5eO9CooqMMHQ8ONn8
	 zb8bo1sQ85MWINbrK70jwkcAd1Pgs+prOGfhR+vum6gKfYwu3ZleIVrAoRtuH9H3+7
	 mJh5y+UHHPxjVlp4NM6Yn8Mir8Kpq8zbYa4+di0fi+njlE+EnSZN5AslWt1hpFD37L
	 TivYdhLtEAWQF9okdixFPtK9BBGIG4scNxzVIEK3INfcH0ZenXJqkStUCUBfTbKnBW
	 sWjuxZTj6OLvQ==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  ath10k@lists.infradead.org,
  linux-wireless@vger.kernel.org,  linux-arm-msm@vger.kernel.org,  Yongqin
 Liu <yongqin.liu@linaro.org>
Subject: Re: [PATCH 0/3] wifi: ath10k: fix board file loading for wcn3990
 devices
References: <20240130-wcn3990-board-fw-v1-0-738f7c19a8c8@linaro.org>
	<CAA8EJprsjs8SWZmpTisyQcAZ9VC8g3_GEEc1hhp8bMZrm-hyaw@mail.gmail.com>
	<875xww3tv8.fsf@kernel.org>
	<CAA8EJprZTdDZZ=NSzn9xEBGB0kp0s1HHLffF0X7YSLyVxy7ZSw@mail.gmail.com>
Date: Fri, 05 Apr 2024 16:11:52 +0300
In-Reply-To: <CAA8EJprZTdDZZ=NSzn9xEBGB0kp0s1HHLffF0X7YSLyVxy7ZSw@mail.gmail.com>
	(Dmitry Baryshkov's message of "Fri, 5 Apr 2024 16:06:48 +0300")
Message-ID: <877chc2btz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:

> On Fri, 5 Apr 2024 at 14:57, Kalle Valo <kvalo@kernel.org> wrote:
>
>>
>> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
>>
>> > On Tue, 30 Jan 2024 at 08:47, Dmitry Baryshkov
>> > <dmitry.baryshkov@linaro.org> wrote:
>> >
>> >>
>> >> The ath10k driver fails to properly handle fallback from board-2.bin to
>> >> board.bin for WCN3990 cards. This happens because the
>> >> ath10k_hw_params_list doesn't include .fw.board* parameters for the
>> >> WCN3990 platform.
>> >>
>> >> Add board data configuration for WCN3990. While we are at it, merge
>> >> common pieces of BDF support: drop .board and .eboard names from struct
>> >> ath10k_hw_params_fw and use the common name instead.
>> >>
>> >> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> >> ---
>> >> Dmitry Baryshkov (3):
>> >>       wifi: ath10k: populate board data for WCN3990
>> >>       wifi: ath10k: drop chip-specific board data file name
>> >>       wifi: ath10k: drop fw.eboard file name
>> >>
>> >>  drivers/net/wireless/ath/ath10k/core.c      | 32 ++++-------------------------
>> >>  drivers/net/wireless/ath/ath10k/hw.h        | 14 ++-----------
>> >>  drivers/net/wireless/ath/ath10k/pci.c       | 10 ++++-----
>> >>  drivers/net/wireless/ath/ath10k/targaddrs.h |  3 +++
>> >>  4 files changed, 14 insertions(+), 45 deletions(-)
>> >> ---
>> >> base-commit: 596764183be8ebb13352b281a442a1f1151c9b06
>> >> change-id: 20240129-wcn3990-board-fw-a2d97507a712
>> >
>> > Kalle, Jeff, is there anything pending on me on this series?
>>
>> This is in my queue (Deferred state):
>>
>> https://patchwork.kernel.org/project/linux-wireless/list/?series=821157&state=*&order=date
>>
>> Unfortunately there is not really much time for ath10k nowadays so there
>> will be delays.
>
> No problems, each maintainer treats PW states slightly differently, so
> I was trying to understand if there is anything left on my side.

That's true. I have tried to document how we in wireless use patchwork here:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#checking_state_of_patches_from_patchwork

Though I guess I'm the only one using Deferred state.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

