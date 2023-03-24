Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7BB6C8141
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Mar 2023 16:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjCXPd5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Mar 2023 11:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCXPd4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Mar 2023 11:33:56 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60B1126E7
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 08:33:54 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id l8-20020a056e02066800b003247f2ba648so1401256ilt.5
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 08:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679672034;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eLycQxPJh5ctdiAHM+TFhyOKcExHz+mFKF6NIvcUHOA=;
        b=Id5vfVckk+FbT6doTH0gSc3qTTzXLLF0u334xZNu46X1eKIq4i/Rh90pb7IyPnaKsN
         +n16CdRuJ6wRBVWqxIyym7aAYb5lQCo9eocf3u7VLLw91fQc5oCxbD/MWTjVbPTsVPA2
         pkyTcP7NyzmsKzZ8IGYTFw89KsN73cr9W0aXkHgRgG6EbpXgNYv/Z2jTIYNo9j/k2Vtz
         5wuCUdBgHUTHjGtePUSKKLj+l7ol+ipNsUx2fHEbY4sRHy6r4uvqTpsmK8qgo+gVDnsH
         KuaiG8MxugDsRFLhFY338RxQF5/ywy6Dyd+QLUTfNvT+f3aj9utHII2fYaJoTA4IoiHX
         tLMQ==
X-Gm-Message-State: AO0yUKUUKwHW0HwhtoslpPu4N4bt02GARPbxvdgpy1XxeCpTE9xhwiGT
        RM9CC75KtOtXXTDqwtiBRRNOFEjWfolTpUcwMyjMn7i62X4o
X-Google-Smtp-Source: AK7set8UfRAmUJZ9Pdv22DQTYvQa4B67nyUY5YX08xzcbn8+rNZj62ZJYHmhaEpOsXfVcdvNZq5UIPZ8gpDieG2iTXihb54QJ+SK
MIME-Version: 1.0
X-Received: by 2002:a02:95c4:0:b0:406:2a80:467a with SMTP id
 b62-20020a0295c4000000b004062a80467amr1109851jai.0.1679672033950; Fri, 24 Mar
 2023 08:33:53 -0700 (PDT)
Date:   Fri, 24 Mar 2023 08:33:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec461d05f7a71e38@google.com>
Subject: [syzbot] [wireless] Monthly Report
From:   syzbot <syzbot+listd50b9cb19229e38c60c8@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello wireless maintainers/developers,

This is a 30-day syzbot report for wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 6 new issues were detected and 0 were fixed.
In total, 45 issues are still open and 102 have been fixed so far.

Some of the still happening issues:

Crashes Repro Title
6721    Yes   KMSAN: uninit-value in hwsim_cloned_frame_received_nl
              https://syzkaller.appspot.com/bug?extid=b2645b5bf1512b81fa22
4059    Yes   WARNING in __cfg80211_ibss_joined (2)
              https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
3067    Yes   WARNING in __ieee80211_beacon_get
              https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
806     Yes   INFO: task hung in switchdev_deferred_process_work (2)
              https://syzkaller.appspot.com/bug?extid=8ecc009e206a956ab317
558     Yes   WARNING in __rate_control_send_low
              https://syzkaller.appspot.com/bug?extid=fdc5123366fb9c3fdc6d
517     Yes   WARNING in ieee80211_start_next_roc
              https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
245     Yes   INFO: task hung in rfkill_global_led_trigger_worker (2)
              https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb
232     Yes   WARNING in ieee80211_link_info_change_notify (2)
              https://syzkaller.appspot.com/bug?extid=de87c09cc7b964ea2e23
196     No    WARNING in ieee80211_ibss_csa_beacon (2)
              https://syzkaller.appspot.com/bug?extid=b10a54cb0355d83fd75c
10      Yes   KMSAN: uninit-value in ath9k_wmi_ctrl_rx
              https://syzkaller.appspot.com/bug?extid=f2cb6e0ffdb961921e4d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.
