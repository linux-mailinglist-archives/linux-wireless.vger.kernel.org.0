Return-Path: <linux-wireless+bounces-35076-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPx4IQ495mlutgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35076-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:49:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8B842D816
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D76B33365E2
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 14:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B1C43CECD;
	Mon, 20 Apr 2026 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCXKag4B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F8743CEC8;
	Mon, 20 Apr 2026 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691792; cv=none; b=NdbyC5WhlOGUCRIv+y5I6IGAsXXKlkeBUiYPz145/8MgNAnPD3gtcRLKALMBoV2tdXNDPdxSlxH/jvK81UVPrsC8cpRXK1E/fylTWnRvIT71pdUDX7SPgn+XHl9QwUEnF6CAy5fZidg5deBgJcUjs+3SPFnJ13gwxhrPMTgJgpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691792; c=relaxed/simple;
	bh=Teg3PZk4joL13q6+vgKFwwZm+5qBJJjOBbONA6sS+Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJANRYj6FskBR9MI7ID89a2suqFrEd3fMOaq5XyXYcZEpCsQAUuWTVmM5H84q0vhtBfgRpNR699HBl24lcTMXBIzZoQpPlJqmoGQBPyolDpCVtRWZcn4pWYuMD5m7RSzRPHTj/W3D6fPsuzqpcp4D6rmxTtwPuQlI74GeljnRYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCXKag4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778A4C2BCB6;
	Mon, 20 Apr 2026 13:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691791;
	bh=Teg3PZk4joL13q6+vgKFwwZm+5qBJJjOBbONA6sS+Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RCXKag4B286qlBwFzEZZ9xPSbFhhY1e/R7ZpTpdS0wx0zkAnY39qefSCWazwBLxAx
	 plQ5gBF0UAVN22IxRTcATJ01WYE4Nsu/tzhsOTk8gfuwy4XQV22xmq86QL4yzoMsTP
	 5VKTvMYEm9D1rI/JrYxhVIBJR8TXdSLbrpBUx+l4LT2TFYE4NIKcsKkBpb/WKW+Ao4
	 P8Pv6JR/n9je71mZ+qAZ87uIsQIK+0iCLjOUafY3SgWorbWp8H75eHi7f+9xOM4INb
	 PWVAtP1naXMzj4oT5VD5eOaE19+4vBsL4HoXNB8nfliY06vAQlqrq3adEHerEt+X8X
	 C/RhrHfYFIVqQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.18] wifi: brcmfmac: of: defer probe for MAC address
Date: Mon, 20 Apr 2026 09:19:50 -0400
Message-ID: <20260420132314.1023554-196-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 7.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,intel.com,kernel.org,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-35076-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD8B842D816
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Rosen Penev <rosenp@gmail.com>

[ Upstream commit 084863593243c5dce0f2eef44e23de8c53ebf4a2 ]

of_get_mac_address can return EPROBE_DEFER if the specific nvmem driver
has not been loaded yet.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Link: https://patch.msgid.link/20260220022739.41755-1-rosenp@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have all the information needed for a comprehensive analysis. Let
me compile the findings.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

### Step 1.1: Subject Line
- **Subsystem**: `wifi: brcmfmac: of:` (Broadcom WiFi driver, device-
  tree integration)
- **Action verb**: "defer" — implies fixing a probe ordering issue
- **Summary**: Handle `-EPROBE_DEFER` return from `of_get_mac_address`
  to properly defer probe when nvmem isn't ready

### Step 1.2: Tags
- **Signed-off-by**: Rosen Penev (author)
- **Acked-by**: Arend van Spriel (Broadcom WiFi maintainer) — strong
  endorsement
- **Link**:
  `https://patch.msgid.link/20260220022739.41755-1-rosenp@gmail.com`
- **Signed-off-by**: Johannes Berg (wireless subsystem maintainer)
- No Fixes: tag, no Reported-by, no Cc: stable (all expected for this
  review)

### Step 1.3: Commit Body
The commit explains that `of_get_mac_address` can return `-EPROBE_DEFER`
if the nvmem driver hasn't loaded yet. This is a well-known kernel
pattern — nvmem drivers often load as modules, and the order relative to
network drivers is not guaranteed.

### Step 1.4: Hidden Bug Fix Detection
This IS a real bug fix. The unchecked return value means the driver
proceeds without a valid MAC address. On systems relying on nvmem-
provided MAC addresses (common on embedded platforms), the device ends
up with no proper MAC.

**Record**: Real bug fix disguised as a simple probe improvement.

---

## PHASE 2: DIFF ANALYSIS

### Step 2.1: Inventory
- **1 file** changed:
  `drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c`
- **+3 lines, -1 line** (net +2 lines)
- **Function modified**: `brcmf_of_probe()`

### Step 2.2: Code Flow Change
**Before**: `of_get_mac_address(np, settings->mac);` — return value
discarded
**After**:
```c
err = of_get_mac_address(np, settings->mac);
if (err == -EPROBE_DEFER)
    return err;
```

Only `-EPROBE_DEFER` is checked; other errors (e.g., no MAC in DT) are
still silently ignored, preserving the original behavior where a missing
MAC is not fatal.

### Step 2.3: Bug Mechanism
**Category**: Logic/correctness fix — missing return value check
- `of_get_mac_address()` -> `of_get_mac_address_nvmem()` ->
  `of_nvmem_cell_get()` -> nvmem core returns `-EPROBE_DEFER` when the
  nvmem device isn't yet available
- Without the fix: probe succeeds with wrong/empty MAC
- With the fix: probe defers, retries later when nvmem is ready, gets
  correct MAC

### Step 2.4: Fix Quality
- **Obviously correct**: 3-line change, checking exactly one specific
  error code
- **Minimal/surgical**: No unrelated changes
- **Regression risk**: Extremely low — only adds a `return
  -EPROBE_DEFER` path, which the caller already handles (verified in
  `common.c` line 564)
- The exact same pattern is used by ath9k, mt76, and rt2x00 drivers (all
  by the same author)

---

## PHASE 3: GIT HISTORY INVESTIGATION

### Step 3.1: Blame
The buggy line (`of_get_mac_address(np, settings->mac)` without return
check) was introduced by commit `716c220b4d990a` (Pavel Löbl,
2022-05-06, "brcmfmac: allow setting wlan MAC address using device
tree"), first present in v5.19.

### Step 3.2: Fixes Tag
No Fixes: tag present. The implicit fix target is `716c220b4d990a`.

### Step 3.3: File History
Recent changes to `of.c`:
- `082d9e263af8d` — Check return of `of_property_read_string_index()`
  (v6.14+)
- `2e19a3b590ebf` — Release 'root' node in all paths (v6.13)
- `7cc7267a01631` — Use `devm_clk_get_optional_enabled_with_rate()`
  (v6.13)
- `0ff0843310b74` — Changed function from `void` to `int`, added LPO
  clock (v6.13)

The current commit is standalone — no dependencies on other patches.

### Step 3.4: Author
Rosen Penev is a regular contributor who has systematically fixed this
exact same bug across multiple wireless drivers:
- ath9k: `dfffb317519f8` (2024-11-05)
- mt76: `c7c682100cec9` (same pattern)
- rt2x00: `428ea708b714b` (same pattern)
- brcmfmac: THIS commit (completing the series)

### Step 3.5: Dependencies
- **Requires** `0ff0843310b74e` (v6.13) — changed `brcmf_of_probe` from
  `void` to `int`
- **Requires** `9e935c0fe3f80` (v6.15) — memory leak fix in caller's
  EPROBE_DEFER handling
- Both are present in v7.0 (verified via `git merge-base --is-ancestor`)

---

## PHASE 4: MAILING LIST RESEARCH

### Step 4.1-4.5
Lore is protected by Anubis anti-bot, so direct fetch was blocked.
However:
- The commit was **Acked-by Arend van Spriel** (Broadcom WiFi
  maintainer)
- Merged by **Johannes Berg** (wireless subsystem maintainer)
- The exact same fix pattern was applied to ath9k, mt76, rt2x00 — well-
  established approach

---

## PHASE 5: CODE SEMANTIC ANALYSIS

### Step 5.1-5.4: Function Call Chain
```
brcmf_sdio_probe / brcmf_pcie_probe / brcmf_usb_probe
  -> brcmf_get_module_param()  [common.c:564]
    -> brcmf_of_probe()  [of.c:69]
      -> of_get_mac_address()  [net/core/of_net.c:126]
        -> of_get_mac_address_nvmem()  [net/core/of_net.c:61]
          -> of_nvmem_cell_get()  -> nvmem core returns -EPROBE_DEFER
```

All three bus probes (SDIO, PCIe, USB) properly handle
`ERR_PTR(-EPROBE_DEFER)` returned from `brcmf_get_module_param()`.

### Step 5.5: Similar Patterns
The exact same fix exists in 3 other wireless drivers:
- `drivers/net/wireless/ath/ath9k/init.c:651` — checks EPROBE_DEFER
- `drivers/net/wireless/mediatek/mt76/eeprom.c:174` — checks
  EPROBE_DEFER
- `drivers/net/wireless/ralink/rt2x00/rt2x00dev.c:996` — checks
  EPROBE_DEFER

brcmfmac was the outlier that did NOT check.

---

## PHASE 6: STABLE TREE ANALYSIS

### Step 6.1: Buggy Code in Stable Trees
- The `of_get_mac_address` call was added in v5.19 (`716c220b4d990a`)
- But `brcmf_of_probe` was changed from `void` to `int` in v6.13
  (`0ff0843310b74e`)
- For v7.0 stable: all prerequisites present, fix applies cleanly
- For v6.13–v6.15: prerequisites present, may need minor backport
  adjustments
- For v6.12 and older: function returns `void`, fix is structurally
  incompatible

### Step 6.2: Backport Complications
For v7.0: The code matches exactly — clean apply expected.

---

## PHASE 7: SUBSYSTEM CONTEXT

### Step 7.1: Subsystem
- **Subsystem**: WiFi driver (brcmfmac) — Broadcom wireless
- **Criticality**: IMPORTANT — widely used in embedded/SBC/OpenWrt
  platforms (Raspberry Pi, many routers)

---

## PHASE 8: IMPACT AND RISK ASSESSMENT

### Step 8.1: Affected Users
Users of brcmfmac WiFi devices where the MAC address is provided via
nvmem (device tree). This is common on:
- OpenWrt routers
- Embedded ARM platforms
- Single-board computers with Broadcom WiFi

### Step 8.2: Trigger Conditions
The bug triggers when:
1. Device tree specifies MAC address via nvmem
2. The nvmem driver loads AFTER brcmfmac
3. This is a race between module loading order — common in practice

### Step 8.3: Failure Mode
- **Severity**: MEDIUM-HIGH
- Device probes with wrong/random MAC address
- Can break network configuration, DHCP leases, MAC-based filtering
- No crash, but real functional breakage for affected users

### Step 8.4: Risk-Benefit
- **Benefit**: HIGH — fixes MAC address assignment on affected embedded
  platforms
- **Risk**: VERY LOW — 3-line change, only adds one conditional return
  path that the caller already handles
- **Ratio**: Strongly favorable

---

## PHASE 9: FINAL SYNTHESIS

### Step 9.1: Evidence Summary

**FOR backporting:**
- Fixes a real, functional bug (wrong MAC address on embedded platforms)
- Extremely small and surgical (3 lines)
- Obviously correct — matches identical fixes in 3 other wireless
  drivers
- Acked by Broadcom WiFi maintainer, merged by wireless maintainer
- Same author systematically fixed this across all affected drivers
- All prerequisites present in v7.0
- Caller already handles EPROBE_DEFER properly

**AGAINST backporting:**
- No crash or security issue — "just" wrong MAC address
- No Fixes: tag or explicit stable nomination

The "against" points are very weak here — wrong MAC addresses are a real
functional problem.

### Step 9.2: Stable Rules Checklist
1. Obviously correct and tested? **YES** — identical pattern in 3 other
   drivers, acked by maintainer
2. Fixes a real bug? **YES** — device gets wrong MAC when nvmem loads
   after driver
3. Important issue? **YES** — functional networking failure on affected
   platforms
4. Small and contained? **YES** — 3 lines, 1 file, 1 function
5. No new features or APIs? **YES**
6. Can apply to stable? **YES** — code matches v7.0 exactly

### Verification:
- [Phase 1] Parsed tags: Acked-by Arend van Spriel (broadcom
  maintainer), Signed-off-by Johannes Berg (wireless maintainer)
- [Phase 2] Diff analysis: 3 lines changed — capture return value of
  `of_get_mac_address()`, return EPROBE_DEFER
- [Phase 3] git blame: buggy line `716c220b4d990a` introduced in v5.19
  (2022), unchecked of_get_mac_address
- [Phase 3] git show `0ff0843310b74e`: confirmed prerequisite
  (void->int) present in v6.13+
- [Phase 3] git merge-base: all 3 prerequisites (`716c220b`, `0ff08433`,
  `9e935c0f`) in v7.0
- [Phase 3] Author history: Rosen Penev fixed same bug in ath9k, mt76,
  rt2x00 — systematic fix campaign
- [Phase 4] Lore discussion: blocked by Anubis; maintainer ack/merge
  confirmed from commit tags
- [Phase 5] Callers traced: `brcmf_get_module_param()` in `common.c:564`
  already checks EPROBE_DEFER
- [Phase 5] of_get_mac_address -> of_get_mac_address_nvmem ->
  of_nvmem_cell_get -> nvmem core returns EPROBE_DEFER (confirmed in
  `drivers/nvmem/core.c:1123`)
- [Phase 5] 3 other wireless drivers handle this identical pattern
  (verified via grep)
- [Phase 6] Code exists in v7.0 stable tree, clean apply expected
- [Phase 8] Failure mode: wrong MAC address on embedded platforms,
  severity MEDIUM-HIGH

The fix is tiny, obviously correct, follows an established pattern
across multiple drivers, is acked by the subsystem maintainer, and fixes
a real functional bug on embedded platforms.

**YES**

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index 1681ad00f82ec..03efae36a0b2d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -128,7 +128,9 @@ int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 	if (err)
 		brcmf_err("failed to get OF country code map (err=%d)\n", err);
 
-	of_get_mac_address(np, settings->mac);
+	err = of_get_mac_address(np, settings->mac);
+	if (err == -EPROBE_DEFER)
+		return err;
 
 	if (bus_type != BRCMF_BUSTYPE_SDIO)
 		return 0;
-- 
2.53.0


