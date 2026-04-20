Return-Path: <linux-wireless+bounces-35046-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJqRO/4p5mnesgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35046-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:28:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ACB42BCA5
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E786D3018B41
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 13:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97933A8722;
	Mon, 20 Apr 2026 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRHwl6ih"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9C93A2551;
	Mon, 20 Apr 2026 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690972; cv=none; b=tGP9LiqmXM0uJ8FssSiY6FwskZ3jzo9a/Q8yqiISfQlDVuSKbDVtj73KMetiV96ZMilehGx+hW7YS3bNPF9LkuW04XEhkPSAxvfZRSvwoirJ82AF8n0lV2MbC0k9JoRBK7mlRqjfGxkMXIRpUFNfhRiyCQKYGqSMCPXCOOv5WkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690972; c=relaxed/simple;
	bh=XRu+DMAZZf7fnaXEhjw82GF1wBHfzxLJuoQc7tEAjZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DzmhUy5k6ED82OCG8fe8qxp2o5vrQBeO6pikC5D3iXcIiY+tdLtbaHPHGDKqGuEyB/zzT+ahe/OZNUzhxAhuVPD4SzQ0yzKilMY546t+oN82rugHViP2d4sYNGKeojBAwqGs7Muj8u6ktq5stpoMgAPoPmqk31VFRymMRQS03n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRHwl6ih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1038C2BCC4;
	Mon, 20 Apr 2026 13:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776690972;
	bh=XRu+DMAZZf7fnaXEhjw82GF1wBHfzxLJuoQc7tEAjZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QRHwl6ih7O4Ep0yW0eyLlp11HYqg37Y0e64D1tUxQp9nXu+KLy5EPHIJyHKPy/mQw
	 A8gSPrAj+FJn57XHPNKbLlEFgakXVngpPA0cRllsYi6skQU92rPuybx3yvCwXrMSSR
	 Tiw1hraIzRKdz3c8jOyoxWn6iOq+yNVDllWWxkXkAPk+JYzPuVk369tBbp0i1pmO1F
	 BAizd3QWRbDTFf/MF85TaNjXyNpk+dXTQA3Dpifh9VvZWZDKxAY2mTlwTOGO+VeUJg
	 cS1cbKtC6J0zA/Uw18rSF+C+SEqFl6OnqpxwjqZKdukY0cNicuviOiy87+AyTjniI3
	 z4QwVYnnLExGA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Leon Yen <leon.yen@mediatek.com>,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 7.0-6.6] wifi: mt76: mt792x: Fix a potential deadlock in high-load situations
Date: Mon, 20 Apr 2026 09:08:05 -0400
Message-ID: <20260420131539.986432-19-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420131539.986432-1-sashal@kernel.org>
References: <20260420131539.986432-1-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mediatek.com,canonical.com,nbd.name,kernel.org,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35046-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F0ACB42BCA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Leon Yen <leon.yen@mediatek.com>

[ Upstream commit bb2f07819d063a58756186cac6465341956ac0a4 ]

A deadlock may occur between two works, ps_work and mac_work, if their work
functions run simultaneously as they attempt to cancel each other by
calling cancel_delayed_work_sync().

mt792x_mac_work() ->   ...  -> cancel_delayed_work_sync(&pm->ps_work);
mt792x_pm_power_save_work() -> cancel_delayed_work_sync(&mphy->mac_work);

In high-load situations, they are queued but may not have chance to be
executed until the CPUs are released. Once the CPUs are available, there
is a high possibility that the ps_work function and mac_work function will
be executed simultaneously, resulting in a possible deadlock.

This patch replaces cancel_delayed_work_sync() with cancel_delayed_work()
in ps_work to eliminate the deadlock and make the code easier to maintain.

Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Tested-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Link: https://patch.msgid.link/20251215122231.3180648-1-leon.yen@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have all the data needed. Let me compile the full analysis.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

**Step 1.1: Subject Line**
- Subsystem: `wifi: mt76: mt792x`
- Action verb: "Fix"
- Summary: Fixes a potential deadlock between ps_work and mac_work in
  high-load situations.

Record: [wifi/mt76/mt792x] [Fix] [Deadlock between two work functions
that cancel each other with _sync variant]

**Step 1.2: Tags**
- `Signed-off-by: Leon Yen <leon.yen@mediatek.com>` — Author from
  MediaTek (the chip vendor)
- `Tested-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>` — Tested
  by a Canonical engineer
- `Link: https://patch.msgid.link/20251215122231.3180648-1-
  leon.yen@mediatek.com`
- `Signed-off-by: Felix Fietkau <nbd@nbd.name>` — mt76 subsystem
  maintainer accepted the patch

Record: Author is from MediaTek (chip vendor). Tested by Canonical
(Ubuntu). Accepted by mt76 maintainer Felix Fietkau. No Fixes: tag, no
Reported-by (expected since this is a code-analysis-based fix).

**Step 1.3: Commit Body**
The message describes:
- **Bug**: A deadlock between two delayed works: `ps_work` and
  `mac_work`
- **Mechanism**: Both try to cancel each other using
  `cancel_delayed_work_sync()`, which blocks until the target work
  finishes
- **Trigger**: High-load situations where both works get queued and
  execute simultaneously on different CPUs
- **Fix**: Replace `cancel_delayed_work_sync()` with
  `cancel_delayed_work()` in ps_work

Record: Classic ABBA deadlock. Failure mode is system hang (deadlock).
Triggered under high CPU load with WiFi active.

**Step 1.4: Hidden Bug Fix?**
No — this is explicitly labeled "Fix" and clearly describes a deadlock.
Not hidden.

## PHASE 2: DIFF ANALYSIS

**Step 2.1: Inventory**
- 1 file changed: `drivers/net/wireless/mediatek/mt76/mt792x_mac.c`
- 1 line changed: `-cancel_delayed_work_sync(` → `+cancel_delayed_work(`
- Function modified: `mt792x_pm_power_save_work()`
- Scope: Single-file, single-line, surgical fix

**Step 2.2: Code Flow Change**
Before: `mt792x_pm_power_save_work()` calls
`cancel_delayed_work_sync(&mphy->mac_work)`, which blocks until any
currently-running `mac_work` completes.

After: It calls `cancel_delayed_work(&mphy->mac_work)`, which cancels a
pending work but does NOT wait for a running instance to finish.

**Step 2.3: Bug Mechanism — Deadlock**

The deadlock is an ABBA pattern between two work functions:

**Chain A** (mac_work → waits for ps_work):

```
mt792x_mac_work()
  → mt792x_mutex_acquire()
    → mt76_connac_mutex_acquire()
      → mt76_connac_pm_wake()
        → cancel_delayed_work_sync(&pm->ps_work)   ← WAITS for ps_work
```

**Chain B** (ps_work → waits for mac_work):

```
mt792x_pm_power_save_work()
  → cancel_delayed_work_sync(&mphy->mac_work)      ← WAITS for mac_work
```

If both execute simultaneously:
- CPU1's mac_work waits for ps_work to finish
- CPU2's ps_work waits for mac_work to finish
- **Classic ABBA deadlock → system hang**

The two works run on *different* workqueues (`mac_work` on ieee80211's
workqueue, `ps_work` on `dev->mt76.wq`), which confirms they CAN execute
in parallel on different CPUs.

**Step 2.4: Fix Quality**
- Obviously correct: removing `_sync` breaks the circular dependency
- The non-sync variant is safe here because after the cancel, `ps_work`
  immediately returns. If `mac_work` is running, it will re-queue itself
  (line 30-31) and will be properly managed in the next power-save
  cycle. `mac_work` acquires `mt792x_mutex_acquire` which wakes the
  device if needed.
- Minimal/surgical: exactly 1 function call changed
- Regression risk: Very low — the only difference is not waiting for a
  running `mac_work` to finish, which is acceptable since `ps_work`
  doesn't depend on `mac_work` completion

## PHASE 3: GIT HISTORY

**Step 3.1: Blame**
The buggy line was introduced by commit `c21a7f9f406bba` (Lorenzo
Bianconi, 2023-06-28), "wifi: mt76: mt7921: move shared runtime-pm code
on mt792x-lib". This was code movement that created the mt792x_mac.c
file, carrying the original deadlock-prone pattern from mt7921/mac.c.

**Step 3.2: Fixes tag** — No Fixes: tag present (expected).

**Step 3.3: Related changes** — The file has had several changes since,
but none addressing this specific deadlock.

**Step 3.4: Author** — Leon Yen is a MediaTek engineer with multiple
mt76 contributions, including WiFi/BT combo fixes and power management
work.

**Step 3.5: Dependencies** — None. This is a standalone one-line fix.

## PHASE 4: MAILING LIST RESEARCH

b4 dig did not find the exact commit (it matched a different file
change). The lore.kernel.org search was blocked. However, the commit
message Link tag points to the original submission:
`20251215122231.3180648-1-leon.yen@mediatek.com`. The patch was accepted
by Felix Fietkau (mt76 maintainer) and tested by a Canonical engineer.

Record: Maintainer-accepted, independently tested. Standalone patch (not
a series).

## PHASE 5: CODE SEMANTIC ANALYSIS

**Step 5.1: Functions modified**: `mt792x_pm_power_save_work()`

**Step 5.2: Callers**: This function is the work handler for
`pm.ps_work`, queued on `dev->mt76.wq` (an ordered workqueue) via
`mt76_connac_power_save_sched()`. It is called indirectly when the
device transitions to power-save mode.

**Step 5.3-5.4: Call chain**: The power-save work is scheduled via
`mt76_connac_mutex_release()` → `mt76_connac_power_save_sched()`, which
is called after every device register access. This is a very hot path
for any mt792x WiFi operation.

**Step 5.5: Similar patterns**: The `mt7615` driver has similar power-
save code at `drivers/net/wireless/mediatek/mt76/mt7615/mac.c`, but this
specific fix only addresses the mt792x code path.

## PHASE 6: STABLE TREE ANALYSIS

**Step 6.1**: The buggy code was introduced in commit `c21a7f9f406bba`
(June 2023), which is present in v6.6 but NOT in v6.1. Affected stable
trees: v6.6.y, v6.12.y, and any later LTS.

**Step 6.2**: The fix is a one-line change. It should apply cleanly to
any tree containing the buggy code.

**Step 6.3**: No related fixes for this specific deadlock already in
stable.

## PHASE 7: SUBSYSTEM CONTEXT

**Step 7.1**: `drivers/net/wireless/mediatek/mt76` — WiFi driver for
MediaTek MT7921/MT7922/MT7925 chipsets. These are extremely popular WiFi
chips found in many modern laptops (Framework, Lenovo ThinkPad, Dell,
etc.). Criticality: **IMPORTANT** — affects many real users.

**Step 7.2**: The mt76 subsystem is very active with regular
contributions.

## PHASE 8: IMPACT AND RISK ASSESSMENT

**Step 8.1**: Affects all users with MT7921/MT7922/MT7925 WiFi chipsets
(very large population, especially Ubuntu/Fedora laptop users).

**Step 8.2**: Trigger is high CPU load with active WiFi. Both works must
execute simultaneously. Under heavy load this is realistic — the commit
specifically says "In high-load situations, they are queued but may not
have chance to be executed until the CPUs are released."

**Step 8.3**: **Failure mode: DEADLOCK → system hang**. Severity:
**CRITICAL** — the system becomes unresponsive.

**Step 8.4**:
- Benefit: VERY HIGH — prevents deadlock/hang on popular hardware
- Risk: VERY LOW — 1-line change, removing a sync variant that was
  causing the deadlock
- Ratio: Extremely favorable

## PHASE 9: FINAL SYNTHESIS

**Evidence FOR backporting:**
- Fixes a real deadlock (ABBA pattern) verified through code analysis
- 1-line fix, obviously correct, minimal regression risk
- Affects widely-used WiFi hardware (MT7921/MT7922/MT7925)
- Tested by Canonical engineer (Ubuntu LTS relevance)
- Accepted by subsystem maintainer
- Buggy code exists in stable trees v6.6+
- Failure mode is system hang (CRITICAL)
- Author is from MediaTek (chip vendor, deep domain expertise)

**Evidence AGAINST backporting:**
- None significant

**Stable rules checklist:**
1. Obviously correct and tested? **YES** — 1-line change, independently
   tested
2. Fixes a real bug? **YES** — deadlock under high load
3. Important issue? **YES** — system deadlock/hang (CRITICAL)
4. Small and contained? **YES** — 1 line in 1 file
5. No new features? **YES** — pure bug fix
6. Applies to stable? **YES** — clean apply expected for v6.6+

## Verification

- [Phase 1] Parsed tags: Tested-by from Canonical, maintainer SOB from
  Felix Fietkau
- [Phase 2] Diff analysis: 1-line change in
  `mt792x_pm_power_save_work()`, `cancel_delayed_work_sync` →
  `cancel_delayed_work`
- [Phase 3] git blame: buggy code from commit c21a7f9f406bba (June
  2023), code refactoring that moved runtime-PM code to mt792x-lib
- [Phase 3] `git merge-base --is-ancestor`: confirmed code is in v6.6
  but NOT in v6.1
- [Phase 5] Traced deadlock chain: mac_work→mt792x_mutex_acquire→mt76_co
  nnac_pm_wake→cancel_delayed_work_sync(&ps_work) vs
  ps_work→cancel_delayed_work_sync(&mac_work)
- [Phase 5] Verified `dev->mt76.wq` is `alloc_ordered_workqueue`
  (mac80211.c line 733) and mac_work uses ieee80211's workqueue
  (different queues → parallel execution possible)
- [Phase 5] Verified `mt76_connac_power_save_sched` at line 62-83 of
  mt76_connac_mac.c schedules ps_work, confirming the scheduling path
- [Phase 6] Confirmed fix applies to v6.6+ stable trees
- [Phase 7] mt76 is a widely used WiFi driver subsystem
- [Phase 8] Failure mode: system deadlock/hang, severity CRITICAL

**YES**

 drivers/net/wireless/mediatek/mt76/mt792x_mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
index 71dec93094ebd..888e5a5056731 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
@@ -375,7 +375,7 @@ void mt792x_pm_power_save_work(struct work_struct *work)
 	}
 
 	if (!mt792x_mcu_fw_pmctrl(dev)) {
-		cancel_delayed_work_sync(&mphy->mac_work);
+		cancel_delayed_work(&mphy->mac_work);
 		return;
 	}
 out:
-- 
2.53.0


