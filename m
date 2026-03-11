Return-Path: <linux-wireless+bounces-32980-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ON7DDINEsWlCtAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32980-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 11:31:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C40262396
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 11:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4EFD348B9A0
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 10:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0BC3C873B;
	Wed, 11 Mar 2026 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="pZIoQHWj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8890C3C942B
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224507; cv=none; b=dSzwA8K8DShk6w7pH14q8ryCYKUlvLBx7839r6vNsWeTCxIMfPTMeRKX4kZLxIz2GIaK8bI1qP8tSHaUNrSTSKOlx/zSyQPaVEi9f0Q8OJfTL3j9q9csz/ggQOCa0vls5MljW2rrc3gX5YTCnMZJk/eP3Wecwt1NkhMbXdMj1Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224507; c=relaxed/simple;
	bh=DdadgcMl80ZQxddOlaA1t7EQr+GrSbHyE7IwiqASbkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsA1NkWpPiFoC+zdL53Nl8kCIv7KAoXBrihRLWPr2J20dmZ2coE5L3kVWdA1KvOJeE8dAF8XadJmWPvWuxW4fvy8jlh0g23MnD+gbXHN3xacgNoeSuxQq42PBNdFyI2v/FeVHh3qBRzbL3PJCtlaNB2Bgn9A9Y6alCK+zdSxUcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=pZIoQHWj; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so12766730a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 03:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1773224506; x=1773829306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CU8re/eLsja5JXlIoPMEPU6pT0QnmhbCVMr2nR3TJxU=;
        b=pZIoQHWjP83rkQAEYhHwYO+ukaDxkr+JB/3fXelTS8zExGoH1yNA4jYapGWv9S83ND
         x3Czstt1Vo/tUCm5zo03A9Mbc92BIg/Jv/7dG/F3n/6EB+Exd2+uvQP2pd/bOOAfBZ52
         GNl5kHtQXsX4CquSKyHYvhuhbA2YAXPohyqDebEx4XjMrWq+fEnkc/YfvrpfuyTO+FJ+
         gNROwTI12AM4QYvtM3HJcR2+JouO26Ykg4s+u/WEC0SXiKYE5nF4sW3vyzioLHLpNvJi
         a4/ThzdcYgvWYfocotN0LdCZRiPYOshcPaYuCTUYc5/TruVkvOSLPJpQhsgcaneux0xK
         1NKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773224506; x=1773829306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CU8re/eLsja5JXlIoPMEPU6pT0QnmhbCVMr2nR3TJxU=;
        b=Egg2ecMRZJv1KrK/Bf8pDLzLKU8tc+thp3VzBfyqKISecs+BE/FTLbPDRReycIPdRM
         TyOBZLfr45jzXsZ0RJGO/8Si9NOurlL5tx5r/MHtin1TRyFC1CR9lJBRciAF7iwtLKTH
         QHjvCnrlu6F0+sBqgyzlrtd2Df5RvFquFFuy0HBEzmSOC3q7CplzP+F3uvmpTflx+bx+
         rPDkrxs/w2VPk09CpBHJYOrl6NmKO28gxpizNUyy74npnCvea0bZHwkMlyaBdYzBAZMy
         j998Qm7s9O6LOy70wU+8GvXMvQz72sNqjLySvZhRyqv8n+OX/nbRd6TBO+LQz4TAZl4S
         BO9w==
X-Gm-Message-State: AOJu0YxYigv0rkt8t1TDufCJGbT0gpwO/2nl12jdgKxweBgiFk3YihMC
	c99fmP+4HBfkreEGWALRU9RKlw1/zjEzn2lrbIJDufVnfE0EviNcHHsQDX1b7qyJ1mc=
X-Gm-Gg: ATEYQzwHXxKrAWaWEeizXOsg2UvqFD9U764a7Zipd5JmjMDfB56vOOoQLPykwwvmP26
	DIeuO2URF7w9jlXfwHT+xTnqI1oRdQcVR33Yvk/1aEwmI0HexTvQZD3n3KXOCfhg5g5mIZRVJdo
	j8jKwqItc++Aa7wLAmMOPAEbaIvhJ8FsHAgMvCDr7tGMiqyPx6ysClbTNaRKclWfJODahZgPmhv
	o8SV06Hlu01XNLKybiZeo/NpE9B6vhuyddGBX/xtaHFOcaDEPK0B2ll8gZqodwve5aBPH0nrPGf
	xu2+HtpXPo0/yx6Q2r3zi+MbSazg0juczbasWU939oeAGcXSHnjm4xqxNtkhtOb9VNBL9e7oNka
	0igfV8dOLtBwbw/gsFsbIVjGJkxxWF3Sad+Zv2oLRdxL97Y1FlEyoQdrdW3OrTLSiOgxqSVOkpz
	r197pyH5Uo0691D2oOtPJPEKJsyEtlLzVJ3xK6ylxuINdX1vyTOofLiOlWS85Oy6FU
X-Received: by 2002:a17:90b:3dc7:b0:359:8d95:4a4f with SMTP id 98e67ed59e1d1-35a01357ecdmr1729693a91.32.1773224505765;
        Wed, 11 Mar 2026 03:21:45 -0700 (PDT)
Received: from localhost ([60.227.233.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02e7a2edsm1800297a91.7.2026.03.11.03.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:21:45 -0700 (PDT)
Date: Wed, 11 Mar 2026 21:21:41 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [PATCH wireless-next v2] wifi: cfg80211: init S1G properly when
 creating chandef
Message-ID: <4dhrrbuvxdgve2doc7qvabzjancimtqpounngyrxspk4d4rbls@xnad5bwciz7c>
References: <20260311064339.524758-1-lachlan.hodges@morsemicro.com>
 <791eaf8ab04dcbe01e2d71612d162f71c61e573a.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <791eaf8ab04dcbe01e2d71612d162f71c61e573a.camel@sipsolutions.net>
X-Rspamd-Queue-Id: 86C40262396
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32980-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,morsemicro.com:email]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 10:55:46AM +0100, Johannes Berg wrote:
> On Wed, 2026-03-11 at 17:43 +1100, Lachlan Hodges wrote:
> > When creating a chandef, the initial width is determined by the
> > chan_type argument leading to a default width of 20/20_NOHT/40 which
> > does not make sense for S1G channels. Fix this by ensuring we default
> > S1G chandefs to a width of 1MHz.
> > 
> > Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
> > ---
> > v1 -> v2:
> > 
> > - Remove the mac80211-based wording in the commit message and keep it
> >   simple.
> 
> Thanks :)
> 
> Now with more tea and all that, do we really want it to completely
> ignore the width? Should that be documented? Almost feels like it should
> WARN if you use it wrong, with an S1G channel but a regular width, and
> mac80211 should be fixed?
 
When you say "ignore the width" do you mean nothing checks it? If
that's the case we probably need to add something within
cfg80211_chandef_valid() to ensure if we have an S1G chan we don't
have a non-S1G width i.e > 16MHz. That would fix mac80211 from
giving it to the driver in the first place.

lachlan

