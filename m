Return-Path: <linux-wireless+bounces-247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCAD7FFA0D
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 19:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5461C20DF8
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 18:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B91F5917D;
	Thu, 30 Nov 2023 18:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qq0Lo0U7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344DF10DE
	for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 10:52:35 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cdfb721824so88508b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 10:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701370354; x=1701975154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LGsCThw/8M7WGjjcEO752+1Pv8AcjBfcid6too1NUdc=;
        b=Qq0Lo0U7xp+kn9vdp7A22UBlJFLHIU2VZbeqF0Opfh3RJx6e2WV1sg4jU9NeOUflyx
         LqalS1Nz0QZ/6dhbQ3C+ascdo7UTbE0fDgYnAeDLMb6RLDb/SaaTX7apJPNIILbnuDK4
         ZXG2x05v1IOVlwpl/SfvpLyv/BNX4vlK8SkE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701370354; x=1701975154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGsCThw/8M7WGjjcEO752+1Pv8AcjBfcid6too1NUdc=;
        b=p4Dz13HUX1J42e+XHOwlFk1Vl6SRwpmw3cbHJRQXp6JnpI734w392qt0TY+00jCCFV
         VSNNh9ka/fKbVMvgK+ccEdDR0DRhvfiqinmoY9VvVbF0R/LfbDVAz6fnbuTUGSPI+Hmq
         X7BiZdnoTmRw8CzJWDnEsWty3edTRZqXxtrNwxQklIGVP3fp0Jd9euUqtbOEl2qQpNpw
         R7zmws7Jo5j6kCjrV5y2Q1ayHHJ46z6o74OmndBPuO34IGbNxv6hIwrgjhuFt9QkzQSd
         3LkXUmHcP5oPP9H3kZP1SLMLO6KVDhOXXfZzdPOZPeq5b6vcnFapPWMDBTK7l0NvWIzZ
         7MRQ==
X-Gm-Message-State: AOJu0YxGPdZMkydKBcv3xhXIXEkVkj1P9UZgvYHhgdo2KGTqLtcQ30Ko
	ICOAiaifJ/U5hp9HEEs1qrJVjA==
X-Google-Smtp-Source: AGHT+IGn3UR6bxk65+ndMSgaMec8KdlQ2/Wv4uC1wrrgvr6kaZ0oQywWQjkjywooD15YymGT/9lKXA==
X-Received: by 2002:a05:6a00:1807:b0:6cd:fada:31a7 with SMTP id y7-20020a056a00180700b006cdfada31a7mr423361pfa.7.1701370354683;
        Thu, 30 Nov 2023 10:52:34 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v2-20020a634802000000b005b82611378bsm1563169pga.52.2023.11.30.10.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 10:52:34 -0800 (PST)
Date: Thu, 30 Nov 2023 10:52:33 -0800
From: Kees Cook <keescook@chromium.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Michael Walle <mwalle@kernel.org>, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	Max Schulze <max.schulze@online.de>
Subject: Re: [RFC PATCH] wifi: cfg80211: fix CQM for non-range use
Message-ID: <202311301050.C4BFFB9837@keescook>
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

I was able to see it with Ubuntu's GCC 12.3.0 and their config. This
fixed it for me:


diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d0f499227c29..7735d178a393 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12845,7 +12845,7 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 }
 
 static int nl80211_set_cqm_rssi(struct genl_info *info,
-				const s32 *thresholds, int n_thresholds,
+				const s32 *thresholds, u32 n_thresholds,
 				u32 hysteresis)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -12948,7 +12948,7 @@ static int nl80211_set_cqm(struct sk_buff *skb, struct genl_info *info)
 	    attrs[NL80211_ATTR_CQM_RSSI_HYST]) {
 		const s32 *thresholds =
 			nla_data(attrs[NL80211_ATTR_CQM_RSSI_THOLD]);
-		int len = nla_len(attrs[NL80211_ATTR_CQM_RSSI_THOLD]);
+		u32 len = nla_len(attrs[NL80211_ATTR_CQM_RSSI_THOLD]);
 		u32 hysteresis = nla_get_u32(attrs[NL80211_ATTR_CQM_RSSI_HYST]);
 
 		if (len % 4)


If that's sensible, I can send a proper patch?

(Oh, it looks like nla_len is actually u16 ... should I use that instead
of u32?)

-- 
Kees Cook

