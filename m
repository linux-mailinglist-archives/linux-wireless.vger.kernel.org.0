Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484AF22BDB0
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jul 2020 07:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgGXFsj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jul 2020 01:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgGXFsj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jul 2020 01:48:39 -0400
Received: from rhcavuit04.kulnet.kuleuven.be (rhcavuit04.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29EDC0619D3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 22:48:38 -0700 (PDT)
X-KULeuven-Envelope-From: mathy.vanhoef@kuleuven.be
X-Spam-Status: not spam, SpamAssassin (cached, score=-51, required 5,
        autolearn=disabled, ALL_TRUSTED -1.00, LOCAL_SMTPS -50.00)
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 86501120337.AECD6
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-smtps-1.cc.kuleuven.be (icts-p-smtps-1e.kulnet.kuleuven.be [134.58.240.33])
        by rhcavuit04.kulnet.kuleuven.be (Postfix) with ESMTP id 86501120337
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jul 2020 07:48:33 +0200 (CEST)
Received: from mathy-work.localhost (unknown [176.205.50.14])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by icts-p-smtps-1.cc.kuleuven.be (Postfix) with ESMTPSA id 41C5740B2;
        Fri, 24 Jul 2020 07:48:32 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [RFC 0/5] Add radiotap flag to prevent frame reordering
Date:   Fri, 24 Jul 2020 09:47:19 +0400
Message-Id: <20200724054724.105520-1-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a flag to radiotap's Tx flag field to prevent frame reordering
and assure that selected drivers also adhere to this flag. Previously,
injected frames might otherwise be reordered relative to each other
before transmission based on their QoS TID priority.

This is a new radiotag flag and, I assume, will first have to be
approved by the radiotap standard. I'll send a mail to the radiotap
mailing list shortly to start this discussion/process.

These patches depend on the patch set "[PATCH 0/6] mac80211: monitor
mode injection fixes". I can single out the individual patches that
it depends on if needed.

Mathy Vanhoef (5):
  mac80211: add radiotap flag to assure frames are not reordered
  mac80211: adhere to Tx control flag that prevents frame reordering
  mac80211: don't overwrite QoS TID of injected frames
  mac80211: assure that certain drivers adhere to DONT_REORDER flag
  ath9k_htc: adhere to the DONT_REORDER transmit flag

 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c |  7 ++++++-
 include/net/ieee80211_radiotap.h              |  1 +
 include/net/mac80211.h                        |  4 ++++
 net/mac80211/tx.c                             | 12 ++++++++----
 net/mac80211/wme.c                            | 15 +++++++++++++--
 5 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.27.0

