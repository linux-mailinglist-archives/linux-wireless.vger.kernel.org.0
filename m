Return-Path: <linux-wireless+bounces-9160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5095490CC11
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 14:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606F01C21FA2
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 12:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B2E13D880;
	Tue, 18 Jun 2024 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMFIiRMR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A321D15A4B7;
	Tue, 18 Jun 2024 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714226; cv=none; b=PKZNRpYcfN1XqEQCIgdgbclZVjbF9Dmt0u+2RpxDeEKigA5FADpgxtUbXZ1R0KV6Hhe0dKYdTMQgZkRuZV7bSXMKgk3M79kQnqCNiCcOhPzlqbXnthbXiob3ce3pClYtygod8v5VFByCUJ+/Li96EyIiqTinhRyUDGuR9ddQYlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714226; c=relaxed/simple;
	bh=0GLwHGGaShKSnlBuhwBKV7mfWNIEaVSqkUQvGMUJcpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=moSqt3JPawNmweXo2OyZ3PpFsJP3g4x1uHT+6T2ePCzEj1vA1wtz0nAib7ZPMnU9LYslYAOWR/EwgkPijdQ3cmUwrYP+gxK9V9NERSiZWiTuMFU1MmQqCB2mOlR7b/rsJI0Od5RqZLjSOvgDRNQ0HrcQXqQvNijFBmnnYVDKzB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMFIiRMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1D3C4AF1D;
	Tue, 18 Jun 2024 12:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714226;
	bh=0GLwHGGaShKSnlBuhwBKV7mfWNIEaVSqkUQvGMUJcpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DMFIiRMRGyVhwKqwtsah0WlEMtHnNLW3HshwGWx+xy9jfSxC4gG3bsbTwn9G2ob0U
	 DfnVo5SGs3lK7OzVax1WNFkOTvjlhSXdCnzNl4+BosTTf2e0UZQAirell+Dw50ZP1J
	 alm04brwP1F47NN7mWN4Y6GzsD3gkmvCLLhy6quOhiA4UZn8iF6WLvarpcEbAxusTb
	 zb3P9b59L1KYJWJMAmC6p4h5peWG/oFTs24C1xqwz8eORCqdvlf1kqBjDTC40jPo3M
	 RxAzgLkcsOntE7Cx6ZlGyiT8t1cta8OiRT5YzeiBNNmOyxpK0OfYi8DXixNofpgKs6
	 dOcsUfDmoMfcg==
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
Date: Tue, 18 Jun 2024 08:35:03 -0400
Message-ID: <20240618123611.3301370-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
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


