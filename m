Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7592F57D5
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 21:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732241AbfKHTm1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 14:42:27 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:46198 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731422AbfKHTm1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 14:42:27 -0500
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id C964D13C345;
        Fri,  8 Nov 2019 11:42:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C964D13C345
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1573242146;
        bh=9yAS5sc0FE5J2LJfFvzsHqDYBNzwes8YiVMiKrUTMzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NmtTIL7xjY1ZqSxdomV3NWwVPn7uqRtkEH8wxqrVdOk73HPeI2DcfkeblsmBa9tOy
         KOj9fDJsveyoX0pRsKtgKe8kIGZu4nUPcdeowkYmR3swdoXMXywFZW8rOjdWa+1dUB
         DQwaC6mmi0Sb6vEB7cpqIN+6XIJIaCkyb0EwO9gE=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 09/10] mac80211: Use warn-on-once for queue mis-configuration.
Date:   Fri,  8 Nov 2019 11:42:10 -0800
Message-Id: <20191108194210.23618-10-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108194210.23618-1-greearb@candelatech.com>
References: <20191108194210.23618-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Don't spam logs if a user manages to hit this warning.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/util.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 32a7a53833c0..21c2f439fc6a 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -387,8 +387,11 @@ static void __ieee80211_wake_queue(struct ieee80211_hw *hw, int queue,
 
 	trace_wake_queue(local, queue, reason);
 
-	if (WARN_ON(queue >= hw->queues))
+	if (WARN_ON_ONCE(queue >= hw->queues)) {
+		pr_err("wake-queue, queue: %d > hw->queues: %d\n",
+		       queue, hw->queues);
 		return;
+	}
 
 	if (!test_bit(reason, &local->queue_stop_reasons[queue]))
 		return;
-- 
2.20.1

