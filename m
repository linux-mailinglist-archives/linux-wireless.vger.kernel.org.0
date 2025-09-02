Return-Path: <linux-wireless+bounces-26921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DE9B3F493
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 07:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98038483DA0
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 05:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A621FDE31;
	Tue,  2 Sep 2025 05:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="QIQj/EEM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588B32D593E
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 05:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756791191; cv=none; b=a5gf0iH5dcJWPxs/H3/QXUV197mkf2OQce2IpsGKPY9SNZR7yXjy5OaBQ0gLWLaPHH6fwQfAlztDvzmfsRsGVKDs1OPwWF0vXjegR5+dVs6l1PbtxF0a46BQtxmR8iSNBuw7q1vpvmvfx+baM9zaXXFEZtmaq2yB2hSrSA7raxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756791191; c=relaxed/simple;
	bh=TbeLVaVlIncR4Ia0uT9E/901MITA2LHoezsrbMaOBEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQnblx2mz73pcgx9Hb3TQPmi8a7DfMCPmO0NT/5TBEZnhuGvK3Q2yZWGRlEKWIsPa7tr0ebdLxmeh5uPOcE+5yjy6FMpfOXbq6R9q2NI2Op3lxHJ310Sc9IG0j7jLlFKZsgkbHES3ps2BukHZvX4ZJsDUILtV51izLXDYm4mlhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=QIQj/EEM; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7722c8d2694so2922396b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 01 Sep 2025 22:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1756791187; x=1757395987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TbeLVaVlIncR4Ia0uT9E/901MITA2LHoezsrbMaOBEM=;
        b=QIQj/EEMo8zOxrEEt89tcrNLIShoOed6MjeggC9sWUh14yT2stK7NsGJiGUJ+M6B4J
         geNtwAVJJdv0HXkVi0h/WDdyrEqWd/2A4ZJeW6DWtLP+UUvOHMtT+ZbZSNx2TOMmxOlL
         orSSCIMaePCEn4LtDwOemnsNE7QbKs+EkPvgb5Q8KR0Sl16ANbxO2moogpJU0fs0oxNK
         TyP1S4SD4Knpc0bkrLf8tyyI1F6mR7QxT00+aVLHjQLj0F+qfWwrdfgdvnePy7j3QUsQ
         ZWhLzzb5RL+al4aRhe1NFmfsrGkg7hOt/R8z6X8JZ4SAKuSx1jXwL741H8USiDJf1woX
         1HhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756791187; x=1757395987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbeLVaVlIncR4Ia0uT9E/901MITA2LHoezsrbMaOBEM=;
        b=qbvSy9kHVokEXphyc9rOPgMRFJqG9PWOUR8axIUwdsyT5MPXbrFNx4kc7Uu4djRIyI
         AO6XyHtokHTHhGBRuvTG+Gk8Jk+Xrm1nv/a4DD++gAP5fmiQUWxCojZyCMtUfFDTc1aH
         nv0IC8y1pFQpf7Vd0T/5zvozsXO8ZMMfmcHJc3HbQwAhzdSnk0ata22CqFop/O89Jxh1
         o4n+96hnYRaqx8s0MnJvFGZzU4MieAmbXFjXpihAUhDvyEUcHDB93ri6kKdxkdtKSgnc
         57kRhMhwzG9t/GAnlEkotgjTiqFgdr2sU5/qAstBdrIJz9B8XLSCLOTk3Z95ugB2Jc4O
         hvcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsAmOhateyEWVTY2z/c/c8k+btZb5JATdNlaDNzVqhwijQWQGqMnL1QONTRVesKgJenLeNfsZuuAhPGR+rwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLjCbI6BTLZCCsIE3TeAji4+nxgYDHGxhPK/NDZTWtMroUqs9r
	KSqWOnAcPFkdrgidcZ9TacjUibJHkPfnjU67rgyJPqDqn9hBXZWySo2vygwOt6+SLVg=
X-Gm-Gg: ASbGncuR9+5QOrMB1/GjrVn7Nm+qNvDdEBYax8iB2Lr+ntJW5E65iUCeTAiNPrJjA9m
	BWGJA/jJTkQAE2H5pcpcG81b4/vdvi9YXqMseuH6iht8wgrzILnHy8f0Zgg6+HRvP5G4QhcZu0H
	MaDLU0n7Mup/MXPuiPbXElmWTbGsPOwR9mjZr0Q3fb3LPFHDZaerkWjUvomEUGUXUlUl0ayy5UW
	9SUK68l0AZvwfv1IuqIbzAONpSlTBUec5ZGWvS5xxlKKMVLWm2I/Q/wOTl7EirrWtjIb4F2lW25
	fWw3XvtW8vYzGCNg68GnziVUs/OfofbtLM4fWTtv/KRJ4XeGhY7Vg+HbgG/8IcGYK3tknlsiWRr
	uKnmIZlxK7/O90JqL9rMnKq9wAGutEZfghl4hFcqdA24c1g6mcFsxrSXg9FWDoCE1ntQoOQz0x1
	/58Bt4ZhRrU2sbH6gtBEV7LGbfLhdf7Pnlids9eSI=
X-Google-Smtp-Source: AGHT+IH4t5zVAOcJHbO8yPXOEbt0lxv8P3uF9XDgIt1CYvFtxDHiqDubyjinqlfkCvlBLIGMLI56Qg==
X-Received: by 2002:a05:6a20:7485:b0:243:d471:51e5 with SMTP id adf61e73a8af0-243d6e5f224mr15119864637.27.1756791187573;
        Mon, 01 Sep 2025 22:33:07 -0700 (PDT)
Received: from DESKTOP-U69D987.localdomain (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd28ade38sm10699714a12.34.2025.09.01.22.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 22:33:07 -0700 (PDT)
Date: Tue, 2 Sep 2025 15:33:03 +1000
From: Arien Judge <arien.judge@morsemicro.com>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Subject: Re: [PROPOSAL RFC] S1G Primary Channel Implementation Proposal
Message-ID: <20250902053303.urzbsmmjfn6naz2f@DESKTOP-U69D987.localdomain>
References: <xu4ftmpdwwpokw6exaprrv6wleptq7ggleiluiu6x2dzqbqfhv@6s4m3okiohzw>
 <75245df8edd5bbaa8f9cdfd12bab37720473d93d.camel@sipsolutions.net>
 <czhftz5pdqx4edw4xr73svcr5cxfzzwa2r547p52tmsgywsb34@k5ooo5iw5mcu>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <czhftz5pdqx4edw4xr73svcr5cxfzzwa2r547p52tmsgywsb34@k5ooo5iw5mcu>

[ CC'ing Lachlan.. He forgot to CC himself :) ]

