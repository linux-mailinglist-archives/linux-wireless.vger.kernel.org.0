Return-Path: <linux-wireless+bounces-2900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F44A84494D
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 22:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31019B2120B
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 21:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226A4381D5;
	Wed, 31 Jan 2024 21:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gClUy83S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C243F374F1
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 21:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706734848; cv=none; b=NnA7xtWc33o0J9hkLn80PICShJWEF7AYtoUt7cYNENtdp6lhcFkSV49igDmUhXnsm1YXgfQz0xNa81vWFLVrEaAD3dVZdZFtKVEyPoSz8cJgAo/rVdm+2UHrULdow008mGncF2LbTfxrOCpCS027ID2x+H1lq5jke/2GHfB3UDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706734848; c=relaxed/simple;
	bh=Cpv8sRaJmsiIJkLz/JI/pL+vbSauHKORd1Ke41FP6mY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f2aw6Oc/J54+YEUZSTUKtvrYuwMmTh2AnzDwNf60UCjryRgNT6fG4CpG/+XhOy8sJ/hV0JsFU5zO7H8bCTggkpxqqO7ZjXGhQezOs00/GP7Ahhwi48JO86cXf9DUsSsovY3gr/iX+QfA4K7BGF4P/yFm+H+xyOEJEobipNd6Zmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gClUy83S; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=XXDyIQFX79ZeY9eUHNplq/o2yZ0TX2ARXAeRRiR/ugE=; t=1706734844; x=1707944444; 
	b=gClUy83SsQnttY6PC3a64qXn/pYfY1rfaAO4sCz1Q8RenyfDRWmcOeCdqwIrzVdumIqUchOCISp
	G4v+DSANnyuQ7AxNSojOrAxzp842mSnho5GUq1AXSRc0GWAhtOPfeADtKdx0agnP7PEDvrNY/PmI7
	GBEVTLm3lBJsnRNqHixw7QF96FsYiGc5M5rca8j3uc8y6f7sCeNV3mFAdYQ130y0WsOEkQFHcjwMc
	3vF06Ak3IUwAzW7UZVeXCb3MUW4G52f/5pcxKkY2GfKkQrpQrj0Td8M1vQUvvI4ePjhVda9QcBLlm
	53Okf0KdPtlz0Yfm6HWAI1qWKpoq4ScxTehw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rVHhJ-00000007QhR-1XeO;
	Wed, 31 Jan 2024 22:00:41 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: miriam.rachel.korenblit@intel.com,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: iwlwifi: remove unused function prototype
Date: Wed, 31 Jan 2024 22:00:39 +0100
Message-ID: <20240131220039.6fdb8cbf4814.I6c46065b836cafd93df676dd88c99a626a25bf46@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Saw this while going through the code, this function
hasn't existed for a while now; remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index eb38c686b5cb..98d56e778d99 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -306,8 +306,6 @@ static inline void iwl_fw_error_collect(struct iwl_fw_runtime *fwrt, bool sync)
 	_iwl_dbg_tlv_time_point(fwrt, tp_id, NULL, sync);
 }
 
-void iwl_fw_error_print_fseq_regs(struct iwl_fw_runtime *fwrt);
-
 static inline void iwl_fwrt_update_fw_versions(struct iwl_fw_runtime *fwrt,
 					       struct iwl_lmac_alive *lmac,
 					       struct iwl_umac_alive *umac)
-- 
2.43.0


