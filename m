Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A19ADFD2
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 22:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732854AbfIIUOF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Sep 2019 16:14:05 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:52480 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731972AbfIIUOE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Sep 2019 16:14:04 -0400
Received: from v-f24-64.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id EC13A104F;
        Mon,  9 Sep 2019 13:14:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com EC13A104F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1568060044;
        bh=gD7a4HO38BShwL/lteS70mQANZ1VGtWqnG7jSRbh22Y=;
        h=From:To:Cc:Subject:Date:From;
        b=ji7MBTvhWwD/Oo/8qGi87bgGbK1CHku9US1/LLXlLp/nfCit8qEg2aDWo3bJmlIdK
         rveQ4xF//XvqGDWkwc9gsKPafTtqeXAGt4aOukXrAPYamkKlSeMUy9sPv/Mn9/bioE
         0fXLFprPGCkkLOKJGDMrgqWT/YEZPaw4D61WzL9g=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH-v2 1/2] iw:  Support associated-at station statistic.
Date:   Mon,  9 Sep 2019 13:13:56 -0700
Message-Id: <1568060037-7481-1-git-send-email-greearb@candelatech.com>
X-Mailer: git-send-email 2.7.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This can be helpful for calculating roaming time and other
higher precision stats.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 nl80211.h | 2 ++
 station.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/nl80211.h b/nl80211.h
index ca8f207..89d88fc 100644
--- a/nl80211.h
+++ b/nl80211.h
@@ -3201,6 +3201,7 @@ enum nl80211_sta_bss_param {
  *	sent to the station (u64, usec)
  * @NL80211_STA_INFO_AIRTIME_WEIGHT: current airtime weight for station (u16)
  * @NL80211_STA_INFO_AIRTIME_LINK_METRIC: airtime link metric for mesh station
+ * @NL80211_STA_INFO_ASSOC_AT_BOOTTIME: Timestamp of last assoc -> auth transition
  * @__NL80211_STA_INFO_AFTER_LAST: internal
  * @NL80211_STA_INFO_MAX: highest possible station info attribute
  */
@@ -3247,6 +3248,7 @@ enum nl80211_sta_info {
 	NL80211_STA_INFO_TX_DURATION,
 	NL80211_STA_INFO_AIRTIME_WEIGHT,
 	NL80211_STA_INFO_AIRTIME_LINK_METRIC,
+	NL80211_STA_INFO_ASSOC_AT_BOOTTIME,
 
 	/* keep last */
 	__NL80211_STA_INFO_AFTER_LAST,
diff --git a/station.c b/station.c
index aaad079..61a317d 100644
--- a/station.c
+++ b/station.c
@@ -569,6 +569,12 @@ static int print_sta_handler(struct nl_msg *msg, void *arg)
 	if (sinfo[NL80211_STA_INFO_CONNECTED_TIME])
 		printf("\n\tconnected time:\t%u seconds",
 			nla_get_u32(sinfo[NL80211_STA_INFO_CONNECTED_TIME]));
+	if (sinfo[NL80211_STA_INFO_ASSOC_AT_BOOTTIME]) {
+		unsigned long long bt;
+		bt = (unsigned long long)nla_get_u64(sinfo[NL80211_STA_INFO_ASSOC_AT_BOOTTIME]);
+		printf("\n\tassociated at:\t%llu.%.3llus [boottime]",
+		       bt/1000000000, (bt%1000000000)/1000000);
+	}
 
 	printf("\n");
 	return NL_SKIP;
-- 
2.7.5

