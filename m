Return-Path: <linux-wireless+bounces-29607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CCACAE7BF
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Dec 2025 01:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C7B1306C67C
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Dec 2025 00:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C25E21ADC7;
	Tue,  9 Dec 2025 00:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZT0wrQAd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7E51FF5E3;
	Tue,  9 Dec 2025 00:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765239418; cv=none; b=Bf1SBhu4bGKczMWal3TvNPGWaHP8/RIxb3fdNI0UTPV6H24Y4T08+odd9al3VBWs5bcr4xl+Z2weNCTqZrQF9LI3OfM/3CRTqaqtw5SKRtNKk+RjABMmSPBYsa12Q0UWL92Dym1qXhpe2jBxcg5zMoSi/hW4T5dfBO5DwQSKbIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765239418; c=relaxed/simple;
	bh=CcoOduBaJKs+Vjdxjvqz8sl0XCzaN235phou1vX6Q7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZBA6S78DqSBmk+XuziIJa7eB857L4RNMzRECxD5y3w+6OIZOP/uAAp1XFhWZxWWCoDYab2VzLe+qMLx+CP+0AFJjUBx4XVKzQKmC7VKOQ1//H/TJE4HBw1LMV8SU9LpJV8eTFNX7Fgb1se4/ewCQIPvl0ppxXizRE2O34Sab6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZT0wrQAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13CDC113D0;
	Tue,  9 Dec 2025 00:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765239417;
	bh=CcoOduBaJKs+Vjdxjvqz8sl0XCzaN235phou1vX6Q7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZT0wrQAdlZg68BobiE6NmgGOvL0AYRawmqvssGrtTPwrbIxbHIW1cqe8Y1ajTOC2l
	 z1RRJiwp25q3phSIkLGZjhKNAY7X1xPpoqr5o7WoHrz3loizZiSvz59yoc4WVy7NW6
	 GmdoyTvlP2k7i2zF+wwgHynrQx1YwMEPHPOzRfs+7N2O2kBqug7THD2UihnbwuwKlF
	 94bDAwsLJDBWKu1u/4xFKGSiYmK4JV0sakphOlwn/Ppm4UewRj6ld30liKdyutpkWW
	 NbmO2lGoS6J7Vl404zaK3l9Uap8Tpb1Qf0/N7Ds7BF6bUMVSZGF2wL7WkMNUw4mVZF
	 VIjdKki0s56Hw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Caleb James DeLisle <cjd@cjdns.fr>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.18-5.10] wifi: mt76: mmio_*_copy fix byte order and alignment
Date: Mon,  8 Dec 2025 19:15:04 -0500
Message-ID: <20251209001610.611575-12-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209001610.611575-1-sashal@kernel.org>
References: <20251209001610.611575-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Caleb James DeLisle <cjd@cjdns.fr>

[ Upstream commit 2df00805f7dbaa46b60c682aad0d76270b7ba266 ]

Update functions which copy to and from MMIO to load bytes as Little
Endian, and also support unaligned buffers.

PCI devices almost universally use Little Endian ordering for MMIO
registers, mt76 is no exception. PCI hardware that is designed to work
with Big Endian CPUs often (but not always) "helps" by transparently
byte-swapping MMIO reads and writes on the wire. If this is enabled
then it cannot be turned off for a single write. On hardware which does
not support this, writel() does the swap in software. When we are
transferring arbitrary bytes to MMIO space, we need them to arrive in
the same order they were in memory, so when the hardware swaps them
this is a problem. Rather than care about how our PCI host controller
works, we instead load bytes as Little Endian - so on a Big Endian
machine this will reverse them, then we use writel() which will put
them back in the right order again. This way we do not make it our
business whether the swapping is done in software or hardware.

Furthermore, inspection of the code shows that these functions are
often called with stack-allocated u8 arrays which have no alignment
guarantees so we now use (get|put)_unaligned_le32().

Fixes this issue:
mt76x2e 0000:02:00.0: ROM patch build: 20141115060606a
mt76x2e 0000:02:00.0: Firmware Version: 0.0.00
mt76x2e 0000:02:00.0: Build: 1
mt76x2e 0000:02:00.0: Build Time: 201607111443____
mt76x2e 0000:02:00.0: Firmware failed to start
mt76x2e 0000:02:00.0: probe with driver mt76x2e failed with error -145

Tested on:
SmartFiber XP8421-B (Big Endian MIPS 34Kc)
  - MT7612 -> 5g / ap / psk2
  - MT7603 -> 2g / sta / psk2
  - MT7603 -> 2g / ap / psk2
TpLink Archer v1200v-v2 (Big Endian MIPS 34Kc)
  - MT7613 -> 5g / ap / psk2
  - MT7603 -> 2g / sta / psk2

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
Link: https://patch.msgid.link/20251029184143.3991388-1-cjd@cjdns.fr
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## ANALYSIS SUMMARY

### 1. COMMIT MESSAGE ANALYSIS

**Bug Description:** The commit fixes two issues in mt76 WiFi driver's
MMIO copy functions:
1. **Byte order issue on Big Endian systems:** The original code uses
   `__iowrite32_copy()` and `__ioread32_copy()` which internally use
   `__raw_writel()`/`__raw_readl()` - these do NOT perform byte swapping
2. **Unaligned buffer issue:** Stack-allocated u8 arrays may not be
   4-byte aligned

**User-visible failure:** Complete driver probe failure with "Firmware
failed to start" error -145 on Big Endian systems. WiFi is totally non-
functional.

**Testing:** Tested on real hardware - multiple MT76 devices on Big
Endian MIPS platforms (SmartFiber, TP-Link Archer).

**Notable:** No `Fixes:` or `Cc: stable` tags present.

### 2. CODE CHANGE ANALYSIS

**Root cause:** The generic `__iowrite32_copy()` function (in
`lib/iomap_copy.c:20-28`) uses `__raw_writel()` which writes bytes in
host order without endian conversion. On Big Endian systems, bytes
arrive at the PCI device in the wrong order.

**The fix:**
- Replaces `__iowrite32_copy()` with explicit loop using `writel()` +
  `get_unaligned_le32()`
- Replaces `__ioread32_copy()` with explicit loop using `readl()` +
  `put_unaligned_le32()`

**Why it's correct:**
1. `get_unaligned_le32()` reads 4 bytes interpreting them as little-
   endian (safe for unaligned access)
2. `writel()` handles endian conversion (host→LE for PCI wire format)
3. Combined: bytes arrive at hardware in correct order regardless of
   host endianness
4. On Little Endian systems: behavior is functionally equivalent (no
   regression risk)

**Header dependency:** `<linux/unaligned.h>` is included transitively
via `mac80211.h` → `mt76.h` → `mmio.c`

### 3. CLASSIFICATION

- **Type:** Bug fix (not a feature)
- **Severity:** HIGH - Complete driver failure on affected systems
- **Scope:** mt76 WiFi devices on Big Endian architectures (MIPS
  routers, embedded systems)
- **Security:** Not a security issue

### 4. SCOPE AND RISK ASSESSMENT

| Factor | Assessment |
|--------|------------|
| Lines changed | ~10 lines (very small) |
| Files affected | 1 file (mmio.c) |
| Complexity | Low - uses standard kernel APIs |
| Risk of regression | Low - functionally equivalent on LE systems |
| Self-contained | Yes - no dependencies on other commits |

### 5. USER IMPACT

- **Affected users:** Big Endian systems with mt76 WiFi (OpenWrt
  routers, embedded MIPS devices)
- **Impact severity:** CRITICAL for affected users - WiFi doesn't work
  at all
- **Impact scope:** Minority use case (BE systems are uncommon)

### 6. STABILITY INDICATORS

- ✅ Signed off by subsystem maintainer (Felix Fietkau)
- ✅ Tested on multiple real hardware platforms
- ✅ Uses well-established kernel primitives
- ⚠️ No Reviewed-by tags from others
- ⚠️ No explicit stable request

### 7. DEPENDENCY CHECK

- ✅ Self-contained patch
- ✅ No prerequisite commits needed
- ✅ Code path exists in all stable trees with mt76 (since 2019)

## VERDICT

**Arguments FOR backporting:**
- Fixes a complete driver failure that makes WiFi unusable on Big Endian
  systems
- Small, surgical fix (~10 lines) with well-defined scope
- Uses standard, well-tested kernel APIs (`writel`,
  `get_unaligned_le32`)
- Self-contained with no dependencies
- Accepted by maintainer
- Functionally equivalent on Little Endian systems (no regression risk)

**Arguments AGAINST backporting:**
- No explicit `Cc: stable` tag from maintainer
- No `Fixes:` tag indicating when bug was introduced
- Big Endian systems are a minority use case

**Conclusion:** Despite the lack of explicit stable tagging, this commit
fixes a severe, user-visible bug (complete driver failure) with a small,
obviously correct fix using standard kernel patterns. The risk is low
and the benefit is high for affected users. Big Endian MIPS platforms
with mt76 WiFi (common in OpenWrt/embedded space) deserve working WiFi
support.

**YES**

 drivers/net/wireless/mediatek/mt76/mmio.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mmio.c b/drivers/net/wireless/mediatek/mt76/mmio.c
index cd2e9737c3bf9..865ec910f05a4 100644
--- a/drivers/net/wireless/mediatek/mt76/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mmio.c
@@ -33,13 +33,21 @@ static u32 mt76_mmio_rmw(struct mt76_dev *dev, u32 offset, u32 mask, u32 val)
 static void mt76_mmio_write_copy(struct mt76_dev *dev, u32 offset,
 				 const void *data, int len)
 {
-	__iowrite32_copy(dev->mmio.regs + offset, data, DIV_ROUND_UP(len, 4));
+	int i;
+
+	for (i = 0; i < ALIGN(len, 4); i += 4)
+		writel(get_unaligned_le32(data + i),
+		       dev->mmio.regs + offset + i);
 }
 
 static void mt76_mmio_read_copy(struct mt76_dev *dev, u32 offset,
 				void *data, int len)
 {
-	__ioread32_copy(data, dev->mmio.regs + offset, DIV_ROUND_UP(len, 4));
+	int i;
+
+	for (i = 0; i < ALIGN(len, 4); i += 4)
+		put_unaligned_le32(readl(dev->mmio.regs + offset + i),
+				   data + i);
 }
 
 static int mt76_mmio_wr_rp(struct mt76_dev *dev, u32 base,
-- 
2.51.0


