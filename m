Return-Path: <linux-wireless+bounces-31871-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPmuG03qkGkfdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31871-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:34:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E46AE13DA1F
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06D6630D4ECE
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9181311C15;
	Sat, 14 Feb 2026 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeTyUTdu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8633B313E0F;
	Sat, 14 Feb 2026 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104446; cv=none; b=qdoRQXOepEpvBdSEPlxrr7dpaymPOrbr+PKUQt1ZAHu6rfbhOhnYyKtXteEaC9Zhrx1WdQBQEtZAbzavQjwn3yLI6Jzcu/Pr/Q1O5lCOAgMcWnJ9XnCelZyGsXmos5fmK062gvEZ3xkHm82D1756cTdA1uUJ+6sSqZyZmtL5AMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104446; c=relaxed/simple;
	bh=lj9vwZCQHlT7d8sGFbR58OnAbzrYvN3VU5g4RsM2RD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwaA0KvOzFnwYNCBE8aaL+C28QvfHiqUuzdduiqdqXbOaQnFz0GDLtSm2WQzuN9gx5qW0YTgX9tmpM2fpJAbdkhOXOe62Fi/FxRTIEDGRCmpnBC3J0eC1f6rvhew0PnVbI5oRMzj1ZscsNNHhft28rxhaIzXbk0N4TSiOshkr1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeTyUTdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF759C16AAE;
	Sat, 14 Feb 2026 21:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104446;
	bh=lj9vwZCQHlT7d8sGFbR58OnAbzrYvN3VU5g4RsM2RD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JeTyUTdueAyCUQbPsbDGhqj1ub/zDBNyNCJj/NJnfpWLCu0CDzwU9hsMJaRGMgWWY
	 XE+q+Z1g3R1gKAeXdORhQp9OanLpWBfPE6P4+EFGq7WqUBKxLuCu9Ywe2k+bIi03c2
	 lDOWcEZVWNXRGqeS90ZSuJsdRIeWf9QvatFcvLM0Zz9ap8Q6QGk71Ne82g0Eov1hxK
	 N2oul/N2BjpeSlV5ssmIuirbwZc0PIZGCtfIMK1Y08y66TNYMf9hBeq8i+8yC1T2IT
	 wQzO+qrJYiSZKPxt5mIQxAou4qpHvlpfSmYuLfDFie2QRRib8Q3/xsA9aanjy1tcpp
	 31Hzal/Ylu8rQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.12] wifi: rtw89: 8922a: set random mac if efuse contains zeroes
Date: Sat, 14 Feb 2026 16:23:55 -0500
Message-ID: <20260214212452.782265-90-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-31871-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: E46AE13DA1F
X-Rspamd-Action: no action

From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

[ Upstream commit 41be33d3efc120f6a2c02d12742655f2aa09e1b6 ]

I have some rtl8922ae devices with no permanent mac stored in efuse.

It could be properly saved and/or configured from user tools like
NetworkManager, but it would be desirable to be able to initialize it
somehow to get the device working by default.

So, in the same way as with other devices, if the mac address read from
efuse contains zeros, a random mac address is assigned to at least allow
operation, and the user is warned about this in case any action needs to
be considered.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20251126091905.217951-1-jtornosm@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The rtw8922a driver was first included in kernel v6.8. This means it's
available in stable trees 6.8.y and later (and likely in 6.6.y LTS if it
was backported, but probably not).

### 8. OVERALL ASSESSMENT

**Arguments FOR backporting (YES):**
- Fixes a real hardware issue — devices with empty efuse are completely
  unusable without this
- Very small, contained change in a single file
- Well-established pattern used in rtw88 driver and other Realtek
  wireless drivers
- Low risk — only affects devices with all-zero MAC (no impact on
  working devices)
- Acked by subsystem maintainer
- Falls under "hardware quirk/workaround" category which is acceptable
  for stable

**Arguments AGAINST backporting (NO):**
- This is technically adding new functionality (random MAC generation)
  rather than fixing a bug in existing code
- The driver was working "as designed" — it just didn't handle the case
  of unprogrammed efuse
- It's not fixing a crash, corruption, or security issue — it's making
  broken hardware work
- The commit message describes this as a "desirable" improvement rather
  than a critical fix
- No Fixes: tag or Cc: stable (expected, but also suggests the author
  didn't consider it critical)

### DECISION

This is a borderline case. While the change is small and low-risk, it's
fundamentally adding new behavior (random MAC assignment) rather than
fixing a bug in existing code. The device doesn't crash without this —
it simply doesn't have a valid MAC address. This is closer to a
"hardware enablement" change than a bug fix.

However, I lean toward YES because:
1. It's a hardware workaround for broken/unprogrammed devices — this
   category is explicitly allowed in stable
2. Without it, the device is completely non-functional (a zero MAC
   address is invalid)
3. The risk is essentially zero for existing users
4. The pattern is proven across the Realtek driver family
5. It's a small, self-contained change

**YES**

 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 4437279c554b0..4bcf20612a455 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -636,16 +636,30 @@ static int rtw8922a_read_efuse_rf(struct rtw89_dev *rtwdev, u8 *log_map)
 static int rtw8922a_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
 			       enum rtw89_efuse_block block)
 {
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+	int ret;
+
 	switch (block) {
 	case RTW89_EFUSE_BLOCK_HCI_DIG_PCIE_SDIO:
-		return rtw8922a_read_efuse_pci_sdio(rtwdev, log_map);
+		ret = rtw8922a_read_efuse_pci_sdio(rtwdev, log_map);
+		break;
 	case RTW89_EFUSE_BLOCK_HCI_DIG_USB:
-		return rtw8922a_read_efuse_usb(rtwdev, log_map);
+		ret = rtw8922a_read_efuse_usb(rtwdev, log_map);
+		break;
 	case RTW89_EFUSE_BLOCK_RF:
-		return rtw8922a_read_efuse_rf(rtwdev, log_map);
+		ret = rtw8922a_read_efuse_rf(rtwdev, log_map);
+		break;
 	default:
-		return 0;
+		ret = 0;
+		break;
+	}
+
+	if (!ret && is_zero_ether_addr(efuse->addr)) {
+		rtw89_info(rtwdev, "efuse mac address is zero, using random mac\n");
+		eth_random_addr(efuse->addr);
 	}
+
+	return ret;
 }
 
 #define THM_TRIM_POSITIVE_MASK BIT(6)
-- 
2.51.0


