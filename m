Return-Path: <linux-wireless+bounces-17953-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 581E4A1CACA
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 16:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD6F1885159
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 15:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02EA20A5CA;
	Sun, 26 Jan 2025 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ul8rTD3H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8935020ADD5;
	Sun, 26 Jan 2025 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903743; cv=none; b=EikytTtsmYhuBsWd8QI92Z0qe9fwAx8tVIl80JEquV3YcaSFswbuUsIghTDSYGmyT1khJTvcV3+ymURN3TOd06aOYlus9aQ6X3ggubG4NyB6y+7n+FQKYOz69r3tV8kncLfQPFVhW6tS6zlrPS0fe7tncbLgixixtIQlXj2+cFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903743; c=relaxed/simple;
	bh=CGiuOyRCSz8cyy9BQptoIIFiYUhJkgbuW56cfCSSqqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oh6SbcS/DOfiebXhDaTRVz5/dvXoPJnxm7L7e5TveSjVvvMlKZvmZ6iJOp8hn280fMZ5hVdZBpb18bHExGCJBWMPLw6EKIO2zq9KYTI+Q0fFTcGVESxHoEmnAzJcKRvB9XpvbfhkWIRnvcjJy2UfBgj61EDfEv82ScwbD74MDco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ul8rTD3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386FDC4CEE2;
	Sun, 26 Jan 2025 15:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903743;
	bh=CGiuOyRCSz8cyy9BQptoIIFiYUhJkgbuW56cfCSSqqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ul8rTD3Hf6kpQNSv+pKvJ+JJoi8XI/DLv/5tpkXGcuh/CODYtVuCviRKNx6q99GsU
	 bnP1s2WRtbAeC+zLWrwhe8Sznr2LKsfbbYC8WOpUKugsZ66+ile9nOsuQNSmNr1SBQ
	 +D0gpwl9zC9btOPKUX0PHQGwmswCCyYej7BilSLQP4s7TQN+rMn4TelxJ9/a63fy/H
	 x9KXzoCGqgn0KzJbFf/usuDUjeD8IulVM5o0vnDKy8na5LoyEvvojlicolCthfD51o
	 HngTTqp85QZ7XEkrPICeAYraBTzf/pLAh7Y7jluSnWl4D7y5dyd9ohYOV+Kyx7+fue
	 hUEQnCfGVIG+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	johannes.berg@intel.com,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH AUTOSEL 6.12 06/29] wifi: brcmsmac: add gain range check to wlc_phy_iqcal_gainparams_nphy()
Date: Sun, 26 Jan 2025 10:01:47 -0500
Message-Id: <20250126150210.955385-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150210.955385-1-sashal@kernel.org>
References: <20250126150210.955385-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 3f4a0948c3524ae50f166dbc6572a3296b014e62 ]

In 'wlc_phy_iqcal_gainparams_nphy()', add gain range check to WARN()
instead of possible out-of-bounds 'tbl_iqcal_gainparams_nphy' access.
Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://patch.msgid.link/20241210070441.836362-1-dmantipov@yandex.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
index d69879e1bd870..d362c4337616b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
@@ -23423,6 +23423,9 @@ wlc_phy_iqcal_gainparams_nphy(struct brcms_phy *pi, u16 core_no,
 				break;
 		}
 
+		if (WARN_ON(k == NPHY_IQCAL_NUMGAINS))
+			return;
+
 		params->txgm = tbl_iqcal_gainparams_nphy[band_idx][k][1];
 		params->pga = tbl_iqcal_gainparams_nphy[band_idx][k][2];
 		params->pad = tbl_iqcal_gainparams_nphy[band_idx][k][3];
-- 
2.39.5


