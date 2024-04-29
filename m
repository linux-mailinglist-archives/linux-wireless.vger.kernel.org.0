Return-Path: <linux-wireless+bounces-7006-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049508B62E6
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 21:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0101C21B6A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 19:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F22613AD30;
	Mon, 29 Apr 2024 19:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b8d14gqH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40453128807
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 19:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420373; cv=none; b=CQesmSQlgDmv+IY5EV+d3XF64HwnQvXstnXp4kfoOOZVxAHiv/brKm7lH6++D4bR5ylXA7uWPaUcjfKpBkQkJKMY2Dr8gpyWMU+qDoK+9Gl9exILp01Vjc7MqzImJLztg46YyYGcA7YQ4HBlnvkimO5NTbGj/9Swq0jTWXM2OLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420373; c=relaxed/simple;
	bh=TNV8us/6NnA8JuXeuStfxViNa9eMxew5hUMJ0dTnbaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvlZq8o2gVrZtA28vpr8aCVBq54a5Os5ezUhUPg//xeCtYd9SpHZTpsTF5+03keV/uCX8Sf0hdMyfGX+S882eAnIvGEwwDhO4m7NguUdR97qQnnwYPVIz7EL3w4xZ6SxsLXfkn/610GFSMuvtpvWSxwSG/jsapuYJIH6+eCOLa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b8d14gqH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e3ca546d40so41438125ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 12:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714420370; x=1715025170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DzuTy06wG7m8jkWQy8dNk6D9cIiYm7VWueBizCkNUFc=;
        b=b8d14gqHNWCF0f8BhxPqSzkHHqNIBlOLXLYfa4S8GdtbMGSgpgbh47meFNWoNdRVE3
         HM1YhUlkEDsYPOvv9OobJt0/s8NLlLGLAejMNlQOBpvcgSHEMnGjieu1G+NWrh5Vod/c
         3Tvdasf00vkevGXcPP4nauuvrfFqbWvUDFrUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420370; x=1715025170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzuTy06wG7m8jkWQy8dNk6D9cIiYm7VWueBizCkNUFc=;
        b=WnyGjo9/tyDS+j88TJC2aDkaJ1mGnyb2z0TKTrSG9MZTgbM4+1pATYMcpaEj0UaOME
         jxx6UNHqQlvj+DmyxOx3gtg2bJbDWmwyjpXDwRHvJh53vUl6+jW7dPwNMfhfPducAKFK
         yqSQRI5WYKc+2/yefxoiOV/kbq+onOPvz/per4736ooW4JbdObRdRR3hLtvrEisssQ67
         jftBWjLDzn9GxEop8S375mqb8LbVtxgLh7F/d3/PkinaacGt7EaiXjF6sWXVDHVcvWQJ
         52s9S/mNjhqVtRY0xI1m4Nd0IplY66JeAtsrPXBi+simJmjQR4G3L+Ullg9Wo6eJGwVh
         LiIA==
X-Forwarded-Encrypted: i=1; AJvYcCWt3BeiwVhbaCcrzQmsr7P5UkP1O2bvCbYq2zqqXMAkCKqXpRE4V+Ho/XkZnnN8MtXFiTSXdxE1cXzRwwjDAlmaWLhK1twM2JwTxha33Ro=
X-Gm-Message-State: AOJu0Yz0B3IHlSE7w3diWsGUK6SqFI+gfDBpJnl73YVwqxtewUts9HzZ
	ct+oALNOK8qZt8Xse9Ldkf2TCsAAoWmd6GhVDZcR9dPEn1myI1UXM3qM/Qgs+g==
X-Google-Smtp-Source: AGHT+IH6R15V6HIyl661wmHcOEZXcog7rxy3zKQh4WZRVF2N9wXnAwIZ5BHVnBVQzm3UTDvQLLyBiQ==
X-Received: by 2002:a17:903:230f:b0:1eb:22fb:6793 with SMTP id d15-20020a170903230f00b001eb22fb6793mr853821plh.39.1714420370630;
        Mon, 29 Apr 2024 12:52:50 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902a38900b001eb0dd08d96sm6549425pla.57.2024.04.29.12.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:52:50 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:52:49 -0700
From: Kees Cook <keescook@chromium.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] wifi: wil6210: wmi: Use __counted_by() in
 struct wmi_set_link_monitor_cmd and avoid -Wfamnae warning
Message-ID: <202404291251.9CBC42E481@keescook>
References: <ZgSTCmdP+omePvWg@neat>
 <171222554691.1806092.8730005090791383928.kvalo@kernel.org>
 <202404291008.51DB333F@keescook>
 <877cggqdwb.fsf@kernel.org>
 <202404291109.331E1704@keescook>
 <87bk5sf003.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk5sf003.fsf@kernel.org>

On Mon, Apr 29, 2024 at 10:21:32PM +0300, Kalle Valo wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Mon, Apr 29, 2024 at 08:25:56PM +0300, Kalle Valo wrote:
> >
> >> Kees Cook <keescook@chromium.org> writes:
> >> 
> >> > On Thu, Apr 04, 2024 at 10:12:28AM +0000, Kalle Valo wrote:
> >> >
> >> >> "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
> >> >> 
> >> >> > Prepare for the coming implementation by GCC and Clang of the
> >> >> > __counted_by attribute. Flexible array members annotated with
> >> >> > __counted_by can have their accesses bounds-checked at run-time
> >> >> > via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> >> >> > (for strcpy/memcpy-family functions).
> >> >> > 
> >> >> > Also, -Wflex-array-member-not-at-end is coming in GCC-14, and we are
> >> >> > getting ready to enable it globally.
> >> >> > 
> >> >> > So, use the `DEFINE_FLEX()` helper for an on-stack definition of
> >> >> > a flexible structure where the size of the flexible-array member
> >> >> > is known at compile-time, and refactor the rest of the code,
> >> >> > accordingly.
> >> >> > 
> >> >> > So, with these changes, fix the following warning:
> >> >> > drivers/net/wireless/ath/wil6210/wmi.c:4018:49: warning: structure
> >> >> > containing a flexible array member is not at the end of another
> >> >> > structure [-Wflex-array-member-not-at-end]
> >> >> > 
> >> >> > Link: https://github.com/KSPP/linux/issues/202
> >> >> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> >> >> > Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> >> >> > Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> >> >> 
> >> >> Patch applied to ath-next branch of ath.git, thanks.
> >> >> 
> >> >> cbb0697e0ded wifi: wil6210: wmi: Use __counted_by() in struct
> >> >> wmi_set_link_monitor_cmd and avoid -Wfamnae warning
> >> >
> >> > Hi,
> >> >
> >> > I was just walking through our patch tracker and noticed that I don't
> >> > see this patch include in -next yet (as of next-20240429). Is there a
> >> > flush of the ath-next queue planned soon? Or did I miss some change?
> >> 
> >> Yeah, wireless-next was pulled last week so most likely we will create
> >> ath-next pull request this week.
> >> 
> >> BTW we are planning to move ath.git to a new location, rename branches
> >> etc. I think we'll see if we can also setup it so that it can be pulled
> >> to linux-next, so that you don't need to ask this every time ;)
> >> 
> >> (Just joking of course, there a lot of benefits from having the tree in
> >> linux-next)
> >
> > Ah-ha! Thanks. Yeah, sorry if I keep asking about that. It's different
> > from other trees, so it doesn't stick in my head. :) I should keep
> > better notes!
> 
> BTW I think all vendor specific wireless driver trees are not pulled to
> linux-next: iwlwifi, mt76, rtw (Realtek) and ath. So with all of these it will
> take a while before the commit is in linux-next.

How long is "a while"? And if the latency can be reduced for these, it'd
be nice since it would allow for longer bake-time in -next.

-- 
Kees Cook

