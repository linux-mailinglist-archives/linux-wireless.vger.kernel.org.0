Return-Path: <linux-wireless+bounces-600-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2184A80BACF
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 14:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5236A1C209DC
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 13:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A6111725;
	Sun, 10 Dec 2023 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBTyf9Q9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF3210A
	for <linux-wireless@vger.kernel.org>; Sun, 10 Dec 2023 05:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702213521; x=1733749521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/UJh+6vLJ/yJSM2o/VHmToPWAHarDUUaaFG2SSSIE48=;
  b=PBTyf9Q9HV+wkDDsuc7CBROqkcLhndZMA0xjg+n6yM7YKpsIoXPj9Hzu
   K7FbFkBsdf+7Q3jIorIIzhevQPbo915zkRZLbFInhDw7Fbna22CA/cHWz
   76zGTNXyj+8CqPr1mqLKgsBQS9Ao7UI/pQgfmulTqTiRvic1n5chrhWSV
   I5K/0SZSg+AnDlIU+OeYTL+KsbVbpWauSE1mE2vI8SjupVBi71vPHAiAO
   O+Kvmo1SpDOVmFZOL4JVB8Z9zb5UN8VrngzF5LIJ3mLk/mEr3g2qUr1BE
   MZrQUuMRTZjoUUcXDXX08VsTIh80dfzyANnyaAxMddOM8rVLTglQ7MFX7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="480745723"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="480745723"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:05:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="748925584"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="748925584"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:05:18 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>, Greenman@web.codeaurora.org,
	Gregory <gregory.greenman@intel.com>
Subject: [PATCH 05/14] wifi: mac80211: add a flag to disallow puncturing
Date: Mon, 11 Dec 2023 09:05:23 +0200
Message-Id: <20231211085121.c1e89ea55e93.I37b8ca0ee64d5d7699e351785a9010afc106da3c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
References: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There may be cases where puncturing isn't possible, and
a connection needs to be downgraded. Add a hardware flag
to support this.

This is likely temporary: it seems we will need to move
puncturing to the chandef/channel context.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h |  4 ++++
 net/mac80211/debugfs.c |  1 +
 net/mac80211/mlme.c    | 12 ++++++++++--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index aa8e1055fc3a..77a71b1396b1 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2686,6 +2686,9 @@ struct ieee80211_txq {
  * @IEEE80211_HW_MLO_MCAST_MULTI_LINK_TX: Hardware/driver handles transmitting
  *	multicast frames on all links, mac80211 should not do that.
  *
+ * @IEEE80211_HW_DISALLOW_PUNCTURING: HW requires disabling puncturing in EHT
+ *	and connecting with a lower bandwidth instead
+ *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2743,6 +2746,7 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_SUPPORTS_CONC_MON_RX_DECAP,
 	IEEE80211_HW_DETECTS_COLOR_COLLISION,
 	IEEE80211_HW_MLO_MCAST_MULTI_LINK_TX,
+	IEEE80211_HW_DISALLOW_PUNCTURING,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index b575ae90e57f..74be49191e70 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -497,6 +497,7 @@ static const char *hw_flag_names[] = {
 	FLAG(SUPPORTS_CONC_MON_RX_DECAP),
 	FLAG(DETECTS_COLOR_COLLISION),
 	FLAG(MLO_MCAST_MULTI_LINK_TX),
+	FLAG(DISALLOW_PUNCTURING),
 #undef FLAG
 };
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 887b496f2b81..2b1b64eb82f7 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -135,6 +135,7 @@ ieee80211_handle_puncturing_bitmap(struct ieee80211_link_data *link,
 				   u16 bitmap, u64 *changed)
 {
 	struct cfg80211_chan_def *chandef = &link->conf->chandef;
+	struct ieee80211_local *local = link->sdata->local;
 	u16 extracted;
 	u64 _changed = 0;
 
@@ -147,7 +148,9 @@ ieee80211_handle_puncturing_bitmap(struct ieee80211_link_data *link,
 							 bitmap);
 
 		if (cfg80211_valid_disable_subchannel_bitmap(&bitmap,
-							     chandef))
+							     chandef) &&
+		    !(bitmap && ieee80211_hw_check(&local->hw,
+						   DISALLOW_PUNCTURING)))
 			break;
 		link->u.mgd.conn_flags |=
 			ieee80211_chandef_downgrade(chandef);
@@ -5682,6 +5685,7 @@ static bool ieee80211_config_puncturing(struct ieee80211_link_data *link,
 					const struct ieee80211_eht_operation *eht_oper,
 					u64 *changed)
 {
+	struct ieee80211_local *local = link->sdata->local;
 	u16 bitmap = 0, extracted;
 
 	if ((eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT) &&
@@ -5713,6 +5717,9 @@ static bool ieee80211_config_puncturing(struct ieee80211_link_data *link,
 		return false;
 	}
 
+	if (bitmap && ieee80211_hw_check(&local->hw, DISALLOW_PUNCTURING))
+		return false;
+
 	ieee80211_handle_puncturing_bitmap(link, eht_oper, bitmap, changed);
 	return true;
 }
@@ -7584,7 +7591,8 @@ ieee80211_setup_assoc_link(struct ieee80211_sub_if_data *sdata,
 
 			bitmap = get_unaligned_le16(disable_subchannel_bitmap);
 			if (cfg80211_valid_disable_subchannel_bitmap(&bitmap,
-								     &link->conf->chandef))
+								     &link->conf->chandef) &&
+			    !(bitmap && ieee80211_hw_check(&local->hw, DISALLOW_PUNCTURING)))
 				ieee80211_handle_puncturing_bitmap(link,
 								   eht_oper,
 								   bitmap,
-- 
2.34.1


