Return-Path: <linux-wireless+bounces-24048-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE30AD6CE8
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 12:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E7E17660F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 10:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B669522A1E6;
	Thu, 12 Jun 2025 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oB10xmED";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CCQfAkcf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oB10xmED";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CCQfAkcf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C684022172E
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749722477; cv=none; b=sKtLMq/rK+oWztfX2pFKD/QBrTe8knIn1ZuwXpRY3w186sMySV7CPGHR9/7elUYNW/kHwcRMSh1ToqqqrPazPvK98g+pfgO1nuhHkeYoV+1g1g8WNfM/6jkakvYOnrfahELndJD/rKi2dONBEjfvu1t35cE+AuwGXNo7vMYph8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749722477; c=relaxed/simple;
	bh=q5kTkBhWgDYKTr55UJHZdrxdw2kvuVN9wI3YTFpQeJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjhcwqVbfsIDiUhTyPg1JqKHFSKr8MpFTTGBc0MxLBOft51lLvxXqxnefIAjsw4vK6UE5rElYVxKLROSCdwRZK7CU28IPliLv1Gy4f7VlJkkaKtBi7Z1wAl7uw3/DAPowd681n9OonT4W+kqeQd0NEw/27AM80JLLjSOAFUajQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oB10xmED; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CCQfAkcf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oB10xmED; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CCQfAkcf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1AC621F78E;
	Thu, 12 Jun 2025 10:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749722474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MfDva740sbD7wBeTOlrPtgcsAi2TWLZrQwwMYisXkR8=;
	b=oB10xmEDnnQCgl7Ov5+3Z/w2op1djNanlBxzXo4xZK79GJdzAcQ9L4mIWQ7PfllEKlNHTo
	VQxcwSdg1iy/F0cKMKYwBJATaZEDnyqoEcpunZuXt0V84pl12QrsmjaapE5/3t0OsTBItt
	G4J8dEEYMBLDD8k4wj1lcx7uVXiuJKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749722474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MfDva740sbD7wBeTOlrPtgcsAi2TWLZrQwwMYisXkR8=;
	b=CCQfAkcfmqyL/JwRt0+58QGcb4i5sA9J2V2eC4V9QTbny0fpirayYOGXmv0Eui/CzBHk/W
	aqZ3kC+n1RE894CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749722474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MfDva740sbD7wBeTOlrPtgcsAi2TWLZrQwwMYisXkR8=;
	b=oB10xmEDnnQCgl7Ov5+3Z/w2op1djNanlBxzXo4xZK79GJdzAcQ9L4mIWQ7PfllEKlNHTo
	VQxcwSdg1iy/F0cKMKYwBJATaZEDnyqoEcpunZuXt0V84pl12QrsmjaapE5/3t0OsTBItt
	G4J8dEEYMBLDD8k4wj1lcx7uVXiuJKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749722474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MfDva740sbD7wBeTOlrPtgcsAi2TWLZrQwwMYisXkR8=;
	b=CCQfAkcfmqyL/JwRt0+58QGcb4i5sA9J2V2eC4V9QTbny0fpirayYOGXmv0Eui/CzBHk/W
	aqZ3kC+n1RE894CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81D6D132D8;
	Thu, 12 Jun 2025 10:01:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id USolHGmlSmjRSgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 12 Jun 2025 10:01:13 +0000
Date: Thu, 12 Jun 2025 11:01:03 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	akpm@linux-foundation.org, Jeff Johnson <jjohnson@kernel.org>, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCHv2] wifi: ath11k: mark reset srng lists as uninitialized
Message-ID: <zlzpmburt4o75yizy6uknx4ews4eox6wbr5jleuixp6o6v2tuk@sz6k4x4gcolo>
References: <20250529035708.3136232-1-senozhatsky@chromium.org>
 <5857380e-ced9-4118-b9a0-ce926b25c11c@quicinc.com>
 <rxaibpgtf37w3th5lnt3w574w443yononqjoglyfktlcxe26qg@jpmtkckrotzp>
 <d02bca79-66f1-48b0-8c3b-aeaaa17135a9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d02bca79-66f1-48b0-8c3b-aeaaa17135a9@quicinc.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Thu, Jun 12, 2025 at 04:01:49PM +0800, Baochen Qiang wrote:
> [+ kernel mm list]
> 
> On 6/12/2025 1:04 PM, Sergey Senozhatsky wrote:
> > On (25/06/12 11:30), Baochen Qiang wrote:
> >> On 5/29/2025 11:56 AM, Sergey Senozhatsky wrote:
> >>> ath11k_hal_srng_deinit() frees rdp and wrp which are used
> >>> by srng lists.  Mark srng lists as not-initialized.  This
> >>> makes sense, for instance, when device fails to resume
> >>> and the driver calls ath11k_hal_srng_deinit() from
> >>> ath11k_core_reconfigure_on_crash().
> >>
> >> Did you see any issue without your change?
> > 
> > We do see some issues, yes, on LTS kernels.
> > 
> > [..]
> >>> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
> >>> index 8cb1505a5a0c..cab11a35f911 100644
> >>> --- a/drivers/net/wireless/ath/ath11k/hal.c
> >>> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> >>> @@ -1346,6 +1346,10 @@ EXPORT_SYMBOL(ath11k_hal_srng_init);
> >>>  void ath11k_hal_srng_deinit(struct ath11k_base *ab)
> >>>  {
> >>>  	struct ath11k_hal *hal = &ab->hal;
> >>> +	int i;
> >>> +
> >>> +	for (i = 0; i < HAL_SRNG_RING_ID_MAX; i++)
> >>> +		ab->hal.srng_list[i].initialized = 0;
> >>
> >> With this flag reset, srng stats would not be dumped in ath11k_hal_dump_srng_stats().
> > 
> > I think un-initialized lists should not be dumped.
> > 
> > ath11k_hal_srng_deinit() releases wrp.vaddr and rdp.vaddr, which are
> > accessed, as far as I understand it, in ath11k_hal_dump_srng_stats()
> > as *srng->u.src_ring.tp_addr and *srng->u.dst_ring.hp_addr, presumably,
> > causing things like:
> > 
> > <1>[173154.396775] BUG: unable to handle page fault for address: ffffb4e4c046f010
> > <1>[173154.396778] #PF: supervisor read access in kernel mode
> > <1>[173154.396781] #PF: error_code(0x0000) - not-present page
> 
> I am confused here: if the root cause is driver trying to read a freed memory, it should
> not result in a PF issue. Because even if freed, the page is there and still mapped in
> kernel page table.
> 

Any memory that is virtually-mapped (read: vmalloc, vmap, vm_map_ram, and others)
will be unmapped on its subsequent free. I'm not familiar with the DMA subsystem,
but the address ffffb4e4c046f010 is vmalloc-like.

> 
> > <4>[173154.396824] RIP: 0010:ath11k_hal_dump_srng_stats+0x2b4/0x3b0 [ath11k]
> > <4>[173154.396839] Code: 88 c0 44 89 f2 89 c1 e8 3a 14 06 00 41 be e8 25 00 00 eb 6e 42 0f b6 84 33 78 ff ff ff 89 45 d0 46 8b 7c 33 d8 4a 8b 44 33 e0 <44> 8b 20 46 8b 6c 33 e8 42 8b 04 33 48 89 45 c8 48 8b 3d 45 a3 a0
> > <4>[173154.396842] RSP: 0018:ffffb4e4dceefc50 EFLAGS: 00010246
> > <4>[173154.396846] RAX: ffffb4e4c046f010 RBX: ffff90d1c3040000 RCX: a0009634a5d28c00
> > <4>[173154.396849] RDX: ffffffffb0279d80 RSI: ffffffffb0279d80 RDI: ffff90d2e5d17488
> > <4>[173154.396851] RBP: ffffb4e4dceefc90 R08: ffffffffb0249d80 R09: 0000000000003b82
> > <4>[173154.396854] R10: 0000000000000004 R11: 00000000ffffffea R12: ffff90d1c3041c90
> > <4>[173154.396856] R13: ffff90d1c3040000 R14: 0000000000002828 R15: 0000000000000000
> > <4>[173154.396859] FS: 0000000000000000(0000) GS:ffff90d2e5d00000(0000) knlGS:0000000000000000
> > <4>[173154.396862] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > <4>[173154.396865] CR2: ffffb4e4c046f010 CR3: 000000005ca24000 CR4: 0000000000750ee0
> > <4>[173154.396868] PKRU: 55555554
> > <4>[173154.396870] Call Trace:
> > <4>[173154.396874] <TASK>
> > <4>[173154.396883] ? __die_body+0xae/0xb0
> > <4>[173154.396890] ? page_fault_oops+0x381/0x3e0
> > <4>[173154.396896] ? exc_page_fault+0x69/0xa0
> > <4>[173154.396901] ? asm_exc_page_fault+0x22/0x30
> > <4>[173154.396908] ? ath11k_hal_dump_srng_stats+0x2b4/0x3b0 [ath11k (HASH:3de7 4)]
> > <4>[173154.396923] ath11k_qmi_driver_event_work+0xbd/0x1050 [ath11k (HASH:3de7 4)]
> > <4>[173154.396942] worker_thread+0x390/0x960
> > <4>[173154.396949] kthread+0x149/0x170
> 

-- 
Pedro

