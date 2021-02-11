Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0480318FA5
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 17:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhBKQNz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Feb 2021 11:13:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:34142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231779AbhBKQLn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Feb 2021 11:11:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6650F64E74;
        Thu, 11 Feb 2021 16:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613059861;
        bh=Ngzk1emKiaG36gqqFjTpsGKAhB41lFMoQhZQg55r8+8=;
        h=To:Cc:From:Subject:Date:From;
        b=LRvPec22Wf3X8fvsacAuvjRltL90KnBtbdpa8DAZSFGEqe6Vap/pnOuxeiRz2oXS+
         dXTl4KKM0uvfd49r1QqTcACw8E7GQe2jWqZUGHg1T5AUq8Olm205JRHPFAHqSjqf6A
         D4CG89YLS3Okzd8r5Wj369NdQVqXe2WJMletc+pdeTAuUKynpKgtHu8CAgFFRm3cEK
         4c09+m8Ji5GWBy+k4l5k90a/6af0RbAFNsMLzl71CorzauoUe0As0a0cHL82vOXPCG
         1j5fEKbfY91VGGDIta0UGlqO2yHXpSeJtXJT9hPeeeLPn+tNKm5m+yHGv3dDaRANDK
         4HCCKXeOhnn0g==
To:     Luca Coelho <luciano.coelho@intel.com>
Cc:     linux-wireless@vger.kernel.org
From:   Heiner Kallweit <hkall@kernel.org>
Subject: Today's linux-next iwlwifi broken
Message-ID: <badb5b55-2cfe-8514-b69c-38a4592f07a5@kernel.org>
Date:   Thu, 11 Feb 2021 17:10:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Today's linux-next has a bunch of issues, at least with my AX210 (0024) card.

First I got a GPF in iwl_request_firmware(), cfg->fw_name_pre was invalid.
After some digging into it I found that 6f60fb03c8e7 ("iwlwifi: move SnJ
and So rules to the new tables") removed the entries for some cards.
Obviously 5febcdef3090 and 9b15596c5006 weren't synced with some parallel
development.
After adding the entry for 0024 I now get the following lockdep warning.
Isn't there any regression testing with lockdep enabled?
Also warning "api flags index 2 larger than supported by driver" is still
there, IIRC we talked about this weeks ago.


[    4.561774] iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
[    4.630849] iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-ty-a0-gf-a0-61.ucode failed with error -2
[    4.639817] iwlwifi 0000:01:00.0: api flags index 2 larger than supported by driver
[    4.640062] iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 93.8.73.28
[    4.642138] iwlwifi 0000:01:00.0: loaded firmware version 60.84d9abea.0 ty-a0-gf-a0-60.ucode op_mode iwlmvm
[    4.760541] iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=0x420
[    4.942350] irq/131-iwlwifi/2094 just changed the state of lock:
[    4.942358] ffffa3fc07f080b0 (&rxq->lock){+.-.}-{2:2}, at: iwl_pcie_rx_handle+0x7c/0x8b0 [iwlwifi]
[    4.942504] 1 lock held by irq/131-iwlwifi/2094:
[    4.942511]  #0: ffffa3fc0855c170 (sync_cmd_lockdep_map){+.+.}-{0:0}, at: iwl_pcie_irq_rx_msix_handler+0x47/0x100 [iwlwifi]
[    4.943219]    _iwl_pcie_rx_init+0x208/0x6e0 [iwlwifi]
[    4.943242]    iwl_pcie_gen2_rx_init+0x20/0x30 [iwlwifi]
[    4.943264]    iwl_trans_pcie_gen2_start_fw+0x1e3/0x350 [iwlwifi]
[    4.943289]    iwl_mvm_load_ucode_wait_alive+0xfc/0x440 [iwlmvm]
[    4.943329]    iwl_run_unified_mvm_ucode+0xa5/0x250 [iwlmvm]
[    4.943360]    iwl_run_init_mvm_ucode+0x292/0x370 [iwlmvm]
[    4.943391]    iwl_op_mode_mvm_start+0x7f4/0xb60 [iwlmvm]
[    4.943424]    _iwl_op_mode_start.isra.0+0x42/0x80 [iwlwifi]
[    4.943446]    iwl_opmode_register+0x70/0xe0 [iwlwifi]
[    4.943467]    iwl_mvm_init+0x35/0x1000 [iwlmvm]
[    4.943588]                     _iwl_pcie_rx_init+0x140/0x6e0 [iwlwifi]
[    4.943612]                     iwl_pcie_gen2_rx_init+0x20/0x30 [iwlwifi]
[    4.943635]                     iwl_trans_pcie_gen2_start_fw+0x1e3/0x350 [iwlwifi]
[    4.943662]                     iwl_mvm_load_ucode_wait_alive+0xfc/0x440 [iwlmvm]
[    4.943695]                     iwl_run_unified_mvm_ucode+0xa5/0x250 [iwlmvm]
[    4.943728]                     iwl_run_init_mvm_ucode+0x292/0x370 [iwlmvm]
[    4.943760]                     iwl_op_mode_mvm_start+0x7f4/0xb60 [iwlmvm]
[    4.943793]                     _iwl_op_mode_start.isra.0+0x42/0x80 [iwlwifi]
[    4.943816]                     iwl_opmode_register+0x70/0xe0 [iwlwifi]
[    4.943838]                     iwl_mvm_init+0x35/0x1000 [iwlmvm]
[    4.943954]                     iwl_pcie_rx_handle+0x7c/0x8b0 [iwlwifi]
[    4.943978]                     iwl_pcie_napi_poll_msix+0x2a/0x90 [iwlwifi]
[    4.944063]                     iwl_pcie_irq_rx_msix_handler+0xbc/0x100 [iwlwifi]
[    4.944147]                    _iwl_pcie_rx_init+0x140/0x6e0 [iwlwifi]
[    4.944170]                    iwl_pcie_gen2_rx_init+0x20/0x30 [iwlwifi]
[    4.944194]                    iwl_trans_pcie_gen2_start_fw+0x1e3/0x350 [iwlwifi]
[    4.944220]                    iwl_mvm_load_ucode_wait_alive+0xfc/0x440 [iwlmvm]
[    4.944255]                    iwl_run_unified_mvm_ucode+0xa5/0x250 [iwlmvm]
[    4.944287]                    iwl_run_init_mvm_ucode+0x292/0x370 [iwlmvm]
[    4.944319]                    iwl_op_mode_mvm_start+0x7f4/0xb60 [iwlmvm]
[    4.944352]                    _iwl_op_mode_start.isra.0+0x42/0x80 [iwlwifi]
[    4.944375]                    iwl_opmode_register+0x70/0xe0 [iwlwifi]
[    4.944397]                    iwl_mvm_init+0x35/0x1000 [iwlmvm]
[    4.944493]  ... key      at: [<ffffffffc0c2e0c0>] __key.12+0x0/0xffffffffffff0f40 [iwlwifi]
[    4.944547]    iwl_pcie_rx_handle+0x7c/0x8b0 [iwlwifi]
[    4.944569]    iwl_pcie_napi_poll_msix+0x2a/0x90 [iwlwifi]
[    4.944643]    iwl_pcie_irq_rx_msix_handler+0xbc/0x100 [iwlwifi]
[    4.944705] CPU: 0 PID: 2094 Comm: irq/131-iwlwifi Not tainted 5.11.0-rc7-next-20210211+ #1
[    4.944786]  ? iwl_pcie_rx_handle+0x7c/0x8b0 [iwlwifi]
[    4.944825]  ? iwl_pcie_rx_handle+0x7c/0x8b0 [iwlwifi]
[    4.944847]  iwl_pcie_rx_handle+0x7c/0x8b0 [iwlwifi]
[    4.944878]  iwl_pcie_napi_poll_msix+0x2a/0x90 [iwlwifi]
[    4.944949]  ? iwl_pcie_irq_rx_msix_handler+0xab/0x100 [iwlwifi]
[    4.944981]  iwl_pcie_irq_rx_msix_handler+0xbc/0x100 [iwlwifi]



