Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC93261F5D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 22:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732651AbgIHUC0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 16:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730487AbgIHPek (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 11:34:40 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A3DC061365
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 05:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=A7yXgNYE7yBLGT3eB1jHUtOeKcGlCa4RsyEFXxnSJd0=; b=kaGupuTraFOjg8sbaetIVr/FgH
        BcshdKlfOEhMQF6h4VBE+NsSFZIxZVW4Tz2VB/hpHuZK8oxMA+wgQ7OWRji6ToFsdSa8qZZLbrOo+
        6lbDEgDpyndW4VPe3lW30lAvGaK4LQ3u9XywZ2ojYloFlC8LtfWlmLi+AVQHnDG9PZQE=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kFcrw-00050i-E3; Tue, 08 Sep 2020 14:37:04 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v4 00/14] mac80211 encapsulation offload / performance patches
Date:   Tue,  8 Sep 2020 14:36:48 +0200
Message-Id: <20200908123702.88454-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v4:
- reorder patches
- instead of disabling offload when tkip or sw crypto is used, fall back
  in the tx handler
- add patch to remove a forward declaration
- remove unnecessary checks for p2p go/client and add a comment instead

v3:
- fix sta pointer and skb info pointer in ieee80211_tx_status_ext skb free patch

v2:
- add cover letter
- fix netdev ops for vlan interfaces
- make multicast traffic fall back to non-offload path to support sw crypto
- use ieee80211_tx_status_ext as replacements for ieee80211_free_txskb
  (the latter does not work with encap offload packets)
  - add api for bulk free after tx status

Felix Fietkau (14):
  mac80211: add missing queue/hash initialization to 802.3 xmit
  mac80211: check and refresh aggregation session in encap offload tx
  mac80211: skip encap offload for tx multicast/control packets
  mac80211: set info->control.hw_key for encap offload packets
  mac80211: rework tx encapsulation offload API
  mac80211: reduce duplication in tx status functions
  mac80211: remove tx status call to ieee80211_sta_register_airtime
  mac80211: optimize station connection monitor
  mac80211: swap NEED_TXPROCESSING and HW_80211_ENCAP tx flags
  mac80211: unify 802.3 (offload) and 802.11 tx status codepath
  mac80211: support using ieee80211_tx_status_ext to free skbs without
    status info
  mac80211: extend ieee80211_tx_status_ext to support bulk free
  mac80211: notify the driver when a sta uses 4-address mode
  mac80211: reorganize code to remove a forward declaration

 drivers/net/wireless/ath/ath11k/dp_tx.c |    4 +-
 drivers/net/wireless/ath/ath11k/mac.c   |   61 +-
 include/net/mac80211.h                  |   49 +-
 net/mac80211/cfg.c                      |    1 +
 net/mac80211/debugfs.c                  |    1 +
 net/mac80211/driver-ops.h               |   29 +
 net/mac80211/ieee80211_i.h              |    5 +-
 net/mac80211/iface.c                    | 1573 ++++++++++++-----------
 net/mac80211/key.c                      |   15 -
 net/mac80211/mesh_hwmp.c                |    4 +-
 net/mac80211/mesh_ps.c                  |    2 +-
 net/mac80211/mlme.c                     |   56 +-
 net/mac80211/rx.c                       |   11 +-
 net/mac80211/sta_info.h                 |    2 -
 net/mac80211/status.c                   |  219 ++--
 net/mac80211/trace.h                    |   33 +
 net/mac80211/tx.c                       |  113 +-
 17 files changed, 1119 insertions(+), 1059 deletions(-)

-- 
2.28.0

