Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82930621468
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 15:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiKHOA5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 09:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbiKHOA4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 09:00:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC35623B6
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 06:00:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29057615A2
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 14:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7862C433B5;
        Tue,  8 Nov 2022 14:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667916054;
        bh=GQqN3uk4uI0pLzcEd/XRQ6ibDPBdgB9ImZSIjgy8Jhs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mz12nUWZfx7cSJl2DB9kOkyE992ySRrcRzBhH8j144/iJPvMoEuu1aZRbixQ1WHLY
         dqx13Cn4V1vENfWPEAPyAQqQ5rBJ0dZly9xkaWa1DsbMuifNuy0S1qPHvhirhopf5N
         /HvI/0uNdtSXpoUkDoReXI8sbvxlY29gcrVyFhBAasvw/ZPDBwqJWAwNStsrPF0ZpV
         uI+x+oa5MV393+nCcRKqIN2IGeC0fTsX9c20F+7Dcye0yhRnVvuuqawAMw9LsNj9k+
         pUTe2onmpXgtOsrVqQ5fv/NdZDaUkeRyPSW550qtHnhBKVzyCWuANJ/jwx6m9N0i8j
         z1aSn3bMlbAqg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
Subject: Re: [PATCH 33/50] wifi: ath12k: add mhi.c
References: <20220812161003.27279-1-kvalo@kernel.org>
        <20220812161003.27279-34-kvalo@kernel.org>
        <05841a52-3d2f-8704-b885-4b02e7a439e0@quicinc.com>
Date:   Tue, 08 Nov 2022 16:00:49 +0200
In-Reply-To: <05841a52-3d2f-8704-b885-4b02e7a439e0@quicinc.com> (Jeff
        Johnson's message of "Thu, 18 Aug 2022 15:25:49 -0700")
Message-ID: <87h6z9eeb2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
>>   drivers/net/wireless/ath/ath12k/mhi.c | 615 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 615 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/mhi.c
>> b/drivers/net/wireless/ath/ath12k/mhi.c
>> new file mode 100644
>> index 000000000000..f77634994d97
>> --- /dev/null
>> +++ b/drivers/net/wireless/ath/ath12k/mhi.c
>> @@ -0,0 +1,615 @@
>> +// SPDX-License-Identifier: BSD-3-Clause-Clear
>> +/*
>> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/msi.h>
>> +#include <linux/pci.h>
>> +
>> +#include "core.h"
>> +#include "debug.h"
>> +#include "mhi.h"
>> +#include "pci.h"
>> +
>> +#define MHI_TIMEOUT_DEFAULT_MS	90000
>> +
>> +static struct mhi_channel_config ath12k_mhi_channels_qcn9274[] = {
>
> should this be const?
> in struct mhi_controller_config:
> 	const struct mhi_channel_config *ch_cfg;

Fixed.

>> +static struct mhi_event_config ath12k_mhi_events_qcn9274[] = {
>
> seems this should be const
> but for some reason struct mhi_controller_config has:
> 	struct mhi_event_config *event_cfg;
>
> (not const) so this can't be const :(
>
> perhaps someone can propose a MHI interface change?
> especially since internally to MHI in parse_ev_cfg() we have:
> 	const struct mhi_event_config *event_cfg;
> 	[...]
> 	for (i = 0; i < num; i++) {
> 		event_cfg = &config->event_cfg[i];
>
> so it is treated as const

You submitted a patch for this, thanks for that:

https://lore.kernel.org/all/20220830171147.24338-1-quic_jjohnson@quicinc.com/

But oddly I cannot find anywhere in git, I sent a question about that to
the mhi list.

>> +static struct mhi_channel_config ath12k_mhi_channels_wcn7850[] = {
>
> const

Fixed.

>> +static struct mhi_event_config ath12k_mhi_events_wcn7850[] = {
>
> keep not const (for now) :(

Yup, hopefully we can fix this soon.

>> +struct mhi_controller_config ath12k_mhi_config_wcn7850 = {
>
> and this one should be const since it is registered via:
>
> int mhi_register_controller(struct mhi_controller *mhi_cntrl,
> 			const struct mhi_controller_config *config);

Fixed.

>> +static int ath12k_mhi_get_msi(struct ath12k_pci *ab_pci)
>> +{
>> +	struct ath12k_base *ab = ab_pci->ab;
>> +	u32 user_base_data, base_vector;
>> +	int ret, num_vectors, i;
>> +	int *irq;
>> +
>> +	ret = ath12k_pci_get_user_msi_assignment(ab,
>> +						 "MHI", &num_vectors,
>> +						 &user_base_data, &base_vector);
>> +	if (ret)
>> +		return ret;
>> +
>> + ath12k_dbg(ab, ATH12K_DBG_PCI, "Number of assigned MSI for MHI is
>> %d, base vector is %d\n",
>> +		   num_vectors, base_vector);
>> +
>> +	irq = kcalloc(num_vectors, sizeof(int), GFP_KERNEL);
>
> prefer sizeof(*irq)?

Fixed.

>> +void ath12k_mhi_unregister(struct ath12k_pci *ab_pci)
>> +{
>> +	struct mhi_controller *mhi_ctrl = ab_pci->mhi_ctrl;
>> +
>> +	mhi_unregister_controller(mhi_ctrl);
>> +	kfree(mhi_ctrl->irq);
>> +	mhi_free_controller(mhi_ctrl);
>
> consider setting ab_pci->mhi_ctrl = NULL to avoid dangling pointer?

Fixed.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
