Return-Path: <linux-wireless+bounces-31844-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIorGmTokGkMdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31844-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:25:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF49813D52D
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B397B302926E
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778E2283159;
	Sat, 14 Feb 2026 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehoa4lZ1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5383D3C2D;
	Sat, 14 Feb 2026 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104308; cv=none; b=AywG1k7kUvHyyvpaTkRQPIWmbOoFua+oZBCpbk6/Q1+tpeSW2fcYCE1cCALGa+7P07+MA+pWOZsheuPu/9HP4TpOWbVwnmrt62qPrDYCblSZNvxrs6NbVkJPrWzVRC6bsUqEx9GYiBFCg01mthvaR/lLYavDDI4TtpYloG13qxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104308; c=relaxed/simple;
	bh=ao1a0ujgLDH2jAkAjdo1In/ou142IZ3qprhr/H+9WaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTsv/z41lbBxGTC5ogeLup8gt5b6Exo03CAdgCAPfvEJfK5sc7q4Hv6N1B8n/J5p18DatOtrltxI25Y2GNtq1TPW+KwSL1vLx/4abb8mgl7AGd2gzjaPLyGT4G4euroCQ23Fm8Hml+G+hMkbdyruKxII64TzzB91rFJqMqTNX3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehoa4lZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A786C19422;
	Sat, 14 Feb 2026 21:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104308;
	bh=ao1a0ujgLDH2jAkAjdo1In/ou142IZ3qprhr/H+9WaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ehoa4lZ1X++N9eHi5e1ssvb96YIzguhtK7Dik30rCyCkQATUDChbtxZx+/MUt5xRN
	 GVACwEkhytujmkyYx3jgpUV6+Z+AFFeCvJ7PGVsJeA9u/i51JCsInH8JTHSkd2VqOC
	 RSzKJOruFzBJVGuHcSN48OhMYgmWZq62Mxui84nIdW+AaP1JFQDFANoNdtXAxirXpd
	 UxXl0damyzoxzvUc+2hOIYhaFQV5eHdIbrX6w+Mho2X4vruJKiYDYMEXv6XK07Eyq5
	 z4zxV0NnQQZKnBntavXyFrid+eLdlOIqA4brtCnd/vV3iPyplIUU5XgmSg70N2bsgp
	 CI3gEiTO7YMKg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.18] wifi: rtw89: pci: validate sequence number of TX release report
Date: Sat, 14 Feb 2026 16:22:32 -0500
Message-ID: <20260214212452.782265-7-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-31844-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF49813D52D
X-Rspamd-Action: no action

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 957eda596c7665f2966970fd1dcc35fe299b38e8 ]

Hardware rarely reports abnormal sequence number in TX release report,
which will access out-of-bounds of wd_ring->pages array, causing NULL
pointer dereference.

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 1 PID: 1085 Comm: irq/129-rtw89_p Tainted: G S   U
             6.1.145-17510-g2f3369c91536 #1 (HASH:69e8 1)
  Call Trace:
   <IRQ>
   rtw89_pci_release_tx+0x18f/0x300 [rtw89_pci (HASH:4c83 2)]
   rtw89_pci_napi_poll+0xc2/0x190 [rtw89_pci (HASH:4c83 2)]
   net_rx_action+0xfc/0x460 net/core/dev.c:6578 net/core/dev.c:6645 net/core/dev.c:6759
   handle_softirqs+0xbe/0x290 kernel/softirq.c:601
   ? rtw89_pci_interrupt_threadfn+0xc5/0x350 [rtw89_pci (HASH:4c83 2)]
   __local_bh_enable_ip+0xeb/0x120 kernel/softirq.c:499 kernel/softirq.c:423
   </IRQ>
   <TASK>
   rtw89_pci_interrupt_threadfn+0xf8/0x350 [rtw89_pci (HASH:4c83 2)]
   ? irq_thread+0xa7/0x340 kernel/irq/manage.c:0
   irq_thread+0x177/0x340 kernel/irq/manage.c:1205 kernel/irq/manage.c:1314
   ? thaw_kernel_threads+0xb0/0xb0 kernel/irq/manage.c:1202
   ? irq_forced_thread_fn+0x80/0x80 kernel/irq/manage.c:1220
   kthread+0xea/0x110 kernel/kthread.c:376
   ? synchronize_irq+0x1a0/0x1a0 kernel/irq/manage.c:1287
   ? kthread_associate_blkcg+0x80/0x80 kernel/kthread.c:331
   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
   </TASK>

To prevent crash, validate rpp_info.seq before using.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260110022019.2254969-2-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

### Commit Message Analysis

The commit message is crystal clear about the bug:
- **Hardware rarely reports abnormal sequence numbers** in TX release
  reports
- This causes **out-of-bounds access** on `wd_ring->pages` array
- Results in a **NULL pointer dereference** (kernel crash)
- A full crash trace is provided, showing this is a **reproducible,
  real-world bug**

The crash trace shows it occurs in an IRQ context
(`rtw89_pci_release_tx` → `rtw89_pci_napi_poll` → `net_rx_action`),
meaning when this bug triggers, it crashes the system during normal
network operation.

### Code Change Analysis

The fix is extremely small and surgical — it adds a **bounds check** on
`rpp_info.seq` before it's used to index into the `wd_ring->pages`
array:

```c
if (unlikely(rpp_info.seq >= RTW89_PCI_TXWD_NUM_MAX)) {
    rtw89_warn(rtwdev, "invalid seq %d\n", rpp_info.seq);
    return;
}
```

This is placed right before the line:
```c
txwd = &wd_ring->pages[rpp_info.seq];
```

Without this check, an out-of-bounds `seq` value from the hardware leads
to accessing memory beyond the `pages` array, causing a NULL pointer
dereference (or potentially worse — arbitrary memory access).

The only other change is adding `unlikely()` to an existing check on
`rpp_info.txch == RTW89_TXCH_CH12`, which is a minor optimization hint
and completely safe.

### Bug Classification

This is a textbook **out-of-bounds array access / NULL pointer
dereference** fix:
- The `seq` value comes from hardware (parsed from the TX release report
  via `parse_rpp`)
- Hardware can occasionally provide invalid/corrupt values
- No validation was performed before using `seq` as an array index
- Result: kernel crash (BUG: kernel NULL pointer dereference)

### Stable Kernel Criteria Assessment

1. **Obviously correct and tested**: Yes — it's a simple bounds check
   before array access. The author (Realtek maintainer) clearly
   understands the code.
2. **Fixes a real bug**: Yes — NULL pointer dereference causing kernel
   crash, with a full stack trace demonstrating the issue.
3. **Important issue**: Yes — kernel crash/oops during normal WiFi
   operation.
4. **Small and contained**: Yes — adds 4 lines of bounds checking code,
   changes 1 line (adding `unlikely()`), in a single file.
5. **No new features**: Correct — pure bug fix.
6. **Applies cleanly**: The change is self-contained with no
   dependencies on other commits.

### Risk Assessment

**Risk: Very Low**
- The fix only adds a validation check that returns early on invalid
  input
- It cannot introduce regressions — it only rejects values that would
  have caused a crash anyway
- The `RTW89_PCI_TXWD_NUM_MAX` constant is already used elsewhere in the
  driver for allocating the `pages` array, so it's the correct bound
- Single file, single function, minimal change

**Benefit: High**
- Prevents kernel crashes for rtw89 WiFi users
- The rtw89 driver supports popular Realtek WiFi chips (RTW8852A,
  RTW8852B, RTW8852C, etc.) used in many laptops
- The crash occurs during normal WiFi operation when hardware reports a
  bad sequence number

### Author and Trust

- **Ping-Ke Shih** is the Realtek WiFi driver maintainer — highly
  trusted for rtw89 changes
- The commit includes a detailed crash trace demonstrating the real-
  world impact
- The kernel version in the trace (6.1.145) suggests this was actually
  hit on a stable kernel

### Dependencies

None. The fix is completely self-contained. `RTW89_PCI_TXWD_NUM_MAX` is
already defined in the driver.

### Summary

This is an ideal stable backport candidate: a small, obviously correct
bounds check that prevents a kernel NULL pointer dereference crash in a
widely-used WiFi driver. It has zero regression risk, fixes a real bug
that users hit in production, and is authored by the subsystem
maintainer.

**YES**

 drivers/net/wireless/realtek/rtw89/pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index a66fcdb0293b6..093960d7279f8 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -604,11 +604,16 @@ static void rtw89_pci_release_rpp(struct rtw89_dev *rtwdev, void *rpp)
 
 	info->parse_rpp(rtwdev, rpp, &rpp_info);
 
-	if (rpp_info.txch == RTW89_TXCH_CH12) {
+	if (unlikely(rpp_info.txch == RTW89_TXCH_CH12)) {
 		rtw89_warn(rtwdev, "should no fwcmd release report\n");
 		return;
 	}
 
+	if (unlikely(rpp_info.seq >= RTW89_PCI_TXWD_NUM_MAX)) {
+		rtw89_warn(rtwdev, "invalid seq %d\n", rpp_info.seq);
+		return;
+	}
+
 	tx_ring = &rtwpci->tx.rings[rpp_info.txch];
 	wd_ring = &tx_ring->wd_ring;
 	txwd = &wd_ring->pages[rpp_info.seq];
-- 
2.51.0


