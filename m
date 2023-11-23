Return-Path: <linux-wireless+bounces-9-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 254457F68FE
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 23:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566A01C20C02
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 22:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CB33FB39;
	Thu, 23 Nov 2023 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tmDXbQvl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C70CB
	for <linux-wireless@vger.kernel.org>; Thu, 23 Nov 2023 14:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=x5RvPcAtT1lLjPZgResW0su+xTW6MLY3b0x/4xe49FE=;
	t=1700778477; x=1701988077; b=tmDXbQvl75dxxgfJ3xV+2qobFLrvAgr5gqrDp070oQC71wX
	qT/CwIDYyMRLSzBWM814JF1Squil+PylzLkCoofLEjIOO6Zchtt3w9uQddRGRXUE/pMRKRDkrfbUi
	XZPoDs+AEnNJbW74DYxWmFqn+3OmjDnPb2XkO2lFsCTITy0hj0UFmXv0KbNzfGdxXhOx9RfVuNpR8
	2uuqzmYiI0bFH8aBu+dT2Ewjo9j/emZOcrjsLneockmym5msMA6kDltMpmUQ5kgWra9EDWCstAzUc
	ualonKzcMYhqF+97EgGzr9mNvF5wfeSFDP3O0GH7Hw5rnHGuD86IpBK3ciIEXQuQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6IAs-00000001Y53-404t;
	Thu, 23 Nov 2023 23:27:55 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH v2 04/13] wifi: mac80211: simplify HE capability access
Date: Thu, 23 Nov 2023 23:14:41 +0100
Message-ID: <20231123231436.c835026f0ff5.I8baa604dd3f3399e08b86c99395a2c6a1185d35d@changeid>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123221436.143254-14-johannes@sipsolutions.net>
References: <20231123221436.143254-14-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

For verifying the required HE capabilities are supported
locally, we access the HE capability element of the AP.
Simplify that access, we've already parsed and validated
it when parsing elements.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 32 +++++---------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index d3b32fecc91d..0e9ed0e3e70b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4525,41 +4525,17 @@ static u8 ieee80211_max_rx_chains(struct ieee80211_link_data *link,
 
 static bool
 ieee80211_verify_peer_he_mcs_support(struct ieee80211_sub_if_data *sdata,
-				     const struct cfg80211_bss_ies *ies,
+				     const struct ieee80211_he_cap_elem *he_cap,
 				     const struct ieee80211_he_operation *he_op)
 {
-	const struct element *he_cap_elem;
-	const struct ieee80211_he_cap_elem *he_cap;
 	struct ieee80211_he_mcs_nss_supp *he_mcs_nss_supp;
 	u16 mcs_80_map_tx, mcs_80_map_rx;
 	u16 ap_min_req_set;
-	int mcs_nss_size;
 	int nss;
 
-	he_cap_elem = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_CAPABILITY,
-					     ies->data, ies->len);
-
-	if (!he_cap_elem)
+	if (!he_cap)
 		return false;
 
-	/* invalid HE IE */
-	if (he_cap_elem->datalen < 1 + sizeof(*he_cap)) {
-		sdata_info(sdata,
-			   "Invalid HE elem, Disable HE\n");
-		return false;
-	}
-
-	/* skip one byte ext_tag_id */
-	he_cap = (void *)(he_cap_elem->data + 1);
-	mcs_nss_size = ieee80211_he_mcs_nss_size(he_cap);
-
-	/* invalid HE IE */
-	if (he_cap_elem->datalen < 1 + sizeof(*he_cap) + mcs_nss_size) {
-		sdata_info(sdata,
-			   "Invalid HE elem with nss size, Disable HE\n");
-		return false;
-	}
-
 	/* mcs_nss is right after he_cap info */
 	he_mcs_nss_supp = (void *)(he_cap + 1);
 
@@ -4924,7 +4900,9 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 			}
 		}
 
-		if (!ieee80211_verify_peer_he_mcs_support(sdata, ies, he_oper) ||
+		if (!ieee80211_verify_peer_he_mcs_support(sdata,
+							  (void *)elems->he_cap,
+							  he_oper) ||
 		    !ieee80211_verify_sta_he_mcs_support(sdata, sband, he_oper))
 			*conn_flags |= IEEE80211_CONN_DISABLE_HE |
 				       IEEE80211_CONN_DISABLE_EHT;
-- 
2.42.0


