Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8625E24D0E2
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 10:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgHUIyz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 04:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgHUIyz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 04:54:55 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A5BC061385
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 01:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=tN4J3A28OqXx8tQlzfx7F02IaKOi3v/Nv2YrXhB/lYc=; b=G23hgFmrjADUYyX9+y2WOxIR57
        d62Py+MK9aBdatPJdyHZoX/rD1GLrKfgdz1MACQLZ841896OXA6/nn70gi7uDV63SM5M2n4my6jeU
        wx9ds4RmjkjHHlomAzSVGV0jvF1/2p8F0V1nEyqCW5HvatEXxehdL2gEZm+X1Hh+Bwak=;
Received: from p5b206497.dip0.t-ipconnect.de ([91.32.100.151] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k92jq-0005lO-VL; Fri, 21 Aug 2020 10:49:31 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v3 10/13] mac80211: extend ieee80211_tx_status_ext to support bulk free
Date:   Fri, 21 Aug 2020 10:49:23 +0200
Message-Id: <20200821084926.10650-11-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821084926.10650-1-nbd@nbd.name>
References: <20200821084926.10650-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Store processed skbs ready to be freed in a list so the driver bulk free them

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/mac80211.h |  2 ++
 net/mac80211/status.c  | 10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 0cd8dbe4e688..aaec7688e965 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1095,12 +1095,14 @@ ieee80211_info_get_tx_time_est(struct ieee80211_tx_info *info)
  * @info: Basic tx status information
  * @skb: Packet skb (can be NULL if not provided by the driver)
  * @rate: The TX rate that was used when sending the packet
+ * @free_list: list where processed skbs are stored to be free'd by the driver
  */
 struct ieee80211_tx_status {
 	struct ieee80211_sta *sta;
 	struct ieee80211_tx_info *info;
 	struct sk_buff *skb;
 	struct rate_info *rate;
+	struct list_head *free_list;
 };
 
 /**
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index a3543c3dbd3d..a0dd926dceb3 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -1044,7 +1044,10 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 	 * with this test...
 	 */
 	if (!local->monitors && (!send_to_cooked || !local->cooked_mntrs)) {
-		dev_kfree_skb(skb);
+		if (status->free_list)
+			list_add_tail(&skb->list, status->free_list);
+		else
+			dev_kfree_skb(skb);
 		return;
 	}
 
@@ -1169,7 +1172,10 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 		return;
 
 	ieee80211_report_used_skb(local, skb, false);
-	dev_kfree_skb(skb);
+	if (status->free_list)
+		list_add_tail(&skb->list, status->free_list);
+	else
+		dev_kfree_skb(skb);
 }
 EXPORT_SYMBOL(ieee80211_tx_status_ext);
 
-- 
2.28.0

