Return-Path: <linux-wireless+bounces-22522-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4B4AAA6C1
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D59A98650A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB38B296700;
	Mon,  5 May 2025 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtTHbneS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5532918CC;
	Mon,  5 May 2025 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484496; cv=none; b=QyBlEq8B5dt8vsdJMqL1J8ZGc5yi2PcNVYFBGdjl5JP4lDkmgyUrL01XbXJjmUfX50CeUcfDbmf2Kqw4PRuh1UZzVYjdX4frmFQ3+Xc8gZilBG9LWg94HOQLPDMH1v5AvbobCGmBIMDtaDRDuqg0GdIqlNB2NKiIUDGZFAzvl+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484496; c=relaxed/simple;
	bh=i9Hdyi5yqv9Sgn7L+e2OGD9/FzgPxYc++2fAHHc6HqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sbq0dOs3YNeCRCXwBRhK9SVnDgRP58S4gWSaED9nfqhIi5owco4MdCWckVPiPiBwry2F9PPt1fS5pW8vjqCP3UIw6G4EprXyr1cao1Z2iEtT0FDAz2m6r6UamSNeH+FqGqAqwup6E9MQWIHPgdIq0P+jBhmKgy3le/f9OcJz61E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtTHbneS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F28BC4CEE4;
	Mon,  5 May 2025 22:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484496;
	bh=i9Hdyi5yqv9Sgn7L+e2OGD9/FzgPxYc++2fAHHc6HqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AtTHbneSlfzh1Q5OsDG3rkqdWH3cJsLvXytlvKfRawGIdWniLMgZXmw/NC/9HtAhX
	 AdSnUhfaxDY8KyRo+OGk7YuzLMKMaMaMYOjPpubVJmh5yu1XdwHm+Nvh2QkkveOG4X
	 HQFCuuS1RXKEkmedBU1wKOLPKKqHU6OzfZBexG4wdnvj2GUN8hp3wQtFwa4+chaH8O
	 VZOPSOup8pX0LEc7NLKUvu0o7aubc/CeicYE0KXJOpF0lkDv3Od+T4c1cCBm2xjIoM
	 Y/dtxpDqHQoZ5wcpikrCGowtdn6zw9u2A37lvkS9e0gCr17n8pOgfXpVgUIix4vup5
	 Z84k9GVYihDFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 501/642] wifi: mac80211: always send max agg subframe num in strict mode
Date: Mon,  5 May 2025 18:11:57 -0400
Message-Id: <20250505221419.2672473-501-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 3fca951123b68df8d1b47bbf90409f8a3671362b ]

Instead of only sending the correct number for EHT and up,
always send the correct number as it should be in strict
mode.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250205110958.5910263db6da.Icd1f93fabc9705e4e760d834095c29b60b934d9e@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/agg-tx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 61f2cac37728c..92120f9051499 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2023 Intel Corporation
+ * Copyright (C) 2018 - 2024 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -464,7 +464,8 @@ static void ieee80211_send_addba_with_timeout(struct sta_info *sta,
 	sta->ampdu_mlme.addba_req_num[tid]++;
 	spin_unlock_bh(&sta->lock);
 
-	if (sta->sta.deflink.eht_cap.has_eht) {
+	if (sta->sta.deflink.eht_cap.has_eht ||
+	    ieee80211_hw_check(&local->hw, STRICT)) {
 		buf_size = local->hw.max_tx_aggregation_subframes;
 	} else if (sta->sta.deflink.he_cap.has_he) {
 		buf_size = min_t(u16, local->hw.max_tx_aggregation_subframes,
-- 
2.39.5


