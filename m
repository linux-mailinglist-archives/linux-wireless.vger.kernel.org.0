Return-Path: <linux-wireless+bounces-20816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5B8A70D4D
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 23:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B681898C98
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 22:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD7E269AFA;
	Tue, 25 Mar 2025 22:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZyczogLj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4632E1991D2
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 22:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742943328; cv=none; b=MebKX3jct+fsTWeknzWcH3pSqSoTIUs+XPpzkEOG6kHZ8B6xg++BrStAe070VDDc5gF/tzgyLOVGbZghwy4HHzUphKVWDTnd1jrkcDe0ji8/8kC74vAlTN03BSdBIQTQxHq8D93KmsEj9PR4eUgQJR8aXt6Fq0Sr1p1aTCgGs68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742943328; c=relaxed/simple;
	bh=3ATsKOEl3U55Kx0tNiQbYgKWXpTx+lq0HaAgp3b+/1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCg3By51f12OoE/EPi8qwgZI+dnyuneB6LmGfKhvm4X83qmjHwYjGi/fGhZrGH2YEaYqPiR8Tm3C1nZxbGFZeq8NhJw3B2Xofnr8OnEn1Av19IsDWoHSmp7odVAL1BkFBBujZhdBynl+GQK8SiKq0OvxTgJ70hsV+bhUzwVISFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZyczogLj; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-300fefb8e06so10933552a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 15:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742943326; x=1743548126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/rWYTl0BQ8sV08+fAcHai9+yEEk78TAqV1oXCWKXLvo=;
        b=ZyczogLjhc45iJvvJluP48PgYwXfI4ElqHvn7tUwgjL2KzxYgZFDYRAAlmIMmjrf01
         JAUiUEPqh+U9uJ8Rr1U8euA7CCF5c4G4E9/VhKCEMFh5sBV3GD88k6T+YdDkGTap5G0q
         AMzI5VBrx+gzWie6CXsY1QYFXJ/L5IfEgLUz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742943326; x=1743548126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rWYTl0BQ8sV08+fAcHai9+yEEk78TAqV1oXCWKXLvo=;
        b=J5SOo7vLKmGglQ1whi8gsb/u0AKVi/vPbI1pv+XK1emzHNqE6cLG+S4lC7VbSk1Kwm
         37T6MmV2q1AyfYuWObTA1n6yY2CliTmkTr4nAT1O8NrKjfrMRofRf9IKsesZohXQNXQw
         puFoz3qiIkfQrSZ9+1/WX0uFmwwMdCFVeQilH8sUVSgw+C/FcBOZ8bWjlUOgEJvavqsG
         dvThBliMnJcp8RUVJkPqwdFOvpiuVxIx6fXf7UMDey9rQbBLZ1PyRV5yRQJiEKt7QKtg
         YOWIl6NjPuFFO1w1WkHZRvLp6bAmZ0cX8gR0q8+4EOZJR+EgFY+Utqlt5V7V/EVBmUpC
         MKTA==
X-Forwarded-Encrypted: i=1; AJvYcCW1kfMlRUC2b3h0tlS/MPnFQu8NGloZJx0/EZNVBpQMm4NLDqn85/ckUS9Ik0JoJnZoYsmTCdzPO06GVjta2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVQRaUtLuxqR9Wizhn6m0ksaIhTrRZ/2OEQVN9ig0osoxI3d7J
	Yo/It55eom8LmBMIbcfLNSdBHmvC4cQtB1+1QHXz5y1Ca99ZKPuvfZpOyjRQ4g==
X-Gm-Gg: ASbGncsbRZAwY/iyEATjRkG2C5BxIiP2qxFdxkxFmnvg8ojYXzYXELQJsmNFC5ZOAOV
	brjMS54HyYubXQGPZPMqvLkdZXjysEnR7d985CFfbVxYIDRYvRr8ICqd94wh0pGeN6mfZYCouaL
	mVdIZgHztpRXOrmbWK7wd3RXZBz7Fjz619NU0FtPeWYHgNYO3d/o2xlk515L46vV0TePlFzqEmL
	VkxN2kQbIqZgUQIL/2N7BvCSnFfF6ZHFL4LltghZ5QaSWWEn7Ls6cQtlNOuRLTusoARbryimBK4
	djFRzGwDT0AmMfFML3vyvE9iEEqfDP34glRap0ce6LDwRFk0Dv+0QYlyS6wLVwLupUVjqvLKa3F
	j5Y2rPSU=
X-Google-Smtp-Source: AGHT+IG9S6QnIRAL+Dp97HJUJGLI8iqjec4PoLgiksev72cNRulybhcRcYYBIlaatzFFYS67MgI4+w==
X-Received: by 2002:a17:90b:390a:b0:2ee:bc7b:9237 with SMTP id 98e67ed59e1d1-3030fef0a26mr27364715a91.27.1742943326173;
        Tue, 25 Mar 2025 15:55:26 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:b885:47c3:6268:77fb])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3030f60994dsm10989539a91.26.2025.03.25.15.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 15:55:25 -0700 (PDT)
Date: Tue, 25 Mar 2025 15:55:23 -0700
From: Brian Norris <briannorris@chromium.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jeff Chen <jeff.chen_1@nxp.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [EXT] Re: [PATCH v4 1/2] wifi: mwifiex: Fix premature release of
 RF calibration data.
Message-ID: <Z-M0W_RzOM9X0x0Y@google.com>
References: <20250220061143.1417420-2-jeff.chen_1@nxp.com>
 <20250318050739.2239376-2-jeff.chen_1@nxp.com>
 <20250319162842.GA46894@francesco-nb>
 <PAWPR04MB9910FE139C88507DE5904ABD9CA72@PAWPR04MB9910.eurprd04.prod.outlook.com>
 <fe70fb090164301d8b2a894dd350850c175a03dc.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe70fb090164301d8b2a894dd350850c175a03dc.camel@sipsolutions.net>

On Tue, Mar 25, 2025 at 05:45:10PM +0100, Johannes Berg wrote:
> On Tue, 2025-03-25 at 16:43 +0000, Jeff Chen wrote:
> > 
> > 
> > I have decided to withdraw the patch. I appreciate your feedback and attention to detail, 
> > which helped identify this oversight.  
> > 
> 
> This goes for _everyone_ on this thread... I applied this patch a long
> time ago. Whatever you need to fix, you need to send new patches.

If it needs withdrawn, I suppose Jeff should send a revert patch then.

> And I guess next time I'm not going to apply any patches for mwifiex
> however innocent they look ... thus making the situation of that driver
> even worse than it is now.
> 
> So please get together and form a plan on how to maintain it.

My 2 cents:

 * Technically, I'm listed as maintainer still. I'm not always prompt,
   but I try to eventually get around to stuff (or at least see that
   Francesco reviews). I believe the previous implicit agreement would
   be that the wireless-drivers maintainer would wait for an Ack from
   sub-maintainer(s) before applying, unless they were truly trivial. I
   don't require that, of course, if you'd like to take things on your
   own Johannes, but that was my previous understanding.
 * I'm also used to seeing email replies when patches get applied. Kalle
   used to do that (presumably from some kind of push-time automation?),
   but I see you don't. You're of course free to do this however works
   best for you, but I find such emails useful for all interested
   parties (authors, reviewers, etc.). For example, if I thought the
   patches were controversial and were on my ToDo list, I'd probably
   speak up sooner.

Brian

