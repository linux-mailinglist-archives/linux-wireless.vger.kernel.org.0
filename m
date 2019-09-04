Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E888A7B68
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 08:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfIDGQE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 02:16:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60172 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfIDGQE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 02:16:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0F6BB60159; Wed,  4 Sep 2019 06:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567577763;
        bh=5Xij+zFs54t+TMTsDwybgL6kdYeyg2X6LTssTBMQyz4=;
        h=From:To:Cc:Subject:Date:From;
        b=JavAxvNdJbF0mcxK/TWmgD20QXxPGGSZQz0RsM8XOei0doNrEeAz/vc/xyAHWdDNk
         mHpKEYmHFDdLIK2J/vULaUrfJmOCI/KWGfbYrJN6oxkKbmRxJrqw5Q58ctGeimmb6E
         6B1fXNmPiY4pyixvXGahV0Ud6pf47nRI2bBgO3FM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 75C9A60E75;
        Wed,  4 Sep 2019 06:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567577761;
        bh=5Xij+zFs54t+TMTsDwybgL6kdYeyg2X6LTssTBMQyz4=;
        h=From:To:Cc:Subject:Date:From;
        b=ouTQD6gikvu4yUgWWDjjI5SfHl2LQAmO83PbQuVOn3RwBMsi13vOCyJAnfpnkeuAD
         vqwZ+5zdKmkjE/m/hzAjNJZkCROPSsZHyTm6UQr+UwGO1iRE3bEO+fpfk+yoDJOSsH
         FGwgWyRUtTvYWP/6iWYutJ99lMqhB7TykJ0rsxu8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75C9A60E75
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] mac80211: Store max_mtu in ieee80211_hw
Date:   Wed,  4 Sep 2019 14:15:43 +0800
Message-Id: <1567577743-27684-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Make it possibly for drivers to adjust the default mat_mtu
by storing it in the hardware struct.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 include/net/mac80211.h | 3 +++
 net/mac80211/iface.c   | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d26da01..8545b03 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2454,6 +2454,8 @@ enum ieee80211_hw_flags {
  *
  * @weight_multiplier: Driver specific airtime weight multiplier used while
  *	refilling deficit of each TXQ.
+ *
+ * @max_mtu: the max mtu could be set.
  */
 struct ieee80211_hw {
 	struct ieee80211_conf conf;
@@ -2491,6 +2493,7 @@ struct ieee80211_hw {
 	u8 max_nan_de_entries;
 	u8 tx_sk_pacing_shift;
 	u8 weight_multiplier;
+	u32 max_mtu;
 };
 
 static inline bool _ieee80211_hw_check(struct ieee80211_hw *hw,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 06aac0a..00c33e6 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1877,7 +1877,10 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 
 		/* MTU range: 256 - 2304 */
 		ndev->min_mtu = 256;
-		ndev->max_mtu = IEEE80211_MAX_DATA_LEN;
+		if (local->hw.max_mtu)
+			ndev->max_mtu = local->hw.max_mtu;
+		else
+			ndev->max_mtu = IEEE80211_MAX_DATA_LEN;
 
 		ret = register_netdevice(ndev);
 		if (ret) {
-- 
1.9.1

