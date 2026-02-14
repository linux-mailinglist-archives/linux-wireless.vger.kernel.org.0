Return-Path: <linux-wireless+bounces-31856-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIwuNWjokGkOdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31856-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:26:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E8713D54B
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B22BC300D0F9
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FAD2D2486;
	Sat, 14 Feb 2026 21:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IImHk/lJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F1E30DD2F;
	Sat, 14 Feb 2026 21:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104354; cv=none; b=feirPW7hNZEG1+gMr+cUxqRns3jXFdzAMIWVuD2btMhMhr8YYa+CryyAHP5KdB5LyE7zCJPg2x5PxBsLOEksrDlp8TINaUkH+uVCrUrEMTfGskzjYh489OXs3Dj69M0+xvWOwp5CeAro2gCqGRQpnjqFM9kqJAhUG6uWmggkFZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104354; c=relaxed/simple;
	bh=xc+sAmT+c0jAo/RwbDeReUB05daqk4bQVQNnhsh+/6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quI+vcsncAK3YC9o35/eN/Cf4AihIZDRAfND4C7QvwdgxHUp9jiCkbmBycLZ+czTnCZJPTdUSMXhyLw0Hz5MyncE0SeCRzygtHFINchyJs/NJJjpx2AWOQm0Bds768VmV1PGn23EaNp5zkloHzxrKYlquQIZMK5WIeDA4uMVcPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IImHk/lJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893A6C19423;
	Sat, 14 Feb 2026 21:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104354;
	bh=xc+sAmT+c0jAo/RwbDeReUB05daqk4bQVQNnhsh+/6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IImHk/lJKlMTRewIsU/jwjL19oTdyPORZ4YCORS1erRA0kKl837x/OeOn6/QnAfy7
	 tMct4iIaf+dZ6uQB4y1o0pdi0Vmqkuyl6OgeZ4BMGn0grjeg7ZclOVHccOjX3zbWxr
	 QJM0XhT5Y7G3ZN+i61GyvycXPj/WZM5yZJENmEDs3ICDUPiYKIGjA2dg5VgEV0qL0U
	 7Dd0AIPvkinLiZ9xOSYCJ1VDtBaCuEVsaH7u90K5xpdXjJH5iSOhQcSUrhWlOX0Iay
	 LSVdkbHzhhLRZ0+G9qUZJwew1rERQ1J6t3r7iH8llnMXZ2tnLUbSN/VqWcHzm1zHKe
	 Mmu4knnQ3IOPQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.12] wifi: rtw88: Fix inadvertent sharing of struct ieee80211_supported_band data
Date: Sat, 14 Feb 2026 16:23:00 -0500
Message-ID: <20260214212452.782265-35-sashal@kernel.org>
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
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31856-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B6E8713D54B
X-Rspamd-Action: no action

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit fcac0f23d4d20b11014a39f8e2527cdc12ec9c82 ]

Internally wiphy writes to individual channels in this structure,
so we must not share one static definition of channel list between
multiple device instances, because that causes hard to debug
breakage.

For example, with two rtw88 driven devices in the system, channel
information may get incoherent, preventing channel use.

Copied from commit 0ae36391c804 ("wifi: rtw89: Fix inadverent sharing
of struct ieee80211_supported_band data").

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/e94ad653-2b6d-4284-a33c-8c694f88955b@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

This is a relevant finding: `devm_kmemdup_array()` was introduced in
v6.15 cycle (February 2025). This means for older stable trees (6.12.y,
6.6.y, 6.1.y, 5.15.y), this function won't exist and the backport would
need adaptation. However, this is a minor concern - it can be replaced
with `devm_kmemdup()` with a manual size calculation.

### 6. USER IMPACT

- **Affected users:** Anyone with two or more rtw88 WiFi adapters in
  their system (e.g., RTL8822CE + RTL8821CE, or built-in + USB adapter)
- **Symptom:** Channel information becomes corrupt; certain WiFi
  channels become unusable
- **Severity:** Medium-High. WiFi connectivity issues are significant
  for users
- **Driver popularity:** rtw88 supports many common Realtek WiFi chips
  (RTL8822BE, RTL8822CE, RTL8821CE, RTL8723DE) found in many laptops

### 7. DEPENDENCY CHECK

The main dependency concern is `devm_kmemdup_array()`, which was added
in v6.15. For older stable trees, this would need to be adapted
(trivially, by using `devm_kmemdup()` with `sband->n_channels *
sizeof(*sband->channels)` manually). The rest of the code is standard
and should exist in all stable trees that have the rtw88 driver.

### Summary

**What it fixes:** Data corruption bug where multiple rtw88 WiFi device
instances share the same static channel/bitrate arrays through shallow
copying. When one device's wiphy modifies channel data, it corrupts the
other device's data.

**Stable criteria met:**
- Obviously correct (deep copy instead of shallow copy)
- Fixes a real bug (channel data corruption with multiple devices)
- Small and contained (~30 new lines in one file)
- No new features
- Already proven pattern (same fix in rtw89)
- Acked by Realtek maintainer

**Risk:** Very low. The change only affects rtw88 driver initialization,
uses standard kernel APIs, and devres handles cleanup automatically.

**Concern:** `devm_kmemdup_array()` may need adaptation for older stable
trees, but this is a trivial mechanical change.

**YES**

 drivers/net/wireless/realtek/rtw88/main.c | 34 +++++++++++++++++++----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 2004d714530a3..e1de638164862 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1658,16 +1658,41 @@ static u16 rtw_get_max_scan_ie_len(struct rtw_dev *rtwdev)
 	return len;
 }
 
+static struct ieee80211_supported_band *
+rtw_sband_dup(struct rtw_dev *rtwdev,
+	      const struct ieee80211_supported_band *sband)
+{
+	struct ieee80211_supported_band *dup;
+
+	dup = devm_kmemdup(rtwdev->dev, sband, sizeof(*sband), GFP_KERNEL);
+	if (!dup)
+		return NULL;
+
+	dup->channels = devm_kmemdup_array(rtwdev->dev, sband->channels,
+					   sband->n_channels,
+					   sizeof(*sband->channels),
+					   GFP_KERNEL);
+	if (!dup->channels)
+		return NULL;
+
+	dup->bitrates = devm_kmemdup_array(rtwdev->dev, sband->bitrates,
+					   sband->n_bitrates,
+					   sizeof(*sband->bitrates),
+					   GFP_KERNEL);
+	if (!dup->bitrates)
+		return NULL;
+
+	return dup;
+}
+
 static void rtw_set_supported_band(struct ieee80211_hw *hw,
 				   const struct rtw_chip_info *chip)
 {
 	struct ieee80211_supported_band *sband;
 	struct rtw_dev *rtwdev = hw->priv;
-	struct device *dev = rtwdev->dev;
 
 	if (chip->band & RTW_BAND_2G) {
-		sband = devm_kmemdup(dev, &rtw_band_2ghz, sizeof(*sband),
-				     GFP_KERNEL);
+		sband = rtw_sband_dup(rtwdev, &rtw_band_2ghz);
 		if (!sband)
 			goto err_out;
 		if (chip->ht_supported)
@@ -1676,8 +1701,7 @@ static void rtw_set_supported_band(struct ieee80211_hw *hw,
 	}
 
 	if (chip->band & RTW_BAND_5G) {
-		sband = devm_kmemdup(dev, &rtw_band_5ghz, sizeof(*sband),
-				     GFP_KERNEL);
+		sband = rtw_sband_dup(rtwdev, &rtw_band_5ghz);
 		if (!sband)
 			goto err_out;
 		if (chip->ht_supported)
-- 
2.51.0


