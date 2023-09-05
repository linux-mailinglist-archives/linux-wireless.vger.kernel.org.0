Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F92D7927D4
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Sep 2023 18:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbjIEQCU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Sep 2023 12:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354673AbjIEN07 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Sep 2023 09:26:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F9D12A
        for <linux-wireless@vger.kernel.org>; Tue,  5 Sep 2023 06:26:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E65B2608D5
        for <linux-wireless@vger.kernel.org>; Tue,  5 Sep 2023 13:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60620C433C8;
        Tue,  5 Sep 2023 13:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693920415;
        bh=nYwFMATp/Xv5PYiiX2QDNP7K3dchpHCAjLpN24WxQGc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=GQmgTiu6wrrRFXqICJpsFftcxLlb5MXLKyijTpg11pIibfO+inyFyHGGdbFoqmsZy
         FGeABNYmGRK729Ncbh2/0Sgp0GIKlttf7aQTxqb6bTxNNmloNixWNrXRgf/bI01g7F
         Emskw0Z52zdq4T60squ6dHKml7pj8fIYaza0dKrGXPGpZHdpOuzEXv1EDoz7dM1hmn
         1NAQs/2Hz7ufzjOu9EdVa78Dz7qtjPccQU5i63GWkDEzUOeaVM/ch6hPVfAOl6RQxt
         gGMdMbQQKptFo2lnAYfG8ZwbsrYQqvLI2SXBmV2zXaRVY0PxheB6JhBnIHAugMKLSL
         v+80OWF9sjseA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] wifi: ath12k: Ignore fragments from uninitialized
 peer
 in  dp
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230821130343.29495-2-quic_hprem@quicinc.com>
References: <20230821130343.29495-2-quic_hprem@quicinc.com>
To:     Harshitha Prem <quic_hprem@quicinc.com>
Cc:     ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Harshitha Prem <quic_hprem@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169392041226.3610046.3872550352211944428.kvalo@kernel.org>
Date:   Tue,  5 Sep 2023 13:26:54 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Harshitha Prem <quic_hprem@quicinc.com> wrote:

> When max virtual ap interfaces are configured in all the bands with
> ACS and hostapd restart is done every 60s, a crash is observed at
> random times.
> 
> In the above scenario, a fragmented packet is received for self peer,
> for which rx_tid and rx_frags are not initialized in datapath.
> While handling this fragment, crash is observed as the rx_frag list
> is uninitialized and when we walk in ath12k_dp_rx_h_sort_frags,
> skb null leads to exception.
> 
> To address this, before processing received fragments we check
> dp_setup_done flag is set to ensure that peer has completed its
> dp peer setup for fragment queue, else ignore processing the
> fragments.
> 
> Call trace:
>     PC points to "ath12k_dp_process_rx_err+0x4e8/0xfcc [ath12k]"
>     LR points to "ath12k_dp_process_rx_err+0x480/0xfcc [ath12k]".
>     The Backtrace obtained is as follows:
>     ath12k_dp_process_rx_err+0x4e8/0xfcc [ath12k]
>     ath12k_dp_service_srng+0x78/0x260 [ath12k]
>     ath12k_pci_write32+0x990/0xb0c [ath12k]
>     __napi_poll+0x30/0xa4
>     net_rx_action+0x118/0x270
>     __do_softirq+0x10c/0x244
>     irq_exit+0x64/0xb4
>     __handle_domain_irq+0x88/0xac
>     gic_handle_irq+0x74/0xbc
>     el1_irq+0xf0/0x1c0
>     arch_cpu_idle+0x10/0x18
>     do_idle+0x104/0x248
>     cpu_startup_entry+0x20/0x64
>     rest_init+0xd0/0xdc
>     arch_call_rest_init+0xc/0x14
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

bbc86757ca62 wifi: ath12k: Ignore fragments from uninitialized peer in  dp
d48f55e773dc wifi: ath12k: fix undefined behavior with __fls in dp

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230821130343.29495-2-quic_hprem@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

