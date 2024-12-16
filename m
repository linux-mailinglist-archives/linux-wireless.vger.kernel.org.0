Return-Path: <linux-wireless+bounces-16403-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6187C9F294B
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 05:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC9E1638ED
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 04:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5634C185B62;
	Mon, 16 Dec 2024 04:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Swywnszy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0011804E;
	Mon, 16 Dec 2024 04:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734323334; cv=none; b=S+7sAkr9/M9HfsnSX05SB2g0qAuVVgZiDhCW0WGzCe1qP/9FD0Sow6xoJoNU+HfQqXfaA6AcGMgAnLtwuc3NhUjPuL2Eea1VoANlbfFlKM5acSD7yRtFZcJLyOe4YAK0ZjU5BHvJgVvHe0sngaKau3V5eaj8xAbzzlLdcMuEszg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734323334; c=relaxed/simple;
	bh=+7ebeBX9/Sd+wZ9MZbhIg7jVGuJt5VnvgdgVtdj8Evo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PwyYuz/zte9pvckwLyOcIq8lMTpkfe6Va4cht5tluWh5hRv4VV8VBVCb8vXAPyNI2v0qdX59lr2KiTGugpmOFXWPF6I3UjcDUm+ZoRxuk2E3TRtHaVnno3Lff4lAKdYqhAjaJd1GgaDcLAaTA3dE7TmCgd4auzlraggKT/NluAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Swywnszy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87802C4CED0;
	Mon, 16 Dec 2024 04:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734323333;
	bh=+7ebeBX9/Sd+wZ9MZbhIg7jVGuJt5VnvgdgVtdj8Evo=;
	h=From:To:Cc:Subject:Date:From;
	b=SwywnszyURP7Q1UaRzBfKk0cAuAT6yqlPvm36ahD3h8V2kMqVEe3Fit6HPhNiNJAk
	 IhYWOxATY49Lc1859ZFjHvCh6h6TvV3VUccTlbpAljqKyZCCKrhyLATZxfbARiH9qG
	 HgR6SQq+eDtueD7qzO/2zkbF1MLCnbU3Bg+RnrbNyppwxqpUEv8R63mICSAc/WoCVg
	 PocUocHc3iQ17T3ZSaIgZMK8Cl72HUBnJbZT991bWXQaX8O7hUCRE705qZ/d51wzUk
	 uTn8SBMc8xwc/Zy0NNvZ2O+Z6QwmMX0+BU6HT6vZm4u0cGz5Jox6/y9P6d6h/ISyWi
	 vJCdKTGflA9hQ==
From: Kees Cook <kees@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Shaul Triebitz <shaul.triebitz@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH RESEND] wifi: iwlwifi: mvm: Fix __counted_by usage in cfg80211_wowlan_nd_*
Date: Sun, 15 Dec 2024 20:28:48 -0800
Message-Id: <20241216042843.work.498-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4355; i=kees@kernel.org; h=from:subject:message-id; bh=+7ebeBX9/Sd+wZ9MZbhIg7jVGuJt5VnvgdgVtdj8Evo=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnxa+pnTdhyv76o/kF3Y9G1dC0VUYsroVHPw4ROGUVJ3 Wc5MHNWRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwEQkLBkZXhtyfmZO+6i+ZoeQ 3iKbn08ehYo7n7ma1Gcyh7vIsfbuCoZ/xo8Dsw9NiypMumBszXryctLSzRMtju2edvR0xAnZ/jl azAA=
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
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://lore.kernel.org/r/20240619211233.work.355-kees@kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
---
Pinging this patch again, see https://lore.kernel.org/lkml/20240619211233.work.355-kees@kernel.org/
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index f85c01e04ebf..7d973546c9fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2954,6 +2954,7 @@ static void iwl_mvm_query_set_freqs(struct iwl_mvm *mvm,
 				    int idx)
 {
 	int i;
+	int n_channels = 0;
 
 	if (fw_has_api(&mvm->fw->ucode_capa,
 		       IWL_UCODE_TLV_API_SCAN_OFFLOAD_CHANS)) {
@@ -2962,7 +2963,7 @@ static void iwl_mvm_query_set_freqs(struct iwl_mvm *mvm,
 
 		for (i = 0; i < SCAN_OFFLOAD_MATCHING_CHANNELS_LEN * 8; i++)
 			if (matches[idx].matching_channels[i / 8] & (BIT(i % 8)))
-				match->channels[match->n_channels++] =
+				match->channels[n_channels++] =
 					mvm->nd_channels[i]->center_freq;
 	} else {
 		struct iwl_scan_offload_profile_match_v1 *matches =
@@ -2970,9 +2971,11 @@ static void iwl_mvm_query_set_freqs(struct iwl_mvm *mvm,
 
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
@@ -3053,6 +3056,8 @@ static void iwl_mvm_query_netdetect_reasons(struct iwl_mvm *mvm,
 			     GFP_KERNEL);
 	if (!net_detect || !n_matches)
 		goto out_report_nd;
+	net_detect->n_matches = n_matches;
+	n_matches = 0;
 
 	for_each_set_bit(i, &matched_profiles, mvm->n_nd_match_sets) {
 		struct cfg80211_wowlan_nd_match *match;
@@ -3066,8 +3071,9 @@ static void iwl_mvm_query_netdetect_reasons(struct iwl_mvm *mvm,
 				GFP_KERNEL);
 		if (!match)
 			goto out_report_nd;
+		match->n_channels = n_channels;
 
-		net_detect->matches[net_detect->n_matches++] = match;
+		net_detect->matches[n_matches++] = match;
 
 		/* We inverted the order of the SSIDs in the scan
 		 * request, so invert the index here.
@@ -3082,6 +3088,8 @@ static void iwl_mvm_query_netdetect_reasons(struct iwl_mvm *mvm,
 
 		iwl_mvm_query_set_freqs(mvm, d3_data->nd_results, match, i);
 	}
+	/* We may have fewer matches than we allocated. */
+	net_detect->n_matches = n_matches;
 
 out_report_nd:
 	wakeup.net_detect = net_detect;
-- 
2.34.1


