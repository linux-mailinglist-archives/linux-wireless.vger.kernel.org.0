Return-Path: <linux-wireless+bounces-9102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFC190B09D
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 15:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C181C22D4B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 13:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5EE17C01A;
	Mon, 17 Jun 2024 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQfC6os0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A413917C018;
	Mon, 17 Jun 2024 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630732; cv=none; b=Mm9WqImm5O30yzSZ34z9qwEToZilhMgrHqPOG3GPoU+4pW2+a2+kRN5TWQ4VHjEaU7qIsLkmeEcwf7mJXvDiG3iHJA1rC2+rLIHRpA/pOcHVDh2hvXZQMsJdYv2v4Bq2EmB1LKdQj5RuyQxUXZIPKDkkZC2gQwW/6If57RZLu8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630732; c=relaxed/simple;
	bh=SIY+XGznWIjYWRnwlRHisYlKO0m1D5ZxOPn78mfuTHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjbxwDsWO6uWTqoNxHGYZK7i1pJodiXI0dBLmH+sAPxlaBwniIHuXvly4jG+LW8ER5lJB0IN420UQV2LAkZX+B+Nd1tdFZV85rXKiTbgB3ckBRuEa22mePTgW+6ozbei4aUp0zYe9Mfq/ZYyuk06ua6mdxTkNgBP8DcH2i8mvfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQfC6os0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CE6C4AF49;
	Mon, 17 Jun 2024 13:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630732;
	bh=SIY+XGznWIjYWRnwlRHisYlKO0m1D5ZxOPn78mfuTHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rQfC6os0L5dYcjdxy/qKtFJirf6SJl1qTsfzzyx/UMzZssFCRhk3hTlZo1H8XTZ2f
	 ZWYX4VcjbHfePeObjr39zA4u39tWv7nHr1AkoWA+7Fhc8HeZN9IpVlhPIMXRREhUUX
	 oGju9wZWy2RBRSYuSY+sAgo6Mvhc4jyQ9QFy7kQRa/TsslDqW4v7cKI5WLnkiP00bT
	 UMkeyF2YhA+ExzLBlCcSgL2Pn5pMqM0uFglwgvvUJFPms+S8ioDDjNrX0WeNtfniHe
	 gknAhK8MxMWYY1WXMgSLkessqm0/P7izR3uBmPImpCVftKiOeIX/yi3nYsK3ZGz4k+
	 qNvT7tenqoVIA==
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
Subject: [PATCH AUTOSEL 6.1 17/29] wifi: iwlwifi: mvm: properly set 6 GHz channel direct probe option
Date: Mon, 17 Jun 2024 09:24:21 -0400
Message-ID: <20240617132456.2588952-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132456.2588952-1-sashal@kernel.org>
References: <20240617132456.2588952-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.94
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
index b20d64dbba1ad..686a55515cdec 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1707,7 +1707,10 @@ iwl_mvm_umac_scan_fill_6g_chan_list(struct iwl_mvm *mvm,
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


