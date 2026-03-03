Return-Path: <linux-wireless+bounces-32422-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGQmG+JNp2nKggAAu9opvQ
	(envelope-from <linux-wireless+bounces-32422-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 22:08:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C66451F730A
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 22:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67020314AB0D
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 21:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DA6388E42;
	Tue,  3 Mar 2026 21:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vN5eBbgF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D988372EF1;
	Tue,  3 Mar 2026 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772571831; cv=none; b=Kouc29KeYcXRmDOdPwOtKunK2PRDN6ZNfZoUOcm59p9G92dJFwaKJz8uCfi14rkJtZ1lIpm88aEe4qebic/jUGQaEb4tuiVRMPRyjWdT3dkuDwfyXBA86u6Fzko1rgEmz7V22yf18XMPlPKyJmoC2f8pTwXPfV8ACK7qaPkDLzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772571831; c=relaxed/simple;
	bh=o3O9nQYN5pP5LfOCZOHDWE99WzuDFIDdp0lQTBdhQk0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A7Cgx2a8wV+zE6/d37CY4BVP4ih+iUvZSEAGIGuEfQH7/G4RDnycOkYlidw1TNdSpwwVmC+5bJAZsWXQprduW576zC930WNw3MaXo1bPSsT+HmeDs5479dIZkmnpbEnkV6ng4Pi4YehFMzI0Wzlu5BvJDldKpdCY8yoXaSeW75o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vN5eBbgF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=S4rybKDMoyY2IHTBJRDgn2ftLBqB7p9GFO8FxLdaHZQ=;
	t=1772571830; x=1773781430; b=vN5eBbgF/rHUekVUKJlm/uOg5cBicKlUHxUqSosOxKnB+4F
	wmpHj2rExg0LLONlVNCbCaYM0ACNANH1sSjuYC1JdGRaGSxmY/zdXsyIxLZzAXXgzI3X0jDE8Kojc
	4e8JDBp4OUQtxcajZtEv3iPQrQlkGcVVmxz52QMglPG8q2PXVe5NELTgHPge4bmCTilT7KvwfPu0X
	2gj/ZiDQqp9z7sDtxx35HBO9md4R7fYtGKzO1jjd5xCP3rZpoFml5jm7/mpY8NyMpAvfhqe/5U6C1
	YgxUNf08AIpISfa5p3dTUXSj8z6sRjLfqnBYkoQYQlydgS6r/o7GA/jkmA25XN6Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxWu7-00000007KeR-3L26;
	Tue, 03 Mar 2026 22:03:44 +0100
Message-ID: <76682f4db2c378774fa8eefaff497570ec904cc1.camel@sipsolutions.net>
Subject: Re: 6.18.13 iwlwifi deadlock allocating cma while work-item is
 active.
From: Johannes Berg <johannes@sipsolutions.net>
To: Tejun Heo <tj@kernel.org>
Cc: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>, "Korenblit, Miriam Rachel"
	 <miriam.rachel.korenblit@intel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 03 Mar 2026 22:03:43 +0100
In-Reply-To: <aadKDCKGHk1Ua-7_@slm.duckdns.org>
References: <fa4e82ee-eb14-3930-c76c-f3bd59c5f258@candelatech.com>
	 <18c4bfed-caca-bef3-a139-63d7fa48940a@candelatech.com>
	 <e7d92fab-9d0e-4a58-aa0b-2c6545772e68@candelatech.com>
	 <3456b2c89f057900b39ce79ea8ca1154c5014e43.camel@sipsolutions.net>
	 <0de6c8d1-d2fa-44ac-8025-cfcfecd87b02@candelatech.com>
	 <bed9cc03d3c214b2601093f91e4b00f3715762b2.camel@sipsolutions.net>
	 <c616fc41-3bc7-4ddc-b65c-a622111d8548@candelatech.com>
	 <35779061f94c2a55bb58dcd619ae91c618509cf4.camel@sipsolutions.net>
	 <aadKDCKGHk1Ua-7_@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Queue-Id: C66451F730A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32422-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 2026-03-03 at 10:52 -1000, Tejun Heo wrote:
> Hello,
>=20
> On Tue, Mar 03, 2026 at 12:49:24PM +0100, Johannes Berg wrote:
> > Fair. I don't know, I don't think there's anything that even shows that
> > there's a dependency between the two workqueues and the
> > "((wq_completion)events_unbound)" and "((wq_completion)events)", and
> > there would have to be for it to deadlock this way because of that?
> >=20
> > But one is mm_percpu_wq and the other is system_percpu_wq.
> >=20
> > Tejun, does the workqueue code somehow introduce a dependency between
> > different per-CPU workqueues that's not modelled in lockdep?
>=20
> Hopefully not. Kinda late to the party.

Yeah, sorry, should've included a link:
https://lore.kernel.org/linux-wireless/fa4e82ee-eb14-3930-c76c-f3bd59c5f258=
@candelatech.com/

> Why isn't mm_percpu_wq making
> forward progress? That should in all circumstances. What's the work item =
and
> kworker doing?

So it seems that first iwlwifi is holding the RTNL:

  ieee80211_open+0x62/0xe0 [mac80211]
  __dev_open+0x11a/0x2e0
  __dev_change_flags+0x1f8/0x280
  netif_change_flags+0x22/0x60
  do_setlink.isra.0+0xe57/0x11a0
  rtnl_newlink+0x7e8/0xb50

(last stack trace at the above link)
This stuff definitely happens with the RTNL held, although I didn't
check now which function actually acquires it in this stack.

Simultaneously the kworker/6:0 is stuck in reg_todo(), trying to acquire
the RTNL.

So far that seems fairly much normal. The kworker/6:0 running reg_todo()
is from net/wireless/reg.c, reg_work, scheduled to system_percpu_wq (by
simply schedule_work.)

Now iwlwifi is also trying to allocate coherent DMA memory (continuing
the stack trace), potentially a significant chunk for firmware loading:

  dma_direct_alloc+0x7b/0x250
  dma_alloc_attrs+0xa1/0x2a0
  _iwl_pcie_ctxt_info_dma_alloc_coherent+0x31/0xb0 [iwlwifi]
  iwl_pcie_ctxt_info_alloc_dma+0x20/0x50 [iwlwifi]
  iwl_pcie_init_fw_sec+0x2fc/0x380 [iwlwifi]
  iwl_pcie_ctxt_info_v2_alloc+0x19e/0x530 [iwlwifi]
  iwl_trans_pcie_gen2_start_fw+0x2e2/0x820 [iwlwifi]
  iwl_trans_start_fw+0x77/0x90 [iwlwifi]
  iwl_mld_load_fw_wait_alive+0x97/0x2c0 [iwlmld]
  iwl_mld_load_fw+0x91/0x240 [iwlmld]
  iwl_mld_start_fw+0x44/0x470 [iwlmld]
  iwl_mld_mac80211_start+0x3d/0x1b0 [iwlmld]
  drv_start+0x6f/0x1d0 [mac80211]
  ieee80211_do_open+0x2d6/0x960 [mac80211]
  ieee80211_open+0x62/0xe0 [mac80211]

This is fine, but then it gets into __flush_work() in
__lru_add_drain_all():

  __flush_work+0x34e/0x530
  __lru_add_drain_all+0x19b/0x220
  alloc_contig_range_noprof+0x1de/0x8a0
  __cma_alloc+0x1f1/0x6a0
  __dma_direct_alloc_pages.isra.0+0xcb/0x2f0
  dma_direct_alloc+0x7b/0x250

which is because __lru_add_drain_all() schedules a bunch of workers, one
for each CPU, onto the mm_percpu_wq and then waits for them.

Conceptually, I see nothing wrong with this, hence my question; Ben says
that the system stops making progress at this point.

johannes

