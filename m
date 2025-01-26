Return-Path: <linux-wireless+bounces-17967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEC5A1CBF8
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 16:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08563A8D2A
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 15:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD6722B8B5;
	Sun, 26 Jan 2025 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUN+GMS0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AD41F5619;
	Sun, 26 Jan 2025 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903909; cv=none; b=C4JPbAnZEt86UyS/I6GvJjyYq/+9ohi62uDPJmVAOTde/8/OuKtp8l9SJEE+fJjZwfZcZr5i6PKrTA9RcAYT8tCmNcvugAhORbS3V19hvHs/BkR6+OH9Xc/88iwZWUAOUnVt0SCAEPw2nVleS6WLGsbrnMlnMYmXqsbiAcqdc04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903909; c=relaxed/simple;
	bh=rHa6Mj1eOZGznjcDsG5Hg7fGc0ElWRv/IgRiffMrrRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SIWq/NDFPkABqQg9zAQ3CjHjvWCINLwjBFYJ1VbAxpOe6OtY4AKuUTfG55ibXQO7PWTnHcJH3uTWykijHCbujJY9zWbV7iAQiki47+ItZs/JARTecyiW3ALg15cCcG+uXTFK0n+ug2wqQ7yII/V8b27w2AgwVNj0298cCZ54DRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUN+GMS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B011DC4CED3;
	Sun, 26 Jan 2025 15:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903908;
	bh=rHa6Mj1eOZGznjcDsG5Hg7fGc0ElWRv/IgRiffMrrRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rUN+GMS0CrDANVuH29Y+YrCdpOKRnD9dXTRg3vYBcuUxqdvSo9XWyQ3TWYFx9VO1Z
	 Co8FfKvEwubW8rZCdjCQztHslQpIt0m/TefHsrwNIHLCzAkHXQNcfqrx7t47rIkpLz
	 J9e+PhOv2niuQvE+mNsXLj0KasRYtRnuClHOYp8Zhz+EcJthfJerl6/4gpFRgOeW0l
	 sj14OmvpbntP5lJDM3UwaGzyVBMdyMLuFe01fC6ZldDx4pos4FNWBncOtV7zGsWj6g
	 d7577b+U+2Mg1JxlyWYrZeYyJo1zYwT4u0hJ8wF7GMS/GbdlTuzcNJjwGoIrBu/kYh
	 3rLf4QkkUObVA==
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
Subject: [PATCH AUTOSEL 5.10 03/12] wifi: brcmsmac: add gain range check to wlc_phy_iqcal_gainparams_nphy()
Date: Sun, 26 Jan 2025 10:04:51 -0500
Message-Id: <20250126150500.959521-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150500.959521-1-sashal@kernel.org>
References: <20250126150500.959521-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.233
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


