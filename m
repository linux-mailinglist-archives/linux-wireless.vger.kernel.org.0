Return-Path: <linux-wireless+bounces-2213-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67993832068
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 21:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 083D7B21D42
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 20:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FA32E825;
	Thu, 18 Jan 2024 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="avv2qAf4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8622E82F
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705609192; cv=none; b=QSweB9tA1R5g2kSTgLfNH+Qi+58qgun7rxxet8r+clUztLsF6ErzJquv8JZY6g3CeqaoFUJb34qP1GGg/xErAid3WFyWyZklAUdh5DzWigwABrT7zcnHLE6h66IeRhrIVK1JQjZNGb5F0UXnBd0yF2MUQlE786KdBGdmUPycDRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705609192; c=relaxed/simple;
	bh=j9PldOicSCiR56xGx4w5DlqynjyiqkkllVc8RQEib1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfwVZVPwh35/uIjQamJWPrsSZdFau24hFwSEgJyPnPRttsHe1yk5Fco5K65sf9ApNkn/5PHkXHPiYoNL6Dm+NZoydjPP7igpyh+nyrLvxIVlUVBtuGWYCHf8KQLrFrt/zH6mB6I4MSQCvMCz4rmbAokW+1Ev+FMcKQ9UU7Bqq6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=avv2qAf4; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cde7afa1d7so40239a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 12:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705609191; x=1706213991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/WcFOrXzi1etprpTMrc6iHqPcX21W26WmkZmedeBfBQ=;
        b=avv2qAf4u7zBd00cqH3rkrR5fCKK09j8sPYmBm2bKx9MjBrrHY5+gJPXMqyX2sUwcQ
         Xzi+Jq63GdANlZxY7SoUVi2TINvfE/Mr8O8F7lWXFs8vYpYjpAdPtqBszV5EhYJWJOPB
         qGEwnBllHt6MO145vbaVXHBfLuBmwf9W7hbTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705609191; x=1706213991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WcFOrXzi1etprpTMrc6iHqPcX21W26WmkZmedeBfBQ=;
        b=T0eE1y+TXxH2qhG/9h4PyXuoKs+m4U6sYpeKufatPJsm9Rh0pgmGgGWatwq6MMkM6M
         vDOqDQpKNJGA1ns1+SRJZl/j8O/oYdnj1VVQ3cvrX2jSV7VP/Pu8V66gUrFcGDevVbyT
         sWfLitiYzAMmFIGDUtNemY9XnseTaDhbi2DySJ+c7i5IG0gx8Apv+QLnYxli+DG1FMcf
         oL9zz4NjNRTFWDYPxPSYNHB6j8ykML2CWASKLzW6XWfFdTL03pM0swxOSd0oMKDjH/ri
         /HUn1VotDl8DgYWHfFvo619rvLYge6PQ6P6dFehNa0Vo1qlBapaJkjIxEJ5j81sKJg26
         7caw==
X-Gm-Message-State: AOJu0Yweg1qdEaIUUWmMYTRgMU/TGm+8yjqwWV90YFh2MC8p+c31h3Mu
	QpCvGBwd+Ktk1Ia04lR6sdeXzTYUzeLoRQpC4Y9zf4iCAJsXxgp9eLFXjU+EEg==
X-Google-Smtp-Source: AGHT+IF4nnlVdgtVrwLuTAYy39B/0R16JlUrk6mFm918Pc2TjDWO4jFBSBuNgu+yKV55b4U9s0AePA==
X-Received: by 2002:a05:6a20:1604:b0:199:701a:4452 with SMTP id l4-20020a056a20160400b00199701a4452mr1373703pzj.9.1705609190749;
        Thu, 18 Jan 2024 12:19:50 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fa18-20020a056a002d1200b006d996ce80a6sm3670498pfb.0.2024.01.18.12.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 12:19:50 -0800 (PST)
Date: Thu, 18 Jan 2024 12:19:49 -0800
From: Kees Cook <keescook@chromium.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Atul Raut <rauji.raut@gmail.com>, aspriel@gmail.com,
	franky.lin@broadcom.com, kvalo@kernel.org,
	linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] brcmfmac: replace one-element array with
 flexible-array member
Message-ID: <202401181217.1D75C32E@keescook>
References: <20230803052238.12147-1-rauji.raut@gmail.com>
 <20230803052238.12147-2-rauji.raut@gmail.com>
 <f739cc15-dade-4f69-a17a-30242026c099@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f739cc15-dade-4f69-a17a-30242026c099@broadcom.com>

On Thu, Jan 18, 2024 at 02:53:28PM +0100, Arend van Spriel wrote:
> + Kees
> 
> On 8/3/2023 7:22 AM, Atul Raut wrote:
> > One-element arrays are obsolete, and flexible
> > array members have taken their place. So, in
> > struct cca_stats_n_flags, replace the one-element
> > array with a flexible-array member.
> > 
> > This fixes warnings such as:
> > ./drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:119:6-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> 
> I think this correct, but maybe Kees can give definitive answer here.
> 
> > Signed-off-by: Atul Raut <rauji.raut@gmail.com>
> > ---
> >   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > index de8a2e27f49c..fff32e54833d 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > @@ -116,7 +116,7 @@ struct brcmf_dump_survey {
> >   struct cca_stats_n_flags {
> >   	u32 msrmnt_time; /* Time for Measurement (msec) */
> >   	u32 msrmnt_done; /* flag set when measurement complete */
> > -	char buf[1];
> > +	char buf[];
> >   };
> >   struct cca_msrmnt_query {

Normally a [1] -> [] conversion needs some details in the commit log
about why this is safe (since it runs the risk of changing sizeof(struct
cca_stats_n_flags). In this case, there's only a single user of the
struct, and nothing about its use depends on its size:

#define BRCMF_DCMD_MEDLEN       1536
...
        struct cca_stats_n_flags *results;
        char *buf;
	...
        buf = kzalloc(sizeof(char) * BRCMF_DCMD_MEDLEN, GFP_KERNEL);
	...
        results = (struct cca_stats_n_flags *)(buf);
	...
                brcmf_parse_dump_obss(results->buf, survey);

So, the allocation size is big enough for the struct, and nothing
depends on the struct size.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

