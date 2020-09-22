Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E265274A49
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 22:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgIVUop (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 16:44:45 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:47832 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgIVUop (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 16:44:45 -0400
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id DA2A813C2B1;
        Tue, 22 Sep 2020 13:44:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com DA2A813C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1600807485;
        bh=fQjNdy2MO5sqewOTNw6DIn+NG3UFzClrxzXmN1d4xDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xy3j0QL3Q71MU0WK0pL0mt0v3hxmPLPU7+PedW7X+fO0D07d9OL6oBb3CZ5pbH6Mj
         ea8pXaksd2l7mbpXhSpXc2Qbu+x7OGM0bWsFB41305mCHWcfdfRlT3/EW9yY+KFFyR
         pDYCt1Jbx+zE1p3kDWa+yc/wbI7sywePV5AcJVvE=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 2/2] mac80211:  Set radio to unavailable when it fails to reconfigure.
Date:   Tue, 22 Sep 2020 13:44:40 -0700
Message-Id: <20200922204440.25360-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200922204440.25360-1-greearb@candelatech.com>
References: <20200922204440.25360-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This can happen when firmware crashes during recover operations, for
instance.  Seen sometimes during stress test of ath10k systems, particularlly
an IPQ4019 based platform, but I think it could happen on many systems.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index f3bc05217f741..ecd56f80b0c82 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2106,6 +2106,7 @@ static void ieee80211_handle_reconfig_failure(struct ieee80211_local *local)
 	mutex_unlock(&local->chanctx_mtx);
 
 	cfg80211_shutdown_all_interfaces(local->hw.wiphy);
+	cfg80211_set_unavailable(local->hw.wiphy, 1);
 }
 
 static void ieee80211_assign_chanctx(struct ieee80211_local *local,
-- 
2.26.2

