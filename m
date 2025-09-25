Return-Path: <linux-wireless+bounces-27647-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456A1B9DF31
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 10:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7083ADCE8
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 08:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB5626A08A;
	Thu, 25 Sep 2025 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NnCXqymb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0671925DD0B;
	Thu, 25 Sep 2025 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758787224; cv=none; b=uUXOC8I7etHpSNazEINYnzv79drMU7F57d2EgMq3PEkoPIcTYKpD/CKYxU+bOzv6sulDOETjiMNg1RofkUmL+Y04h3W42wHkIP93SVDw3SCCWB6ZxFTE68lQ+83MqHM3VTfjP20/MhN2P+v9+quCXVf1tDr+VtDGgvVoKiwoGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758787224; c=relaxed/simple;
	bh=lEdXdsWft4AO75HCnvZQ8vPsorkolkiczbtHjFkHByE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mc6W8UnpG8aBLhcvUbCLtR9QrJN8ZnGcptBso9//NLJMKvHzSV6GpDuBcYtI0GXVCahE3LEkhCzD9xY5fKVbd+K9UfpgqPsJKM5vHdGB+c9mWHUNQYu9wi4bWj0kEORrce/aAsZzR2D5D1ASWDVmecTC74ND5tFGDACBqvFPE9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NnCXqymb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=FzxDSPy9KU4erZk9t1+i+HaA9soMowGoS/WKgL1AqXA=; t=1758787223; x=1759996823; 
	b=NnCXqymbqr2Ll1Subu1JwzatobeoVsoaQFZGR1eCCQUPFhFkFP2R7Bmb8Ofdz0ushxK5cDtSqHB
	2qw6iI0ZtHXb1KCFujbcPfzDDVAQN8cXVpzho4BWuoBA4ETmGNfAezNZ4D0tNPrXRHAl2fcubKH5z
	/rvlK66gN1blEU4a2GLndQhGf/4fuIE83ByTV4aZi+ZVb3/VtFexdVSPAYEoGmN2J84qR/zRF3NfM
	cZIJSh9we/Jda4FLi+cuM3utssPi1nUjiFMn506DjmhMOXzgA8VFyiXDUUiuSyJgEymjMk86Jnt9G
	DPM+d3Peq8DcG1GZSZcDPAaQTNMkBIrMuzdw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v1gti-0000000Anv0-1LoZ;
	Thu, 25 Sep 2025 10:00:14 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: stable@vger.kernel.org
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 6.16 1/2] wifi: iwlwifi: fix byte count table for old devices
Date: Thu, 25 Sep 2025 10:00:06 +0200
Message-ID: <20250925080010.9298-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

commit 586e3cb33ba6890054b95aa0ade0a165890efabd upstream.

For devices handled by iwldvm, bc_table_dword was never set, but I missed
that during the removal thereof. Change the logic to not treat the byte
count table as dwords for devices older than 9000 series to fix that.

Fixes: 6570ea227826 ("wifi: iwlwifi: remove bc_table_dword transport config")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250828095500.eccd7d3939f1.Ibaffa06d0b3aa5f35a9451d94af34de208b8a2bc@changeid
---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index eee55428749c..5ca9712dd7f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -2093,7 +2093,8 @@ static void iwl_txq_gen1_update_byte_cnt_tbl(struct iwl_trans *trans,
 		break;
 	}
 
-	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_9000 &&
+	    trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		len = DIV_ROUND_UP(len, 4);
 
 	if (WARN_ON(len > 0xFFF || write_ptr >= TFD_QUEUE_SIZE_MAX))
-- 
2.51.0


