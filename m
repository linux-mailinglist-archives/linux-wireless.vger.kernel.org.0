Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17D1014EBAE
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 12:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgAaLZW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 06:25:22 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55914 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728395AbgAaLZV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 06:25:21 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixUEp-0002GC-LD; Fri, 31 Jan 2020 13:13:28 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 13:13:00 +0200
Message-Id: <20200131111300.891737-24-luca@coelho.fi>
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
Subject: [PATCH 23/23] mac80211: Properly set the SMPS mode for 6GHz station
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

The managed interface SMPS mode was not set in the HE 6GHz
capabilities IE. Set it.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/mac80211.h |  2 ++
 net/mac80211/mlme.c    | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 6d4ea71523d2..a930cc710e70 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -508,6 +508,7 @@ struct ieee80211_ftm_responder_params {
  *	mode only, set if the AP advertises TWT responder role)
  * @twt_responder: does this BSS support TWT requester (relevant for managed
  *	mode only, set if the AP advertises TWT responder role)
+ * @twt_protected: does this BSS support protected TWT frames
  * @assoc: association status
  * @ibss_joined: indicates whether this station is part of an IBSS
  *	or not
@@ -618,6 +619,7 @@ struct ieee80211_bss_conf {
 	bool he_support;
 	bool twt_requester;
 	bool twt_responder;
+	bool twt_protected;
 	/* association related data */
 	bool assoc, ibss_joined;
 	bool ibss_creator;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 9ab0842a7c37..34fe500df687 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3389,9 +3389,17 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 
 		bss_conf->he_support = sta->sta.he_cap.has_he;
 		changed |= ieee80211_recalc_twt_req(sdata, sta, elems);
-	} else {
+		if (elems->rsnx && elems->rsnx_len &&
+		    (elems->rsnx[0] & WLAN_RSNX_CAPA_PROTECTED_TWT) &&
+		    wiphy_ext_feature_isset(local->hw.wiphy,
+					    NL80211_EXT_FEATURE_PROTECTED_TWT))
+			bss_conf->twt_protected = true;
+		else
+			bss_conf->twt_protected = false;
+} else {
 		bss_conf->he_support = false;
 		bss_conf->twt_requester = false;
+		bss_conf->twt_protected = false;
 	}
 
 	if (bss_conf->he_support) {
-- 
2.24.1

