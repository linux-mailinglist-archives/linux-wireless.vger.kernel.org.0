Return-Path: <linux-wireless+bounces-22586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BE6AAAC4A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 04:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0D21892321
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0C33C2E3E;
	Mon,  5 May 2025 23:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vy2TsrIf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F307E3881AD;
	Mon,  5 May 2025 23:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486738; cv=none; b=f/s8jKlIpjL3o9i+L+h648q8n8dJZcUYg40gNSZXAT/YeCikor/l/e2N/BIAMMYYCHN8x+OM6jvSAg/F5B2TMD30oYXLKugF6IYMS6IVApxYbNdq5pmewqDoIB/4KriR1jRhrUgXOwQGxSFTXp4hL4slATZpHsJcyzAwzYSJFaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486738; c=relaxed/simple;
	bh=+sIC0S0TGn20DvW27cgTI3wRhI3QCwXWL6zBz16zPrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WgWdz0zlSPfZQl/igvAVOsksJTB9AVpxx9PoMuAzH4LLmwgRfkYBlwTECTFLYq6EyED1vdmV8k+1BZPBIiuFjUFpHRlOp+m9r5k1Zr/Wt31B8Pi12FPQH6Wi1qiWhP+Scjl8QfgcUavNGxlArh6H+0zDCiHfPZQmH2wYAkAtuHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vy2TsrIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26C0C4CEE4;
	Mon,  5 May 2025 23:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486737;
	bh=+sIC0S0TGn20DvW27cgTI3wRhI3QCwXWL6zBz16zPrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vy2TsrIfoeo2C8iz2NMBUuzRWHgPAP2zDtv7nKCgTOtyiQoe1q8m1ivOffnFaHKWT
	 8ERtcfDtnaqlqJJ2OefzDMzohRnnEAyUXVXJYuaYcdaoyiYJtys6+e2LeDY1o7dwiI
	 XNoUIr2ZqecrY0fZI3lR0cP4al+ndKoGRNDQhE9U8yqkKbjoEZpWZ4pulKrI1J+1Sz
	 AyZA9/CI+vqqeeazF0Cek9WvCDoNXmOW4sjPdB3V+6FKEkLcRY2tuPaUgeXpeY/dD9
	 hBCKeAf7q78doxDYJvrET0CVo5gARcGqsKpi5oN/365xFzndU8THztfSf2HDRV8r6N
	 3aJMqABiw5PEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 177/212] wifi: mac80211: don't unconditionally call drv_mgd_complete_tx()
Date: Mon,  5 May 2025 19:05:49 -0400
Message-Id: <20250505230624.2692522-177-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 1798271b3604b902d45033ec569f2bf77e94ecc2 ]

We might not have called drv_mgd_prepare_tx(), so only call
drv_mgd_complete_tx() under the same conditions.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250205110958.e091fc39a351.Ie6a3cdca070612a0aa4b3c6914ab9ed602d1f456@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 9a5530ca2f6b2..8f0e6d7fe7167 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2896,7 +2896,8 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	if (tx)
 		ieee80211_flush_queues(local, sdata, false);
 
-	drv_mgd_complete_tx(sdata->local, sdata, &info);
+	if (tx || frame_buf)
+		drv_mgd_complete_tx(sdata->local, sdata, &info);
 
 	/* clear AP addr only after building the needed mgmt frames */
 	eth_zero_addr(sdata->deflink.u.mgd.bssid);
-- 
2.39.5


