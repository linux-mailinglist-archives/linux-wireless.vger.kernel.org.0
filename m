Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFD5EF57DA
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 21:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbfKHTmb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 14:42:31 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:46158 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbfKHTm0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 14:42:26 -0500
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 73E3913C2B8;
        Fri,  8 Nov 2019 11:42:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 73E3913C2B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1573242145;
        bh=mZ1B91Q31N0eF1FTFMU7WwqKj9LBZGeMtHNrBG45SXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l4vHtLGIf/+h+XmC9qB0tOFjWQ4EtrKVuXBtHSYmCFYZqxiAzi1y4eEHQAzt8X8iV
         mhZJw4ZW+YzqmiIXg107kXcZd8ml5ZPaC4qMxWBJJ8Vl9FJGRm2LMutjKGJELvWQG6
         GeLrGfem2hfXpzXrFeqC2WuSaIZ2ftHBTW8jr8hA=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 02/10] mac80211: Change warn-on to warn-on-once
Date:   Fri,  8 Nov 2019 11:42:03 -0800
Message-Id: <20191108194210.23618-3-greearb@candelatech.com>
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

I saw a bunch of splats while reloading ath10k module, one splat is plenty.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 0e05ff037672..670ae0cecc33 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4553,7 +4553,7 @@ void ieee80211_rx_napi(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 	 * The same happens when we're not even started,
 	 * but that's worth a warning.
 	 */
-	if (WARN_ON(!local->started))
+	if (WARN_ON_ONCE(!local->started))
 		goto drop;
 
 	if (likely(!(status->flag & RX_FLAG_FAILED_PLCP_CRC))) {
-- 
2.20.1

