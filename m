Return-Path: <linux-wireless+bounces-31849-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NRpDwDpkGkadwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31849-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:28:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9212413D6E4
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21F87303C616
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCD828DB46;
	Sat, 14 Feb 2026 21:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfI28HH4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4293C2D;
	Sat, 14 Feb 2026 21:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104328; cv=none; b=rokV6idn2NydsT2eQtcxSR5w4/WthZb9Mz1gDHvKPHoZEVh5eGqfFW38XW9sbxRuDD51XOLOTkR0L8LFw+DhLOj/9z8E1yg+9UygD5KX2RRQeHZiJ7Bon7vRQAwqpY7iCWj+tty9X5coPzO74we9DTCzDx4aP3m1wDt2Op7HYMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104328; c=relaxed/simple;
	bh=Zg58RY5Vx2pbK9qID2LZfzUNpRROwehp88OQD3AliQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LfbjRx6LYRnoc6qUar7IR3dTNXqgJR2jWyyDvzXrxfbBlgijuPbNeAl4N4bdrlCorvHx6vUICBr1Fsxp+1pyNk7KgihwNYcOkAERxZ5ri7r1th75kAgzmY6DvKeIEBzcN/NSuW/DYeI+2rC32/jUhulQv1g8nnD8GKsk0e1iuAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfI28HH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFEBC19422;
	Sat, 14 Feb 2026 21:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104328;
	bh=Zg58RY5Vx2pbK9qID2LZfzUNpRROwehp88OQD3AliQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DfI28HH4MQp7hNchPmxGp7Y+hL8cI6G49PFuBP3fifapaCfgzrKWqeINp6JkmuxYq
	 9VFH4xqK2EuhRXu76VGt/tNUGU8G/t7HklwX9WYHb5rmzm5frGePUkwL9+dNcZ1cFQ
	 6sYjDUMFCTyleixMukBFLF9rs1B0pV5divSHD3bKQostBmE+aDMwpw0RCAybVlLYIV
	 0TMvjnbUUwjaAo9B+/n6LC/jUnFRVEesBajGo2rhnmHh68ibtsMzPdJ0600YFxMp9L
	 Voi0x974ZPZ+VR+Kj9hl12tUjkT3aSedxXg/ugQN91CnXQv85P7xk0M2xmfuywycmD
	 nRXPEwKyRUrjg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Chih-Kang Chang <gary.chang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.18] wifi: rtw89: setting TBTT AGG number when mac port initialization
Date: Sat, 14 Feb 2026 16:22:45 -0500
Message-ID: <20260214212452.782265-20-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31849-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 9212413D6E4
X-Rspamd-Action: no action

From: Chih-Kang Chang <gary.chang@realtek.com>

[ Upstream commit 5e5f83fba48381098b26a8b2513a6d5fc5c66ccb ]

When initializing mac port, needs to set TBTT AGG number to trigger TBTT
related interrupts. Otherwise, after sending join info H2C command with
disconnection mode, firmware will clear TBTT AGG number. Without the
setting from mac port initialization after that, this port will not be
able to transmit beacons.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20251223030651.480633-12-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The `tbtt_agg` field has been part of the port register structure since
the initial driver addition. The register mask `B_AX_TBTT_AGG_NUM_MASK`
also exists. This means all necessary infrastructure is already in
stable trees.

### User Impact

This affects users running the rtw89 WiFi driver (Realtek 802.11ax
cards) in AP mode or any mode that requires beacon transmission. After a
disconnect/reconnect cycle, beacons stop being transmitted, making the
wireless interface non-functional for AP operations. This is a
significant functionality loss.

### Assessment

**Meets stable criteria:**
- **Obviously correct**: The function follows the exact same trivial
  pattern as all other port config functions
- **Fixes a real bug**: Beacon transmission failure after
  disconnect/reconnect
- **Small and contained**: ~15 lines, 1 file, mechanical pattern
- **No new features**: This restores expected behavior (setting a
  hardware register during initialization)
- **No new APIs**: Internal driver change only
- **Low risk**: Uses existing register definitions and write helpers

**Concerns:**
- The commit is part of a series (patch 12 of a series based on the
  Link), but it appears self-contained - it only adds a new function and
  calls it. No dependencies on other patches in the series.
- The code is simple and the pattern is well-established in this driver.

The fix is small, surgical, restores critical WiFi AP functionality, and
follows established patterns in the driver. It meets all stable kernel
criteria.

**YES**

 drivers/net/wireless/realtek/rtw89/mac.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index b4c292c7e829d..6734e5d5a5e22 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4341,6 +4341,7 @@ static void rtw89_mac_bcn_drop(struct rtw89_dev *rtwdev,
 #define BCN_HOLD_DEF 200
 #define BCN_MASK_DEF 0
 #define TBTT_ERLY_DEF 5
+#define TBTT_AGG_DEF 1
 #define BCN_SET_UNIT 32
 #define BCN_ERLY_SET_DLY (10 * 2)
 
@@ -4644,6 +4645,16 @@ static void rtw89_mac_port_cfg_tbtt_early(struct rtw89_dev *rtwdev,
 				B_AX_TBTTERLY_MASK, TBTT_ERLY_DEF);
 }
 
+static void rtw89_mac_port_cfg_tbtt_agg(struct rtw89_dev *rtwdev,
+					struct rtw89_vif_link *rtwvif_link)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
+
+	rtw89_write16_port_mask(rtwdev, rtwvif_link, p->tbtt_agg,
+				B_AX_TBTT_AGG_NUM_MASK, TBTT_AGG_DEF);
+}
+
 static void rtw89_mac_port_cfg_bss_color(struct rtw89_dev *rtwdev,
 					 struct rtw89_vif_link *rtwvif_link)
 {
@@ -4904,6 +4915,7 @@ int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvi
 	rtw89_mac_port_cfg_bcn_hold_time(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_bcn_mask_area(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_tbtt_early(rtwdev, rtwvif_link);
+	rtw89_mac_port_cfg_tbtt_agg(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_bss_color(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_mbssid(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_func_en(rtwdev, rtwvif_link, true);
-- 
2.51.0


