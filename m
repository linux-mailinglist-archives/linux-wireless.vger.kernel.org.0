Return-Path: <linux-wireless+bounces-31868-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDFkHwnpkGkOdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31868-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:28:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 452AC13D70F
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB8EE3014FE9
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DAF3128D2;
	Sat, 14 Feb 2026 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHAL1u/9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA3E311946;
	Sat, 14 Feb 2026 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104415; cv=none; b=qJyn0ipYEAQOx2Zd7KlmOwoNEYauXWB33NCcxmpjqXHP8O0Z6KNJXvz66rJuqPlTiAxc7MFwpCjjx06i8XkLf672frpvATnYjSLj+HZPbAZ+vBxrIsLiaIGNKa0e1G45Jj4My/PsY6JF0xcVGr6FnC/NWqpsyp9DlZJcGkQzKFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104415; c=relaxed/simple;
	bh=EpS38SPSuQKOXTpV9zikmdTC014tgP8opn/FCfsWElM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EXBSL4Lpe747bH+17qYdGOOvEivxzjadRydvML2sQkYjhTDYBfNieTxn2rZx3i+0jln+V+ILRlnitt7LC7B0KDR9P6GHPcBuQ/4t9BQTC9msD9xlJHFkHKYmT9IpRzCQe5/4QuwbvE6mHR0/APbGHHTvpwdq6QniemnvLAvUXfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHAL1u/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D72DC16AAE;
	Sat, 14 Feb 2026 21:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104415;
	bh=EpS38SPSuQKOXTpV9zikmdTC014tgP8opn/FCfsWElM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BHAL1u/9lqPR8qOipNJTQJ5EDxaAdIc/eSvj63qaez3t4zg4A5t6SAD/8G7ZQFUfm
	 8EhJQ6xecNw/WBI71SzNwucaUwLHk8yRfzXMA7uCAQMcoGdnQLeAs6tPgDhoEKrW7G
	 4ccrKWp0TH+EQEAwAAKIuZUhFncf+QJPN4bW3UstyXPyqJ7gDoB3sdpgZZp/NkUuzx
	 YxSynArLt50sPFSWk5TNhc6LxE3IALMcIhmaEFRzrCELNqWVO2aJ9Vy8V8G6EKwGP4
	 9ZqBzNH4Atk3b3o6Ii9EbvvFV4R+P6qW8mewzriPQk/i0B/BzNXJAAE4s1B2kw4jBk
	 DkKop3x6nidgA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.12] wifi: rtw88: Use devm_kmemdup() in rtw_set_supported_band()
Date: Sat, 14 Feb 2026 16:23:37 -0500
Message-ID: <20260214212452.782265-72-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31868-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Queue-Id: 452AC13D70F
X-Rspamd-Action: no action

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit 2ba12401cc1f2d970fa2e7d5b15abde3f5abd40d ]

Simplify the code by using device managed memory allocations.

This also fixes a memory leak in rtw_register_hw(). The supported bands
were not freed in the error path.

Copied from commit 145df52a8671 ("wifi: rtw89: Convert
rtw89_core_set_supported_band to use devm_*").

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/1aa7fdef-2d5b-4a31-a4e9-fac8257ed30d@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

### Commit Message Analysis

The commit message is explicit about fixing a bug: **"This also fixes a
memory leak in rtw_register_hw(). The supported bands were not freed in
the error path."**

The primary change converts `kmemdup()` to `devm_kmemdup()` (device-
managed memory), which means the memory will be automatically freed when
the device is removed. This simultaneously:
1. Simplifies the code (removes manual `rtw_unset_supported_band()`
   function)
2. **Fixes a real memory leak** on the error path of `rtw_register_hw()`

### Code Change Analysis

Let me trace the bug:

1. `rtw_set_supported_band()` allocates memory with `kmemdup()` for 2GHz
   and 5GHz band structures
2. `rtw_register_hw()` calls `rtw_set_supported_band()` early in its
   flow
3. If `rtw_register_hw()` fails later (e.g., at `rtw_regd_hint()` →
   `goto led_deinit`), the error path does NOT call
   `rtw_unset_supported_band()` to free those allocations
4. The old `rtw_unset_supported_band()` was only called in
   `rtw_unregister_hw()`, which is the normal teardown path — not the
   error path

Let me verify this by examining the error path structure in the diff.
The `rtw_register_hw()` function has error paths (`goto led_deinit`)
that return without freeing the band allocations. This is a genuine
memory leak.

### The Fix

The fix converts to `devm_kmemdup()`, which ties the allocation lifetime
to the device. This means:
- On error paths: memory is freed when the device is cleaned up (no
  leak)
- On normal unregister: memory is freed automatically (no need for
  `rtw_unset_supported_band()`)

The `rtw_unset_supported_band()` function is removed entirely since it's
no longer needed, and the call to it in `rtw_unregister_hw()` is also
removed.

### Stable Criteria Assessment

1. **Fixes a real bug**: Yes — memory leak on error path in
   `rtw_register_hw()`. If probe fails repeatedly (e.g., USB WiFi dongle
   being plugged/unplugged), this leaks memory each time.
2. **Obviously correct**: Yes — the pattern of converting from `kmemdup`
   to `devm_kmemdup` is well-established and was already done in the
   sister driver rtw89 (commit 145df52a8671).
3. **Small and contained**: Yes — changes a single file, ~20 lines of
   actual logic change, rest is removal of now-unnecessary code.
4. **No new features**: Correct — this is purely a bug fix with code
   simplification.
5. **Tested**: Has `Acked-by` from the Realtek maintainer (Ping-Ke
   Shih).

### Risk Assessment

**Low risk**:
- `devm_kmemdup()` is a standard, well-tested kernel API
- The same pattern was already applied to rtw89 (the newer sibling
  driver)
- The change is straightforward — swap allocation function, remove
  manual free function
- The rtw88 driver is widely used (RTL8822BE, RTL8822CE, RTL8821CE are
  common WiFi chips)

**One potential concern**: The devm-managed memory will be freed when
the device is destroyed, while the old code freed it in
`rtw_unregister_hw()`. However, since `ieee80211_unregister_hw()` is
called before the device is destroyed, and that function removes the
wiphy, the bands won't be accessed after the devm memory is freed. This
ordering is safe.

### User Impact

The rtw88 driver covers commonly used Realtek WiFi chips found in many
laptops. Memory leaks during driver initialization failures could
accumulate, especially for USB-based variants where plug/unplug cycles
are common. This is a real-world issue.

### Dependency Check

This commit appears self-contained. `devm_kmemdup()` has been available
in the kernel for a long time. The function signature changes are all
internal to `main.c`. No other patches are needed.

### Conclusion

This commit fixes a genuine memory leak in a widely-used WiFi driver.
The fix is small, well-understood, uses standard kernel APIs, and has
been reviewed/acked by the subsystem maintainer. The pattern was already
proven in the rtw89 driver. It meets all stable kernel criteria.

**YES**

 drivers/net/wireless/realtek/rtw88/main.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 361ce0d40956d..2004d714530a3 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1661,11 +1661,13 @@ static u16 rtw_get_max_scan_ie_len(struct rtw_dev *rtwdev)
 static void rtw_set_supported_band(struct ieee80211_hw *hw,
 				   const struct rtw_chip_info *chip)
 {
-	struct rtw_dev *rtwdev = hw->priv;
 	struct ieee80211_supported_band *sband;
+	struct rtw_dev *rtwdev = hw->priv;
+	struct device *dev = rtwdev->dev;
 
 	if (chip->band & RTW_BAND_2G) {
-		sband = kmemdup(&rtw_band_2ghz, sizeof(*sband), GFP_KERNEL);
+		sband = devm_kmemdup(dev, &rtw_band_2ghz, sizeof(*sband),
+				     GFP_KERNEL);
 		if (!sband)
 			goto err_out;
 		if (chip->ht_supported)
@@ -1674,7 +1676,8 @@ static void rtw_set_supported_band(struct ieee80211_hw *hw,
 	}
 
 	if (chip->band & RTW_BAND_5G) {
-		sband = kmemdup(&rtw_band_5ghz, sizeof(*sband), GFP_KERNEL);
+		sband = devm_kmemdup(dev, &rtw_band_5ghz, sizeof(*sband),
+				     GFP_KERNEL);
 		if (!sband)
 			goto err_out;
 		if (chip->ht_supported)
@@ -1690,13 +1693,6 @@ static void rtw_set_supported_band(struct ieee80211_hw *hw,
 	rtw_err(rtwdev, "failed to set supported band\n");
 }
 
-static void rtw_unset_supported_band(struct ieee80211_hw *hw,
-				     const struct rtw_chip_info *chip)
-{
-	kfree(hw->wiphy->bands[NL80211_BAND_2GHZ]);
-	kfree(hw->wiphy->bands[NL80211_BAND_5GHZ]);
-}
-
 static void rtw_vif_smps_iter(void *data, u8 *mac,
 			      struct ieee80211_vif *vif)
 {
@@ -2320,10 +2316,7 @@ EXPORT_SYMBOL(rtw_register_hw);
 
 void rtw_unregister_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 {
-	const struct rtw_chip_info *chip = rtwdev->chip;
-
 	ieee80211_unregister_hw(hw);
-	rtw_unset_supported_band(hw, chip);
 	rtw_debugfs_deinit(rtwdev);
 	rtw_led_deinit(rtwdev);
 }
-- 
2.51.0


