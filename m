Return-Path: <linux-wireless+bounces-9109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA9690B0F7
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 16:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1A11C21D7E
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B3D19E818;
	Mon, 17 Jun 2024 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4gFdhjN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC9619E814;
	Mon, 17 Jun 2024 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630803; cv=none; b=I/3/Zpe9X7kZ56HZPboe0prFClLQpOcoWJpa8RMEm2IbJ74Eswq5jYRz1pIqGLoLckekVqfWRWC9CHNlpLX6TXpnmK+wybCXY5KuTIAq7Lbht0ORsR5Xh2fnPGt7owH5Nki64SW5nhCTDDn19ilhLbKUbBBjkqw+t68gYmgtGKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630803; c=relaxed/simple;
	bh=8WLbFziU0zMdfTxwwQhPgmhRh05tOApmBTnDzFv5sCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqruNoLe3Neh8KyDRhsULq1E11AvLOS0kV9FhsbuvquovNksgVSZRb45kfUi9F5/16oV3UaIMhGp8mBnnhq1qeJqanUYYDEyXmprLNOO+EQAxBzstpK76fkaGdrufUhICPNV+3vAoXuXq3UuCRmpHTDZPvzpvcM3v3TrZxTgF08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4gFdhjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE07C4AF49;
	Mon, 17 Jun 2024 13:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630803;
	bh=8WLbFziU0zMdfTxwwQhPgmhRh05tOApmBTnDzFv5sCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s4gFdhjNu1he4A1kOrYG+s+Smy9hbLd03WmnDRwKevKTVSCH8Wguxz1/JkHqu7DHb
	 1KP+rlpB/ZMOwiOH4HxVth6OAqISqEoIhkk266ds0PQcMlJHCRgMQ9vdpI+XfEE34n
	 UGoocBQ8nar2nFz3z+AHKHUDX9AB7RFgXEI6f0vF3GieiHgwfGjTfFIoq/vFZ4HxCx
	 0ma9F82QzAbinHeKDHHKzMu2Hc9uXCVqSRn3pHHCYxo2Mk/jzQXmzwQhR+xpPd4y9Q
	 x27yezzGtpE+tvMVMHCQPQ8+y3SsdBdQnftVU7VxYpP/BuCKyJVbEYDqtCh6zDq0XX
	 g2sENCQuX+Q9g==
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
Date: Mon, 17 Jun 2024 09:25:49 -0400
Message-ID: <20240617132617.2589631-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132617.2589631-1-sashal@kernel.org>
References: <20240617132617.2589631-1-sashal@kernel.org>
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


