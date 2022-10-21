Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55071607599
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 13:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJULHh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 07:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiJULHg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 07:07:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBE72591DD
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 04:07:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFE78B82A2D
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 11:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9ECEC433C1;
        Fri, 21 Oct 2022 11:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666350452;
        bh=KiDKvGNH29WQDs7TzlkbxJyAX/pWfvnZQyxfCLqQWuQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=BfvRsP7dZ/YvgZ/8xs3ieVwdwAJfjO0KOFcP+n0lxep/2k3FMdDbVFKvbdopuil6t
         0B2dpR2RK7y4SoH1oXQRtFeHJZ9JmEqeH3+gf7ic2OrqYtBPhQoivb/qpAHPBxENiF
         53DzUue1jlCt2k46EfeT1+1lb75NlRu+0GTXpnpQj7rt+4gMx4svUE9HO6Rc5j2DSy
         MWPnapjjVHwg2KFaViUw+AUWYq8Mw70JL9E1Qxb4ZLIB0tM9K0c6V1jL0swwDGXLEu
         y47Wiau24InTUlxPQIqcIAoZ0u7r9Cc5ArJf8+2QM2V4PrGtmtDRKaqNCIh56m8G7K
         oVpXV2/kjThbQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
Subject: Re: [PATCH 08/50] wifi: ath12k: add dbring.h
References: <20220812161003.27279-1-kvalo@kernel.org>
        <20220812161003.27279-9-kvalo@kernel.org>
        <3f8edc37-6be7-efe5-ac02-2d068f428277@quicinc.com>
Date:   Fri, 21 Oct 2022 14:07:29 +0300
In-Reply-To: <3f8edc37-6be7-efe5-ac02-2d068f428277@quicinc.com> (Jeff
        Johnson's message of "Mon, 15 Aug 2022 12:59:31 -0700")
Message-ID: <87r0z1juz2.fsf@kernel.org>
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
>>   drivers/net/wireless/ath/ath12k/dbring.h | 80 ++++++++++++++++++++++++++++++++
>>   1 file changed, 80 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/dbring.h
>> b/drivers/net/wireless/ath/ath12k/dbring.h
>> new file mode 100644
>> index 000000000000..2be2d8def3f0
>> --- /dev/null
>> +++ b/drivers/net/wireless/ath/ath12k/dbring.h
>> @@ -0,0 +1,80 @@
>> +/* SPDX-License-Identifier: BSD-3-Clause-Clear */
>> +/*
>> + * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef ATH12K_DBRING_H
>> +#define ATH12K_DBRING_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/idr.h>
>> +#include <linux/spinlock.h>
>> +#include "dp.h"
>> +
>> +struct ath12k_dbring_element {
>> +	dma_addr_t paddr;
>> +	u8 payload[0];
>
> should just be payload[]
>
> <https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays>

Praneesh fixed this:

c568d8bc26de ath12k: convert payload[0] to payload[], use ab variable and fix __ath12k_dbg() signature

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
