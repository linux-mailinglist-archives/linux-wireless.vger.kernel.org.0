Return-Path: <linux-wireless+bounces-10775-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B15F943B7A
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 02:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395CB1C21AD8
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 00:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D083149005;
	Thu,  1 Aug 2024 00:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YA4NBVLW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B65148FF7;
	Thu,  1 Aug 2024 00:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471293; cv=none; b=pP7GEaMZZeZuco0YdNdmePrFM6Y1gIguuJ3kFqdr535nijikEPzhCef37ROeasf310qKcZ+uh5NWikeHJhRc8VL80a4UQ3ZjUoJv4AfRAcgExw5kvwQgYQH5lXT4nD1TMJxR4EnHiTdaIfjecbb2hHSRGPYVlqWWoyBah/cJVSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471293; c=relaxed/simple;
	bh=Tq50UgeE7XkMX1Isg2Fj8+bIFxdVnvNfWmQ2TfwR2Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jk/PeuMc1YzFTUuLdJZMP0Tsx+kzwkOQdmwg3T6cMB5DvV304k6XhJiSPFRVfJyn+4PX17ED7Tz597ZCrt9tckn6FUvLf8kRVHcV2xsNPL/gZhTk+oTvpA9F3bQFGEgUq89yH9JqMn1h5pEV5ICQ0jMafjN3zRwp9bkSS/fxOtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YA4NBVLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78413C116B1;
	Thu,  1 Aug 2024 00:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471292;
	bh=Tq50UgeE7XkMX1Isg2Fj8+bIFxdVnvNfWmQ2TfwR2Sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YA4NBVLWQ74AKv9kmWpTB4K9hp7KphEaVVFGzjV/vkjrY05fbvslZbMfF2sRMRaMv
	 IQr2rtelnGE9DQeR8yABM/oxmv/uBQsK2TwpqLqAGhG+J8EbCiZNNewSnNFx/HCRmR
	 rr3nFrpEIIsZm45R7KEQhvrfJ0zFiYbUf4PnW9Em1FxlD+Ag74o9qtGFR7DzEbuJ1K
	 dj2+g8YR2g+7uRG8Hhc2gkKiB7fwbpK4Ibz9OWjP3JMwd8D9kKMxNN0DJPVObqTLcI
	 H9N8Eav05AZr/ZxvfFeJsHqrq/xSPBue7v1q4I93kv23Nw1giokLSpHSS+SsW/92iU
	 eq0ofGSzcz+Fw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	yedidya.ben.shimol@intel.com,
	gregory.greenman@intel.com,
	ilan.peer@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 058/121] wifi: iwlwifi: mvm: use only beacon BSS load for active links
Date: Wed, 31 Jul 2024 19:59:56 -0400
Message-ID: <20240801000834.3930818-58-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit d9b7531fe98a0c2a0387270557cf0a514c28dd28 ]

For active links, don't take information that may have been
received in probe responses, as those are not protected. For
inactive links, there may not be a choice.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240527190228.6947dc462fa9.I2076961211d6785c8a15b4308e0e87a413148222@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      | 14 ++++++++++++--
 .../net/wireless/intel/iwlwifi/mvm/tests/links.c   |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 6ec9a8e21a34e..7b03d3ad60673 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -504,17 +504,27 @@ iwl_mvm_get_puncturing_factor(const struct ieee80211_bss_conf *link_conf)
 static unsigned int
 iwl_mvm_get_chan_load(struct ieee80211_bss_conf *link_conf)
 {
+	struct ieee80211_vif *vif = link_conf->vif;
 	struct iwl_mvm_vif_link_info *mvm_link =
 		iwl_mvm_vif_from_mac80211(link_conf->vif)->link[link_conf->link_id];
 	const struct element *bss_load_elem;
 	const struct ieee80211_bss_load_elem *bss_load;
 	enum nl80211_band band = link_conf->chanreq.oper.chan->band;
+	const struct cfg80211_bss_ies *ies;
 	unsigned int chan_load;
 	u32 chan_load_by_us;
 
 	rcu_read_lock();
-	bss_load_elem = ieee80211_bss_get_elem(link_conf->bss,
-					       WLAN_EID_QBSS_LOAD);
+	if (ieee80211_vif_link_active(vif, link_conf->link_id))
+		ies = rcu_dereference(link_conf->bss->beacon_ies);
+	else
+		ies = rcu_dereference(link_conf->bss->ies);
+
+	if (ies)
+		bss_load_elem = cfg80211_find_elem(WLAN_EID_QBSS_LOAD,
+						   ies->data, ies->len);
+	else
+		bss_load_elem = NULL;
 
 	/* If there isn't BSS Load element, take the defaults */
 	if (!bss_load_elem ||
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c b/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
index f49e3c98b1ba4..991dc875a7ead 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
@@ -208,6 +208,7 @@ static void setup_link_conf(struct kunit *test)
 	bss_load->channel_util = params->channel_util;
 
 	rcu_assign_pointer(bss.ies, ies);
+	rcu_assign_pointer(bss.beacon_ies, ies);
 }
 
 static void test_link_grading(struct kunit *test)
-- 
2.43.0


