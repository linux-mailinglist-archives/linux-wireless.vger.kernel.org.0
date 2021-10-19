Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4AD43353B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 13:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhJSMBv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 08:01:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhJSMBu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 08:01:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59247610E7;
        Tue, 19 Oct 2021 11:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634644778;
        bh=AHof4fE4HKD/9CIKNfHVNZ1gxrtHfzRzfgGd0EgL1Hg=;
        h=From:To:Cc:Subject:Date:From;
        b=bERyOOoAmSDB5/yQz2gU4DIywnXeEiA6k5uvZZGxInQPvCY2/z9dWVOdqDpQOgaYY
         42wooEdGTqFa68k+aUPVfmdzezcOqX7HAkdUW/b4UuZsP2KgFrFlxa47XjMErXl3NJ
         89T7vHVRpf1yn4b4AW8cqRSVqAadOATTYPLt9tn3RBYX9UfO8lEEji15ok1lqBYO1O
         WhBD7kbRf1r06vCdcmLvZu6SZ85WCoZYZWGWM8zDPa45n+TOEyx+t3mIomAJvD1nCw
         Jz/S8VmK2I/fyZq8vIrlad1ppYWFEq78Bjwo3R76oy6SpU0hoJdHYsB4rgl1Dy1vwt
         LAFknvPdTdxfA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com
Subject: [PATCH mac80211-next 0/4] add offchannel radar chain support
Date:   Tue, 19 Oct 2021 13:59:03 +0200
Message-Id: <cover.1634644309.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce the capability to configure a dedicated chain available for radar
detection on some hw (e.g. mt7915). The driver is supposed to implement CAC
management in sw or fw while hostapd will implement the logic to select and
configure the monitored channel.
Using a dedicated chain to perform the CAC, the AP can avoid the CAC downtime
switching to a new DFS channel.

Changes since rfc:
- rely on NL80211_CMD_RADAR_DETECT netlink msg to configure offchannel radar
  chain

Lorenzo Bianconi (4):
  mac80211: introduce set_radar_offchan callback
  cfg80211: introduce NL80211_ATTR_RADAR_OFFCHAN netlink attribute
  cfg80211: introduce cfg80211_cac_offchan_event routine
  cfg80211: introduce NL80211_EXT_FEATURE_RADAR_OFFCHAN feature flag

 include/net/cfg80211.h       | 19 +++++++++++++++++++
 include/net/mac80211.h       |  5 +++++
 include/uapi/linux/nl80211.h | 10 ++++++++++
 net/mac80211/cfg.c           | 13 +++++++++++++
 net/wireless/mlme.c          | 26 ++++++++++++++++++++++++++
 net/wireless/nl80211.c       | 16 ++++++++++++++--
 net/wireless/rdev-ops.h      | 17 +++++++++++++++++
 net/wireless/trace.h         | 19 +++++++++++++++++++
 8 files changed, 123 insertions(+), 2 deletions(-)

-- 
2.31.1

