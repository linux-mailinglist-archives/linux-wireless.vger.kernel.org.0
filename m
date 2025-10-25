Return-Path: <linux-wireless+bounces-28259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3A6C0974F
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 18:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A75D34E7F0
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 16:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C88230BF72;
	Sat, 25 Oct 2025 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxy8aLsR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0492D30506C;
	Sat, 25 Oct 2025 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409325; cv=none; b=kr7Vewi3YyipHWF81fI+KGJwNzMwSLOdCqdCSbOWEhx+eFWi+jKMSe0EohvUVFSN2T8c7idIHPR2r9kRmyXpzxVkU9KYCcCJMG9kjd6P0SLzsqs46DjvvHXO2fWSjWzDHqbvP8xUZ1E0I2edOHLT5BlnM6jlXrJV9sEW4owAyGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409325; c=relaxed/simple;
	bh=PDVVWw42kVC8LPT260SgqJWF/qgL6c3wPJmj4MRx5I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7or6Ry/2xVjwqDzKYQ8LVpak+hSs3bTcQkP4+6hthxb/6VhoOjngmMC6YldIyhPSM4Rp1QfeQ/t0BqXWVlsgaiHq0YgnJh6TSQ6FopeMaP/7VA3Vfbnxir6o/KmE+sk1o3jOBTKDMBxsRcvlCvrXK1DnCefIM8vZLhwAiZ4BPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxy8aLsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A393C2BC9E;
	Sat, 25 Oct 2025 16:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409324;
	bh=PDVVWw42kVC8LPT260SgqJWF/qgL6c3wPJmj4MRx5I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nxy8aLsRbKi6v2bKIP/YI06cgd0Iak/ZLJhrRIVLvyl5esjiHQDvuRFBXsDHZTKft
	 fojEAcVgiO7QiIDOGES29XEDAaFtgefTWI6ssdNnV87G8LMYT7u1Dyv5WSU5z7K+5y
	 QxeltO+f1ZwjHsq7OtcliawLYHmlNq7p1sppKuPoKYy9xqGYGtMX3tQ6mpoLEkKp/h
	 l/hmcU4RYLojRvW3FKtsMY9ij6zgMQDwRLvNj42FbNH02Lb0oQ2r/WA0wzqeluIW0+
	 51WTB6G3l+b4c3sEK4qbH2Ek6FXIVnBJseP2uzSaKwfCNEKWNEAVQIflYLphMBmEes
	 Zu9NWSdWJQyIw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.6] wifi: rtw88: sdio: use indirect IO for device registers before power-on
Date: Sat, 25 Oct 2025 11:58:31 -0400
Message-ID: <20251025160905.3857885-280-sashal@kernel.org>
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

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 58de1f91e033b1fface8d8948984583125f93736 ]

The register REG_SYS_CFG1 is used to determine chip basic information
as arguments of following flows, such as download firmware and load PHY
parameters, so driver read the value early (before power-on).

However, the direct IO is disallowed before power-on, or it causes wrong
values, which driver recognizes a chip as a wrong type RF_1T1R, but
actually RF_2T2R, causing driver warns:

  rtw88_8822cs mmc1:0001:1: unsupported rf path (1)

Fix it by using indirect IO before power-on.

Reported-by: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/699C22B4-A3E3-4206-97D0-22AB3348EBF6@gmail.com/T/#t
Suggested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Tested-by: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250724004815.7043-1-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

Explanation

- Bug fixed and user impact:
  - The driver reads `REG_SYS_CFG1` very early to determine chip RF
    configuration before full power-on. In SDIO mode, doing this via
    direct I/O before power-on can return wrong values, making 2T2R
    chips look like 1T1R and leading to runtime warnings and
    misconfiguration (e.g., “unsupported rf path (1)”).
  - The early read is visible in
    `drivers/net/wireless/realtek/rtw88/main.c:1861`, where
    `hal->chip_version = rtw_read32(rtwdev, REG_SYS_CFG1);` happens
    during core init, before the power-on flag is set.

- What the change does:
  - It updates the direct/indirect access decision so that device
    register accesses use indirect I/O until the device is fully powered
    on.
  - Specifically, `rtw_sdio_use_direct_io()` now returns false (use
    indirect) when the device is not yet powered on and the target is
    not a bus address. This is the minimal and precise change that
    addresses the wrong-value read issue.

- Code path details and why it works:
  - Current decision helper:
    - `drivers/net/wireless/realtek/rtw88/sdio.c:145` defines
      `rtw_sdio_use_direct_io()` and is used by all bus read/write entry
      points (`read8/16/32`, `write8/16/32`) at
      `drivers/net/wireless/realtek/rtw88/sdio.c:257`,
      `drivers/net/wireless/realtek/rtw88/sdio.c:285`,
      `drivers/net/wireless/realtek/rtw88/sdio.c:313`, and for writes
      later in the file.
  - Address translation:
    - `drivers/net/wireless/realtek/rtw88/sdio.c:127`
      `rtw_sdio_to_io_address()` adds `WLAN_IOREG_OFFSET` only for
      direct I/O on device registers; indirect I/O passes the raw MAC
      register address to the indirect engine. This ensures that with
      the new condition pre-power-on device register accesses go through
      the indirect mechanism as intended.
  - Indirect engine:
    - Indirect access is orchestrated via `REG_SDIO_INDIRECT_REG_CFG`
      and `REG_SDIO_INDIRECT_REG_DATA`
      (`drivers/net/wireless/realtek/rtw88/sdio.c:159`,
      `drivers/net/wireless/realtek/rtw88/sdio.h:115`) and does not
      depend on the device power-on state for correctness, as it uses
      SDIO-local registers.
  - Power state flag:
    - The power-on flag used by the new check is already present and
      managed in the core: see
      `drivers/net/wireless/realtek/rtw88/main.h:371` for
      `RTW_FLAG_POWERON`, and it is cleared/set in the generic power
      flows (`drivers/net/wireless/realtek/rtw88/rtw88xxa.c:753`,
      `drivers/net/wireless/realtek/rtw88/rtw88xxa.c:1233`) and in MAC
      power flows (`drivers/net/wireless/realtek/rtw88/mac.c:309`,
      `drivers/net/wireless/realtek/rtw88/mac.c:325`).
  - Early read context:
    - Because `REG_SYS_CFG1` is read before `RTW_FLAG_POWERON` is set
      (`drivers/net/wireless/realtek/rtw88/main.c:1861`), the new guard
      in `rtw_sdio_use_direct_io()` affects precisely this problematic
      access, forcing indirect I/O and preventing the mis-detection of
      RF path count.

- Scope and risk:
  - Scope: One small conditional addition in a single function in the
    rtw88 SDIO HCI glue (`drivers/net/wireless/realtek/rtw88/sdio.c`).
    No API changes, no architectural refactoring.
  - Behavior change is intentionally limited to pre-power-on device
    register accesses; bus addresses remain direct, and after power-on
    existing direct/indirect policy remains unchanged.
  - This reduces risk of wrong reads on SDIO 2.0 paths (where prior
    logic allowed direct I/O pre-power-on) and aligns pre-power-on
    behavior across SDIO versions, improving reliability.
  - The indirect path is established and already used broadly (e.g.,
    when SDIO 3.0 is supported or for unaligned accesses), so
    coverage/risk is low.

- Stable backport suitability:
  - Fixes a real, user-visible problem (incorrect RF path detection and
    warnings; potential malfunction).
  - Change is small, contained, and conforms to stable rules (bug fix,
    no new features or invasive changes).
  - Only touches the rtw88 SDIO transport, not core kernel or unrelated
    subsystems.
  - The commit message references a report, suggested fix, and testing,
    supporting its maturity.

- Specific code references
  - Decision point to force indirect before power-on:
    drivers/net/wireless/realtek/rtw88/sdio.c:145
  - Address mapping for direct I/O:
    drivers/net/wireless/realtek/rtw88/sdio.c:127
  - Indirect engine config/data registers:
    drivers/net/wireless/realtek/rtw88/sdio.c:159,
    drivers/net/wireless/realtek/rtw88/sdio.h:115
  - Power-on flag declaration:
    drivers/net/wireless/realtek/rtw88/main.h:371
  - Power-on flag management:
    drivers/net/wireless/realtek/rtw88/rtw88xxa.c:753,
    drivers/net/wireless/realtek/rtw88/rtw88xxa.c:1233;
    drivers/net/wireless/realtek/rtw88/mac.c:309,
    drivers/net/wireless/realtek/rtw88/mac.c:325
  - Early `REG_SYS_CFG1` read (bug trigger site):
    drivers/net/wireless/realtek/rtw88/main.c:1861
  - `WLAN_IOREG_OFFSET` definition:
    drivers/net/wireless/realtek/rtw88/sdio.h:11

Conclusion: This commit is a strong candidate for stable backport. It
addresses a concrete and reported malfunction with a minimal, targeted
change and low regression risk, confined to the rtw88 SDIO pre-power-on
access path.

 drivers/net/wireless/realtek/rtw88/sdio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index cc2d4fef35879..99d7c629eac6f 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -144,6 +144,10 @@ static u32 rtw_sdio_to_io_address(struct rtw_dev *rtwdev, u32 addr,
 
 static bool rtw_sdio_use_direct_io(struct rtw_dev *rtwdev, u32 addr)
 {
+	if (!test_bit(RTW_FLAG_POWERON, rtwdev->flags) &&
+	    !rtw_sdio_is_bus_addr(addr))
+		return false;
+
 	return !rtw_sdio_is_sdio30_supported(rtwdev) ||
 		rtw_sdio_is_bus_addr(addr);
 }
-- 
2.51.0


