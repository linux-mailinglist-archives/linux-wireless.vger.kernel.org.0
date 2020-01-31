Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C0A14EB81
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 12:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgAaLNO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 06:13:14 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55788 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728325AbgAaLNN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 06:13:13 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixUEY-0002GC-UN; Fri, 31 Jan 2020 13:13:11 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 13:12:42 +0200
Message-Id: <20200131111300.891737-6-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131111300.891737-1-luca@coelho.fi>
References: <20200131111300.891737-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 05/23] mac80211: remove some stray braces
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Remove some braces that were left in a previous fix where
they're no longer needed.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/mlme.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ffe8cb35ab43..f076e73314a6 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4849,9 +4849,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		break;
 	}
 
-	if (!have_80mhz) {
+	if (!have_80mhz)
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
-	}
 
 	ifmgd->flags |= ieee80211_determine_chantype(sdata, sband,
 						     cbss->channel,
@@ -5463,9 +5462,8 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
 	}
 
-	if (req->flags & ASSOC_REQ_DISABLE_VHT) {
+	if (req->flags & ASSOC_REQ_DISABLE_VHT)
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
-	}
 
 	err = ieee80211_prep_connection(sdata, req->bss, true, override);
 	if (err)
-- 
2.24.1

