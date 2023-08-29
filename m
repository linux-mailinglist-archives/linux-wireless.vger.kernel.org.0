Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32C778BE4B
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Aug 2023 08:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjH2GMg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Aug 2023 02:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjH2GMY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Aug 2023 02:12:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B3A123
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 23:12:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B6556136C
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 06:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E19CC433C7;
        Tue, 29 Aug 2023 06:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693289538;
        bh=A2jHdFfbPCRG4k58lDHbnJpWRYiyziscU2utDXup6Gk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=MqtkYE/KBd2Ql7dqXQ7WceT/RX35n1zePWtPuz+i6bmXXkyNLKi+/VaZXMv7/NKc1
         Il6sdaqooN0l5qOBuEChbvsYI0LPR4ZteQLsQYdXw5LUqSYX5GiulftXUTryTyt+Jr
         qkM/HUdcwld3mrn3ZoBL2HjwmZWQ6t66L+lHl8ML4I3kb0qQPe8Kpenbc4Leg3mlgv
         NDMfYy6exzYofTU+A0g8q+Tcot0ZSjoDeu8a6Sh5M1l9LDVIsXzWWR6AWC7NtB9HnG
         dq45TuqrTItd6kNSkOnWWh+i/IE+GiHO8vZW/d37iPD06jMpo+5hh386FdjuBi3pHe
         HxzLu4tbrIJHw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        daniel@makrotopia.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH wireless] mt76: fix lock dependency problem for wed_lock
References: <ee80be41c2a8d8749d83c6950a272a5e77aadd45.1693228333.git.lorenzo@kernel.org>
Date:   Tue, 29 Aug 2023 09:13:27 +0300
In-Reply-To: <ee80be41c2a8d8749d83c6950a272a5e77aadd45.1693228333.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Mon, 28 Aug 2023 15:16:11 +0200")
Message-ID: <873502v0jc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Fix the following kernel depency lock holding wed_lock with BH disabled.
>
> [   40.579696] mt798x-wmac 18000000.wifi: attaching wed device 0 version 2
> [   40.604648] platform 15010000.wed: MTK WED WO Firmware Version: DEV_000000, Build Time: 20221208202138
> [   40.613972] platform 15010000.wed: MTK WED WO Chip ID 00 Region 3
> [   40.943617]
> [   40.945118] ========================================================
> [   40.951457] WARNING: possible irq lock inversion dependency detected
> [   40.957797] 5.15.127 #0 Not tainted
> [   40.961276] --------------------------------------------------------
> [   40.967614] insmod/2329 just changed the state of lock:
> [   40.972827] ffffff8004003b08 (&dev->wed_lock){+.+.}-{2:2}, at: mt76_get_rxwi+0x1c/0xac [mt76]
> [   40.981387] but this lock was taken by another, SOFTIRQ-safe lock in the past:
> [   40.988592]  (&q->lock){+.-.}-{2:2}
> [   40.988602]
> [   40.988602]
> [   40.988602] and interrupts could create inverse lock ordering between them.
> [   40.988602]
> [   41.003445]
> [   41.003445] other info that might help us debug this:
> [   41.009957]  Possible interrupt unsafe locking scenario:
> [   41.009957]
> [   41.016729]        CPU0                    CPU1
> [   41.021245]        ----                    ----
> [   41.025761]   lock(&dev->wed_lock);
> [   41.029241]                                local_irq_disable();
> [   41.035145]                                lock(&q->lock);
> [   41.040620]                                lock(&dev->wed_lock);
> [   41.046616]   <Interrupt>
> [   41.049223]     lock(&q->lock);
> [   41.052356]
> [   41.052356]  *** DEADLOCK ***
> [   41.052356]
> [   41.058260] 1 lock held by insmod/2329:
> [   41.062085]  #0: ffffff80003b9988 (&dev->mutex){....}-{3:3}, at: __driver_attach+0x88/0x190
> [   41.070442]
> [   41.070442] the shortest dependencies between 2nd lock and 1st lock:
> [   41.078257]  -> (&q->lock){+.-.}-{2:2} {
> [   41.082177]     HARDIRQ-ON-W at:
> [   41.085396]                       lock_acquire+0xfc/0x2c0
> [   41.090787]                       _raw_spin_lock_bh+0x84/0xa0
> [   41.096525]                       mt76_dma_cleanup+0x24c/0x650 [mt76]
> [   41.102977]                       mt76_dma_cleanup+0x614/0x650 [mt76]
> [   41.109428]                       mt7915_eeprom_get_power_delta+0x1168/0x2464 [mt7915e]
> [   41.117435]                       mt7915_eeprom_init+0x40/0x340 [mt7915e]
> [   41.124222]                       cleanup_module+0x94/0xb28 [mt7915e]
> [   41.130662]                       platform_probe+0x64/0xbc
> [   41.136139]                       really_probe.part.0+0x98/0x2f4
> [   41.142134]                       __driver_probe_device+0x94/0x16c
> [   41.148303]                       driver_probe_device+0x40/0x120
> [   41.154299]                       __driver_attach+0x94/0x190
> [   41.159947]                       bus_for_each_dev+0x5c/0x94
> [   41.165594]                       driver_attach+0x20/0x30
> [   41.170983]                       bus_add_driver+0x104/0x1f4
> [   41.176631]                       driver_register+0x74/0x120
> [   41.182280]                       __platform_driver_register+0x24/0x30
> [   41.188797]                       0xffffffc000cb1074
> [   41.193754]                       do_one_initcall+0x70/0x2cc
> [   41.199403]                       do_init_module+0x44/0x240
> [   41.204968]                       load_module+0x1f5c/0x2874
> [   41.210532]                       __do_sys_init_module+0x1d8/0x2ac
> [   41.216702]                       __arm64_sys_init_module+0x18/0x20
> [   41.222958]                       invoke_syscall.constprop.0+0x4c/0xe0
> [   41.229474]                       do_el0_svc+0x50/0xf0
> [   41.234602]                       el0_svc+0x4c/0xcc
> [   41.239471]                       el0t_64_sync_handler+0xe0/0x110
> [   41.245556]                       el0t_64_sync+0x15c/0x160
> [   41.251029]     IN-SOFTIRQ-W at:
> [   41.254249]                       lock_acquire+0xfc/0x2c0
> [   41.259638]                       _raw_spin_lock_bh+0x84/0xa0
> [   41.265372]                       mt76_queue_tx_complete+0x34/0x70 [mt76]
> [   41.272170]                       mt76_free_pending_rxwi+0x36c/0x5d0 [mt76]
> [   41.279140]                       mt76_free_pending_rxwi+0x5c0/0x5d0 [mt76]
> [   41.286111]                       mt7915_eeprom_get_power_delta+0x620/0x2464 [mt7915e]
> [   41.294026]                       __napi_poll.constprop.0+0x5c/0x230
> [   41.300372]                       net_rx_action+0xe4/0x294
> [   41.305847]                       _stext+0x154/0x4cc
> [   41.310801]                       do_softirq+0xa4/0xbc
> [   41.315930]                       __local_bh_enable_ip+0x168/0x174
> [   41.322097]                       napi_threaded_poll+0xbc/0x140
> [   41.328007]                       kthread+0x13c/0x150
> [   41.333049]                       ret_from_fork+0x10/0x20
> [   41.338437]     INITIAL USE at:
> [   41.341568]                      lock_acquire+0xfc/0x2c0
> [   41.346869]                      _raw_spin_lock_bh+0x84/0xa0
> [   41.352519]                      mt76_dma_cleanup+0x24c/0x650 [mt76]
> [   41.358882]                      mt76_dma_cleanup+0x614/0x650 [mt76]
> [   41.365245]                      mt7915_eeprom_get_power_delta+0x1168/0x2464 [mt7915e]
> [   41.373160]                      mt7915_eeprom_init+0x40/0x340 [mt7915e]
> [   41.379860]                      cleanup_module+0x94/0xb28 [mt7915e]
> [   41.386213]                      platform_probe+0x64/0xbc
> [   41.391602]                      really_probe.part.0+0x98/0x2f4
> [   41.397511]                      __driver_probe_device+0x94/0x16c
> [   41.403594]                      driver_probe_device+0x40/0x120
> [   41.409502]                      __driver_attach+0x94/0x190
> [   41.415063]                      bus_for_each_dev+0x5c/0x94
> [   41.420625]                      driver_attach+0x20/0x30
> [   41.425926]                      bus_add_driver+0x104/0x1f4
> [   41.431487]                      driver_register+0x74/0x120
> [   41.437049]                      __platform_driver_register+0x24/0x30
> [   41.443479]                      0xffffffc000cb1074
> [   41.448346]                      do_one_initcall+0x70/0x2cc
> [   41.453907]                      do_init_module+0x44/0x240
> [   41.459383]                      load_module+0x1f5c/0x2874
> [   41.464860]                      __do_sys_init_module+0x1d8/0x2ac
> [   41.470944]                      __arm64_sys_init_module+0x18/0x20
> [   41.477113]                      invoke_syscall.constprop.0+0x4c/0xe0
> [   41.483542]                      do_el0_svc+0x50/0xf0
> [   41.488582]                      el0_svc+0x4c/0xcc
> [   41.493364]                      el0t_64_sync_handler+0xe0/0x110
> [   41.499361]                      el0t_64_sync+0x15c/0x160
> [   41.504748]   }
> [   41.506489]   ... key      at: [<ffffffc000c65ba0>] __this_module+0x3e0/0xffffffffffffa840 [mt76]
> [   41.515371]   ... acquired at:
> [   41.518413]    _raw_spin_lock+0x60/0x74
> [   41.522240]    mt76_get_rxwi+0x1c/0xac [mt76]
> [   41.526608]    mt76_dma_cleanup+0x3e0/0x650 [mt76]
> [   41.531410]    mt76_dma_cleanup+0x614/0x650 [mt76]
> [   41.536211]    mt7915_dma_init+0x408/0x7b0 [mt7915e]
> [   41.541177]    mt7915_register_device+0x310/0x620 [mt7915e]
> [   41.546749]    mt7915_mmio_probe+0xcec/0x1d44 [mt7915e]
> [   41.551973]    platform_probe+0x64/0xbc
> [   41.555802]    really_probe.part.0+0x98/0x2f4
> [   41.560149]    __driver_probe_device+0x94/0x16c
> [   41.564670]    driver_probe_device+0x40/0x120
> [   41.569017]    __driver_attach+0x94/0x190
> [   41.573019]    bus_for_each_dev+0x5c/0x94
> [   41.577018]    driver_attach+0x20/0x30
> [   41.580758]    bus_add_driver+0x104/0x1f4
> [   41.584758]    driver_register+0x74/0x120
> [   41.588759]    __platform_driver_register+0x24/0x30
> [   41.593628]    init_module+0x74/0x1000 [mt7915e]
> [   41.598248]    do_one_initcall+0x70/0x2cc
> [   41.602248]    do_init_module+0x44/0x240
> [   41.606162]    load_module+0x1f5c/0x2874
> [   41.610078]    __do_sys_init_module+0x1d8/0x2ac
> [   41.614600]    __arm64_sys_init_module+0x18/0x20
> [   41.619209]    invoke_syscall.constprop.0+0x4c/0xe0
> [   41.624076]    do_el0_svc+0x50/0xf0
> [   41.627555]    el0_svc+0x4c/0xcc
> [   41.630776]    el0t_64_sync_handler+0xe0/0x110
> [   41.635211]    el0t_64_sync+0x15c/0x160
> [   41.639037]
> [   41.640517] -> (&dev->wed_lock){+.+.}-{2:2} {
> [   41.644872]    HARDIRQ-ON-W at:
> [   41.648003]                     lock_acquire+0xfc/0x2c0
> [   41.653219]                     _raw_spin_lock+0x60/0x74
> [   41.658520]                     mt76_free_pending_rxwi+0xc0/0x5d0 [mt76]
> [   41.665232]                     mt76_dma_cleanup+0x1dc/0x650 [mt76]
> [   41.671508]                     mt7915_eeprom_get_power_delta+0x1830/0x2464 [mt7915e]
> [   41.679336]                     mt7915_unregister_device+0x5b4/0x910 [mt7915e]
> [   41.686555]                     mt7915_eeprom_get_target_power+0xb8/0x230 [mt7915e]
> [   41.694209]                     mt7986_wmac_enable+0xc30/0xcd0 [mt7915e]
> [   41.700909]                     platform_remove+0x4c/0x64
> [   41.706298]                     __device_release_driver+0x194/0x240
> [   41.712554]                     driver_detach+0xc0/0x100
> [   41.717857]                     bus_remove_driver+0x54/0xac
> [   41.723418]                     driver_unregister+0x2c/0x54
> [   41.728980]                     platform_driver_unregister+0x10/0x20
> [   41.735323]                     mt7915_ops+0x244/0xffffffffffffed58 [mt7915e]
> [   41.742457]                     __arm64_sys_delete_module+0x170/0x23c
> [   41.748887]                     invoke_syscall.constprop.0+0x4c/0xe0
> [   41.755229]                     do_el0_svc+0x50/0xf0
> [   41.760183]                     el0_svc+0x4c/0xcc
> [   41.764878]                     el0t_64_sync_handler+0xe0/0x110
> [   41.770788]                     el0t_64_sync+0x15c/0x160
> [   41.776088]    SOFTIRQ-ON-W at:
> [   41.779220]                     lock_acquire+0xfc/0x2c0
> [   41.784435]                     _raw_spin_lock+0x60/0x74
> [   41.789737]                     mt76_get_rxwi+0x1c/0xac [mt76]
> [   41.795580]                     mt7915_debugfs_rx_log+0x804/0xb74 [mt7915e]
> [   41.802540]                     mtk_wed_start+0x970/0xaa0
> [   41.807929]                     mt7915_dma_start+0x26c/0x630 [mt7915e]
> [   41.814455]                     mt7915_dma_start+0x5a4/0x630 [mt7915e]
> [   41.820981]                     mt7915_dma_init+0x45c/0x7b0 [mt7915e]
> [   41.827420]                     mt7915_register_device+0x310/0x620 [mt7915e]
> [   41.834467]                     mt7915_mmio_probe+0xcec/0x1d44 [mt7915e]
> [   41.841167]                     platform_probe+0x64/0xbc
> [   41.846469]                     really_probe.part.0+0x98/0x2f4
> [   41.852291]                     __driver_probe_device+0x94/0x16c
> [   41.858286]                     driver_probe_device+0x40/0x120
> [   41.864107]                     __driver_attach+0x94/0x190
> [   41.869582]                     bus_for_each_dev+0x5c/0x94
> [   41.875056]                     driver_attach+0x20/0x30
> [   41.880270]                     bus_add_driver+0x104/0x1f4
> [   41.885745]                     driver_register+0x74/0x120
> [   41.891221]                     __platform_driver_register+0x24/0x30
> [   41.897564]                     init_module+0x74/0x1000 [mt7915e]
> [   41.903657]                     do_one_initcall+0x70/0x2cc
> [   41.909130]                     do_init_module+0x44/0x240
> [   41.914520]                     load_module+0x1f5c/0x2874
> [   41.919909]                     __do_sys_init_module+0x1d8/0x2ac
> [   41.925905]                     __arm64_sys_init_module+0x18/0x20
> [   41.931989]                     invoke_syscall.constprop.0+0x4c/0xe0
> [   41.938331]                     do_el0_svc+0x50/0xf0
> [   41.943285]                     el0_svc+0x4c/0xcc
> [   41.947981]                     el0t_64_sync_handler+0xe0/0x110
> [   41.953892]                     el0t_64_sync+0x15c/0x160
> [   41.959192]    INITIAL USE at:
> [   41.962238]                    lock_acquire+0xfc/0x2c0
> [   41.967365]                    _raw_spin_lock+0x60/0x74
> [   41.972580]                    mt76_free_pending_rxwi+0xc0/0x5d0 [mt76]
> [   41.979206]                    mt76_dma_cleanup+0x1dc/0x650 [mt76]
> [   41.985395]                    mt7915_eeprom_get_power_delta+0x1830/0x2464 [mt7915e]
> [   41.993137]                    mt7915_unregister_device+0x5b4/0x910 [mt7915e]
> [   42.000270]                    mt7915_eeprom_get_target_power+0xb8/0x230 [mt7915e]
> [   42.007837]                    mt7986_wmac_enable+0xc30/0xcd0 [mt7915e]
> [   42.014450]                    platform_remove+0x4c/0x64
> [   42.019753]                    __device_release_driver+0x194/0x240
> [   42.025922]                    driver_detach+0xc0/0x100
> [   42.031137]                    bus_remove_driver+0x54/0xac
> [   42.036612]                    driver_unregister+0x2c/0x54
> [   42.042087]                    platform_driver_unregister+0x10/0x20
> [   42.048344]                    mt7915_ops+0x244/0xffffffffffffed58 [mt7915e]
> [   42.055391]                    __arm64_sys_delete_module+0x170/0x23c
> [   42.061735]                    invoke_syscall.constprop.0+0x4c/0xe0
> [   42.067990]                    do_el0_svc+0x50/0xf0
> [   42.072857]                    el0_svc+0x4c/0xcc
> [   42.077466]                    el0t_64_sync_handler+0xe0/0x110
> [   42.083289]                    el0t_64_sync+0x15c/0x160
> [   42.088503]  }
> [   42.090157]  ... key      at: [<ffffffc000c65c10>] __this_module+0x450/0xffffffffffffa840 [mt76]
> [   42.098951]  ... acquired at:
> [   42.101907]    __lock_acquire+0x718/0x1df0
> [   42.105994]    lock_acquire+0xfc/0x2c0
> [   42.109734]    _raw_spin_lock+0x60/0x74
> [   42.113561]    mt76_get_rxwi+0x1c/0xac [mt76]
> [   42.117929]    mt7915_debugfs_rx_log+0x804/0xb74 [mt7915e]
> [   42.123415]    mtk_wed_start+0x970/0xaa0
> [   42.127328]    mt7915_dma_start+0x26c/0x630 [mt7915e]
> [   42.132379]    mt7915_dma_start+0x5a4/0x630 [mt7915e]
> [   42.137430]    mt7915_dma_init+0x45c/0x7b0 [mt7915e]
> [   42.142395]    mt7915_register_device+0x310/0x620 [mt7915e]
> [   42.147967]    mt7915_mmio_probe+0xcec/0x1d44 [mt7915e]
> [   42.153192]    platform_probe+0x64/0xbc
> [   42.157019]    really_probe.part.0+0x98/0x2f4
> [   42.161367]    __driver_probe_device+0x94/0x16c
> [   42.165887]    driver_probe_device+0x40/0x120
> [   42.170234]    __driver_attach+0x94/0x190
> [   42.174235]    bus_for_each_dev+0x5c/0x94
> [   42.178235]    driver_attach+0x20/0x30
> [   42.181974]    bus_add_driver+0x104/0x1f4
> [   42.185974]    driver_register+0x74/0x120
> [   42.189974]    __platform_driver_register+0x24/0x30
> [   42.194842]    init_module+0x74/0x1000 [mt7915e]
> [   42.199460]    do_one_initcall+0x70/0x2cc
> [   42.203460]    do_init_module+0x44/0x240
> [   42.207376]    load_module+0x1f5c/0x2874
> [   42.211290]    __do_sys_init_module+0x1d8/0x2ac
> [   42.215813]    __arm64_sys_init_module+0x18/0x20
> [   42.220421]    invoke_syscall.constprop.0+0x4c/0xe0
> [   42.225288]    do_el0_svc+0x50/0xf0
> [   42.228768]    el0_svc+0x4c/0xcc
> [   42.231989]    el0t_64_sync_handler+0xe0/0x110
> [   42.236424]    el0t_64_sync+0x15c/0x160
> [   42.240249]
> [   42.241730]
> [   42.241730] stack backtrace:
> [   42.246074] CPU: 1 PID: 2329 Comm: insmod Not tainted 5.15.127 #0
> [   42.252157] Hardware name: GainStrong Oolite-MT7981B V1 Dev Board (NAND boot) (DT)
> [   42.259712] Call trace:
> [   42.262147]  dump_backtrace+0x0/0x174
> [   42.265802]  show_stack+0x14/0x20
> [   42.269108]  dump_stack_lvl+0x84/0xac
> [   42.272761]  dump_stack+0x14/0x2c
> [   42.276066]  print_irq_inversion_bug.part.0+0x1b0/0x1c4
> [   42.281285]  mark_lock+0x8b8/0x8bc
> [   42.284678]  __lock_acquire+0x718/0x1df0
> [   42.288592]  lock_acquire+0xfc/0x2c0
> [   42.292158]  _raw_spin_lock+0x60/0x74
> [   42.295811]  mt76_get_rxwi+0x1c/0xac [mt76]
> [   42.300008]  mt7915_debugfs_rx_log+0x804/0xb74 [mt7915e]
> [   42.305320]  mtk_wed_start+0x970/0xaa0
> [   42.309059]  mt7915_dma_start+0x26c/0x630 [mt7915e]
> [   42.313937]  mt7915_dma_start+0x5a4/0x630 [mt7915e]
> [   42.318815]  mt7915_dma_init+0x45c/0x7b0 [mt7915e]
> [   42.323606]  mt7915_register_device+0x310/0x620 [mt7915e]
> [   42.329005]  mt7915_mmio_probe+0xcec/0x1d44 [mt7915e]
> [   42.334056]  platform_probe+0x64/0xbc
> [   42.337711]  really_probe.part.0+0x98/0x2f4
> [   42.341885]  __driver_probe_device+0x94/0x16c
> [   42.346232]  driver_probe_device+0x40/0x120
> [   42.350407]  __driver_attach+0x94/0x190
> [   42.354234]  bus_for_each_dev+0x5c/0x94
> [   42.358061]  driver_attach+0x20/0x30
> [   42.361627]  bus_add_driver+0x104/0x1f4
> [   42.365454]  driver_register+0x74/0x120
> [   42.369282]  __platform_driver_register+0x24/0x30
> [   42.373977]  init_module+0x74/0x1000 [mt7915e]
> [   42.378423]  do_one_initcall+0x70/0x2cc
> [   42.382249]  do_init_module+0x44/0x240
> [   42.385990]  load_module+0x1f5c/0x2874
> [   42.389733]  __do_sys_init_module+0x1d8/0x2ac
> [   42.394082]  __arm64_sys_init_module+0x18/0x20
> [   42.398518]  invoke_syscall.constprop.0+0x4c/0xe0
> [   42.403211]  do_el0_svc+0x50/0xf0
> [   42.406517]  el0_svc+0x4c/0xcc
> [   42.409565]  el0t_64_sync_handler+0xe0/0x110
> [   42.413827]  el0t_64_sync+0x15c/0x160
> [   42.674858] mt798x-wmac 18000000.wifi: HW/SW Version: 0x8a108a10, Build Time: 20221208201745a
> [   42.674858]
> [   42.692078] mt798x-wmac 18000000.wifi: WM Firmware Version: ____000000, Build Time: 20221208201806
> [   42.735606] mt798x-wmac 18000000.wifi: WA Firmware Version: DEV_000000, Build Time: 20221208202048
>
> Tested-by: Daniel Golle <daniel@makrotopia.org>
> Fixes: 2666bece0905 ("wifi: mt76: introduce rxwi and rx token utility routines")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

I assigned this to me on patchwork. Felix, ack?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
