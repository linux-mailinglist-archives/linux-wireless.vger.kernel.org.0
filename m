Return-Path: <linux-wireless+bounces-7113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248298B9924
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 12:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23FD28399F
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 10:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CB361694;
	Thu,  2 May 2024 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKikgIve"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D8B60ED3
	for <linux-wireless@vger.kernel.org>; Thu,  2 May 2024 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714646402; cv=none; b=EswRFkgR6yOL7ynjTCVbCqH4jGTC7+m3fFW5U06Ws/85cp0fi/Wo4OFLlVsP0RoEyeI+COa0t36mvCH0ekoq1wKJgZh3muu9fMFUA15vResb08k/KdmrxDkEHPyyAtM+54dMmW5hBCzbKDjYmmRAwiZv56MF7CPBR0cVAQfwvtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714646402; c=relaxed/simple;
	bh=59Lg6crkNG6Sw6l0EhZYHYibNEh0Vh+UltVt2CkQPtw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gnygGYYkuPnWXwubj6BmuQzU2UVL4M2QU/AxxWGH2olH647h3Sbn0MotJ/rXpkeUSuXt1G1NtjZATibb+xLVDI46ykzFnDJBqP1KEx+I7iubK9nCSqO01oLKThOvqPez+39thtTrFNfV0hi+oNlZCn20ifcwHgdUUmvFAggIr2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKikgIve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567C9C113CC;
	Thu,  2 May 2024 10:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714646402;
	bh=59Lg6crkNG6Sw6l0EhZYHYibNEh0Vh+UltVt2CkQPtw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=GKikgIve3HlnI+kmPeCvuanO1VfDVm8lMunBkigrAKVzERlkyoo+uxFmJVrUSfx7R
	 xBhYov2cYOuuKr1udbJeCmwCrf7wQZSCwAcER9AbekYM2c5X+N5a5Uyc86Om5ThW+S
	 fz05hMfDctfY/o+2xHB04zynMspK2rXcETI4H9XIpFRuT5zQRhqLsCjo1BvrshaZUe
	 uC+k4AljV2HgC5XpouW1ogt9iWe6MXTaYnwwiYIb2wkrLBJwz7rPQS1LKh810LjAIl
	 yOiqf2lqC0MGdp2N9865vyol6tqdGPrKVnvE1bN7Jwv3EDp2DbaF6T+3mWDSAng+CC
	 lJ7ng00y5S6tQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>,
  <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] wifi: ath12k: drop failed transmitted frames
 from metric calculation.
References: <20240430074313.885807-1-quic_kathirve@quicinc.com>
	<20240430074313.885807-3-quic_kathirve@quicinc.com>
	<8a7823bb-dcee-4ddb-93e0-077371408014@quicinc.com>
Date: Thu, 02 May 2024 13:39:59 +0300
In-Reply-To: <8a7823bb-dcee-4ddb-93e0-077371408014@quicinc.com> (Jeff
	Johnson's message of "Tue, 30 Apr 2024 10:50:00 -0700")
Message-ID: <87zft8o5ts.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 4/30/2024 12:43 AM, Karthikeyan Kathirvel wrote:
>> In mesh node traffic, internal firmware-transmitted failures are
>> reported as transmitted failures in mesh metric calculation, leading
>> to the breakage of the mesh link.
>> 
>> Fix the issue by dropping the internal firmware-transmitted failures
>> before updating the TX completion status to mac80211, in order to
>> prevent false failure averaging in mesh metric calculation.
>> 
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> 
>> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
>> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> With one caveat noted below,
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>
> [...]
>> diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
>> index 63340256d3f6..71e8c8a091ae 100644
>> --- a/drivers/net/wireless/ath/ath12k/hal_desc.h
>> +++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
>> @@ -1,7 +1,7 @@
>>  /* SPDX-License-Identifier: BSD-3-Clause-Clear */
>>  /*
>>   * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
>> - * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>
> should be 2021-2022, 2024 per current guidance
>
> Kalle can probably fix this in the pending branch

Fixed to this:

--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

