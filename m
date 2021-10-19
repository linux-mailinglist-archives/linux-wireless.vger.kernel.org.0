Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDC9433C23
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 18:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbhJSQaf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 12:30:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233737AbhJSQae (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 12:30:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1426C61052;
        Tue, 19 Oct 2021 16:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634660901;
        bh=9HBvlgibHv8CAFNjoiM5GBApxiv8wnMQ1NVLjI23rso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W+4GM0r/PAnZlwRPbARdQxyDNbPukU0HDnWZCWJpcNIjqVjI2E5bAS51q+w9arZeh
         LLIZbEA3njcblCrL0IM/k+6fSejk9Lmix/xrdRyaexS340Jy6a9MI9+V7B7lJwsRv9
         hZ+ZVdWwSyX01OVw2C1ssljFcjqJSroU/N3F4o+JrFePO/EaP9KpgcuYCcSexLOv03
         AlLmre4P386B1QJQttVaJJRT6tjNLzTXXc9IQWrBUwXek9e/QtMewfSWux1GvpxMes
         8gSYnJHsJtdFzvkIdo4s2aC9EHazUHXLYzq7pW8oOKL1BN8p2Gpgnivh0I5QGCeief
         rYXhM4nj1G+9g==
From:   Jakub Kicinski <kuba@kernel.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 2/2] cfg80211: prepare for const netdev->dev_addr
Date:   Tue, 19 Oct 2021 09:28:16 -0700
Message-Id: <20211019162816.1384077-2-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019162816.1384077-1-kuba@kernel.org>
References: <20211019162816.1384077-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

netdev->dev_addr will be const soon.
All callers of wdev_address() can take const already.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: johannes@sipsolutions.net
CC: linux-wireless@vger.kernel.org
---
 include/net/cfg80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 62dd8422e0dc..61c87d8e7f2a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5492,7 +5492,7 @@ struct wireless_dev {
 	unsigned long unprot_beacon_reported;
 };
 
-static inline u8 *wdev_address(struct wireless_dev *wdev)
+static inline const u8 *wdev_address(struct wireless_dev *wdev)
 {
 	if (wdev->netdev)
 		return wdev->netdev->dev_addr;
-- 
2.31.1

