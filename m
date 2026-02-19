Return-Path: <linux-wireless+bounces-32031-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Of7E5k8l2l2vwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32031-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 17:38:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52749160BDB
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 17:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B1993023A5D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 16:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0B413957E;
	Thu, 19 Feb 2026 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="nLOelImU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B19D34BA59
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771519123; cv=none; b=rSzhPFTSzoZRmpuGl+6iBW13YY7Ecc9xtjQCpC9xvr1YgMtq7rEur8uS7gkHzSok32+dpDmvJ8Q+YZ6qgCz589DnDLqKLZnuFFUYOqjdV47qjEMtNHPd6CcdOGOiKPQdKlucu5Fm+5GRuQJwIhTu/uY25asTPaMgZMVveAlIvpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771519123; c=relaxed/simple;
	bh=9wKK73Vq7CCKWmpp8AJcQK8hvGUd5AVT2QF9vLcltks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEMl+YF/XV6jbyzRIV6aNc8dIp2tlah3IKIn4GkHlM3Te0Qs/bMN4E+ppzfa1fpD/ooZcQPpnZ1K294yEby9dsV+4qVuh5KoBp4SMNiHPmcbo8LiY0sV1NIj34v9y7tfqxpz6P0Xa0dsJ+38fMf8GbDIH1aapTBbG9uzYlsXsEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=nLOelImU; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 63391940082;
	Thu, 19 Feb 2026 16:38:39 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id DFA9D13C2B0;
	Thu, 19 Feb 2026 08:38:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com DFA9D13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1771519116;
	bh=9wKK73Vq7CCKWmpp8AJcQK8hvGUd5AVT2QF9vLcltks=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nLOelImUsGg3wb8i2ZVK8gRscGRYAp7CDQIoSVftvoRYBqlII3cjxIZMy64F035d6
	 kfM8oAUQEKlsBmpEPpz/OR56xnm9926HQCKpSPGjh2rpWjYkSVW+M1XD5Z245Humlx
	 RhbWiDZ9dgQAifb9t7QjTW5yDUKQP5FE4bavFEyU=
Message-ID: <5ff61419-0d65-7cdf-4033-afb43df03a2e@candelatech.com>
Date: Thu, 19 Feb 2026 08:38:36 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: iwlwifi: prevent NAPI processing after firmware
 error
To: Cole Leavitt <cole@unwrap.rs>
Cc: linux-wireless@vger.kernel.org
References: <7f72ac08-6b4a-486b-a8f9-7b78ea0f5ae1@candelatech.com>
 <20260218184749.22675-1-cole@unwrap.rs>
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20260218184749.22675-1-cole@unwrap.rs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1771519120-z2P1o4YZlgDY
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1771519120;z2P1o4YZlgDY;<greearb@candelatech.com>;bfe4a6ce8997d7f0952d3aefe92bd651
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32031-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[candelatech.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,candelatech.com:mid,candelatech.com:dkim,candelatech.com:url,candelatech.com:email]
X-Rspamd-Queue-Id: 52749160BDB
X-Rspamd-Action: no action

On 2/18/26 10:47, Cole Leavitt wrote:
> Ben,
> 
> Thanks for the historical context. I dug through the git history and
> your linux-ct repos to verify exactly what happened when. I want to
> make sure I have this right - can you confirm whether this matches
> what you saw?

Bug was originally seen in mainline kernel before MLD driver was forked
off from mvm, not in a backports kernel.

Adding your patch below didn't solve the UAF in the tcp_ack path,
at least.  I did not see the debugging indicated that code path
in the patch was taken.  I have not seen any more instances of the 32k loops in
packet segment loop in the last crash, so at least it is not only reason why a UAF
would happen.

The problem reproduced overnight was:

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 0 P4D 0
Oops: Oops: 0002 [#1] SMP
CPU: 12 UID: 0 PID: 1234 Comm: irq/345-iwlwifi Tainted: G S         O        6.18.9+ #53 PREEMPT(full)
Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE
Hardware name: Default string /Default string, BIOS 5.27 11/12/2024
RIP: 0010:rb_erase+0x173/0x350
Code: 08 48 8b 01 a8 01 75 97 48 83 c0 01 48 89 01 c3 c3 48 89 46 10 e9 27 ff ff ff 48 8b 56 10 48 8d 41 01 48 89 51 08 48 89 4e 10 <48> 89 02 48 8b 01 48 89 06 
48 89 31 48 83 f8 03 0f 86 8e 00 00 00
RSP: 0018:ffffc9000038c820 EFLAGS: 00010246
RAX: ffff8881b0646601 RBX: 000000000000000c RCX: ffff8881b0646600
RDX: 0000000000000000 RSI: ffff8881e9cbea00 RDI: ffff8881b0646200
------------[ cut here ]------------
RBP: ffff8881b0646200 R08: ffff8881ce443108 R09: 0000000080200001
R10: 0000000000010000 R11: 00000000f0eaffb7 R12: ffff8881ce442f80
R13: 0000000000000004 R14: ffff8881b0646600 R15: 0000000000000001
refcount_t: underflow; use-after-free.
FS:  0000000000000000(0000) GS:ffff8888dc42e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000005a36002 CR4: 0000000000772ef0
PKRU: 55555554
Call Trace:
WARNING: CPU: 0 PID: 1224 at lib/refcount.c:28 refcount_warn_saturate+0xd8/0xe0
  <IRQ>
Modules linked in:
  tcp_ack+0x635/0x16e0
  nf_conntrack_netlink
  tcp_rcv_established+0x211/0xc10
  nf_conntrack
  ? sk_filter_trim_cap+0x1a7/0x350
  nfnetlink
  tcp_v4_do_rcv+0x1bf/0x350
  tls
  tcp_v4_rcv+0xddf/0x1550
  vrf
  ? lock_timer_base+0x6d/0x90
  nf_defrag_ipv6
  ? raw_local_deliver+0xcc/0x280
  nf_defrag_ipv4
ip_protocol_deliver_rcu+0x20/0x130
  8021q
  ip_local_deliver_finish+0x85/0xf0
  garp
  ip_sublist_rcv_finish+0x35/0x50
  mrp
  ip_sublist_rcv+0x16f/0x200
  stp
  ip_list_rcv+0xfe/0x130
  llc
  __netif_receive_skb_list_core+0x183/0x1f0
  macvlan
  netif_receive_skb_list_internal+0x1c8/0x2a0
  wanlink(O)
  gro_receive_skb+0x12e/0x210
  pktgen
  ieee80211_rx_napi+0x82/0xc0 [mac80211]
  rpcrdma
  iwl_mld_rx_mpdu+0xd0f/0xf00 [iwlmld]
  rdma_cm
  iwl_pcie_rx_handle+0x394/0xa00 [iwlwifi]
  iw_cm
  iwl_pcie_napi_poll_msix+0x3f/0x110 [iwlwifi]
  ib_cm
  __napi_poll+0x25/0x1e0
  ib_core
  net_rx_action+0x2d3/0x340
  qrtr


I have enough guard/debugging logic in place that I'm pretty sure the skb coming
from iwlwifi in this particular path is fine.  It appears the problem is that
there is an already freed skb in the socket's skb collection, and code blows up
trying to access a bad rbtree link, or something.  I'm continuing to try to narrow
down where skb goes bad, but it seems like probably some other thread of logic is
racing to free the skb since the crash site moves around a lot.  Maybe I can add
some sort of debugging to warn if skb is freed while in an rbtree...

Thanks,
Ben

> 
> 2018 Bug (Bug 199209)
> ---------------------
> Fixed by Emmanuel in commit 0eac9abace16 ("iwlwifi: mvm: fix TX of
> AMSDU with fragmented SKBs"). That was a different trigger - NFS
> created highly fragmented SKBs where nr_frags was so high that the
> buffer descriptor limit check produced num_subframes=0. Emmanuel's
> fix clamps that path to 1.
> 
> Current MLD Bug
> ---------------
> Different path to the same symptom. When TLC disables AMSDU for a
> TID, both MVM and MLD set max_tid_amsdu_len[tid] = 1 as a sentinel
> value. The key difference in protection:
> 
> MVM has a private mvmsta->amsdu_enabled bitmap that gates the entire
> AMSDU path:
> 
>      if (!mvmsta->amsdu_enabled)
>          return iwl_tx_tso_segment(skb, 1, ...);  // bail out early
> 
>      if (!(mvmsta->amsdu_enabled & BIT(tid)))
>          return iwl_tx_tso_segment(skb, 1, ...);  // bail out early
> 
> MVM never reads max_tid_amsdu_len in its TX path - it uses its own
> mvmsta->max_amsdu_len. This bitmap was added in commit 84226ca1c5d3
> ("iwlwifi: mvm: enable AMSDU for all TIDs", Nov 2017).
> 
> MLD was designed to use mac80211's sta->cur->max_tid_amsdu_len
> directly, with no equivalent bitmap:
> 
>      max_tid_amsdu_len = sta->cur->max_tid_amsdu_len[tid];
>      if (!max_tid_amsdu_len)  // only catches 0, not sentinel 1!
>          return iwl_tx_tso_segment(skb, 1, ...);
> 
>      num_subframes = (max_tid_amsdu_len + pad) / (subf_len + pad);
>      // When max_tid_amsdu_len=1: num_subframes = (1 + 3) / (1534 + 3) = 0
> 
> What I found in your repos:
> 
>    - linux-ct-6.5-be200, linux-ct-6.10, linux-ct-6.14: No MLD driver,
>      only MVM with amsdu_enabled bitmap protection
>    - linux-ct-6.15, linux-ct-6.18: Have MLD driver
>      (drivers/net/wireless/intel/iwlwifi/mld/)
>    - backport-iwlwifi: MLD tx.c first appeared in commit 56f903a89
>      (2024-07-17)
> 
> So MVM should have been immune to this specific sentinel-value bug
> due to the bitmap check.
> 
> Question for you: When you saw TSO segment explosions in 2024, what
> kernel and driver were you using? If it was one of your 6.5-6.14
> kernels with MVM, then there may be a different path to
> num_subframes=0 that I haven't identified yet. If you were using
> backport-iwlwifi with MLD enabled, that would explain it hitting the
> same bug I'm fixing now.
> 
> The commit ae6d30a71521 (Feb 2024) added better error reporting for
> skb_gso_segment failures, which suggests people were hitting GSO
> segment errors around that time - but I don't have visibility into
> what specific trigger you hit.
> 
> My fix catches the sentinel-induced zero after the calculation, which
> is equivalent to what MVM's bitmap check accomplishes. This should
> prevent the current MLD bug from reaching skb_gso_segment with
> gso_size=0.
> 
> Looking forward to your test results with the problem AP, and any
> clarification on what setup you were using in 2024.
> 
> Cole
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



