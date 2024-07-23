Return-Path: <linux-wireless+bounces-10455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0B193A411
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 17:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A603D284925
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 15:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B72A156F5D;
	Tue, 23 Jul 2024 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l0mNkX4l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DDD157468
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jul 2024 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721750323; cv=none; b=EeDZFO0JMIAZAgIPaGycHzzaJpi5BKSqZMn974rn7OWQZ6oPOhQFjYsH2z1qUNmRUmS7TGcxZcA/CBXU+HdeQlq/jEF0JlgDi6NHiEwdPU3MfbzxXQyeRNAy1Q+dQzV8kWhi9ELdWMP8sGw2lcTTC6wV2VTTo6YzWqRo3zDVjYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721750323; c=relaxed/simple;
	bh=0cjdKOYSrhY8s26sotnrUscHJG4VMR0ddQo114J2yKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sf6bBHUu05pxdPAOFvyGILo7pMLoucFyzGzwpVI8OH7444oa9MIx9LXxQfVXN63XJJVhL3FSI+JlkVMzDWLQ8TI8WIEJow2fBqWzIrKw9mN+LkWwdjt0mtkr7k7PxyHLDc4NGS+MJCQ7MwjJ0E12+BrHFPzHsC9Cj/t3EVrdFuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l0mNkX4l; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so2816476b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jul 2024 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721750321; x=1722355121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yxMshVPFdKCTFIUSW7cw9L8v3CsrBB2PAnKA86oz4mg=;
        b=l0mNkX4lCx2UiKDkQofre9ItOJIv6ar42SLKdQs315yeGWR9jEOrj071gt3srZsJr0
         iy2hsHxLJMV+/+0BGrtxj0D7oVwlIgHTLeKCsd31dT70xlWPvEW/spLH0d009TRQmd5H
         geQxg+RWWc01rUFP+SSIZLc5UCcd91WGJyHBwg4a16ok3dM1Adhfhm3k0pMJoxIScgFN
         FX0zHt5dknPeDV5EvKzKHbSNNfS/aUB0fp0gOcw7bJ0UsNkF7mdcjjyhHEfyV6s7DL5F
         ndS9ON/6AxX0dwaDvGrGf1Bfjz96+gIKohgIMhS6H5AQf/cmgcAKKiaSSFMrRRHQGwg+
         HSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721750321; x=1722355121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxMshVPFdKCTFIUSW7cw9L8v3CsrBB2PAnKA86oz4mg=;
        b=iE1ghTFqsi68/1vZ25SEu1kz/4agkbaCFel+if+AJaI+bTA7qxyCF+15JyYT4Cq7F6
         +vSt37KCpT5nytkl1pDzI0WUd0k15kqR4e+B7RyhynOphv0CXZ+nAVFBB701ycsPBt6R
         rscPIytkljlUIc4niXzH4Fp34vXOfwJx5riTgVC8IW9eUS0FAscAQV4uvNS8eKPRAC23
         JNpu+d3AKf4pNUveH5yN6GXG16/TFUn9kJM/xnBX06LYmLJjvBspmln/VdpqdTNCQ76l
         YNCNjcCV4Htt8W3dLcTGg24MYEniR32I0mbOyDxmd1lIrKDuCTn+FZ32J78nwQyx4Gka
         SvwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzxwx2UXSVhXCGmIwZnLX/SZRWXr+yDkZ9n6q/bssSMtL5MerrHPY28k8DhZ6qyTF1svN6cCWyRWss3Xf0yshqt7oDl3j3ga3aBwd2XPA=
X-Gm-Message-State: AOJu0YwALluadcYryCQ/tAMKGQeLGSN7jszfmsq2J69CsogDro0DfvhX
	lKkyaYce00E9BY9SNnM+iNF7ZDMYj7cnGdBqJ5u7OcdlT9WeuTjayC0dGx50Y2t1RiD5lnO6a/7
	7+Q==
X-Google-Smtp-Source: AGHT+IGN1DM2mfd/B146aH9qkl9pN0ZEn9PdD7IHJ03qLrC2xEfy8R96KXgRMlhn4MOOAtv1vv/i6Q==
X-Received: by 2002:a05:6a00:2e9a:b0:70e:98e3:1c17 with SMTP id d2e1a72fcca58-70e98e346a3mr545239b3a.27.1721750320704;
        Tue, 23 Jul 2024 08:58:40 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d1370c6adsm5153893b3a.56.2024.07.23.08.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 08:58:40 -0700 (PDT)
Date: Tue, 23 Jul 2024 15:58:36 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: cfg80211: fix reporting failed MLO links status
 with cfg80211_connect_done
Message-ID: <Zp_TLK2-C4LYC-yl@google.com>
References: <20240722194146.1736608-1-quic_vjakkam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722194146.1736608-1-quic_vjakkam@quicinc.com>

On Tue, Jul 23, 2024 at 01:11:46AM +0530, Veerendranath Jakkam wrote:
> Individual MLO links connection status not copied to
> EVENT_CONNECT_RESULT data while processing the connect response
> information in cfg80211_connect_done(). Due to this failed links also
> indicated with success status in EVENT_CONNECT_RESULT.
> 
> To fix this, copy the individual MLO links status to
> EVENT_CONNECT_RESULT data.

Does this need a Fixes: tag then?

> 
> Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
> ---
>  net/wireless/sme.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/wireless/sme.c b/net/wireless/sme.c
> index e419aa8c4a5a..d9d7bf8bb5c1 100644
> --- a/net/wireless/sme.c
> +++ b/net/wireless/sme.c
> @@ -1045,6 +1045,7 @@ void cfg80211_connect_done(struct net_device *dev,
>  			cfg80211_hold_bss(
>  				bss_from_pub(params->links[link].bss));
>  		ev->cr.links[link].bss = params->links[link].bss;
> +		ev->cr.links[link].status = params->links[link].status;
>  
>  		if (params->links[link].addr) {
>  			ev->cr.links[link].addr = next;
> -- 
> 2.34.1
> 

