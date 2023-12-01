Return-Path: <linux-wireless+bounces-304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E46801269
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 19:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A141C20996
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 18:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CEF4F1EA;
	Fri,  1 Dec 2023 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ME+7xuSh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9EF10D
	for <linux-wireless@vger.kernel.org>; Fri,  1 Dec 2023 10:17:04 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d065be370aso3981525ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 01 Dec 2023 10:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701454624; x=1702059424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=80BOfbzU3jRYQRqKUun9qybGXNm0Ak9QPhMAb8Oq5lY=;
        b=ME+7xuShkkCd0062a9EL0L48UcVgl2XNVW5BRL6HrY/mg3DiShxSdpn7IJmQxj/w1W
         y6Kih+9DYWaLfoqYp+5pe938En1UXK6dzqyoieMKZZnN5wPV/Uq1I9TVzm7jMnnSzyry
         5cZjnWvfXpQLdgXob0ttJuENteq2/BltyHmws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701454624; x=1702059424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80BOfbzU3jRYQRqKUun9qybGXNm0Ak9QPhMAb8Oq5lY=;
        b=uTsyHrYLT3ExY6GPdVP/2OVCe7yCtwYs1YGqNeKMx/8WCkJKc/qEgEkGxpkNS+LOQt
         SmxCkQlWqYhhKP8KjUQ2HAsCivAcQkboYHLhMTVGFZA0Yp9+jpJvQE4fmJ78uW0jHpc8
         WS84++UJIaROmW5UjEAkXNwlOmE0DDAw1jnyU2qgvphiOj65QsMgkonVmqrOvia7HTKO
         xSqL7+ZlT/lXb0o+Vb3FsHMrUecsU0WDhOs+Z76EyIUFuGSDBdfpj1i3VcrxDAcspgRD
         hrrEOFie8XgBAVxIc39rylyX/wWc2k+7UVU7CPAu6AL0JNRVAshrIKIeknUmrsBfiVb9
         mdeA==
X-Gm-Message-State: AOJu0YzM4guJtav8m1KGS3MBY3FFko+pbEgFzs/zzohDQKRIXUz+nHsj
	w+49B2oorp33hj7dh9fuTYIYKi2J/c6NTcGXjV8=
X-Google-Smtp-Source: AGHT+IHL4QH3wU1zQC3wiy9r3528WOQq1iSHFfDCieTdatztPnIyrMoq50t3CKZORUjazAX/9P8zkg==
X-Received: by 2002:a17:902:db06:b0:1cf:c376:6d7f with SMTP id m6-20020a170902db0600b001cfc3766d7fmr26246754plx.42.1701454623948;
        Fri, 01 Dec 2023 10:17:03 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b001cfb99d8b82sm1570921plk.136.2023.12.01.10.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:17:03 -0800 (PST)
Date: Fri, 1 Dec 2023 10:17:02 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kernel test robot <lkp@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Michael Walle <mwalle@kernel.org>,
	Max Schulze <max.schulze@online.de>, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] netlink: Return unsigned value for nla_len()
Message-ID: <202312010953.BEDC06111@keescook>
References: <20231130200058.work.520-kees@kernel.org>
 <20231130172520.5a56ae50@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130172520.5a56ae50@kernel.org>

On Thu, Nov 30, 2023 at 05:25:20PM -0800, Jakub Kicinski wrote:
> On Thu, 30 Nov 2023 12:01:01 -0800 Kees Cook wrote:
> > This has the additional benefit of being defensive in the face of nlattr
> > corruption or logic errors (i.e. nla_len being set smaller than
> > NLA_HDRLEN).
> 
> As Johannes predicted I'd rather not :(
> 
> The callers should put the nlattr thru nla_ok() during validation
> (nla_validate()), or walking (nla_for_each_* call nla_ok()).
> 
> > -static inline int nla_len(const struct nlattr *nla)
> > +static inline u16 nla_len(const struct nlattr *nla)
> >  {
> > -	return nla->nla_len - NLA_HDRLEN;
> > +	return nla->nla_len > NLA_HDRLEN ? nla->nla_len - NLA_HDRLEN : 0;
> >  }
> 
> Note the the NLA_HDRLEN is the length of struct nlattr.
> I mean of the @nla object that gets passed in as argument here.
> So accepting that nla->nla_len may be < NLA_HDRLEN means
> that we are okay with dereferencing a truncated object...
> 
> We can consider making the return unsinged without the condition maybe?

Yes, if we did it without the check, it'd do "less" damage on
wrap-around. (i.e. off by U16_MAX instead off by INT_MAX).

But I'd like to understand: what's the harm in adding the clamp? The
changes to the assembly are tiny:
https://godbolt.org/z/Ecvbzn1a1

i.e. a likely dropped-from-the-pipeline xor and a "free" cmov (checking
the bit from the subtraction). I don't think it could even get measured
in real-world cycle counts. This is much like the refcount_t work:
checking for the overflow condition has almost 0 overhead.

(It looks like I should use __builtin_sub_overflow() to correctly hint
GCC, but Clang gets it right without such hinting. Also I changed
NLA_HDRLEN to u16 to get the best result, which suggests there might be
larger savings throughout the code base just from that change...)

-- 
Kees Cook

