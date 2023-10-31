Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2307DD857
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Oct 2023 23:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346769AbjJaWcF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Oct 2023 18:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344887AbjJaWcE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Oct 2023 18:32:04 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8868EED
        for <linux-wireless@vger.kernel.org>; Tue, 31 Oct 2023 15:32:01 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 703A4C006F
        for <linux-wireless@vger.kernel.org>; Tue, 31 Oct 2023 22:31:59 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id F0B3613C2B0
        for <linux-wireless@vger.kernel.org>; Tue, 31 Oct 2023 15:31:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com F0B3613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698791519;
        bh=SQmlXZWbQrztkP/nzm6L8lLwm9wpkPmJN/oWJVtW8JY=;
        h=Date:To:From:Subject:From;
        b=A4zK6mT9TGGf7sgrjyYoRzAbhZGzq7+YYR3iJo2nyMkDHc2n4hOdyvLSP7RvMmdI8
         CtdOTdFHDfshhBWeOIVtQPJqEm6mMSnsA8Lk0F9sgrwvpRGsLpF6WB2TL2xGDArTCQ
         3q1p6j7b/vdPQnioIAAzXTVv1ixP7uV2XtYAHwrE=
Message-ID: <eac89197-1faf-899b-c1eb-7de8fc8bd2c5@candelatech.com>
Date:   Tue, 31 Oct 2023 15:31:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: wireless-next plus hacks, iwl_dbg_tlv_add related memory debugging
 splat.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1698791520-Sjc72w4EbGxY
X-MDID-O: us5;ut7;1698791520;Sjc72w4EbGxY;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I saw this while testing a kernel a great pile of debugging options turned on.

This might be something I can actually debug, so I'll try to investigate it more.

Oct 31 15:19:38 ct523c-2103 kernel: BUG kmalloc-96 (Tainted: G        W         ): Freepointer corrupt
Oct 31 15:19:38 ct523c-2103 kernel: -----------------------------------------------------------------------------
Oct 31 15:19:38 ct523c-2103 kernel: Allocated in iwl_dbg_tlv_add+0x27/0xc0 [iwlwifi] age=18446726515884352973 cpu=4088 pid=990
Oct 31 15:19:38 ct523c-2103 kernel: adjust-he-cap, disabling 160Mhz.
Oct 31 15:19:38 ct523c-2103 kernel:  __kmalloc+0x4b/0x150
Oct 31 15:19:38 ct523c-2103 kernel:  iwl_dbg_tlv_add+0x27/0xc0 [iwlwifi]
Oct 31 15:19:38 ct523c-2103 kernel:  _iwl_dbg_tlv_time_point+0x14c2/0x1660 [iwlwifi]
Oct 31 15:19:38 ct523c-2103 kernel:  iwl_run_unified_mvm_ucode+0x171/0x4c0 [iwlmvm]
Oct 31 15:19:38 ct523c-2103 kernel:  iwl_run_init_mvm_ucode+0x3e7/0x620 [iwlmvm]
Oct 31 15:19:38 ct523c-2103 kernel:  iwl_mvm_start_get_nvm+0xff/0x380 [iwlmvm]
Oct 31 15:19:38 ct523c-2103 kernel:  iwl_op_mode_mvm_start+0x1119/0x1460 [iwlmvm]
Oct 31 15:19:38 ct523c-2103 kernel:  _iwl_op_mode_start+0x197/0x1e0 [iwlwifi]
Oct 31 15:19:38 ct523c-2103 kernel:  iwl_opmode_register+0x84/0x110 [iwlwifi]
Oct 31 15:19:38 ct523c-2103 kernel:  0xffffffffa1ac801d
Oct 31 15:19:38 ct523c-2103 kernel:  do_one_initcall+0xb4/0x380
Oct 31 15:19:38 ct523c-2103 kernel:  do_init_module+0x130/0x360
Oct 31 15:19:38 ct523c-2103 kernel:  load_module+0x3263/0x3440
Oct 31 15:19:38 ct523c-2103 kernel:  init_module_from_file+0xcc/0x120
Oct 31 15:19:38 ct523c-2103 kernel:  idempotent_init_module+0x1ae/0x3e0
Oct 31 15:19:38 ct523c-2103 kernel:  __x64_sys_finit_module+0x73/0xc0
Oct 31 15:19:38 ct523c-2103 kernel: Slab 0xffffea0004ade580 objects=37 used=18 fp=0xffff88812b796cb0 
flags=0x5fff8000000840(slab|head|node=0|zone=2|lastcpupid=0x3fff)
Oct 31 15:19:38 ct523c-2103 kernel: Object 0xffff88812b796878 @offset=2168 fp=0x00000ff82b796950
Oct 31 15:19:38 ct523c-2103 kernel: Redzone  ffff88812b796870: cc cc cc cc cc cc cc cc                          ........
Oct 31 15:19:38 ct523c-2103 kernel: Object   ffff88812b796878: 40 8e 12 cb 81 88 ff ff f5 5a 00 00 ca 02 50 06  @........Z....P.
Oct 31 15:19:38 ct523c-2103 kernel: Object   ffff88812b796888: 09 00 00 01 48 00 00 00 01 00 00 00 00 00 00 00  ....H...........
Oct 31 15:19:38 ct523c-2103 kernel: Object   ffff88812b796898: 08 00 00 00 0a 1a 00 00 03 00 01 00 00 00 00 00  ................
Oct 31 15:19:38 ct523c-2103 kernel: Object   ffff88812b7968a8: ff ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00  ................
Oct 31 15:19:38 ct523c-2103 kernel: Object   ffff88812b7968b8: 00 00 00 00 01 00 01 04 01 00 00 f0 f8 0f 00 00  ................
Oct 31 15:19:38 ct523c-2103 kernel: Object   ffff88812b7968c8: cc cc cc cc cc cc cc cc cc cc cc cc f8 0f 00 00  ................
Oct 31 15:19:38 ct523c-2103 kernel: Redzone  ffff88812b7968d8: cc cc cc cc cc cc cc cc                          ........
Oct 31 15:19:38 ct523c-2103 kernel: Padding  ffff88812b79693c: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a              ZZZZZZZZZZZZ
Oct 31 15:19:38 ct523c-2103 kernel: CPU: 0 PID: 23351 Comm: pkill Tainted: G        W          6.6.0-rc5+ #8
Oct 31 15:19:38 ct523c-2103 kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
Oct 31 15:19:38 ct523c-2103 kernel: Call Trace:
Oct 31 15:19:38 ct523c-2103 kernel:  <TASK>
Oct 31 15:19:38 ct523c-2103 kernel:  dump_stack_lvl+0x57/0x90
Oct 31 15:19:38 ct523c-2103 kernel:  check_object+0x14e/0x310
Oct 31 15:19:38 ct523c-2103 kernel:  free_to_partial_list+0x1ff/0x5b0
Oct 31 15:19:38 ct523c-2103 kernel:  ? qlist_free_all+0x68/0x190
Oct 31 15:19:38 ct523c-2103 kernel:  qlist_free_all+0x6d/0x190
Oct 31 15:19:38 ct523c-2103 kernel:  ? _raw_spin_unlock_irqrestore+0x2b/0x50
Oct 31 15:19:38 ct523c-2103 kernel:  kasan_quarantine_reduce+0x18a/0x1d0
Oct 31 15:19:38 ct523c-2103 kernel:  __kasan_slab_alloc+0x46/0x70
Oct 31 15:19:38 ct523c-2103 kernel:  kmem_cache_alloc+0x111/0x310
Oct 31 15:19:38 ct523c-2103 kernel:  ? mntput_no_expire+0xf0/0x5d0
Oct 31 15:19:38 ct523c-2103 kernel:  ? getname_flags.part.0+0x34/0x240
Oct 31 15:19:38 ct523c-2103 kernel:  ? mark_held_locks+0x24/0x90
Oct 31 15:19:38 ct523c-2103 kernel:  getname_flags.part.0+0x34/0x240
Oct 31 15:19:38 ct523c-2103 kernel:  ? build_open_flags+0x1d9/0x240
Oct 31 15:19:38 ct523c-2103 kernel:  do_sys_openat2+0xc6/0x130
Oct 31 15:19:38 ct523c-2103 kernel:  ? build_open_flags+0x240/0x240
Oct 31 15:19:38 ct523c-2103 kernel:  ? debug_objects_oom+0x220/0x220
Oct 31 15:19:38 ct523c-2103 kernel:  ? lockdep_hardirqs_on_prepare+0x132/0x200
Oct 31 15:19:38 ct523c-2103 kernel:  ? percpu_counter_add_batch+0xd0/0x120
Oct 31 15:19:38 ct523c-2103 kernel:  __x64_sys_openat+0xe0/0x130
Oct 31 15:19:38 ct523c-2103 kernel:  ? __x64_compat_sys_openat+0x130/0x130
Oct 31 15:19:38 ct523c-2103 kernel:  ? __call_rcu_common.constprop.0+0x220/0x480
Oct 31 15:19:38 ct523c-2103 kernel:  ? lockdep_hardirqs_on_prepare+0x132/0x200
Oct 31 15:19:38 ct523c-2103 kernel:  ? syscall_enter_from_user_mode+0x1c/0x50
Oct 31 15:19:38 ct523c-2103 kernel:  do_syscall_64+0x34/0xb0
Oct 31 15:19:38 ct523c-2103 kernel:  entry_SYSCALL_64_after_hwframe+0x46/0xb0
Oct 31 15:19:38 ct523c-2103 kernel: RIP: 0033:0x7fbc6c9018e8
Oct 31 15:19:38 ct523c-2103 kernel: Code: f0 25 00 00 41 00 3d 00 00 41 00 74 45 64 8b 04 25 18 00 00 00 85 c0 75 69 89 da 48 89 ee bf 9c ff ff ff b8 01 01 00 
00 0f 05 <48> 3d 00 f0 ff ff 0f 87 8c 00 00 00 48 8b 54 24 28 64 48 2b 14 25
Oct 31 15:19:38 ct523c-2103 kernel: RSP: 002b:00007ffcd6384370 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
Oct 31 15:19:38 ct523c-2103 kernel: RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbc6c9018e8
Oct 31 15:19:38 ct523c-2103 kernel: RDX: 0000000000000000 RSI: 00007ffcd6384400 RDI: 00000000ffffff9c
Oct 31 15:19:38 ct523c-2103 kernel: RBP: 00007ffcd6384400 R08: 0000000000000000 R09: 0000000000000073
Oct 31 15:19:38 ct523c-2103 kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 0000562d00eb8ac0
Oct 31 15:19:38 ct523c-2103 kernel: R13: 0000000000000000 R14: 0000000000000020 R15: 000000000001ffc5
Oct 31 15:19:38 ct523c-2103 kernel:  </TASK>
Oct 31 15:19:38 ct523c-2103 kernel: FIX kmalloc-96: Object at 0xffff88812b796878 not freed
-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

