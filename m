Return-Path: <linux-wireless+bounces-17959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F8EA1CB4A
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 16:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D88373A97E4
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 15:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6BE21884A;
	Sun, 26 Jan 2025 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXUs/wZd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC73621883D;
	Sun, 26 Jan 2025 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903805; cv=none; b=u3JHOp8ZFq7UrXeqFjyFWS8Dj00FDYRxYpVUawf+KWgsvYF4AYzlTEK6b0xcilPduqr6t9ANNsGKLUWeFmkWR7NxZDhlDlN6q/bK24EBJzMrjng3hllWsbfpTK5MtcTg2AR0zIv+RR1ViTGunWC+VJtV48Z7tqH7zCnwkf7YpoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903805; c=relaxed/simple;
	bh=rHa6Mj1eOZGznjcDsG5Hg7fGc0ElWRv/IgRiffMrrRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uJE0Y8rfKuUlDfN7GrpJFarP8DKjCs9Egvvy6bdx7CDAGw5l33y13iWVCUmSdjgvKQ4FWr8pR0VRm6OOUrloZ9tUb4AiH0eEYlPB4PzHTZBfQ+cS6EsCjv7PsmwHJxMXrYFRoW+zCTKMOpPxsNLz+ew7UgF81oy5YIcnXCpM4Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXUs/wZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F89AC4CEE9;
	Sun, 26 Jan 2025 15:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903805;
	bh=rHa6Mj1eOZGznjcDsG5Hg7fGc0ElWRv/IgRiffMrrRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UXUs/wZdyh+ER1kgvWl0MwT1ENQXaBr8lU65+0KqHyI+HSy/te1dxrxn13Kt/aukt
	 SuOPg7Gxbhwj5NnftZooU6yovSqKHh4QO0s28jvqk1Euq39isrPwz5Nr5zLAwqjON9
	 1OzS0fk4fPcxG4XEbe70SIr0H5eyMj2CWpfxMomjSeW0r/SoFClCeDlPp6OoEwgSwg
	 XGr94uIFrBwT7VXLd5YzFVQgInxoJp3fZQtPyBgbBne2rxfXuYyYZr+3p1YwPt9vW4
	 lUANP3QKU23ktFWx50vN0HeNtAZ/IGN0r5HrLtYEHvtKNL1WlM49N6B19PXG8ycxzn
	 9wixbjacxxryA==
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
Subject: [PATCH AUTOSEL 6.6 05/19] wifi: brcmsmac: add gain range check to wlc_phy_iqcal_gainparams_nphy()
Date: Sun, 26 Jan 2025 10:03:00 -0500
Message-Id: <20250126150315.956795-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150315.956795-1-sashal@kernel.org>
References: <20250126150315.956795-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
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
index 8580a27547891..42e7bc67e9143 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
@@ -23427,6 +23427,9 @@ wlc_phy_iqcal_gainparams_nphy(struct brcms_phy *pi, u16 core_no,
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


