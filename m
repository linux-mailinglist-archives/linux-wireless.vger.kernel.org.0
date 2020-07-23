Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8138F22AB16
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jul 2020 10:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgGWIwH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jul 2020 04:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgGWIwG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jul 2020 04:52:06 -0400
Received: from rhcavuit03.kulnet.kuleuven.be (rhcavuit03.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D409EC0619DC
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 01:52:05 -0700 (PDT)
X-KULeuven-Envelope-From: mathy.vanhoef@kuleuven.be
X-Spam-Status: not spam, SpamAssassin (cached, score=-51, required 5,
        autolearn=disabled, ALL_TRUSTED -1.00, LOCAL_SMTPS -50.00)
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: CAE78120330.AED28
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-smtps-2.cc.kuleuven.be (icts-p-smtps-2e.kulnet.kuleuven.be [134.58.240.34])
        by rhcavuit03.kulnet.kuleuven.be (Postfix) with ESMTP id CAE78120330
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 10:51:58 +0200 (CEST)
Received: from mathy-work.localhost (unknown [176.205.50.14])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by icts-p-smtps-2.cc.kuleuven.be (Postfix) with ESMTPSA id 8FDB1200A3;
        Thu, 23 Jul 2020 10:51:57 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To:     vanhoefm@gmail.com, Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, mathy.vanhoef@nyu.edu
Cc:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 0/6] mac80211: monitor mode injection fixes
Date:   Thu, 23 Jul 2020 12:51:21 +0400
Message-Id: <20200723085126.29127-1-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This set of patches fixes some bugs related to frame injection, adds
an existing radiotap flag to avoid sequence number overwrites, avoids
an out-of-bounds memory read when injecting frames, and makes the
usage of certain Tx flags more consistent.

Mathy Vanhoef (6):
  mac80211: never drop injected frames even if normally not allowed
  mac80211: add radiotap flag to prevent sequence number overwrite
  mac80211: do not overwrite the sequence number if requested
  mac80211: use same flag everywhere to avoid sequence number overwrite
  mac80211: remove unused flags argument in transmit functions
  mac80211: parse radiotap header when selecting Tx queue

 include/net/ieee80211_radiotap.h |  1 +
 include/net/mac80211.h           | 11 +++++
 net/mac80211/cfg.c               |  2 +-
 net/mac80211/ieee80211_i.h       | 12 ++---
 net/mac80211/iface.c             | 15 ++++--
 net/mac80211/offchannel.c        |  2 +-
 net/mac80211/rx.c                |  2 +-
 net/mac80211/scan.c              |  7 ++-
 net/mac80211/sta_info.c          |  2 +-
 net/mac80211/tx.c                | 81 +++++++++++++++-----------------
 10 files changed, 72 insertions(+), 63 deletions(-)

-- 
2.27.0

