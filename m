Return-Path: <linux-wireless+bounces-245-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B377FF9D0
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 19:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3195E2817C8
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 18:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCFE524DD;
	Thu, 30 Nov 2023 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oQ6FPkqI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4281010DE
	for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 10:46:10 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d00689f5c8so12133595ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 10:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701369970; x=1701974770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MqmKExj/Mv5RpM6S+8jCnwhQH5wvdmwNgK4JjLqPLxY=;
        b=oQ6FPkqIzhWZgclPAY5/g3/AvTivkr1FX8Nq4GVs+xJ48BnxZvL0lu641S2+MrNVOP
         YDCtTWMYqMwrbK+VEkvIYLy/X6R2bnAKbBBm9najUQMbhbkElraGDXX2mdnzJHdFzqw1
         YXNqwLT7Ndxsfx1fdpMYTSRfI3S7Bh3Y8nkko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701369970; x=1701974770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqmKExj/Mv5RpM6S+8jCnwhQH5wvdmwNgK4JjLqPLxY=;
        b=cT3YTUz6NQouOq1zzXKnZ6vFTVfbMOPvzIY18N5GpKq6l4V156dmDy74qJ8dHWxeEV
         bxmnoEHeZ9kiIzd2IEN8Q8smpvudlUlZQnQ/kmVZbfzdfyI8VCr1+UoyNFvSPIC6hj9U
         Q/dnw223fEEk8EdJtYr0HK3kSIr6i/dg3JL3i8F2z/B5Eba/uzfN6ondaHIhNOMUuAMk
         4sn/DZACcwwU4NUYAbiGwWucjUGCVW5q969bjO4CGPBdeOXH87XkkWU/RE+2fUMG6LhO
         D+MhFchnbad0UV/vYJpLVV5l8uw+zOH8Mm/dZua7h4lMOwPdnVUa7uSHr6Jgv+NZ9gbW
         wJMw==
X-Gm-Message-State: AOJu0Yyz2k3/Eqj5xHK8bkFbOhAdPdYqnnlSUGbn6F40O4pZ6iX1wX6R
	cSzxVSLMzIP9BFRBxkuZYFk5+jIJsrdwD25+Yx8=
X-Google-Smtp-Source: AGHT+IGMeNXhdzIngIMI6Tzqw3ooKUlw4KdmTCBArrH5SoAcoNzPZ+6yZoCGN0NfHiDu6oY1EIRIjQ==
X-Received: by 2002:a17:902:c106:b0:1cf:cd57:5ee7 with SMTP id 6-20020a170902c10600b001cfcd575ee7mr14635168pli.28.1701369969718;
        Thu, 30 Nov 2023 10:46:09 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902e5cc00b001cfdf290e82sm32218plf.35.2023.11.30.10.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 10:46:09 -0800 (PST)
Date: Thu, 30 Nov 2023 10:46:08 -0800
From: Kees Cook <keescook@chromium.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Michael Walle <mwalle@kernel.org>, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	Max Schulze <max.schulze@online.de>
Subject: Re: [RFC PATCH] wifi: cfg80211: fix CQM for non-range use
Message-ID: <202311301045.6DA830F7@keescook>
References: <202311090752.hWcJWAHL-lkp@intel.com>
 <202311090752.hWcJWAHL-lkp@intel.com>
 <1c37d99f722f891a50c540853e54d4e36bdf0157.camel@sipsolutions.net>
 <fc1dbe4a-a810-445c-9398-60a5e55990a2@quicinc.com>
 <202311301016.84D0010@keescook>
 <01e3663e9e1418a183ee86251e0352256494ee28.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01e3663e9e1418a183ee86251e0352256494ee28.camel@sipsolutions.net>

On Thu, Nov 30, 2023 at 07:40:26PM +0100, Johannes Berg wrote:
> On Thu, 2023-11-30 at 10:32 -0800, Kees Cook wrote:
> > Yeah, I would expect this to mean that there is a code path that
> > GCC found where the value could overflow. It does this when a variable
> > "value range" gets bounded (e.g. an int isn't the full -INT_MAX to INT_MAX
> > range).And flex_array_size() was designed to saturate at SIZE_MIX rather
> > than wrapping around to an unexpected small value, so these are playing
> > together it seems.
> > 
> > However, I would have expected the kzalloc() to blow up _first_.
> 
> Hmm.
> 
> > Regardless, I suspect the addition of "if (n_thresholds > 1)" is what is
> > tripping GCC.
> > 
> >                 int len = nla_len(attrs[NL80211_ATTR_CQM_RSSI_THOLD]);
> > 		...
> >                 return nl80211_set_cqm_rssi(info, thresholds, len / 4,
> >                                             hysteresis);
> > 
> > Now it "knows" there is a path where n_threasholds could be [2,
> > INT_MAX].
> 
> Yeah, it's not _really_ bounded, apart from the message length? But then
> struct_size() should saturate and fail? But I guess it cannot know that,
> and limits the object size to 1<<63 - 1 whereas the copy is 1<<64 - 1...
> 
> > Does this warning go away if "len" is made unsigned?
> 
> Thing is, neither Kalle nor I can even reproduce the warning locally, so
> it's a bit hard to check ... not even with their config and gcc 12.2.0
> (nix, rather than debian though.)

Ah! Hmm. Let me see if I can coax out the warning locally...

-- 
Kees Cook

