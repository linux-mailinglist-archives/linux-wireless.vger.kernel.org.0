Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBF81293A4
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2019 10:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfLWJag (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Dec 2019 04:30:36 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54538 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726096AbfLWJag (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Dec 2019 04:30:36 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ijK2r-0000iJ-DI; Mon, 23 Dec 2019 11:30:34 +0200
Message-ID: <7ed0aa2b95ab0df7f85e6201bb1861620f4d0cd1.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Steve French <smfrench@gmail.com>, linux-wireless@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 23 Dec 2019 11:30:31 +0200
In-Reply-To: <CAH2r5mu5NC+QxAuECihhFdMgJjZVeoOqj1aQv+RR+kscHYH_hw@mail.gmail.com>
References: <CAH2r5mu5NC+QxAuECihhFdMgJjZVeoOqj1aQv+RR+kscHYH_hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2+b1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: Oops in ieee80211 driver on 5.5-rc2
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2019-12-21 at 16:58 -0600, Steve French wrote:
> I saw this oops again in the ieee80211 driver again today when the
> laptop was started at a connecting to a new WiFi in different location
> (in a fast food restaurant instead of at home or work).  I hadn't seen
> it connecting to Wifi at home for a while.
> 
> .x86_64 #1
> [   66.632041] Hardware name: LENOVO 20MAS08500/20MAS08500, BIOS
> N2CET48W (1.31 ) 11/04/2019
> [   66.632047] RIP:
> 0010:ieee80211_sta_update_pending_airtime+0xed/0x120 [mac80211]
> [   66.632048] Code: 8b b2 90 01 00 00 48 85 f6 75 07 48 8b b2 40 01
> 00 00 41 89 e8 89 c1 44 89 ea 48 c7 c7 58 3d 08 c1 89 44 24 04 e8 e5
> 6c 0d ef <0f> 0b 8b 44 24 04 eb 9d 48 83 c6 40 41 89 e8 89 c1 48 c7 c7
> 20 3d
> [   66.632049] RSP: 0018:ffffb0ef40c53ba8 EFLAGS: 00010286
> [   66.632049] RAX: 0000000000000000 RBX: 00000000ffffffb0 RCX: 0000000000000000
> [   66.632049] RDX: 000000000000003a RSI: ffffffffb215047a RDI: 0000000000000246
> [   66.632050] RBP: 0000000000000050 R08: 0000000f839398c6 R09: 000000000000003a
> [   66.632050] R10: 0000000000000001 R11: 00000000b2150446 R12: ffff9d76f2db87c0
> [   66.632051] R13: 0000000000000002 R14: ffff9d76a2c5a5c8 R15: ffff9d76f0833d00
> [   66.632051] FS:  0000000000000000(0000) GS:ffff9d76fbcc0000(0000)
> knlGS:0000000000000000
> [   66.632052] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   66.632052] CR2: 00001cab696ac008 CR3: 000000081492e006 CR4: 00000000003606e0
> [   66.632052] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   66.632053] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   66.632053] Call Trace:
> [   66.632060]  __ieee80211_tx_status+0x720/0x900 [mac80211]
> [   66.632066]  ieee80211_tx_status+0x6a/0x90 [mac80211]
> [   66.632070]  iwl_mvm_tx_reclaim+0x2a2/0x3c0 [iwlmvm]
> [   66.632074]  iwl_mvm_rx_ba_notif+0xff/0x2e0 [iwlmvm]
> [   66.632076]  ? __switch_to_asm+0x40/0x70
> [   66.632079]  iwl_mvm_rx_common+0xdd/0x2c0 [iwlmvm]
> [   66.632083]  iwl_pcie_rx_handle+0x3af/0x9c0 [iwlwifi]
> [   66.632085]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
> [   66.632088]  iwl_pcie_irq_rx_msix_handler+0x45/0x80 [iwlwifi]
> [   66.632089]  irq_thread_fn+0x20/0x60
> [   66.632090]  irq_thread+0xdc/0x170
> [   66.632091]  ? irq_forced_thread_fn+0x80/0x80
> [   66.632092]  kthread+0xf9/0x130
> [   66.632093]  ? irq_thread_check_affinity+0xf0/0xf0
> [   66.632094]  ? kthread_park+0x90/0x90
> [   66.632095]  ret_from_fork+0x35/0x40
> [   66.632096] ---[ end trace 9f6b29cb2168e61f ]---

Hi Steve,

This is fixed in v5.5-rc3.  This is the commit that fixes it:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=911bde0fe5ccd7e55760be9d6dcc67a8850fcc12

HTH.

--
Cheers,
Luca.

