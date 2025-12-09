Return-Path: <linux-wireless+bounces-29605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E66CAE770
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Dec 2025 01:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D00E9301CD8C
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Dec 2025 00:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949BE21ABAA;
	Tue,  9 Dec 2025 00:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1L6WM0c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696231A9B46;
	Tue,  9 Dec 2025 00:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765239396; cv=none; b=Uz0YU6grXmLqo5RjBGamlcI611UHLwTFnmRQVYuP9ppP4umgVWWW7H0N2XPWuhkYd/i0Pu8+JyuGwa3je6PPABpDSvJNeSlI8I0fBCDg78NSXn16tyKaxJpbHI64kL26Q+kfKrG4Ht4i5Xo+nGqqfAAxoIP2PtJlIqqZDBylKxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765239396; c=relaxed/simple;
	bh=3WeGAEZa8Aq5I0z4SfJDUYehCDb10tX39TFwjnnYEI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eAmuIECFUo4W7Vc9CH9cXDqLNdjkhpxHxGBUNG2xSi6jskr6rhW6I26ZEvJEmSt/ieDHZuQCl21LIGtRJ4fzCenUphws1O7ZAAaboAx0gOK/3xH/bk5RMdNx0YiSUeorjvY5+WIuwJkQBTo95HuF3mRnYefSYE8v35bUq/ikT4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1L6WM0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68FFC19421;
	Tue,  9 Dec 2025 00:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765239395;
	bh=3WeGAEZa8Aq5I0z4SfJDUYehCDb10tX39TFwjnnYEI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e1L6WM0cIQ/OXkTqSofiCQjCyHzWj+nu2R9iPOlOdqzBddM8eag1BfBGq9m2SqPGZ
	 T/xBzFD+LpKwqhwkjFHcjp3ZKAeryPi0PTPc7fCIsts0E2r9sysn70cBuUMbV92ILt
	 Xmnde/cs+vC1p7Blv+MAAyBzo2AvYLmdgtK5DQu053rIc009fmJrXKAdq8f5p1D10N
	 9DbciOay0aBWEkCst2hrMBgg+8ovYlPZFWx60TAkNhzERRnwKJZ3KnJSE5PphwjVLV
	 vVP5GVLZ+BMMzN7YHwUbzZZ3cwKZkjKR/mHQ4zWF9P58hIzkObosqqDu0ZZGZYOFNA
	 CzMyp2OYEtIFg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.17] wifi: rtw89: use skb_dequeue() for queued ROC packets to prevent racing
Date: Mon,  8 Dec 2025 19:14:54 -0500
Message-ID: <20251209001610.611575-2-sashal@kernel.org>
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

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit f44a9b14a78f1e2e2c57dbc1f1e93889ad2f6ac0 ]

TX task can enqueue ROC skb, but other tasks dequeue the skb. Using
skb_queue_walk_safe() without locking will cause potential racing.
Use skb_dequeue() with lock instead.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20251021133402.15467-3-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Conclusion

This commit is a **legitimate bug fix** for a race condition in the
rtw89 WiFi driver's ROC (Remain On Channel) packet handling. The race
occurs because `skb_queue_walk_safe()` traverses the queue without
holding the queue's internal lock, while concurrently the TX task may
add packets via `skb_queue_tail()`.

**The fix:**
- Replaces the unlocked iteration + separate unlink pattern with atomic
  `skb_dequeue()`
- Is small (net -8 lines), contained, and obviously correct
- Uses standard kernel idioms that are well-tested
- Has minimal regression risk

**Stable tree applicability:**
- Applies to kernel versions 6.4+ where the ROC functionality exists
- Does NOT apply to 6.1.y LTS (code doesn't exist)
- Code is identical in 6.6.y LTS and later versions

**Why YES despite missing stable tags:**
The fix meets all the technical criteria for stable backporting: it
fixes a real bug (race condition that could cause crashes), is small and
surgical, doesn't add features, and has very low regression risk. While
the maintainer didn't explicitly request stable backport, the bug is
clearly real and the fix is clearly correct. The absence of a `Cc:
stable` tag may simply indicate it wasn't considered urgent, not that it
shouldn't be backported.

**YES**

 drivers/net/wireless/realtek/rtw89/core.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 917b2adede61d..8b40cada4149e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3632,12 +3632,10 @@ void rtw89_core_free_sta_pending_roc_tx(struct rtw89_dev *rtwdev,
 					struct ieee80211_sta *sta)
 {
 	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
-	struct sk_buff *skb, *tmp;
+	struct sk_buff *skb;
 
-	skb_queue_walk_safe(&rtwsta->roc_queue, skb, tmp) {
-		skb_unlink(skb, &rtwsta->roc_queue);
+	while ((skb = skb_dequeue(&rtwsta->roc_queue)))
 		dev_kfree_skb_any(skb);
-	}
 }
 
 static void rtw89_core_stop_tx_ba_session(struct rtw89_dev *rtwdev,
@@ -3881,8 +3879,8 @@ static void rtw89_core_sta_pending_tx_iter(void *data,
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
 	struct rtw89_vif_link *target = data;
 	struct rtw89_vif_link *rtwvif_link;
-	struct sk_buff *skb, *tmp;
 	unsigned int link_id;
+	struct sk_buff *skb;
 	int qsel, ret;
 
 	rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
@@ -3895,9 +3893,7 @@ static void rtw89_core_sta_pending_tx_iter(void *data,
 	if (skb_queue_len(&rtwsta->roc_queue) == 0)
 		return;
 
-	skb_queue_walk_safe(&rtwsta->roc_queue, skb, tmp) {
-		skb_unlink(skb, &rtwsta->roc_queue);
-
+	while ((skb = skb_dequeue(&rtwsta->roc_queue))) {
 		ret = rtw89_core_tx_write(rtwdev, vif, sta, skb, &qsel);
 		if (ret) {
 			rtw89_warn(rtwdev, "pending tx failed with %d\n", ret);
-- 
2.51.0


