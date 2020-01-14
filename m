Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 568DB13A0D8
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2020 07:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgANGFq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jan 2020 01:05:46 -0500
Received: from mail.adapt-ip.com ([173.164.178.19]:56840 "EHLO
        mail.adapt-ip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgANGFq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jan 2020 01:05:46 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.adapt-ip.com (Postfix) with ESMTP id BF23E2F0A45;
        Tue, 14 Jan 2020 05:59:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at web.adapt-ip.com
Received: from mail.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PmrUVZbAliwR; Mon, 13 Jan 2020 21:59:41 -0800 (PST)
Received: from tractor.ibsgaard.io (c-73-202-5-52.hsd1.ca.comcast.net [73.202.5.52])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: thomas@adapt-ip.com)
        by mail.adapt-ip.com (Postfix) with ESMTPSA id F0FC02F0A2E;
        Mon, 13 Jan 2020 21:59:40 -0800 (PST)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v3 0/2] more STA PS fixes and mac80211_hwsim PS support
Date:   Mon, 13 Jan 2020 21:59:38 -0800
Message-Id: <20200114055940.18502-1-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset adds power save support to mac80211_hwsim, and fixes some
lingering bugs in mac80211 STA PS related to (QoS) nullfunc probing.

The hostap hwsim test failures initially observed[0] have been
"resolved" by disabling STA PS by default. It turns out STA PS behavior
violates some assumption for eg. the bgscan_simple_beacon_loss test
where a beacon loss event was expected instead of a disconnect event,
which is triggered because hwsim can now do nullfunc probing. For the
p2p failures I really have no idea :)

[0]:
https://lore.kernel.org/linux-wireless/43f4d446d7f8b9a08e091ab811fbf99bf00da2af.camel@sipsolutions.net/

Thomas Pedersen (2):
  mac80211_hwsim: add power save support
  mac80211: add ieee80211_is_any_nullfunc()

 drivers/net/wireless/mac80211_hwsim.c | 9 +++++++++
 include/linux/ieee80211.h             | 9 +++++++++
 net/mac80211/mlme.c                   | 2 +-
 net/mac80211/rx.c                     | 8 +++-----
 net/mac80211/status.c                 | 5 ++---
 net/mac80211/tx.c                     | 2 +-
 6 files changed, 25 insertions(+), 10 deletions(-)

-- 
2.20.1

