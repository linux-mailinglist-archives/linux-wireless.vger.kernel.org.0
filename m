Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AB72ACCB1
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 04:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387714AbgKJD4q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 22:56:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730249AbgKJD4o (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 22:56:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0182E2063A;
        Tue, 10 Nov 2020 03:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604980603;
        bh=7y1FuVyjxr2ugCCeDo7vnYcqlQj71agm0WBc/48hLCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ETRTiFbJPEYgQ7ezUVT9/FJ3lghQXH6t9ADaI7jxmcksizqGBLKGNA42rb+uDP7hq
         bVNkc+a1qknHRUykbwjhDo9SYKOn2/CDJ/YnLaF4znNIU5WLL1J0z/1jAJsh9TDYbR
         u7S7TeW0hLo9ZNXqqRNM4c5ZJXYlaGO0xv+Tx6Ug=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+2e293dbd67de2836ba42@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 07/12] mac80211: always wind down STA state
Date:   Mon,  9 Nov 2020 22:56:28 -0500
Message-Id: <20201110035633.425030-7-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201110035633.425030-1-sashal@kernel.org>
References: <20201110035633.425030-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit dcd479e10a0510522a5d88b29b8f79ea3467d501 ]

When (for example) an IBSS station is pre-moved to AUTHORIZED
before it's inserted, and then the insertion fails, we don't
clean up the fast RX/TX states that might already have been
created, since we don't go through all the state transitions
again on the way down.

Do that, if it hasn't been done already, when the station is
freed. I considered only freeing the fast TX/RX state there,
but we might add more state so it's more robust to wind down
the state properly.

Note that we warn if the station was ever inserted, it should
have been properly cleaned up in that case, and the driver
will probably not like things happening out of order.

Reported-by: syzbot+2e293dbd67de2836ba42@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/20201009141710.7223b322a955.I95bd08b9ad0e039c034927cce0b75beea38e059b@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/sta_info.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index fef8d7758dae9..8a9bbcfefbca6 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -243,6 +243,24 @@ struct sta_info *sta_info_get_by_idx(struct ieee80211_sub_if_data *sdata,
  */
 void sta_info_free(struct ieee80211_local *local, struct sta_info *sta)
 {
+	/*
+	 * If we had used sta_info_pre_move_state() then we might not
+	 * have gone through the state transitions down again, so do
+	 * it here now (and warn if it's inserted).
+	 *
+	 * This will clear state such as fast TX/RX that may have been
+	 * allocated during state transitions.
+	 */
+	while (sta->sta_state > IEEE80211_STA_NONE) {
+		int ret;
+
+		WARN_ON_ONCE(test_sta_flag(sta, WLAN_STA_INSERTED));
+
+		ret = sta_info_move_state(sta, sta->sta_state - 1);
+		if (WARN_ONCE(ret, "sta_info_move_state() returned %d\n", ret))
+			break;
+	}
+
 	if (sta->rate_ctrl)
 		rate_control_free_sta(sta);
 
-- 
2.27.0

