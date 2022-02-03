Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDFC4A8C4F
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 20:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353759AbiBCTPk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 14:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353722AbiBCTPg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 14:15:36 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368DDC061714
        for <linux-wireless@vger.kernel.org>; Thu,  3 Feb 2022 11:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=F6TzcxegNOxqRAlBel9qW48famuVOd3vO6dMjHRveys=; t=1643915736; x=1645125336; 
        b=uuso/K7syAAinb7KKL+s22dnmrFE+BPL33/rE2Njl2g/TAlfC1dQqAP6trKXzqlXHiiHBiUfaDn
        BjZLJ40XbT31pvSH82R+pn7w6wJBC+LLnZy4n2qEVx4jkJ1MP/Cv+gZLWDofMlXsyrUwjN8L65ogZ
        F4NaYFQaCmfunsAJGMaq1A5ao2/cekmdneKiF/1D5x9sL6Aw/4mYnO0kmFGLro1f4uj6ZdJZoF1FB
        HzytJ2M/khVg5PuA5trOSJ4BWTlJE4uqdogrorN+j7qwImpgb4D8ugZUURmiC/QazUpY3/8zjoOIl
        Jg35amUkWe6HsW6vRiNW7VobnXRBRIRdWLTw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nFhZs-00E6ix-13;
        Thu, 03 Feb 2022 20:15:32 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: refuse aggregations sessions before authorized
Date:   Thu,  3 Feb 2022 20:15:29 +0100
Message-Id: <20220203201528.ff4d5679dce9.I34bb1f2bc341e161af2d6faf74f91b332ba11285@changeid>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If an MFP station isn't authorized, the receiver will (or
at least should) drop the action frame since it's a robust
management frame, but if we're not authorized we haven't
installed keys yet. Refuse attempts to start a session as
they'd just time out.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/agg-tx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 74a878f213d3..1deb3d874a4b 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2021 Intel Corporation
+ * Copyright (C) 2018 - 2022 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -626,6 +626,14 @@ int ieee80211_start_tx_ba_session(struct ieee80211_sta *pubsta, u16 tid,
 		return -EINVAL;
 	}
 
+	if (test_sta_flag(sta, WLAN_STA_MFP) &&
+	    !test_sta_flag(sta, WLAN_STA_AUTHORIZED)) {
+		ht_dbg(sdata,
+		       "MFP STA not authorized - deny BA session request %pM tid %d\n",
+		       sta->sta.addr, tid);
+		return -EINVAL;
+	}
+
 	/*
 	 * 802.11n-2009 11.5.1.1: If the initiating STA is an HT STA, is a
 	 * member of an IBSS, and has no other existing Block Ack agreement
-- 
2.34.1

