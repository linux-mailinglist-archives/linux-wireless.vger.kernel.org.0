Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AAE22AC11
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jul 2020 12:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgGWKDP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jul 2020 06:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgGWKDO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jul 2020 06:03:14 -0400
Received: from rhcavuit02.kulnet.kuleuven.be (rhcavuit02.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B66C0619DC
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 03:03:13 -0700 (PDT)
X-KULeuven-Envelope-From: mathy.vanhoef@kuleuven.be
X-Spam-Status: not spam, SpamAssassin (not cached, score=-50.999, required 5,
        autolearn=disabled, ALL_TRUSTED -1.00, LOCAL_SMTPS -50.00,
        URIBL_BLOCKED 0.00)
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 32382120341.AE90A
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-smtps-2.cc.kuleuven.be (icts-p-smtps-2e.kulnet.kuleuven.be [134.58.240.34])
        by rhcavuit02.kulnet.kuleuven.be (Postfix) with ESMTP id 32382120341
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 12:03:08 +0200 (CEST)
Received: from mathy-work.localhost (unknown [176.205.50.14])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by icts-p-smtps-2.cc.kuleuven.be (Postfix) with ESMTPSA id 34179200A1;
        Thu, 23 Jul 2020 12:03:07 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 3/6] mac80211: do not overwrite the sequence number if requested
Date:   Thu, 23 Jul 2020 14:01:50 +0400
Message-Id: <20200723100153.31631-3-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723100153.31631-1-Mathy.Vanhoef@kuleuven.be>
References: <20200723085126.29127-1-Mathy.Vanhoef@kuleuven.be>
 <20200723100153.31631-1-Mathy.Vanhoef@kuleuven.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Check if the Tx control flag is set to prevent sequence number overwrites,
and if so, do not assign a new sequence number to the transmitted frame.

Signed-off-by: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
---
 net/mac80211/tx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 040b0ef18..cc5068999 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -824,6 +824,9 @@ ieee80211_tx_h_sequence(struct ieee80211_tx_data *tx)
 	if (ieee80211_is_qos_nullfunc(hdr->frame_control))
 		return TX_CONTINUE;
 
+	if (info->control.flags & IEEE80211_TX_CTRL_NO_SEQNO)
+		return TX_CONTINUE;
+
 	/*
 	 * Anything but QoS data that has a sequence number field
 	 * (is long enough) gets a sequence number from the global
-- 
2.27.0

