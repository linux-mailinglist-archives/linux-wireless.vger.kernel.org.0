Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371167B1B51
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 13:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjI1Lmh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 07:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjI1Lmg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 07:42:36 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0FE126
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 04:42:34 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6c61ada4178so7698280a34.0
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 04:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695901353; x=1696506153;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qTaDubZXEWSEPslgclOxwc7+Ad3m/lBvUqQUG3lQH1U=;
        b=VfTH1i1gX/umr/5ku1Np2tnkV6Ic/ANoIyUyNfwL/KehXjavrZrc5ghP+xL6g0yYXq
         2Z0WtTs/jNed3GXbjmt19cNIRUj7kB1MVYAiDYPNaNqyO47prDRYmC5i2UrGMCuI59Nz
         HdkSnJiC3tCy0L+cdmGAhL1xuj6W4ZvJSUB5hJOsOoNTlbY3Te3VAQrim5i8nHydMLMt
         iiiEwsaVaj3HXnryJQDi5kCdoKdDQxuNmDipEI/8sgBbN1pOwh1biQYtr4W6n0M6M3zr
         X99Vb//a/fHuRoPKtzRj1F59Coc0icuWJXW8m2eMlmsvTfV2Lkx0vVU/ORXewAvGvnGa
         JhcQ==
X-Gm-Message-State: AOJu0YyNcmXzNTA2hDJSRJClyuT8NRdCb1KJ9L2PHGHYzxsinkk5DVS/
        wZDs7wjhyIFZrUvVa1eQsxFO4sD8ZTRRgZX1Rio7gchoWmoV
X-Google-Smtp-Source: AGHT+IGzJDdL7CGRqLCO9dfIof4cK7XxRZfPS6R1Yj25M96dgd53FV7gcHWycFeFD3YcwU49Wd3DOxR7JcS43H35tFBpUrBbu5Nt
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3086:b0:3a7:3ced:532a with SMTP id
 bl6-20020a056808308600b003a73ced532amr381328oib.7.1695901353486; Thu, 28 Sep
 2023 04:42:33 -0700 (PDT)
Date:   Thu, 28 Sep 2023 04:42:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bfaf33060669cd6b@google.com>
Subject: [syzbot] Monthly wireless report (Sep 2023)
From:   syzbot <syzbot+liste709cb91ac7b8a619720@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 2 new issues were detected and 0 were fixed.
In total, 28 issues are still open and 115 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5399    Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  4322    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<3>  3473    Yes   WARNING in ieee80211_rx_list
                   https://syzkaller.appspot.com/bug?extid=8830db5d3593b5546d2e
<4>  2422    Yes   WARNING in ieee80211_link_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=de87c09cc7b964ea2e23
<5>  2066    No    WARNING in ieee80211_ibss_csa_beacon (2)
                   https://syzkaller.appspot.com/bug?extid=b10a54cb0355d83fd75c
<6>  870     Yes   WARNING in __rate_control_send_low
                   https://syzkaller.appspot.com/bug?extid=fdc5123366fb9c3fdc6d
<7>  816     Yes   WARNING in ar5523_submit_rx_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=6101b0c732dea13ea55b
<8>  693     Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<9>  475     No    INFO: task hung in ath9k_hif_usb_firmware_cb (2)
                   https://syzkaller.appspot.com/bug?extid=d5635158fb0281b27bff
<10> 55      Yes   WARNING in ieee80211_free_ack_frame (2)
                   https://syzkaller.appspot.com/bug?extid=ac648b0525be1feba506

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
