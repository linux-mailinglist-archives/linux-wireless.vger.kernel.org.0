Return-Path: <linux-wireless+bounces-9256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA2E90F848
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 23:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE901C2347F
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 21:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B99515A87E;
	Wed, 19 Jun 2024 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3L4Gs0Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEBF15A864;
	Wed, 19 Jun 2024 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718831570; cv=none; b=CX2h6KPDXgQu25Lme9bgoDLMFySsz1vOT1FPFURKZYArS44Hup2KDk9/SDD+v7VyrvFDzhWS/tZmiM7v4Gq4PpmR+rxKcEqx/j14NP/3aEwLoQDq1fQD3JLXK0vwQj/Qos6yOm8SyButxm7w8VOJfScpWJnmZf3GbhVe48lf0AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718831570; c=relaxed/simple;
	bh=VhvaB5BCvNV/7ItMlUKCyJLkhBGaN1WYVCzerkxhHBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EsyjRcchTSpmnzn+73oUCQ2x9woR2+AdanGP0C2HTrQ2AkPXLeqsOn+oU4sXKkC1OCGnBw7cRP/oorpdwXBzTauqo6WAULfWNsLU3PHwwZYcwdbR2dgq4TksiyPmAR36VQXieQihUls6kf1Z5niUgH1F6gNxMXngD7nbKz+qiCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3L4Gs0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7ABC4AF08;
	Wed, 19 Jun 2024 21:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718831570;
	bh=VhvaB5BCvNV/7ItMlUKCyJLkhBGaN1WYVCzerkxhHBw=;
	h=From:To:Cc:Subject:Date:From;
	b=P3L4Gs0QlChkUuo1QBHJaK/flrUElZ+KaSTcZ4frLteSfcDzMnN7yFLJJcs47xL0Z
	 i+Y4f5uj9sK4tdvftb7AvTQ3vdmcXhjYp59Gh5Eu/in27JyaQe3iTgFapgYSLQiaVM
	 W6+WV9yuXTC4FsgFrlHTMtgcPTsj4puvrzCAaRG4cZL9V7iEUWTU8ZXxdWNVlHlEsI
	 +5U5lX9UJ9iZlIncU1/Wh+fG3XCac7nqHD9ix04ZNV6Nv+9+JolqawqewWa+uobOvH
	 98RVza7BvOFt+1MbUMmlMEcTOuqKbLshDzEnHoIGHQ/kJbO+9zwonPX3GRd/yNBVpm
	 tRtPInq4+LItA==
From: Kees Cook <kees@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Kees Cook <kees@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Luca Coelho <luciano.coelho@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Haim Dreyfuss <haim.dreyfuss@intel.com>,
	linux-wireless@vger.kernel.org,
	Shaul Triebitz <shaul.triebitz@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: iwlwifi: mvm: Fix __counted_by usage in cfg80211_wowlan_nd_*
Date: Wed, 19 Jun 2024 14:12:45 -0700
Message-Id: <20240619211233.work.355-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4538; i=kees@kernel.org; h=from:subject:message-id; bh=VhvaB5BCvNV/7ItMlUKCyJLkhBGaN1WYVCzerkxhHBw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmc0nNQq/TPpPwGi/dcbLKQg7pM3dYduoJRnrEc 9b2bi/VJ3yJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZnNJzQAKCRCJcvTf3G3A JipeEACLsBS4IKYSggSdsDiaoVdZGiEWdHgktl+fWWYFyGZFS/mm40ZAKDIhC93qTfGA64t7mKz ZumswcVRdDpGwG3hPg2A3ZVIGeU1KL+/0uzAUrkZmMUpzvRx+uDH4x+JfekHG6VOpMnT7rvjuM7 5GHZe2MOlZcxffAutHv6sWps17rC3v6g8a6/mwcwFRvwepN0UJmaMsugPXgV/gqxQSvgn9pizdC HpShJhoK+KtpJ3BmvQx/5qdplCQ3fuQXM+iRCLNb4CVkFg8LC8w88xWRZsvK8VVKJt/BWdtIyI2 /y5XlVV7AgV/57d/iCUZeowXYGmX412+lN2Ha0ra7I3rNmmKaC08t/jifsEzr00bt8CEsLmdLVi UaFUMa0O87QSXcqTSz3qHukdVOFuxfXR2wSY0Mm7vqOx3JrCMPMcRi7prEfiqYOgpQqEvaPKBxc IeN1mxGVPVW5JD6V2XWdKAFzKhwt9OUQJCENDWCsvaqDZso1DlI6+M0Qb9YP37gQQiXW5NENViG UZDZaUvvvjkvIDIl3yjRl8jWC+RMLHPx2AbnsNZYWaPIAuLCEwEM8o5HBvinzPGZSrR6ln75+VY MENyn9vSCJ/QQprEW/f4GeF/NHDH+n0IgPcazJqYIUmdwJQY1Wqrdy8rUU4UE6iON/wGQhgX3q7 lJYBhKw6LGP+l
 CA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Both struct cfg80211_wowlan_nd_match and struct cfg80211_wowlan_nd_info
pre-allocate space for channels and matches, but then may end up using
fewer that the full allocation. Shrink the associated counter
(n_channels and n_matches) after counting the results. This avoids
compile-time (and run-time) warnings from __counted_by. (The counter
member needs to be updated _before_ accessing the array index.)

Seen with coming GCC 15:

drivers/net/wireless/intel/iwlwifi/mvm/d3.c: In function 'iwl_mvm_query_set_freqs':
drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2877:66: warning: operation on 'match->n_channels' may be undefined [-Wsequence-point]
 2877 |                                 match->channels[match->n_channels++] =
      |                                                 ~~~~~~~~~~~~~~~~~^~
drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2885:66: warning: operation on 'match->n_channels' may be undefined [-Wsequence-point]
 2885 |                                 match->channels[match->n_channels++] =
      |                                                 ~~~~~~~~~~~~~~~~~^~
drivers/net/wireless/intel/iwlwifi/mvm/d3.c: In function 'iwl_mvm_query_netdetect_reasons':
drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2982:58: warning: operation on 'net_detect->n_matches' may be undefined [-Wsequence-point]
 2982 |                 net_detect->matches[net_detect->n_matches++] = match;
      |                                     ~~~~~~~~~~~~~~~~~~~~~^~

Fixes: aa4ec06c455d ("wifi: cfg80211: use __counted_by where appropriate")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Luca Coelho <luciano.coelho@intel.com>
Cc: Gregory Greenman <gregory.greenman@intel.com>
Cc: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Cc: Haim Dreyfuss <haim.dreyfuss@intel.com>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 54f4acbbd05b..9cd03ea4680d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2866,6 +2866,7 @@ static void iwl_mvm_query_set_freqs(struct iwl_mvm *mvm,
 				    int idx)
 {
 	int i;
+	int n_channels = 0;
 
 	if (fw_has_api(&mvm->fw->ucode_capa,
 		       IWL_UCODE_TLV_API_SCAN_OFFLOAD_CHANS)) {
@@ -2874,7 +2875,7 @@ static void iwl_mvm_query_set_freqs(struct iwl_mvm *mvm,
 
 		for (i = 0; i < SCAN_OFFLOAD_MATCHING_CHANNELS_LEN * 8; i++)
 			if (matches[idx].matching_channels[i / 8] & (BIT(i % 8)))
-				match->channels[match->n_channels++] =
+				match->channels[n_channels++] =
 					mvm->nd_channels[i]->center_freq;
 	} else {
 		struct iwl_scan_offload_profile_match_v1 *matches =
@@ -2882,9 +2883,11 @@ static void iwl_mvm_query_set_freqs(struct iwl_mvm *mvm,
 
 		for (i = 0; i < SCAN_OFFLOAD_MATCHING_CHANNELS_LEN_V1 * 8; i++)
 			if (matches[idx].matching_channels[i / 8] & (BIT(i % 8)))
-				match->channels[match->n_channels++] =
+				match->channels[n_channels++] =
 					mvm->nd_channels[i]->center_freq;
 	}
+	/* We may have ended up with fewer channels than we allocated. */
+	match->n_channels = n_channels;
 }
 
 /**
@@ -2965,6 +2968,8 @@ static void iwl_mvm_query_netdetect_reasons(struct iwl_mvm *mvm,
 			     GFP_KERNEL);
 	if (!net_detect || !n_matches)
 		goto out_report_nd;
+	net_detect->n_matches = n_matches;
+	n_matches = 0;
 
 	for_each_set_bit(i, &matched_profiles, mvm->n_nd_match_sets) {
 		struct cfg80211_wowlan_nd_match *match;
@@ -2978,8 +2983,9 @@ static void iwl_mvm_query_netdetect_reasons(struct iwl_mvm *mvm,
 				GFP_KERNEL);
 		if (!match)
 			goto out_report_nd;
+		match->n_channels = n_channels;
 
-		net_detect->matches[net_detect->n_matches++] = match;
+		net_detect->matches[n_matches++] = match;
 
 		/* We inverted the order of the SSIDs in the scan
 		 * request, so invert the index here.
@@ -2994,6 +3000,8 @@ static void iwl_mvm_query_netdetect_reasons(struct iwl_mvm *mvm,
 
 		iwl_mvm_query_set_freqs(mvm, d3_data->nd_results, match, i);
 	}
+	/* We may have fewer matches than we allocated. */
+	net_detect->n_matches = n_matches;
 
 out_report_nd:
 	wakeup.net_detect = net_detect;
-- 
2.34.1


