Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6ED24CC8D
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 06:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgHUEUI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 00:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgHUEUG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 00:20:06 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD603C061386
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 21:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=WK61CoSkyOL4dv/L5xauqEYwrEMONUpdDyzw94fklX4=; b=oDuOJuiGzkafI4mfU9sXebiAgI
        LhCe6krwaynADq8U6eJGyAU55uMWq75ED88mdbEaAV79+3UHpTpUL24z/D24DnM08ElNqQa9TC1au
        nN8PLFSsV/TYE3dxYqxY/AapSJrnFa7sdBRGsEzvs95JGXdqpvFCQU1Wc2Ds1eUa8jyY=;
Received: from p5b206497.dip0.t-ipconnect.de ([91.32.100.151] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k8yX5-0005s7-Gx; Fri, 21 Aug 2020 06:20:03 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v2 00/13] mac80211 encapsulation offload / performance patches
Date:   Fri, 21 Aug 2020 06:19:48 +0200
Message-Id: <20200821042001.23388-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v2:
- add cover letter
- fix netdev ops for vlan interfaces
- make multicast traffic fall back to non-offload path to support sw crypto
- use ieee80211_tx_status_ext as replacements for ieee80211_free_txskb
  (the latter does not work with encap offload packets)
- add api for bulk free after tx status


Felix Fietkau (13):
  mac80211: rework tx encapsulation offload API
  mac80211: reduce duplication in tx status functions
  mac80211: remove tx status call to ieee80211_sta_register_airtime
  mac80211: optimize station connection monitor
  mac80211: swap NEED_TXPROCESSING and HW_80211_ENCAP tx flags
  mac80211: unify 802.3 (offload) and 802.11 tx status codepath
  mac80211: add missing queue/hash initialization to 802.3 xmit
  mac80211: check and refresh aggregation session in encap offload tx
  mac80211: support using ieee80211_tx_status_ext to free skbs without
    status info
  mac80211: extend ieee80211_tx_status_ext to support bulk free
  mac80211: notify the driver when a sta uses 4-address mode
  mac80211: skip encap offload for tx multicast/control packets
  mac80211: set info->control.hw_key for encap offload packets

 drivers/net/wireless/ath/ath11k/dp_tx.c |   4 +-
 drivers/net/wireless/ath/ath11k/mac.c   |  61 ++++---
 include/net/mac80211.h                  |  49 +++++-
 net/mac80211/cfg.c                      |   6 +
 net/mac80211/debugfs.c                  |   1 +
 net/mac80211/driver-ops.h               |  29 ++++
 net/mac80211/ieee80211_i.h              |   5 +-
 net/mac80211/iface.c                    | 204 ++++++++++++++++------
 net/mac80211/key.c                      |  23 +--
 net/mac80211/mesh_hwmp.c                |   4 +-
 net/mac80211/mesh_ps.c                  |   2 +-
 net/mac80211/mlme.c                     |  56 +++---
 net/mac80211/rx.c                       |  11 +-
 net/mac80211/sta_info.h                 |   2 -
 net/mac80211/status.c                   | 218 +++++++++---------------
 net/mac80211/trace.h                    |  33 ++++
 net/mac80211/tx.c                       |  96 +++++------
 17 files changed, 451 insertions(+), 353 deletions(-)

-- 
2.28.0

