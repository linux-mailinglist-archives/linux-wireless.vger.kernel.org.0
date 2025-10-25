Return-Path: <linux-wireless+bounces-28249-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF57EC09608
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 18:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FDDD4EFA51
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 16:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282B9304BAB;
	Sat, 25 Oct 2025 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIv+Hdfv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F136F303A19;
	Sat, 25 Oct 2025 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761408861; cv=none; b=fXRi1ARGAUCCTsvXb6OVnjbR5ZW1kVJYBN9/q7tSeIV7/YNm/pXcSyq4EpzOfe0BYAdQ4WW4KZ4Q7HEG466c9fl1zrZ62pH1Wl1u1g+gTpKIdCvMPlMyrGwSsSNtDncRyl/7MmLeYttlqTx2RQfX2CcI9GTbiLQlnOG2uMbVAzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761408861; c=relaxed/simple;
	bh=dNRqzk6PR52romSKaeV8CFRlktah5VCw/ExB0EH7O1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thBEowOcVsntdkQwcusJ7gaZ3sB3SiRIANTVy0qfK1nio9eN0kidsnIA2L0HoHS94m+HZX/7Eq/ndfGK9nH6GU6N8rWlUiJjSB/tRYD/u/PKBUbzFwxTKUBXJ1hM+C6gUI6rU6goHYYnOWo2kC6BhFAWsZJtok+Hj2I/pOnZjkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIv+Hdfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2333CC4CEFF;
	Sat, 25 Oct 2025 16:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761408860;
	bh=dNRqzk6PR52romSKaeV8CFRlktah5VCw/ExB0EH7O1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kIv+Hdfvy6G49N5G8eIgu2lxDTO3ix+Kt+Z8Y3GwpDJBNngxwX6hfaRSpmetd4ANI
	 yg6pA8HsPH1n4xV0tAr+SIXNKTVCcaAcK4FHHhwHG/dVE/u6ogZm4Y5j2awDJJz7yY
	 MFUB/hTuFV91x0P8w3V5HAL2TPzhgO49wC+0C2k5W9W/aCscTqjp/GGfa8KgRrwGsQ
	 ikagpCAhLlU7diKh5t9qGu2RlkKax6AVUSh90E3xNZWxSpze2a5aoTj2BNh8vXDWAi
	 bYw52KHXURIFrVOc2PyCe4l9V2/dIuvfIPyg0nP45+VnCCDpJVex5i3kFN2DPsnWJj
	 kF27QakBIf/9A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Chih-Kang Chang <gary.chang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] wifi: rtw89: disable RTW89_PHYSTS_IE09_FTR_0 for ppdu status
Date: Sat, 25 Oct 2025 11:55:36 -0400
Message-ID: <20251025160905.3857885-105-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chih-Kang Chang <gary.chang@realtek.com>

[ Upstream commit 4e79a5cc01c5e1f1ba393ed3b44b0c3611eaadf1 ]

The IE length of RTW89_PHYSTS_IE09_FTR_0 is dynamic, need to calculate
more to get it. This IE is not necessary now, disable it to avoid get
wrong IE length to let the parse function check failed.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250915065213.38659-4-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES – Removing the request for the optional FTR_0 PHY-status IE keeps
PPDU parsing from failing when the hardware emits that variable-length
block.

- **Bug impact**: Before this change, `__rtw89_physts_parsing_init()`
  set `RTW89_PHYSTS_IE09_FTR_0` for every PPDU page
  (`drivers/net/wireless/realtek/rtw89/phy.c:6290`). The parser still
  assumes IE09 has a fixed 8‑byte length via
  `rtw89_core_get_phy_status_ie_len()`
  (`drivers/net/wireless/realtek/rtw89/core.c:1816`), so when the
  hardware sends a longer instance the loop in
  `rtw89_core_rx_parse_phy_sts()` overruns and returns `-EINVAL`
  (`drivers/net/wireless/realtek/rtw89/core.c:1959`), leaving
  `phy_ppdu->valid` false and blocking follow-up processing such as per-
  chain RSSI conversion and antenna-diversity updates.

- **Fix rationale**: The patch stops setting
  `BIT(RTW89_PHYSTS_IE09_FTR_0)` in that PPDU initialization block
  (`drivers/net/wireless/realtek/rtw89/phy.c:6290`), so the firmware no
  longer emits the problematic IE. Because no driver code consumes IE09
  today, nothing functional is lost while the parser again succeeds and
  the PHY statistics remain usable.

- **Risk assessment**: Change is tiny, localized to bitmap setup, and
  merely disables an unused, optional report. No API changes, no new
  dependencies. It only matters on kernels that already picked up commit
  28bb3d842e8f1e (“add EHT physts…”), which introduced the IE09
  enablement; older stable trees without that commit aren’t affected.

Given it fixes real PPDU-status breakage with minimal regression risk,
it’s a good stable backport candidate.

 drivers/net/wireless/realtek/rtw89/phy.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 01a03d2de3ffb..59cb32720fb7b 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -5929,8 +5929,6 @@ static void __rtw89_physts_parsing_init(struct rtw89_dev *rtwdev,
 			val |= BIT(RTW89_PHYSTS_IE13_DL_MU_DEF) |
 			       BIT(RTW89_PHYSTS_IE01_CMN_OFDM);
 		} else if (i >= RTW89_CCK_PKT) {
-			val |= BIT(RTW89_PHYSTS_IE09_FTR_0);
-
 			val &= ~(GENMASK(RTW89_PHYSTS_IE07_CMN_EXT_PATH_D,
 					 RTW89_PHYSTS_IE04_CMN_EXT_PATH_A));
 
-- 
2.51.0


