Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673C03ADA25
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jun 2021 15:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbhFSNiy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Jun 2021 09:38:54 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:25285 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbhFSNiy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Jun 2021 09:38:54 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d03 with ME
        id K1cg2500G21Fzsu031cgFZ; Sat, 19 Jun 2021 15:36:41 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 19 Jun 2021 15:36:41 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ieee80211: add the value for Category '6' in "rtw_ieee80211_category"
Date:   Sat, 19 Jun 2021 15:36:30 +0200
Message-Id: <66be0187869bd7dae1c0b0785a32db695ee9872e.1624108556.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Preparation work for removing the "enum rtw_ieee80211_category" in
"drivers/staging/rtl8188eu/include/ieee80211.h" and
"drivers/staging/rtl8723bs/include/ieee80211.h".

This enum is similar to "enum ieee80211_category" from
"include/linux/ieee80211.h". However it defines the value '6' as
RTW_WLAN_CATEGORY_FT.

So add a corresponding value in "ieee80211_category"

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
/!\ Review with care. I don't have access to the standard. /!\

The name has been adjusted from what I have found on:
   https://mrncciew.com/2014/10/09/802-11-mgmt-action-frames/

I guess that FT was for "Fast Transition".
---
 include/linux/ieee80211.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 2967437f1b11..67f3e51e7ecc 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2933,6 +2933,7 @@ enum ieee80211_category {
 	WLAN_CATEGORY_BACK = 3,
 	WLAN_CATEGORY_PUBLIC = 4,
 	WLAN_CATEGORY_RADIO_MEASUREMENT = 5,
+	WLAN_CATEGORY_FAST_BBS_TRANSITION = 6,
 	WLAN_CATEGORY_HT = 7,
 	WLAN_CATEGORY_SA_QUERY = 8,
 	WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION = 9,
-- 
2.30.2

