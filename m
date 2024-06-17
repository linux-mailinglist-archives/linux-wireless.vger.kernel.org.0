Return-Path: <linux-wireless+bounces-9093-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA49F90AFEA
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 15:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1461C220A1
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 13:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D761C68B2;
	Mon, 17 Jun 2024 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVuCiaNA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D35819B3F9;
	Mon, 17 Jun 2024 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630639; cv=none; b=nIN15iPHBCU6pxmYc9Wh0Q/3/v8oU9DDX8RIoj2KcRRsdsmW2lXJ6ul48cs11IOZ/CURJ7HAL5MkwcCqKsiA/raLHCGoG05Bsf9ZFl4JSTy9kAl0wvwdkVMS9OrnO/9luCYKwpz7yBpRuTCNV1C7/LjxgKfQuixlx+dTTfreFiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630639; c=relaxed/simple;
	bh=oL2RJNCGK0o4MseziMSXNn0aSdA+cdU6tgtgsUdPQ/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7JvIpk0YxCAj2BGWuwqJ38ZSFYuOlgdiCGTQHsA+y1kOZg7fS6vIpZ1HXhb34EwiCxgcmV/dy5h2hGeWvg2hAdMYS4YK/K40BnowS7yUe1dTfPwpUZXM4ACP3PhPY9o9PEMIpxNQbyrlmeFqFT96kuy531r5dNX1rDPjdf703Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVuCiaNA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBD6C4AF1D;
	Mon, 17 Jun 2024 13:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630639;
	bh=oL2RJNCGK0o4MseziMSXNn0aSdA+cdU6tgtgsUdPQ/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nVuCiaNAyutjl6UwwAWUkTwEu0mMtbITnLWMKJ0sPJxxUXG9PK1EUGdezlSdP1i2x
	 0Aqr7KhGDGB0Y3nT5bmok3dlV67ukMw/PHPxIMTcDD+N0Qe1fv6+nRhZInhaKhjixR
	 D6uDIBv5MDVUfUddLbeavi7Ul9omCvpiCb53lKgK/NB9Afv6YgHhMPm9qW4HBqE53d
	 Q5Z0wOcSqdZQeN6QNdfsdHj9CYKlrYmIbg5QF45dMto3XbYznCEksQw/nxARUCpkGU
	 lyF2org0y3I8hBQSwuQ1bytYGeZNuB62dbjijdUQ527lQnm8Ofc7ICDxDHbeTAYIW6
	 F+slbbWzZUV9w==
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
Subject: [PATCH AUTOSEL 6.6 19/35] wifi: iwlwifi: mvm: properly set 6 GHz channel direct probe option
Date: Mon, 17 Jun 2024 09:22:17 -0400
Message-ID: <20240617132309.2588101-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132309.2588101-1-sashal@kernel.org>
References: <20240617132309.2588101-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.34
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
index 03ec900a33433..d1dae33fe8884 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1718,7 +1718,10 @@ iwl_mvm_umac_scan_fill_6g_chan_list(struct iwl_mvm *mvm,
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


