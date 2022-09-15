Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A2B5BA018
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Sep 2022 18:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiIOQ5K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Sep 2022 12:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiIOQ5J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Sep 2022 12:57:09 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D077915D2
        for <linux-wireless@vger.kernel.org>; Thu, 15 Sep 2022 09:57:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so22985868pjm.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Sep 2022 09:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:date:to:from
         :subject:message-id:from:to:cc:subject:date;
        bh=LzS2cHNZPO4yoimnmhKA74maSQ96CMEuspiYWU+YP+4=;
        b=VuMzoOa67Sm1KmMYq7T+BENhyRJZzactxZywMELW6spgYxaVeqElKI34kBTrzwXsHl
         NyResx2BHmhB24213RFiRtpj5/A+YPtR6uj1jChDL68KW/4O6fpYayHh6T6hh8/pIsQC
         Zp4d/P9wONjxKKCGXzozRuLJ27SagRvoRjOaN1mwiqGwZbYO0xP0g2TNJ/wejHDfgqV8
         iGzRUH81fvfx07THaNSxObgWEbtohOygRuOgsXc+K2I8i5ELzUN0RgITZd8c520enX4L
         kcg0v7TvYjTozoJMc2quAWXB2mxUzzj8gjGBxd9gOw/+DJRHv8sZzDIgBJDlBcx26AqL
         Ys7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=LzS2cHNZPO4yoimnmhKA74maSQ96CMEuspiYWU+YP+4=;
        b=j2EmsojN0ItZiVe/N6hRiLKBxc2EB+e/cqv7WvqOc5j4MLmle9/OSmwe3p7RFyKGY8
         xjCI23sc575bSnQx+c0oxbK60AExa5A1JEFV7TZ12ePUz1hb/txvvnqDRR6Oblzk/2ZU
         fUKKt7PdzPW46Yy8deEJluANTRy4zdj+xyopTE34WuaRbiA66ihRytgdb3H7+jUWrvjE
         hnHHSDNPP8y6/m12FteyhXE10M7WYDPJNb9O/HRLBiQfjGWG8EDbI/rqYvbwp0/AZ4Cr
         igktvvAP3n26Y5tFdQeS2wfSPNW9r0pnwIAKHCmoQwum9C5mKetSDZ+Ame//J9/62ml0
         mRgQ==
X-Gm-Message-State: ACrzQf0mzG5qW30WSJt1d/cTmGZzP+jnn5Te+xENbHwptecdDT0KOD0B
        WA7AoW7aw4xCwcJdBpY+xIWuFNHUSuU=
X-Google-Smtp-Source: AMsMyM6ZlTAU2fZjIIVmKgDqi2Jy28eg2hO6cbbv5VTM18pkMBC/+PEQQkvWqFrLU3KWNJ5eYRCopg==
X-Received: by 2002:a17:90b:1d12:b0:200:461c:fa7d with SMTP id on18-20020a17090b1d1200b00200461cfa7dmr890669pjb.38.1663261028139;
        Thu, 15 Sep 2022 09:57:08 -0700 (PDT)
Received: from [192.168.68.90] ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id x22-20020a1709027c1600b0016c5306917fsm13140517pll.53.2022.09.15.09.57.07
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 09:57:07 -0700 (PDT)
Message-ID: <3de9eff3afe96a374a16e749dd80db00e5654730.camel@gmail.com>
Subject: Warning in ieee80211_build_preq_ies
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Date:   Thu, 15 Sep 2022 09:57:07 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I noticed this warning on 5.16, recompiled to 5.19 and still saw it.
Its happening on a UML kernel running many tests if that makes a
difference. It will happen several times during a full test run, warn
many times >60, then stop for a bit and repeat.

[ 1413.940000] ------------[ cut here ]------------
[ 1413.940000] WARNING: CPU: 0 PID: 1706 at include/net/cfg80211.h:608
ieee80211_build_preq_ies+0x766/0x84d
[ 1413.940000] Modules linked in:
[ 1413.940000] CPU: 0 PID: 1706 Comm: kworker/u2:2 Tainted: G        W
5.19.0 #1
[ 1413.940000] Workqueue: rad2 ieee80211_scan_work
[ 1413.940000] Stack:
[ 1413.940000]  605d0943 60256c96 60035421 00000001
[ 1413.940000]  6052cddd 60450efa 65d61dd9 60454c00
[ 1413.940000]  00000000 00000000 00000009 6003e77d
[ 1413.940000] Call Trace:
[ 1413.940000]  [<60256c96>] ? dump_stack_print_info+0xe1/0xef
[ 1413.940000]  [<60035421>] ? um_set_signals+0x0/0x3c
[ 1413.940000]  [<60450efa>] ? _printk+0x0/0x9f
[ 1413.940000]  [<60454c00>] ? dump_stack_lvl+0x47/0x52
[ 1413.940000]  [<6003e77d>] ? __warn+0xf2/0x123
[ 1413.940000]  [<604501bb>] ? warn_slowpath_fmt+0xd6/0xe2
[ 1413.940000]  [<60066c8c>] ? __wake_up_common+0x9e/0x121
[ 1413.940000]  [<604500e5>] ? warn_slowpath_fmt+0x0/0xe2
[ 1413.940000]  [<603d3bc5>] ? ieee80211_ie_split_ric+0xe4/0xfe
[ 1413.940000]  [<60035421>] ? um_set_signals+0x0/0x3c
[ 1413.940000]  [<604341ac>] ? ieee80211_vif_type_p2p+0x0/0x26
[ 1413.940000]  [<6043aeb5>] ? ieee80211_build_preq_ies+0x766/0x84d
[ 1413.940000]  [<60035449>] ? um_set_signals+0x28/0x3c
[ 1413.940000]  [<602c6e4b>] ? skb_queue_tail+0x43/0x47
[ 1413.940000]  [<60429f6c>] ? skb_put_zero+0x2c/0x34
[ 1413.940000]  [<60429f40>] ? skb_put_zero+0x0/0x34
[ 1413.940000]  [<6043b095>] ? ieee80211_build_probe_req+0xf9/0x161
[ 1413.940000]  [<6040c2ed>] ?
ieee80211_scan_state_send_probe+0xaf/0x14c
[ 1413.940000]  [<60051181>] ? queue_delayed_work_on+0x67/0x72
[ 1413.940000]  [<6040d1b0>] ? ieee80211_scan_work+0x40b/0x503
[ 1413.940000]  [<600529de>] ? process_one_work+0x1b0/0x2b1
[ 1413.940000]  [<6004f829>] ? move_linked_works+0x0/0x57
[ 1413.940000]  [<60053086>] ? worker_thread+0x270/0x39b
[ 1413.940000]  [<6004f909>] ? set_pf_worker+0x0/0x5f
[ 1413.940000]  [<60057231>] ? arch_local_irq_save+0x0/0x26
[ 1413.940000]  [<60035449>] ? um_set_signals+0x28/0x3c
[ 1413.940000]  [<60052e16>] ? worker_thread+0x0/0x39b
[ 1413.940000]  [<600588ef>] ? kthread_exit+0x0/0x37
[ 1413.940000]  [<60052e16>] ? worker_thread+0x0/0x39b
[ 1413.940000]  [<60058a6d>] ? kthread+0x11f/0x124
[ 1413.940000]  [<60035377>] ? unblock_signals+0x36/0xe0
[ 1413.940000]  [<60021f95>] ? new_thread_handler+0x86/0xbb
[ 1413.940000] ---[ end trace 0000000000000000 ]---
[ 1414.230000] ------------[ cut here ]------------

Probably a separate issue, but I also noticed this print on 5.19:

[ 1054.390000] wlan107: authenticate with 02:00:00:00:f1:00
[ 1054.390000] wlan107: bad VHT capabilities, disabling VHT
[ 1054.390000] wlan107: Invalid HE elem, Disable HE
[ 1054.390000] wlan107: 80 MHz not supported, disabling VHT

I don't think its related since I don't see this on 5.16, but still see
the crash.

Thanks,
James

