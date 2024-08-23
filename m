Return-Path: <linux-wireless+bounces-11832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BDC95C8C4
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 11:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72F01F2498A
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 09:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAED149C65;
	Fri, 23 Aug 2024 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vLgD7Ve/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B20A3BBC2
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724403823; cv=none; b=bsIWrx4OmuxFjP9GRGtKtyn50hvjFqQG185zDczyfp0byVHz6hbpr64fRVenlEWUPuc8+3p2di0crmECERJnY8dmYlSyJqfufLkNWpyKHibNkRnLnnIEX8rCgSAK6NJQwPqApVA5tF3V6cTHKlHQG0obNRAspbFarFEqEW+0Bsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724403823; c=relaxed/simple;
	bh=6pgSQ39T9Plmpl4AfmQ3YZoIf570bVZ3OiwSjBwhTbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZX4+nbdvxHhlj877Gtzjjr/+y0W/aL7Ew6x3PxElKBEUJpNr4hV22ifhL/YYGTl08+i3cy8UkyH7063cK8RuB77MGDIUl5ExnYVx/U1ukbZWlcxi+w4wmcm51csHHtMn0rOEIy76uA2Tsm9AI1QNf90JsgAVcoFrIQt5/QIDsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vLgD7Ve/; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a868b8bb0feso216159766b.0
        for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 02:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724403820; x=1725008620; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ch25zyq2s/Kdq5vfRHfbF0eBNHDOnxoEELCgVT5D+gE=;
        b=vLgD7Ve/o/cPnb7cLiXpOQqmPNttBCGV+UeNVDQrDotU+n1ASD00YRi+k/MIdiFPu+
         uuqcBiV16yoj26GoGSQDWiHOzNXqjJmixNolLiUAyTSBGcIEr97nNIk3jCrlyoWy0LC9
         x8i2XHp6C7LUWL4R0ilYpRBZ1F0MwJsljuAWIFFrbOjOOXm1y6oz6p+1R4Zq3Ud5Iexl
         MjzdVcew0NErhMuHvgctJgI+hLbcKkkVDotjSaEqmgu0kfJ4cOGoiab12DUzRZzEQ5OO
         hM9W1YxHcMHNBcNNHSiPbTyW8jE2wJIyrhBrTtTqK+9Y6E+34GmrD5amAjsk91lDJbX0
         S++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724403820; x=1725008620;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ch25zyq2s/Kdq5vfRHfbF0eBNHDOnxoEELCgVT5D+gE=;
        b=OjD3lmP+wekYF+8jGAwnr70PKL1eQUBoOa1ol90wLnl7EAhUQBTEfLtiZoGowN6Z5Q
         uNxNbTD6H1ugVjbzEINF5D9N80/yoWp+grQu6gTphGtXg1IKoX8345+jd5E3eaSAMedu
         /5O00OKmtB5mgSRFB+uT7DJUDQthiK6Tbl/yAkrDbBlFEOLFUstHvjH01P4U8bVbaSLo
         HAFUhLJCBIqFK5wqVlgHRgjMu+dqpxyjbL5I6X8jcuOU3O80V1wRfH0Bng3ClAMxewau
         3wzMrzbX6QUJcisQ/uV8pBaV0y6B8vsvFO7udH19wF062Vf3HdHjLfjXpYsxAXtn5Kq9
         WfjA==
X-Forwarded-Encrypted: i=1; AJvYcCUgiWG0k4VbOHiVmEIOkvjeSd4Fh+2sO8G8ME6djhdHQGdU5grRprrQxxYEDtWg9PRmNPBph+0WZDpXjUvhgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCd3s8w0DnU2DXSjLbTCFxCRh3jPb74S/rv/buLqsLKo9bvjeV
	7Gb+qCe94/E0SKPaeurRt+lo9HPYMPv1U5B/KIDXUkA6rDJKqwmHvgB4vFpmQ3w=
X-Google-Smtp-Source: AGHT+IFL2ahd9iW6kioYgjRY7ywdjB0PoAxv2j34f9YFYNVQDqx3JkjYGC0pnPM8LImqUDl7HFqgZQ==
X-Received: by 2002:a17:907:7f12:b0:a7a:bad3:e5b9 with SMTP id a640c23a62f3a-a86a5168f1cmr93975766b.11.1724403819514;
        Fri, 23 Aug 2024 02:03:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2e48e2sm230158366b.89.2024.08.23.02.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 02:03:38 -0700 (PDT)
Date: Fri, 23 Aug 2024 12:03:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: benjamin.berg@intel.com, daniel.gabay@intel.com,
	gregory.greenman@intel.com, johannes.berg@intel.com,
	kvalo@kernel.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, miriam.rachel.korenblit@intel.com
Subject: Re: [PATCH RESEND] wifi: iwlwifi: mvm: fix an error code in
 iwl_mvm_alloc_sta_after_restart()
Message-ID: <3a9fc675-9c39-47e1-8735-a9d107b4d0be@stanley.mountain>
References: <575625da-60bc-4444-a5f3-a7acf925f1e5@suswa.mountain>
 <20240823030423.1781977-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240823030423.1781977-1-make24@iscas.ac.cn>

On Fri, Aug 23, 2024 at 11:04:23AM +0800, Ma Ke wrote:
> Dan Carpenter<dan.carpenter@linaro.org> wrote:
> > The Subject says RESEND but doesn't explain why you are resending.
> > You probably meant v2, but again it needs an explanation.
> > 
> > On Fri, Aug 02, 2024 at 12:27:40PM +0800, Ma Ke wrote:
> > > This error path should return -EINVAL instead of success.
> > 
> > Why do you feel that way?  Have you tested it?  What is the user visible
> > effect of this bug?
> > 
> > I slightly feel hypocritical because I have send lots of commit messages
> > with exactly this commit message.  The difference is that I only send
> > really easy patches where it's obvious what the intent was.  A normal
> > kernel developer wouldn't need to leave their email client or view any
> > outside information to see that my patch is correct.  If a patch is not
> > dead easy, I normally just report it.  (Sometimes I report dead easy
> > bugs as well because I am lazy and maybe it's the end of my work day
> > or whatever).
> > 
> > This patch on the other hand is more subtle and it's not clear why the
> > continue statements changed into returns.
> > 
> > regards,
> > dan carpenter
> Thank you for your response to the vulnerability I submitted. Yes, we 
> believe there is a similar issue. As described in [1], it gets pointers 
> which are handled under the protection mechanism. If the path is error, it 
> should return -EINVAL directly instead of success. The discovery of this 
> problem was confirmed through manual review of the code and compilation 
> testing. And by the way, I resent the patch because I hadn’t received a 
> reply for a long time, so I resent it.
> 
> [1] https://lore.kernel.org/all/MW5PR11MB58102E1897D7437CD8E1DF27A3DDA@MW5PR11MB5810.namprd11.prod.outlook.com/
> 

Oh, huh.  If I understand it correctly, you're copying the logic from my patch.

71b5e40651d8 ("wifi: iwlwifi: mvm: fix an error code in iwl_mvm_mld_add_sta()")

That was a different situation:
1) The code was already doing a return instead of a continue, it's just that
   the error code wasn't set.
2) I mentioned in my email that I wasn't sure of the logic, but just copy and
   pasting from similar code.
3) Plus my code is on a WARN_ON() path so it's almost certainly dead code.  That
   means my patch was very safe.

Meanwhile Gregory's code looks deliberate.  If it's causing an issue at runtime
definitely we need to fix that.  Or if we can find a bug in it then sure.  But
don't assume my code is better than his, because it's likely not the case.

regards,
dan carpenter

