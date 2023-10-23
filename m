Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A047D3883
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjJWNzS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 09:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjJWNzR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 09:55:17 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2B110A
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 06:55:13 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 83D618C0078
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 13:55:11 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.112.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 37F7513C2B0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 06:55:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 37F7513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698069307;
        bh=B147UPeIrB6FuxReuzirbTtq4g7OadRVqEY4oozD/Gg=;
        h=To:From:Subject:Date:From;
        b=NXyR72+l8AgmoQJOSmq3eBIRz5mQj66iXo/IBhQluSs1ZH+qTCOnrV4vRRXgPuXuB
         duDgLKmlxRDqUxeV1YfqwsFH32wnIsEXesu/dzcwSQ2bWnPMZYeOCuq5IAyruBkwR0
         yuxf7Jh4AoN3yzc3e287U4LgOE5l8n2P9CvHL32U=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: Crash in wireless-next in unregister netdevice path.
Organization: Candela Technologies
Message-ID: <eb28a0db-a562-5360-360b-877f08de9477@candelatech.com>
Date:   Mon, 23 Oct 2023 06:55:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1698069312-bPfPw5FpZWHX
X-MDID-O: us5;at1;1698069312;bPfPw5FpZWHX;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This one is mostly FYI, I guess I'll need to spend some time under KASAN
to try to get a better idea of what is going on...

BUG: unable to handle page fault for address: 00000ff8119010c0
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP
CPU: 6 PID: 18653 Comm: iw Not tainted 6.6.0-rc5+ #13
Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
RIP: 0010:kobject_get_path+0x31/0x110
Code: 89 fd 41 54 55 53 48 83 ec 08 89 74 24 04 4c 89 ed bb 01 00 00 00 eb 12 e8 ac 4b 01 00 48 8b 6d 18 8d 5c 0c
RSP: 0018:ffffc900098bb7c0 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000018 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000cc0 RDI: ffffffff8241ba7b
RBP: 00000ff8119010c0 R08: 0000000000001000 R09: 0000000000000000
R10: ffff888188ade000 R11: ffff8881105fb908 R12: ffff888188ade000
R13: ffff8881331f4650 R14: 0000000000000000 R15: ffff88813820b7c0
FS:  00007f67fc296b80(0000) GS:ffff88845dd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000ff8119010c0 CR3: 000000019988a003 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <TASK>
  ? __die+0x1a/0x60
  ? page_fault_oops+0x154/0x450
  ? exc_page_fault+0x69/0x140
  ? asm_exc_page_fault+0x22/0x30
  ? kobject_get_path+0x31/0x110
  kobject_uevent_env+0xcd/0x830
  ? sysfs_remove_group+0x33/0x80
  __kobject_del+0x96/0xd0
  kobject_put+0xd9/0x170
  net_rx_queue_update_kobjects+0x13a/0x190
  netdev_unregister_kobject+0x45/0x90
  unregister_netdevice_many_notify+0x425/0x7e0
  unregister_netdevice_queue+0x84/0xc0
  _cfg80211_unregister_wdev+0x1e7/0x230 [cfg80211]
  ieee80211_if_remove+0x8b/0xe0 [mac80211]
  ieee80211_del_iface+0xc/0x10 [mac80211]
  cfg80211_remove_virtual_intf+0x28/0xd0 [cfg80211]
  genl_family_rcv_msg_doit+0xd1/0x120
  genl_rcv_msg+0x17b/0x290
  ? __cfg80211_wdev_from_attrs+0x290/0x290 [cfg80211]
  ? nl80211_stop_ap+0x30/0x30 [cfg80211]
  ? nlmsg_trim+0x20/0x20 [cfg80211]
  ? genl_family_rcv_msg_dumpit+0xf0/0xf0
  netlink_rcv_skb+0x4f/0x100
  genl_rcv+0x1f/0x30
  netlink_unicast+0x18b/0x280
  netlink_sendmsg+0x24b/0x4c0
  __sock_sendmsg+0x33/0x60
  ____sys_sendmsg+0x229/0x2a0
  ? copy_msghdr_from_user+0x68/0xa0
  ___sys_sendmsg+0x81/0xc0
  ? do_fault+0x2f9/0x430

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
