Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D3D7CD117
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Oct 2023 01:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjJQX5X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 19:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjJQX5V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 19:57:21 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275F39F
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 16:57:20 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 763BFA80064
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 23:57:18 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 08DF813C2B0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 16:57:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 08DF813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1697587038;
        bh=xWVTnY1MKrUYdTyUCpHTm2d8wT9fgqrw8Wklt1fDxEc=;
        h=Date:To:From:Subject:From;
        b=rZigbw1eE2DKEsyMnwtAkxoAd5mUsQE+xRa9kLC4VyZtuu0w9oOjgLdsHxTJcDzyR
         bDvUusDwFRf6cwTfsvA9MZlO0M8A5Sd/MU+2gaPIykc6af6UYcfeMvk4wBd6IhEoQ1
         WDaHuRxcx/uN9mwf+lnX/ntkTthgW6MJQ23b5xms=
Message-ID: <afeba994-1ddd-08f3-b42e-951f8021f46b@candelatech.com>
Date:   Tue, 17 Oct 2023 16:57:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: iwlwifi crash on rmmod, be200, 6.7-ish
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1697587039-zbylxGbk3hZC
X-MDID-O: us5;ut7;1697587039;zbylxGbk3hZC;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Self-backported and hacked together 6.6 + wireless-testing.  Lots of opportunities
for self harm in that....

I see this crash on rmmod, any known issue?

# BUG: unable to handle page fault for address: 00000ff81a6a0808
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 0 P4D 0
Oops: 0002 [#1] PREEMPT SMP
CPU: 7 PID: 7879 Comm: rmmod Not tainted 6.6.0-rc5+ #20
Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
RIP: 0010:iwl_dbg_tlv_free+0x199/0x250 [iwlwifi]
Code: 48 89 5f 08 e8 d8 b7 57 e0 4c 89 f7 4d 8b 36 4c 39 ef 75 de 49 8b 7c 24 10 4c 8b 37 48 39 3c 24 74 26 48 8b 57 08 49 89 56 08 <4c> 89 32 48 89 2f 48 87
RSP: 0018:ffffc90003acbda0 EFLAGS: 00010202
RAX: ffff888110042600 RBX: dead000000000122 RCX: 00000000002a0009
RDX: 00000ff81a6a0808 RSI: ffffea0004e1a0c0 RDI: ffff888119883f60
RBP: dead000000000100 R08: 0000000000000000 R09: 00000000002a0009
R10: ffff888138683960 R11: 0000000000000000 R12: ffff88811a6a07f8
R13: ffff88811a6a0818 R14: ffff88811a6a0808 R15: ffff88811a6a0828
FS:  00007f1a64386740(0000) GS:ffff88845ddc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000ff81a6a0808 CR3: 00000001130e3006 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <TASK>
  ? __die+0x1a/0x60
  ? page_fault_oops+0x154/0x450
  ? __wake_up_common+0x6b/0x130
  ? __slab_free+0x55/0x2b0
  ? exc_page_fault+0x69/0x140
  ? asm_exc_page_fault+0x22/0x30
  ? iwl_dbg_tlv_free+0x199/0x250 [iwlwifi]
  iwl_drv_stop+0xc2/0xd0 [iwlwifi]
  iwl_pci_remove+0x16/0x30 [iwlwifi]
  pci_device_remove+0x2c/0x90
  device_release_driver_internal+0x192/0x1f0
  driver_detach+0x3f/0x80
  bus_remove_driver+0x64/0xe0
  pci_unregister_driver+0x36/0x80
  iwl_drv_exit+0x5/0x390 [iwlwifi]
  __do_sys_delete_module.constprop.0+0x16f/0x2b0



(gdb) l *(iwl_dbg_tlv_free+0x199)
0x1a6b9 is in iwl_dbg_tlv_free (/home/greearb/git/linux-6.6.dev.y/include/linux/list.h:196).
191	 * the prev/next entries already!
192	 */
193	static inline void __list_del(struct list_head * prev, struct list_head * next)
194	{
195		next->prev = prev;
196		WRITE_ONCE(prev->next, next);
197	}
198	
199	/*
200	 * Delete a list entry and clear the 'prev' pointer.
(gdb) l *(iwl_drv_stop+0xc2)
0x3c32 is in iwl_drv_stop (/home/greearb/git/linux-6.6.dev.y/drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1872).
1867		debugfs_remove_recursive(drv->dbgfs_drv);
1868	#endif
1869	
1870		iwl_dbg_tlv_free(drv->trans);
1871	
1872		kfree(drv);
1873	}
1874	
1875	/* shared module parameters */
1876	struct iwl_mod_params iwlwifi_mod_params = {
(gdb)

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

