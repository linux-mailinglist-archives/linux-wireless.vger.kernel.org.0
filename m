Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723435EB484
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 00:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiIZW0f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Sep 2022 18:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiIZW0e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Sep 2022 18:26:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970378E997
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 15:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664231189;
        bh=qKBQ5aW8wvVyg24BjWDYJ5Wa1SiPN60M9Kvz3JhcN8A=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=D36k+URdM2RV/RS9uth1ijjm4H/NtI1fxbKBenuifk7IFxIJ8FkGWFM9kAJ8ne8f+
         FrhsGkSrS5LNHYHQwrUbWOGAJNBB0RbSwWgTAz3gq9CZSiKw+j9p/Q0e394yLR66IM
         0dK2L+xJ1Nn5v5d0a+WL6oPY8qdOzqQRFE8fICoA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from legacy ([80.109.83.31]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnpnm-1p0ij00mvi-00pIGy; Tue, 27
 Sep 2022 00:13:48 +0200
Date:   Tue, 27 Sep 2022 00:13:47 +0200
From:   Stefan Tauner <stefan.tauner@gmx.at>
To:     linux-wireless@vger.kernel.org
Cc:     ilw@linux.intel.com
Subject: UBSAN: shift-out-of-bounds in =?UTF-8?B?4oCmL2l3bGVnYWN5LzQ5NjUt?=
 =?UTF-8?B?cnMuYzo2NzE6MTg=?=
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-ID: <1MSt8Q-1ooWxu16kw-00ULZw@mail.gmx.net>
X-Provags-ID: V03:K1:TVCXKfy2bHodIsqr0z+qD2kC7IeuuSrMkPmJx5EG0zoBXkQk8FY
 xNx6a051ouva3l2izRkYkbaklX8eemmEP8u/VFW8rWd/TYLeIS33leNh4VRTJTx3bjEnmSN
 qoruoLb9YGf2fubYTt1vw65gR0EzQCOrHeSBl4fMhuyEB2E1pVng6aFKaCALNNCR/VzWhVO
 HDCRuyj2pRJceNUam9YNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z+gKMBtGwmo=:j+G7hPHdOUVTr6WdYeRPr2
 6Qz8xTfOJDqQhnvUDafr6wAmuJDlKsBnbNTw9n4XmNKpqvCndLSB5yIRwcEofLCFPV0RFB8IP
 9T1jrmNdD954j4NIT5t17Sm6AK+lTzhwZPmpOB6OKe57XPtX3K+/KBRRD5a4krh9uMq8I8CAS
 4bBxV3EtfZs6JaEEca4B42qSsyF758yvMx2wdaSgE6tRoj5eSbWnZSEPxUplNvlJBZ616I8xr
 0dYwyChylm9wzyIkJnms46XXFU9JPw15SMUP358Cg8fsCMkbh/OkVdUJtVtGIoNkEpHabnfY0
 XF7a5IsTloWENlCznaDGgxXTalmtrctAtbbYywxCn4INpFxRew1IrFNbNC1EU5SM95/6hESB/
 fQHPpirOj0M6BZzJUnsXnXdgS/G45iS7wUacXTKSCOxDZ8UJ05NLRlkfAfuxYevUw0kqzndUw
 K2iNWClNhn0lr2nXqJgccQCXELzWwaYPan3MVCKY3gEnDfOa0IwUKv098Ycii5JN7AVWB2BoG
 /d/SlWiU1iESRsrCkqHx1JjlVuvIwM0D/HX5hGfjVZv6K0ASmhwoKRJ0VFIP1c7werbslgzYM
 R14wjWjM1/6VpZMaKPBC5bkrcNpn8jscqCWemfR/h9xOp+f4NrL+IhQbYVpYTjVZmFA7fLJje
 EtClNPcNiiLZcwuR4guiw7JmBGUWU3yrsl5oXlO3aLwGjBxKskrNAlsRiVac2Nps9T2fn0PIr
 mpPYhQEqgZ4m7RiDqtmC2J+tQTEvuTrxDNV52hx4kesVQXQmJUjRUAWw13yv42xBs5ZyEU5PL
 n9d+c6quU6/F+mMs3uQ28XNlaq1PFBMvmgx2P3CFdHTYFrldxL1jODLtcMOhqfaN99Xm6yGOz
 vkGmOYbZhg8rwRV/r7fUW/Spp7rGYeGlGp+nN8vvaACy12AIl51MmAEwuHC4Tg0s/gLU+cPs/
 xfhEAbTqlqZlGnljKB00p6ZlcLfHHMgOJ8NQCjMLAvvc/YAF1Zf5Fpc1OnK/bluNjNnnbcZJh
 KzvAIc3NAISGOWyOkhOJmOaHt9tiWcOpOzODyyNlhq6FfnCb9GXfqljB3CNReWUw0KMr+WSwY
 bthQdtlTJlv0AGxpqCbmoXXd5G/uEueYhYzstEDiFHVqFyamq3QsBt8GHJf9ufC5cJFhhk/JN
 grD6RrxD6575pVcTs+AXBTn9PPa51h9/RjKUj1gLch+p7q4Nd8fDrMSm8PqlvXT0zQRUH86NW
 5YJboAdrenMwqNYjuRRh8I6Ogx0JagRCtT6gvNA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I have updated an ancient Thinkpad T61 to Ubuntu 22.04 and noticed some
UB warnings in dmesg.

[   14.870724] UBSAN: shift-out-of-bounds in /build/linux-kQ6jNR/linux-5.15=
.0/drivers/net/wireless/intel/iwlegacy/4965-rs.c:671:18
[   14.870840] shift exponent -1 is negative
[   14.870940] CPU: 0 PID: 0 Comm: swapper/0 Tainted: P           OE     5.=
15.0-48-generic #54-Ubuntu
[   14.870943] Hardware name: LENOVO 6460EDG/6460EDG, BIOS 7LETC6WW (2.26 )=
 05/11/2009
[   14.870945] Call Trace:
[   14.870948]  <IRQ>
[   14.870951]  show_stack+0x52/0x5c
[   14.870957]  dump_stack_lvl+0x4a/0x63
[   14.870962]  dump_stack+0x10/0x16
[   14.870964]  ubsan_epilogue+0x9/0x49
[   14.870967]  __ubsan_handle_shift_out_of_bounds.cold+0x61/0xef
[   14.870969]  ? sock_def_readable+0x4b/0x80
[   14.870973]  ? __netlink_sendskb+0x62/0x80
[   14.870980]  il4965_rs_get_adjacent_rate.constprop.0.cold+0x3a/0xa4 [iwl=
4965]
[   14.870990]  il4965_rs_get_best_rate.isra.0+0xcc/0x140 [iwl4965]
[   14.870997]  il4965_rs_switch_to_siso.isra.0+0xa7/0x100 [iwl4965]
[   14.871003]  il4965_rs_move_legacy_other.isra.0+0x134/0x4c0 [iwl4965]
[   14.871010]  il4965_rs_rate_scale_perform+0xada/0xd10 [iwl4965]
[   14.871016]  ? kfree_skbmem+0x52/0xa0
[   14.871019]  il4965_rs_tx_status+0x3e0/0x6b0 [iwl4965]
[   14.871028]  rate_control_tx_status+0xb1/0xc0 [mac80211]
[   14.871128]  ieee80211_tx_status_ext+0x20e/0x650 [mac80211]
[   14.871166]  ieee80211_tx_status+0x72/0xa0 [mac80211]
[   14.871205]  ieee80211_tasklet_handler+0xa6/0xd0 [mac80211]
[   14.871242]  tasklet_action_common.constprop.0+0xc0/0xf0
[   14.871247]  tasklet_action+0x22/0x30
[   14.871249]  __do_softirq+0xd9/0x2e7
[   14.871253]  irq_exit_rcu+0x94/0xc0
[   14.871255]  common_interrupt+0x8e/0xa0
[   14.871258]  </IRQ>
[   14.871259]  <TASK>
[   14.871261]  asm_common_interrupt+0x26/0x40
[   14.871265] RIP: 0010:cpuidle_enter_state+0xd9/0x620
[   14.871270] Code: 3d c4 ef d9 54 e8 17 d7 68 ff 49 89 c7 0f 1f 44 00 00 =
31 ff e8 58 e4 68 ff 80 7d d0 00 0f 85 61 01 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 f6 0f 88 6d 01 00 00 4d 63 ee 49 83 fd 09 0f 87 e7 03 00 00
[   14.871272] RSP: 0018:ffffffffac603db8 EFLAGS: 00000292
[   14.871275] RAX: 0000000000000000 RBX: ffff9d83f7c3b508 RCX: 00000000000=
00020
[   14.871277] RDX: 0000000000001afa RSI: 000000000000a028 RDI: ffffffffac6=
07a40
[   14.871279] RBP: ffffffffac603e08 R08: 0000000000000000 R09: 00000000000=
0c738
[   14.871281] R10: 0000000000000004 R11: 071c71c71c71c71c R12: ffffffffac8=
d3ea0
[   14.871283] R13: 0000000000000002 R14: 0000000000000002 R15: 00000003765=
a58ca
[   14.871286]  ? cpuidle_enter_state+0x24a/0x620
[   14.871289]  cpuidle_enter+0x2e/0x50
[   14.871291]  cpuidle_idle_call+0x142/0x1e0
[   14.871294]  do_idle+0x83/0xf0
[   14.871296]  cpu_startup_entry+0x20/0x30
[   14.871299]  rest_init+0xd3/0x100
[   14.871301]  ? acpi_enable_subsystem+0x20b/0x217
[   14.871306]  arch_call_rest_init+0xe/0x23
[   14.871309]  start_kernel+0x4a9/0x4ca
[   14.871311]  x86_64_start_reservations+0x24/0x2a
[   14.871313]  x86_64_start_kernel+0xe4/0xef
[   14.871316]  secondary_startup_64_no_verify+0xc2/0xcb
[   14.871320]  </TASK>

If idx passed to il4965_rs_get_adjacent_rate is 0 then the initial
statement of the first loop tries to 1 << -1 (mask =3D (1 << i) where
int i =3D idx - 1), which is indeed UB due to the negative second operand.
The idx AFAICT comes from il4965_rs_rate_scale_perform() but I don't
think it matters too much? Please let me know if I should investigate
further. I didn't notice any ill effects but I didn't test it a lot
either.

The kernel is a pre-compiled 5.15.0 from the Ubuntu repos
(linux-image-5.15.0-48-generic). I had to enable an ancient Nvidia
binary driver which taints it but it happened with nouveau before that
as well.

--=20
Kind regards/Mit freundlichen Gr=C3=BC=C3=9Fen, Stefan Tauner
