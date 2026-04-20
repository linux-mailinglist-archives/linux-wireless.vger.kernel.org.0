Return-Path: <linux-wireless+bounces-35090-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bAF7GqNh5mm6vgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35090-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 19:25:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD924312F1
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 19:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10C423015D21
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 17:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49739381B1F;
	Mon, 20 Apr 2026 17:25:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.unwrap.rs (mail.unwrap.rs [172.232.15.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BC53A5421
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.232.15.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705918; cv=none; b=Fz6fgTbEb562HD92vagmAljzG/RIRj/XrXJhb62296gIL9WEgLu4RYwu0YH1P5cTZiZC9A2LGKZO6D+P06tCl2n3dGVp5aOJKicbbZYV+qnup5wt7u2vGz1Ogs+w9Y6yAjNzLLq4qSNtomL3jF6KTvkWkhs3bjfMdIfcCl3UerY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705918; c=relaxed/simple;
	bh=McZgI3T4YKaWaQucFQ/KrICs2u3NNGha0oVKpEi+e20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fhFvzlEgu4NS9ijP8yJvc4NqbuRDjVwobEj5LAeqzON1RlWuf9HVGHq+kgE4UnQZccWAaKv7f8oMHzmlqbBgaqWserw+wWdrFAzKowzsFF74ToVIKdCQNExCAimW4TO/0FejcuXAQORbSZLc8JVXuhw02wpBYbh7bErqkvStF9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs; spf=pass smtp.mailfrom=unwrap.rs; arc=none smtp.client-ip=172.232.15.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unwrap.rs
From: Cole Leavitt <cole@unwrap.rs>
To: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, Ben Greear <greearb@candelatech.com>,
 Johannes Berg <johannes@sipsolutions.net>, cole@unwrap.rs
Subject: Re: [PATCH v2 0/3] wifi: iwlwifi: mld: fix UAF and soft lockup on
 firmware error
Date: Mon, 20 Apr 2026 10:22:55 -0700
Message-ID: <177670577529.120399.4827377400344304346@unwrap.rs>
In-Reply-To: <DS0PR11MB7880A8ABB08B6CD3DA5EB53EA3222@DS0PR11MB7880.namprd11.prod.outlook.com>
References: <20260405054145.1064152-1-cole@unwrap.rs> <DS0PR11MB7880E9A54C78A39307F793C3A3252@DS0PR11MB7880.namprd11.prod.outlook.com>
 <DS0PR11MB7880A8ABB08B6CD3DA5EB53EA3222@DS0PR11MB7880.namprd11.prod.outlook.com>
User-Agent: mutt/2.2.14
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [0.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[unwrap.rs : SPF not aligned (strict), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cole@unwrap.rs,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35090-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 0BD924312F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Miriam,

Answering both of your questions in one reply.

> Any chance you can share the dmesg that includes also the FW error?

Yes =E2=80=94 trimmed the boot noise down to the relevant window. On BE200
running c102 firmware (iwlwifi-gl-c0-fm-c0-c102.ucode, build
102.07fca168.0) the sequence looks like this:

  iwlwifi 0000:84:00.0: Error sending SYSTEM_STATISTICS_CMD: time out after 2=
000ms.
  iwlwifi 0000:84:00.0: Failed to send the temperature measurement command (e=
rr=3D-110)
  iwlwifi 0000:84:00.0: Start IWL Error Log Dump:
  iwlwifi 0000:84:00.0: Loaded firmware version: 102.07fca168.0 gl-c0-fm-c0-c=
102.ucode
  iwlwifi 0000:84:00.0: 0x00000070 | NMI_INTERRUPT_UNKNOWN
  iwlwifi 0000:84:00.0: 0x00000B03 | branchlink2
  iwlwifi 0000:84:00.0: 0x67A00000 | FSEQ_ERROR_CODE
  iwlwifi 0000:84:00.0: UMAC CURRENT PC: 0xc00863c0
  iwlwifi 0000:84:00.0: UMAC CURRENT PC 1: 0xc00863c2
  iwlwifi 0000:84:00.0: LMAC1 CURRENT PC: 0xd0
  iwlwifi 0000:84:00.0: LMAC2 CURRENT PC: 0xd0
  iwlwifi 0000:84:00.0: Device error - SW reset
  ...
  watchdog: BUG: soft lockup - CPU#4 stuck for 26s! [ssh:2761085]
  watchdog: BUG: soft lockup - CPU#6 stuck for 26s! [irq/261-iwlwifi:1632]
  watchdog: BUG: soft lockup - CPU#21 stuck for 23s! [Chrome_ChildIOT:843039]

Backtraces on the stuck CPUs converge on
native_queued_spin_lock_slowpath -> __dev_queue_xmit ->
validate_xmit_skb -> skb_segment (on the ssh:* threads) and on the
iwlwifi IRQ threads ieee80211_queue_skb -> codel_dequeue.

The full multi-boot capture (~2k lines) is attached off-list to avoid
spamming linux-wireless; happy to send it to you directly or upload it
somewhere convenient for the Intel firmware team.

One detail I think is useful for internal investigation: I extracted
the code sections of the c102 .ucode file and disassembled the UMAC
image around 0xc00863c0. With Code Density enabled the CRASH PC sits
in a sequence of three consecutive narrow L32I.N instructions all
reading the same offset:

  c00863bd:  78 e0      l32i.n  a7, a0, 56
  c00863bf:  78 e0      l32i.n  a7, a0, 56    ; crash PC falls here
  c00863c1:  78 e0      l32i.n  a7, a0, 56
  c00863c3:  78 8c      l32i.n  a7, a12, 32

Looks like a tight MMIO poll waiting on a ready bit after the
malformed AMSDU descriptor sequence is queued =E2=80=94 the SYSTEM_STATISTICS
timeout fires 2 seconds later because the firmware never leaves that
loop. If it's useful, I have the full ELF of the extracted firmware
image (load addresses preserved) ready to share.

> Was the soft lockup happening after (as a consequence?) of the bug that
> you fixed in 2/3?

Yes, chained. The typical reproduction trace is:

  1. 2/3: TLC disables AMSDU for a TID, max_tid_amsdu_len=3D1 sentinel,
     the missing-sentinel check lets num_subframes=3D0 through,
     skb_gso_segment() expands the skb into an unbounded number of
     tiny segments.
  2. Firmware receives the malformed AMSDU descriptor chain and hangs
     in the MMIO poll above (FSEQ_ERROR_CODE 0x67A00000,
     SYSTEM_STATISTICS_CMD timeout).
  3. 3/3: mac80211 TX continues pulling from the TXQs while
     STATUS_FW_ERROR is set, iwl_mld_tx_from_txq() loops over every
     queued frame, each fails at iwl_trans_tx() with -EIO =E2=80=94 soft
     lockup watchdog fires on whichever CPU is pulling the queue.
  4. 1/3: NAPI keeps draining stale RX from the dying firmware into
     iwl_mld_handle_tx_resp_notif(). iwl_trans_reclaim() already
     early-returns on STATUS_FW_ERROR so a real UAF can't reach the
     queue walk from there; 1/3's WARN_ONCE guards are really
     instrumentation so that if the post-FW-error race does fire
     we get a log line rather than silent CPU burn.

So 2/3 is the root-cause driver fix, 3/3 eliminates the soft lockup
that 2/3's trigger would otherwise produce, and 1/3 closes an earlier
observation window for diagnostics. They come as a series because all
three fired together in Ben's and my reproductions, but 3/3 can stand
alone if you prefer.

> I am wondering why we didn't see it in mvm driver. I don't think we have su=
ch
> a guard there.

MVM gates AMSDU at a different layer =E2=80=94 in mvm/tx.c lines 910-913 and
934-937, `mvmsta->amsdu_enabled` (a per-TID bitmap) is checked before
the num_subframes calculation ever runs. When AMSDU is disabled for a
TID in MVM, the bitmap bit is cleared and TSO falls through to the
non-AMSDU path immediately. MLD has no equivalent bitmap; it relies
only on max_tid_amsdu_len and trusts the "=3D=3D 0 means disabled"
convention =E2=80=94 but the TLC notification path actually writes the
sentinel 1 (mld/tlc.c:858 and the MVM equivalents at
mvm/rs-fw.c:497, mvm/rs.c:1529), so MLD should also treat that value
as disabled. That's what 2/3 does.

v3 is prepared and will be out shortly. Changes from v2:

  - 1/3: commit message reframed =E2=80=94 the v2 text claimed a proven
    SSN-corruption -> iwl_trans_reclaim() UAF chain, but reclaim
    already checks STATUS_FW_ERROR itself, so that chain cannot
    actually reach the queue walk. The patch is more accurately
    described as earlier guards with WARN_ONCE instrumentation,
    which is what it actually is. Also stripped about 1100 lines of
    inadvertent clang-format style churn that snuck into v2.
  - 2/3: Removed the speculative tcp_shifted_skb / tcp_rack_detect_loss
    causal chain from the commit message per Ben's feedback. The
    driver-side bug is traced in-tree; the downstream TCP symptom
    attribution is being investigated separately with Ben and is not
    claimed here.
  - 3/3: Unchanged from v2.

Thanks for the review.

Cole

