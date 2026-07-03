Return-Path: <linux-wireless+bounces-38538-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O/9nAtkcR2p6TQAAu9opvQ
	(envelope-from <linux-wireless+bounces-38538-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 04:22:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 562006FDE62
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 04:22:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=bJr3ZJt9;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38538-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38538-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 260453027B41
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 02:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E3725B0AE;
	Fri,  3 Jul 2026 02:22:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2F31A6807;
	Fri,  3 Jul 2026 02:22:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783045333; cv=none; b=fe+7yd6+Wi7/sWLsL26lgHvyRCFhjXGUJgXLKD3a14Y5cVmNeRKs3zODAd135vS0VSIiPTzVxjaviFI3Ivt3zd9c+SrEPo8gsarwIZg6c3oscyJaNcscCGYly8zpJbMdraHT1TTBXfh9sCppt3ys00jm8E/UvLgbGg9LvGLzj8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783045333; c=relaxed/simple;
	bh=4d1wKtIQvB4IADvUKnHetEfeLvhpaqeV6fZbaW+9+gU=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=edapq8mLdAXaoJf1Stl/34v9kiRAwQGntYMjjT0V4uxY85Q577AWZm/OojHWm6udJDcgwOOPyMg84SO8jpGk85yRRuf8YtaxrFGOXyDiCyw3ITzw1zp4ReL3P4m2POSM9Ezw1Gkpr9+t/5WHGTaiMUkLhTPq9WlnhEUD9L/bsq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=bJr3ZJt9; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6632M7Z402384573, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783045328; bh=PC+6dTrA8OOGLaZkzQzFr11M+X12cg5WXocPvrnEFEY=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=bJr3ZJt9ngnmSzyZKKHD/DFN8UW2zQo5wTcZPdLPoClTISeF/aq4b2KGxC5dluTSj
	 Aok6F15L8zZpcv7xGqdNyQ1kUEUsgrJK5NevNE6CG/3/zyL964S/qcCWNpGir/CPUC
	 +//jHk5bB+eJvsKY+PEjYhJq+38CSpFB5hobWbdnWzJXmzz3C9lLCXaTGScFCyPm9+
	 vGpz9Dq32/6/rs9YVRUFoI0bWKV+lHRpjxSzYu1x5ckoaRqRbCX+YmVJBr7wOpHi4z
	 jyYehtU1iE5kA51gkEc7mCFAbBdWOKv+YyzLexo46c4jHi28Xj5mDH0ZxXAw0EiQF+
	 9V2bzIF5jl7qg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6632M7Z402384573
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 10:22:08 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 10:22:06 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Jul 2026 10:22:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: William Hansen-Baird <william.hansen.baird@gmail.com>,
	<pkshih@realtek.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>, William
 Hansen-Baird <william.hansen.baird@gmail.com>
Subject: Re: [PATCH rtw-next v2] wifi: rtlwifi: rtl8723be: Remove unnecessary irq save/restore in hw_init()
In-Reply-To: <20260609095359.2964193-1-william.hansen.baird@gmail.com>
References: <20260608135345.2526325-3-williamhb+k@fastmail.com> <20260609095359.2964193-1-william.hansen.baird@gmail.com>
Message-ID: <e7393ecd-12ea-4ae6-b395-fa2ff95070cc@RTKEXHMBS03.realtek.com.tw>
Date: Fri, 3 Jul 2026 10:22:01 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38538-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:william.hansen.baird@gmail.com,m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:williamhansenbaird@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:from_mime,realtek.com:email,realtek.com:dkim,RTKEXHMBS03.realtek.com.tw:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 562006FDE62

William Hansen-Baird <william.hansen.baird@gmail.com> wrote:

> rtl8723be hw_init() calls local_save_flags(flags) followed by
> local_irq_enable(). Later, local_irq_restore(flags) is called.
> 
> This causes warnings from Lockdep on boot and modprobe,
> as local_irq_restore(flags) should only be called while irqs are disabled.
> The warning was introduced to detect this class of bug in [1].
> 
> With testing I found that all paths which call hw_init() have irqs
> already enabled for rtl8723be.
> 
> Furthermore, the calls were originally added for the rtl8192ce
> in commit f78bccd79ba3 ("rtlwifi: rtl8192ce: Fix too long disable of IRQs")
> before later being added to most other rtlwifi drivers.
> 
> Commit d3feae41a347 ("rtlwifi: Update power-save routines for 062814 driver")
> then replaces the call to spin_lock_irqsave() before hw_init(),
> and thus the codepath which caused irqs to be disabled in hw_init and
> prompted the original commit has been removed.
> 
> The same irq save/restore pattern is also present in the hw_init() of
> rtl8192ce, rtl8723ae, rtl8188ee, rtl8192se and rtl8192cu,
> however I don't have the hardware to test them,
> so I did not include them in my changes.
> 
> Tested on a Razer Blade 14 2017.
> 
> Example of output from Lockdep prior to fix:
> 
> raw_local_irq_restore() called with IRQs enabled
> 
> ...
> 
> Call Trace:
> <TASK>
> rtl8723be_hw_init+0x5992/0x7220 [rtl8723be]
> ? static_obj+0x61/0xa0
> rtl_pci_start+0x222/0x5c0 [rtl_pci]
> rtl_op_start+0x128/0x1a0 [rtlwifi]
> ? __kasan_check_read+0x11/0x20
> drv_start+0x16c/0x550 [mac80211]
> 
> ...
> 
> irq event stamp: 887679
> hardirqs last  enabled at (887689): [<ffffffff96511170>] __up_console_sem+0x90/0xa0
> hardirqs last disabled at (887698): [<ffffffff96511155>] __up_console_sem+0x75/0xa0
> softirqs last  enabled at (887670): [<ffffffff962f4675>] __irq_exit_rcu+0x175/0x2f0
> softirqs last disabled at (887649): [<ffffffff962f4675>] __irq_exit_rcu+0x175/0x2f0
> ---[ end trace 0000000000000000 ]---
> 
> [1] https://lore.kernel.org/all/20210111153707.10071-1-mark.rutland@arm.com/
> 
> Signed-off-by: William Hansen-Baird <william.hansen.baird@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

1b4cd55626b6 wifi: rtlwifi: rtl8723be: Remove unnecessary irq save/restore in hw_init()

---
https://github.com/pkshih/rtw.git


