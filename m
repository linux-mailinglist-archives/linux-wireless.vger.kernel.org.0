Return-Path: <linux-wireless+bounces-9320-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD5D911032
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 20:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03D14B2308F
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 17:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8824D1B29A9;
	Thu, 20 Jun 2024 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OTC7H3sd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DDC1B3730
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718905989; cv=none; b=IFs60yLDCoVxYpl0HLEEn7I2K9/WJumcgf5TmemEwFy5TkZ2ONh4yXtemoSGnmHXnvnAvVhppIjXWhoSMFF1q9/fFuuRUYQB7lqA5Kp7HDGdTQ8hbw70vGaTXbWzDpstRlxo2LP+RP7B1Ye8u3GktPVDfHuk12r5l4hWIvGqZMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718905989; c=relaxed/simple;
	bh=W2wPyagb4ldaqqVyTb2b9Z2e5CK27gmMWxIc/X5KPr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koeljd2dcofb5HwVyko0x7dQJQ4+nAMB00Vf0Fe7fmR/9n5GS0rX2xitqLgGhI61152rujQpAaCULJ0Vu/OPNTWYrqklP4FF99KUNCwXJWz7lNaNT14IfkIg/dGLAYvlNQs6fER7HOI++mBodt529adHzMRyCe6uV4q2wpykBT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OTC7H3sd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f44b594deeso10331815ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 10:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718905987; x=1719510787; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MtIWSfT11IlIfoNWl+SXXECHST6nXFRE+DFh7n7shoE=;
        b=OTC7H3sdXvaWbKUlmoe704zrLJ1GIdeVHGE0hgj6XY7LDdqAhJ78kWC6p7OJ52nxUi
         PHbLeG+li1OU8APOCDc0dw6rYClx4kpQOwBkDglczovKU3inWoT2RJnF7EIO6oEUjPiX
         Zbl6DnUcTo6hnXaRQXWT+QTuzRkqjAZJ7KeVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718905987; x=1719510787;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MtIWSfT11IlIfoNWl+SXXECHST6nXFRE+DFh7n7shoE=;
        b=cMcGHVBHXC4/fBkrb8rhOpTkmgAbdQ1EVRLk/PjjHuW/JuDZEnO3iLyF9kEbZLBCOF
         RMA6CvQaMNCsmiT5LJjhGI09tc07uCVgppF6+pWaXmaHsxKql1WtadnveEiRNyERgs1u
         MuNbRMif8vboqE3iQhPiTw7FMhFEbRx9rljtTwmaqyW6YPJTgU4/f8myTh551kwYNGY6
         SBOEjvnZ76sIFb1u8p7jaOCoPd3pttZGdzIO9r09qTQH7ChYm0RWv5oPj99nwPFVvHOh
         cF7TigCosKWDxAuueKB2VAGzBNqivgyLJTCdU5xvjJMxwyN5xt3h/UaSJgQMVhEy/n+Y
         pekA==
X-Gm-Message-State: AOJu0Yzd8wataJ+Ha+zVCVH0gHC46mt5XjnAZZHT5l1mb/AsBDvHN7tN
	OdqZwwik7rCO5/poEx8bmPHjIw0E9yS+zs+ghlOyYOKo58yRlfknG36yK7jXhA==
X-Google-Smtp-Source: AGHT+IG10MTuzTJGoKiQY55AN/HSJhvqzplpT6keg/Y2/J9OJcTyXs0GsEftBP+jEQApt5y4CuzxNg==
X-Received: by 2002:a17:902:d2cd:b0:1f6:80cd:ec92 with SMTP id d9443c01a7336-1f9aa67e7f4mr67443335ad.63.1718905985309;
        Thu, 20 Jun 2024 10:53:05 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:3c9c:a224:3ec6:17d2])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1f98c1f2782sm58226555ad.257.2024.06.20.10.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 10:53:04 -0700 (PDT)
Date: Thu, 20 Jun 2024 10:53:02 -0700
From: Brian Norris <briannorris@chromium.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"francesco@dolcini.it" <francesco@dolcini.it>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for
 client mode
Message-ID: <ZnRsfiau_JSWBXTZ@google.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <20240418060626.431202-2-yu-hao.lin@nxp.com>
 <Zk6TklTIbxZxIWyb@google.com>
 <PA4PR04MB9638DC958102D07A7B7084B6D1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXOE2Pwv3kRhwkAd1e3+U8zxZi7cX0TeLDkycQya9xkdPA@mail.gmail.com>
 <PA4PR04MB963875C85CFFA0EE2E914BEAD1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXMzHRs=CeyVeMbY44ornTa7f8G3ek3bFeyX39QAwr5bog@mail.gmail.com>
 <PA4PR04MB96380A04A6830AB69024E4B2D1F62@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PA4PR04MB96380A04A6830AB69024E4B2D1F62@PA4PR04MB9638.eurprd04.prod.outlook.com>

Hi David,

On Sat, May 25, 2024 at 12:50:59AM +0000, David Lin wrote:
> 
> > From: Brian Norris <briannorris@chromium.org>
> > Sent: Saturday, May 25, 2024 6:55 AM
> > 
> > On Fri, May 24, 2024 at 3:01 PM David Lin <yu-hao.lin@nxp.com> wrote:
> > > I think it needs time to support probe client. Can we put your
> > > suggested comments to the code used to hook probe_client() and add
> > >
> > > "TODO: support probe client" to mwifiex_cfg80211_probe_client().
> > 
> > Are you suggesting that you plan to actually implement proper probe_client
> > support? Did you already do what I suggested, and understand why hostapd
> > needs probe_client support? This seems to be a common pattern -- that
> > reviewers are asking for you to do your research, and it takes several
> > requests before you actually do it.
> > 
> > Now that I've tried to do that research for you ... it looks like hostapd uses
> > probe_client to augment TX MGMT acks, as a proxy for station presence /
> > inactivity. If a station is inactive and non-responsive, we disconnect it
> > eventually. So that looks to me like probe_client support should actually be
> > optional, if your driver reports TX status? And in that case, I'd still
> > recommend you try to fix hostapd.
> > 
> > But if you're really planning to implement proper probe_client support, then
> > I suppose the TODO approach is also OK.
> > 
> > I'd also request that you please actually do your research when reviewers
> > ask questions. I'm frankly not sure why I'm spending my time on the above
> > research, when the onus should be on the submitter to explain why they're
> > doing what they're doing.
> 
> Yes. I know when aging time of station is out, hostapd will use probe_client to check if station is still there before really disconnect it.
> 
> Without this feature, it won't really affect mayor function of hostapd.

I'm glad *you* know all about the above behavior, but *I* didn't know
about it until I went and researched what this API does, and how hostapd
is using it. But that isn't my job -- it's your job, as the code
submitter, to explain your reasoning and reduce the amount of work that
readers/reviewers/maintainers have to do to understand your code and
agree that it is the right thing to do.

It's not clear to me that you've really learned the above lesson, and
it's really affecting the rate at which I review your code. This is by
far not the first time that you've placed the burden on the reader. And
if you're going to make the job difficult, then I'll prioritize enjoying
my free time, or stuff that actually pays me at $DAY_JOB, or ...

> That is the reason that I suggest that we put comments and TODO to the code.

OK, I suppose that works for me.

Brian

