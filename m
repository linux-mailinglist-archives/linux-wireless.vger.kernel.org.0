Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87626077DE
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 15:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiJUNJZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 09:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiJUNJS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 09:09:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CBF26C1BC
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 06:09:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FEADB82BCD
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 13:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A75C433C1;
        Fri, 21 Oct 2022 13:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666357682;
        bh=tKKxs7kbtMVrIJ25VRA8AnRI7kBpz/GZtojXw0IasK8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=U+E+90G+6vXZ3J168+f0JOK6bvHTv4NZIyVeh9nNe97XIvCoTzKliduMT45WRLSH+
         pXNPFZjEHZzfF3eZrn7DgXbTBoiJQ9NKDzUyekOtls5ugjU8O4p8g5yJBptIvDkOG2
         dpZN30uzlra3qDAxjAdFJBrDhiaxzJnFJ4/sQKHpwhRvwvejO+IR7XKq9vVIp3G/qV
         v7gUy+qkpGaMb24yNBUAsLWohw9h0nkFyvWEerJf9qH1/3y+NPd53B9/+waHfkqCKD
         PdUf4e7bT5f0qoD5KNKNaxtmyFF/yvS6ubgnKeXn6gZr0fEli7nUOCuaEvhcva00XA
         yLIUlb8Sq0bsQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
Subject: Re: [PATCH 13/50] wifi: ath12k: add dp_mon.c
References: <20220812161003.27279-1-kvalo@kernel.org>
        <20220812161003.27279-14-kvalo@kernel.org>
        <e4c2c436-82e2-bf15-a635-e8f4e566d8d2@quicinc.com>
Date:   Fri, 21 Oct 2022 16:07:58 +0300
In-Reply-To: <e4c2c436-82e2-bf15-a635-e8f4e566d8d2@quicinc.com> (Jeff
        Johnson's message of "Tue, 16 Aug 2022 13:13:46 -0700")
Message-ID: <87y1t9iatt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 8/12/2022 9:09 AM, Kalle Valo wrote:
>
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>
>> (Patches split into one patch per file for easier review, but the final
>> commit will be one big patch. See the cover letter for more info.)
>>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/dp_mon.c | 2598 ++++++++++++++++++++++++++++++
>>   1 file changed, 2598 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c
>> b/drivers/net/wireless/ath/ath12k/dp_mon.c
>> new file mode 100644
>> index 000000000000..479be0e441d8
>> --- /dev/null
>> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
>> @@ -0,0 +1,2598 @@
>> +// SPDX-License-Identifier: BSD-3-Clause-Clear
>> +/*
>> + * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include "dp_mon.h"
>> +#include "debug.h"
>> +#include "dp_rx.h"
>> +#include "dp_tx.h"
>> +#include "peer.h"
>> +
>> +static void ath12k_dp_mon_rx_handle_ofdma_info(void *rx_tlv,
>> + struct hal_rx_user_status *rx_user_status)
>> +{
>> +	struct hal_rx_ppdu_end_user_stats *ppdu_end_user =
>> +				(struct hal_rx_ppdu_end_user_stats *)rx_tlv;
>> +
>> +	rx_user_status->ul_ofdma_user_v0_word0 = __le32_to_cpu(ppdu_end_user->info6);
>> + rx_user_status->ul_ofdma_user_v0_word1 =
>> __le32_to_cpu(ppdu_end_user->rsvd2[10]);
>
> this violates the convention that info* is used for fields that are
> accessed while rsvd* is used for fields that are not accessed. in
> addition, use of magic number offsets is also not nice.

P Praneesh fixed this:

b290b591dbdd ath12k: remove magic number offset in rx_user_status struct

> imo what would improve this code is to have accessor macros/inline
> functions defined co-resident with the struct so that all the magic
> numbers and magic fields are contained within the acessors, and the
> actual code here looks really readable.

Yeah, in general that would be good. But in this case it would also help
if struct hal_rx_user_status word0 and word1 fields would be renamed to
better reflect what they actually are:

	u32 ul_ofdma_user_v0_word0;
	u32 ul_ofdma_user_v0_word1;

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
