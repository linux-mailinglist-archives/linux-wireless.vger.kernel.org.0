Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C1F115329
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2019 15:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfLFObM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Dec 2019 09:31:12 -0500
Received: from nbd.name ([46.4.11.11]:36196 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfLFObM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Dec 2019 09:31:12 -0500
Received: from tmo-101-57.customers.d1-online.com ([80.187.101.57] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1idEdR-00046n-Je; Fri, 06 Dec 2019 15:31:09 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: [PATCH] trivial: mac80211: fix indentation
Date:   Fri,  6 Dec 2019 15:31:03 +0100
Message-Id: <20191206143103.3645-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: John Crispin <john@phrozen.org>
---
 include/linux/ieee80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 7d3f2ced92d1..e172d0c7bf74 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2047,7 +2047,7 @@ ieee80211_he_ppe_size(u8 ppe_thres_hdr, const u8 *phy_cap_info)
 #define IEEE80211_HE_OPERATION_ER_SU_DISABLE			0x00010000
 #define IEEE80211_HE_OPERATION_6GHZ_OP_INFO			0x00020000
 #define IEEE80211_HE_OPERATION_BSS_COLOR_MASK			0x3f000000
-#define IEEE80211_HE_OPERATION_BSS_COLOR_OFFSET		24
+#define IEEE80211_HE_OPERATION_BSS_COLOR_OFFSET			24
 #define IEEE80211_HE_OPERATION_PARTIAL_BSS_COLOR		0x40000000
 #define IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED		0x80000000
 
-- 
2.20.1

