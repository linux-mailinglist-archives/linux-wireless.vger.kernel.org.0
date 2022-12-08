Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E9464754A
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Dec 2022 19:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiLHSFx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 13:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHSFv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 13:05:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDDE2FBC2
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 10:05:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA3B8B825BF
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 18:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E68BC433D2;
        Thu,  8 Dec 2022 18:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670522748;
        bh=CbhWdDa6UuOwMfhI/T9OOlup8bU3/ProUo82bONAmYc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=cNTa8FqkJPlXJ4gLzLL4TvqUIydmeB8aJ38/olddUcJCecYP6bE5znCMCbx3L9+Wv
         nvDawSWJIAbWQvIViaABdFZhMFojvOqVcot4sjqpb0l2Qt1Rou8MXDUcUq1AAdENDw
         1Bvi3c682EXcRV0rUh5FTUqE40giwfOvIxBS6xd7t1LbQ2X8dZfVjLiNen4u8BKJrA
         xiI0K547B2iUdLIDd0YgeS9+cCoGTcAnFW9dFD2kgMAw8yTJV0HeO1IFJPKaOfaL/n
         RdujKsL0gw4A3a5RsPV7BNMkwiYxI3RoPwUTSRvHSqXf9Icj46rxhFueeCLybYvqVH
         bFBlCabQ/xlXg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi:ath11k: fix monitor mode bringup crash
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221129142532.23421-1-quic_nmaran@quicinc.com>
References: <20221129142532.23421-1-quic_nmaran@quicinc.com>
To:     Nagarajan Maran <quic_nmaran@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Nagarajan Maran <quic_nmaran@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167052274389.20906.12708398332244220304.kvalo@kernel.org>
Date:   Thu,  8 Dec 2022 18:05:47 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nagarajan Maran <quic_nmaran@quicinc.com> wrote:

> When the interface is brought up in monitor mode, it leads
> to NULL pointer dereference crash. This crash happens when
> the packet type is extracted for a SKB. This extraction
> which is present in the received msdu delivery path,is
> not needed for the monitor ring packets since they are
> all RAW packets. Hence appending the flags with
> "RX_FLAG_ONLY_MONITOR" to skip that extraction.
> 
> Observed calltrace:
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000064
> Mem abort info:
>   ESR = 0x0000000096000004
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x04: level 0 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000004
>   CM = 0, WnR = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=0000000048517000
> [0000000000000064] pgd=0000000000000000, p4d=0000000000000000
> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> Modules linked in: ath11k_pci ath11k qmi_helpers
> CPU: 2 PID: 1781 Comm: napi/-271 Not tainted
> 6.1.0-rc5-wt-ath-656295-gef907406320c-dirty #6
> Hardware name: Qualcomm Technologies, Inc. IPQ8074/AP-HK10-C2 (DT)
> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : ath11k_hw_qcn9074_rx_desc_get_decap_type+0x34/0x60 [ath11k]
> lr : ath11k_hw_qcn9074_rx_desc_get_decap_type+0x5c/0x60 [ath11k]
> sp : ffff80000ef5bb10
> x29: ffff80000ef5bb10 x28: 0000000000000000 x27: ffff000007baafa0
> x26: ffff000014a91ed0 x25: 0000000000000000 x24: 0000000000000000
> x23: ffff800002b77378 x22: ffff000014a91ec0 x21: ffff000006c8d600
> x20: 0000000000000000 x19: ffff800002b77740 x18: 0000000000000006
> x17: 736564203634343a x16: 656e694c20657079 x15: 0000000000000143
> x14: 00000000ffffffea x13: ffff80000ef5b8b8 x12: ffff80000ef5b8c8
> x11: ffff80000a591d30 x10: ffff80000a579d40 x9 : c0000000ffffefff
> x8 : 0000000000000003 x7 : 0000000000017fe8 x6 : ffff80000a579ce8
> x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> x2 : 3a35ec12ed7f8900 x1 : 0000000000000000 x0 : 0000000000000052
> Call trace:
>  ath11k_hw_qcn9074_rx_desc_get_decap_type+0x34/0x60 [ath11k]
>  ath11k_dp_rx_deliver_msdu.isra.42+0xa4/0x3d0 [ath11k]
>  ath11k_dp_rx_mon_deliver.isra.43+0x2f8/0x458 [ath11k]
>  ath11k_dp_rx_process_mon_rings+0x310/0x4c0 [ath11k]
>  ath11k_dp_service_srng+0x234/0x338 [ath11k]
>  ath11k_pcic_ext_grp_napi_poll+0x30/0xb8 [ath11k]
>  __napi_poll+0x5c/0x190
>  napi_threaded_poll+0xf0/0x118
>  kthread+0xf4/0x110
>  ret_from_fork+0x10/0x20
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Reported-by: Florian Schmidt <florian@fls.name>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216573
> Signed-off-by: Nagarajan Maran <quic_nmaran@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

950b43f8bd8a wifi: ath11k: fix monitor mode bringup crash

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221129142532.23421-1-quic_nmaran@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

