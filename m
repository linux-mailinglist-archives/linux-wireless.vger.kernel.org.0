Return-Path: <linux-wireless+bounces-21141-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC3EA7AA85
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 21:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32AD9179820
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 19:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BB425A62B;
	Thu,  3 Apr 2025 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZI5ybgB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692D125A625;
	Thu,  3 Apr 2025 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707012; cv=none; b=hK0P5WExjZSDwGXjrLcSLhm6KSVuov2kzHqIoBXYUVDbHvPrXNa1RvcxJlU0T9r6Srz2f162TPeKG/qcbieWZEDXYXxvmIksj3u4FCf8PwZmdmlFF5r/iRGVsExY5HY+C5RLCn44M5EnMO9/uvkADIwy/j5CrRRT9fdtmL/0zK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707012; c=relaxed/simple;
	bh=e2X8vBO+kcgjTqY+W0KycZj3PvkeEu+edKkaEEPzrlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XXpijr01dyLhV8qC3FbdLJURLfboNv5FcfOPNoyVx7Vjs7y+8LZQCzElXvXv2AtUzCKrf6fxBEBw/LU6TeZArr4mVO3OakGgplV+8hhmvgskw/+pQgOuXJtZxI64lAu3q08B3Gi4fMYggShjTMmZCljAp302Cs4ImB4bJ7cDsB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZI5ybgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F77C4CEE8;
	Thu,  3 Apr 2025 19:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707010;
	bh=e2X8vBO+kcgjTqY+W0KycZj3PvkeEu+edKkaEEPzrlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hZI5ybgBeTP31Pl4wIzNNMa1YurR+q+/QMoUKnL3fs9KTcaoXRdiGFiAayZFzV9FR
	 XLi0ztakVznvsku9FEjWCgF19ALcqxR6lVaEDc618HrGy61Hg+aPGu0kn0/VCk3kLG
	 PkGNXxTyzAkohWvwAKIm6lfv1O98eWxYCkLYupKB5qt+B+789p7kDxnGwjR11oFRnL
	 vJJH638Eio/g044yRJnvW1U0lygyIttRHtd/c7f3XFwrpgF66Cl0QDMvqD1qZGMG4e
	 wgZJ03Olfe+n3UtQbgN62MWbzPAPv+9gJW7d/aZjnqddYw4p/8f6I7hTEc5hAwQAZj
	 Ry17kQ44el7iw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 35/54] wifi: mac80211: fix userspace_selectors corruption
Date: Thu,  3 Apr 2025 15:01:50 -0400
Message-Id: <20250403190209.2675485-35-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 700014d3ad1fd6e55c8f9ffa817514d3fbb5286e ]

Spotted during code review, the selectors need to be large
enough for a 128-bit bitmap, not a single unsigned long,
otherwise we have stack corruption.

We should also allow passing selectors from userspace, but
that should be a separate change.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250308225541.8f1bcf96a504.Ibeb8970c82a30c97279a4cc4e68faca5df1813a5@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 64fa3fba244eb..4951e4fa7373a 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -9648,8 +9648,6 @@ EXPORT_SYMBOL(ieee80211_disable_rssi_reports);
 
 static void ieee80211_ml_reconf_selectors(unsigned long *userspace_selectors)
 {
-	*userspace_selectors = 0;
-
 	/* these selectors are mandatory for ML reconfiguration */
 	set_bit(BSS_MEMBERSHIP_SELECTOR_SAE_H2E, userspace_selectors);
 	set_bit(BSS_MEMBERSHIP_SELECTOR_HE_PHY, userspace_selectors);
@@ -9669,7 +9667,7 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 		                sdata->u.mgd.reconf.removed_links;
 	u16 link_mask, valid_links;
 	unsigned int link_id;
-	unsigned long userspace_selectors;
+	unsigned long userspace_selectors[BITS_TO_LONGS(128)] = {};
 	size_t orig_len = len;
 	u8 i, group_key_data_len;
 	u8 *pos;
@@ -9777,7 +9775,7 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 	}
 
 	ieee80211_vif_set_links(sdata, valid_links, sdata->vif.dormant_links);
-	ieee80211_ml_reconf_selectors(&userspace_selectors);
+	ieee80211_ml_reconf_selectors(userspace_selectors);
 	link_mask = 0;
 	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
 		struct cfg80211_bss *cbss = add_links_data->link[link_id].bss;
@@ -9823,7 +9821,7 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 		link->u.mgd.conn = add_links_data->link[link_id].conn;
 		if (ieee80211_prep_channel(sdata, link, link_id, cbss,
 					   true, &link->u.mgd.conn,
-					   &userspace_selectors)) {
+					   userspace_selectors)) {
 			link_info(link, "mlo: reconf: prep_channel failed\n");
 			goto disconnect;
 		}
@@ -10157,14 +10155,14 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 	 */
 	if (added_links) {
 		bool uapsd_supported;
-		unsigned long userspace_selectors;
+		unsigned long userspace_selectors[BITS_TO_LONGS(128)] = {};
 
 		data = kzalloc(sizeof(*data), GFP_KERNEL);
 		if (!data)
 			return -ENOMEM;
 
 		uapsd_supported = true;
-		ieee80211_ml_reconf_selectors(&userspace_selectors);
+		ieee80211_ml_reconf_selectors(userspace_selectors);
 		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
 		     link_id++) {
 			struct ieee80211_supported_band *sband;
@@ -10240,7 +10238,7 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 						     data->link[link_id].bss,
 						     true,
 						     &data->link[link_id].conn,
-						     &userspace_selectors);
+						     userspace_selectors);
 			if (err)
 				goto err_free;
 		}
-- 
2.39.5


