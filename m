Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69CFCCB46D
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 08:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbfJDGWR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 02:22:17 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:54104 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730687AbfJDGWR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 02:22:17 -0400
Received: by mail-vk1-f202.google.com with SMTP id q5so2178130vkg.20
        for <linux-wireless@vger.kernel.org>; Thu, 03 Oct 2019 23:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eM+TtTHjE2md44io/60oVnM+vsz9X/uBFBALUtWj+xs=;
        b=q2JcCcXfsNyJ3p+aeik6xkH3hQdkASeAggPZN+xi4dxEM6VhW2wHAo6C/1xCkewMG6
         fmuB38Is0vuGeG/I/EdSIBgXpNjijmWL0NBOwufDALuiGzNtJBG+zewt39cZ46sNDE9l
         beKkH8yJe0ZnDAsq/oyvpq86Vi9BB80hdaBet9wsKlcdv87dHK4LRNukldiR3qli32qz
         AVursi1QK6c999rfSzPQc4QhkGzPY67chDI2F41+5UQoL4yT/FgQViDvaPfMma7wGuts
         5uCLo5krjyKelgAS4Vz17+xiZ7JUX935//GeY8vIQI8VAdqSACGD8zlB/TtPIflu7YYi
         7Xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eM+TtTHjE2md44io/60oVnM+vsz9X/uBFBALUtWj+xs=;
        b=rK69Wr0FDFfDgaYhLAcFYO0G3hF7Zhpe6C/KsKX1qPVGzX1iTHBZiGMlwu5a7WpW2p
         gbdi9/keGlZS/MVOUzVdTuoXe1cqCAPSk7B7kFZob64ifoKqjuRt8KaN1RFujwcjb/mL
         r7+hR5E97QfgVixlO7fPrxo2AhVmWK+71S4KtIi6rYHuE+yn98YMhBuoTaHjiuvPUusg
         p9TV86jW4CtQkg06osF7IDKo/JzUGz7ayWdbaOgHsEiA4on7/1KqG8orJPg0rx96LIEJ
         p31gRPbFITDlrwXjfOc952DaeeGv4bXLlzHvz7NBX7evbd4YarT3lhFCiyqQrl5HAg/8
         0TyQ==
X-Gm-Message-State: APjAAAVnK1DZoSLY+3DfCPQGb7GPS79O7DrTcliWCcctpjRvmYtdWhU8
        vS0AqoK/uRBIfe1IwsbckGxy2LIn
X-Google-Smtp-Source: APXvYqxUccMsePcOD0ey5XMo6FbbGwMiL63goML8dUj35j03ydqjILlgCleA59QWbi1apog6q161B2aG
X-Received: by 2002:a1f:5c0d:: with SMTP id q13mr7209330vkb.38.1570170134477;
 Thu, 03 Oct 2019 23:22:14 -0700 (PDT)
Date:   Thu,  3 Oct 2019 23:21:49 -0700
Message-Id: <20191004062151.131405-1-kyan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH 0/2] Implement Airtime-based Queue Limit (AQL)
From:   Kan Yan <kyan@google.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, toke@redhat.com,
        nbd@nbd.name, yiboz@codeaurora.org, Kan Yan <kyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series implements Airtime-based Queue Limit (AQL) in the mac80211 and Ath10k driver. It is based on an earlier version from the ChromiumOS tree[0]. 

This version has been tested with QCA9884 platform with 4.14 kernel. Tests show AQL is able to reduce latency by an order of magnitude in a congested environment without negative impact on the throughput.

[0] https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1703105/7

Kan Yan (2):
  mac80211: Implement Airtime-based Queue Limit (AQL)
  ath10k: Enable Airtime-based Queue Limit (AQL)

 drivers/net/wireless/ath/ath10k/mac.c  |  7 ++-
 drivers/net/wireless/ath/ath10k/txrx.c | 12 +++-
 include/net/cfg80211.h                 |  7 +++
 include/net/mac80211.h                 | 34 +++++++++++
 net/mac80211/debugfs.c                 | 79 ++++++++++++++++++++++++++
 net/mac80211/debugfs_sta.c             | 43 ++++++++++----
 net/mac80211/ieee80211_i.h             |  4 ++
 net/mac80211/main.c                    |  7 ++-
 net/mac80211/sta_info.c                | 23 ++++++++
 net/mac80211/sta_info.h                |  4 ++
 net/mac80211/tx.c                      | 60 +++++++++++++++----
 11 files changed, 253 insertions(+), 27 deletions(-)

-- 
