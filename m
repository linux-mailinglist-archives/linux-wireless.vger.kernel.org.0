Return-Path: <linux-wireless+bounces-28260-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD45C0994A
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 18:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9D41C815BF
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 16:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CE0313E1B;
	Sat, 25 Oct 2025 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Za6hh7V8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC3730DD34;
	Sat, 25 Oct 2025 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409416; cv=none; b=RvUM/6NKgFvqIVQlbZYDIPbfptwxNkA8PRdTB2jjxkonQvjGiarL+8+lqPfiijLP+ElE59zJaHSuxTT2N8RPyG6xDSmbUbqmhts4vXDkkEdFGb5Y2N5T6JdROAr4NhxBr0cKOUXPZmiFCuwdZBvZKPR2yVNcvqkQeN3b4WZsMs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409416; c=relaxed/simple;
	bh=ATJBh4hHrUIzCasofL8ny9QYa/F7yEQCjLOJZQHII/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q48XsVD01e8AktwvpLgo6PRjhLeAE3dkeJAwPHAKZQlQf236gOYZUju7hFTBO8FdVfKpWnLU+P16cs5AOwMSkplwezxNrr4KypUHXU8Ai7zPJ8NnOZBYX4XtDD6SGvBf/ozQMw06LUxVW3dQMITXNDIN8B3xCLnVLGgFKW88SN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Za6hh7V8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0763C4CEFB;
	Sat, 25 Oct 2025 16:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409416;
	bh=ATJBh4hHrUIzCasofL8ny9QYa/F7yEQCjLOJZQHII/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Za6hh7V8WbPH5Ceo6wTcMWS3QUte9yCeJJhx8Ho7ruYoXN73z7E3D2didrZUS6Lwz
	 cnp25KKCGpRq0OwhsMCohL33ixTWsZ5YzhzuCfoiBFuh+PrvlhzLJrTh2zglpUS45L
	 Mque/2d82vCmGZiT6jvftzhUuMJX3fVDhOchkMJjSqzithYeFtrwyG0MIdwQSvZO8F
	 C4zzJke47lTYTAG7KIfmN5bkIa8r2VRRDNd3qpEltU9xt6WidD9aKDvyUoL+5ArkIp
	 yxetOY9hawTw1S1zhirML9EbOcg9pFcT22/Ml7beR9pV7Ql5U7fVBwhaM3JM3EGZny
	 uxWSefEVhv/3w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kuan-Chung Chen <damon.chen@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.12] wifi: rtw89: wow: remove notify during WoWLAN net-detect
Date: Sat, 25 Oct 2025 11:59:05 -0400
Message-ID: <20251025160905.3857885-314-sashal@kernel.org>
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

[ Upstream commit 38846585f9df9af1f7261d85134a5510fc079458 ]

In WoWLAN net-detect mode, the firmware periodically performs scans
and sends scan reports via C2H, which driver does not need. These
unnecessary C2H events cause firmware watchdog timeout, leading
to unexpected wakeups and SER 0x2599 on 8922AE.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250811123744.15361-4-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- What it fixes
  - In WoWLAN net-detect (PNO) mode, the driver currently enables all
    per-channel scan-offload notifications by setting `notify_action` to
    the debug mask. This causes the firmware to emit frequent C2H scan
    notifications that the driver doesn’t use while the host sleeps,
    leading to firmware watchdog timeouts, unexpected wakeups, and SER
    0x2599 on 8922AE. The change removes those notifications only for
    the PNO (net‑detect) path.

- Specific code changes
  - Removes `ch_info->notify_action = RTW89_SCANOFLD_DEBUG_MASK;` in the
    PNO channel setup paths:
    - AX path: `drivers/net/wireless/realtek/rtw89/fw.c:7126`
    - BE path: `drivers/net/wireless/realtek/rtw89/fw.c:7267`
  - Leaves hardware/normal scan paths intact (these still set
    `notify_action` for runtime scanning, e.g.
    `drivers/net/wireless/realtek/rtw89/fw.c:7183`,
    `drivers/net/wireless/realtek/rtw89/fw.c:7309`), so normal scan
    behavior is unaffected.

- Why removing these lines is correct and low risk
  - `notify_action` is a 5‑bit field controlling per-channel scan-
    offload notifications
    (`drivers/net/wireless/realtek/rtw89/fw.h:354`,
    `drivers/net/wireless/realtek/rtw89/fw.h:384`), and
    `RTW89_SCANOFLD_DEBUG_MASK` is `0x1F` (enables all notification
    types) (`drivers/net/wireless/realtek/rtw89/fw.h:336`).
  - These fields are consumed by the H2C channel-info encoders:
    - AX: `le32_encode_bits(ch_info->notify_action,
      RTW89_H2C_CHINFO_W1_ACTION)`
      (`drivers/net/wireless/realtek/rtw89/fw.c:5495`)
    - BE: `le32_encode_bits(ch_info->notify_action,
      RTW89_H2C_CHINFO_BE_W1_NOTIFY)`
      (`drivers/net/wireless/realtek/rtw89/fw.c:5586`)
  - In the PNO path, `ch_info` is allocated with `kzalloc`, so with the
    assignment removed, `notify_action` defaults to 0 (no per-channel
    notifications). See `kzalloc` and subsequent call into the PNO
    helpers:
    - AX: allocation and call:
      `drivers/net/wireless/realtek/rtw89/fw.c:7398`
    - BE: allocation and call:
      `drivers/net/wireless/realtek/rtw89/fw.c:7609`
  - Net-detect scans are initiated from the WoWLAN path (e.g.
    `rtw89_wow_init_pno` and `rtw89_pno_scan_offload`), not from active
    host scanning:
    - Net-detect enabled log:
      `drivers/net/wireless/realtek/rtw89/wow.c:1071`
    - PNO scan offload start/stop from WoW:
      `drivers/net/wireless/realtek/rtw89/wow.c:1510`,
      `drivers/net/wireless/realtek/rtw89/wow.c:1516`
  - The “end of scan cycle” H2C notify bit (distinct from per-channel
    notify_action) remains enabled via
    `RTW89_H2C_SCANOFLD_W1_NOTIFY_END` for scan offload coordination
    (`drivers/net/wireless/realtek/rtw89/fw.c:5683`), so control flow
    isn’t broken.
  - Normal/hardware scan behavior remains unchanged since those paths
    still set `notify_action`, so no regression for active scans.

- Scope and stability criteria
  - Small and contained: Two assignments removed in a single file
    specifically for WoWLAN PNO paths.
  - No feature additions or architectural changes; limited to `rtw89`
    Wi‑Fi driver.
  - Directly addresses a user-visible bug (unexpected wakeups and
    firmware SER/reset on 8922AE) in a low-power feature where spurious
    notifications are harmful.
  - Aligns with stable backport rules: important bugfix, minimal risk,
    confined to a subsystem.

- Conclusion
  - This is a clear bugfix that reduces unnecessary C2H traffic during
    WoWLAN net-detect and prevents firmware watchdog/SER events on
    affected hardware. It is safe and appropriate to backport to stable
    kernels.

 drivers/net/wireless/realtek/rtw89/fw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 16e59a4a486e6..e6f8fab799fc1 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -7123,7 +7123,6 @@ static void rtw89_pno_scan_add_chan_ax(struct rtw89_dev *rtwdev,
 	struct rtw89_pktofld_info *info;
 	u8 probe_count = 0;
 
-	ch_info->notify_action = RTW89_SCANOFLD_DEBUG_MASK;
 	ch_info->dfs_ch = chan_type == RTW89_CHAN_DFS;
 	ch_info->bw = RTW89_SCAN_WIDTH;
 	ch_info->tx_pkt = true;
@@ -7264,7 +7263,6 @@ static void rtw89_pno_scan_add_chan_be(struct rtw89_dev *rtwdev, int chan_type,
 	struct rtw89_pktofld_info *info;
 	u8 probe_count = 0, i;
 
-	ch_info->notify_action = RTW89_SCANOFLD_DEBUG_MASK;
 	ch_info->dfs_ch = chan_type == RTW89_CHAN_DFS;
 	ch_info->bw = RTW89_SCAN_WIDTH;
 	ch_info->tx_null = false;
-- 
2.51.0


