Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC8E6ED389
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Apr 2023 19:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjDXRdw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Apr 2023 13:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjDXRdv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Apr 2023 13:33:51 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56836A59
        for <linux-wireless@vger.kernel.org>; Mon, 24 Apr 2023 10:33:43 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-760c58747cdso725086339f.0
        for <linux-wireless@vger.kernel.org>; Mon, 24 Apr 2023 10:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682357623; x=1684949623;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7xMk9SBOyp+I3icJY6amD5jkR7wUoKwtCs5nuOfK7o=;
        b=YDVacHzixVP07ownFb5dK37ndavIF7I3kJVQ1TnaDN3Fu1EVD2hqtkoa3QMlVXKOov
         gxgRU8b9RxrLnWfhzrIw89LKHJIDz0XocEo2CjKuPAsAJKsdb5Virq65TFr1CXfL5B0f
         gdqslhrQAdpAsJVTQObBbxeTsJma79it5Xqc6BUcA3/tmnLDP4LkJekmNF6xZ9znUZmA
         vg0maRAa58+1EATCvplji5v8raN09IYHkp2U9Lpy1lpiF6QGglS5ZqBfEGy4I7RkE5a1
         v+GaeKM5afx7NP2ClrCHhcy9f72fzKX/mSZu7vqYR/kLNSfJOPa5XDYJ3LoURGvn1Wnf
         6yRA==
X-Gm-Message-State: AAQBX9fVHqMdP3cNLYiIylfwRcXIlXP8qn75z7LbmZFBJDlWJFZk9aLT
        FvPGGj1LYYRQxweWxNbrBWcCd8rD5DNv2BibcW1lKNN3joeF
X-Google-Smtp-Source: AKy350Z2E1p0Tcjtba0WE5yKa8Oh25OghkiAt8B7o7zqzEpXUWTPhqX58dVcVdWUK14iqAI9baGz/+5/dYVCRFEAXrF/83zxz09j
MIME-Version: 1.0
X-Received: by 2002:a5d:9cd8:0:b0:760:ec21:a8ab with SMTP id
 w24-20020a5d9cd8000000b00760ec21a8abmr4995456iow.0.1682357623224; Mon, 24 Apr
 2023 10:33:43 -0700 (PDT)
Date:   Mon, 24 Apr 2023 10:33:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084816805fa1868e4@google.com>
Subject: [syzbot] Monthly wireless report
From:   syzbot <syzbot+list9f4a29a9c608b1bb6d72@syzkaller.appspotmail.com>
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

During the period, 1 new issues were detected and 0 were fixed.
In total, 34 issues are still open and 102 have been fixed so far.

Some of the still happening issues:

Crashes Repro Title
6997    Yes   KMSAN: uninit-value in hwsim_cloned_frame_received_nl
              https://syzkaller.appspot.com/bug?extid=b2645b5bf1512b81fa22
4553    Yes   WARNING in ieee80211_bss_info_change_notify
              https://syzkaller.appspot.com/bug?extid=09d1cd2f71e6dd3bfd2c
4131    Yes   WARNING in __cfg80211_ibss_joined (2)
              https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
3464    Yes   WARNING in __ieee80211_beacon_get
              https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
590     No    WARNING in ieee80211_ibss_csa_beacon (2)
              https://syzkaller.appspot.com/bug?extid=b10a54cb0355d83fd75c
565     Yes   WARNING in ieee80211_start_next_roc
              https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
413     Yes   WARNING in ieee80211_link_info_change_notify (2)
              https://syzkaller.appspot.com/bug?extid=de87c09cc7b964ea2e23
309     Yes   INFO: task hung in rfkill_global_led_trigger_worker (2)
              https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb
166     Yes   INFO: trying to register non-static key in skb_queue_tail
              https://syzkaller.appspot.com/bug?extid=743547b2a7fd655ffb6d
37      Yes   WARNING in ieee80211_free_ack_frame (2)
              https://syzkaller.appspot.com/bug?extid=ac648b0525be1feba506

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.
