Return-Path: <linux-wireless+bounces-25859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDBFB0D9D8
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 14:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5CD560BDB
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 12:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503B928C5AC;
	Tue, 22 Jul 2025 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="g6zTnuQo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF9323ED75
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187951; cv=none; b=TMn4MipFqVa09S7AEjZq5Pn44ortqtKFlTWuimfWeOJB6RTtYgS67PG15B2Qhrn2qUQeqCAMdH3h4FUPEymruexjJKQeUt8gNIbljeCntXqPbAzN36MC2obXKj9WxnU+IJ23U610Y6YfBrXWSgk9el23m4+chSnmzerA7konKAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187951; c=relaxed/simple;
	bh=rm+a646p1zody1XxGmzWQ9FJvktgnJtT/gHpXWAMGI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gevbthF7nE4Ek5+4CEUs8PKbNxvkQmdd0RDtDHN2XHAnvYEFABOCAARhTvio5MuBTgQ9LpUgXay4R26M7cZtv+qm68Oz1dHHYXdoxAJQPdeFkOwnJqvQrdE4GX7rtR/Alc6FzUQi9pTz+YPtR3Fb3mK8TTiW2F9LSofaKJ1NkLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=g6zTnuQo; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b391ca6146eso4830527a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 05:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1753187949; x=1753792749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wOTLvwnvyDZ6xMR5KiMN+m3JOZsC8PXj5HrYfUvsZJg=;
        b=g6zTnuQoYBwiT2g+Lq5J7jdb240SIFZhIbNYZ2CJxIZeM2joaZSSGR0gJUYyl1cIvF
         oJjlaBr/8B5Rcv1brWj7iz2AB/IS5EsX2KeBoU6MAbIs/S3rqnFPdGKIt0QLrL3SnpCk
         Qr+LVctUbzSaumY4m/s0xTFQTO3EPHNAq4cWg5ZbgQJEie+KfS5zMtPI+F2Y4i7Amnl4
         PJqWOdXjW/H95AUDgHPYC+YqZZUxxIyOECFJxxYYQBRk9erv6EEI04rMMcJgcCnKZ3dU
         GwtrNaD40lG6XYmnV4jEcJme3ckxRO6X5a7hJtT8hMrCC6U3rraZO87ypo7ykvNnrByX
         /9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753187949; x=1753792749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOTLvwnvyDZ6xMR5KiMN+m3JOZsC8PXj5HrYfUvsZJg=;
        b=soHoKqL/KvzHi3JvrmKjx9P3GbFqfOTghAv9lz1PNHrRdybx5yrS9q0U5TsE6kmsym
         7LjPL0E/rDKnCNMGoJ3EUKgftx+WpVsApXnCMiiddBpX8eg/dWwFm9g5jQ7mzjFNpT1v
         BE7CE5vYNZWCR97R0wNF+stzAF/CA7mm3KltSKzkSx/Kx+wBRNKwa4+rSkb9jYOPGV9s
         qmvL5mIa7WLldZA4CZDW4CGa3oZa9k5shDEvNzxmwrlnn6kBKho+HbTEFnKUWptK+rCx
         s2alnH7K7DbUEQsrgd8eBca946xgTwlKqiozvl2hbhcVaTrBzT2JYwyda4oyazIH+89j
         s7nA==
X-Gm-Message-State: AOJu0YxbeAul0bNd9rzrKhX0M47VGrn96Y/hZachyJmGXgc5CSQp0zcf
	5WK+QWc46RKGBQQ1XwIN6dK/EUPcQcdepgePeVNVa+tlQSVIGw4tGSsNBCeZmVMl+nI=
X-Gm-Gg: ASbGnct+AnySL+KUiWzb6+jypxdlmny4znoY2PV2JA9bl8I9BEJJHzQiGXMAHB6ObbG
	CJ4XWH0rozVfhiFb4z7tR88CjKirGWlUJkkgIQc8OpGyoir4fQwPPxWpvrZl93hvTcQuHMEP39v
	5F+WbVmUoHWaut3+ux6ceikFd419NGtiChmnvzOP2nohYMnLDad08bhtIaZNzGWLImYISZgqBQ8
	BMR5fGoTdKmUWhdcC6sPHl6BtGODex3R8gv8f3OvSfOMleTosvOJOcs2JkeDMndc/xq3I1BGqzk
	9kK0tOuekeJEDUDGu0V3Tl9wb+peF6Q2CGwMVDAGp64mf7OWonhDNDEONSyvOxRszg8dVEsfl4o
	yDYAV5knH6P3sKMX8NcKgF1RtalPsLw0=
X-Google-Smtp-Source: AGHT+IG0ihhD4MBlBQKhPhYMYYXBP/08z0Zkw+BIvevvSH66FTXT2XM5fFkFuGO3hRZsoCLL7+Tdqw==
X-Received: by 2002:a17:90b:2584:b0:311:df4b:4b81 with SMTP id 98e67ed59e1d1-31caf8ef446mr26087067a91.25.1753187948726;
        Tue, 22 Jul 2025 05:39:08 -0700 (PDT)
Received: from localhost ([101.180.88.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6f2184sm75726425ad.224.2025.07.22.05.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 05:39:08 -0700 (PDT)
Date: Tue, 22 Jul 2025 22:39:05 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [wireless-next 0/2] wifi: support S1G TIM encoding
Message-ID: <vyuemvg55sju7caufqymxzx33mmlm56a2atwoxfd3ho53zklf5@vdcznigys7xw>
References: <20250722071642.875875-1-lachlan.hodges@morsemicro.com>
 <tx3gim4qbf6qmwd4u6kqspzu7n37cih42elgbnwedxogvpkxcn@vmzo7fiyrshw>
 <c116cc5f1258693d67a28b9282da4cf8c94413f5.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c116cc5f1258693d67a28b9282da4cf8c94413f5.camel@sipsolutions.net>

On Tue, Jul 22, 2025 at 01:35:10PM +0200, Johannes Berg wrote:
> On Tue, 2025-07-22 at 17:22 +1000, Lachlan Hodges wrote:
> > 
> > Something I forgot to mention (my file didn't save ._.) is that I aim to get
> > some S1G hwsim tests up and running soon as S1G is almost fully functional
> > within mac80211 (1 maybe 2 more patchsets left) such that there is some
> > standardised testing utilising hwsim.
> 
> After reviewing the bit twiddling code here a bit I'd like to point out
> that perhaps some testing in kunit might also be useful. Not saying you
> _must_ do that, but I've found that even for development it helps, and
> we could drop examples from Annex L into it too.

Sure Ill look into it. Especially now if we are adding a variety of
encoding types.

