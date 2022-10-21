Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D833B6075DB
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 13:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiJULOd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 07:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiJULNy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 07:13:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2CA132DC4
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 04:13:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37E0661E2D
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 11:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0217C433D6;
        Fri, 21 Oct 2022 11:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666350774;
        bh=EAZr8MnyEYrWDeZ3KDwVf2S2ovNDi+djVop8NKZmqf8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LZN5fanhjbalZ/93gXChtA8E01oDFDujZp9cqPVF4IYc6lH18LqlGbi+TDt7UyZEh
         lrbd5wy2bALOh4hCdS5Rr12DMzGbUggvL9ZCilxZMlg9uUBDvSuIgbtG5FUrzwUvDv
         kf6YEa0HSgtajvPk2fsdI+TA4+pKjATVdPhxkjWlUDUGJsb8ZoFb9ZN0Ev21nYIoTn
         Tgot6NYRenXgNBhcPZOXfSgVu66bTFjLRk/0GuNYJYBJ8RMS82tMYNHW1Y/eY5Dy9a
         A2y57aAZ1E3VdmDiw2rr+d+KowWob0iVFxprCfUQLjPOmR867K+PQKObeBKqeyc73m
         5nzmf7xCsgJ0Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
Subject: Re: [PATCH 08/50] wifi: ath12k: add dbring.h
References: <20220812161003.27279-1-kvalo@kernel.org>
        <20220812161003.27279-9-kvalo@kernel.org>
        <3f8edc37-6be7-efe5-ac02-2d068f428277@quicinc.com>
        <87r0z1juz2.fsf@kernel.org>
Date:   Fri, 21 Oct 2022 14:12:48 +0300
In-Reply-To: <87r0z1juz2.fsf@kernel.org> (Kalle Valo's message of "Fri, 21 Oct
        2022 14:07:29 +0300")
Message-ID: <87mt9pjuq7.fsf@kernel.org>
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

Kalle Valo <kvalo@kernel.org> writes:

> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>
>> On 8/12/2022 9:09 AM, Kalle Valo wrote:
>>
>>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>>
>>> (Patches split into one patch per file for easier review, but the final
>>> commit will be one big patch. See the cover letter for more info.)
>>>
>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>>> ---
>>>   drivers/net/wireless/ath/ath12k/dbring.h | 80 ++++++++++++++++++++++++++++++++
>>>   1 file changed, 80 insertions(+)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath12k/dbring.h
>>> b/drivers/net/wireless/ath/ath12k/dbring.h
>>> new file mode 100644
>>> index 000000000000..2be2d8def3f0
>>> --- /dev/null
>>> +++ b/drivers/net/wireless/ath/ath12k/dbring.h
>>> @@ -0,0 +1,80 @@
>>> +/* SPDX-License-Identifier: BSD-3-Clause-Clear */
>>> +/*
>>> + * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
>>> + * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>>> +
>>> +#ifndef ATH12K_DBRING_H
>>> +#define ATH12K_DBRING_H
>>> +
>>> +#include <linux/types.h>
>>> +#include <linux/idr.h>
>>> +#include <linux/spinlock.h>
>>> +#include "dp.h"
>>> +
>>> +struct ath12k_dbring_element {
>>> +	dma_addr_t paddr;
>>> +	u8 payload[0];
>>
>> should just be payload[]
>>
>> <https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays>
>
> Praneesh fixed this:
>
> c568d8bc26de ath12k: convert payload[0] to payload[], use ab variable
> and fix __ath12k_dbg() signature

But there's still more of these:

ce.h:138:	struct sk_buff *skb[0];
core.h:738:	u8 drv_priv[0] __aligned(sizeof(void *));
dp.h:1336:	u8 data[0];
dp.h:1341:	u8 value[0];
dp.h:1597:	u8 payload[0];
rx_desc.h:1397:	u8 msdu_payload[0];
rx_desc.h:1418:	u8 msdu_payload[0];

I added these to my todo list, need to investigate in detail.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
