Return-Path: <linux-wireless+bounces-28262-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9EDC09A1F
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 18:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CAF3547AD8
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 16:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DDC2FCC1A;
	Sat, 25 Oct 2025 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plBem8Gj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3825C30DD36;
	Sat, 25 Oct 2025 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409441; cv=none; b=hBFCafLu+ha3ADlE5HTtuI3VT807Y4Dt4EijeApB6oKgjCyFgwxQiIIGrrygHkdZMo7Dj0a4lGYbGljlbjRH7jgODN7YWuvdvVxrUnS/FPDbXk2HlCpYaCy3issMfczPN2ur6Wn1OoHpkUlclpMoZFrGJuuxU0ukzX9f9qBhRPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409441; c=relaxed/simple;
	bh=e3Ams2jiJHk4xSiHYOXE6jS58LCiDT3q49LTvoyBlJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMhMErf2j3SQZTZ5sWUPmWTBKhHwoT0KJssIztU9KBb3ZdTnAqkuaMh18+OH6GdVxKGsZoW4aaQUyfbvrDXfBisznZZHeMLZEz2m7vpQWmhoG4k23Hq4viTwv8+W0Og563XblP8CavS/ePtwAnVEbK9ggCfC63yRCO4lSBfF7vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plBem8Gj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629A6C4CEFF;
	Sat, 25 Oct 2025 16:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409441;
	bh=e3Ams2jiJHk4xSiHYOXE6jS58LCiDT3q49LTvoyBlJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=plBem8Gj33Nj8YKMAr7VJSc+9CzViTnl+Om2+fUHUkSV7idVnH2PHg1nM1VATiZIq
	 MKFDfoRcXwOdncR+md+Gc9yk9yAXUI5kRLd37UfPqvfiCy+/RiYVZuQYOvmL0DtJ08
	 fgCenjmhQRuwU7wjFhqdVerQBRY9MyAm+lYeWFPiF7Kh1s1BzzL2kXZapFBNcFybyB
	 Pb2VlgCzfhLEVzr8QujIQtPHnEJNQj2GMVlwMzb99lpYmnJ4K7oVsEUmcA0K+Srw1Z
	 +J4OEbDvDy+lYxafvfSk7t+7Y/CFp4gD6pvcJ4h9GoCtXsBIOXNEmyIZVwyrdS8yjc
	 TkbJgATF+Icaw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.12] wifi: rtw89: print just once for unknown C2H events
Date: Sat, 25 Oct 2025 11:59:18 -0400
Message-ID: <20251025160905.3857885-327-sashal@kernel.org>
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

[ Upstream commit 7e1c44fe4c2e1e01fa47d9490893d95309a99687 ]

When driver receives new or unknown C2H events, it print out messages
repeatedly once events are received, like

  rtw89_8922ae 0000:81:00.0: PHY c2h class 2 not support

To avoid the thousands of messages, use rtw89_info_once() instead. Also,
print out class/func for unknown (undefined) class.

Reported-by: Sean Anderson <sean.anderson@linux.dev>
Closes: https://lore.kernel.org/linux-wireless/20250729204437.164320-1-sean.anderson@linux.dev/
Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250804012234.8913-2-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

Why this is a good stable backport
- Fixes real user pain (log flooding): The current rtw89 driver logs an
  info message for every unknown/unhandled C2H event, leading to
  “thousands of messages” per the commit message. In-tree code shows
  exactly this behavior:
  - `drivers/net/wireless/realtek/rtw89/mac.c:5535` prints “MAC c2h
    class %d not support” and returns for every unknown class;
    `drivers/net/wireless/realtek/rtw89/mac.c:5539` prints “MAC c2h
    class %d func %d not support”.
  - `drivers/net/wireless/realtek/rtw89/phy.c:3128` prints “PHY c2h
    class %d not support”;
    `drivers/net/wireless/realtek/rtw89/phy.c:3132` prints “PHY c2h
    class %d func %d not support”.
  This can flood dmesg/syslog when firmware repeatedly sends such
events, crowding out important logs and consuming resources. Reducing
this to a single print per callsite is a tangible bugfix for system
reliability and observability.
- Minimal and contained change:
  - Adds a single helper macro mapping to a long‑standing kernel
    facility: `rtw89_info_once` → `dev_info_once` in
    `drivers/net/wireless/realtek/rtw89/debug.h` near `rtw89_info` (see
    `drivers/net/wireless/realtek/rtw89/debug.h:58`). `dev_info_once` is
    widely available (see `include/linux/dev_printk.h:204`), so no
    portability concerns across stable series.
  - In both handlers, shifts unknown/unsupported printing into the
    common “no handler” path and uses `rtw89_info_once`:
    - For MAC: stops logging in the switch `default:` and instead logs
      once when `handler == NULL` with class/func, then returns.
      Behavior remains identical (unknowns are dropped), but message
      prints once instead of per-event.
    - For PHY: same pattern—remove per-event `default:` logging and
      replace the final “no handler” print with `rtw89_info_once`
      showing class/func.
  - No data path, timing, locking, or ABI changes; only logging behavior
    is touched.
- Low regression risk:
  - Control flow remains the same for unknown events: they are ignored
    after a single informational notice. Previously an unknown class
    returned early after printing; now it falls through and returns at
    the `!handler` check. Since `handler` is `NULL` for unknowns, the
    net effect is the same.
  - `dev_info_once` is per callsite, preventing floods while still
    signaling the condition once.
- Aligns with stable policy: This is a focused, risk‑free improvement
  that prevents severe kernel log spam, a class of fixes commonly
  accepted into stable when the noise can degrade system usability or
  mask other issues. It is confined to the rtw89 driver and does not
  introduce features or architectural changes.
- Reported and reviewed: The patch addresses a real report
  (Closes/Reported-by in the message), with a clear rationale and
  review, indicating practical relevance.

Notes for backporting
- Context differences: Some older branches (e.g.,
  `drivers/net/wireless/realtek/rtw89/phy.c:3123-3126`) have a special-
  case return for `RTW89_PHY_C2H_CLASS_DM` with
  `RTW89_PHY_C2H_DM_FUNC_LOWRT_RTY`. The logging adjustment is still
  trivial: remove per-event prints in the switch `default:` and convert
  the final `!handler` print to `rtw89_info_once` with class/func. No
  functional behavior needs to change.
- No external dependencies: `dev_info_once` is present in the tree
  (`include/linux/dev_printk.h:204`), so introducing `rtw89_info_once`
  in `debug.h` is safe across stable series.

Summary of changes that matter
- Add `#define rtw89_info_once(rtwdev, a...)
  dev_info_once((rtwdev)->dev, ##a)` next to `rtw89_info`
  (drivers/net/wireless/realtek/rtw89/debug.h:58).
- In `rtw89_mac_c2h_handle`, stop printing in the `default:` and instead
  log once in the `if (!handler)` block with class/func and return
  (drivers/net/wireless/realtek/rtw89/mac.c:5535, 5539).
- In `rtw89_phy_c2h_handle`, same pattern: remove per-event `default:`
  log and use `rtw89_info_once` with class/func in the `!handler` block
  (drivers/net/wireless/realtek/rtw89/phy.c:3128, 3132).

Given the concrete reduction of harmful log spam, tiny and contained
code deltas, and zero behavioral risk, this is a solid candidate for
stable backport.

 drivers/net/wireless/realtek/rtw89/debug.h | 1 +
 drivers/net/wireless/realtek/rtw89/mac.c   | 7 +++----
 drivers/net/wireless/realtek/rtw89/phy.c   | 7 +++----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.h b/drivers/net/wireless/realtek/rtw89/debug.h
index fc690f7c55dc7..a364e7adb0798 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.h
+++ b/drivers/net/wireless/realtek/rtw89/debug.h
@@ -56,6 +56,7 @@ static inline void rtw89_debugfs_deinit(struct rtw89_dev *rtwdev) {}
 #endif
 
 #define rtw89_info(rtwdev, a...) dev_info((rtwdev)->dev, ##a)
+#define rtw89_info_once(rtwdev, a...) dev_info_once((rtwdev)->dev, ##a)
 #define rtw89_warn(rtwdev, a...) dev_warn((rtwdev)->dev, ##a)
 #define rtw89_err(rtwdev, a...) dev_err((rtwdev)->dev, ##a)
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 5a5da9d9c0c5b..ef17a307b7702 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5813,12 +5813,11 @@ void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	case RTW89_MAC_C2H_CLASS_ROLE:
 		return;
 	default:
-		rtw89_info(rtwdev, "MAC c2h class %d not support\n", class);
-		return;
+		break;
 	}
 	if (!handler) {
-		rtw89_info(rtwdev, "MAC c2h class %d func %d not support\n", class,
-			   func);
+		rtw89_info_once(rtwdev, "MAC c2h class %d func %d not support\n",
+				class, func);
 		return;
 	}
 	handler(rtwdev, skb, len);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index d607577b353c6..01a03d2de3ffb 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3626,12 +3626,11 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			handler = rtw89_phy_c2h_dm_handler[func];
 		break;
 	default:
-		rtw89_info(rtwdev, "PHY c2h class %d not support\n", class);
-		return;
+		break;
 	}
 	if (!handler) {
-		rtw89_info(rtwdev, "PHY c2h class %d func %d not support\n", class,
-			   func);
+		rtw89_info_once(rtwdev, "PHY c2h class %d func %d not support\n",
+				class, func);
 		return;
 	}
 	handler(rtwdev, skb, len);
-- 
2.51.0


