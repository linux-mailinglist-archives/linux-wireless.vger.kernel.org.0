Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6CF24CC9F
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 06:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725268AbgHUEY5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 00:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgHUEY4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 00:24:56 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F080C061385
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 21:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gNTrA+Wd7KQ4l/sPK4M7yb3QtTmeFD5TbtOyQVNQUqE=; b=LOXjyAGefy+ePL4LJNJ+i08Y/J
        lXSPdkz9PQMm0ntOX5GiDFS8ITrNy21GJVpS0qDIgQ7ceoEP4NBte2rsOMp4131fAEpkoAXOXWPOA
        h3JShZp9v0pNvDEoMo/0uuR/awOCvdjbdX+POQ3pF6/+6ORc1wrFUuIY5uVaE6P2V94c=;
Received: from p5b206497.dip0.t-ipconnect.de ([91.32.100.151] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k8yX7-0005s7-N2; Fri, 21 Aug 2020 06:20:05 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v2 10/13] mac80211: extend ieee80211_tx_status_ext to support bulk free
Date:   Fri, 21 Aug 2020 06:19:58 +0200
Message-Id: <20200821042001.23388-11-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821042001.23388-1-nbd@nbd.name>
References: <20200821042001.23388-1-nbd@nbd.name>
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
index 261bdda2ec08..4cfd569a5f55 100644
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
 
@@ -1168,7 +1171,10 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
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

