Return-Path: <linux-wireless+bounces-12426-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D5596A931
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 22:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC62DB2462F
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57932126BE5;
	Tue,  3 Sep 2024 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwayQ/y8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D341126BE1;
	Tue,  3 Sep 2024 20:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396355; cv=none; b=Ze7fHQIyTkCswhmyHPJuVlfNbG6n5XMur0yA64yfLecqxZjuA2zx4MYHh62sE1rv5rZkRw/Qp184aDvtR2TM+7drmrv/G9J8IFfeuDpuSQq0K/97AeZIi7ShTfOMmryfQ9jHr+0b5/crW/vt6ojeD1xQpTAyKvV5ufan4L0hsq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396355; c=relaxed/simple;
	bh=Oybb4pvN4O3GfMTrezxA/QHIEqTXBFe2q7MswjlpnDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwIgAK4DIdd6gknxCGx6gAZim9OYdIZW1CxyM9Az60YTjL/d8kgqjeI//9USbxm4IWw7pzhpB4POCRxHRWrFrMyvRdTs63uTM6eP6CMn0sO+Y8Sf8IItcoNIX+4S8wenEKn+Fdv7pCq/geFk++tEgn2dmJKnIPVYcgr4CrKN/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwayQ/y8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F057C4CEC5;
	Tue,  3 Sep 2024 20:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396354;
	bh=Oybb4pvN4O3GfMTrezxA/QHIEqTXBFe2q7MswjlpnDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AwayQ/y81M/T9NiN+3O92nwfemZerZK8OG8Flr6NclhQ3NeS6yXHFAQ6E1X7e1vaF
	 OO3rVYs2mgmwVzr4SzH0Tjv+AYtGh5T5jcBBlld0hK5g90Czi0RqX2RuEOsaV9Vp9B
	 63tqKMIyJIZbDi7eheRY3LepHJywXkvo8dpb/UZPSwKhEzUXbjHwzT64mi4aY+uTrK
	 7AbyjeP9ambsRbShcDNq6b7G6Q4aOxwC1WEguW3FeFAhzAPO0VtbabE1R5qUSCIFr9
	 xORqupFNgrh8JxWB3pQczvha06YGlm5XCRqG2Duj0D46VuuPJ+7SbWP00RC4PPcFrQ
	 qgrMjzIFphHcg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	ayala.beker@intel.com,
	benjamin.berg@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 13/17] wifi: iwlwifi: mvm: fix iwl_mvm_scan_fits() calculation
Date: Tue,  3 Sep 2024 15:25:27 -0400
Message-ID: <20240903192600.1108046-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192600.1108046-1-sashal@kernel.org>
References: <20240903192600.1108046-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.107
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

[ Upstream commit d44162280899c3fc2c6700e21e491e71c3c96e3d ]

The calculation should consider also the 6GHz IE's len, fix that.
In addition, in iwl_mvm_sched_scan_start() the scan_fits helper is
called only in case non_psc_incldued is true, but it should be called
regardless, fix that as well.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20240825191257.7db825442fd2.I99f4d6587709de02072fd57957ec7472331c6b1d@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 23 ++++++++++---------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index b58441c2af730..20c5cc72e4269 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -824,8 +824,8 @@ static inline bool iwl_mvm_scan_fits(struct iwl_mvm *mvm, int n_ssids,
 	return ((n_ssids <= PROBE_OPTION_MAX) &&
 		(n_channels <= mvm->fw->ucode_capa.n_scan_channels) &
 		(ies->common_ie_len +
-		 ies->len[NL80211_BAND_2GHZ] +
-		 ies->len[NL80211_BAND_5GHZ] <=
+		 ies->len[NL80211_BAND_2GHZ] + ies->len[NL80211_BAND_5GHZ] +
+		 ies->len[NL80211_BAND_6GHZ] <=
 		 iwl_mvm_max_scan_ie_fw_cmd_room(mvm)));
 }
 
@@ -2935,18 +2935,16 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 		params.n_channels = j;
 	}
 
-	if (non_psc_included &&
-	    !iwl_mvm_scan_fits(mvm, req->n_ssids, ies, params.n_channels)) {
-		kfree(params.channels);
-		return -ENOBUFS;
+	if (!iwl_mvm_scan_fits(mvm, req->n_ssids, ies, params.n_channels)) {
+		ret = -ENOBUFS;
+		goto out;
 	}
 
 	uid = iwl_mvm_build_scan_cmd(mvm, vif, &hcmd, &params, type);
-
-	if (non_psc_included)
-		kfree(params.channels);
-	if (uid < 0)
-		return uid;
+	if (uid < 0) {
+		ret = uid;
+		goto out;
+	}
 
 	ret = iwl_mvm_send_cmd(mvm, &hcmd);
 	if (!ret) {
@@ -2963,6 +2961,9 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 		mvm->sched_scan_pass_all = SCHED_SCAN_PASS_ALL_DISABLED;
 	}
 
+out:
+	if (non_psc_included)
+		kfree(params.channels);
 	return ret;
 }
 
-- 
2.43.0


