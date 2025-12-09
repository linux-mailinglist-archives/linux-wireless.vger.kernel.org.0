Return-Path: <linux-wireless+bounces-29611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC89CAE8B2
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Dec 2025 01:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02D4B3086CF7
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Dec 2025 00:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81772E5402;
	Tue,  9 Dec 2025 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD9LfDi+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E28D2E370E;
	Tue,  9 Dec 2025 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765239487; cv=none; b=L5GIVAXfutHJLBG3UDumvjeTJ4OXSTmVqxTZfiyN3h/28VS7k8PCkIjiyB8++bQSdULHKU9R8OrjScEPArM5Su5pjyrwqTOimwOxkaTUgrUBKxJLbsekdQHzwe0HUKOqrhdEdRBgrBRHqt9MiDFH1coVnizQltVqF289eKL2XFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765239487; c=relaxed/simple;
	bh=1E52SU0XhxhmH0LjX9ze5vyc45B8H7RL6W44/GdTtww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcTpxttDv4fucfN4YCRedi3MJCG9RkAjFCw1+J1iDQZ1dyDBX02PDfovJ6S8Yt0AkdAr+7BT0MZCWeL/D0JrSReeD3EjJUu33HtNuqEALM9p8IDUrkp9aL9+P8M7oXaFX8/cRT+gLJBui/nub0kZHwW8EVS1krW2t+tt5DOMV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kD9LfDi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA4FC19421;
	Tue,  9 Dec 2025 00:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765239487;
	bh=1E52SU0XhxhmH0LjX9ze5vyc45B8H7RL6W44/GdTtww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kD9LfDi++dWHhMcJbPhseMz577o4fZIhMtmgbP8mi+NsYhCJLwViFJqj9hMoFLAPE
	 n9xrz5tdFho8tCIU+e/d0KimIqaJWa9UDE9zHbg71tp7t8MTJgwsz2f7GvqsjI2BbI
	 LCflxMFIQ18u/M/UNNY4efIeeuh9Jzqr9OSOqJnNA9p59nz72pMeq0EvBma9mW3ne4
	 PUiTHQHifr+rr8b5gEfgy7ellhS9X2Me6R6QvCHXlDUfL86AW6/Y+Y90kxukcfZutf
	 RxnNJZC8bAN6mU3KyrRabmet120V4YFumoSDMyybvgooLvXhXrHyo1nAFnQKGX3Tf9
	 iRSHtwXLKhKIA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kuan-Chung Chen <damon.chen@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.1] wifi: rtw89: phy: fix out-of-bounds access in rtw89_phy_read_txpwr_limit()
Date: Mon,  8 Dec 2025 19:15:30 -0500
Message-ID: <20251209001610.611575-38-sashal@kernel.org>
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
Content-Transfer-Encoding: 8bit

From: Kuan-Chung Chen <damon.chen@realtek.com>

[ Upstream commit 1dd7e743dd37361c8c1ac89355a8da738e2b81fb ]

Coverity reported a potential out-of-bounds access when 'bw' exceeds the
valid range for the specified band. Add a helper `rtw89_bw_is_valid()`
to check bandwidth validity for each band before accessing limit tables.

Addresses-Coverity-ID: 1598844 ("Out-of-bounds access")
Addresses-Coverity-ID: 1598896 ("Out-of-bounds access")

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20251111022452.28093-6-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis of Commit for Stable Backport

### 1. COMMIT MESSAGE ANALYSIS

- **Subject:** Clearly indicates a bug fix - "fix out-of-bounds access"
- **Bug Type:** Out-of-bounds array access (memory safety issue)
- **Source:** Coverity static analysis (IDs 1598844, 1598896)
- **No "Cc: stable@vger.kernel.org"** tag present
- **No "Fixes:" tag** pointing to original buggy commit

### 2. CODE CHANGE ANALYSIS

**The Bug:**
The function `rtw89_phy_read_txpwr_limit()` uses the `bw` (bandwidth)
parameter as an array index in expressions like:
```c
da_lmt = (*rule_da_2ghz->lmt)[bw][ntx][rs][bf][regd][ch_idx];
lmt = (*rule_2ghz->lmt)[bw][ntx][rs][bf][regd][ch_idx];
```

Different bands (2G, 5G, 6G) have different valid bandwidth ranges
(`RTW89_2G_BW_NUM`, `RTW89_5G_BW_NUM`, `RTW89_6G_BW_NUM`). If `bw`
exceeds the valid range for the specified band, an out-of-bounds array
read occurs.

**The Fix:**
1. Adds a new helper function `rtw89_phy_validate_txpwr_limit_bw()` that
   validates bandwidth against band-specific limits
2. Adds a validation check at the beginning of
   `rtw89_phy_read_txpwr_limit()` that returns 0 (safe default) if
   validation fails

**Technical Correctness:**
The fix is straightforward - validate input before using it as array
index. This is a defensive programming pattern that prevents OOB access.

### 3. CLASSIFICATION

- **Bug fix:** Yes - fixes memory safety bug (OOB read)
- **Feature addition:** No
- **Security relevant:** Potentially - OOB access can cause crashes,
  kernel panics, or information leaks

### 4. SCOPE AND RISK ASSESSMENT

| Factor | Assessment |
|--------|------------|
| Lines changed | ~20 lines added |
| Files touched | 1 file (phy.c) |
| Complexity | Low - simple validation check |
| Regression risk | Very low - only adds validation, no behavioral
change for valid inputs |
| Subsystem | rtw89 WiFi driver (Realtek 802.11ax) |

The change is **small and surgical**. It only adds bounds checking and
returns a safe default (0) for invalid inputs. Normal operation is
completely unaffected.

### 5. USER IMPACT

- **Affected users:** Users with Realtek rtw89 WiFi hardware
- **Severity if triggered:** Kernel crash/oops or potential information
  leak
- **Trigger conditions:** Invalid `bw` value exceeding band-specific
  limits
- **Real-world likelihood:** Uncertain - could be triggered by malformed
  firmware/hardware responses or bugs elsewhere in the driver

### 6. STABILITY INDICATORS

- Signed-off by Realtek engineers (maintainer-level confidence)
- No explicit tested-by or reviewed-by tags visible
- Has proper patch link for traceability

### 7. DEPENDENCY CHECK

The fix uses existing constants (`RTW89_*_BW_NUM`) that should exist in
any stable kernel with the rtw89 driver. The rtw89 driver was introduced
in kernel 5.16, so this applies to 6.1.y, 6.6.y, and newer stable
branches.

### DECISION RATIONALE

**For backporting:**
- Fixes a genuine memory safety bug (OOB array access)
- Small, self-contained fix with minimal regression risk
- Defensive in nature - only affects invalid input handling
- OOB access bugs can have security implications

**Against backporting:**
- No explicit "Cc: stable" tag from maintainers
- Coverity-found vs user-reported (no evidence of actual crashes in the
  wild)
- No "Fixes:" tag to identify the original buggy commit

**Verdict:**
Despite the lack of explicit stable tags, this is a legitimate memory
safety fix that:
1. Is obviously correct and small
2. Fixes a real bug (OOB access)
3. Has no risk of regression for valid code paths
4. Could prevent crashes or security issues

The fix meets stable kernel criteria: it's a small, self-contained bug
fix that addresses a real memory safety issue without changing normal
behavior. Out-of-bounds access bugs are the type of issues stable trees
should protect against.

**YES**

 drivers/net/wireless/realtek/rtw89/phy.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index ba7feadd75828..e8960fbcb72db 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2339,6 +2339,21 @@ static u8 rtw89_channel_to_idx(struct rtw89_dev *rtwdev, u8 band, u8 channel)
 	}
 }
 
+static bool rtw89_phy_validate_txpwr_limit_bw(struct rtw89_dev *rtwdev,
+					      u8 band, u8 bw)
+{
+	switch (band) {
+	case RTW89_BAND_2G:
+		return bw < RTW89_2G_BW_NUM;
+	case RTW89_BAND_5G:
+		return bw < RTW89_5G_BW_NUM;
+	case RTW89_BAND_6G:
+		return bw < RTW89_6G_BW_NUM;
+	default:
+		return false;
+	}
+}
+
 s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 			      u8 bw, u8 ntx, u8 rs, u8 bf, u8 ch)
 {
@@ -2363,6 +2378,11 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 	};
 	s8 cstr;
 
+	if (!rtw89_phy_validate_txpwr_limit_bw(rtwdev, band, bw)) {
+		rtw89_warn(rtwdev, "invalid band %u bandwidth %u\n", band, bw);
+		return 0;
+	}
+
 	switch (band) {
 	case RTW89_BAND_2G:
 		if (has_ant_gain)
-- 
2.51.0


