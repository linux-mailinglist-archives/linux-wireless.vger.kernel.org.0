Return-Path: <linux-wireless+bounces-9180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E83A90CD59
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 15:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23DD2B2C991
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 13:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB911A3BC0;
	Tue, 18 Jun 2024 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPiqfLdq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F501A3BBE;
	Tue, 18 Jun 2024 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714454; cv=none; b=NFZWOuIr+mZjZ28mZughE4CSC5iAYMxUi2MjQ0kejiDlikGyZb7/QjArBN9QQjJM+gzHaWKtas0YgccmicZXNQyFM8u8sbqthygt+jTSiZfXwYqrq04LPsY7e485CcEibQyXYhOExUV9QxL75XaChRCqpn7xIlN2swwnhfHYk50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714454; c=relaxed/simple;
	bh=SIY+XGznWIjYWRnwlRHisYlKO0m1D5ZxOPn78mfuTHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCgFQIf4JGRhEDdOJu1+bN4o+l1ZJuH3B3wGmOPyRhhIO9cd/iW0Vwjuh6mRWsPxwCcC6ngvcWuERlUFcSdb6gZBkidGjKojz08lmYcozboOtVnL9dehkBoLOBgMxLMHyDVa45CoU6MybGHC1uK0Z4GlQU+XITBtK56GCxETVVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPiqfLdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A8BC32786;
	Tue, 18 Jun 2024 12:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714454;
	bh=SIY+XGznWIjYWRnwlRHisYlKO0m1D5ZxOPn78mfuTHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lPiqfLdq/FM65oD2IzWxgXiUeRgQ2wBrCKrm91hcxWRF05Splb53Pw+zDdar+JPbl
	 TsKTQxMVR1VJFvhYMbVzkhYe8eyaPpMAFP5yFPW1Fx3rb8tj40sXe7Il1MGURi8Lst
	 qtDMPk6JQ84Dlyo8ry4DG0AkSFsGYg6qJB3TJ3mPvXMYKB+EKOpJhdh9hKlh2xWtcn
	 53zJsCcTVk4Jaemm24A76yQBtyoB0PRWGgYSHh8iX00TRgcibEUcOD0s8CAsGg2wwj
	 bG2YN9hBaYv4RZMz6b6VtrKZq47Tgchtifo8W3WHQc4/3J5I5IcCY5+ZeN63Wpjbvh
	 +Fe9BBPYcBukg==
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
Date: Tue, 18 Jun 2024 08:39:43 -0400
Message-ID: <20240618124018.3303162-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124018.3303162-1-sashal@kernel.org>
References: <20240618124018.3303162-1-sashal@kernel.org>
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


