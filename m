Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F2D22AC10
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jul 2020 12:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgGWKDL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jul 2020 06:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgGWKDI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jul 2020 06:03:08 -0400
Received: from rhcavuit01.kulnet.kuleuven.be (rhcavuit01.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D0BC0619DC
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 03:03:08 -0700 (PDT)
X-KULeuven-Envelope-From: mathy.vanhoef@kuleuven.be
X-Spam-Status: not spam, SpamAssassin (cached, score=-50.999, required 5,
        autolearn=disabled, ALL_TRUSTED -1.00, LOCAL_SMTPS -50.00,
        URIBL_BLOCKED 0.00)
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 0C07F12033F.A3D92
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-smtps-2.cc.kuleuven.be (icts-p-smtps-2e.kulnet.kuleuven.be [134.58.240.34])
        by rhcavuit01.kulnet.kuleuven.be (Postfix) with ESMTP id 0C07F12033F
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 12:03:05 +0200 (CEST)
Received: from mathy-work.localhost (unknown [176.205.50.14])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by icts-p-smtps-2.cc.kuleuven.be (Postfix) with ESMTPSA id DE86C200A3;
        Thu, 23 Jul 2020 12:03:03 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 2/6] mac80211: add radiotap flag to prevent sequence number overwrite
Date:   Thu, 23 Jul 2020 14:01:49 +0400
Message-Id: <20200723100153.31631-2-Mathy.Vanhoef@kuleuven.be>
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

The radiotap specification contains a flag to indicate that the sequence
number of an injected frame should not be overwritten. Parse this flag
and define and set a corresponding Tx control flag.

Signed-off-by: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
---
 include/net/ieee80211_radiotap.h | 1 +
 include/net/mac80211.h           | 3 +++
 net/mac80211/tx.c                | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/include/net/ieee80211_radiotap.h b/include/net/ieee80211_radiotap.h
index 459d355f6..19c00d100 100644
--- a/include/net/ieee80211_radiotap.h
+++ b/include/net/ieee80211_radiotap.h
@@ -117,6 +117,7 @@ enum ieee80211_radiotap_tx_flags {
 	IEEE80211_RADIOTAP_F_TX_CTS = 0x0002,
 	IEEE80211_RADIOTAP_F_TX_RTS = 0x0004,
 	IEEE80211_RADIOTAP_F_TX_NOACK = 0x0008,
+	IEEE80211_RADIOTAP_F_TX_NOSEQNO = 0x0010,
 };
 
 /* for IEEE80211_RADIOTAP_MCS "have" flags */
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 11d5610d2..6615fe450 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -825,6 +825,8 @@ enum mac80211_tx_info_flags {
  * @IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP: This frame skips mesh path lookup
  * @IEEE80211_TX_CTRL_HW_80211_ENCAP: This frame uses hardware encapsulation
  *	(header conversion)
+ * @IEEE80211_TX_CTRL_NO_SEQNO: Do not overwrite the sequence number that
+ *	has already been assigned to this frame.
  *
  * These flags are used in tx_info->control.flags.
  */
@@ -836,6 +838,7 @@ enum mac80211_tx_control_flags {
 	IEEE80211_TX_CTRL_FAST_XMIT		= BIT(4),
 	IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP	= BIT(5),
 	IEEE80211_TX_CTRL_HW_80211_ENCAP	= BIT(6),
+	IEEE80211_TX_CTRL_NO_SEQNO		= BIT(7),
 };
 
 /*
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 62d01ab26..040b0ef18 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2084,6 +2084,8 @@ static bool ieee80211_parse_tx_radiotap(struct ieee80211_local *local,
 			txflags = get_unaligned_le16(iterator.this_arg);
 			if (txflags & IEEE80211_RADIOTAP_F_TX_NOACK)
 				info->flags |= IEEE80211_TX_CTL_NO_ACK;
+			if (txflags & IEEE80211_RADIOTAP_F_TX_NOSEQNO)
+				info->control.flags |= IEEE80211_TX_CTRL_NO_SEQNO;
 			break;
 
 		case IEEE80211_RADIOTAP_RATE:
-- 
2.27.0

