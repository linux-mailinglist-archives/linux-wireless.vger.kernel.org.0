Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08B74EAFEF
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2019 13:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfJaMNE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Oct 2019 08:13:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53518 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfJaMNE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Oct 2019 08:13:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id n7so5674720wmc.3
        for <linux-wireless@vger.kernel.org>; Thu, 31 Oct 2019 05:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xAtVRfhDg48i3Bwmqx792TgOAvBvCbqs6I8oYFPPEXA=;
        b=PNa/5ax82TvKVdAgHhXJEtvzkLFRPcQgMr5EfIF5LyeSWFSWxfhIt5xyOU6hlCquIe
         pScK+23M3S1h/she8uoDqsG2JOaVKB0F+gqWnK/UE0roZBPcQ9RIKyQFRgUdzl+CT56r
         RwP2YUsxz7LGxUZSVM0h7LDV6FqgCP+CNFL79W5vmft40wfTzPSXAgPy2GVoLi2YaVFp
         wA3jvKbcAr/usUSmiq4jwiBxfM2jNCMc8VT7H/GVK6lfjbNnrem88TdhPe7YcKqCM6mJ
         hGlYLl592Rx7JkAp2bumikRm1YQtMgB7XRDHcbmGkxtIdGL0ynIxQHvf2kfKmTcczIys
         DgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xAtVRfhDg48i3Bwmqx792TgOAvBvCbqs6I8oYFPPEXA=;
        b=PnNqzQzj+R9/YoDUcEKtzCCvZqSwkbf5QQcsnduv3AHP7B0vmuOXQeCBu6jNUClAtg
         WH5BPmJmhJNKN6O6D5awA0Gj2b1xuMiv+ILJRHtobRkDnReQJKVRrHVgq9weicA1FGcN
         JfjQu5R5Fm1BdHYCVWfFqCGaUCavJzCpUoLtrZ5ZPBsUDZkPpxW2I/LjZbPcCuVj0WAm
         enMmciPmHCnfMlqLxQrevidsZ0l+Ma6tje6GHFo72DZrb8AromcNMTqTk9CL2ypeleNb
         4LfUyevrj6tlrEuiZEp6CMsYJ0dnwBP+h+XXD+F5bG9foaZB685LJmeY/b6U14h94BMM
         dKmQ==
X-Gm-Message-State: APjAAAUuABjbOlBA5e9jxq55bIq030aWcGzQGBvHN/53bpjWsVaORNx9
        N9OXmLfoae2OyXDAaHdmD3JNp4rd
X-Google-Smtp-Source: APXvYqwJppDou0klFe0dOpPWaQJ14OdMtfTYWGUAx7TFVIU+v6W1pJIqBGZpBvKJ07xr5DY8UUibQA==
X-Received: by 2002:a1c:750e:: with SMTP id o14mr5211893wmc.28.1572523982121;
        Thu, 31 Oct 2019 05:13:02 -0700 (PDT)
Received: from localhost.localdomain ([156.197.16.66])
        by smtp.googlemail.com with ESMTPSA id n22sm2796856wmk.19.2019.10.31.05.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 05:13:01 -0700 (PDT)
From:   Ahmed Zaki <anzaki@gmail.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ahmed Zaki <anzaki@gmail.com>
Subject: [PATCH v2] mac80211: fix insane values that sometimes appear in inactive_time
Date:   Thu, 31 Oct 2019 06:12:43 -0600
Message-Id: <20191031121243.27694-1-anzaki@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In the first 5 minutes after boot (time of INITIAL_JIFFIES),
ieee80211_sta_last_active() returns zero if last_ack is zero. This
leads to "inactive time" showing jiffies_to_msecs(jiffies).

 # iw wlan0 station get fc:ec:da:64:a6:dd
 Station fc:ec:da:64:a6:dd (on wlan0)
	inactive time:	4294894049 ms
	.
	.
	connected time:	70 seconds

Fix by returning last_rx if last_ack == 0.

Signed-off-by: Ahmed Zaki <anzaki@gmail.com>
---
 net/mac80211/sta_info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index bd11fef2139f..428866ff7c0a 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2457,7 +2457,8 @@ unsigned long ieee80211_sta_last_active(struct sta_info *sta)
 {
 	struct ieee80211_sta_rx_stats *stats = sta_get_last_rx_stats(sta);
 
-	if (time_after(stats->last_rx, sta->status_stats.last_ack))
+	if (!sta->status_stats.last_ack ||
+		time_after(stats->last_rx, sta->status_stats.last_ack))
 		return stats->last_rx;
 	return sta->status_stats.last_ack;
 }
-- 
2.17.1

