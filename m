Return-Path: <linux-wireless+bounces-10127-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F7092B98E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 14:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68303B26949
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 12:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307DE158D85;
	Tue,  9 Jul 2024 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="yG3cCbWb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD08155A53
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528341; cv=none; b=mFJoKooRN2wpuwbzPxJ3zNFu5xkEAECQBalIlAllgY+i0HKlt3YYAzuJFmcGF7ivQ+pWw2013Fr2TcNIbcCfcUdoXhore1meYzVNof1Sb0FkxQP4FFjCphAmmzjbFOdlzTsLQAMb7M10Edt2QSNT2URzJCWlL46wXUt169QS3kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528341; c=relaxed/simple;
	bh=NFCm+l7YEekKEgodIFHc77aNWxAy0bSq8Z/awU1Gc74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sx0DrGcH8IVWbqlpTJtrtQLxlZzPmmVDrq2J4csD20OKIYjXBVxjsRtS6BlpKrrumLNVCMAg04Lurq5p3xGZNrTV8E9mqC70IexIKnssh3Dzv5DRMlCrm//plPIJTsNjjpIMayuiRn5FWrepOA5ApG46GartH1fPUJ1O6Kv2Oyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=yG3cCbWb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=28OXD9QYwrZeyu8e6UbPKU9nzoPuzeppOA4dJzG5nFo=; t=1720528338; x=1721737938; 
	b=yG3cCbWbRNMJX4TjQNLE/9hen+Tw+U23u3g1kUyCvY0AcCupvXvNq91f4HJtbeZF2LgstMcAft2
	mC0E7PRHZHCuOOdYHWSLkdgMYN87bdA5FZN97JIL+gckUmb0++gO211oZcRUMZTVeEPElbDmspGo8
	8FbgXM1v8SqJOa/5FEHhu56wHKg6HALyLt3cjyuA2lS27Hnamd9o9GyDUd3DhEPbNRRnJENiODuCT
	mI93okRlbpEOeuuQZmkONg4dSYFaknCm8z2/tglmthTIa5vR1w16dXRXamS1uk4a4Yv2f9e9pnx/c
	p3AaI2zTXER4t8OB1DyR1F0cytObE6WhOPbQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sRA0z-0000000E7r9-0Thy;
	Tue, 09 Jul 2024 14:32:13 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] wifi: iwlwifi: correctly reference TSO page information
Date: Tue,  9 Jul 2024 14:31:49 +0200
Message-ID: <20240709123149.1848315-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The code got copied from get_workaround_page, but here p->page is the
correct way to reference the page.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Fixes: adc902ceada2 ("wifi: iwlwifi: keep the TSO and workaround pages mapped")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202407062135.NNjnmMdR-lkp@intel.com/
---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 748772fa6b3e..22d482ae53d9 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1770,7 +1770,7 @@ static void *iwl_pcie_get_page_hdr(struct iwl_trans *trans,
 	 * (see also get_workaround_page() in tx-gen2.c)
 	 */
 	if (((unsigned long)p->pos & ~PAGE_MASK) + len < IWL_TSO_PAGE_DATA_SIZE) {
-		info = IWL_TSO_PAGE_INFO(page_address(ret));
+		info = IWL_TSO_PAGE_INFO(page_address(p->page));
 		goto out;
 	}
 
@@ -1783,7 +1783,7 @@ static void *iwl_pcie_get_page_hdr(struct iwl_trans *trans,
 		return NULL;
 	p->pos = page_address(p->page);
 
-	info = IWL_TSO_PAGE_INFO(page_address(ret));
+	info = IWL_TSO_PAGE_INFO(page_address(p->page));
 
 	/* set the chaining pointer to NULL */
 	info->next = NULL;
-- 
2.45.2


