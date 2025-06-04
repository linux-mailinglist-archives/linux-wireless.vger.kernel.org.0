Return-Path: <linux-wireless+bounces-23632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B52CACD2F7
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6FC3A2FC6
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 01:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB1E1F4281;
	Wed,  4 Jun 2025 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQNZZ3fk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A821F418F;
	Wed,  4 Jun 2025 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998813; cv=none; b=JKLhkGa75fs5i+u83+hpVB3nysNGwPZXj/YiOF4LDNT5xgwHnfMh85k3ltykoD5Ojwsrqw77ckCwRT9Ht6WKkY9og71bxoQB/q8tbOTW2L9DfyLSNqip6SWjqCvzgBiBV2ZDtuIpxpsXjgwBRkny/dp2RARW4Kfg6cwe+FCHung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998813; c=relaxed/simple;
	bh=VPizbeVo+AKNDOfXGGiiUq3pOFIHVCnuPIWO48yUAV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCNE9n/dMWgbazD/5sG6oNjKLcpnvfjKCQwimayIggLzw+SZKk3tC6gwOzNj+nM/nnGhl/KLVVV3+mLz9qvcpaM4PpWvgo/d9JnfaK+QA1Fediaok2P6nA0HtUuVXxagmZ/gUSsIXQGEbnv+PM+Ui/FVnvaQj3n9LFJt+c0kTVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQNZZ3fk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46024C4CEED;
	Wed,  4 Jun 2025 01:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998813;
	bh=VPizbeVo+AKNDOfXGGiiUq3pOFIHVCnuPIWO48yUAV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SQNZZ3fkO20vQt6ro4cZjFD+30u9oY1UDYV7i12LxlJp0u4ZxdhvqdK9kQbH9Acyq
	 TJIJWyQiJCpwGOzFQoPs5OJClsiwz9+9zsFHJTLeJg75rq4n0FHLUv2/qRbqBN3579
	 4UVdLsadmM9iy56JcsaL+w8/eRI46JiLRi42NClsK5658f2HuPfGi173yD2Rd3GgK/
	 S75cNM0LC1z/FdLSxYJAo19IOe/MM5pYhIiKosWrG3Q4uG6aUBA2tbV2DJaP64X1Af
	 7l7GKffKkTl3b+0rmLsOwD51FWYdOSzwSRHu6UgiGqXkFiMmCfuh1xIS2LZG7NDErD
	 tvPJmGnNW/HNg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Dian-Syuan Yang <dian_syuan0116@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 27/93] wifi: rtw89: leave idle mode when setting WEP encryption for AP mode
Date: Tue,  3 Jun 2025 20:58:13 -0400
Message-Id: <20250604005919.4191884-27-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005919.4191884-1-sashal@kernel.org>
References: <20250604005919.4191884-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.31
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Dian-Syuan Yang <dian_syuan0116@realtek.com>

[ Upstream commit d105652b33245162867ac769bea336976e67efb8 ]

Due to mac80211 triggering the hardware to enter idle mode, it fails
to install WEP key causing connected station can't ping successfully.
Currently, it forces the hardware to leave idle mode before driver
adding WEP keys.

Signed-off-by: Dian-Syuan Yang <dian_syuan0116@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250507031203.8256-1-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my extensive analysis: ## Bug Fix Analysis **Real User-Affecting Bug**:
The commit fixes a clear functional issue where WEP encryption key
installation fails in AP mode when the rtw89 wireless device is in idle
mode. This directly impacts users trying to establish WEP-encrypted
connections to an AP, causing authentication failures and preventing
network connectivity. **Specific Technical Problem**: When mac80211 puts
the hardware into idle mode (IPS - Idle Power Save), the rtw89
firmware/hardware enters a low-power state where key installation
operations fail. This is particularly problematic for WEP encryption
which appears to have specific hardware state requirements. ## Code
Change Analysis **Minimal and Targeted**: The fix adds exactly two lines
of code: ```c case WLAN_CIPHER_SUITE_WEP40:
rtw89_leave_ips_by_hwflags(rtwdev); // NEW hw_key_type =
RTW89_SEC_KEY_TYPE_WEP40; break; case WLAN_CIPHER_SUITE_WEP104:
rtw89_leave_ips_by_hwflags(rtwdev); // NEW hw_key_type =
RTW89_SEC_KEY_TYPE_WEP104; break; ``` **Uses Existing Infrastructure**:
The fix leverages the existing `rtw89_leave_ips_by_hwflags()` function,
which is a well-tested mechanism already used throughout the driver for
similar power management scenarios. **WEP-Specific Requirement**:
Notably, other cipher types (TKIP, CCMP, GCMP) don't require this call,
indicating WEP has unique hardware state dependencies - likely due to
its legacy implementation requiring specific firmware states. ## Risk
Assessment **Very Low Risk**: - The `rtw89_leave_ips_by_hwflags()`
function only acts when the hardware is actually in idle mode
(`IEEE80211_CONF_IDLE` flag set) - It's a conditional safety mechanism
that doesn't affect normal operation - Limited scope - only affects
WEP40/WEP104 cipher types - Follows established patterns already present
in the driver **No Architectural Changes**: This is purely a bug fix
that ensures hardware is in the correct state before performing WEP key
operations. ## Stable Tree Criteria Compliance **Meets All Stable
Requirements**: 1. ✅ **Important bug fix**: Resolves WEP authentication
failures in AP mode 2. ✅ **Small and contained**: Two identical function
calls in a switch statement 3. ✅ **Obviously correct**: Uses existing,
proven power management infrastructure 4. ✅ **Low regression risk**:
Conservative fix affecting only legacy WEP encryption 5. ✅ **User-
visible impact**: Fixes network connectivity issues ## Comparison with
Historical Commits Looking at the similar commits provided, this follows
the same pattern as other rtw88/rtw89 power management fixes that were
marked as "NO" for backporting. However, those commits were primarily
optimizations or behavior changes during scanning operations, not fixes
for broken functionality. This commit differs because: - It fixes a
**broken feature** (WEP key installation failure) - It's not an
optimization or behavioral change - It has direct user-visible impact
(connection failures) - It's a minimal, surgical fix for a specific
failure mode ## Conclusion This is a textbook example of a commit
suitable for stable backporting: it fixes a real bug affecting users,
uses minimal and safe code changes, and follows established driver
patterns. The fix ensures WEP encryption works properly in AP mode by
guaranteeing the hardware is powered up during key installation
operations.

 drivers/net/wireless/realtek/rtw89/cam.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 8d140b94cb440..0c8ea5e629e6a 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -6,6 +6,7 @@
 #include "debug.h"
 #include "fw.h"
 #include "mac.h"
+#include "ps.h"
 
 static struct sk_buff *
 rtw89_cam_get_sec_key_cmd(struct rtw89_dev *rtwdev,
@@ -447,9 +448,11 @@ int rtw89_cam_sec_key_add(struct rtw89_dev *rtwdev,
 
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
+		rtw89_leave_ips_by_hwflags(rtwdev);
 		hw_key_type = RTW89_SEC_KEY_TYPE_WEP40;
 		break;
 	case WLAN_CIPHER_SUITE_WEP104:
+		rtw89_leave_ips_by_hwflags(rtwdev);
 		hw_key_type = RTW89_SEC_KEY_TYPE_WEP104;
 		break;
 	case WLAN_CIPHER_SUITE_CCMP:
-- 
2.39.5


