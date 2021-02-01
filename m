Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905D330A35D
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Feb 2021 09:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhBAIe0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Feb 2021 03:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbhBAIe0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Feb 2021 03:34:26 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08C4C061573
        for <linux-wireless@vger.kernel.org>; Mon,  1 Feb 2021 00:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hOQ9cTUf80v7R70Xyvi+szFlyXJf2CKC610KQzMUi6I=; b=t4f22SU4lhZSLW34pBs/FE+C5u
        FdODAh7/ykEqdySmOk7aEk7bAeJ/N6Wq7NUZSfLAbKUXcL0MYCuEmk2vpdw7ePPgL1fyGRNqE4oNf
        4yeKVVpVCrFPpi98TxE6SUuukd2ZXW9Bz8iYduga/RykC62gpFCY3jqSGH5PCOqND4Sw=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l6UeD-0002Sb-SM; Mon, 01 Feb 2021 09:33:25 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 5.11] mac80211: fix station rate table updates on assoc
Date:   Mon,  1 Feb 2021 09:33:24 +0100
Message-Id: <20210201083324.3134-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If the driver uses .sta_add, station entries are only uploaded after the sta
is in assoc state. Fix early station rate table updates by deferring them
until the sta has been uploaded

Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/driver-ops.c | 5 ++++-
 net/mac80211/rate.c       | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index c9a8a2433e8a..a1f879cd53fe 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -125,8 +125,11 @@ int drv_sta_state(struct ieee80211_local *local,
 	} else if (old_state == IEEE80211_STA_AUTH &&
 		   new_state == IEEE80211_STA_ASSOC) {
 		ret = drv_sta_add(local, sdata, &sta->sta);
-		if (ret == 0)
+		if (ret == 0) {
 			sta->uploaded = true;
+			if (rcu_dereference(sta->sta.rates))
+				drv_sta_rate_tbl_update(local, sdata, &sta->sta);
+		}
 	} else if (old_state == IEEE80211_STA_ASSOC &&
 		   new_state == IEEE80211_STA_AUTH) {
 		drv_sta_remove(local, sdata, &sta->sta);
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 45927202c71c..63652c39c8e0 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -960,7 +960,8 @@ int rate_control_set_rates(struct ieee80211_hw *hw,
 	if (old)
 		kfree_rcu(old, rcu_head);
 
-	drv_sta_rate_tbl_update(hw_to_local(hw), sta->sdata, pubsta);
+	if (sta->uploaded)
+		drv_sta_rate_tbl_update(hw_to_local(hw), sta->sdata, pubsta);
 
 	ieee80211_sta_set_expected_throughput(pubsta, sta_get_expected_throughput(sta));
 
-- 
2.28.0

