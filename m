Return-Path: <linux-wireless+bounces-12-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 408FC7F6902
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 23:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4EF0B212CD
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 22:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BE24A9BE;
	Thu, 23 Nov 2023 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="c8Wu3P6n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4310BD60
	for <linux-wireless@vger.kernel.org>; Thu, 23 Nov 2023 14:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=otmmcFLnOKUc8cSls2Dv7CYsJv5mMEEslURXO+VqiEU=;
	t=1700778476; x=1701988076; b=c8Wu3P6nAt6dU8X14DteKH2ZhSx0KJFwGJmiPgR3ht5hRiN
	EWgzmj0Q0oJVBGh1xWzYiF8oodEJUQFNBSXbL6l4H/vJHwAI1F6bjWJ1C7ZfFMMYaLm8uaNoBiLlN
	ijdLPGZd0jp5uxpgNSSxCmFkuA1FIMZKPQUUbg9cmuRRVq6AK6kyvaZPFd2FM+4W3fR0jcr5bvbVY
	jaanFmg3ueU+A5UObIZ49eL1OJ/hqpyOiN4772dfayGhN5tq5RAI4O78k5kMrkbiXSvzcBgRNBsm/
	psXWehxI21EEiVYRB1lVL+o0svIvWag2MrblIpkvSV7ZLxBHGjY65GOM5qi0jA/Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6IAq-00000001Y53-44vE;
	Thu, 23 Nov 2023 23:27:53 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH v2 01/13] wifi: mac80211: simplify ieee80211_config_bw() prototype
Date: Thu, 23 Nov 2023 23:14:38 +0100
Message-ID: <20231123231436.d16617c03e0f.I8bd5ee848074029a9f0495c95e4339546ad8fe15@changeid>
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

The only user of this function passes a lot of pointers
directly from the parsed elements, so it's simpler to
just pass the entire elements parsing struct. This also
shows that the ht_cap is actually unused.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 887b496f2b81..778eef2f06f1 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -481,15 +481,15 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 }
 
 static int ieee80211_config_bw(struct ieee80211_link_data *link,
-			       const struct ieee80211_ht_cap *ht_cap,
-			       const struct ieee80211_vht_cap *vht_cap,
-			       const struct ieee80211_ht_operation *ht_oper,
-			       const struct ieee80211_vht_operation *vht_oper,
-			       const struct ieee80211_he_operation *he_oper,
-			       const struct ieee80211_eht_operation *eht_oper,
-			       const struct ieee80211_s1g_oper_ie *s1g_oper,
+			       struct ieee802_11_elems *elems,
 			       const u8 *bssid, u64 *changed)
 {
+	const struct ieee80211_vht_cap *vht_cap = elems->vht_cap_elem;
+	const struct ieee80211_ht_operation *ht_oper = elems->ht_operation;
+	const struct ieee80211_vht_operation *vht_oper = elems->vht_operation;
+	const struct ieee80211_he_operation *he_oper = elems->he_operation;
+	const struct ieee80211_eht_operation *eht_oper = elems->eht_operation;
+	const struct ieee80211_s1g_oper_ie *s1g_oper = elems->s1g_oper;
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
@@ -6340,11 +6340,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 
 	changed |= ieee80211_recalc_twt_req(sdata, sband, link, link_sta, elems);
 
-	if (ieee80211_config_bw(link, elems->ht_cap_elem,
-				elems->vht_cap_elem, elems->ht_operation,
-				elems->vht_operation, elems->he_operation,
-				elems->eht_operation,
-				elems->s1g_oper, bssid, &changed)) {
+	if (ieee80211_config_bw(link, elems, bssid, &changed)) {
 		sdata_info(sdata,
 			   "failed to follow AP %pM bandwidth change, disconnect\n",
 			   bssid);
-- 
2.42.0


