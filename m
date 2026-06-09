Return-Path: <linux-wireless+bounces-37548-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nbEHCj1wJ2oOwwIAu9opvQ
	(envelope-from <linux-wireless+bounces-37548-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 03:45:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DA065BBC9
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 03:45:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=FpisHdtb;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37548-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37548-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EEAA301225D
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 01:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045932FF672;
	Tue,  9 Jun 2026 01:45:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D8128506C
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 01:45:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780969521; cv=none; b=IFDHp9qDFiu1F2uEU+RWHEzprRRD4g5WZG8eJnONZu361+9SVi8NrG9Q1GQfCkKJmJ2YHQSD7/nrNDXUas/H0zt2eM0N6u0vGzZXC2tZw/rNMArt4b90HerW/3CCgut4L3EDqDkQlpdoXW0KxlzvCOpfrR2jEx+kC/l6A1e41rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780969521; c=relaxed/simple;
	bh=6O8YqZs6YkDTVZyHdWn88TRHYchEYKKdHFjvaz5OpCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjoeEjn9oB1KW95Mjqo+WyhDTHNcm+eASRI+NHJh95dwlYRIxLKqLvcwhaLQiLiqZ1nGHORm2FzpscWOy+vKHxHNu1ixc73uPaoX9AHjBOIo+tItnhAcNy4Z3EAvUBndsWeJhsq4lTyS1CPi7nlw9wZ4rTTokZK2/LmkOOQnjWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FpisHdtb; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf2d865383so386245ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 18:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780969520; x=1781574320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9/wdxfyH4JAOSK4spHVo4nmbREVFxJGYB6KTPGdKO7A=;
        b=FpisHdtbMCU3QX2sPKmuCROGv0IH9yLmuPNgXMkXXY+OJ/yFS4iy6f955mjFKdmgZ4
         Wmr4NyE4gBMgVUzo8WwaNZcNnfH75Whatq+JIhM1q6Kuk8LBVR6V/czSI4RG7ClKjxwb
         GJXu4Q5IGGSINZBm4I0QisCL7T+pXzBT6aaEk0uJ07XNIpOuhr/s48NHnIkHjBxMBfci
         lIYUxRbelulL6DSu0H1KnhwyxBGtu5juYuvGRe5m9nFc09GLgg0eg1sC6SGr5e5jqyA0
         X9/yVh93EuAPBjP9aKVz40kxKzIiz4deDs7XbibjQnkMVNA6UrHYSzwYX6yalGNF4Blt
         ioFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780969520; x=1781574320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/wdxfyH4JAOSK4spHVo4nmbREVFxJGYB6KTPGdKO7A=;
        b=KfMu79Lq0J2KKBTlnTg50OU0cPzdjmaKVtBuZ4HOZSn5uwN6s+3F0PVdob76m169zg
         KQDbNWQnx9ywbcoPHLF63EJ3vaj8XZwWtbvTkzekHmsqkfgp1utHyKIWdlHpiF4YJJzl
         DamZtFq3IiadZ4Ggq33ok41fQT0OjYuSaJK5oDcocU45jNvd5MEp4ZcUlasCVe7MZcQf
         DGGxhkjR5PDHAHE/rtWiPva8hXlQ4EgvWHYEkbc3dyCSFVbQV96DxQoKkBC+R3ttJXVE
         gd3yCgq78myGfEJOqac5XeXtPwqH6lBb0hwhXL4YNEZ4+JIEYsg6BJowjuXFHpYM5mpT
         OV+w==
X-Forwarded-Encrypted: i=1; AFNElJ84FLb/DYl7dK4j3cil8+3JFdLNAup+umLiaLx4wRM/5poabQpUinJ4T5LjM/739LR4ABG1RpqNhcB8+8SM/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv3Vhe0SbrB61igGPuAmKFIkvR+ruKw/3eK8cVH0JDf7C4O0ho
	wW9COpCzYR7yneNHd46lisuRcMA48PeSlZ/OVsocxTsZIbO4qJnzWBx9I5VzQl7e9A==
X-Gm-Gg: Acq92OHxMassXyAXktOyMl35ItPsvdBEQQp0BZTVbP/uCYulNENvoEgM38dmrmTJ4J8
	Rw9KUYx8QQmht5CCW0E1S9WX/Jxn2vZ1lyAomRsPDhrbDYSkTiy1IcoK2mSLpIdvnllpbfDGpIU
	ZrIo+RwVvo3SZUlQm3QULmABPFKg49Ffek1EKmygekKcWRFUoHelr8ymJUSEpKiKLCjmxdDm4hS
	8fiSJMRY6LJ4Rf94/0cdt/566PxuJmb7EN1+8l5Vt7jmzQgqByy1hnjL2MJHb1GEJbcB7nmJcgb
	6hBFLv2RThUEM9APcDt51rkOpCEpFFvS00hm2ac3RKVzERbeaRuMiMcSnvUJeKksNcxHyTO3q+u
	UqqbJaXm9lICsv5Cco6xPHv+KGT5AqbNlIBcB4c0mKDwWRtGzfTvi0O06QIPOHSGvNrlsfpijSI
	s8FlPRoGKex5a0xJz5RGtomqLbOg0p++n73NEZgxgwqdfhK73dv8cslREDmuGH3B+EgcuKIuiv/
	AhHlLZzuE4bkdPciSi55SrMWRD/+ue1ipEipXOafqFvqDZ6o7a8QN4E
X-Received: by 2002:a17:903:11c6:b0:2c1:4228:3321 with SMTP id d9443c01a7336-2c1ebb62205mr7223595ad.12.1780969519693;
        Mon, 08 Jun 2026 18:45:19 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f68b03ef6sm17613184a91.0.2026.06.08.18.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 18:45:18 -0700 (PDT)
Date: Tue, 9 Jun 2026 01:45:14 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, yichenyu@google.com, kernel-team@android.com,
	Johannes Berg <johannes.berg@intel.com>,
	syzbot+fd222bb38e916df26fa4@syzkaller.appspotmail.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	"open list:802.11 (including CFG80211/NL80211)" <linux-wireless@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.12.y] wifi: remove zero-length arrays
Message-ID: <aidwKjYHa2yQmxsv@google.com>
References: <20260608133216.1396790-1-cmllamas@google.com>
 <20260608-stable-reply-0011@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-stable-reply-0011@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_FROM(0.00)[bounces-37548-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:stable@vger.kernel.org,m:yichenyu@google.com,m:kernel-team@android.com,m:johannes.berg@intel.com,m:syzbot+fd222bb38e916df26fa4@syzkaller.appspotmail.com,m:lachlan.hodges@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cmllamas@google.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmllamas@google.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,fd222bb38e916df26fa4];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89DA065BBC9

On Mon, Jun 08, 2026 at 08:51:57PM -0400, Sasha Levin wrote:
> > [PATCH 6.12.y] wifi: remove zero-length arrays
> 
> Queued for 6.12, thanks. I dropped the leftover "Change-Id:" trailer from
> the commit message while applying.

Oops, sorry about that. I was working from a gerrit mirror. Thanks for
fixing it.
--
Carlos Llamas

