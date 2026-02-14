Return-Path: <linux-wireless+bounces-31855-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFKJGV7pkGkOdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31855-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:30:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BEC13D81F
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83C1530A4FE9
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6562D2486;
	Sat, 14 Feb 2026 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MftDr06Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC88B25F994;
	Sat, 14 Feb 2026 21:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104352; cv=none; b=MmJM9oxt6biiIgiwB4iJqzJF9Gkk0Fx9S7hn3FhSTTt0HrZxacClyR9eLUz5lis/A6tVC014u//o8wnL194Hs8qzoexYu7D9XJfVInQY4679qDbWW9RIYTIbAVUBl/OpsgO5RlYMTnoEn1Goj6zz7hYhhlV858OvxlOkhP1b7dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104352; c=relaxed/simple;
	bh=mUbgclJqjUwPl4cKFFF63FLHgNj3UpN/LhTRwZcaGg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EuIMiiLJZxFleYG1dgOIcR56+HIdh1B/OAsg8Acqrr11Gk6ys3C0/OUtAAG5VoQmXPtzksV0UTZP8SM/hSQPKiwEATyOWsGH0Cb41oM/p3BL9CtzNpoiF76yM0l92kYzKhJhtnTIgTzXQxSugtRcIi8e3UfDLlM+iFj1yYDPflY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MftDr06Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD6CC19422;
	Sat, 14 Feb 2026 21:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104351;
	bh=mUbgclJqjUwPl4cKFFF63FLHgNj3UpN/LhTRwZcaGg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MftDr06YH8dkuMX9RAjsBnEc3XP++ilIDnBMXHb//s93geK648AVikBND9+GXeSkd
	 4hHnJOojmon3lAiPioaoAuUcl6n9+LRaXrkQGs/QCxDug/5DHlH1SwudCuFSdrpIIS
	 n6+d8wiL70xw1pU6RD1tjNkySYzIGlnpyLwATRHsUHQT90boA+RuhIZRuIrzbDA92e
	 ixCMncQ09zqq8bdTjHSa/U54/orS8DuORtPjzjTDycje3yPbkMRVHuEU7j7NpvCPUs
	 yMPhJEJvCCxCgW+/xNb0CKqe65CMG5j2KD4f4ohOmQgmpb4boC1J8gjHtPsHCGDktO
	 DT0X4NoJSwSTQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.12] wifi: rtw89: mac: correct page number for CSI response
Date: Sat, 14 Feb 2026 16:22:58 -0500
Message-ID: <20260214212452.782265-33-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214212452.782265-1-sashal@kernel.org>
References: <20260214212452.782265-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31855-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,realtek.com:email]
X-Rspamd-Queue-Id: 07BEC13D81F
X-Rspamd-Action: no action

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit aa2a44d0d22d45d659b9f01638809b1735e46cff ]

For beamforming procedure, hardware reserve memory page for CSI response.
The unit of register is (value - 1), so add one accordingly as expected.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260110022019.2254969-7-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis of commit: "wifi: rtw89: mac: correct page number for CSI
response"

### 1. Commit Message Analysis

The commit message states that for the beamforming procedure, hardware
reserves memory pages for CSI (Channel State Information) response. The
register expects a value where the unit is `(value - 1)`, meaning the
driver needs to write `pg_num + 1` to get the correct number of pages
reserved. The current code writes `pg_num` directly, which results in
one fewer page than intended.

This is a hardware register programming bug — an off-by-one error in how
a register value is interpreted.

### 2. Code Change Analysis

The change is a single-line fix:
```c
- rtw89_write32_mask(rtwdev, reg, B_BE_CSI_RESERVED_PAGE_NUM_MASK,
  qt_cfg.pg_num);
+ rtw89_write32_mask(rtwdev, reg, B_BE_CSI_RESERVED_PAGE_NUM_MASK,
qt_cfg.pg_num + 1);
```

This is about as minimal and surgical as a fix can be. It corrects the
value written to the `R_BE_RESP_CSI_RESERVED_PAGE` register's page
number field by adding 1 to account for the hardware's `(value - 1)`
encoding.

### 3. Bug Classification

This is a **hardware register programming bug** (off-by-one). The
consequence is that the hardware reserves one fewer memory page than
needed for CSI response in beamforming. This could lead to:
- **Beamforming failures** or degraded WiFi performance
- Potential **memory corruption within the hardware's DLE (Data Link
  Engine)** if CSI responses overflow the allocated pages
- Possible **firmware/hardware hangs** if the CSI response data
  overwrites adjacent memory regions in the hardware

### 4. Scope and Risk Assessment

- **Lines changed**: 1 line
- **Files touched**: 1 file
  (`drivers/net/wireless/realtek/rtw89/mac_be.c`)
- **Complexity**: Trivially simple — adds `+ 1` to a value
- **Risk of regression**: Extremely low. The fix aligns the driver with
  the hardware's documented register encoding. Writing the wrong value
  was the bug.
- **Subsystem**: WiFi driver (rtw89 — Realtek WiFi), which is a commonly
  used wireless driver

### 5. User Impact

- **Who is affected**: Users of Realtek WiFi chipsets supported by the
  rtw89 driver (specifically the "BE" generation, likely WiFi 7 chips
  like RTL8922AE)
- **Severity**: Medium-high. Beamforming is important for WiFi
  performance and reliability. With incorrect page reservation, users
  may experience degraded throughput, connection instability, or
  potential hardware issues
- **Real-world impact**: Any user with this hardware would be affected
  during beamforming operations

### 6. Stability Indicators

- **Author**: Ping-Ke Shih (pkshih@realtek.com) — the primary maintainer
  of the rtw89 driver at Realtek. Highly trusted for this subsystem.
- **Obviously correct**: The commit message clearly explains the
  hardware register encoding, and the fix directly addresses it.

### 7. Dependency Check

This is a standalone fix. It doesn't depend on other patches (it's patch
7 of a series, but this particular change is self-contained — it just
corrects a value written to a register). The function
`resp_pktctl_init_be()` and the register definitions need to exist in
the stable tree.

### 8. Stable Kernel Criteria Assessment

- **Obviously correct**: Yes — the hardware register uses `(value - 1)`
  encoding, so writing `pg_num + 1` is the correct value
- **Fixes a real bug**: Yes — off-by-one in hardware register
  programming causes incorrect page reservation
- **Small and contained**: Yes — single line change in a single file
- **No new features**: Correct — this is purely a bug fix
- **Tested**: From the Realtek driver maintainer, submitted through
  proper channels

### Risk vs. Benefit

- **Risk**: Negligible. A one-line arithmetic correction to a hardware
  register value, authored by the subsystem maintainer.
- **Benefit**: Fixes beamforming page allocation for rtw89 BE-generation
  WiFi hardware, preventing potential performance degradation or
  hardware issues.

### Concerns

The only concern is whether the `mac_be.c` file exists in the target
stable trees. The "BE" generation support was added relatively recently,
so this fix would only apply to stable kernels that already include
rtw89 BE support. But if the code exists in the stable tree, this fix is
clearly appropriate.

**YES**

 drivers/net/wireless/realtek/rtw89/mac_be.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 9b9e646487346..dee5ff71b75fe 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -1175,7 +1175,7 @@ static int resp_pktctl_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_RESP_CSI_RESERVED_PAGE, mac_idx);
 	rtw89_write32_mask(rtwdev, reg, B_BE_CSI_RESERVED_START_PAGE_MASK, qt_cfg.pktid);
-	rtw89_write32_mask(rtwdev, reg, B_BE_CSI_RESERVED_PAGE_NUM_MASK, qt_cfg.pg_num);
+	rtw89_write32_mask(rtwdev, reg, B_BE_CSI_RESERVED_PAGE_NUM_MASK, qt_cfg.pg_num + 1);
 
 	return 0;
 }
-- 
2.51.0


