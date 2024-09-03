Return-Path: <linux-wireless+bounces-12432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2926F96A956
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 22:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C1911C244B7
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD811E7D8E;
	Tue,  3 Sep 2024 20:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Firvkp2L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8AC1E7D8A;
	Tue,  3 Sep 2024 20:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396419; cv=none; b=Lo/Jxa6VWOlw6GGvduPEUplLG5sCJ1O+wgYh+jdjsXNeuf3sDswrjwxRnpnKDn9Mencq2St2tjphaivaU1Jzj4/Sgdz8cqsTXzsMslay+Qd1OjjN5LMR4Ci+95Dp+zbfiA+CR7/QccpN6Ngt9jRxFJSYhjJ+F/ZnMH1rbk0VuGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396419; c=relaxed/simple;
	bh=kZQszGWw/fmFm1OtN3ftcqD/xN8oO3ZAdRjOKNbZxtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzP5EhG+T18/1+Pl1lNOY0VqwwMM0ohjjN2fu4HNRaRrphAKW3g35N01G2Dbj8NNcD3iXkDDKmLmcESj6uTeVhU6ddhGopWBFC8DcZ42yJm4sTfOabAUVGPZ3h29UTd8D8gA5PbuqWTJJF1Jg7hdqhxksYr3KA2YVu14Nqu+H10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Firvkp2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9B7C4CEC8;
	Tue,  3 Sep 2024 20:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396418;
	bh=kZQszGWw/fmFm1OtN3ftcqD/xN8oO3ZAdRjOKNbZxtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Firvkp2LSjLgAkItsO4a8EAb2zyDJECC7whql21lxlkV6sA2yJdq2m1goaBYuV6gX
	 Dm8Ok1YDK3ghfpofBDqngiQPvWqyNU0+yfOOtYnDKLWyC7WoSVg+0v/xDzo+oPcBMc
	 km6liW7m+QUClkstz6wwIOkBH0R4ii34FW+poI2/LSSGTyKUMivUgXeKyec8oMyOTv
	 6EPqvqQGlZGMgtkjOIRkRjZm3uH0MwGLJfcmhDwMfvXho880vuR7YQcpZArnzgiCd7
	 reY90DTISELukJ+Pp8hcfg3y7iULOFIorzRDr7gVcbx6AJ6UqDb6UlgiZKo/jTqSBb
	 JCMaFpdsjhz6g==
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
Subject: [PATCH AUTOSEL 5.15 09/12] wifi: iwlwifi: mvm: fix iwl_mvm_scan_fits() calculation
Date: Tue,  3 Sep 2024 15:26:53 -0400
Message-ID: <20240903192718.1108456-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192718.1108456-1-sashal@kernel.org>
References: <20240903192718.1108456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.165
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
index 8179a7395bcaf..d6e25f7e700ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -834,8 +834,8 @@ static inline bool iwl_mvm_scan_fits(struct iwl_mvm *mvm, int n_ssids,
 	return ((n_ssids <= PROBE_OPTION_MAX) &&
 		(n_channels <= mvm->fw->ucode_capa.n_scan_channels) &
 		(ies->common_ie_len +
-		 ies->len[NL80211_BAND_2GHZ] +
-		 ies->len[NL80211_BAND_5GHZ] <=
+		 ies->len[NL80211_BAND_2GHZ] + ies->len[NL80211_BAND_5GHZ] +
+		 ies->len[NL80211_BAND_6GHZ] <=
 		 iwl_mvm_max_scan_ie_fw_cmd_room(mvm)));
 }
 
@@ -2775,18 +2775,16 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
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
@@ -2803,6 +2801,9 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 		mvm->sched_scan_pass_all = SCHED_SCAN_PASS_ALL_DISABLED;
 	}
 
+out:
+	if (non_psc_included)
+		kfree(params.channels);
 	return ret;
 }
 
-- 
2.43.0


