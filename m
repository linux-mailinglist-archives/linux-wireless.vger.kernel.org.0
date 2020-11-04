Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448CD2A5E0F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 07:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgKDGTK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 01:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgKDGTK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 01:19:10 -0500
Received: from rhcavuit02.kulnet.kuleuven.be (rhcavuit02.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD02BC061A4D
        for <linux-wireless@vger.kernel.org>; Tue,  3 Nov 2020 22:19:09 -0800 (PST)
X-KULeuven-Envelope-From: mathy.vanhoef@kuleuven.be
X-Spam-Status: not spam, SpamAssassin (cached, score=-51, required 5,
        autolearn=disabled, ALL_TRUSTED -1.00, LOCAL_SMTPS -50.00)
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 829DA120334.AFB27
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-smtps-2.cc.kuleuven.be (icts-p-smtps-2e.kulnet.kuleuven.be [134.58.240.34])
        by rhcavuit02.kulnet.kuleuven.be (Postfix) with ESMTP id 829DA120334
        for <linux-wireless@vger.kernel.org>; Wed,  4 Nov 2020 07:19:00 +0100 (CET)
Received: from mathy-work.localhost (unknown [92.96.39.204])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by icts-p-smtps-2.cc.kuleuven.be (Postfix) with ESMTPSA id 7143E200A1;
        Wed,  4 Nov 2020 07:18:58 +0100 (CET)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 0/5] mac80211: implement DONT_REORDER radiotap flag
Date:   Wed,  4 Nov 2020 10:18:18 +0400
Message-Id: <20201104061823.197407-1-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The radiotap TX flags field has recently been properly standardized,
including a new DONT_REORDER bit. This set of patches implements
the new DONT_REORDER bit in mac80211 and for selected drivers.

Mathy Vanhoef (5):
  mac80211: add radiotap flag to assure frames are not reordered
  mac80211: adhere to Tx control flag that prevents frame reordering
  mac80211: don't overwrite QoS TID of injected frames
  mac80211: assure that certain drivers adhere to DONT_REORDER flag
  ath9k_htc: adhere to the DONT_REORDER transmit flag

 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c |  7 ++++++-
 include/net/ieee80211_radiotap.h              |  1 +
 include/net/mac80211.h                        |  4 ++++
 net/mac80211/tx.c                             | 13 +++++++++----
 net/mac80211/wme.c                            | 15 +++++++++++++--
 5 files changed, 33 insertions(+), 7 deletions(-)

-- 
2.28.0

