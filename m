Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5660070C76
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2019 00:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfGVWUb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jul 2019 18:20:31 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:40150 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfGVWUb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jul 2019 18:20:31 -0400
Received: by mail-wr1-f42.google.com with SMTP id r1so40983972wrl.7
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2019 15:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ppIUpipRX4KZ9BVCFMexwgN+9PMSZfXKvecPVJddrZo=;
        b=s9ygLDw+aEvfn6yl5Q5es98VMNMcqu9AG29WWMxIawhfEGvKhoF73N8rHo2HaMNAmV
         ybx4NlY677BaJGGYaP1fWUdCMBrgGy+Vd/7VFdxWeC4YdFQOTIURJIsDJkwaFir+DhC5
         1cmKscrIgor1aKkqwQKrYxQcSwfaj18EZwhJJt7554pJI4YfQeXj/6KA+Eqmj6ekn6hC
         NPB0XAhJeYld1yO1Z0QRZUUsQ3MXfFpvEOxMH3imOxeCdA7KtRTxqWMDk+y4lT8i5RSs
         1lazofp28q8OQL38fLLi4vdzb2JvhTDsAD2PcliqEEePh04VpstoqLvyOjn6Vnk6kn6s
         zXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ppIUpipRX4KZ9BVCFMexwgN+9PMSZfXKvecPVJddrZo=;
        b=O87Qe2SMX+QLaL8UeJrF7yQYoxmtIYt0fl2h7TdjFy+TmL6/Peaw0mG+t3zt93gvkw
         JXlRlr+P+lOJrFoUyJC8Je4RJxTgYvrelpBkXZzv1i249lk3rPQzMR+uig/1gceQIShQ
         ERl2x6j9x2ME3lhoJSkmpyWssT37s5Q8TwpVO02FN2bfIlYaEXbh7rr9P4zbKZyyJcGc
         /nbPQFPrduWoDYxwkib6+AwjHxvS5lRMCjQFq2c/vwEiwauq6BObnYegxc+ZFLBK0yzd
         bgRJ/SeTmrrTzFsyaEJBJ51QcwwjrQEpgI8ZdjqYgcyqRcO4eD3s6Q1aJ3LDWjRuUBOc
         L80g==
X-Gm-Message-State: APjAAAW5rC0g6TQsGsK/JhMqseK8G9hgCsFRdMFJrwMoNiZ30ifgZaD6
        YvSUOZ8TD5odW5fZrkRi3H74CT3Pb/sdppXIt+rwQA==
X-Google-Smtp-Source: APXvYqwrhs/cd8fBL2rlGBoSpdxP9pr4Km0Do9zXomiWU453TyNo+GsjKgXdT6LZaJZS4Z0dA88mwP7b5eSr2YU6rEQ=
X-Received: by 2002:adf:b1cb:: with SMTP id r11mr72059186wra.328.1563834028682;
 Mon, 22 Jul 2019 15:20:28 -0700 (PDT)
MIME-Version: 1.0
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 22 Jul 2019 15:20:16 -0700
Message-ID: <CALAqxLXrB0YvdK=MgbbF94QcQwqPV-FvHtm=uOVURuphFx=OfA@mail.gmail.com>
Subject: TI wlcore wifi not loading w/ v5.3-rc1
To:     Kalle Valo <kvalo@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hey folks,

Testing on my HiKey960, I'm seeing:
[    8.894909] wlcore: wl18xx HW: 183x or 180x, PG 2.2 (ROM 0x11)
[    8.902017] ------------[ cut here ]------------
[    8.906832] WARNING: CPU: 0 PID: 5 at net/wireless/core.c:868
wiphy_register+0x8b4/0xc08
[    8.914932] Modules linked in:
[    8.917999] CPU: 0 PID: 5 Comm: kworker/0:0 Tainted: G S
    5.3.0-rc1-00095-g1ddb90492e79 #504
[    8.927657] Hardware name: HiKey960 (DT)
[    8.931590] Workqueue: events request_firmware_work_func
[    8.936904] pstate: 60400005 (nZCv daif +PAN -UAO)
[    8.941704] pc : wiphy_register+0x8b4/0xc08
[    8.945891] lr : wiphy_register+0x8b4/0xc08
[    8.950076] sp : ffffff801006bbf0
[    8.953390] x29: ffffff801006bbf0 x28: 0000000000000000
[    8.958704] x27: 000000000000002d x26: 0000000000000001
[    8.964019] x25: 000000000000002f x24: 0000000000000000
[    8.969334] x23: ffffffc217505d98 x22: ffffffc217503f00
[    8.974650] x21: ffffff80117c9000 x20: 00000000000007dc
[    8.979963] x19: ffffffc217504300 x18: ffffffffffffffff
[    8.985276] x17: 0000000000000000 x16: 0000000000000000
[    8.990592] x15: ffffff80117c9a88 x14: ffffff809006b957
[    8.995908] x13: ffffff801006b965 x12: ffffff80117f0000
[    9.001223] x11: 0000000005f5e0ff x10: ffffff801006b8f0
[    9.006537] x9 : ffffff80117c9ac0 x8 : ffffff801054b798
[    9.011852] x7 : 00000000000002ad x6 : 0000000000000028
[    9.017168] x5 : ffffff8011d72dd8 x4 : 0000000000000000
[    9.022482] x3 : 0000000000000000 x2 : 1814804b8988b000
[    9.027800] x1 : 0000000000000000 x0 : 0000000000000024
[    9.033113] Call trace:
[    9.035559]  wiphy_register+0x8b4/0xc08
[    9.039396]  ieee80211_register_hw+0x43c/0xb88
[    9.043846]  wlcore_nvs_cb+0x8c8/0xae0
[    9.047603]  request_firmware_work_func+0x48/0x88
[    9.052310]  process_one_work+0x1f0/0x430
[    9.056321]  worker_thread+0x48/0x4b0
[    9.059987]  kthread+0x128/0x130
[    9.063219]  ret_from_fork+0x10/0x1c
[    9.066792] ---[ end trace bfe1c71ef18337b1 ]---
[    9.071626] wlcore: ERROR unable to register mac80211 hw: -22

Which seems to be caused by commit 901bb9891855 ("nl80211: require and
validate vendor command policy"), and I've validated that reverting
that gets it working again.

It seems like from the commit message, the wlcore driver isn't
providing the policy values the network core expects? I'm not sure
what the right fix would be, but wanted to raise the issue.

Suggestions?

thanks
-john
