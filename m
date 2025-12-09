Return-Path: <linux-wireless+bounces-29612-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED75CAE8A6
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Dec 2025 01:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 713973114FB1
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Dec 2025 00:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902E92FE57C;
	Tue,  9 Dec 2025 00:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cgl1NqBw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665532FE575;
	Tue,  9 Dec 2025 00:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765239504; cv=none; b=UvOkOMjbEBUsONNBVrH/npnzjIU1F4JD/ZpkaiDPgaQjba+NhE+lzVenHSKc01Mm1rxpntoB55/RkV8s6aYS/oUK79VG6mPib81kxeN80RKG9iJCf34Xp20gbZ5iFlfDinRkD+Kagq2h+JyLH/x748xSa+P/wlJy+9YPb3fG5WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765239504; c=relaxed/simple;
	bh=XpKHAEixGzYXqzWImy4xf3ogx25ptVRFnWcBtm/70Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bz+eU++BGeazAZS+I7BQLjY9IltgG+E8cX5DUvUmj/mH1PdJjD/qQOHR6UmspemHK1eSqJD3DArseOU1OZKCDPtK/3fkxdiA2a21D9SLg6rxP7I09waLsa5YpYgDYrhkwdTIK82qAErqFOUc8eE0bAmozm0mi0/FfbST1T7Ux/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cgl1NqBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBF8C19421;
	Tue,  9 Dec 2025 00:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765239504;
	bh=XpKHAEixGzYXqzWImy4xf3ogx25ptVRFnWcBtm/70Vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cgl1NqBwSUVCa+qgh9WjTtbWF5vtPtO/5lGYYbXfP4jPojXEsEdu/CC9jODxC1bJq
	 /iRVAwd85ImmAWBHdOLd71qBh/m9CuQyPrbv2UZEvZEGFZMM4B7DRK3I+hgQMrLrin
	 TXvKZ+Zx5W7Yk+kZ8kHwvfYJBZBq8zxayEzQcnqrdAUDlTmtXYxWu8oAFfhFuXO+km
	 rIKSzkIQaatabMrElp4/mfww3YKYQKZoBrisV1nLp2dtLxewV7gZENw5Qfp8YjZlWY
	 NU/HxOZqMKvGXkvONu86JozAzzwk9nvPWqzj2tFh+rENmEy7KTT1O3z9ezhXv6+bd6
	 w/Q5zeARW0I5A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Chih-Kang Chang <gary.chang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.1] wifi: rtw89: flush TX queue before deleting key
Date: Mon,  8 Dec 2025 19:15:36 -0500
Message-ID: <20251209001610.611575-44-sashal@kernel.org>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

[ Upstream commit 3a12581fc292997f5ca6dafe3238afd39b77e798 ]

In the wpa_supplicant rekey flow, it sends an EAPOL packet 4/4 through
nl80211_tx_control_port() and triggers wake_tx_queue() in the driver.
Then, it sends nl80211_new_key() to configure a new key in mac80211.
However, in wake_tx_queue(), a workqueue is used to process the TX packet,
which might cause the driver to process the EAPOL packet later than
nl80211_new_key(). This results in the EAPOL packet 4/4 being transmitted
with the new key and IV, causing it to be dropped by the AP. Therefore,
needs to flush TX queue before deleting the old key to ensure that the
EAPOL 4/4 packet is transmitted using the old key.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20251114060128.35363-2-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## 3. CLASSIFICATION

**Type:** Bug fix - Race condition in WPA rekey flow

**User Impact:** WPA rekeying failures, causing:
- WiFi authentication failures
- Connection drops during normal operation
- Poor user experience on networks that perform rekeying

This is a **functional bug**, not a security vulnerability - it causes
legitimate authentication packets to be dropped.

## 4. SCOPE AND RISK ASSESSMENT

- **Lines changed:** 1 line added
- **Files touched:** 1 file (mac80211.c)
- **Complexity:** Very low

**Pattern already exists in the driver:**
Looking at `ps.c:65`, the same `flush_work(&rtwdev->txq_work)` pattern
is already used before power mode changes. This fix applies the same
proven pattern to key deletion.

**Risk:** Very low - the fix:
- Uses well-understood kernel API (`flush_work()`)
- Follows existing driver patterns
- Only adds a synchronization point, doesn't change logic

## 5. DEPENDENCY CHECK

- `txq_work` has existed since the rtw89 driver was first introduced
  (commit e3ec7017f6a20 in October 2021, kernel 5.16)
- The `set_key` function with the `DISABLE_KEY` path also exists since
  driver inception
- No dependencies on other commits

## 6. STABILITY INDICATORS

**Pros:**
- Simple, obvious fix using well-established pattern
- Clear understanding of the race condition
- Signed off by Realtek developers who maintain this driver

**Cons:**
- No `Cc: stable@vger.kernel.org` tag
- No `Fixes:` tag
- Relatively new commit (November 2025)
- No Tested-by or Reviewed-by tags

## 7. SUMMARY

| Criteria | Assessment |
|----------|------------|
| Fixes real bug | ✅ Yes - WPA rekey failure causing connection issues |
| Obviously correct | ✅ Yes - follows existing pattern, minimal change |
| Small and contained | ✅ Yes - 1 line |
| No new features | ✅ Yes - pure bug fix |
| Stable tag | ❌ No explicit request from maintainer |
| Fixes tag | ❌ Missing |
| Risk | ✅ Very low |
| Dependencies | ✅ None - uses existing infrastructure |

## CONCLUSION

This commit **should be backported** to stable. Despite the lack of
explicit stable tags, it meets all the technical criteria for stable
inclusion:

1. **Fixes a real, user-visible bug** - WPA rekeying failures cause
   authentication problems
2. **Extremely minimal change** - just one line that adds a
   `flush_work()` call
3. **Uses proven pattern** - identical pattern already exists in `ps.c`
4. **Low risk** - synchronization-only change that cannot break existing
   functionality
5. **No dependencies** - the `txq_work` structure has existed since the
   driver was introduced

The fix ensures EAPOL 4/4 packets are transmitted with the correct key
during WPA rekeying, which is essential for proper WiFi operation. The
change is surgical and follows established patterns in the driver.

**YES**

 drivers/net/wireless/realtek/rtw89/mac80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 7b04183a3a5dd..064bae533bceb 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -954,6 +954,7 @@ static int rtw89_ops_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		}
 		break;
 	case DISABLE_KEY:
+		flush_work(&rtwdev->txq_work);
 		rtw89_hci_flush_queues(rtwdev, BIT(rtwdev->hw->queues) - 1,
 				       false);
 		rtw89_mac_flush_txq(rtwdev, BIT(rtwdev->hw->queues) - 1, false);
-- 
2.51.0


