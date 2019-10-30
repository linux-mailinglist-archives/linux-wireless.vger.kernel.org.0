Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB85EA565
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2019 22:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfJ3Vck (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Oct 2019 17:32:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39565 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfJ3Vcj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Oct 2019 17:32:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id g19so3786793wmh.4
        for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2019 14:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r181HOhIsFO1o9M+c9/DziEFYmXK1WM0ueN3NTPMjBY=;
        b=hDzSv9VT2ucEDIimZWMchqoGPTnIpHR2G+FdgpZsd9kqTQQlWXutCFxIvTFgHXiCtv
         SQfq0lTLRVXmvbOEOSfPAbKl3GIJJKAW9BKpqexBO0Bj5xFr1Ff8eRmFtNRP5FyfHSOm
         mZupNSV9XX22/CkH80LzJinhXa4Y5/hXkXv7BdFEvwPuXHWxa1ISJpYmBOrxGPdQQPkM
         A1yzndvCA0Mz3mQIMHuomzpJU98kZUEIw2ohFhQrn8yZ5NpGmnPtkYvPhCOosB6ZUGOX
         O0r2u+W3KtqHvbs/jnacCXNu8oTr4e6l3XlmBDhyVwdNSjipcQGiQlR3XqIby1zZ6Kg+
         tw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r181HOhIsFO1o9M+c9/DziEFYmXK1WM0ueN3NTPMjBY=;
        b=SBStBJdzTjT7KaVjn5sstm15WrOdxYPGNfS7KYgIdIHFTWFE2e8d/8s+rz38Q15C1M
         P9PCIRztG8F+gFukI3+4EHnfim9m0YefqGCFnpIofsSLEwu6dRhz/8PjxS/VeiSG8bpa
         PpcL5l7rOkUEHBel7TkIM3sjz7+uI2wis/Y+ExgZdlsBSE8oAgwEzbtT/X/SXMq0COTD
         ZOQr9uP2lgmh3edeTPaoqp20JsdBuWm7ESLhqHrzGhDDRh+atBvNxCFQoD0iNFsIAAoo
         wcJ+8hNqjOfUWbu4wUUwYjB+6NC07JULkwxfSAJWl4Q51OHmyfOy/9YxJyVu00YNIvYY
         pYew==
X-Gm-Message-State: APjAAAWT3a9JyzzeUszIYYZ5BFSxnOFR6ZvgN2XEr5HPZ2VJvMYq7oTo
        gKV0uxtCgOw7Bzy60+HoOECUj7Dj
X-Google-Smtp-Source: APXvYqxnvW1AV8KqBW9zE3DEIu/2xQwwEtUDWROkCC9bhwUmEAXcuEPowC3/MvFPtA4JtmlM03IrzA==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr1491917wmi.49.1572471157630;
        Wed, 30 Oct 2019 14:32:37 -0700 (PDT)
Received: from localhost.localdomain ([156.197.16.66])
        by smtp.googlemail.com with ESMTPSA id z189sm1560542wmc.25.2019.10.30.14.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 14:32:37 -0700 (PDT)
From:   Ahmed Zaki <anzaki@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     anzaki@gmail.com
Subject: [PATCH 1/1] sta_info: fix insane values in iw sta dump "inactive time"
Date:   Wed, 30 Oct 2019 15:31:53 -0600
Message-Id: <20191030213153.3196-2-anzaki@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030213153.3196-1-anzaki@gmail.com>
References: <20191030213153.3196-1-anzaki@gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In the first 5 mins after boot (initial jiffies),
ieee80211_sta_last_active() returns zero in case last_ack is zero. This
leads to insane values appearing in "inactive time".

Fix by returning last_rx if last_ack == 0.
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

