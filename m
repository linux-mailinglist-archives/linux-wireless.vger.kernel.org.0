Return-Path: <linux-wireless+bounces-20852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33B1A71A33
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 16:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7F13B33EF
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 15:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5B63C1F;
	Wed, 26 Mar 2025 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VnSG6YCs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE658635C
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002608; cv=none; b=ZEmSIeRsXtza5wIxynGykSw1hT/CMtvUOS0fnOLsb/81jQkV0WU4+tCcqFqZvQrkDqEbQsVMOPOoZqfhCuf3Svd9YQ70zMqu13rDeWV2rvWUxueWKe/zzzpjmmTzyJHcj8OrnYEtV5vKGcVqe08WqAPNeJVj5+q1pyMfa/t122o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002608; c=relaxed/simple;
	bh=k7CJgaBictxhGds/SNqY01GFqGuOdurOMdG05jQsVEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwTe+393Xbio0VjIRAEaxqUGsnflq6BE0VnluTpzdCK+uwIVKGaPmSjhCCwlI4ZxgdtDyjK/Bra+uAAr2Socd1rQ309sRkSkseC+BAfjdufJ9MUBMkp+oYbzb6eabM+awOZEGv/D5NB73GQIp5OUk+HP3ceUZiVaXWeGL0poPAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VnSG6YCs; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223a7065ff8so276875ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1743002606; x=1743607406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oLxpsj3MlyrxzxcTIdl+re05Lx90Epv1ZYMgB2IEZX8=;
        b=VnSG6YCsDLu06T3AZofWIZpF3sCASyaBAApDq+oBCE4Yo9kK/1YRCgQ2tRVMVfF2vz
         9h2hYpvMz6HRbSVw0fXN4hpnFABKKO7c/W35uxVnCbGlM+DYQiCQBRf3L7Ly6594b84K
         /+ze7jiWHufPywIOQl7ML1ZLNXAh7+MSYC+ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743002606; x=1743607406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLxpsj3MlyrxzxcTIdl+re05Lx90Epv1ZYMgB2IEZX8=;
        b=qNCA9C+XE3XLLGf2Jq1hbel8mHJ4hxeFIUWzNonyMrBSkITmkCsLXq3I1qFlMwCcnq
         y3v6qSGpV279jInpEEdLMsKR+iN735D9LcDdJveTBqfIlKj+4fn2os8sL4pxDAHC74Vr
         n0N9U6DjvfmLNbyjSQeTXJGNWOCP+aYkDPXO3U0I79WytdEVB5xmj1/ukG7jDAZNYkJj
         +yw6eXFyfSqnMFBia42Y2VEQbgiRfxdFeNmCACrtqAprkaj+2hpVEVDrRlNE8Mx4QXgY
         N/u+QrETjyniNtt385KqjTe4k3mBXq3FmMH/RnPmvl1woaq2cWEue1NXxdcV1Y3YI6Te
         zV0w==
X-Forwarded-Encrypted: i=1; AJvYcCU8SHX/ZQuLrbYzg9LEiXWanwLIE4lQmW+uUmQjDYr79PIaEicwprcZG5b03Z6m5uzY+nSWrKMCNQ10py+Amg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5SJWPNq5o+kLPb8ryNoNEIc7jhilsRSDy0LTiAlmVY+d4aIPC
	1WcrBQ+92A3bk9NKRexL50rgFkiZoVIjdO+U4YMJUblHFiV4VAYYHM5R7AzNag==
X-Gm-Gg: ASbGncuHik0ui9Xy2Wha/dknyDmPmYrzIlJ8a417tqnod7fTuUaxF70yXIw1tGOncHK
	WgojdJwENYlBeL8ktkmL3ujr+AGAD/EQTz/WmKJ2uOWQ8mlsWky6gjuZWU8O6EQIM7GbSdc3Gs7
	PcfxvCwQiypxMFRIr1hIJUVDZQSHYdSn9o1df51LpKqOmhYg+k67atASWgAGUfEjP2QaRAdhrNj
	lZW1lgv4lapb4bTODww4S5g4F7og7KTU6V6ldSr5I4nEjnN6go8TZvswfguZmMy2xIe9dBc9DSy
	V9PFqXonokZ0OzDhgFYEpMZP2BAlOvCJd/cEaFcHhlxMweamqHklwgxPl6CRJan3WRg6rMTjHhm
	FJiGNsP4=
X-Google-Smtp-Source: AGHT+IEvRqUnkr5RYindS5V2XIwmBMS49KB5BhJjqPUOz/O93KkRT4qX6ryr2KWxJyl0iEG0vMiRlg==
X-Received: by 2002:a17:902:e88a:b0:21d:3bd7:afdd with SMTP id d9443c01a7336-2280456c1f9mr431375ad.0.1743002606123;
        Wed, 26 Mar 2025 08:23:26 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:b885:47c3:6268:77fb])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7390611bd23sm12735632b3a.96.2025.03.26.08.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 08:23:25 -0700 (PDT)
Date: Wed, 26 Mar 2025 08:23:23 -0700
From: Brian Norris <briannorris@chromium.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Jeff Chen <jeff.chen_1@nxp.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [EXT] Re: [PATCH v4 1/2] wifi: mwifiex: Fix premature release of
 RF calibration data.
Message-ID: <Z-Qb6_1-sTZ_LTPs@google.com>
References: <20250220061143.1417420-2-jeff.chen_1@nxp.com>
 <20250318050739.2239376-2-jeff.chen_1@nxp.com>
 <20250319162842.GA46894@francesco-nb>
 <PAWPR04MB9910FE139C88507DE5904ABD9CA72@PAWPR04MB9910.eurprd04.prod.outlook.com>
 <Z-PwgtSRNoCd2L3z@gaggiata.pivistrello.it>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-PwgtSRNoCd2L3z@gaggiata.pivistrello.it>

On Wed, Mar 26, 2025 at 01:18:10PM +0100, Francesco Dolcini wrote:
> On Tue, Mar 25, 2025 at 04:43:33PM +0000, Jeff Chen wrote:
> > From: Francesco Dolcini <francesco@dolcini.it>
> > > On Tue, Mar 18, 2025 at 01:07:38PM +0800, Jeff Chen wrote:
> > > > This patch resolves an issue where RF calibration data was being
> > > > released before the download process. Without this fix, the external
> > > > calibration data file would not be downloaded at all.
> > > >
> > > > Fixes: d39fbc88956e ("mwifiex: remove cfg_data construction")
> > > > Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
> > > 
> > > The code looks ok to me, however I do not understand the commit you
> > > selected as fixes tag.
> > > 
> > > From what I understand releasing the data before using it was done since the
> > > initial commit 388ec385d5ce ("mwifiex: add calibration data download
> > > feature"). What am I missing?
> > 
> > Thank you for reviewing the patch. You are correct-the Fixes tag I included was incorrect.
> > After re-examining the issue, I found that the premature release of RF calibration data 
> > cannot be reproduced, which invalidates the problem statement for this patch.  
> > 
> > I have decided to withdraw the patch. I appreciate your feedback and attention to detail, 
> > which helped identify this oversight.  
> 
> To me the code change is correct, and it is also merged in wireless-next. No
> reason to drop it because of my comment on the fixes tag.
> 
> Brian: are you ok with that?

Oh, sorry, I don't think I really analyzed the nature of the reasons for
"withdrawal". Yes, if it's just the Fixes tag, then reverting isn't even
that helpful. I'm fine with keeping it as-is.

Brian

