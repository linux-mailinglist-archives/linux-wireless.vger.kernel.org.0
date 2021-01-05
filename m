Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA642EA8B9
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 11:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbhAEKaZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jan 2021 05:30:25 -0500
Received: from relay.smtp-ext.broadcom.com ([192.19.221.30]:44082 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728024AbhAEKaZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jan 2021 05:30:25 -0500
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jan 2021 05:30:24 EST
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 747ED2477F;
        Tue,  5 Jan 2021 02:23:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 747ED2477F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1609842184;
        bh=vuRnp/eCd1YKq4LphdjGZ/Py22dRmY1iJGIZcxdma+8=;
        h=From:To:Cc:Subject:Date:From;
        b=pKn6OhvhTx/0DWI+haOAPFi72NKW9vVePYapL3dtA/qtBfILtWxYxdn1kgyHV+OjK
         gFzoAJ5NlIehu7VlT+cmNx5wbKTamHgaGWEfIHjUhLCsd4AeKORjd4izVEKFK1JvkT
         Pg01WOhuNL3ZvvJKq9UO/GWplJtdqSHR97UKficI=
Received: from localhost.localdomain (unknown [10.230.40.141])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id CB001187289;
        Tue,  5 Jan 2021 02:23:02 -0800 (PST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <jberg@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH] cfg80211: add VHT rate entries for MCS-10 and MCS-11
Date:   Tue,  5 Jan 2021 11:22:50 +0100
Message-Id: <20210105102250.3473-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Observed the warning in cfg80211_calculate_bitrate_vht() using an
11ac chip reporting MCS-11. Since devices reporting non-standard
MCS-9 is already supported add similar entries for MCS-10 and MCS-11.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 net/wireless/util.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index b4acc805114b..19fd4db6d32f 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1236,6 +1236,8 @@ static u32 cfg80211_calculate_bitrate_vht(struct rate_info *rate)
 		   78000000,
 		/* not in the spec, but some devices use this: */
 		   86500000,
+		   97500000,
+		  108300000,
 		},
 		{  13500000,
 		   27000000,
@@ -1247,6 +1249,8 @@ static u32 cfg80211_calculate_bitrate_vht(struct rate_info *rate)
 		  135000000,
 		  162000000,
 		  180000000,
+		  202500000,
+		  225000000,
 		},
 		{  29300000,
 		   58500000,
@@ -1258,6 +1262,8 @@ static u32 cfg80211_calculate_bitrate_vht(struct rate_info *rate)
 		  292500000,
 		  351000000,
 		  390000000,
+		  438800000,
+		  487500000,
 		},
 		{  58500000,
 		  117000000,
@@ -1269,12 +1275,14 @@ static u32 cfg80211_calculate_bitrate_vht(struct rate_info *rate)
 		  585000000,
 		  702000000,
 		  780000000,
+		  877500000,
+		  975000000,
 		},
 	};
 	u32 bitrate;
 	int idx;
 
-	if (rate->mcs > 9)
+	if (rate->mcs > 11)
 		goto warn;
 
 	switch (rate->bw) {
-- 
2.17.1

