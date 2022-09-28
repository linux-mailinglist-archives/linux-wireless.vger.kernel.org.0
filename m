Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B6F5EE9A9
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 00:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbiI1WtR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 18:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiI1WtP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 18:49:15 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDC21114F6
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 15:49:14 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id r8-20020a17090a560800b00205eaaba073so2884297pjf.1
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 15:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=EO1SU1X2FUBsNtFwmlpCnKck5Lg/0kTWiFSbiQDbQB8=;
        b=NihL1qOcRdAax6ULgQoRKIllcORIg7yrFvHYEtyiUkZatT4WeSdI1XfPmoylDoJ1bH
         SqdpsdihA9saSvAeQn2C4e85rlN5+6IGQGY4/6Q6/tYIZEdNDZXLyoj4c3eVuxQIEKsO
         oRliHiGWH35ufYd1/TwmHfs6baDWGHMFI+pOdsCs9YzMRiut29AY4zSRfmhOHoLXYZwu
         b0F7nsmKj7a4zM8AiYk7Zfb1VAt6a3qHA2L/GYRTLvRtV3R6Xgqe5fDj+qVpHlImAJ5q
         5ydUXKRr+680zs8AS5asVl5NksKMoK8+aOh/uq56tXV0K54kTzomJAjf711NXeAirTgP
         escA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=EO1SU1X2FUBsNtFwmlpCnKck5Lg/0kTWiFSbiQDbQB8=;
        b=wLJv5tzqhcXuhRJ+M3krJqQFEvMMRSor03DpAs6s6uTGh1jf0rJhKYZj++cdMHgimq
         goCnm5/+2nNKFOlKoKflrIRblzzjl11zZt0XMx79BFimNEuInylw/mFfq9omFpmSR/fN
         w11qmmiEKY1MhHujicjFlvT3k5/6Bu0UZefCpuxlRz6sxKHtRoLP/y3jfUmQ377xsNNq
         x4j01x81lq0bA6nIfFZ2xxxh5xQBn50N528MYEAUZ0kntCZfR+xdZO1pp2J1n3hxcz3u
         DDbRS7oMcE55WXrx7AEswzeyu6HUYDfrjOgUWKuDDj/dEjCpIfiP/d+s8hFmEcmICnMD
         bz+Q==
X-Gm-Message-State: ACrzQf39WUi3Nkmb2FXbNH5dHaDEafr6416dMSxDKQHuOfvW8zP0Zh8e
        QkAy+Ykzo7C5pAsihOHV33cblPrjD5U=
X-Google-Smtp-Source: AMsMyM43V9NUSod2OtBGTTumTJqHoSGkIZe4sLVGf3luThC9BtPO9bo4KNc545sA3XpdDxj8qHxIJQ==
X-Received: by 2002:a17:902:d50b:b0:178:3ea4:2945 with SMTP id b11-20020a170902d50b00b001783ea42945mr195810plg.67.1664405353816;
        Wed, 28 Sep 2022 15:49:13 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id ob6-20020a17090b390600b001f2fa09786asm643738pjb.19.2022.09.28.15.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 15:49:13 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 0/1] Fix potential HE IE bug and some other questions
Date:   Wed, 28 Sep 2022 15:49:09 -0700
Message-Id: <20220928224910.453232-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I believe there is a bug when building the probe request IEs for the
HE capabilities. More info in the patch. While looking at this I
noticed some other confusing code related to building the probe
request.

Looking at ieee80211_build_preq_ies. It is passed 'bands_used' which
is a bitmask of bands. A probe request is only sent out on a single
band so why would this contain multiple bands? We then loop over these
bands and call ieee80211_build_preq_ies_band for each one.
This, AFAICT, would append the same IEs multiple times if 'bands_used'
contained more than one band. Internal to mac80211/util.c its only
passed BIT(chan->band), but mac80211/scan.c seems to pass a list...

Below is the warning I am seeing (many, many times). It says the warning
is in build_preq_ies, but it really seems like this is not correct
and its actually in ieee80211_get_he_6ghz_capa since I see no warning
message as others _should_ have.

[  732.130000] ------------[ cut here ]------------
[  732.130000] WARNING: CPU: 0 PID: 1352 at include/net/cfg80211.h:608 ieee80211_build_preq_ies+0x766/0x84d
[  732.130000] Modules linked in:
[  732.130000] CPU: 0 PID: 1352 Comm: kworker/u2:0 Tainted: G        W         5.19.0 #1
[  732.130000] Workqueue: rad6 ieee80211_scan_work
[  732.130000] Stack:
[  732.130000]  605d0943 60256c96 60035421 00000001
[  732.130000]  6052cddd 60450efa 61f3d5d9 60454c00
[  732.130000]  00000000 00000000 00000009 6003e77d
[  732.130000] Call Trace:
[  732.130000]  [<60256c96>] ? dump_stack_print_info+0xe1/0xef
[  732.130000]  [<60035421>] ? um_set_signals+0x0/0x3c
[  732.130000]  [<60450efa>] ? _printk+0x0/0x9f
[  732.130000]  [<60454c00>] ? dump_stack_lvl+0x47/0x52
[  732.130000]  [<6003e77d>] ? __warn+0xf2/0x123
[  732.130000]  [<60035449>] ? um_set_signals+0x28/0x3c
[  732.130000]  [<604501bb>] ? warn_slowpath_fmt+0xd6/0xe2
[  732.130000]  [<6042830f>] ? ieee80211_prepare_and_rx_handle+0xbf4/0xc22
[  732.130000]  [<604500e5>] ? warn_slowpath_fmt+0x0/0xe2
[  732.130000]  [<603d3bc5>] ? ieee80211_ie_split_ric+0xe4/0xfe
[  732.130000]  [<60035421>] ? um_set_signals+0x0/0x3c
[  732.130000]  [<604341ac>] ? ieee80211_vif_type_p2p+0x0/0x26
[  732.130000]  [<6043aeb5>] ? ieee80211_build_preq_ies+0x766/0x84d
[  732.130000]  [<60035377>] ? unblock_signals+0x36/0xe0
[  732.130000]  [<60429f6c>] ? skb_put_zero+0x2c/0x34
[  732.130000]  [<60429f40>] ? skb_put_zero+0x0/0x34
[  732.130000]  [<6043b095>] ? ieee80211_build_probe_req+0xf9/0x161
[  732.130000]  [<6040c2ed>] ? ieee80211_scan_state_send_probe+0xaf/0x14c
[  732.130000]  [<60051181>] ? queue_delayed_work_on+0x67/0x72
[  732.130000]  [<6040d1b0>] ? ieee80211_scan_work+0x40b/0x503
[  732.130000]  [<6040cda5>] ? ieee80211_scan_work+0x0/0x503
[  732.130000]  [<600529de>] ? process_one_work+0x1b0/0x2b1
[  732.130000]  [<6004f829>] ? move_linked_works+0x0/0x57
[  732.130000]  [<60053086>] ? worker_thread+0x270/0x39b
[  732.130000]  [<6004f909>] ? set_pf_worker+0x0/0x5f
[  732.130000]  [<60057231>] ? arch_local_irq_save+0x0/0x26
[  732.130000]  [<60035449>] ? um_set_signals+0x28/0x3c
[  732.130000]  [<60052e16>] ? worker_thread+0x0/0x39b
[  732.130000]  [<600588ef>] ? kthread_exit+0x0/0x37
[  732.130000]  [<60052e16>] ? worker_thread+0x0/0x39b
[  732.130000]  [<60058a6d>] ? kthread+0x11f/0x124
[  732.130000]  [<60035377>] ? unblock_signals+0x36/0xe0
[  732.130000]  [<60021f95>] ? new_thread_handler+0x86/0xbb
[  732.130000] ---[ end trace 0000000000000000 ]---
[  732.210000] ------------[ cut here ]------------


James Prestwood (1):
  wifi: mac80211: fix probe req HE capabilities access

 net/mac80211/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.3

