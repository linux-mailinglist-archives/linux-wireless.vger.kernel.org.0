Return-Path: <linux-wireless+bounces-15107-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A18CC9C0CF0
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 18:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576C61F240E3
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 17:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B24E212EF0;
	Thu,  7 Nov 2024 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6+4VwMv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE53190049;
	Thu,  7 Nov 2024 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000720; cv=none; b=Le+cq0T5Lnpkjpnx84r694tm7V9QcyuedfzS/BUa5Xv92x27ZunaeunEsr3m4E1kTnLHRZOMi9EIoKMwACoRD6dIbczR8PIZLh6xOuG+q3yUNqFyDzcQHgGivVUfQGSXfVW5YQ9Rn9Bs9JXUJIIdzJIdSvIARd2ZdrvYjgKgJB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000720; c=relaxed/simple;
	bh=TfjUEPKxwyd2jm4vuB7rJhOT1ey+EjzS+137thlX6+Y=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gGLzvsI2ws4MBp8lZ/UGZTBdF421kAbIuTMAJVxbl6GrFQ7rlGzfIflIj55ZSvmNaYNMP7E+3VSsPL3aO0PlBdtoPID9WXmP14hwuOqCYxGXXXHTN5jiqTAYLor7g1kE4d6FEWpYG38F0rVFjzq0msVD5ufz5SQjKgBmV56pUWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6+4VwMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC2CC4CECC;
	Thu,  7 Nov 2024 17:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731000719;
	bh=TfjUEPKxwyd2jm4vuB7rJhOT1ey+EjzS+137thlX6+Y=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Z6+4VwMvIqk2vYedO6FMFTHw+Frs4OsGlT5R8HPd4McF3glhOk+OvkuRlKMvZR4qt
	 /UHY1+M4MqIoFWDtBwFJdyaJYWE7LWhyXw07Rd6ZQ0wqFT4rzqiWQEQehTHnC9Cq+x
	 10pqbGhdxSkjoeSzbFcZ3XUEEe9v2b5lBTDhMHuniNFju5bxlQ9pmwm35/M9MEyNT3
	 dtdl7BcCykBAot7BUu+LBCHIiOB+XPCqpjKSG7a4s6+VR5Zc00ME6xvOvlYwvw9ELG
	 38Y1HDIdiDOHgySSmdo9ivPIKOd04JXN0NG5U1MqR7cL8bLX5Tys/vBVtP6QQeI6r4
	 usF7my+pbQWfw==
From: Kalle Valo <kvalo@kernel.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
  <quic_jjohnson@quicinc.com>,  <ath11k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>,  <linux-arm-msm@vger.kernel.org>,
  <quic_zhichen@quicinc.com>
Subject: Re: [PATCH v2 2/2] wifi: ath11k: support board-specific firmware
 overrides
References: <46de0bfe-ebdd-4b37-a957-3c64e30a1376@quicinc.com>
	<CAA8EJpr4zgV4Sa4sPdCToQWs+CFJu6Xz6CPcPyHDhDczmuzj=g@mail.gmail.com>
	<06ff37ef-dfda-470f-80f7-0f54bae25686@quicinc.com>
	<CAA8EJppFCXeUAZax+jv42JrKYgLmaPQNpXhn-06q_K_uB9JZLQ@mail.gmail.com>
	<46b18b39-9e88-42f8-aa88-5b527fc92a9f@quicinc.com>
	<xp5j6kkpggfhxvzuozqcvs2ugon5xexjgzl24zjlen7kggdaju@vd3okew4vcsy>
	<49313be4-b0e2-4ec4-8663-bd4daf20f78a@quicinc.com>
	<ksyukz7oouw2ilxxpx5nhnshu3zmnd5rtgeloea2vykzzn6ii5@unvpx26neirt>
	<590b729b-a921-4ed7-af2d-326cf596ae1f@quicinc.com>
	<73916bc3-f3c8-4ef9-ab8b-d1497f228d13@quicinc.com>
	<csqlwll36viejkp7k57r3jdejpt2kkttmzawq6y6q7i7qs25ht@n3mazu6owblv>
	<3dd897cb-5cc3-409d-a310-66e71847d58f@quicinc.com>
Date: Thu, 07 Nov 2024 19:31:56 +0200
In-Reply-To: <3dd897cb-5cc3-409d-a310-66e71847d58f@quicinc.com> (Miaoqing
	Pan's message of "Fri, 1 Nov 2024 09:32:37 +0800")
Message-ID: <871pzn54s3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miaoqing Pan <quic_miaoqing@quicinc.com> writes:

>>>>>> Understand your concern, automatic adaptation is always the best
>>>>>> choice. But
>>>>>> it may not work for MSM boards, the PCIe card (non m.2) is
>>>>>> customized, which
>>>>>> has special PMU control. User can't swap cards. And that's why power
>>>>>> sequencing module was introduced.
>>>>>
>>>>> I know. Still, it's better to have less unnecessary data there for
>>>>> autodiscoverable devices.
>>>>
>>>
>>> We discussed internally, we have no other choice to enable NFA765 for non
>>> X86 boards. Could you please approve this 'DT' approach ?
>> If you can't use subdevice approach for some reason, then we have no
>> other choice that I can imagine.
>> 
>
> A new patch was submitted:
> https://lore.kernel.org/linux-wireless/20241031000541.3331606-1-quic_miaoqing@quicinc.com/.
> This patch will add QCA6698AQ support, which follows the approach done
> in commit 5dc9d1a55e95 ("wifi: ath11k: add support for QCA2066"),
> enumerates the subversion number to identify the specific card.
>
> But there is still a problem enabling NFA765 m.2 card for IoT
> platforms, which requires ath11k to support board-specific firmware
> overrides.

So there are multiple different hardware you want to support? This is
very confusing and the commit message does not really tell anything
about those. Can you list _all_ the hardware you want to support and
what firmware it needs?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

