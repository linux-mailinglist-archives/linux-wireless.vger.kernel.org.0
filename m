Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BB1458DCA
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 12:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbhKVLvA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 06:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhKVLvA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 06:51:00 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08817C061574
        for <linux-wireless@vger.kernel.org>; Mon, 22 Nov 2021 03:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=MIIOjFkZxce9CiIY0uqF5DlYaipCasS+QvXceWa46nA=;
        t=1637581674; x=1638791274; b=JQaD0F9JfYLe+vTqdQUq36D19a8/aM9FdTTfmL1icXVKnXW
        ktSC5ORzn8khcJ8VRUAtoikjAod2YKiaAoLPFrDkKKUd7JGE6SFK9M0QlIvYyqASabxpJG1zULW7B
        I9KAqSUQdcPmzLqI7DjKRVjYLCln5QKyVXmmgpvxkIG40fH0COEd7s8Z1bSIfR9AOJTkNUeHLrFyK
        MFKZyIuIrqeqfTSvWl13vuY3S22zHZTGSGA1rHb25ldbOygv5wcdYH4VzjkYm1Oe9sg3ejiKl13Or
        5fAyEfl/Z3sveZPO68bT6KVk2jXOF0+aWiQjq7yw94GsOU6nxe79JicCtYd6F+XQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mp7nb-001Gmc-4D;
        Mon, 22 Nov 2021 12:47:51 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+614e82b88a1a4973e534@syzkaller.appspotmail.com
Subject: [PATCH] mac80211: track only QoS data frames for admission control
Date:   Mon, 22 Nov 2021 12:47:40 +0100
Message-Id: <20211122124737.dad29e65902a.Ieb04587afacb27c14e0de93ec1bfbefb238cc2a0@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <0000000000005b12b805d1375f4a@google.com>
References: <0000000000005b12b805d1375f4a@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

For admission control, obviously all of that only works for
QoS data frames, otherwise we cannot even access the QoS
field in the header.

Syzbot reported (see below) an uninitialized value here due
to a status of a non-QoS nullfunc packet, which isn't even
long enough to contain the QoS header.

Fix this to only do anything for QoS data packets.

#syz: test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git master
Reported-by: syzbot+614e82b88a1a4973e534@syzkaller.appspotmail.com
Fixes: 02219b3abca5 ("mac80211: add WMM admission control support")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 54ab0e1ef6ca..37f7d975f3da 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2452,11 +2452,18 @@ static void ieee80211_sta_tx_wmm_ac_notify(struct ieee80211_sub_if_data *sdata,
 					   u16 tx_time)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-	u16 tid = ieee80211_get_tid(hdr);
-	int ac = ieee80211_ac_from_tid(tid);
-	struct ieee80211_sta_tx_tspec *tx_tspec = &ifmgd->tx_tspec[ac];
+	u16 tid;
+	int ac;
+	struct ieee80211_sta_tx_tspec *tx_tspec;
 	unsigned long now = jiffies;
 
+	if (!ieee80211_is_data_qos(hdr->frame_control))
+		return;
+
+	tid = ieee80211_get_tid(hdr);
+	ac = ieee80211_ac_from_tid(tid);
+	tx_tspec = &ifmgd->tx_tspec[ac];
+
 	if (likely(!tx_tspec->admitted_time))
 		return;
 
-- 
2.33.1

