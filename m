Return-Path: <linux-wireless+bounces-9082-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D0090AF5F
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 15:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384A41F2162F
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 13:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68721AB903;
	Mon, 17 Jun 2024 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM9ACF2N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD51AB900;
	Mon, 17 Jun 2024 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630501; cv=none; b=CmW5JqAR/+z3ijiKD/11kTcqo4yNKb8qIHw+hBqpxly10JNswT2EoEl4+ChoU6xvWVCEk0vm+49a6zii/O3VElBTbm+7LZsy3HJTmbzgCC+zO/KZYdqKC89MbCRUckT6UD2XuNNNDN6LnCRTAM2LbXecGs34WI3R/Ec1lZQdc2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630501; c=relaxed/simple;
	bh=0GLwHGGaShKSnlBuhwBKV7mfWNIEaVSqkUQvGMUJcpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRPUeIiZK0lyPWyIRwx9dnNgTmrQH6P06ExCZjUuFjbXSUR0oK1TqegZDEqkUfUpoSR++rkDuzSfIYr6lw5umQE8zcYlsgTrEa44mZyv/LIsuUTqm5bZ+RlumvDVFb7F6FCIZC4r0LFlwfJvnzMYmBhA12/6zRlUVUit5RzTfq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM9ACF2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5478DC2BD10;
	Mon, 17 Jun 2024 13:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630501;
	bh=0GLwHGGaShKSnlBuhwBKV7mfWNIEaVSqkUQvGMUJcpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PM9ACF2NNyC1zbKa0VzawrxT1PTttOcR5VgTZ+ZmCglsJYnAY2OgmEOQBUKMartY3
	 t+Jt8hVaiFi9kXlV82bF2xAuRjaXtcL6jtzT0p/91182RDzjBl+mXxNlIllwSs601t
	 JIAw3MCzMAHcGEG0sPLkpq6GtfradylFn09rz9WaVSSTybC2xquS0WOpXjJ5xpMTS4
	 ZycwdHdpSwiMIhJTV6vM3BDdMNZYBZv1r+Ji5W77/+SouwTu2lvh28RBSfumL48/e7
	 0YyGrUCQKrRpjyVecWc0etc5AFx6rvp/gNOcL0vJ8FK5FBu63p9v24eDx1mYdo1arO
	 l/ib0aEFcN5MA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ayala Beker <ayala.beker@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	gregory.greenman@intel.com,
	benjamin.berg@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 22/44] wifi: iwlwifi: mvm: properly set 6 GHz channel direct probe option
Date: Mon, 17 Jun 2024 09:19:35 -0400
Message-ID: <20240617132046.2587008-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132046.2587008-1-sashal@kernel.org>
References: <20240617132046.2587008-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
Content-Transfer-Encoding: 8bit

From: Ayala Beker <ayala.beker@intel.com>

[ Upstream commit 989830d1cf16bd149bf0690d889a9caef95fb5b1 ]

Ensure that the 6 GHz channel is configured with a valid direct BSSID,
avoiding any invalid or multicast BSSID addresses.

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240513132416.91a631a0fe60.I2ea2616af9b8a2eaf959b156c69cf65a2f1204d4@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 22bc032cffc8b..81d4a96a1c2c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1717,7 +1717,10 @@ iwl_mvm_umac_scan_fill_6g_chan_list(struct iwl_mvm *mvm,
 				break;
 		}
 
-		if (k == idex_b && idex_b < SCAN_BSSID_MAX_SIZE) {
+		if (k == idex_b && idex_b < SCAN_BSSID_MAX_SIZE &&
+		    !WARN_ONCE(!is_valid_ether_addr(scan_6ghz_params[j].bssid),
+			       "scan: invalid BSSID at index %u, index_b=%u\n",
+			       j, idex_b)) {
 			memcpy(&pp->bssid_array[idex_b++],
 			       scan_6ghz_params[j].bssid, ETH_ALEN);
 		}
-- 
2.43.0


