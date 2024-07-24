Return-Path: <linux-wireless+bounces-10484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E4C93B1C1
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 15:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81BA61F22FF1
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 13:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBE4156C5F;
	Wed, 24 Jul 2024 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E9HYZhfQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45A414F9E6
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721828433; cv=none; b=IuRhUWMMx4/8AVSMDk1cEAX8DbijnvpufG/z+5siZz6XtkwLdSfWNt7Oa+xJGJgVINY8k+1Prb2PoQmElkSskFncqlI0z/PXk91lDVhnVrrG+vrKt5cWzDcJ5QHc50wS/DHeyOnxmEKLknHo4V6s/W3AltnsiAPR1tIljkYDJE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721828433; c=relaxed/simple;
	bh=OVHtAUpRPJSuuOBC3IkXJfhrhp7KgHwUqbIhzOoBdO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAZ0bmK9TMB66TfGomP9mVDTQ3TsDBoo77aYOp+bDqycjnKUtkXumsiG615G77oPWT0fVmMkq5lSPNWKCTzbQ2ujl7KYE5FcoRmNBOugzpbcvAxxDA9l+qALgOCWZ9zSlumGiqbYDy/tLCNRFAO/DcKk9DR9XQY67EuDaN8n1N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E9HYZhfQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc65329979so15385215ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 06:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721828431; x=1722433231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ho5uHxbyIN9Ukln1sSTfjXuHmskwj5kUZnNHCu65q0Y=;
        b=E9HYZhfQQ9CytT7hpEzvTuVAqpYP16QIqbWF3xNic1IVjE55miGk8AjWe1TNYgyyGv
         pmrcIajqcxqcRuhDo9DBog5faBj+rCqR7bE6SdPwlGLHxZr7bHglHyNh9dqSW/196DQ2
         KnOkLPTMWtC/fa5rNiEQm28P+gd6c6hV8kKaGyvhis537s+Qw+jvRw0Lbqjt0MZcHLLy
         442KTet9vgDQsQ1U02ErDyPoEPexrBC4FRqPp/3ORs4EK1yH3nmRwWyZT2ce3CYJrOs3
         fsT07Q2rLYkS9wpNdCQo0AfI2ngkpUdjkZbNOKO2uC1ve2eSzizUL0RIoJe0NO43BDUt
         jtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721828431; x=1722433231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ho5uHxbyIN9Ukln1sSTfjXuHmskwj5kUZnNHCu65q0Y=;
        b=rClAKFw5egt8KC+nE2Or2AQ1RSrKZOXR/FQAhBDsCctHiQUxUooIou7D9SzIIqCg5k
         0EuVdbMOAJHJtznbizIm1ExiicLL9ObYSUb+WBC/ww8aEY4XGxsIKS0csMcDPO+msGjn
         rcc1FRhaGQPuKrZp8bJ7PtuGM7AgYKU3XdRSUA7FFC178ZB60T+LEqQQlsPZE1682pAU
         L2szVmIev/pcxKDh7AT/EaumJ8RDXRVa0gOwu7IPgVXqr09uiBQyTDh9SGzyR25/Ybs6
         3DLCXbjvbMdL6loKKP/oCrFApTS8zc2IRuNPQcTgOJnaYNDp8S1EztixpOdgquSjkLF2
         /+3w==
X-Forwarded-Encrypted: i=1; AJvYcCUr1/mtzRqeTpDwMMh9fMX70NRdl5WOBj1QTvoIchEjlxmMDRHWSKKHeyDFZeRAlGJd9QQng5jy1WPKYQpJhRoexcb/VawExIJmjVoiEHk=
X-Gm-Message-State: AOJu0YxNNENojr3FrffkRIPettTI1ACVyIrl9K+1Fx5vbX6xqIw07vVY
	kypawNbVRlKVcpDK1HqVJX1tbLaJFE2h/PT52tV8bqgUTQTKqY7ZSnsVpg6pOw==
X-Google-Smtp-Source: AGHT+IHTe9XqkFMen47fQQ83krsvsC2GF1HLTZ00NqeJfT9BTX56ckWY+qZeZR7mKy1S1QhbNdKaJA==
X-Received: by 2002:a17:903:41c6:b0:1fa:4187:7397 with SMTP id d9443c01a7336-1fdd223cdbdmr30014395ad.60.1721828430892;
        Wed, 24 Jul 2024 06:40:30 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f2aaee0sm94051785ad.117.2024.07.24.06.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 06:40:30 -0700 (PDT)
Date: Wed, 24 Jul 2024 13:40:24 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wifi: cfg80211: fix reporting failed MLO links status
 with cfg80211_connect_done
Message-ID: <ZqED64mn7pIHsl1n@google.com>
References: <20240724125327.3495874-1-quic_vjakkam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724125327.3495874-1-quic_vjakkam@quicinc.com>

On Wed, Jul 24, 2024 at 06:23:27PM +0530, Veerendranath Jakkam wrote:
> Individual MLO links connection status not copied to
> EVENT_CONNECT_RESULT data while processing the connect response
> information in cfg80211_connect_done(). Due to this failed links also
> indicated with success status in EVENT_CONNECT_RESULT.
> 
> To fix this, copy the individual MLO links status to
> EVENT_CONNECT_RESULT data.
> 
> Fixes: 53ad07e9823b ("wifi: cfg80211: support reporting failed links")
> Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
> ---
> v2:
>  - Add "Fixes:" tag in commit text.
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
LGTM,

Reviewed-by: Carlos Llamas <cmllamas@google.com>

