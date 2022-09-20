Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94FC5BE0A4
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 10:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiITIrL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 04:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiITIq5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 04:46:57 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54862371BD
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 01:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=i8HxRndOoMhka4vewDE1iax5QIELaQBczsCp0RIanDA=; b=m/2FyiyeQuIJGx1lwkinWCefLb
        FHCWNqCSroNsntiUyKolRen1gJfoYC/3gKe3qTirTMw8qvBsUbeWST5gBj1jxGSp6LrLz6Sb38HOC
        4kDjkCIZiYlGUvy+upowdm2+NBwT0/omHmzJhOXVM847HNqIFcS3kfWYznqnkOmfPW5k=;
Received: from p200300daa7301d00c12bff90dd0eb021.dip0.t-ipconnect.de ([2003:da:a730:1d00:c12b:ff90:dd0e:b021] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1oaYu4-006GFf-KC; Tue, 20 Sep 2022 10:46:52 +0200
Message-ID: <4d6953a0-e165-b203-7a41-afe62205b573@nbd.name>
Date:   Tue, 20 Sep 2022 10:46:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] mac80211: fix memory corruption in
 minstrel_ht_update_rates()
Content-Language: en-US
To:     Lech Perczak <lech.perczak@camlingroup.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        =?UTF-8?Q?Pawe=c5=82_Lenkow?= <pawel.lenkow@camlingroup.com>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        Peter Seiderer <ps.report@gmx.net>,
        Kalle Valo <kvalo@kernel.org>,
        =?UTF-8?Q?Krzysztof_Drobi=c5=84ski?= 
        <krzysztof.drobinski@camlingroup.com>
References: <20220919150135.90785-1-lech.perczak@camlingroup.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <20220919150135.90785-1-lech.perczak@camlingroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 19.09.22 17:01, Lech Perczak wrote:
> From: Paweł Lenkow <pawel.lenkow@camlingroup.com>
> 
> During our testing of WFM200 module over SDIO on i.MX6Q-based platform,
> we discovered a memory corruption on the system, tracing back to the wfx
> driver. Using kfence, it was possible to trace it back to the root
> cause, which is hw->max_rates set to 8 in wfx_init_common,
> while the maximum defined by IEEE80211_TX_TABLE_SIZE is 4.
> 
> This causes array out-of-bounds writes during updates of the rate table,
> as seen below:
> 
> BUG: KFENCE: memory corruption in kfree_rcu_work+0x320/0x36c
> 
> Corrupted memory at 0xe0a4ffe0 [ 0x03 0x03 0x03 0x03 0x01 0x00 0x00
> 0x02 0x02 0x02 0x09 0x00 0x21 0xbb 0xbb 0xbb ] (in kfence-#81):
> kfree_rcu_work+0x320/0x36c
> process_one_work+0x3ec/0x920
> worker_thread+0x60/0x7a4
> kthread+0x174/0x1b4
> ret_from_fork+0x14/0x2c
> 0x0
> 
> kfence-#81: 0xe0a4ffc0-0xe0a4ffdf, size=32, cache=kmalloc-64
> 
> allocated by task 297 on cpu 0 at 631.039555s:
> minstrel_ht_update_rates+0x38/0x2b0 [mac80211]
> rate_control_tx_status+0xb4/0x148 [mac80211]
> ieee80211_tx_status_ext+0x364/0x1030 [mac80211]
> ieee80211_tx_status+0xe0/0x118 [mac80211]
> ieee80211_tasklet_handler+0xb0/0xe0 [mac80211]
> tasklet_action_common.constprop.0+0x11c/0x148
> __do_softirq+0x1a4/0x61c
> irq_exit+0xcc/0x104
> call_with_stack+0x18/0x20
> __irq_svc+0x80/0xb0
> wq_worker_sleeping+0x10/0x100
> wq_worker_sleeping+0x10/0x100
> schedule+0x50/0xe0
> schedule_timeout+0x2e0/0x474
> wait_for_completion+0xdc/0x1ec
> mmc_wait_for_req_done+0xc4/0xf8
> mmc_io_rw_extended+0x3b4/0x4ec
> sdio_io_rw_ext_helper+0x290/0x384
> sdio_memcpy_toio+0x30/0x38
> wfx_sdio_copy_to_io+0x88/0x108 [wfx]
> wfx_data_write+0x88/0x1f0 [wfx]
> bh_work+0x1c8/0xcc0 [wfx]
> process_one_work+0x3ec/0x920
> worker_thread+0x60/0x7a4
> kthread+0x174/0x1b4
> ret_from_fork+0x14/0x2c 0x0
> 
> After discussion on the wireless mailing list it was clarified
> that the issue has been introduced by:
> commit ee0e16ab756a ("mac80211: minstrel_ht: fill all requested rates")
> and fix shall be in minstrel_ht_update_rates in rc80211_minstrel_ht.c.
> 
> Fixes: ee0e16ab756a ("mac80211: minstrel_ht: fill all requested rates")
> Link: https://lore.kernel.org/all/12e5adcd-8aed-f0f7-70cc-4fb7b656b829@camlingroup.com/
> Link: https://lore.kernel.org/linux-wireless/20220915131445.30600-1-lech.perczak@camlingroup.com/
> Cc: Jérôme Pouiller <jerome.pouiller@silabs.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Peter Seiderer <ps.report@gmx.net>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Krzysztof Drobiński <krzysztof.drobinski@camlingroup.com>,
> Signed-off-by: Paweł Lenkow <pawel.lenkow@camlingroup.com>
> Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>

Acked-by: Felix Fietkau <nbd@nbd.name>

Thanks,

- Felix
