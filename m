Return-Path: <linux-wireless+bounces-28265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2381DC09A6D
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 18:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A90C1C81836
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 16:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB56330B528;
	Sat, 25 Oct 2025 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUjHE4jq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93825308F38;
	Sat, 25 Oct 2025 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409649; cv=none; b=sDI3Bfmat7QOVYO5otImtCIeneCsDEUoF9nBAEwxvnr8iSdmu8is8K9Q2ee6lA9gJDHHG0yx5A61qpD51B9gNG7Ifg2c945f/LQZLJnGPI4rK/zBPQVRiVT9R/XxeT59+gWc48/xE5nPbEXB5Z2sUJt1/beiPkEE9fdOd0HqUQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409649; c=relaxed/simple;
	bh=0QGjg9w5MovQQlzMubdpJglJ7KwASaDwFuoBcn5SVW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1C8MaZOP/rolYPl1AGbI04jISIQq9El7Go9NVwCWMMpseXx40AY+R0NqxAWjihZ0TxiRK/LjIHeIrx78PaOw7Opv5VAYma4vokclZTd1SjMovYxi12g35cTdwa0ZsBwu06t80PIBgB/gRnZnnPSgOz0xp1Z+f2HgrwdFUwbjFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUjHE4jq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6594C4CEFB;
	Sat, 25 Oct 2025 16:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409649;
	bh=0QGjg9w5MovQQlzMubdpJglJ7KwASaDwFuoBcn5SVW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rUjHE4jqHBI8zbAx+hb83Y0admv1kjkrNsICA9mTFJTvC9bUfqggcAFvUZaO0aE5j
	 y+5InZpJHuvx3SvDbDYXgfGh6rBWDcAAT0M80DbKSYOIbx3Ds5n56o+UWEolSlQtFo
	 OwecqVVFK0O/mLcbm5gq5jR3ycJb6J6vwmhhv4d+FSonH5NG4SZSaxGHVcwj2xiJnf
	 tb9V4joWV7va92Fav6Yo6CqSWt30XHkIJqpn9tzfkRVgc55puu957GAuKqncBnY0CK
	 Pz3i0EUwAMA91c672C3anG+SKIyYEjk8pRGlsXj3aACcDn9JT5uQk4pvnKgFIh7Ttf
	 mcrdU/LB68Kcw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Chih-Kang Chang <gary.chang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.12] wifi: rtw89: obtain RX path from ppdu status IE00
Date: Sat, 25 Oct 2025 12:00:36 -0400
Message-ID: <20251025160905.3857885-405-sashal@kernel.org>
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

[ Upstream commit e156d2ab36d7e47aec36845705e4ecb1e4e89976 ]

The header v2 of ppdu status is optional, If it is not enabled, the RX
path must be obtained from IE00 or IE01. Append the IE00 part.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250915065213.38659-5-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES – the change plugs a real regression in the rtw89 Wi‑Fi stack and is
safe to carry to stable.

- When the PPDU “header v2” block is absent, `phy_ppdu->hdr_2_en` stays
  0 (`drivers/net/wireless/realtek/rtw89/core.c:1977`), so we must
  populate `phy_ppdu->rx_path_en` from the legacy PHY information
  elements. Before this patch, the common CCK parser
  (`core.c:1900-1912`) never touched `rx_path_en`, leaving it at 0 for
  CCK frames.
- Downstream users assume `rx_path_en` is valid. For Wi‑Fi 7 hardware,
  `rtw8922a_convert_rpl_to_rssi()` zeros every RSSI/FD sample whenever
  the bitmask is 0
  (`drivers/net/wireless/realtek/rtw89/rtw8922a.c:2722-2735`). That
  produces bogus ~‑110 dBm signals, breaks per-chain reporting, and
  interferes with antenna-diversity decisions in monitor mode or
  diagnostics whenever firmware omits header v2 (which the commit
  message notes is optional).
- The fix simply mirrors the existing OFDM logic by extracting the same
  4‑bit mask out of IE00 (`le32_get_bits(ie->w3, …)` in
  `core.c:1910-1912`) and adds the matching mask definition
  (`drivers/net/wireless/realtek/rtw89/txrx.h:575`). Header‑v2 users are
  untouched because the assignment is gated on `!hdr_2_en`, preserving
  the newer path (`core.c:1958-1963`).
- The bug originated with frequency-domain RSSI support in
  `c9ac071e30ba4` (first in v6.12-rc1), so all kernels carrying that
  commit (and therefore the BE/8922A RSSI conversion) will suffer the
  wrong RSSI without this fix. No additional dependencies were
  introduced afterward.

Given the clear user-visible malfunction, the very small and self-
contained change, and the fact that it only restores parity with the
already-supported OFDM path, this is an excellent candidate for stable
backporting. Recommended follow-up is simply to ensure the prerequisite
`c9ac071e30ba4` (and later header-length fix `640c27b2e0c50`) are
present before applying.

 drivers/net/wireless/realtek/rtw89/core.c | 4 ++++
 drivers/net/wireless/realtek/rtw89/txrx.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 0f7a467671ca8..2cebea10cb99b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1844,6 +1844,10 @@ static void rtw89_core_parse_phy_status_ie00(struct rtw89_dev *rtwdev,
 
 	tmp_rpl = le32_get_bits(ie->w0, RTW89_PHY_STS_IE00_W0_RPL);
 	phy_ppdu->rpl_avg = tmp_rpl >> 1;
+
+	if (!phy_ppdu->hdr_2_en)
+		phy_ppdu->rx_path_en =
+			le32_get_bits(ie->w3, RTW89_PHY_STS_IE00_W3_RX_PATH_EN);
 }
 
 static void rtw89_core_parse_phy_status_ie00_v2(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index ec01bfc363da3..307b22ae13b2a 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -572,6 +572,7 @@ struct rtw89_phy_sts_ie00 {
 } __packed;
 
 #define RTW89_PHY_STS_IE00_W0_RPL GENMASK(15, 7)
+#define RTW89_PHY_STS_IE00_W3_RX_PATH_EN GENMASK(31, 28)
 
 struct rtw89_phy_sts_ie00_v2 {
 	__le32 w0;
-- 
2.51.0


