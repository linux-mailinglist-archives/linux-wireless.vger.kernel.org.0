Return-Path: <linux-wireless+bounces-26997-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C4CB4366C
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 11:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D32DA1B2717B
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 09:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996FA2D29B7;
	Thu,  4 Sep 2025 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="QXCXinrl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE382D2397
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976390; cv=none; b=IxKjmmfBidZuKVa/bCF7jaBQ89F6OsVM4d4kJ4QXFkyNsPtJriASFU5q7oZdLwSc4Q4G+sWZyfq5euP7HJbkH6Pz4i8gkVy0scx4wTNdFuaEDykgj6AFJlmA4pgIlVw77HSwTZ537i8AnXWXac2tDKR6WDycNzp6dYEzPfmNwUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976390; c=relaxed/simple;
	bh=ACBHDUsWRuX/1GhNjTxpBKfVtr0xQJFsLWs1J6PQCfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRDvq9BklVXF9kBHP3YNus8AakKuY8iN73gFWKcTOVScbd5AtE5odEVrvPYXn1f99MjHxahfP0g2kk6INXnTA9ZSDOpQMxK8DBr3wnlvTrhgTm7Rq1pwf6YNjBSsPdgFFajclxLsAeCyK1YAJwc1WogBZU0qrDtwQoVIyXcW41A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=QXCXinrl; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24a9cc916b3so8917525ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 04 Sep 2025 01:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1756976388; x=1757581188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jFejiaa09W+s1nrm+u0vkMU4MI9pwm0MmQmrRwY9lwU=;
        b=QXCXinrlaVOXMLD+0/p7HodiA+dVEpCxTMCAEqc4h0gktTK2A4wNoPRk0IQLSDzaR8
         ly91i+2Qre1orXMaojXRlub+2e+NhcSZPtu15qgjYw5XjByQuaBmfAFTjsVoXryWNfhC
         JVTP6P5uO/TfUZpQeCclhz5L4/cUgWMf7e1IqF+/rbMB8fNjgfO4z7l7OQXQq8XZMGGX
         C0Cdk06lyvTBN0YoeTIwk7pUGV0SywiNJSEhAEVwa7/Lj+YOpla0LNHTW6mawG253eG5
         HdPNvtdp1I2rlQD/Me6//E8jrIDCxrjQu7NO9oJg/bFM3sbJT7lAct8r5TRVOwrGnC2P
         5bkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756976388; x=1757581188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFejiaa09W+s1nrm+u0vkMU4MI9pwm0MmQmrRwY9lwU=;
        b=qq9kbiJiR1kczA7hN9F1ar0+fRL8RYbc2PRKJAol8aOy4bAeufHDBwVDLXti+H4Umo
         4pK2YmTWdQIgC1tDoihvNOP7Ba/D0Mq9zySItCaSXF93ZcpTt/rZZzUKOvKtUJmw8Hgq
         gnQuWrKetL4CRbDpCi1muIil9OdVv+8cT6wKHXkejlVRTUW5ClBpEMCo5hfvJrzdAvUL
         c1aojta7Kz8/JA4u4XMs6t4ncF14S27oCR/FXf2g2SFZQAu0X0f9nZcw2qpVz/8VE5qw
         6vq7qevsO+Yth1CPHDfJRuP6pSx5x7aER3HGliKU/aEMth1FarbvTAl7FwHu1C5FNwnp
         73WQ==
X-Gm-Message-State: AOJu0Yzyn7HgxI+CFCC+ncuLAaF4aJFS9vJTtilE0eWNxd1PNNBe1rWs
	HQ4aBI2m23U7Vdpl1obzeQHoMJg2ca1HIs4P0S11F0QXI6JojjTuOqlJtm3U9k7dYdc=
X-Gm-Gg: ASbGncupm4KfMMBt239QAwSSuEOjwSzkRpvyNVtKBp4YTCoBnk/yvax9Y0VQqtP2nq9
	jXLvPMwEPuDu8dNv4seaD5gRYwHex3gZvUKlmguLu9rO1esgAtIaSO3KroMrQW5pJ51GE/vgXXM
	VzGjD241KsvL3YIroDsG6Gep/ubn55OE0q/UHgKQE3CpPCX6ljIvhGe58yqHxk9zqu/nKGE/7Qq
	jUYqpqMC55vZUrKN9ddhN9FGMIJdMsIHZJ5q1V12brqtL19Vob6qoJKn/tH85OwSImeII5JCuxJ
	vFMomcia8U77BKj+Qc95mS2jP3ubH01IziWhT20c2T2NJcYm9s8UtphqRLgi1CkJkKm4dbT0Inz
	RjOqFHw8eLo6Iu34uK43mg8kqCRsurvUTTIXXffCrxXHBzmrylbqixVOHFf0=
X-Google-Smtp-Source: AGHT+IEonVHovimLabESZcUiXK1iUD1aS90oxvpehvw1gepHYbxed8iaUbWsg/w5hymrlKZCBivZ3g==
X-Received: by 2002:a17:903:2412:b0:249:c2ee:af2a with SMTP id d9443c01a7336-249c2eeb25fmr240018105ad.11.1756976387755;
        Thu, 04 Sep 2025 01:59:47 -0700 (PDT)
Received: from localhost ([1.145.88.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da3c38sm182483045ad.91.2025.09.04.01.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 01:59:47 -0700 (PDT)
Date: Thu, 4 Sep 2025 18:59:43 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [wireless-next v2 3/3] wifi: mac80211: kunit: add kunit tests
 for S1G PVB decoding
Message-ID: <7zj6xu6apxs2b73iwsck3p5qappcpt3hn7vrdecvfh3to5ixzw@3uzofpejtuvu>
References: <20250725132221.258217-1-lachlan.hodges@morsemicro.com>
 <20250725132221.258217-4-lachlan.hodges@morsemicro.com>
 <65411d6ba7516e01920ccf39627269fc2f71dd56.camel@sipsolutions.net>
 <e4j5rbffwxgrqafkwyuezl2q3z4mgdn5lxrkxjxaphmn66movm@d743xb4xbdrc>
 <78645f03a5b61371ee9f95544695ffe86bd1ed8e.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78645f03a5b61371ee9f95544695ffe86bd1ed8e.camel@sipsolutions.net>

On Thu, Sep 04, 2025 at 10:52:21AM +0200, Johannes Berg wrote:
> On Fri, 2025-08-01 at 15:11 +1000, Lachlan Hodges wrote:
> > > Anyway, it's the middle of the merge windows, so I guess it'll be a
> > > while before I apply things.
> 
> I'm finally getting to merging things to wireless-next, so it ended up
> being quite a while indeed.

It's fine, it doesn't really change anything since I submitted it right
at the end of the merge window.

> > That's fine - I can submit a v3 once the merge window closes with these
> > minor fixups, no rush from our end. Plus its always good getting the
> > dopamine hit from seeing all green :)
> 
> Did you want to do that? As I said, I can also just fix it up, but maybe
> you also had other changes in mind.

I reviewed it last week and was happy, so if you want to make the fix when
you apply I am fine with that (and saves me a bit of time aswell :)).

thanks,
lachlan

