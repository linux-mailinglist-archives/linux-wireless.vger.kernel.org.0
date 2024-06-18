Return-Path: <linux-wireless+bounces-9171-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C5A90CCD7
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 14:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A62EB285DC
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 12:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650EC1849FA;
	Tue, 18 Jun 2024 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDNXrz1L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1551849FE;
	Tue, 18 Jun 2024 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714362; cv=none; b=b5PhZ/pjpUitl/Ybq8KobbRreHp4Lli5d/b2Xzhi2QZhXFsHI0t3h8XXpckgoZMWPK15khgC+B+v05I/QoLtJ14sBZGJSuLcEFfRW/EsTyQZZjtwYWMv9YnNlm+nkGQHF69egQXGAhHovsuJJRJAdbn+lNttdOHs4Z0i/1BoeCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714362; c=relaxed/simple;
	bh=oL2RJNCGK0o4MseziMSXNn0aSdA+cdU6tgtgsUdPQ/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXBMJ7iU+cTIymsUJ/saGXsWhkxM3mBNnKN+EV2HTEItdCap72o9WbfYwxdjqJFLDNqgscMan/67+3wqY/AwXJGTKFsF+BOgS4a3FWbaqtRYypb0FjdKzncVrHo+VZmWHJ7T7gP71LsyVicxR3kAz6HAyAimjVSbZCnKrNRJA3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDNXrz1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD7BC3277B;
	Tue, 18 Jun 2024 12:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714361;
	bh=oL2RJNCGK0o4MseziMSXNn0aSdA+cdU6tgtgsUdPQ/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jDNXrz1LDsNCs5oRpmx2j8Chsy15yNwnjyz56zvQmcsORx+nElRjIlWCc42lM9JWS
	 IPEMjtxZ8Jfxrx41Jkrj5KCPmhDeSUWnW3RkLfk4sed+h/fZcIF3IGfWkoZ90Pcw7I
	 DBYQO9M626FT72OpKt51sPBtoXq/xezb+HyOO9kuPRV6iQrg9iezcOgZSHt6ZcwXfF
	 Q4uRQ2dJrDFJgE3OfnXC+mrj9IO7lzEikWp0vYzZsMLlUcxS3CfLnLWV6ut4k01s5C
	 mqdP4d4tu/MQ23u1WIk1rXYqbkqQGHs8t/80nSru8BjYM49mrrQFQH5gfvSr7Tw+5E
	 qXlCED8IzJXLg==
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
Date: Tue, 18 Jun 2024 08:37:39 -0400
Message-ID: <20240618123831.3302346-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123831.3302346-1-sashal@kernel.org>
References: <20240618123831.3302346-1-sashal@kernel.org>
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


