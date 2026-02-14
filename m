Return-Path: <linux-wireless+bounces-31870-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ+oAQvqkGkfdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31870-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:32:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE1613D9BD
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33BF030BD5F4
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC2D28DB46;
	Sat, 14 Feb 2026 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWZA4scx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5D2311C27;
	Sat, 14 Feb 2026 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104445; cv=none; b=Qw7TT8hopl6GrVlGiKM0n1CD5fn3Ep40pFJC73EOdPlvdbTI938Q6Un+kvFSZyf/yai2pk2XOL5R9ryv/BhklHzT8BTETbPUoz6QMEYVg8YrsMxvP7vf1+xM148+pIZOY8peIdjT+1CFxLPsE9xFZF4DMF6AGk3a0NXNq+g/6Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104445; c=relaxed/simple;
	bh=a7eqF+ZaUe+jrkHBrsCoLpAVDieK8LCjza9XqzFNOwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=quWrWVgBTqQRjSJam7niHjVBUGAN9l5pjRfB9zEV8UBjlzP8yoSZyPHNCQV+OwjV5pWiYwM26PZu3RhQpN9Cjnodv6dGQarXFtQZAWMhUFdwVFlMJeWyxv3yu9L+vW0bOwL9UAohGyX/ETvrY6vv0+vh6D0xzCnWoGWVnW/hMSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWZA4scx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A2DC2BC86;
	Sat, 14 Feb 2026 21:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104445;
	bh=a7eqF+ZaUe+jrkHBrsCoLpAVDieK8LCjza9XqzFNOwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KWZA4scx19ESigDiVOKaDHxaC/7Foi1bei0Z0dRHaly/IulIib6Bef85v+4626At8
	 8trKq9/oXwTJB3cVL/5weOSNPkU5qU9Xm9O8r8+bgj2zWPCYGni1RF4vIXMCeASn7I
	 mLF/gpPtqkzJzUqs8aqD7eMt/kz4dPXOzXDxO4AOXWH2kRk7+sbY9ex19PyNxP3R6n
	 W3o/Zt78+dadZa6OfG8uhlZbvrA6uJGlHlz8gHweKMBiMPJ59NxtF6NP5C1MPpMrDw
	 51VxqAyzrFDOVdPNnftxgP7aUeGd3HPAgqIK5mEbYgJM5yLshWEvW90PwE3VIf3yuS
	 CazDLRRsvNsiA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.18] wifi: rtw89: pci: validate release report content before using for RTL8922DE
Date: Sat, 14 Feb 2026 16:23:54 -0500
Message-ID: <20260214212452.782265-89-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31870-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Queue-Id: 8FE1613D9BD
X-Rspamd-Action: no action

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 5f93d611b33a05bd03d6843c8efe8cb6a1992620 ]

The commit 957eda596c76
("wifi: rtw89: pci: validate sequence number of TX release report")
does validation on existing chips, which somehow a release report of SKB
becomes malformed. As no clear cause found, add rules ahead for RTL8922DE
to avoid crash if it happens.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260123013957.16418-11-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

### Detailed Code Change Analysis

The change modifies the `rtw89_pci_release_rpp()` function in two ways:

**OLD code:**
```c
if (unlikely(rpp_info.txch == RTW89_TXCH_CH12)) {
    rtw89_warn(rtwdev, "should no fwcmd release report\n");
    return;
}
```

**NEW code:**
```c
if (unlikely(rpp_info.txch >= RTW89_TXCH_NUM ||
             info->tx_dma_ch_mask & BIT(rpp_info.txch))) {
    rtw89_warn(rtwdev, "should no release report on txch %d\n",
               rpp_info.txch);
    return;
}
```

**What changed and why it matters:**

1. **Bounds check strengthened**: The old check only rejected `txch ==
   RTW89_TXCH_CH12` (value 12). The new check rejects `txch >=
   RTW89_TXCH_NUM` (value >= 13), which catches **out-of-bounds array
   access** when `rpp_info.txch` is used as an index into
   `rtwpci->tx.rings[]` (which has `RTW89_TXCH_NUM` = 13 elements).
   Without this check, a malformed report with `txch >= 13` would cause
   an **out-of-bounds array access**, potentially leading to a crash.

2. **Masked channel check added**: The new code also checks
   `info->tx_dma_ch_mask & BIT(rpp_info.txch)`, which rejects release
   reports for TX channels that are disabled/masked on the specific
   hardware. Accessing a ring for a masked channel could reference
   uninitialized data since those rings are not set up during
   initialization (as confirmed by the `tx_dma_ch_mask` being used to
   skip ring initialization).

3. **The old CH12 check is subsumed**: RTW89_TXCH_CH12 = 12 is the
   firmware command channel. For chips like RTL8922DE, `tx_dma_ch_mask`
   includes `BIT(RTW89_TXCH_CH12)` (since FW CMD channel is typically
   masked), so the old specific check is generalized into the broader
   mask-based check.

### 3. CLASSIFICATION

This is a **bug fix** — specifically a crash prevention fix through
input validation. It:
- Prevents out-of-bounds array access (txch >= RTW89_TXCH_NUM)
- Prevents access to uninitialized TX rings (masked channels)
- The commit message explicitly says "to avoid crash if it happens"
- This extends existing validation (from commit 957eda596c76) to cover
  additional edge cases for RTL8922DE

### 4. SCOPE AND RISK ASSESSMENT

- **Lines changed**: ~6 lines modified in a single function
- **Files touched**: 1 file (`drivers/net/wireless/realtek/rtw89/pci.c`)
- **Risk**: Very low. The change only adds/strengthens a bounds check
  and an already-masked-channel check. It's purely defensive — it only
  triggers on malformed data and returns early with a warning.
- **Subsystem**: WiFi driver (rtw89), well-maintained by Realtek
  engineers
- **The old behavior (CH12 check) is subsumed**, not removed — it's
  generalized

### 5. USER IMPACT

- **Who is affected**: Users with RTL8922DE WiFi adapters (and
  potentially other Realtek WiFi chips using the rtw89 driver)
- **Severity if triggered**: Kernel crash (NULL pointer dereference or
  out-of-bounds access) — this is HIGH severity
- **Likelihood**: The referenced commit 957eda596c76 was created because
  this actually happened with malformed release reports — the cause was
  unclear but the crash was real
- **Author**: Ping-Ke Shih from Realtek, the driver maintainer — high
  trust

### 6. STABILITY INDICATORS

- The commit comes from the rtw89 maintainer at Realtek
- It follows the pattern of an earlier validated fix (957eda596c76)
- Small, surgical change with clear defensive purpose

### 7. DEPENDENCY CHECK

- This commit depends on `957eda596c76` being present (which added the
  initial validation framework including the `rpp_info.seq >=
  RTW89_PCI_TXWD_NUM_MAX` check that remains unchanged)
- It also depends on the `tx_dma_ch_mask` field existing in `struct
  rtw89_pci_info` and the `parse_rpp` callback mechanism
- The RTL8922DE support needs to exist in the target stable tree

### Summary

This is a small, surgical crash prevention fix that strengthens input
validation for malformed TX release reports in the rtw89 WiFi driver. It
prevents:
1. **Out-of-bounds array access** when `txch >= RTW89_TXCH_NUM` (13)
2. **Access to uninitialized/disabled TX rings** when the channel is
   masked

The fix is:
- Obviously correct (bounds check + mask check before array indexing)
- Small and contained (6 lines in one function, one file)
- Fixes a real crash scenario (explicitly stated, and mirrors existing
  fix for other chips)
- Written by the driver maintainer at Realtek
- Very low regression risk (only affects error/malformed paths)

The only concern is whether the RTL8922DE support and the prerequisite
commit exist in the target stable tree. If the RTL8922DE driver and the
`tx_dma_ch_mask` infrastructure are present, this is straightforward to
backport.

**YES**

 drivers/net/wireless/realtek/rtw89/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 093960d7279f8..b8135cf15d13c 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -604,8 +604,10 @@ static void rtw89_pci_release_rpp(struct rtw89_dev *rtwdev, void *rpp)
 
 	info->parse_rpp(rtwdev, rpp, &rpp_info);
 
-	if (unlikely(rpp_info.txch == RTW89_TXCH_CH12)) {
-		rtw89_warn(rtwdev, "should no fwcmd release report\n");
+	if (unlikely(rpp_info.txch >= RTW89_TXCH_NUM ||
+		     info->tx_dma_ch_mask & BIT(rpp_info.txch))) {
+		rtw89_warn(rtwdev, "should no release report on txch %d\n",
+			   rpp_info.txch);
 		return;
 	}
 
-- 
2.51.0


