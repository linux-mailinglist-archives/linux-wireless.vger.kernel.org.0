Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E5D6E4532
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 12:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjDQKaH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 06:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjDQK3m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 06:29:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115337AB3
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 03:28:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C20B661B65
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 10:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB38C433D2;
        Mon, 17 Apr 2023 10:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681727331;
        bh=3Iz5JePtM9cvykU/DcFaEXo6Tdj+TUSbHIg+gJXgJtM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=jSRVAnegX0WNeUdqlH1s5pwjPZYfZg4DuSQXPevNIV0N/2vrliryZAJ3fPeKSKTd3
         lX3pKD2hJbO9kK6Naugv6xidXxYNIHLIhU2ZpmYdQcD1XOWmOdeehw8PHfcsmJmEgZ
         wkM2i8FBHN3nJIcSUfAVVgDV1QD+JXqW2MZYGi+zrCMSqO/+LIQ3Y5XHITpjMgnRLB
         fKaUszztHQ/ZgEuMLAU/4bleKVRA0MaVl3gjpBtL3/c6cN/vMH/nckOS329RHxIAJD
         5wHI4kjZsjhEkou4u/zAqFMo+mIHbLpBk3lQfLfDwjLLViX+XADh8aeg7veKOE2AFl
         L5inedWQjnXpw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath11k: Ignore frags from uninitialized peer in
 dp.
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230403184155.8670-2-quic_nmaran@quicinc.com>
References: <20230403184155.8670-2-quic_nmaran@quicinc.com>
To:     Nagarajan Maran <quic_nmaran@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Nagarajan Maran <quic_nmaran@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168172732519.21228.13363006785669066948.kvalo@kernel.org>
Date:   Mon, 17 Apr 2023 10:28:49 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nagarajan Maran <quic_nmaran@quicinc.com> wrote:

> When max virtual ap interfaces are configured in all the bands with
> ACS and hostapd restart is done every 60s, a crash is observed at
> random times.
> In this certain scenario, a fragmented packet is received for
> self peer, for which rx_tid and rx_frags are not initialized in
> datapath. While handling this fragment, crash is observed as the
> rx_frag list is uninitialised and when we walk in
> ath11k_dp_rx_h_sort_frags, skb null leads to exception.
> 
> To address this, before processing received fragments we check
> dp_setup_done flag is set to ensure that peer has completed its
> dp peer setup for fragment queue, else ignore processing the
> fragments.
> 
> Call trace:
>   ath11k_dp_process_rx_err+0x550/0x1084 [ath11k]
>   ath11k_dp_service_srng+0x70/0x370 [ath11k]
>   0xffffffc009693a04
>   __napi_poll+0x30/0xa4
>   net_rx_action+0x118/0x270
>   __do_softirq+0x10c/0x244
>   irq_exit+0x64/0xb4
>   __handle_domain_irq+0x88/0xac
>   gic_handle_irq+0x74/0xbc
>   el1_irq+0xf0/0x1c0
>   arch_cpu_idle+0x10/0x18
>   do_idle+0x104/0x248
>   cpu_startup_entry+0x20/0x64
>   rest_init+0xd0/0xdc
>   arch_call_rest_init+0xc/0x14
>   start_kernel+0x480/0x4b8
>   Code: f9400281 f94066a2 91405021 b94a0023 (f9406401)
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Nagarajan Maran <quic_nmaran@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

a06bfb3c9f69 wifi: ath11k: Ignore frags from uninitialized peer in dp.
41e02bf4ae32 wifi: ath11k: fix undefined behavior with __fls in dp

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230403184155.8670-2-quic_nmaran@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

