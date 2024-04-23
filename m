Return-Path: <linux-wireless+bounces-6739-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E18B38AF7B5
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 22:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED8FB233C4
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 20:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83671422DF;
	Tue, 23 Apr 2024 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qn1imbgu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C161422A3
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902428; cv=none; b=Fvf4LL78nULa3Q/b17Z47uhIK5gOMjjwJ0QNehjkoZF98IqSF3PnP8VFEm6hogH3FeA3jgJz34CVU8mjPqAdJKLQvpv7bxp6km6xq2qDLD+8HyaeU4jqH/G/Cct96XV6wIUP0t6tyZjw5LC3ojDNlUb3Lz8B2eSBZwOj2XxXAWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902428; c=relaxed/simple;
	bh=adtgfr+fqVLRH/huwT/2UyvFhowbmpzAnpYwpbcL3Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/sexsM9R5JtCIfZLIV41V2Fjfou74GkaimQ/t7sALm4AiYJa7y29OK3XoQJNoT4gPIqfeTgRmob5LMWMNcZK8ckWCTCW3ywFNbnmWbkFVrkfDkcT6CoMB2OVEO9UERLHRyvbJgyUWe6nWq4KZS5gPDAJj9rxx4QljaeYHOSZu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qn1imbgu; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0a+zQWlSfs8UrEOhOd3X8gQDvjO8x7SQjUFUQtUwYug=;
	t=1713902427; x=1715112027; b=qn1imbguaZmOEyjquDCgzfJhkUS4TibvxVL+0lyqTRewiUN
	qDuatIt7fYlGdI+ut9k5oIRSdGaNFAmI1l5x0XI7+FrVdcRxez2Hk/Bw2u/tSnw2lOEwWqQEUpL/G
	GR62STLMVf4J2xaRg7CpRVX4/Ao/pFu2xZolGZM+HVgP9CDRJXx6WIn01+atIYfoCWtmHrrLiuzeH
	WkRgMGh8aJMhHkPzpvkHdYTmRMFFwXNW8e/8GpQi1KthPtAD/h1tll0ofIQRGm+zJgHg89ELnFVNz
	IIvnm9kbtxTqviSXJKtoRf84iw4ndcgVFrYBirwKFeD+8Fr6qHt1dDSVEAS4stBw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rzMJU-00000002OTL-0gOH;
	Tue, 23 Apr 2024 22:00:24 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 2/4] wifi: ath11k: fix TPE power levels
Date: Tue, 23 Apr 2024 21:56:13 +0200
Message-ID: <20240423220019.891a5ad582bb.I359bb401ea74bf82dc981a86a7ca3fa44d169d2e@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423200019.192941-6-johannes@sipsolutions.net>
References: <20240423200019.192941-6-johannes@sipsolutions.net>
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
index 03b0a6ac6d6a..1a3ea072eec3 100644
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


