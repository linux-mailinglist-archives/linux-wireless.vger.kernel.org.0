Return-Path: <linux-wireless+bounces-22524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F57AAA69A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7211675DE
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A9C2918CB;
	Mon,  5 May 2025 22:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCjkZ1Rg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FB029673A;
	Mon,  5 May 2025 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484498; cv=none; b=Xrfsnt2o+tDdJkcIbSxyFATvjSYK7af5ACb4Z51bE1aKQfmtfcQD1987ga3RZ/wgEB/yEwjVcvNERTVwtoLpz2cs8+SiJNWovkLDus88M/4+TyhSlV0sY7Th1LTUnQzdgolPMNmlMyItHy/hqa1klgjk3+V4m0osXWPiEdM3Dmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484498; c=relaxed/simple;
	bh=o77ZFxa3KyQnsL18gt07XHwplhuEsRJgWJ+YKf8k6Jw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JMd39FSGPMTrTKVtGDOROskmdvKX6yIObXMDRiJFoMhAJxdPvqmh7+NFMa8FiUiuFT3DfX3Xc/fFfFhacgbSYsZxRkRwqGxD59j5PZyp+Db9r2j6PayBoPX4oSLrM8f5+mY8FBd1ALkS/9H+SBwHtlIvtQMnD36acA5VEVuehes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCjkZ1Rg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9A9C4CEED;
	Mon,  5 May 2025 22:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484497;
	bh=o77ZFxa3KyQnsL18gt07XHwplhuEsRJgWJ+YKf8k6Jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QCjkZ1RgmK21dWYhj+by4em0YDhJ0KXXjyflfQ1VMltTE+XWX8OIsnle43tF/ZkCi
	 d4QzUKg37Gz/O1UpMFkCZ8HrbKPh9IpG1nB2g8Q9xjRLvoCfETkU7wiiVm+6fGljTc
	 5ko5Jd3vPVsPxEFW+8welMCSsTRKhWRdjHO/nY9mgUSt9u+ry850937zVG3v3TNnGR
	 sAEdJJKvy97oC70Llk9DudF5ZWVLxpeXnaein4XSA8A0Xsp/1pZgIhSmAz7Azrff6z
	 fUzpZS/c0yGtlCPSfbU4RxKlVQ+bWUnS8Q/fiUuu/HYav+RlVGap/sOI0obqIQwQ6M
	 85P3E1hnpgS5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 502/642] wifi: mac80211: don't unconditionally call drv_mgd_complete_tx()
Date: Mon,  5 May 2025 18:11:58 -0400
Message-Id: <20250505221419.2672473-502-sashal@kernel.org>
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
index b179aa7b6470b..d606b9dac145b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3832,7 +3832,8 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	if (tx)
 		ieee80211_flush_queues(local, sdata, false);
 
-	drv_mgd_complete_tx(sdata->local, sdata, &info);
+	if (tx || frame_buf)
+		drv_mgd_complete_tx(sdata->local, sdata, &info);
 
 	/* clear AP addr only after building the needed mgmt frames */
 	eth_zero_addr(sdata->deflink.u.mgd.bssid);
-- 
2.39.5


