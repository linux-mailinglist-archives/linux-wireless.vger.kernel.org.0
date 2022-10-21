Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9223F60766E
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 13:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiJULph (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 07:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiJULpg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 07:45:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755B0119BF6
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 04:45:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31F89B82A2D
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 11:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFA6C433D6;
        Fri, 21 Oct 2022 11:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666352732;
        bh=jEOgSwQYCD+gxiCJMxt436mAcZyHcOjM4AZn3LcQ+Vc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TyvPBM/avix8g4eP5sAjjJIR6HWquANhsUBQ+0uUcAgSvSeuz85ak8tGCOTX4NTaq
         V6L+vYNFUIABkjCmYzP0YAepJe4EKHTetuwujyzFxZ7t8Ko1i5FBcUDQf6uCxzTkye
         W3QhgPPAyNnWpMkdz8C4eskWhH/4wugAL5Ez2RgyKFeHSeRwPwKN0pkNXhw5G3pjE4
         NwmFmUed9uNnBbHcDeJtE/McqE9KZI3Nfdteg1gibgEo9jyZzIYZJz4fGpEmwhMEKb
         m8Mz/4m0XzUlzS8hafR4MwPPYkytsPqojt6sHqYQlmwqU+Bcu/TpfLoU4pHfc5jKGf
         hqncKmj2R1eLQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath12k\@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: Re: [PATCH 12/50] wifi: ath12k: add dp.h
References: <20220812161003.27279-1-kvalo@kernel.org>
        <20220812161003.27279-13-kvalo@kernel.org>
        <0eabd6c1b3ca4d8a8152ad5b4f3efee6@realtek.com>
        <87leqxag07.fsf@kernel.org>
Date:   Fri, 21 Oct 2022 14:45:30 +0300
In-Reply-To: <87leqxag07.fsf@kernel.org> (Kalle Valo's message of "Mon, 05 Sep
        2022 20:27:20 +0300")
Message-ID: <878rl9jt7p.fsf@kernel.org>
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

>>> +struct htt_srng_setup_cmd {
>>> +	u32 info0;
>>> +	u32 ring_base_addr_lo;
>>> +	u32 ring_base_addr_hi;
>>> +	u32 info1;
>>> +	u32 ring_head_off32_remote_addr_lo;
>>> +	u32 ring_head_off32_remote_addr_hi;
>>> +	u32 ring_tail_off32_remote_addr_lo;
>>> +	u32 ring_tail_off32_remote_addr_hi;
>>> +	u32 ring_msi_addr_lo;
>>> +	u32 ring_msi_addr_hi;
>>> +	u32 msi_data;
>>> +	u32 intr_info;
>>> +	u32 info2;
>>> +} __packed;
>>> +
>>
>> Should they be '__le32' instead of 'u32'?
>>
>> This struct is used to fill data of ath12k_htc_send(), and the fields of
>> htc header are __le32: 
>>
>> struct ath12k_htc_hdr {
>> 	__le32 htc_info;
>> 	__le32 ctrl_info;
>> } __packed __aligned(4);
>>
>> If above is correct, some struct(s) related to ath12k_htc_send() have
>> similar problems:
>> struct htt_ver_req_cmd
>> struct htt_ppdu_stats_cfg_cmd
>> struct htt_rx_ring_selection_cfg_cmd
>> struct htt_ext_stats_cfg_cmd
>> struct htt_tx_ring_selection_cfg_cmd  (miss __packed)
>
> Good catch, we'll fix those and the missing __packed. Thanks for the review!

I fixed these in:

efc72b2aa34c wifi: ath12k: dp: convert htt cmd structs to __le32

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
