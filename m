Return-Path: <linux-wireless+bounces-31836-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEQiHV/AkGk4cwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31836-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 19:35:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FED13CEAC
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 19:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4FE4530059BB
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 18:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB191F5858;
	Sat, 14 Feb 2026 18:35:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.unwrap.rs (mail.unwrap.rs [172.232.15.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2512DEA93
	for <linux-wireless@vger.kernel.org>; Sat, 14 Feb 2026 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.232.15.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771094108; cv=none; b=ZYRlUP82BkgeIj6z0F2R69KC0DxgutFdmoIvMLDyAEDqcIz1zRva6haAMqCcqq8wh+hB7kcaXJrJbS2wXHocsSOftOdUu3LIjYO/LdiAm5gtf7qHtKRebE8MEMkQoBh0Z6RqsCI0ELlM30ldysINIVECoiNnXvguWSrGNSVwtws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771094108; c=relaxed/simple;
	bh=v8ZHYJjceF7i6xuAovKw8lNfCnTuTBa1CP3c/+lYOn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXEqN+VNuYKzHHlj6k0ix0YfXK1EOBEV7CgEos3muvvdMdTLLSUnf8/PSZhYnnwdF3TmRBHbI7BMfLdgGFkc89FN//LhApumeSPYjEnWh/agBAufZrjZYi+mmuc9zW9zks2bACk90D6NdHWOVmvNwnFCMcIbtWYy4ijyNqUliYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs; spf=pass smtp.mailfrom=unwrap.rs; arc=none smtp.client-ip=172.232.15.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unwrap.rs
From: Cole Leavitt <cole@unwrap.rs>
To: greearb@candelatech.com
Cc: johannes.berg@intel.com,
	miriam.rachel.korenblit@intel.com,
	linux-wireless@vger.kernel.org,
	Cole Leavitt <cole@unwrap.rs>
Subject: Re: [PATCH] wifi: iwlwifi: prevent NAPI processing after firmware error
Date: Sat, 14 Feb 2026 11:33:06 -0700
Message-ID: <20260214183306.10188-1-cole@unwrap.rs>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <5be8a502-d53a-4cce-821f-202368c44f6d@candelatech.com>
References: <c6f886d4-b9ed-48a6-9723-a738af055b64@candelatech.com> <20260214181018.6091-1-cole@unwrap.rs> <5be8a502-d53a-4cce-821f-202368c44f6d@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[unwrap.rs : SPF not aligned (strict), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cole@unwrap.rs,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31836-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 16FED13CEAC
X-Rspamd-Action: no action

Ben,

Good catch on both fronts.

On the build_tfd dangling pointer -- you're right. The failure path at
line 775 leaves entries[idx].skb/cmd pointing at caller-owned objects
(set at lines 763-764). The caller gets -1 and presumably frees the
skb, so entries[idx].skb becomes a dangling pointer. While write_ptr
not advancing means current unmap paths won't iterate to that index,
it's a latent UAF waiting for a flush path change or future code to
touch it. Two NULL stores inside a held spinlock cost nothing. I think
this should go upstream as its own patch.

On the TOCTOU question -- this is the part I spent the most time on.
The window you're asking about is: firmware starts producing corrupt
completion data *before* STATUS_FW_ERROR gets set. Our NAPI/TX handler
checks can't help there because the flag isn't set yet.

The primary guard in that window is iwl_txq_used() in
iwl_pcie_reclaim(). It validates that the firmware's SSN falls within
[read_ptr, write_ptr). This catches wild values -- out-of-range SSNs,
wraparound corruption, etc.

What it can't catch is an in-range corrupt SSN -- e.g., firmware says
reclaim up to index 15 when legitimate is 8, but write_ptr is 20.
That passes bounds checking and the reclaim loop frees skbs for
entries still in-flight (active DMA). The NULL skb WARN_ONCE in the
loop catches double-reclaim but not first-time over-reclaim.

The complete fix for this would be a per-entry generation counter --
tag each entry on submit, validate on reclaim. But that adds per-entry
overhead on the TX hot path to protect against a condition (firmware
producing corrupt completions) that is already terminal. I think the
right trade-off is:

  1. Your build_tfd NULL fix (eliminates one dangling pointer class)
  2. STATUS_FW_ERROR checks in NAPI poll + TX handlers (this series --
     shrinks the detection window to near-zero)
  3. The existing iwl_txq_used() bounds check (catches most corrupt
     SSNs)

Together these make the damage window small enough that a per-entry
generation scheme isn't justified -- by the time firmware is sending
corrupt SSNs, we're in dump-and-reset territory anyway.

That said, if you're seeing corruption patterns in your customer
testing where a valid-looking-but-wrong SSN gets through before
FW_ERROR fires, I'd be very interested in the traces. That would
change the cost/benefit on the generation counter approach.

Thanks,
Cole

