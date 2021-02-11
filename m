Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDD2319546
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 22:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBKVm1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Feb 2021 16:42:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhBKVm1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Feb 2021 16:42:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 613D86186A;
        Thu, 11 Feb 2021 21:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613079705;
        bh=aU0WQFKgZ7qFFXrEI7PNdC/5P8ugCuwovTQGDn0C3yo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=l/opHI+0il9KzglD6uVpi0uFpIXnysoqVYvkfGbRYzH4V1zgBRYWbNJfnV7Lk3eQ8
         OxW89569gYWUFyF8n4Kjnf6490g7jYXRM/fyA4cBem0m4r9o8tZcnn/l3M7qPTQQca
         9NBjLpiyw1IQzUO2qdMlve66b0+bq0GdoUqlXf3wEvgV21JuQIjyhhUnc/dJ3MSHpJ
         qea+dlVjMimOJOUN0HMHvkCbs3xe6DcbrdaZssX3xYcgvcnvEVtWaRkCHAF5j4yEDi
         ObJQE1SzMxo6Zj03npr3egbrequS6qXXLzqObq+8bxKCuD/+KxZMoHp38RBqcL9Rv9
         5EPI/hyxFVDSg==
Subject: Re: Today's linux-next iwlwifi broken
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
References: <badb5b55-2cfe-8514-b69c-38a4592f07a5@kernel.org>
 <582d5521f31a49e3518d15811ca7d5a79837a70e.camel@coelho.fi>
From:   Heiner Kallweit <hkall@kernel.org>
Message-ID: <633c6919-5f3f-9b7c-8f21-2682f8c69ccd@kernel.org>
Date:   Thu, 11 Feb 2021 22:41:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <582d5521f31a49e3518d15811ca7d5a79837a70e.camel@coelho.fi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11.02.2021 21:23, Luca Coelho wrote:
> On Thu, 2021-02-11 at 17:10 +0100, Heiner Kallweit wrote:
>> Today's linux-next has a bunch of issues, at least with my AX210 (0024) card.
>>
>> First I got a GPF in iwl_request_firmware(), cfg->fw_name_pre was invalid.
>> After some digging into it I found that 6f60fb03c8e7 ("iwlwifi: move SnJ
>> and So rules to the new tables") removed the entries for some cards.
>> Obviously 5febcdef3090 and 9b15596c5006 weren't synced with some parallel
>> development.
>> After adding the entry for 0024 I now get the following lockdep warning.
>> Isn't there any regression testing with lockdep enabled?
>> Also warning "api flags index 2 larger than supported by driver" is still
>> there, IIRC we talked about this weeks ago.
>>
>>
>> [    4.561774] iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
>> [    4.630849] iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-ty-a0-gf-a0-61.ucode failed with error -2
>> [    4.639817] iwlwifi 0000:01:00.0: api flags index 2 larger than supported by driver
>> [    4.640062] iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 93.8.73.28
>> [    4.642138] iwlwifi 0000:01:00.0: loaded firmware version 60.84d9abea.0 ty-a0-gf-a0-60.ucode op_mode iwlmvm
>> [    4.760541] iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=0x420
>> [    4.942350] irq/131-iwlwifi/2094 just changed the state of lock:
>> [    4.942358] ffffa3fc07f080b0 (&rxq->lock){+.-.}-{2:2}, at: iwl_pcie_rx_handle+0x7c/0x8b0 [iwlwifi]
>> [    4.942504] 1 lock held by irq/131-iwlwifi/2094:
>> [    4.942511]  #0: ffffa3fc0855c170 (sync_cmd_lockdep_map){+.+.}-{0:0}, at: iwl_pcie_irq_rx_msix_handler+0x47/0x100 [iwlwifi]
>> [    4.943219]    _iwl_pcie_rx_init+0x208/0x6e0 [iwlwifi]
>> [    4.943242]    iwl_pcie_gen2_rx_init+0x20/0x30 [iwlwifi]
>> [    4.943264]    iwl_trans_pcie_gen2_start_fw+0x1e3/0x350 [iwlwifi]
>> [    4.943289]    iwl_mvm_load_ucode_wait_alive+0xfc/0x440 [iwlmvm]
>> [    4.943329]    iwl_run_unified_mvm_ucode+0xa5/0x250 [iwlmvm]
>> [    4.943360]    iwl_run_init_mvm_ucode+0x292/0x370 [iwlmvm]
>> [    4.943391]    iwl_op_mode_mvm_start+0x7f4/0xb60 [iwlmvm]
>> [    4.943424]    _iwl_op_mode_start.isra.0+0x42/0x80 [iwlwifi]
>> [    4.943446]    iwl_opmode_register+0x70/0xe0 [iwlwifi]
>> [    4.943467]    iwl_mvm_init+0x35/0x1000 [iwlmvm]
>> [    4.943588]                     _iwl_pcie_rx_init+0x140/0x6e0 [iwlwifi]
>> [    4.943612]                     iwl_pcie_gen2_rx_init+0x20/0x30 [iwlwifi]
>> [    4.943635]                     iwl_trans_pcie_gen2_start_fw+0x1e3/0x350 [iwlwifi]
>> [    4.943662]                     iwl_mvm_load_ucode_wait_alive+0xfc/0x440 [iwlmvm]
>> [    4.943695]                     iwl_run_unified_mvm_ucode+0xa5/0x250 [iwlmvm]
>> [    4.943728]                     iwl_run_init_mvm_ucode+0x292/0x370 [iwlmvm]
>> [    4.943760]                     iwl_op_mode_mvm_start+0x7f4/0xb60 [iwlmvm]
>> [    4.943793]                     _iwl_op_mode_start.isra.0+0x42/0x80 [iwlwifi]
>> [    4.943816]                     iwl_opmode_register+0x70/0xe0 [iwlwifi]
>> [    4.943838]                     iwl_mvm_init+0x35/0x1000 [iwlmvm]
>> [    4.943954]                     iwl_pcie_rx_handle+0x7c/0x8b0 [iwlwifi]
>> [    4.943978]                     iwl_pcie_napi_poll_msix+0x2a/0x90 [iwlwifi]
>> [    4.944063]                     iwl_pcie_irq_rx_msix_handler+0xbc/0x100 [iwlwifi]
>> [    4.944147]                    _iwl_pcie_rx_init+0x140/0x6e0 [iwlwifi]
>> [    4.944170]                    iwl_pcie_gen2_rx_init+0x20/0x30 [iwlwifi]
>> [    4.944194]                    iwl_trans_pcie_gen2_start_fw+0x1e3/0x350 [iwlwifi]
>> [    4.944220]                    iwl_mvm_load_ucode_wait_alive+0xfc/0x440 [iwlmvm]
>> [    4.944255]                    iwl_run_unified_mvm_ucode+0xa5/0x250 [iwlmvm]
>> [    4.944287]                    iwl_run_init_mvm_ucode+0x292/0x370 [iwlmvm]
>> [    4.944319]                    iwl_op_mode_mvm_start+0x7f4/0xb60 [iwlmvm]
>> [    4.944352]                    _iwl_op_mode_start.isra.0+0x42/0x80 [iwlwifi]
>> [    4.944375]                    iwl_opmode_register+0x70/0xe0 [iwlwifi]
>> [    4.944397]                    iwl_mvm_init+0x35/0x1000 [iwlmvm]
>> [    4.944493]  ... key      at: [<ffffffffc0c2e0c0>] __key.12+0x0/0xffffffffffff0f40 [iwlwifi]
>> [    4.944547]    iwl_pcie_rx_handle+0x7c/0x8b0 [iwlwifi]
>> [    4.944569]    iwl_pcie_napi_poll_msix+0x2a/0x90 [iwlwifi]
>> [    4.944643]    iwl_pcie_irq_rx_msix_handler+0xbc/0x100 [iwlwifi]
>> [    4.944705] CPU: 0 PID: 2094 Comm: irq/131-iwlwifi Not tainted 5.11.0-rc7-next-20210211+ #1
>> [    4.944786]  ? iwl_pcie_rx_handle+0x7c/0x8b0 [iwlwifi]
>> [    4.944825]  ? iwl_pcie_rx_handle+0x7c/0x8b0 [iwlwifi]
>> [    4.944847]  iwl_pcie_rx_handle+0x7c/0x8b0 [iwlwifi]
>> [    4.944878]  iwl_pcie_napi_poll_msix+0x2a/0x90 [iwlwifi]
>> [    4.944949]  ? iwl_pcie_irq_rx_msix_handler+0xab/0x100 [iwlwifi]
>> [    4.944981]  iwl_pcie_irq_rx_msix_handler+0xbc/0x100 [iwlwifi]
> 
> Thanks for reporting!
> 
> We made a bunch of fixes in this area and Kalle just pulled them to
> wireless-drivers-next.  I believe these changes will be in tomorrow's
> linux-next.  Can you retry it then?
> 

Thanks, I'll re-test tomorrow and let you know.

> --
> Cheers,
> Luca.
> 
Heiner
