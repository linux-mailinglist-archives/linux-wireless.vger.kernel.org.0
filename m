Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32985182C13
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 10:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgCLJLF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 05:11:05 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:42643 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgCLJLF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 05:11:05 -0400
Received: from isengard.tu-ilmenau.de (unknown [141.24.111.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 9605E580073;
        Thu, 12 Mar 2020 10:11:03 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 3/3] mac80211: enable control port no-preauth feature
Date:   Thu, 12 Mar 2020 10:10:55 +0100
Message-Id: <20200312091055.54257-4-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200312091055.54257-1-markus.theil@tu-ilmenau.de>
References: <20200312091055.54257-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch announces the capability to disable pre-auth over nl80211
control port for all mac80211-based device drivers.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 net/mac80211/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 944e86da5c65..ee1b24845b66 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -589,6 +589,8 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_FILS_STA);
 	wiphy_ext_feature_set(wiphy,
 			      NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211);
+	wiphy_ext_feature_set(wiphy,
+			      NL80211_EXT_FEATURE_CONTROL_PORT_NO_PREAUTH);
 
 	if (!ops->hw_scan) {
 		wiphy->features |= NL80211_FEATURE_LOW_PRIORITY_SCAN |
-- 
2.25.1

