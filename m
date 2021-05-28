Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048CB3940A3
	for <lists+linux-wireless@lfdr.de>; Fri, 28 May 2021 12:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbhE1KIw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 May 2021 06:08:52 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2082 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbhE1KIu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 May 2021 06:08:50 -0400
Received: from dggeml715-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fs0bx4r3BzWns9;
        Fri, 28 May 2021 18:02:37 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggeml715-chm.china.huawei.com (10.3.17.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 18:07:13 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 18:07:13 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] mac80211: remove the repeated declaration
Date:   Fri, 28 May 2021 18:07:04 +0800
Message-ID: <1622196424-62403-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Function 'ieee80211_sta_set_rx_nss' is declared twice, so remove the
repeated declaration.

Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 net/mac80211/ieee80211_i.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8fcbaa1eedf3..02e2fbd4c9ce 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1892,7 +1892,6 @@ void ieee80211_sta_set_rx_nss(struct sta_info *sta);
 enum ieee80211_sta_rx_bandwidth
 ieee80211_chan_width_to_rx_bw(enum nl80211_chan_width width);
 enum nl80211_chan_width ieee80211_sta_cap_chan_bw(struct sta_info *sta);
-void ieee80211_sta_set_rx_nss(struct sta_info *sta);
 void ieee80211_process_mu_groups(struct ieee80211_sub_if_data *sdata,
 				 struct ieee80211_mgmt *mgmt);
 u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
-- 
2.7.4

