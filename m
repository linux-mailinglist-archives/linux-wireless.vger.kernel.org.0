Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C542A5E11
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 07:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgKDGTZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 01:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgKDGTZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 01:19:25 -0500
Received: from rhcavuit04.kulnet.kuleuven.be (rhcavuit04.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4377C061A4D
        for <linux-wireless@vger.kernel.org>; Tue,  3 Nov 2020 22:19:24 -0800 (PST)
X-KULeuven-Envelope-From: mathy.vanhoef@kuleuven.be
X-Spam-Status: not spam, SpamAssassin (not cached, score=-50.999, required 5,
        autolearn=disabled, ALL_TRUSTED -1.00, LOCAL_SMTPS -50.00,
        URIBL_BLOCKED 0.00)
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 7327B120333.A2861
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-smtps-2.cc.kuleuven.be (icts-p-smtps-2e.kulnet.kuleuven.be [134.58.240.34])
        by rhcavuit04.kulnet.kuleuven.be (Postfix) with ESMTP id 7327B120333
        for <linux-wireless@vger.kernel.org>; Wed,  4 Nov 2020 07:19:17 +0100 (CET)
Received: from mathy-work.localhost (unknown [92.96.39.204])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by icts-p-smtps-2.cc.kuleuven.be (Postfix) with ESMTPSA id BEDE2200A1;
        Wed,  4 Nov 2020 07:19:12 +0100 (CET)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 1/5] mac80211: add radiotap flag to assure frames are not reordered
Date:   Wed,  4 Nov 2020 10:18:19 +0400
Message-Id: <20201104061823.197407-2-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104061823.197407-1-Mathy.Vanhoef@kuleuven.be>
References: <20201104061823.197407-1-Mathy.Vanhoef@kuleuven.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a new radiotap flag to indicate injected frames must not be
reordered relative to other frames that also have this flag set,
independent of priority field values in the transmitted frame.
Parse this radiotap flag and define and set a corresponding Tx
control flag. Note that this flag has recently been standardized
as part of an update to radiotap.

Signed-off-by: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
---
 include/net/ieee80211_radiotap.h | 1 +
 include/net/mac80211.h           | 4 ++++
 net/mac80211/tx.c                | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/include/net/ieee80211_radiotap.h b/include/net/ieee80211_radiotap.h
index 19c00d100..c0854933e 100644
--- a/include/net/ieee80211_radiotap.h
+++ b/include/net/ieee80211_radiotap.h
@@ -118,6 +118,7 @@ enum ieee80211_radiotap_tx_flags {
 	IEEE80211_RADIOTAP_F_TX_RTS = 0x0004,
 	IEEE80211_RADIOTAP_F_TX_NOACK = 0x0008,
 	IEEE80211_RADIOTAP_F_TX_NOSEQNO = 0x0010,
+	IEEE80211_RADIOTAP_F_TX_ORDER = 0x0020,
 };
 
 /* for IEEE80211_RADIOTAP_MCS "have" flags */
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index e8e295dae..69864b5ef 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -856,6 +856,9 @@ enum mac80211_tx_info_flags {
  *	it can be sent out.
  * @IEEE80211_TX_CTRL_NO_SEQNO: Do not overwrite the sequence number that
  *	has already been assigned to this frame.
+ * @IEEE80211_TX_CTRL_DONT_REORDER: This frame should not be reordered
+ *	relative to other frames that have this flag set, independent
+ *	of their QoS TID or other priority field values.
  *
  * These flags are used in tx_info->control.flags.
  */
@@ -868,6 +871,7 @@ enum mac80211_tx_control_flags {
 	IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP	= BIT(5),
 	IEEE80211_TX_INTCFL_NEED_TXPROCESSING	= BIT(6),
 	IEEE80211_TX_CTRL_NO_SEQNO		= BIT(7),
+	IEEE80211_TX_CTRL_DONT_REORDER		= BIT(8),
 };
 
 /*
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 8ba10a48d..d4e1a2720 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2102,6 +2102,9 @@ bool ieee80211_parse_tx_radiotap(struct sk_buff *skb,
 				info->flags |= IEEE80211_TX_CTL_NO_ACK;
 			if (txflags & IEEE80211_RADIOTAP_F_TX_NOSEQNO)
 				info->control.flags |= IEEE80211_TX_CTRL_NO_SEQNO;
+			if (txflags & IEEE80211_RADIOTAP_F_TX_ORDER)
+				info->control.flags |=
+					IEEE80211_TX_CTRL_DONT_REORDER;
 			break;
 
 		case IEEE80211_RADIOTAP_RATE:
-- 
2.28.0

