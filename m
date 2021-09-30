Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC8E41D871
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Sep 2021 13:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350328AbhI3LNJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Sep 2021 07:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350271AbhI3LNJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Sep 2021 07:13:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6223C06176C
        for <linux-wireless@vger.kernel.org>; Thu, 30 Sep 2021 04:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=4ecpnZMm43ffHkU/aMjXuoRuhhWoYPahJnYoSoaRJWk=;
        t=1633000287; x=1634209887; b=lOgfXakHsujcuoiZLqjCLknOxuStQy03iZjNoWQ+DBQIl5V
        QQhlyMvX2oDc8TT8E6LBTuJ6KHjwUoNewxe57yblmGgL4Np7y4aKtlrjCaoCEWey0aPa75l/fQS9w
        4qNdIXKpMWmDy2i8rfnbJsf7BLOS/Xm0kzZBFXv4lky8I8t4xOdKq3pZpQ6TGrZwozcx8ZSsmhvHm
        zoQJsC+T+aNZAw5o1Rg72bocLnuq7GEnaavodb5eJMO0SPZIiJEbOOzT4c8XQNu2BAxt3Ot+l7O1p
        2Sqn9P5pisedwkabvnK+XnrwrkDt3TEyMuKZzS7yOWlqIbQDvYjiYjHMa6f3zKUQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mVtyG-00Dlt4-6Z;
        Thu, 30 Sep 2021 13:11:24 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] cfg80211: scan: fix RCU in cfg80211_add_nontrans_list()
Date:   Thu, 30 Sep 2021 13:11:21 +0200
Message-Id: <20210930131120.6ddfc603aa1d.I2137344c4e2426525b1a8e4ce5fca82f8ecbfe7e@changeid>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210930131120.b0f940976c56.I954e1be55e9f87cc303165bff5c906afe1e54648@changeid>
References: <20210930131120.b0f940976c56.I954e1be55e9f87cc303165bff5c906afe1e54648@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The SSID pointer is pointing to RCU protected data, so we
need to have it under rcu_read_lock() for the entire use.
Fix this.

Fixes: 0b8fb8235be8 ("cfg80211: Parsing of Multiple BSSID information in scanning")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/scan.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 11c68b159324..adc0d14cfd86 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -418,14 +418,17 @@ cfg80211_add_nontrans_list(struct cfg80211_bss *trans_bss,
 	}
 	ssid_len = ssid[1];
 	ssid = ssid + 2;
-	rcu_read_unlock();
 
 	/* check if nontrans_bss is in the list */
 	list_for_each_entry(bss, &trans_bss->nontrans_list, nontrans_list) {
-		if (is_bss(bss, nontrans_bss->bssid, ssid, ssid_len))
+		if (is_bss(bss, nontrans_bss->bssid, ssid, ssid_len)) {
+			rcu_read_unlock();
 			return 0;
+		}
 	}
 
+	rcu_read_unlock();
+
 	/* add to the list */
 	list_add_tail(&nontrans_bss->nontrans_list, &trans_bss->nontrans_list);
 	return 0;
-- 
2.31.1

