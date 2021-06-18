Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC6F3AC970
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 13:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhFRLIu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 07:08:50 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48284 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231810AbhFRLIu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 07:08:50 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBx8-001YXx-8q; Fri, 18 Jun 2021 13:42:23 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:51 +0300
Message-Id: <iwlwifi.20210618133832.8c9c72f914b0.I68e9c0626dc77a0f67f238a05ae16a0b77b09895@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618104156.747775-1-luca@coelho.fi>
References: <20210618104156.747775-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 26/31] cfg80211: remove ieee80211_get_he_sta_cap()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This function turned out to be too easy to misuse since it
doesn't consider the interface type. Remove it now that we
no longer use it in mac80211.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/cfg80211.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 5a0c4fd2ec5a..6c851fa312ac 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -533,18 +533,6 @@ ieee80211_get_he_iftype_cap(const struct ieee80211_supported_band *sband,
 	return NULL;
 }
 
-/**
- * ieee80211_get_he_sta_cap - return HE capabilities for an sband's STA
- * @sband: the sband to search for the STA on
- *
- * Return: pointer to the struct ieee80211_sta_he_cap, or NULL is none found
- */
-static inline const struct ieee80211_sta_he_cap *
-ieee80211_get_he_sta_cap(const struct ieee80211_supported_band *sband)
-{
-	return ieee80211_get_he_iftype_cap(sband, NL80211_IFTYPE_STATION);
-}
-
 /**
  * ieee80211_get_he_6ghz_capa - return HE 6 GHz capabilities
  * @sband: the sband to search for the STA on
-- 
2.32.0

