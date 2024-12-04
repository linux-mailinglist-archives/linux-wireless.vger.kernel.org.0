Return-Path: <linux-wireless+bounces-15903-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ECF9E4490
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 20:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CCF9166F03
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 19:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0491C3BE8;
	Wed,  4 Dec 2024 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mUXTa+iW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F3F1B4130
	for <linux-wireless@vger.kernel.org>; Wed,  4 Dec 2024 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733340403; cv=none; b=iq99ceskBS6V7TSbcYLL4qfHL+yAEuWPM5kLUdo9feFojbqROCPO0PfaykhNwuBfzQGigATL3CtsnRPg5Z7LajYCXv6PotvgcxZlugASr/a3G1FQ2dhSTK4fZjwr2SjMfyyAxx2Egke0iQhnAMkSIWiSMlh9qSB2mRoYkYxRw/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733340403; c=relaxed/simple;
	bh=C3/eH/02n2G+qGii9hOeQTOzIV1MarUbuxZoSo6Tdrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoeUmsNSIHJQSOzMoIMOYq5KnoFKCt2dI0FuWeLnu15ncXcOFDo3MuhtNeCc+MjOQlQH5fYX54cVsBk6hvfr7yaAQYPAVGgNP6sn+Tlkn/ESg2WyPG1ml/LMp0xTO9KQ8RYOipieUmw+nQTp0623kxbuMr+sgIbz0yG/SDKuurY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mUXTa+iW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-215e194b65aso937435ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Dec 2024 11:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733340401; x=1733945201; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FfDzJKHmceL++JmZOwtSaEgDluQjsPVd6lxF3uJYfTI=;
        b=mUXTa+iWqWcfg+MCPWGGweocf2pf+lk8auPNm87Qk4JT4rpUXFK56eHKp4mbVA5Z5p
         F6dtEPpoe6Ln7XaiL9y2iaoXxv4bSOWb+wxHhGz3vy9xNdPvLRZW95lwR9e+ZhikuXNo
         HG9kF8jXu8k2wZb9TO46Y1VUDOApFnoZDt1Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733340401; x=1733945201;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FfDzJKHmceL++JmZOwtSaEgDluQjsPVd6lxF3uJYfTI=;
        b=T/uqZoLluekhAlBfvZudPAhISN8e4cn6WndOL4dHf85nlqAbWWkb2hmgIgzcL36YHR
         SiVjsnUGkcQLiFfdhssy8vvYV9cYBY6PHw2/MjJzXBShgBUaJINSfkOwwZn1UtKDN8Ye
         oTZmnVAqas6+jW5nXEt0nFN0dTos+2ipNVPXdFH/KuKE03MxtWFrF31S4wvegCT8yVz5
         VCxFK8Gq9XoOtnQdFyy3Z4wj/J99Tlze1gqsN6+SIKNgPWNgeBITWp+qubPLXr5VeDvT
         kCwfVWgMvAquskhZMd1BHa0ooIiEgzRKrhQdmVhfYa5uj7Sz9+pinBoX+VI7KWaudNXT
         5bJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEfjlGynaR+0ZrgBR4JyPNLJR0ZZQcRHRnygsSEs6BhZP44ifZr/57uW4d+6Kna5QnEsGOxkTbPR7Mvef4AA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy2SbssBboUZE8vPjDi8vszLLVbRZKZ9z7m09DV1vC14aRqlQM
	IzGINbvTrXat+MOhuTMgxl+Rx2uQQniS/iHqhr0oJy0laygOAeY5+9ZvmX0zpw==
X-Gm-Gg: ASbGncuKUiAY3801wQb1cUCEBBKNfHAaFdqqgsiedleyIpKoom0J5XIjpq1nYNTqmpy
	HCfSFRqkjRf8aFlJVPnAvJU9Ysfm9r4Cx7ev27FDiV8wLe5urzadoqWrDj/Y6cOF7LFsKjrcqjJ
	hDf0aaZ3shOIK83QD8iHDOdX+OKkQ9Nm4/eYu04otpmkSgLNirPUmpN0sFLmIGQFaDjMRsNw7ko
	lKN/N2mZA4XFFat4OLEucM4W0wL0US/41YSBx1RQQvR455/Yl/mSlAyV9v2cce7dt3pBdWRBJce
	9vZBTDKf6/vR
X-Google-Smtp-Source: AGHT+IHxUYmCQGfedzcLT9G70tfx6EHSHgI0l7Hqj6BU+GVxbnRMM+a76gXXhoU/zLwe8R45jQN9lg==
X-Received: by 2002:a17:903:2349:b0:215:8270:77d6 with SMTP id d9443c01a7336-215bd200a05mr84754445ad.27.1733340401202;
        Wed, 04 Dec 2024 11:26:41 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:8ab8:57a6:96ad:47f7])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-215e57cef2dsm10559385ad.269.2024.12.04.11.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 11:26:40 -0800 (PST)
Date: Wed, 4 Dec 2024 11:26:39 -0800
From: Brian Norris <briannorris@chromium.org>
To: Pin-yen Lin <treapking@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, David Lin <yu-hao.lin@nxp.com>,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: decrease timeout waiting for host sleep
 from 10s to 5s
Message-ID: <Z1Cs7-ajeWn7UOpr@google.com>
References: <20241127105709.4014302-1-treapking@chromium.org>
 <CAD=FV=XhDdBJXfC72PZAbgaSpVx4ubtKSRFptock0SMRg=+Miw@mail.gmail.com>
 <CA+ASDXPXiyga6mKLBacupCXa0wsBbXCrmq20RFo7T2eSF8kbzQ@mail.gmail.com>
 <CAD=FV=XuResyZK1ke1NtaGREfwm_3MB-u5t6vw459kYPt0LZwQ@mail.gmail.com>
 <Z0-4umP9TnNAbJXO@google.com>
 <CAEXTbpeeZVwCYWR0wzX8QMYJ7okj=zmziwt9Nvtu2kzA4iMCmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXTbpeeZVwCYWR0wzX8QMYJ7okj=zmziwt9Nvtu2kzA4iMCmA@mail.gmail.com>

On Wed, Dec 04, 2024 at 09:45:11PM +0800, Pin-yen Lin wrote:
> On Wed, Dec 4, 2024 at 10:04 AM Brian Norris <briannorris@chromium.org> wrote:
> >
> > > >  Can you try testing (and gather timing numbers) when
> > > > suspending soon after initiating scans? It's hard to judge what the
> > > > lower limit of this timeout should really be without any numbers, just
> > > > like it's hard to judge whether your 10 second watchdog is reasonable.
> > >
> > > Pin-yen: is this something you could gather?
> 
> I tried entering suspend right after wifi scans, and the time spent in
> mwifiex_enable_hs() is always around 100ms. It seems initiating
> suspend does not increase the execution time for mwifiex_enable_hs(),
> so I think the driver is capable of interrupting a scan.

Thanks! At some level, there are things we can only verify by
experimentation, since we don't have firmware source code. This seems
fine to me then.

> > > > Also, for the record, since we might have to field regression reports
> > > > for other systems: what hardware (chip variant, FW version) are you
> > > > seeing problems on?
> > >
> > > Pin-yen: I'm assuming you'll provide this.
> 
> From the debugfs entry:
> 
> driver_name = "mwifiex"
> driver_version = mwifiex 1.0 (15.68.19.p54)
> verext = w8897o-B0, RF87XX, FP68, 15.68.19.p54
> 
> The compatible string of the DT is "marvell,sd8897".

Thanks.

I think it'd be good to see this info in the commit message, but
otherwise you can carry my:

Acked-by: Brian Norris <briannorris@chromium.org>

It'd be extra nice to see that you successfully use this patch in
your own releases, but I don't think that's a requirement for upstream.
And anyway, the upstream RC cycle is pretty long.

Brian

