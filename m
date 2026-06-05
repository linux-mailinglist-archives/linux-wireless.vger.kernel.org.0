Return-Path: <linux-wireless+bounces-37398-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id COTjINEcImppSgEAu9opvQ
	(envelope-from <linux-wireless+bounces-37398-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 02:48:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D48AF644281
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 02:48:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CuYou36d;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37398-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37398-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF33D3046998
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 00:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A92DDA9;
	Fri,  5 Jun 2026 00:47:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845ED1AA797
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2026 00:47:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780620431; cv=none; b=JGipF3qh7Fmd0KEUfseaYSnvXwl8ocSN7eZIuC8418tfem+0YY3QgKDaxQTcwDLKq6eGdSU/+AO5NNEbBbXTMl/iROZy3GtgDToEjUQoLc4txr4tn7cg8vFUIczh3aRoFWDUEVJgwscHgpc6gpcqZK2OwxGLEeHLldKYIpVEaCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780620431; c=relaxed/simple;
	bh=qGy24gu3vUGcBugIVlQhmer9jUs99/uS3k6G4TEPAc0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=R80wn7IBf+vJBM1vyvmx6BeHmUddsNHT5eMAK3RjoUwVFgEjy6iQGuiUmBj6NI8s040EOU6ly622gx44fwEkzdLtUXTdH6R5CvBXWlFspHtKhwKZx0Lqh+9T4M28HCv2MfpWKejpnMzLZxVXO+Caj9fcaA+DWZwb1DImXlMhNWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuYou36d; arc=none smtp.client-ip=209.85.128.172
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7dc73a56b5aso10370477b3.1
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jun 2026 17:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780620429; x=1781225229; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rFNpR8+kRntAg2bWP6kAucMUhEw/l3UqI8+nWLYyf4=;
        b=CuYou36dTe+mrylf/BvffqxD3I+UJ3iXajZjNBu4udGlvMtzMYdgmJ6PdfuB3zgSDM
         JHoNpWbywji8iXKyc4CdajBBBDd+U4DT7IrHO+grb916LJT0PnJFSUlprRHLDKJIVfeu
         IzQnyUmPFscJpcQFyq10Hw0cX57f3secISO/xUc8K+tiCCUUMIKnJlRcGY8tUMG+P+ed
         rQQbX5KKdGcHKp8/b+7AoJ4GwlFEoKvtOu4TIRemwy2mRs4zZExGNchRQKJi7/P9aANm
         Xmrpv/ThH+JK16SHqC00eVgQdodGdt8f7coyKGH+CRYXXlplIXT2rk44sQtsRT1aDj23
         DMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780620429; x=1781225229;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6rFNpR8+kRntAg2bWP6kAucMUhEw/l3UqI8+nWLYyf4=;
        b=D4J/6RSAU1geVMuUcsh2B0hpTCf67ViypJVLp7Gr5HTEMpStrd33pbnAug72Qb0l05
         w5+r4jP/JgnrIc3CpcBOtTGmIO181QV6HqdaI+XIR+E+MiIGuIDgiSzM1dijQKMAEF9Q
         a/HwBtdEHmS6TZ8o1xaHd4QrHh7XUoXHaY0Wd2xImw2m5kuy6BL3hFXt0RUkHYs7XuUf
         prjD0SWW9GsvcFSG7x9kbMNfuA1kPV5ItmkTBp5WafzKG65xhbjapMh+vXSQtuocZni7
         PZDMB4TWUWQi70bH4c1dLS3SglUlgXHAJZ/d9/KCJsid4Cn8ZVobHAfn4pniDHHz/v/y
         jGlQ==
X-Forwarded-Encrypted: i=1; AFNElJ89ZPUXUEfEgcwD+NbxXgn4mKbtj2iVEZ0QrsjQ/3HQxP3tM2GI4sqE0TTxGVd8EyYguPI4dYrosGC7WFsZtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuYJHjksfuj3fOq7RGrhu4AT3w7xwf4W32GWafgJyUkgJmvM45
	FZ14b982jN2Xa1NzIV/4XpWue8wWGPCoPW8EmJX38os+mNw8frAsV8TU
X-Gm-Gg: Acq92OEtQrBU7AdMAM6e7FoeNJ4xV76IW/EzJoWk1NuJtXZNRbxOo7L6zVKaKH7tnKb
	sCb9+ctxbW7tlngVMbnCKht222D9zPfbMHmIIeEyyHXpryFmczUJsb0MR0KC8bXtkldxUQ19tEA
	xOoh0u3UKrV/jagSZ8xeMQk3okOQGN6OjWePFnWmucpQ2VYbNQFfEIreiTRAuAiOgUKuhfMTGL4
	zUcoSOZPhPrKjHKBkO88WubeHv3CRN7ttW5PtuS2yuHpROVgHkUDfroWJBH2Ccl3L6CfoGv1qUw
	vRUbC/SGqxKjh65RMiLHqRAMOFNgqjP6kz7TzahXR5TT+22TArRWU6R+5Ztjyahzei9qk09u4G6
	lNrbjhGOhJ+tbwq7hFhct1i4JhLm/OdyI3WfhlFVKCT+qU6xATQedFPT2vwUDqiijLcJA0ZSLc7
	NCKvB2/nTFAiS7rbi1uSVddhn2kFfSKyrLv4F+uTtIxoh9y81pStQ+pif8zjn2WecS5AmD/2hcz
	x2+6LcqBs+4lOmfEambUs22x0T6Z36eQBwHZ+L5M/7or13PRe8=
X-Received: by 2002:a05:690c:7247:b0:79b:deb2:f5ed with SMTP id 00721157ae682-7ed0c8096d9mr13170147b3.23.1780620429564;
        Thu, 04 Jun 2026 17:47:09 -0700 (PDT)
Received: from localhost ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea21968299sm44027227b3.19.2026.06.04.17.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 17:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jun 2026 17:47:06 -0700
Message-Id: <DJ0P9FDV1BW8.1LKRTVDOTEFGW@gmail.com>
Subject: Re: [PATCH wireless-next] wifi: mac80211: fold tid_ampdu_rx
 allocations into a flexible array
From: "Rosen Penev" <rosenp@gmail.com>
To: "Johannes Berg" <johannes@sipsolutions.net>, "Rosen Penev"
 <rosenp@gmail.com>, <linux-wireless@vger.kernel.org>
Cc: "open list" <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260604001427.16466-1-rosenp@gmail.com>
 <64823ef6ba20312cf81eae281740873f5ae6e6f5.camel@sipsolutions.net>
In-Reply-To: <64823ef6ba20312cf81eae281740873f5ae6e6f5.camel@sipsolutions.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37398-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[sipsolutions.net,gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:rosenp@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D48AF644281

On Thu Jun 4, 2026 at 5:20 AM PDT, Johannes Berg wrote:
> On Wed, 2026-06-03 at 17:14 -0700, Rosen Penev wrote:
>> Convert the separately-allocated reorder_buf pointer to a C99 flexible
>> array member at the end of struct tid_ampdu_rx, and place reorder_time
>> in the same allocation immediately after it. This collapses three
>> allocations into one and removes the corresponding kfree() pairs from
>> the error and free paths.
>
> As I pointed out before, I'm not a huge fan of these "doing a minor
> improvement for the sake of it" contributions ...
You say that but these have resulted in missing kfrees being discovered
throughout the tree.
>
>> @@ -241,7 +241,6 @@ struct tid_ampdu_rx {
>>  	struct rcu_head rcu_head;
>>  	spinlock_t reorder_lock;
>>  	u64 reorder_buf_filtered;
>> -	struct sk_buff_head *reorder_buf;
>>  	unsigned long *reorder_time;
>>  	struct sta_info *sta;
>>  	struct timer_list session_timer;
>> @@ -256,6 +255,7 @@ struct tid_ampdu_rx {
>>  	u8 auto_seq:1,
>>  	   removed:1,
>>  	   started:1;
>> +	struct sk_buff_head reorder_buf[];
>
> Given that sizeof(unsigned long) =3D=3D sizeof(void *), that would probab=
ly
> be far simpler as
>
> 	struct {
> 		struct sk_buf_head buf;
> 		unsigned long time;
> 	} reorder[];
>
> or so.
This is indeed much better. Will make the change.
>
> johannes


