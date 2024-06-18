Return-Path: <linux-wireless+bounces-9187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8299490CD54
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 15:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB8A282CED
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 13:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82D01AD9C6;
	Tue, 18 Jun 2024 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcOhD4Py"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B2E13C801;
	Tue, 18 Jun 2024 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714525; cv=none; b=VyHQ9urTgDdC/YDH0WnGisDpmPSOf1u0FO5YbPgfFVyMm5BWVO49wq8/RWrkhw10A4UNmdzU/4BCo/tLTKwTU34fNVJuNEfZ9tcEL0tquY7UGq3dWicZWRCAnPbKUxd+UrVzTpwnhMqeMYsxjTkwEy9TMD8oZSLulLPqwxMKXHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714525; c=relaxed/simple;
	bh=8WLbFziU0zMdfTxwwQhPgmhRh05tOApmBTnDzFv5sCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCN0ZNc3fybiSYqjvG+ng/d+c27vyTNXXbQ7DNZ/IgqaTc+RIc4XAz9JzYX4gEJcLeoPFBX2uyFHKEGzU8L7YPglZsAGrvF1TB9DL2HmMXW8CbKh9UFTjmtkOFHaQIjWhhcTfohNby0vjhM1pOKdfVfC8YIkM88HFDzpfd8YV0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcOhD4Py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB3AC32786;
	Tue, 18 Jun 2024 12:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714525;
	bh=8WLbFziU0zMdfTxwwQhPgmhRh05tOApmBTnDzFv5sCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XcOhD4Pyb++aHN4NryJ6ULBzUBKmFTwHfhGCswG+kVBzmb1yy1lsC43AgBTDR8rIj
	 dLUdWjikWMkBczHKhm2G3riImic49zG0cIXAmVskXSf8s4ktANWhRBezez0z44+Qx+
	 Y3b3ugoDG+CmDYDx2ADCc9emsCJTaYPt6R66vIOsLx2sbShrzWT8q4ZwydTn8X1er1
	 9LnBDDIvCnG3Ouv2G3ILYnJOsfGFiKRbvNXNztvjqW33TwCWQgMF/bBjzk6uuqOvft
	 flcCaYml89n3t/APA0wq1XVB+0/RVTDysMHQCTXWTUx2tEgF5quBFYNwfrFVGHPN6I
	 AXxvmwITny3bQ==
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
Subject: [PATCH AUTOSEL 5.15 12/21] wifi: iwlwifi: mvm: properly set 6 GHz channel direct probe option
Date: Tue, 18 Jun 2024 08:41:11 -0400
Message-ID: <20240618124139.3303801-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124139.3303801-1-sashal@kernel.org>
References: <20240618124139.3303801-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.161
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
index c0ffa26bc5aaa..0f9016cda31c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1721,7 +1721,10 @@ iwl_mvm_umac_scan_fill_6g_chan_list(struct iwl_mvm *mvm,
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


