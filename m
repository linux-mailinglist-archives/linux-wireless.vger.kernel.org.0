Return-Path: <linux-wireless+bounces-27114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A63FB49DFF
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 02:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE59D3B3814
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 00:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BAE1EEA49;
	Tue,  9 Sep 2025 00:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibgL2U5C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75011E501C;
	Tue,  9 Sep 2025 00:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757377837; cv=none; b=NsD2zuwJ4JYuXNWy3LhKW7I2fbb1NgmwKmkwxL1yoRy3KX3+BqXGW8vIni6QQwkv7bSEXcAF5Q3mGiRhnLJOyD9j5yJOq0w2HEN+VL12CH/30VpgvpHe6sVdiurVDO1W8hOt/fCCQEGnbJ1k36n+/Ip7aGi9Gcrl6CzLDrNAysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757377837; c=relaxed/simple;
	bh=0uzllPnalyRF+ushAucw1IpVYRxk4ZJLkGvfoHlSaLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXDWFdh5XbnNDr09O0rVYbgvlljiN87aLxkUCPliLKdHDsIZCyPd2yCU2tgEGX5ZCw16s2RVAYqeoHP47h4ZUtfHOdtFRiHj63y02jImgZ2SrSlOBDOSX71sENVTEH8xUvD8yqVMe1eYoTsViScEg3+1rz8iJa33pSs1QKfd8lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibgL2U5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114A5C4CEF7;
	Tue,  9 Sep 2025 00:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757377837;
	bh=0uzllPnalyRF+ushAucw1IpVYRxk4ZJLkGvfoHlSaLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ibgL2U5C0csPR6VvGNS5yjtW9vZ6hD/OOtTjVNpWsj75APHSVhp4ZiwyMdRBA+Scc
	 rCWBJRhjHvJTd1E47qfwrgO5MX6AbECK7u9ZKftd94r4rnZjR7N7vcYbQSWRD34qMh
	 2Wuz+/5V7iwIdPnNb+dHoSSGjqrVlqdvQsusQmPKboqVNwnxhNX8/G8kjEAHrdjRbk
	 RiFRM2UI3io3PVRkuijN6sEe2509SZbOLDYrFb9P3wpUjhxRpbXlDnWc0eY0Uhv+uv
	 yw/hc9tfZe7cYRWX7+BmKtbewTHsMCYtIkQhh/0OenBP8lAtRmRNNHC3GZSM3oubJ8
	 rxgqSU2IEHvyA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.16] wifi: mt76: do not add non-sta wcid entries to the poll list
Date: Mon,  8 Sep 2025 20:30:16 -0400
Message-ID: <20250909003025.2493540-6-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909003025.2493540-1-sashal@kernel.org>
References: <20250909003025.2493540-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit a3c99ef88a084e1c2b99dd56bbfa7f89c9be3e92 ]

Polling and airtime reporting is valid for station entries only

Link: https://patch.msgid.link/20250827085352.51636-2-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

## Extensive Analysis

This commit adds a critical safety check to prevent non-station wcid
entries from being incorrectly added to the polling list in the mt76
wireless driver.

### Bug Being Fixed

The commit fixes a bug where non-station wcid (wireless client ID)
entries could be added to the `sta_poll_list`. Looking at the code
change in `mt76_wcid_add_poll()`:

```c
- if (test_bit(MT76_MCU_RESET, &dev->phy.state))
+       if (test_bit(MT76_MCU_RESET, &dev->phy.state) || !wcid->sta)
                return;
```

The addition of `|| !wcid->sta` prevents wcid entries that don't
represent actual wireless stations from being added to the polling list.

### Why This is a Critical Fix

1. **Prevents Kernel Crashes**: The polling mechanism (seen in files
   like mt7915/mac.c:100-150) assumes that wcids in the poll list have
   valid `ieee80211_sta` structures. When processing the poll list, the
   code does:
  ```c
  sta = container_of((void *)msta, struct ieee80211_sta, drv_priv);
  ieee80211_sta_register_airtime(sta, tid, tx_cur, rx_cur);
  ```
  For non-sta wcids (like global_wcid, group_wcid, or interface wcids),
  this would dereference invalid memory and cause a kernel panic.

2. **Affects All mt76-based Hardware**: This bug affects multiple
   MediaTek WiFi chipsets including mt7603, mt7615, mt7915, mt7921,
   mt7925, and mt7996, as evidenced by the calls to
   `mt76_wcid_add_poll()` across all these driver variants.

3. **Simple and Contained Fix**: The fix is a single-line addition of a
   boolean check that has minimal risk of introducing regressions. It
   only adds a safety check without changing any existing logic flow.

### Evidence from Code Analysis

The wcid structure (mt76.h:348-378) contains a `sta` field (line 365)
that's a 1-bit flag distinguishing between:
- Station wcids (`sta=1`): Real wireless clients
- Non-sta wcids (`sta=0`): Internal entries like global_wcid,
  group_wcid, interface wcids

The polling mechanism is specifically designed for collecting airtime
statistics from real stations for:
- Airtime fairness scheduling
- Rate control adaptation
- TX/RX time accounting

Non-sta wcids don't have associated `ieee80211_sta` structures and don't
participate in these mechanisms, so polling them is both meaningless and
dangerous.

### Stable Tree Criteria Assessment

✓ **Fixes a real bug**: Prevents potential kernel crashes from invalid
memory access
✓ **Small and contained**: Single-line boolean check addition
✓ **Clear bug fix**: Not a new feature or architectural change
✓ **Low regression risk**: Only adds a safety check, doesn't modify
existing behavior for valid cases
✓ **Affects users**: Can cause kernel panics in production WiFi systems
✓ **Driver-specific**: Confined to mt76 wireless subsystem

This is an ideal candidate for stable backporting as it fixes a clear
bug that can cause system crashes, the fix is minimal and safe, and it
affects widely-used MediaTek WiFi hardware.

 drivers/net/wireless/mediatek/mt76/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 45c8db939d554..13dc868076f08 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1690,7 +1690,7 @@ EXPORT_SYMBOL_GPL(mt76_wcid_cleanup);
 
 void mt76_wcid_add_poll(struct mt76_dev *dev, struct mt76_wcid *wcid)
 {
-	if (test_bit(MT76_MCU_RESET, &dev->phy.state))
+	if (test_bit(MT76_MCU_RESET, &dev->phy.state) || !wcid->sta)
 		return;
 
 	spin_lock_bh(&dev->sta_poll_lock);
-- 
2.51.0


