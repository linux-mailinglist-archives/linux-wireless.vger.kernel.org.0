Return-Path: <linux-wireless+bounces-16650-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138219F9784
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 18:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21330167053
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 17:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000EB21C168;
	Fri, 20 Dec 2024 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkmsHmqS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E2321C163;
	Fri, 20 Dec 2024 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714695; cv=none; b=A9Hi/9nWOQ+GFqqDgaHKJPgbGk+hl9VdtPfBbu66qHykGKR6LOkfc6xiYNvO2JAJj3jPKQhCVDxMbRpsm5kT4X3E2CHEHz4beJ2w5gJIsLpFAQ/gPsQ1p5E/1JjCo+Vn2aPIqfb1fS+deDR7otoMJgd9mCukO7VnsZR00b7XpfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714695; c=relaxed/simple;
	bh=KQf9Y1T6Zq/qIWDvc7z+aCWrmVy6T2vR2ZbfSQb06yk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Diro+pnuBv1cW0esNKDIi7McC+RkKE/UAXUG1QdtG6NGJI6lQXeCF1gX3TedxRPABiMhuNSaD9XQuMmwDI424FJI3VzjMb7MJeZTEdu4pzLgXaH1zBmXlUIdmbqj5GId6cpr7g0WSnPbi5tuoBGMfEFEFrMGOWXoKubm5ZIU1/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkmsHmqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F0AC4CED3;
	Fri, 20 Dec 2024 17:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714695;
	bh=KQf9Y1T6Zq/qIWDvc7z+aCWrmVy6T2vR2ZbfSQb06yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BkmsHmqS7S8q6B8oeuqEZut3hJcabThHLMGZBznbAOLDqVQyzL6vpoQ29o28xVZ1p
	 Gjb7UGMcRCnrW+CD4aC6qZuuqq2zkAItmGkbaobQi/uiyrldohOphmYrWTm/a3w/hJ
	 vgrqN78fX7AvcenyFi18o2J9CcYDYlLToSkN+m+QBaqopC6mLsHMe6H9IkhIQI/cqT
	 MGIF1lmQcGMHgQikAD1XG0uxsunkxE5nAD3E/aGpvPapm8NriDLV7eCyofG2Qui6Ya
	 2u2pzr6Znykgpt7onkLcJeuAhiudxIm48bNazHdHZVyOMrtN1Ak18nl/gqJO2e2SY4
	 uZ7+1rpTx9S7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 03/29] wifi: cfg80211: clear link ID from bitmap during link delete after clean up
Date: Fri, 20 Dec 2024 12:11:04 -0500
Message-Id: <20241220171130.511389-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171130.511389-1-sashal@kernel.org>
References: <20241220171130.511389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.6
Content-Transfer-Encoding: 8bit

From: Aditya Kumar Singh <quic_adisi@quicinc.com>

[ Upstream commit b5c32ff6a3a38c74facdd1fe34c0d709a55527fd ]

Currently, during link deletion, the link ID is first removed from the
valid_links bitmap before performing any clean-up operations. However, some
functions require the link ID to remain in the valid_links bitmap. One
such example is cfg80211_cac_event(). The flow is -

nl80211_remove_link()
    cfg80211_remove_link()
        ieee80211_del_intf_link()
            ieee80211_vif_set_links()
                ieee80211_vif_update_links()
                    ieee80211_link_stop()
                        cfg80211_cac_event()

cfg80211_cac_event() requires link ID to be present but it is cleared
already in cfg80211_remove_link(). Ultimately, WARN_ON() is hit.

Therefore, clear the link ID from the bitmap only after completing the link
clean-up.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Link: https://patch.msgid.link/20241121-mlo_dfs_fix-v2-1-92c3bf7ab551@quicinc.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c  | 8 +++++++-
 net/wireless/util.c | 3 +--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 6dfc61a9acd4..d589ea12e596 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4993,10 +4993,16 @@ static void ieee80211_del_intf_link(struct wiphy *wiphy,
 				    unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
+	u16 new_links = wdev->valid_links & ~BIT(link_id);
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	ieee80211_vif_set_links(sdata, wdev->valid_links, 0);
+	/* During the link teardown process, certain functions require the
+	 * link_id to remain in the valid_links bitmap. Therefore, instead
+	 * of removing the link_id from the bitmap, pass a masked value to
+	 * simulate as if link_id does not exist anymore.
+	 */
+	ieee80211_vif_set_links(sdata, new_links, 0);
 }
 
 static int
diff --git a/net/wireless/util.c b/net/wireless/util.c
index f49b55724f83..18585b1416c6 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2843,10 +2843,9 @@ void cfg80211_remove_link(struct wireless_dev *wdev, unsigned int link_id)
 		break;
 	}
 
-	wdev->valid_links &= ~BIT(link_id);
-
 	rdev_del_intf_link(rdev, wdev, link_id);
 
+	wdev->valid_links &= ~BIT(link_id);
 	eth_zero_addr(wdev->links[link_id].addr);
 }
 
-- 
2.39.5


