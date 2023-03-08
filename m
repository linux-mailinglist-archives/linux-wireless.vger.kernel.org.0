Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC6C6AFC75
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 02:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjCHBhY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Mar 2023 20:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCHBhX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Mar 2023 20:37:23 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC8F41B4B
        for <linux-wireless@vger.kernel.org>; Tue,  7 Mar 2023 17:37:22 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 96F58700082
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 01:37:20 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.39.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 0999813C2B0
        for <linux-wireless@vger.kernel.org>; Tue,  7 Mar 2023 17:37:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0999813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1678239440;
        bh=r8kdAJrJdP3L2afYhN0iFmWocOJyu9b8FESzw+qQ3AA=;
        h=To:From:Subject:Date:From;
        b=dimP4Nhx8tq1RsapPedHEFlQUbyOXJEM7tVAkqJIqXY7uRVBjkPEXjBuflU+5dOpn
         F5Z4EfDbqB3+krrHEI0SNrOFmfWuoORDjqgBpQ3iDsjUpRJuCqDrBHfQnclzm6J8Ec
         l5OHrTrGmJ/GeXECvVFhcfZwqkLbhnMO4Nfc0Ul8=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: 6.2.2+ ksoftirqd kasan splat
Organization: Candela Technologies
Message-ID: <2077f1dc-e4a4-1de0-ce8a-7c5dbe5837ed@candelatech.com>
Date:   Tue, 7 Mar 2023 17:37:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1678239441-5T6E9bXdvzyC
X-MDID-O: us5;ut7;1678239441;5T6E9bXdvzyC;<greearb@candelatech.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I have seen this a few times during reboot/shutdown.  This is on a system
with 24 mtk7922 radios in it, so probably related to that piece of hardware
somehow.  The splat doesn't tell me much though, so not sure how to make
progress.

==================================================================
BUG: KASAN: use-after-free in tasklet_action_common.constprop.0+0xa4/0x200
Read of size 4 at addr ffff888147d1a670 by task ksoftirqd/5/40

CPU: 5 PID: 40 Comm: ksoftirqd/5 Not tainted 6.2.2+ #28
Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
Call Trace:
  <TASK>
  dump_stack_lvl+0x44/0x58
  print_report+0x17c/0x481
  ? __virt_addr_valid+0xab/0x130
  ? tasklet_action_common.constprop.0+0xa4/0x200
  ? tasklet_action_common.constprop.0+0xa4/0x200
  kasan_report+0xad/0x130
  ? tasklet_action_common.constprop.0+0xa4/0x200
  tasklet_action_common.constprop.0+0xa4/0x200
  __do_softirq+0xee/0x38a
  ? trace_event_raw_event_irq_handler_entry+0x180/0x180
  run_ksoftirqd+0x1f/0x30
  smpboot_thread_fn+0x156/0x2c0
  ? sort_range+0x20/0x20
  kthread+0x14c/0x180
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30
  </TASK>

The buggy address belongs to the physical page:

Memory state around the buggy address:
  ffff888147d1a500: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff888147d1a580: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 >ffff888147d1a600: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                              ^
  ffff888147d1a680: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff888147d1a700: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================
reboot: Power down

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
