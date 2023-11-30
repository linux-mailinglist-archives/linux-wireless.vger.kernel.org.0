Return-Path: <linux-wireless+bounces-249-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 430917FFA77
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 19:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1EAD281AA3
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 18:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D4E52F63;
	Thu, 30 Nov 2023 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hawQL+mB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39D1B9
	for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 10:55:17 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d048d38881so3772305ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 10:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701370517; x=1701975317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o/bzlkcxWIvJcapDgBF0UDoZol+j+J/d9ElDaLghBao=;
        b=hawQL+mB3Vnn9+MHvxrIcDi7bIY+9/pSmY5L34FlNEX4YWa05gJIx8WFVVoDzuY7AW
         fUruq12wxwxgaKBjnbj5oskSHMWbYXqVjTXEIUESAeHen5Q7YeTiwkNAstZSIGIY7IKN
         gtVk4EtyK8AcNURP0aiOZO7NHivBzxqFwgV8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701370517; x=1701975317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/bzlkcxWIvJcapDgBF0UDoZol+j+J/d9ElDaLghBao=;
        b=HgTvraYS/mvjXeA1MBsG0ayD+wEjGA3g9yxTVcx0VWSdYIwUcYtv1CkOBI4Sjw0Ddn
         5Lf0CYGMADOCVZVMPrACTBG4Ozpom0tuugpqqamvAe+XKyfWigG+p7rcFddkqb8+oH+Y
         0IPTdwASDt5rRKBt/Z3Ri2T9H0HfJVf38iv+2F2gCoRNwJTNs5ynumKa4u/F1K6rlc5G
         +rbEAzo0Lq1hhCOVpOulKFAPZLPdwqtSKuisDsIm9y8O545cOHf0ofCWor8nGaSTKhea
         LAUZPUr+zwI14EKlo4RzLRSrYdHjwmymvisCCpHQ55hbidZZ2ZHFFiGnrXQ+j7b4z8+6
         kZMQ==
X-Gm-Message-State: AOJu0Yy4/6pfmHn7nYuYQmPTJK6AC7xQgPKaTyCi7d+bpmqWp5hjT4BP
	pVjNlU2bz7edqPsywIAeSzLBXQ==
X-Google-Smtp-Source: AGHT+IG9wFLvlwyxfm/BW91USfaiVHUUl147jWOXSej9Wr/vbn4JU0jdWKnBu9zl2klYM+Jj8oAI9Q==
X-Received: by 2002:a17:902:c1d5:b0:1cc:45df:4710 with SMTP id c21-20020a170902c1d500b001cc45df4710mr21374814plc.40.1701370517354;
        Thu, 30 Nov 2023 10:55:17 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902904900b001bd28b9c3ddsm1727297plz.299.2023.11.30.10.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 10:55:16 -0800 (PST)
Date: Thu, 30 Nov 2023 10:55:16 -0800
From: Kees Cook <keescook@chromium.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Michael Walle <mwalle@kernel.org>, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	Max Schulze <max.schulze@online.de>
Subject: Re: [RFC PATCH] wifi: cfg80211: fix CQM for non-range use
Message-ID: <202311301054.0049306B7@keescook>
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

Actually, this alone fixes it too:

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 167b91348e57..c59679524705 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -1214,9 +1214,9 @@ static inline void *nla_data(const struct nlattr *nla)
  * nla_len - length of payload
  * @nla: netlink attribute
  */
-static inline int nla_len(const struct nlattr *nla)
+static inline u16 nla_len(const struct nlattr *nla)
 {
-	return nla->nla_len - NLA_HDRLEN;
+	return nla->nla_len > NLA_HDRLEN ? nla->nla_len - NLA_HDRLEN : 0;
 }
 
 /**

-- 
Kees Cook

