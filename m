Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A51D764745
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 08:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjG0Gxo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 02:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjG0Gxn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 02:53:43 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AD926AE
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 23:53:41 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a3a8d12040so1433042b6e.3
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 23:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690440821; x=1691045621;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x/jtX+SLT8ZNWdrA+Z3ciysS69lKVgG1Od2heohuNHA=;
        b=KLivRxwcNSMuBDie91142F17LH51FbehQR/FjtuOJI2d0IkM9qmhZZLg9rdCGN2jlO
         pHw+DVUjAogsdTCiUOUs/NjOcx6YtnC4zNG68OXuGNuaJkfXziNA2VInxIU8AaIsEL19
         X1eS75ESTUJ2MiNxGmi3kuMiVrjWJQK5JgNuwf/fNvQ0K1j+pxOS/0/NpLHJpvnv8rv8
         q7P23CaRNy6gVTzCyDx7yVZLA29xBGJ7RhY51JV1L2JC0Q7BCO1J/ZvLR3uyjxPykrRj
         n3Hziadn7AebosE8VBPIkqSKAAHv3k3O4GGzO3y+O3eZniOOqbIZncR+IX3N5CEgG6lA
         RXnw==
X-Gm-Message-State: ABy/qLbJNRojRGCzW+zvnTOyQ/604TKux4+oBWh1/NEVF9b15zh7Ohj3
        V/lLoN+t2B4myaBYdCFAqHqbt3DAwJbzKdtk+yixOlzRK3a4
X-Google-Smtp-Source: APBJJlF2na5TM7DdbhtaIyNBRisOAh+2TTguu02KW7Ut5goTUpZr7zOGmkRcViS7vt1DCKrpF/5rGE47zyv/84Dex0FgO494eVpn
MIME-Version: 1.0
X-Received: by 2002:a05:6808:21a0:b0:3a1:e58d:aae0 with SMTP id
 be32-20020a05680821a000b003a1e58daae0mr4375306oib.3.1690440820847; Wed, 26
 Jul 2023 23:53:40 -0700 (PDT)
Date:   Wed, 26 Jul 2023 23:53:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a3fa6a0601726caf@google.com>
Subject: [syzbot] Monthly wireless report (Jul 2023)
From:   syzbot <syzbot+list84f2b8b519927d59bce1@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
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

During the period, 5 new issues were detected and 0 were fixed.
In total, 37 issues are still open and 106 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  7904    Yes   KMSAN: uninit-value in hwsim_cloned_frame_received_nl
                   https://syzkaller.appspot.com/bug?extid=b2645b5bf1512b81fa22
<2>  6500    Yes   WARNING in ieee80211_bss_info_change_notify
                   https://syzkaller.appspot.com/bug?extid=09d1cd2f71e6dd3bfd2c
<3>  4787    Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<4>  4223    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<5>  1571    Yes   WARNING in ieee80211_link_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=de87c09cc7b964ea2e23
<6>  1361    No    WARNING in ieee80211_ibss_csa_beacon (2)
                   https://syzkaller.appspot.com/bug?extid=b10a54cb0355d83fd75c
<7>  808     Yes   WARNING in ar5523_submit_rx_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=6101b0c732dea13ea55b
<8>  737     Yes   WARNING in __rate_control_send_low
                   https://syzkaller.appspot.com/bug?extid=fdc5123366fb9c3fdc6d
<9>  666     Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<10> 475     Yes   INFO: task hung in rfkill_global_led_trigger_worker (2)
                   https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
