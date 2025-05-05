Return-Path: <linux-wireless+bounces-22578-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF7EAAAF2E
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2288C16B8AD
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731C83AF3F1;
	Mon,  5 May 2025 23:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxcQJDkB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553F7220F3E;
	Mon,  5 May 2025 23:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486282; cv=none; b=YTdfsHuDWGAW4qVOdUksSCSHzMuTaeKbeaUiD5juAXE6Lq1XT/CXkywVnxCLXZHv3TLB0SyBTP3bQZrKxx6rfJAu2E1PBDVpuJQAkk8BkXvXvJIFW6QkmVS1kRzNdvGNlH60WTWKTWBwHC5TUSEaRtBkAM/APun/XmXt/3E0iK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486282; c=relaxed/simple;
	bh=dUhZDr7JpjGKYrdAPTRe8rGmpcgXB1dXpGUNDT0HF8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JeMBgJwkiIe2hwIGuorVg6GgDkGAJRM0uvURG6bG6vkmx4jm34mzNEZjzh03W3f/TT96GVoDOa8oYz9r8dX2AGjGMlXKN0kxkMp+eef3cO8PDrVrqN0zHmzOlYGEzqYM05lmEhqPKHwFX5wGxGYnvzgp5DcqN+r2D8rFgwvUQ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxcQJDkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6C0C4CEEE;
	Mon,  5 May 2025 23:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486280;
	bh=dUhZDr7JpjGKYrdAPTRe8rGmpcgXB1dXpGUNDT0HF8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qxcQJDkBwOYGrOu4sM5RfV19UBA3nMwsj5t40S9zklEHKXSFUKVjB8LvJik+YAIYT
	 AlB5tK+D5VuYSiQ6YjMOlsFtEnyPb+opHlKW2N5mLVlFDbxlhH75HZBhmTiPqXEe14
	 nWiTkjDbLL8Ssc1FcHgPt/6P643o5gehYxPiYDDCElg9HXDAj7abjOr9n2YWyNgeqh
	 9vJFqogQthHPfVYoiPibqqYYFlWRR0ECNHddsBvi6ZLf+gAlQaorEiFuW4ArTwki27
	 dzmdH/WGM0OnP6FNsKJwfoF0ojTsvoDmB1iqlLZ3OyCg2DcwpIYhrmdTH5jo1e4i+t
	 rM44IihCZM4XQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 237/294] wifi: mac80211: don't unconditionally call drv_mgd_complete_tx()
Date: Mon,  5 May 2025 18:55:37 -0400
Message-Id: <20250505225634.2688578-237-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 42e2c84ed2484..37163d84104fa 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2959,7 +2959,8 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	if (tx)
 		ieee80211_flush_queues(local, sdata, false);
 
-	drv_mgd_complete_tx(sdata->local, sdata, &info);
+	if (tx || frame_buf)
+		drv_mgd_complete_tx(sdata->local, sdata, &info);
 
 	/* clear AP addr only after building the needed mgmt frames */
 	eth_zero_addr(sdata->deflink.u.mgd.bssid);
-- 
2.39.5


