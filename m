Return-Path: <linux-wireless+bounces-23647-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3385DACD3EA
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAFCC188B71E
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 01:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96D9265CC5;
	Wed,  4 Jun 2025 01:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KY51gxLa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF66265CBE;
	Wed,  4 Jun 2025 01:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998970; cv=none; b=tlDyxWkCXTD/Mix3K83wuPi1pp6ts4f69Vjsn3DPN30P112VBl+9kbOBaJM/hho6uGdtwnJBcj3wOIfNVsmrWdbJYg1WfIxe3QpSYswGwINBK78UznPjc1LVrr/F+Rvk2YLTytl0Bk788pt1hCdCka7MrC2i5Hk85G1skM4XtJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998970; c=relaxed/simple;
	bh=XpBTO9Iuai9lsQRyiIPzIVDyVxvotp6po9asB3bbB6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YmrvgZywMpfcBlbpUzoGyZVsUyzIyOTfzMT6U47X2BvvVTs9Ly5FQIaMyYSL6ZPdBYMH58KPb776dRlCmjSdEeI638GFIOAmD97L+dUfHdUnpgxC//cyuS9xNA1LKcVqMnGJwftvWY2P08sQ+c7PabRZmxPhhu4HMJojzmmXrLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KY51gxLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D2AC4CEEF;
	Wed,  4 Jun 2025 01:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998970;
	bh=XpBTO9Iuai9lsQRyiIPzIVDyVxvotp6po9asB3bbB6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KY51gxLa+Pm+bCGcAbFTWJ+We88XvtQm36g11uGU98lokHGlivvb7QCTtsTEqwr1S
	 eCr7DDko8AOAUFY8VXCdHReL5CkSXyZySN+4gbA7J0by5RIIeiDYew/b3XVldT6BNS
	 WJiKzOD5C9vtVNwYkk9fe0dUHmpWvCuPTHxca/bVjw1DRepXL6jDS6hyL3q3/SwX1b
	 SNJdG3xpTU/4Vb5DUZ/GbZCt1gXaLbm3+R2i1Hg2FBk3/mDlyLLY2zze5lxzanBKJP
	 WBskSpDkIji1HUqduwrIsZ622pAiWTXVnpvTzD4NOw/kohTdZN2nMw6MZcwyC4kI17
	 wdeSXCsTP2ULQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Dian-Syuan Yang <dian_syuan0116@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 19/62] wifi: rtw89: leave idle mode when setting WEP encryption for AP mode
Date: Tue,  3 Jun 2025 21:01:30 -0400
Message-Id: <20250604010213.3462-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604010213.3462-1-sashal@kernel.org>
References: <20250604010213.3462-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.92
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
index f5301c2bbf133..9a0ffaddb8360 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -6,6 +6,7 @@
 #include "debug.h"
 #include "fw.h"
 #include "mac.h"
+#include "ps.h"
 
 static struct sk_buff *
 rtw89_cam_get_sec_key_cmd(struct rtw89_dev *rtwdev,
@@ -333,9 +334,11 @@ int rtw89_cam_sec_key_add(struct rtw89_dev *rtwdev,
 
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


