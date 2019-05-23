Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C837277ED
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2019 10:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbfEWI1o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 May 2019 04:27:44 -0400
Received: from nbd.name ([46.4.11.11]:40940 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbfEWI1o (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 May 2019 04:27:44 -0400
Received: from pd95fd032.dip0.t-ipconnect.de ([217.95.208.50] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hTj4g-0005pz-P1; Thu, 23 May 2019 10:27:42 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Subject: [PATCH V2] mac80211: fix rate reporting inside cfg80211_calculate_bitrate_he()
Date:   Thu, 23 May 2019 10:27:24 +0200
Message-Id: <20190523082724.14137-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The reported rate is not scaled down correctly. After applying this patch,
the function will behave just like the v/ht equivalents.

Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
---
 net/wireless/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 75899b62bdc9..5a03f38788e7 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1237,7 +1237,7 @@ static u32 cfg80211_calculate_bitrate_he(struct rate_info *rate)
 	if (rate->he_dcm)
 		result /= 2;
 
-	return result;
+	return result / 10000;
 }
 
 u32 cfg80211_calculate_bitrate(struct rate_info *rate)
-- 
2.20.1

