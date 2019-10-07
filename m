Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B836ACECA1
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2019 21:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfJGTVE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Oct 2019 15:21:04 -0400
Received: from mx1.ucr.edu ([138.23.248.2]:24429 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbfJGTVE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Oct 2019 15:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570476064; x=1602012064;
  h=mime-version:from:date:message-id:subject:to;
  bh=dallgVAkyTK9hhgH9V6Aj3NUK6xmHY7JKRhH0QVlX3E=;
  b=EKbVpPKjywFNLH9aQ13woJkbnDK73oqb8Oyfpw5zEBkisIbsl2iP060/
   3TFmCeo1TjKQBKwBFtZyUzFkh380kUgNX/KRdAKdfyKB63MbSKD1FyUCy
   5P4PHiAKMpGt/+/coJNoGvfmTQGf37tK/FiJfp0yF1z0DB1XL2obFqebA
   kr0AipuL2QWnjMGIz1P1mHPZ69hF5UxccfAvML/JvsCVOpNut5kBGj0Lx
   2YuUOo07YdEdpFh0dlcs9jehQFeGe/tc3w0bgRBA/e4Si0LG9vnT0Xm+C
   1nbDQ4reVzEWjigHqNIHYfoSuO9+2rCL6UIETjSzN4ucr8ZHW+mlYyeqd
   Q==;
IronPort-SDR: Y+CtJvOvU/DaRM85zyKBaRr6tS19uqdpsPmYKRh1TeYdXAdtvhr+6gJnr27I9DCUTyjLrpj6VT
 5CWur2GQ9ttpU+TIwdpkYAXKkRyiIo3lJaNvMgJG2Hrp9iUaTB8xK8lJZYKgbHr9+AwFCjJU9y
 j2A4FVJzC6zIkWot2/KeZYOmk/gBMzNaTGTJ7iSG3Tz7SqQ9NGdF1qdX1q+4dm1zmD0IDqaliI
 Fl2TvNvLY1pnttvF3a4N2Erh90NTp5JtYB2SFEUD9Pp1WnCYHdS1tGt60onEzHnDmenmmh9kNl
 DuI=
IronPort-PHdr: =?us-ascii?q?9a23=3A058OZBRCCZyPm/3XxX48Ny8y/Npsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZR2Pt8tkgFKBZ4jH8fUM07OQ7/m7HzFfqs/b6TgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrMkbjIltJqos1B?=
 =?us-ascii?q?fFv2ZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI63cokBAPcbPetAoIbzp1UAoxijCweyGOzi0SNIimPs0KEmz+?=
 =?us-ascii?q?gtDQPL0Qo9FNwOqnTUq9D1Ob8QXuC0zajIzSjDb/RL0jj+6IjHaBEhquyLUL?=
 =?us-ascii?q?NwcMvRyVMgFwLZglmMp4HoJC6V2fgXs2SB8eVvSP+vhnchpgpsoTav3t8hhp?=
 =?us-ascii?q?fVio8R0FzJ9iV0zJwrKdGkS0N3e8CoHIdMuyycKoB4WNktQ3tytyY/0rAGvJ?=
 =?us-ascii?q?m7czUUx5k/3B7fbuCHc5CP4hL+SOadOTd4i2xheLK4nxuy9FKvyuz4VsWt1F?=
 =?us-ascii?q?ZKrDdJnsDCtnwTyxDf9tKLSvR6/kem1jaP0x7c5vtYLkAzkKrXM58hwrgumZ?=
 =?us-ascii?q?oPqUnPADP6lUHsgKKVdkgo4Pak5/jkb7n8uJOQK5N4hhn7Mqs0m8y/Beo4Mh?=
 =?us-ascii?q?IJX2ie4em91Lzi/U3jT7VLkvE6jqfUvYvHJcsHvK61GRFa3Zs+6xqnFTepzM?=
 =?us-ascii?q?wYnWUbLFJCYB+Hi4npO1fTIPH3FPu+jVWskC11yPDCILLhGY7NI2PdkLfuY7?=
 =?us-ascii?q?l98VRQyAktwtBF4ZJbFLUBLOj0Wk/ru9yLRiM+Zi6zw+/hDthmnqkTQ23HVq?=
 =?us-ascii?q?2eMKrUt1KToOgiOeakZYkJtTK7IP8gsbqmoHo8kFkAcK3h8oEKbXqxFfQud0?=
 =?us-ascii?q?icZHPqn9oFV2gQow80RefqoFyETTNXIX21WvR4rhUmA4vuJoDOQoCqyOiFwS?=
 =?us-ascii?q?y6F5tRIGtBB1SMFl/pcZmJX7EHbyfEZodAlCAJUfCFSok8xVmRtRX3z7d8Na?=
 =?us-ascii?q?KA/iweqIL81dZ0z+zViRw2szdzCpLZm0KES2V51l0BQzh+iKNhqEh64lyE3a?=
 =?us-ascii?q?VxnuZfD9UV4OlGBENyFZfdyqRWEd3jVB/aZZ/dSF+nR5OqGzwgQM8q2PcPZV?=
 =?us-ascii?q?pwH5OpiRWVm2KDHb4anr2PTLMu86THw3XwIY4pwmjH26Agix8pWMpJLnGrh6?=
 =?us-ascii?q?hX9g7PCoqPmEKcweLicaUawT6I62aZwG6Dp1pwTgF9S+PGUGoZa0+Qqs72og?=
 =?us-ascii?q?vEQqOiBKoPLARM04iBJ7FMZ9mvik9JAL/nOdLDcyeyln22CBKg2LyBdszpdn?=
 =?us-ascii?q?8b0SGbD1IL10gh/XeXKA52PyaopSqKHjxvBE/pemvn6q9jo2n9Q0MpmUXCRE?=
 =?us-ascii?q?1s0bWk51YugvqTA6cYxbUCtw8qsHNpF0z70t7LXYmuvQ1kKZRdc9Mg5x911W?=
 =?us-ascii?q?vY/1hsLJypLvg63XYDeB4xsk/zgUYkQr5cmNQn+St5hDF5LriVhRYYL2uV?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FqAgBJjZtdf8jQVdFmDoYghE2OYYF?=
 =?us-ascii?q?tBYMlAYxQgRiKNAEIAQEBDi8BAYcfIzgTAgMJAQEFAQEBAQEFBAEBAhABAQk?=
 =?us-ascii?q?LCwgnhUKCOikBg1URfA8CJgIkEgEFASIBGhqFC6JqgQM8iyaBMoQLAQGEVgE?=
 =?us-ascii?q?JDYFIEnoojA6CF4ERgmSFFIMpglgEgTgBAQGVLJZUAQYCghAUjFSIRBuCKgG?=
 =?us-ascii?q?XFI4smUsPI4FGgXszGiV/BmeBT08QFI9aBAFWJJIcAQE?=
X-IPAS-Result: =?us-ascii?q?A2FqAgBJjZtdf8jQVdFmDoYghE2OYYFtBYMlAYxQgRiKN?=
 =?us-ascii?q?AEIAQEBDi8BAYcfIzgTAgMJAQEFAQEBAQEFBAEBAhABAQkLCwgnhUKCOikBg?=
 =?us-ascii?q?1URfA8CJgIkEgEFASIBGhqFC6JqgQM8iyaBMoQLAQGEVgEJDYFIEnoojA6CF?=
 =?us-ascii?q?4ERgmSFFIMpglgEgTgBAQGVLJZUAQYCghAUjFSIRBuCKgGXFI4smUsPI4FGg?=
 =?us-ascii?q?XszGiV/BmeBT08QFI9aBAFWJJIcAQE?=
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="12736708"
Received: from mail-lj1-f200.google.com ([209.85.208.200])
  by smtp1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2019 12:13:57 -0700
Received: by mail-lj1-f200.google.com with SMTP id y12so3798704ljc.8
        for <linux-wireless@vger.kernel.org>; Mon, 07 Oct 2019 12:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PJAtcYhKUx1R52oEkTsXsXK1JI9Wj7XIccCM13DifW8=;
        b=t1FV5S/Ta75AIX6P0xYWm6cA+TT0Ho4t+Smo4uFwftT6gEGSoRLoQZi2K4TB42rZyl
         A/qRoXY8jxkJBqaUAgdgC3ghvRarxTpfs16uPwo11/zBi7FrxRpVf2RcC9J0NQPJT26s
         MCl2XjuSROTsJ/JWgE9ybQ3+/ijzwJ159CMNy/1aBm0Sbf7TVADBp8W2kCgc+w4ErmBF
         b/UbQeCKqK/Mv7RMo4pwWjhd1R0R0aIU1wDGhOzzGmsypa/kav4JQ2wUgTdLLOMOIps6
         TkNerV5uSxBTLE4sH5FxNtTnYmQRtQRLXshhh9XCoasKyspnsQHJopYaDEH+0B+A0Qcw
         bQpg==
X-Gm-Message-State: APjAAAXnu5rv8Y8xwZExhCuqPFd/p/yR/phUrhLq+Z12+va+/04PhV0l
        GUHEVQqL0SFTHnyTgzndrpyYFWLNwtz3LRvInZ7jDV0XpM07ZYR9jgAxqju5viehue6QCjty75q
        sRbTJm8ToxEuYLNdN7Kfdyf5/eK4XLQ4OWbR4uSACR52C
X-Received: by 2002:a2e:a41b:: with SMTP id p27mr19601410ljn.104.1570475634276;
        Mon, 07 Oct 2019 12:13:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqybsfi5mH8tF9NrZD7sU22hacx7Zua94Z8/UMHxu/hlrhN5z+2JdKI5u1YfWM3R1sWLFJpjLuPHGGU6Fb/5yKU=
X-Received: by 2002:a2e:a41b:: with SMTP id p27mr19601397ljn.104.1570475634102;
 Mon, 07 Oct 2019 12:13:54 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Mon, 7 Oct 2019 12:14:37 -0700
Message-ID: <CABvMjLRtWPgMKR8t758DZ1AhynWC4LxG8bTVxiNGF4OJgtNsbg@mail.gmail.com>
Subject: Potential NULL pointer deference in iwlwifi
To:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Avigail Grinstein <avigail.grinstein@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi All:

drivers/net/wireless/intel/iwlwifi/mvm/power.c:

Inside function iwl_mvm_power_ps_disabled_iterator(),
iwl_mvm_vif_from_mac80211()
could return NULL,however, the return value of
iwl_mvm_vif_from_mac80211() is not
checked and get
used. This could potentially be unsafe.

-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
