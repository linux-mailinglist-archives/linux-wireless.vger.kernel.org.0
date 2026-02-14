Return-Path: <linux-wireless+bounces-31872-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BxjFVLqkGkfdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31872-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:34:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E791413DA27
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92DFE3074F05
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0338030FF06;
	Sat, 14 Feb 2026 21:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6RPSoDa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D405F27510B;
	Sat, 14 Feb 2026 21:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104452; cv=none; b=JrPo0weuRULXHQ4XeI1ew/9PBt/DLZikifmTB1dnYJAcXIo+xfNv8WyDDlJtyHTjD0/iao9WJDnzcllQxSoImk6xsojUSxhe42egWoZuE+szEiaR2uJazzb1224sZa9C4uA/0kzyR88ejuAZhzWdbNBJbpGvFkV9PAOD0KY34Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104452; c=relaxed/simple;
	bh=KIpW/QWm8QB7AEFRsEX0RtcVSCPtTL5XdTOSuQxBPbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aPYQfx2ldZAW23ueNh5yNiB0NIlQciciTMFWBZHjOw/tB8pBIcVKf+y4Yo5nYMdksQBnL2QMA7iBFqZUsmjl27fxwoDIkPnvMKWyGr1L7fXHwteCFEvbyJhFw00b+DY+J1wS41+JLebn00y3+n0rhH0Z73Cz1q8EYzxhRtaFkhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6RPSoDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1571FC19422;
	Sat, 14 Feb 2026 21:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104452;
	bh=KIpW/QWm8QB7AEFRsEX0RtcVSCPtTL5XdTOSuQxBPbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u6RPSoDa4hLLLtsgixh3H2/ntDan9oHF46YtbYsMYvjuRhQwOmIt972d0yKrq4jKM
	 OuMEGYUOQoyNlNxjftDT0sya4WAEnrvximiWnA49zLf04CAUjUUOPGEfYUJZjmNZvR
	 pwjyBIoNAiDMEeJ7/PTKBlordCjzpy8F+AixwXZqAlm60G1jM73SirJNsJQQ6Qna7n
	 ktM0Fi3jPjqLalTWdvmtiFpXQdFNUPXSn4zCtUi79JH8oiEBCrnyvL/FMrH+0ySC8h
	 vhGyLCvaJzol0V2mjvPfd7H1fNjRrSDs+F1kp6vr23AYON2Bt8A6DM3McOocUxpzBw
	 80s0vn0Bjf93w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kuan-Chung Chen <damon.chen@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.18] wifi: rtw89: fix potential zero beacon interval in beacon tracking
Date: Sat, 14 Feb 2026 16:23:58 -0500
Message-ID: <20260214212452.782265-93-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-31872-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email,msgid.link:url]
X-Rspamd-Queue-Id: E791413DA27
X-Rspamd-Action: no action

From: Kuan-Chung Chen <damon.chen@realtek.com>

[ Upstream commit eb57be32f438c57c88d6ce756101c1dfbcc03bba ]

During fuzz testing, it was discovered that bss_conf->beacon_int
might be zero, which could result in a division by zero error in
subsequent calculations. Set a default value of 100 TU if the
interval is zero to ensure stability.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20251231090647.56407-11-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis of commit: "wifi: rtw89: fix potential zero beacon interval
in beacon tracking"

### 1. COMMIT MESSAGE ANALYSIS

The subject line explicitly says "fix" and describes a concrete bug:
**division by zero** when `beacon_int` is zero. The commit message
mentions this was found during **fuzz testing**, which is analogous to
syzbot/syzkaller findings — these are reproducible, real bugs. The
author is from Realtek (the hardware vendor), and the commit was signed
off by the subsystem maintainer (Ping-Ke Shih).

### 2. CODE CHANGE ANALYSIS

The patch makes two related changes:

**Change 1: `rtw89_core_bcn_track_assoc()`**
```c
- beacon_int = bss_conf->beacon_int;
+ beacon_int = bss_conf->beacon_int ?: 100;
```
This uses the GCC ternary shorthand to default to 100 TU if `beacon_int`
is zero. The value 100 TU is a reasonable default (standard beacon
interval). Without this, `beacon_int = 0` flows into:
- `beacons_in_period = period / beacon_int / dtim;` — **division by
  zero**
- `bcn_intvl_us = ieee80211_tu_to_usec(beacon_int);` which becomes 0,
  leading to another division by zero later in `rtw89_vif_rx_bcn_stat()`

**Change 2: `rtw89_vif_rx_bcn_stat()` refactored**
- The function signature drops the `bss_conf` parameter and instead
  reads `beacon_int` from `bcn_track->beacon_int` (which was already set
  with the safe default in the assoc function).
- Adds an explicit guard: `if (!bcn_intvl_us) return;` to handle the
  case where association hasn't happened yet.
- This prevents `div_u64_rem(tsf - append, bcn_intvl_us, ...)` from
  dividing by zero.

**Change 3: Call site update**
```c
- rtw89_vif_rx_bcn_stat(rtwdev, bss_conf, skb);
+ rtw89_vif_rx_bcn_stat(rtwdev, skb);
```
Simply adapts the caller to the new signature.

### 3. BUG CLASSIFICATION

This is a **division by zero** bug — a crash/panic-class issue. On most
kernel configurations, division by zero causes an **Oops or kernel
panic**. This is clearly a real bug that affects system stability.

The bug was found through fuzz testing, meaning there is a concrete
trigger path. While the exact fuzz scenario may be unusual in normal
operation, the `bss_conf->beacon_int` being zero is a real possibility
(malformed beacon frames, race conditions during association, etc.).

### 4. SCOPE AND RISK ASSESSMENT

- **Lines changed**: ~15 lines of actual logic change — very small and
  surgical
- **Files changed**: 1 file
  (`drivers/net/wireless/realtek/rtw89/core.c`)
- **Subsystem**: WiFi driver (rtw89) — contained to one driver
- **Risk**: Very low. The changes are:
  - A defensive default value (100 TU is standard)
  - A guard check for zero before division
  - Using already-stored `bcn_track->beacon_int` instead of re-reading
    from `bss_conf`
- **Regression potential**: Minimal. The only behavioral change is
  preventing a crash and using a sensible default.

### 5. USER IMPACT

The rtw89 driver supports Realtek WiFi chips (RTL8852A, RTL8852B,
RTL8852C, RTL8922A, etc.) which are widely used in modern laptops and
desktops. A kernel crash/panic from a division by zero would be severe
for any user of these chips. Even if the trigger requires unusual beacon
conditions, malicious actors could potentially craft beacon frames to
trigger this remotely.

### 6. STABLE CRITERIA CHECK

- **Obviously correct and tested**: Yes — simple defensive coding, from
  the hardware vendor
- **Fixes a real bug**: Yes — division by zero causing kernel crash
- **Important issue**: Yes — kernel crash/panic
- **Small and contained**: Yes — ~15 lines in one file
- **No new features**: Correct — purely a bug fix
- **No new APIs**: Correct

### 7. DEPENDENCY CHECK

The `rtw89_vif_rx_bcn_stat()` function signature change means the patch
needs to apply as a unit, but it's self-contained within this single
commit. The beacon tracking infrastructure (`bcn_track`) must exist in
the stable tree. This was added relatively recently, so it may only
apply to very recent stable branches. However, if the code exists, this
fix applies cleanly.

### 8. CONCLUSION

This is a clear-cut bug fix: it prevents a division-by-zero kernel crash
in a widely-used WiFi driver. The fix is small, surgical, obviously
correct, and comes from the hardware vendor. It meets all stable kernel
criteria.

**YES**

 drivers/net/wireless/realtek/rtw89/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 0824940c91aee..d5b492ea76ef4 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2785,7 +2785,7 @@ static void rtw89_core_bcn_track_assoc(struct rtw89_dev *rtwdev,
 
 	rcu_read_lock();
 	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
-	beacon_int = bss_conf->beacon_int;
+	beacon_int = bss_conf->beacon_int ?: 100;
 	dtim = bss_conf->dtim_period;
 	rcu_read_unlock();
 
@@ -2815,9 +2815,7 @@ static void rtw89_core_bcn_track_reset(struct rtw89_dev *rtwdev)
 	memset(&rtwdev->bcn_track, 0, sizeof(rtwdev->bcn_track));
 }
 
-static void rtw89_vif_rx_bcn_stat(struct rtw89_dev *rtwdev,
-				  struct ieee80211_bss_conf *bss_conf,
-				  struct sk_buff *skb)
+static void rtw89_vif_rx_bcn_stat(struct rtw89_dev *rtwdev, struct sk_buff *skb)
 {
 #define RTW89_APPEND_TSF_2GHZ 384
 #define RTW89_APPEND_TSF_5GHZ 52
@@ -2826,7 +2824,7 @@ static void rtw89_vif_rx_bcn_stat(struct rtw89_dev *rtwdev,
 	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
 	struct rtw89_beacon_stat *bcn_stat = &rtwdev->phystat.bcn_stat;
 	struct rtw89_beacon_track_info *bcn_track = &rtwdev->bcn_track;
-	u32 bcn_intvl_us = ieee80211_tu_to_usec(bss_conf->beacon_int);
+	u32 bcn_intvl_us = ieee80211_tu_to_usec(bcn_track->beacon_int);
 	u64 tsf = le64_to_cpu(mgmt->u.beacon.timestamp);
 	u8 wp, num = bcn_stat->num;
 	u16 append;
@@ -2834,6 +2832,10 @@ static void rtw89_vif_rx_bcn_stat(struct rtw89_dev *rtwdev,
 	if (!RTW89_CHK_FW_FEATURE(BEACON_TRACKING, &rtwdev->fw))
 		return;
 
+	/* Skip if not yet associated */
+	if (!bcn_intvl_us)
+		return;
+
 	switch (rx_status->band) {
 	default:
 	case NL80211_BAND_2GHZ:
@@ -2921,7 +2923,7 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 		pkt_stat->beacon_rate = desc_info->data_rate;
 		pkt_stat->beacon_len = skb->len;
 
-		rtw89_vif_rx_bcn_stat(rtwdev, bss_conf, skb);
+		rtw89_vif_rx_bcn_stat(rtwdev, skb);
 	}
 
 	if (!ether_addr_equal(bss_conf->addr, hdr->addr1))
-- 
2.51.0


