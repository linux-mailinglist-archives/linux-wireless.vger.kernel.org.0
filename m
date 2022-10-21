Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D506075F2
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 13:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiJULTL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 07:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiJULS6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 07:18:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66546261086
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 04:18:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8923B82A05
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 11:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2C6C433D7;
        Fri, 21 Oct 2022 11:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666351132;
        bh=3ChRpt1xyFjKJVHC5jnaDEZiz50ObF+BIKimx31ihV8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=rMsfyNxURen6SpN37CZF454omBkEDH8/h2gG67o55Ej1+E/BHmkE7nMV1qciQIaBz
         f9fdISqF+CrQCBXu5zH8Tbru/wUyD9Rzjmg0tRoI52jy9fl4HkJ4Ti0bO3J7cCWCFQ
         xL6C+tPp9gXHg6mbof5nh6hrZkrGOEocL6vMpd2DFudAYnnEz23M+S3okBjoXzW+y7
         6jj9rmoLAPH0DpgxzkNXK0mGh9KMxlIlN6e+J44rjY6IU9gUv44F4fSg9Omo0RiA44
         9BHvGlq7QCqvSWXc9rHvwdjr+MkCy1l6YWJ21dWCrcxgbFguLxA0FEqMqB7sM3qdco
         L1z3yw9B2/Upw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
Subject: Re: [PATCH 10/50] wifi: ath12k: add debug.h
References: <20220812161003.27279-1-kvalo@kernel.org>
        <20220812161003.27279-11-kvalo@kernel.org>
        <8b456221-07aa-2620-784f-ae44ed2aa431@quicinc.com>
Date:   Fri, 21 Oct 2022 14:18:49 +0300
In-Reply-To: <8b456221-07aa-2620-784f-ae44ed2aa431@quicinc.com> (Jeff
        Johnson's message of "Mon, 15 Aug 2022 13:11:21 -0700")
Message-ID: <87ilkdjug6.fsf@kernel.org>
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

[...]

>> +enum ath12k_debug_mask {
>> +	ATH12K_DBG_AHB		= 0x00000001,
>> +	ATH12K_DBG_WMI		= 0x00000002,
>> +	ATH12K_DBG_HTC		= 0x00000004,
>> +	ATH12K_DBG_DP_HTT	= 0x00000008,
>> +	ATH12K_DBG_MAC		= 0x00000010,
>> +	ATH12K_DBG_BOOT		= 0x00000020,
>> +	ATH12K_DBG_QMI		= 0x00000040,
>> +	ATH12K_DBG_DATA		= 0x00000080,
>> +	ATH12K_DBG_MGMT		= 0x00000100,
>> +	ATH12K_DBG_REG		= 0x00000200,
>> +	ATH12K_DBG_TESTMODE	= 0x00000400,
>> +	ATH12K_DBG_HAL		= 0x00000800,
>> +	ATH12K_DBG_PCI		= 0x00001000,
>> +	ATH12K_DBG_DP_TX	= 0x00001000,
>
> duplicate assignments above

Praneesh fixed this:

c8bd8aa45f6a ath12k: fix ATH12K_DBG_DP_TX value in ath12k_debug_mask

> would using BIT() help here?
> or does having the hex masks make it easier for folks generating the
> masks

Back in the early ath10k days these enums were actually usign BIT() but
someone suggested to switch using hex numbers directly, just because
it's faster to calculate the debug mask. And I have to agree with that,
it's a lot easier when these are in hex.

>> +#ifdef CONFIG_ATH12K_DEBUG
>> +__printf(3, 4) void __ath12k_dbg(struct ath12k_base *ab,
>> +				 enum ath12k_debug_mask mask,
>> +				 const char *fmt, ...);
>> +void ath12k_dbg_dump(struct ath12k_base *ab,
>> +		     enum ath12k_debug_mask mask,
>> +		     const char *msg, const char *prefix,
>> +		     const void *buf, size_t len);
>> +#else /* CONFIG_ATH12K_DEBUG */
>> +static inline int __ath12k_dbg(struct ath12k_base *ab,
>
> should be a void function with an empty body to match the signature of
> the real function

Praneesh fixed in:

c568d8bc26de ath12k: convert payload[0] to payload[], use ab variable and fix __ath12k_dbg() signature

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
