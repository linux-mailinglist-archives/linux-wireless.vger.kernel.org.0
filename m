Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60F32DF326
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Dec 2020 04:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgLTDga (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Dec 2020 22:36:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:57984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbgLTDg1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Dec 2020 22:36:27 -0500
From:   Sasha Levin <sashal@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 1/3] cfg80211: initialize rekey_data
Date:   Sat, 19 Dec 2020 22:35:24 -0500
Message-Id: <20201220033526.2728841-1-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sara Sharon <sara.sharon@intel.com>

[ Upstream commit f495acd8851d7b345e5f0e521b2645b1e1f928a0 ]

In case we have old supplicant, the akm field is uninitialized.

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Link: https://lore.kernel.org/r/iwlwifi.20201129172929.930f0ab7ebee.Ic546e384efab3f4a89f318eafddc3eb7d556aecb@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 5bd89f536720d..ab8bca39afa3f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10428,7 +10428,7 @@ static int nl80211_set_rekey_data(struct sk_buff *skb, struct genl_info *info)
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct nlattr *tb[NUM_NL80211_REKEY_DATA];
-	struct cfg80211_gtk_rekey_data rekey_data;
+	struct cfg80211_gtk_rekey_data rekey_data = {};
 	int err;
 
 	if (!info->attrs[NL80211_ATTR_REKEY_DATA])
-- 
2.27.0

