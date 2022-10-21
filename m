Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCDE607598
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 13:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJULGJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 07:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJULGI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 07:06:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9091A912F
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 04:06:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60A3161E53
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 11:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED006C433C1;
        Fri, 21 Oct 2022 11:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666350366;
        bh=ebUuPGXHDB+aLlvbvnYmLslvYd81HjfRuExzEtiuybo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mtaOSrxZDRT7HeZuhzA/V8I0q9VnDOjprbTMDQw/wVmzqnxCyywcwLM82cV9nzmNh
         AAQWHYQLYd2cZ7c7FCgO5Q+OOuXOBpNALs1Di1CSva7Z0Duu0I4Ma66tZorXhipnrJ
         dekcfBMg+p/8tbCzpovMtQIOcMuTfQl3QFVKbBd/RbTXMM3KsHLn57uIQKBSHsjUUd
         4KHIi9qHOlI2rpRqapGuXiBx0hYtQ1wyVcfR3IO+J1onNQgTsDzBkxwd2DBNyHNkoH
         6VxivgXtvIZXSmhLq+PZRP3zCuCZy8ij/XSJw/UQzo07A3TP556NElCRQ4LvhPyhG5
         O4mcUcUh2pHBg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
Subject: Re: [PATCH 07/50] wifi: ath12k: add dbring.c
References: <20220812161003.27279-1-kvalo@kernel.org>
        <20220812161003.27279-8-kvalo@kernel.org>
        <d9403714-d7ef-3a7c-0448-e5b2b0a60c34@quicinc.com>
Date:   Fri, 21 Oct 2022 14:06:04 +0300
In-Reply-To: <d9403714-d7ef-3a7c-0448-e5b2b0a60c34@quicinc.com> (Jeff
        Johnson's message of "Mon, 15 Aug 2022 12:55:57 -0700")
Message-ID: <87v8odjv1f.fsf@kernel.org>
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
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>
>> (Patches split into one patch per file for easier review, but the final
>> commit will be one big patch. See the cover letter for more info.)
>>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

[...]

>> +static int ath12k_dbring_fill_bufs(struct ath12k *ar,
>> +				   struct ath12k_dbring *ring,
>> +				   gfp_t gfp)
>> +{
>> +	struct ath12k_dbring_element *buff;
>> +	struct hal_srng *srng;
>> +	int num_remain, req_entries, num_free;
>> +	u32 align;
>> +	int size, ret;
>> +
>> +	srng = &ar->ab->hal.srng_list[ring->refill_srng.ring_id];
>
> there are several references to ar->ab in this function.
> suggest being consistent with ath12k_dbring_bufs_replenish() and define:
> 	struct ath12k_base *ab = ar->ab;
> and then s/ar->ab/ab/ in those accesses
>
> this suggestion applies to other functions below since there are
> multiple functions which have multiple ar->ab dereferences

Praneesh fixed this:

c568d8bc26de ath12k: convert payload[0] to payload[], use ab variable and fix __ath12k_dbg() signature


>> +int ath12k_dbring_buf_setup(struct ath12k *ar,
>> +			    struct ath12k_dbring *ring,
>> +			    struct ath12k_dbring_cap *db_cap)
>> +{
>> +	struct ath12k_base *ab = ar->ab;
>> +	struct hal_srng *srng;
>> +	int ret;
>> +
>> +	srng = &ab->hal.srng_list[ring->refill_srng.ring_id];
>> +	ring->bufs_max = ring->refill_srng.size /
>> +		ath12k_hal_srng_get_entrysize(ab, HAL_RXDMA_DIR_BUF);
>> +
>> +	ring->buf_sz = db_cap->min_buf_sz;
>> +	ring->buf_align = db_cap->min_buf_align;
>> +	ring->pdev_id = db_cap->pdev_id;
>> +	ring->hp_addr = ath12k_hal_srng_get_hp_addr(ar->ab, srng);
>> +	ring->tp_addr = ath12k_hal_srng_get_tp_addr(ar->ab, srng);
>
> s/ar->ab/ab/ in both of the above since you already have ab = ar->ab

This is still not fixed.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
