Return-Path: <linux-wireless+bounces-7247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6998BD5CF
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86CD01F21ECA
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3025C15B992;
	Mon,  6 May 2024 19:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="C7u9GWr3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BFB15ADBE
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 19:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024746; cv=none; b=QsvcKV1LBs+2oN9W4P/Cy0VXpD4+T3EYnCatoEjwXqocbc0Sx9itp7QQA+qCRUTbZZ8//T/Efr2Je5u4AYlaHfRzDEu9OKS2o7U9iaQrSMchOhSMVewvRNNQHBMYvw+5jkWX6bvJST/T1p3M7p4w/U0oJ380uiEKlXWOUsgg7FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024746; c=relaxed/simple;
	bh=i3VeNL/NcK5U+0aBg6ykZUo+wo/pCB9POLAoe9SwNiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OsoMr0qPg5ceGX29SaaX0Pw4YI5HRRLHVOuAM1X+yfrb+E/A6xtrzEeSaSZ170zKiv53ZF6K4K/jaS6ZHXelzBJ8JtuyEJDcBnC0fybWY4vwgIfKu/UCZN7iDGtlyqT445+qUbwEojHzS0lQ8FiE1gPKtil3mJpUStTxjI3QUqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=C7u9GWr3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=br1xmNroZrrclCjektPdnkXQxj7Hs9pHrphCeRPFlxY=;
	t=1715024744; x=1716234344; b=C7u9GWr3oaPA8TBHZ4fwcyR9iL5WYud647Dwg7y65juHimO
	mGMm9wamIehpOxucf1SfbCfCLV8dkHvz3fQuLHZzv1Ge57okFfxjPxQ4C2hJtjuILwoCxGnrl3aJD
	vKOOYO5YWbsz6AT7qj1XLa2y/fxutN5A/6Y3fYzxCWQZESXIcxgts14hZPMcGdsdnNYviOeoI6OaW
	H4Ns20aOvQRrsJTh13k1sR/rod8h5pudJ2vS7PjFb7wiBeDXphLa6zvmFIgLMTTNbGl880hMA5sQ/
	fO85JZFdhuV+mbGZH2Vb/as3aoUWj8O81srU0N1MxbUaFjteDUaQLlTTuT7rd98Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s44HN-00000008C27-3aQz;
	Mon, 06 May 2024 21:45:42 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/5] wifi: ath11k: fix TPE power levels
Date: Mon,  6 May 2024 21:37:55 +0200
Message-ID: <20240506214536.d99fcf5856b9.I359bb401ea74bf82dc981a86a7ca3fa44d169d2e@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506194536.102148-7-johannes@sipsolutions.net>
References: <20240506194536.102148-7-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The chanctx can be shared, but it seems like the TPE values for
this vif should only reflect the channel that the vif uses, which
is captured in bss_conf->chanreq.oper rather than the chanctx.
Use that when calculating defaults, a similar issue is where the
data from the AP is processed, but I'm moving that to mac80211.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 59e5e8085742..73876760afe9 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7701,7 +7701,8 @@ void ath11k_mac_fill_reg_tpc_info(struct ath11k *ar,
 		is_tpe_present = true;
 		num_pwr_levels = arvif->reg_tpc_info.num_pwr_levels;
 	} else {
-		num_pwr_levels = ath11k_mac_get_num_pwr_levels(&ctx->def);
+		num_pwr_levels =
+			ath11k_mac_get_num_pwr_levels(&bss_conf->chanreq.oper);
 	}
 
 	for (pwr_lvl_idx = 0; pwr_lvl_idx < num_pwr_levels; pwr_lvl_idx++) {
-- 
2.44.0


