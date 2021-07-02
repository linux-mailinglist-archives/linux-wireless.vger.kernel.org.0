Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B3F3BA3B7
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jul 2021 19:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhGBRqu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jul 2021 13:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229609AbhGBRqu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jul 2021 13:46:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03BA8613E9;
        Fri,  2 Jul 2021 17:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625247858;
        bh=w4SiONw9FTD7ZB223IAzrut6MQ5hpp5K3Z9JO+2bjK4=;
        h=From:To:Cc:Subject:Date:From;
        b=gK0BUEhTv/JRcW2LXqkWCt/YgJQXLYq8xFA0Ks4/UGyB9IR16Bh7HlmjSWvxUGUig
         QBd6cyyvcJhFCdyuQt1gjPpjFYsx9y+1J2pTev94ySLMnvgtEb67EQ28mcOMkV4nZA
         OQ3B1iYqyhembtyX9YCITIPK6FMds5aYnuJhOfp3lPKfIqKSKEoiVfM/Fc6NDp2Dp3
         W4GzJafbFEAML6Y/vEOsNpevX4kbFTznSndBPHdDevDgmJf6x/t6cUtMooO7HhYMtk
         v7aQpZ44vOMNSiU2eEnFVWxz1uKO9PlIs8MHHsItfTTf7oEWoKucroHfeiUURJVSok
         pWy0MC1jPTNWg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     john@phrozen.org, nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com,
        dan.carpenter@oracle.com
Subject: [PATCH v9 mac80211-next 0/3] mac80211: add BSS color change support
Date:   Fri,  2 Jul 2021 19:44:06 +0200
Message-Id: <cover.1625247619.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series adds support for BSS color collission detection and change.

Changes since v8:
- fix a possible NULL pointer dereference in ieee80211_set_beacon_cntdwn()

Changes since v7:
- always notify the driver about bss change in
  ieee80211_color_change_finalize()
- add mt7915 bss color support

Changes since v6:
- rebase on top of mac80211-next
- fix check_patch issues
- alloc nlattr tb array dynamically in nl80211_color_change
- move NL80211_ATTR_CNTDWN_OFFS_BEACON and NL80211_ATTR_CNTDWN_OFFS_PRESP
  in NL80211_ATTR_COLOR_CHANGE_ELEMS as nested attributes
- remove unused definitions
- remove mbss series dependency
- remove ath11k code

John Crispin (2):
  nl80211: add support for BSS coloring
  mac80211: add support for BSS color change

Acked-by: Ryder Lee <ryder.lee@mediatek.com>

Lorenzo Bianconi (1):
  mt76: mt7915: introduce bss coloring support

 .../net/wireless/mediatek/mt76/mt7915/init.c  |   1 +
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  26 ++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  84 +++++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  21 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   2 +
 include/net/cfg80211.h                        |  92 +++++++
 include/net/mac80211.h                        |  29 +++
 include/uapi/linux/nl80211.h                  |  43 ++++
 net/mac80211/cfg.c                            | 234 +++++++++++++++++-
 net/mac80211/ieee80211_i.h                    |  11 +
 net/mac80211/iface.c                          |   2 +
 net/mac80211/tx.c                             |  29 ++-
 net/wireless/nl80211.c                        | 157 ++++++++++++
 net/wireless/rdev-ops.h                       |  13 +
 net/wireless/trace.h                          |  46 ++++
 15 files changed, 739 insertions(+), 51 deletions(-)

-- 
2.31.1

