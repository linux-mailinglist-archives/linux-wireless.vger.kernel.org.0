Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1403417757C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2020 12:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgCCLug (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Mar 2020 06:50:36 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:59758 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbgCCLug (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Mar 2020 06:50:36 -0500
Received: from localhost.localdomain (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 816D8580074;
        Tue,  3 Mar 2020 12:50:34 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 2/3] mac80211: conditionally allow scan in monitor mode
Date:   Tue,  3 Mar 2020 12:50:16 +0100
Message-Id: <20200303115017.9845-2-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303115017.9845-1-markus.theil@tu-ilmenau.de>
References: <20200303115017.9845-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch checks the monitor mode scan feature flag and conditionally
allows scanning in monitor mode for hw which supports this.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 net/mac80211/cfg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 7b654d2b8bb2..01a20f2dbf86 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2313,6 +2313,12 @@ static int ieee80211_scan(struct wiphy *wiphy,
 		     !(req->flags & NL80211_SCAN_FLAG_AP)))
 			return -EOPNOTSUPP;
 		break;
+	case NL80211_IFTYPE_MONITOR:
+		if (wiphy_ext_feature_isset(wiphy,
+					    NL80211_EXT_FEATURE_MONITOR_MODE_SCAN))
+			break;
+		else
+			return -EOPNOTSUPP;
 	case NL80211_IFTYPE_NAN:
 	default:
 		return -EOPNOTSUPP;
-- 
2.25.1

