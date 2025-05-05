Return-Path: <linux-wireless+bounces-22619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360ADAAB1D2
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 06:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ACAD1770E5
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 04:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31D441B770;
	Tue,  6 May 2025 00:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8FqtH4F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4D52D47A2;
	Mon,  5 May 2025 22:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485619; cv=none; b=cKoJ0oO4ZvMEoBGjcrzlwxn85/7BTLueRjWVgVKnGKP4tvC/drenQf3tFnd17EVV1GP/7tL/TYc0H/J7JQvcUqKUM692q6fL12PF7D0S+CahVIX6nCNeRpoXgGTBSGlB6zUZrwCUKM+gNezva3noEJw/QnX6DIiuApjZu4wXNtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485619; c=relaxed/simple;
	bh=ssn/ZHnwsREDe+ZIr3IpyRX2mXuA6gGJb1ktxetpc3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hrHSsYNCZp/raT2Qdr7SVek60BuLuq3xduV50efcjP5m/tFoCKBg+yg/F3scn4GYC1dMaYNcNQR+08kZhxRNvfcqm3KJPcUoMVXl3f/D29lG8IXY75ptaASAhtT+Q4nJm0zlzCyI68D326EGMVFUUlMN0G5XGP0A9W59nbRecrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8FqtH4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292D0C4CEEE;
	Mon,  5 May 2025 22:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485619;
	bh=ssn/ZHnwsREDe+ZIr3IpyRX2mXuA6gGJb1ktxetpc3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u8FqtH4FZirpnLEbfy3TK6ghz0gHuaZktTkoR9iXeDae5HaOBVkt2kiWsZhH9HR4I
	 yTy+tPoRcMifokMXy4sIxwrDyzQ4H6pZo3ENxmROGii27YtfjzYjPorjiVgmMnULJB
	 hbcbrjW9Tjx6c6hWnywharb9bUd7wjmrRsuxeSZFaA0I+JT8j3mxknCX8iJXwtYmNh
	 EyuRgSa6EDBPK4iC2rVZY150v7k2Zs7zqS6nrZ+T7kEiVpqv6PJHa+/gsN9RwTECM/
	 LCvs3iAe5jfhc1vKONOA180sX/zfFNE3R7Jt2v0vQL9gYocRr2CNK3D9RgnTvVxlEq
	 oBhaINNH94aVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 390/486] wifi: mac80211: don't unconditionally call drv_mgd_complete_tx()
Date: Mon,  5 May 2025 18:37:46 -0400
Message-Id: <20250505223922.2682012-390-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index f000026ab714a..ba0af3018cf58 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3589,7 +3589,8 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	if (tx)
 		ieee80211_flush_queues(local, sdata, false);
 
-	drv_mgd_complete_tx(sdata->local, sdata, &info);
+	if (tx || frame_buf)
+		drv_mgd_complete_tx(sdata->local, sdata, &info);
 
 	/* clear AP addr only after building the needed mgmt frames */
 	eth_zero_addr(sdata->deflink.u.mgd.bssid);
-- 
2.39.5


