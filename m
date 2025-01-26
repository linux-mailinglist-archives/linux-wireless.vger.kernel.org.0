Return-Path: <linux-wireless+bounces-17962-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0F7A1CB68
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 16:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA3437A0429
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 15:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCFD223709;
	Sun, 26 Jan 2025 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXagWR9J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAC2223700;
	Sun, 26 Jan 2025 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903843; cv=none; b=e0R1gZ+akDMRaKmwbxAzU+SViU4pSbj0y7cyTG2FHoOMDxUoHPB9Rs6oM5GyM5iyhyyClGvUIHhkdvLfUc9nIuQnfo91KjZRb7iSdOXynjOsYj9ok8CShvR8UvN2VUtHib73u3BoNUHoLNhh/pzMyhLwBZErKbMugu6g+8k/j5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903843; c=relaxed/simple;
	bh=rHa6Mj1eOZGznjcDsG5Hg7fGc0ElWRv/IgRiffMrrRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qzfw6XZbAZXf68N6B8Z7dluOwnhiNid4iFgOkEa3I2LEVnNlFZsbz9bcg1Be7oMbudcIztRnTEjzh15BRSc3+aot1NFG0NVZH2BCTtHZmQmxwvQ7wIqj6gt8bjC/k6NQYx3nWl2Lswfz0HRPtpGb8aZijn06oStTSHiE9G/3hV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXagWR9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D612FC4CEE2;
	Sun, 26 Jan 2025 15:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903843;
	bh=rHa6Mj1eOZGznjcDsG5Hg7fGc0ElWRv/IgRiffMrrRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MXagWR9J6YvQ6V/2ZzAulPaO4fQrofj9MHHMfj2lsd6K4JiypqyPw1oaiXBgGvNae
	 yWG4U91UvKKHVBBeLa3BhbVSgXd+0UVPCWhnQEp/lo5TXu/SfcHG7gPsqrBxyunRUb
	 7jZFDHYecOf0ggo9UCBxqwKW2G09mXwnl8yuqkFw/+/68z/UsN1QQtVJIwDu8AXFjZ
	 mNNkfo5Ju2BAdMdWzI5r2ywT1QeZuOl7g2gY6+7be4RYyPKkBHfxIno5PxOEM+tPLX
	 AqwbbliAjsGBPpPRta9p7bPMLIvx2/ikJPcMMx5oKgaDAqonevrtvkoxtrgVXW9fBN
	 Bf1rBegp8ZfSQ==
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
Subject: [PATCH AUTOSEL 6.1 04/17] wifi: brcmsmac: add gain range check to wlc_phy_iqcal_gainparams_nphy()
Date: Sun, 26 Jan 2025 10:03:40 -0500
Message-Id: <20250126150353.957794-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150353.957794-1-sashal@kernel.org>
References: <20250126150353.957794-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.127
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


