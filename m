Return-Path: <linux-wireless+bounces-27155-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F109B4A80C
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 11:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9EA6188295D
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 09:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5B2274FD3;
	Tue,  9 Sep 2025 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="o8yugTiS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C299A1946AA
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409656; cv=none; b=tQGfwW2PMYQ7fyRUg1iJ6roPDZH8vn2eYqejeuc9hfOXH7fEopJkSHnUViJxvZCtUTnuo+9R1nD4Mue6h0l7p32/mC8TTL2IW9HYBKIQ3LM/laruHW30FA+qhzXKJLgaj2Cil7We5NU/4QKywPrYDi0URaevB2OLOUvWOIotLcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409656; c=relaxed/simple;
	bh=bWWKrnXdXI9cEtyPHbuB57Ixq3V4jtXswb9Ip9oXKNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KP7LX9DSzAEt+stZv3Cr90HVeFJPy2VoBXWppjsqOVh1wui0eGe5wT8J9LZ4aeWbXFQyVP6rdefcAj2i1SdPGcmyfKkync1x9fGZgwogjYXC2WjJQTc/o0ORQQifKJYtTtjN/3H81THm859rOP72Sx4KSFPln3FZuBgGjeVB4pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=o8yugTiS; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4d1e7d5036so3425007a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Sep 2025 02:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1757409653; x=1758014453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eU4HIVk7YPXfWuIuhfgxMl+8gsfgVTC8SC7Ljb9INLg=;
        b=o8yugTiSddXnWFB4G8R+dVesowl2OrrFcWcDynirmG9qzFCAgJLnhIhTHxCrXw2b3v
         KbWoahU9MxGxkr/lMyuWMRGYwp6d/YGUuu8MKiVaOh/FYg94NRi1ktW4SF034kISqOBo
         4PrOJc557W4sUc5x5kxtOlF8gqxJ617sh+6OLRUMnwyW7t/0BEqopducNSkj/jCCHjCT
         wW70GNEDTcJlitJjxZGczaUASKU7JbaAzkVmHP41H64iqGGYNBs0Mur06h5Wxq5GeQ83
         mI7WlFE5tmuI5urr8c+dJHfx+h/LbuhZm5hpDjsVT7gBKLTV7uLM0XkXzDNqVy6vcEtA
         gM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409653; x=1758014453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eU4HIVk7YPXfWuIuhfgxMl+8gsfgVTC8SC7Ljb9INLg=;
        b=YBl//E3brwVJxwzHk2VfolJbfkUVD53p4vBVmeEQkJIBEg38ioLea1JyjVGUeLf9mq
         mjTdMyjjL/X2EmCAXaQLCSWAWDoTYooT+puo5pHcPwOfd/qR69s7+RYW8g26mHSSJiES
         /+4kLVnWY3RbqNEpwhzJZSjGT+r6r8vTfyMBAF9zhgXx5pulpokMiGsyNHJH5YHmUqIi
         fmqneYCEogGRJUxGbK1bgEQFlzueOAeDzMYgaZ1/BIQmBcXdlU2ibGKRDixMJMJ3KGCW
         VBlKBFmx3EJfC/6NKDM0i5v4dkyHi34x1HQt72Yoc0v8XHpIhY7Iua8027JHei+QL3LH
         q2qA==
X-Gm-Message-State: AOJu0YyrprDHp3vEXSAOvFEWpEbToEJEyHOS8hxMpz1m78vED9t2C2/0
	B+a0rNfTvdPY4HjbH3lYRhln20d7w63hC9kHAR8bm3gBFtfdyLpRRfxUOt76W/PiTLriZb++rI9
	sHV9cx+k=
X-Gm-Gg: ASbGncvRC+aqhQYMgpd560vCYn/sRG3yaiDi8LjJGtsU1IZpFjIj5YGd8SXHiNOUaGu
	yQHIIPeaO+Zqn7lX4BaxetTfPpvksi+wTIrQAPCsM2MlmvdYisne2NWx0b0jKwQLCp+na0URQCU
	v2HGjitlYdgVwL9sQ/oxPvmL0Dtbzr3uACWdvgDBjoY9UH9UijLfuX3JsNI3bISnV6Kfgz8XSx5
	w8x6zd8y/afle46GQFgYM2KKh2OUgpHX+w6kGSKzUHV5cM7NMeE2IR9LV19b7RcWI5CW9Rdj9Ed
	LHTu60sBX6V31Gwh0lPsubB9QzVffhVzM0Uj1yQcsD4Paa/+gM+ujz5FioNcuoPRiA8p6kj+Ie9
	4uJXtLpqWOMsDX8w3FvZBgGNC45L5Fzy9Vj+4hSvPDAPqGmfWZ34ApVThAUYuK797
X-Google-Smtp-Source: AGHT+IF7dhHsyOjSSoqlMwMDM5iXGci1bzkkUMwUpOBhxW50u5LrI8WGAdIqorQjUcl0SrTrHmWwzw==
X-Received: by 2002:a17:902:d089:b0:224:10a2:cae7 with SMTP id d9443c01a7336-25174373d5cmr90893965ad.40.1757409652902;
        Tue, 09 Sep 2025 02:20:52 -0700 (PDT)
Received: from localhost ([60.227.224.187])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b988eed84sm15129475a91.8.2025.09.09.02.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:20:52 -0700 (PDT)
Date: Tue, 9 Sep 2025 19:20:40 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [RFC wireless-next 2/3] wifi: mac80211: correctly initialise S1G
 chandef for STA
Message-ID: <o2yyd6azqrxglw4i4ffpvgygxp2vorlpfbxjv3yktfv4p4cewx@edmpgi7bhy2d>
References: <20250909080758.1004956-1-lachlan.hodges@morsemicro.com>
 <20250909080758.1004956-3-lachlan.hodges@morsemicro.com>
 <a70b8e474d097275267458e5bbc8c96ed2cb5955.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a70b8e474d097275267458e5bbc8c96ed2cb5955.camel@sipsolutions.net>

On Tue, Sep 09, 2025 at 10:51:42AM +0200, Johannes Berg wrote:
> On Tue, 2025-09-09 at 18:07 +1000, Lachlan Hodges wrote:
> > 
> > +++ b/net/mac80211/mlme.c
> > @@ -180,11 +180,9 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
> >  
> >  	/* get special S1G case out of the way */
> >  	if (sband->band == NL80211_BAND_S1GHZ) {
> > -		if (!ieee80211_chandef_s1g_oper(elems->s1g_oper, chandef)) {
> > -			sdata_info(sdata,
> > -				   "Missing S1G Operation Element? Trying operating == primary\n");
> > -			chandef->width = ieee80211_s1g_channel_width(channel);
> > -		}
> > +		if (!ieee80211_chandef_s1g_oper(sdata->local, elems->s1g_oper,
> > +						chandef))
> > +			WARN_ON(1);
> 
> We generally don't want WARN_ON() if the AP is broken/wrong/stupid, so
> should probably do something like that had before? Or just not connect?
> 
> 
> (and if we did accept WARN_ON, you'd want WARN_ON(!...) here)

I was meant to leave a comment saying how do we gracefully handle the error..
but I've just had another look and I guess I missed it because, as you
suggest, we can just do something like:

if (sband->band == NL80211_BAND_S1GHZ) {
	if (!ieee80211_chandef_s1g_oper(sdata->local, elems->s1g_oper,
					chandef)) {
		/* Fallback to default 1MHz */
		chandef->width = NL80211_CHAN_WIDTH_1;
		chandef->s1g_primary_2mhz = false;
	}

	return IEEE80211_CONN_MODE_S1G;
}

> 
> > @@ -3227,12 +3228,36 @@ bool ieee80211_chandef_s1g_oper(const struct ieee80211_s1g_oper_ie *oper,
> >  		return false;
> >  	}
> >  
> > -	oper_freq = ieee80211_channel_to_freq_khz(oper->oper_ch,
> > -						  NL80211_BAND_S1GHZ);
> > -	chandef->center_freq1 = KHZ_TO_MHZ(oper_freq);
> > -	chandef->freq1_offset = oper_freq % 1000;
> > +	chandef->s1g_primary_2mhz = false;
> >  
> > -	return true;
> > +	switch (FIELD_GET(S1G_OPER_CH_WIDTH_PRIMARY, oper->ch_width)) {
> 
> nit: I tend to prefer u8_get_bits(oper->ch_width, S1G_OPER...) although
> that mostly applies for fields wider than u8 since then you can use
> le16_get_bits() etc. Might be nicer to be consistent and use the newer
> helpers in newer code.
> 
> (But I don't feel very strongly about it, so if you feel strongly this
> is better, feel free.)
> 
> > +	case IEEE80211_S1G_PRI_CHANWIDTH_1MHZ:
> > +		pri_1mhz_khz = ieee80211_channel_to_freq_khz(
> > +			oper->primary_ch, NL80211_BAND_S1GHZ);
> > +		break;
> > +	case IEEE80211_S1G_PRI_CHANWIDTH_2MHZ:
> > +		chandef->s1g_primary_2mhz = true;
> > +		pri_2mhz_khz = ieee80211_channel_to_freq_khz(
> > +			oper->primary_ch, NL80211_BAND_S1GHZ);
> > +
> > +		if (FIELD_GET(S1G_OPER_CH_PRIMARY_LOCATION, oper->ch_width) ==
> > +		    S1G_2M_PRIMARY_LOCATION_LOWER)
> 
> same here
 
Sure, I can make use of u8_get_bits() instead.

lachlan

