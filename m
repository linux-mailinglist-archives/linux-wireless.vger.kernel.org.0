Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7582AA923B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 21:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732644AbfIDTNy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 15:13:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38609 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732132AbfIDTNy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 15:13:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id d10so7194228pgo.5
        for <linux-wireless@vger.kernel.org>; Wed, 04 Sep 2019 12:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wbOZPW+Xz7Cizq/rnUW56b8b2RD0Yxl0fL5ryXda7Og=;
        b=WDwteHI9MzJFtMeEKKyAcqJVnhpfG6vNgqT43jJRd/cb2RTK46Zp9zUiMPEheUyAyC
         LWNr+KIirAHAtAo+4Y610DEIlePa/V+ZywTV1YFws/Z5706k2t3MG5HXfIwSNs6Es6xr
         D2gEYQ8Y7MaJCXggVuy8M7o1UtsJq1Je+YrsAzDS8iRZk7YumuyRdvVq4aesROH6PULP
         QZtUNxocuEO2zznt77HFKFVd1UwPuz1hROxy/ElVa00g4WzAmW90OPN6MZXbJLZE2z4F
         k51yVK6T6TWGOnKlej6O6+wTIfycGA9FgTs24JCiSlbtiZ3CLG2Cz4kwgDy0vEZwyXC3
         BNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wbOZPW+Xz7Cizq/rnUW56b8b2RD0Yxl0fL5ryXda7Og=;
        b=Fl1i5pP850TGo81ToslPY/k4s4asQPntZoftbP9TAagVU3WXLCHHTfdIo4jnPaZ8Q1
         MI69RZD4HhNBaUVWYs7VoHwqy6DKVb8QtsBdM4qLih/POlJYIIVlJcbnGOLO2Bvcgz0R
         pEUUeCUVEfc8MlTkznmf6wpqO2rqy7XVbCo1Qy9wqtc3vDrb+0Wg/w2vIPxZ3kM9SDdJ
         uqA/TCDiYP8we722yLC0RHT5uaemsvC1iK8PqgHFwUGKFQPH13Vt3mlwnulSeRQHlbii
         t3s8R/9Bd2tyfvisU3NM5+lUtVvFBRgnfk/lfXr+ydIZb5V6bJDOGkJrvJ2GUIJwExe/
         7Ruw==
X-Gm-Message-State: APjAAAXOd4CHmFeYxRogP2pFt0ALQx3QBCs3fBm3R0KTKG6qRB0qM68X
        UlOG+UO6ZuU8xyB81/6QAW+JmHJBuO0=
X-Google-Smtp-Source: APXvYqw0oZaXWAWwwCwBsNWRypJ2mL3YZnvgYV0dTkDXagW1gCaoQVwWhED2vQaNoeUPjOAzAPGpuQ==
X-Received: by 2002:a17:90a:ad88:: with SMTP id s8mr6260587pjq.53.1567624433085;
        Wed, 04 Sep 2019 12:13:53 -0700 (PDT)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id u7sm18849727pgr.94.2019.09.04.12.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 12:13:52 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [RFC 0/4] Allow live MAC address change
Date:   Wed,  4 Sep 2019 12:11:51 -0700
Message-Id: <20190904191155.28056-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This set enables userspace to change the devices MAC address via RTNL
or CMD_CONNECT/CMD_AUTHENTICATE without bringing the device down then
back up. This has several benefits:

 - Simplifies user space logic. No longer requires tracking multiple
   RTNL/netlink message transactions (down, change mac, up, connect).
 - Drastically speeds up connection times when changing MAC on a
   per-connect basis.
 - Eliminates potential race conditions in userspace. At any time
   during the down/change/up sequence the device could be hot
   unplugged or something could go wrong in the kernel leaving
   userspace in an unknown state.

A new extended feature was added,
NL80211_EXT_FEATURE_LIVE_ADDRESS_CHANGE which is set if the device
supports this feature. This feature is enabled by default for mac80211
based drivers.

A new NL80211 attribute was added, NL80211_ATTR_MAC_TO_CHANGE. This
attribute can be used with CMD_CONNECT/CMD_AUTHENTICATE to change the
MAC address automatically without having to go through RTNL.

I have taken some timings for all 3 ways of changing the MAC. Powered
change via RTNL, non powered via RTNL, and changing through
CMD_CONNECT. All times were taken in microseconds and tested on an
Intel 7260 PCI wireless adapter:

Powered via RTNL:

Average: 294508.9
Min: 284523
Max: 300345

==================================
Non-Powered via RTNL:

Average: 14824.7
Min: 11037
Max: 17812

Speedup from powered change: 19.87x (average)

==================================
via CMD_CONNECT:

Average: 11848.7
Min: 9748
Max: 17152

Speedup from powered change: 24.86x (average)

==================================

The speed increases between powered and non-powered are quite
impressive. Besides the obvious speedup, the amount of code requred
for userspace to take advantage of this feature is extremely small
(via CMD_CONNECT, essentially a feature check and an extra attribute).
In addition, the changes/complexity to the kernel is minimal.

James Prestwood (4):
  nl80211: Add LIVE_ADDR_CHANGE feature
  {nl|cfg}80211: Support mac change as part of SME Connect
  mac80211: Support LIVE_ADDRESS_CHANGE feature
  {nl,cfg}nl80211: Support mac change for mlme_authenticate

 include/net/cfg80211.h       |  1 +
 include/uapi/linux/nl80211.h | 10 +++++++
 net/mac80211/iface.c         | 51 ++++++++++++++++++++++++++++++++++--
 net/mac80211/main.c          |  1 +
 net/wireless/core.h          |  4 ++-
 net/wireless/mlme.c          |  9 ++++++-
 net/wireless/nl80211.c       | 18 ++++++++++++-
 net/wireless/sme.c           |  9 ++++++-
 net/wireless/util.c          | 11 ++++++++
 9 files changed, 108 insertions(+), 6 deletions(-)

-- 
2.17.1

