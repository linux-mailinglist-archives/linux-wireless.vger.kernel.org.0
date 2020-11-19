Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5DB2B9676
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Nov 2020 16:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgKSPm7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Nov 2020 10:42:59 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:45332 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbgKSPm7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Nov 2020 10:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1605800577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=43FZ+/TdGBajMA2LNqqNuOqD0RatlQ1neJSWUkj9RBA=;
        b=mrYWkdfTU7coh6gm07VMzThi5qgJXor/KDf1X2GAfUGO3cqHgvaCYEF32B58J22Gy3fX6H
        4iRK+HDT9FkJLlEgc4JggxdHKDVkFUTXe9P7sbP6INaaa8ZlbuIDgTKC2WiFEdclZrbc0E
        kuKy+Z6FajCrsCtO634b0Aa2GG7OHOM=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Sven Eckelmann <sven@narfation.org>
Subject: [PATCH v2 3/3] ath11k: Build check size of ath11k_skb_cb
Date:   Thu, 19 Nov 2020 16:42:34 +0100
Message-Id: <20201119154235.263250-3-sven@narfation.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119154235.263250-1-sven@narfation.org>
References: <20201119154235.263250-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It is rather easy to add more entries to ath11k_skb_cb while forgetting the
size limit of ieee80211_tx_info->driver_data. So just check this during the
build to reduce the change of accidental buffer overflow in the skbuff->cb.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
- new patch

 drivers/net/wireless/ath/ath11k/core.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 5a7915f75e1e..b5ca4455b2e0 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -909,6 +909,8 @@ static inline const char *ath11k_scan_state_str(enum ath11k_scan_state state)
 
 static inline struct ath11k_skb_cb *ATH11K_SKB_CB(struct sk_buff *skb)
 {
+	BUILD_BUG_ON(sizeof(struct ath11k_skb_cb) >
+		     IEEE80211_TX_INFO_DRIVER_DATA_SIZE);
 	return (struct ath11k_skb_cb *)&IEEE80211_SKB_CB(skb)->driver_data;
 }
 
-- 
2.29.2

