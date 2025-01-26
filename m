Return-Path: <linux-wireless+bounces-17968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C5FA1CC33
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 17:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D503A8FBC
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 15:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D901722F3A1;
	Sun, 26 Jan 2025 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmQSnsNp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68221A9B48;
	Sun, 26 Jan 2025 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903935; cv=none; b=rK3uEQDa59Tco275zhYs+LrJZgpjL/rEPgdF7mxCSFmzaKGYuSfkyH/jb0Rbi4P7QYtCKJl86YNLlIblRE5bZuJYvij4SmYYx42kddfrN6kpoqfGuCrAlzkgj34rOzdEoDcWTk0Yn9O+I4GCDIoKaZbTxeOnCr6eKZPenQHWcBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903935; c=relaxed/simple;
	bh=VNMC92ERXGgXHptbGRo48slbMZlq6EDbppqGFCn7la8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jaMOGr2ot2UEmovg6KaiLjYThh8+LNHxLewxoT9F9z76vP8VznEDElRtqMqxMP4JDVRfEMVKW9XWZbMALwUx1rXee1E+Fiyckniy5zNndxMtZsMxLi4pqcMRPmcj4+HOTZvbLGe3xx/8ucgPZShOQqii58flONFBnCdiSfx9RaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmQSnsNp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C598C4CED3;
	Sun, 26 Jan 2025 15:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903935;
	bh=VNMC92ERXGgXHptbGRo48slbMZlq6EDbppqGFCn7la8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WmQSnsNpFgQ42GDfztE18kExKmolKOjvLapFwgpLOtqya+IeniJr7sLpHB4odFSzr
	 B+Y/8qHQfLONLiePqapDKxJtte8AjJrFp6t9yoS3OcWk6ysZ47jvvde3a0NRY8TgXz
	 Bt+j+x79wi/nrCjNO7UQX8tB2tTVwuCuWwtsFWDh1AsbA2RIVmruua5U7huJttSaJg
	 M/VKDl08+l29EH9rPJTmVMNPVmdzL1mPjI7Bqpt/Wj0YnEnQ2s2iaKa4x8tIgpvGjv
	 WFRtRmQjkt+g3ZiPC2Lu8B+l2eMTHeYu/e17dUBH6K+jii1s0eykzwIvvOzQ3GFbtk
	 Avm5W8A+z+low==
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
Subject: [PATCH AUTOSEL 5.4 3/7] wifi: brcmsmac: add gain range check to wlc_phy_iqcal_gainparams_nphy()
Date: Sun, 26 Jan 2025 10:05:23 -0500
Message-Id: <20250126150527.960265-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150527.960265-1-sashal@kernel.org>
References: <20250126150527.960265-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.289
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
index a3f094568cfb2..90ae800cbccd0 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
@@ -23445,6 +23445,9 @@ wlc_phy_iqcal_gainparams_nphy(struct brcms_phy *pi, u16 core_no,
 			}
 		}
 
+		if (WARN_ON(k == NPHY_IQCAL_NUMGAINS))
+			return;
+
 		params->txgm = tbl_iqcal_gainparams_nphy[band_idx][k][1];
 		params->pga = tbl_iqcal_gainparams_nphy[band_idx][k][2];
 		params->pad = tbl_iqcal_gainparams_nphy[band_idx][k][3];
-- 
2.39.5


