Return-Path: <linux-wireless+bounces-10853-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BDF945749
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 07:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0CA1F22299
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 05:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7BC1F5F6;
	Fri,  2 Aug 2024 05:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ljnbP8MA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA901C2BD
	for <linux-wireless@vger.kernel.org>; Fri,  2 Aug 2024 05:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722575386; cv=none; b=ivq7kX0bBQccgW0/+GBNn2vyr0Ax46cwjYpAZcHO6gyELTIFHhZAXbCAw2seN+bAKOO5Frd9WB+6ZuQmW68477h5l4StA9rWlx0qYnTnS8YxlDvfMLedBsn1xDYTcccRKCS/wLAbcN4FhekpVpQ2bvYtZxPCGk6HtSrAdi4EsJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722575386; c=relaxed/simple;
	bh=QU1xql99hzEwvG8x9j+Z4Ka0EHpllKL9hNkY53AN3Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmAnkULuJHbryNwgBoU5Ke5oHmSXfMBxNgyVsfBg5u32/zDVGtfusqmw3d+0Lm2h3h2ihTyrSJIwHtOfTrdQ2g626tZsfnKfHqwoWxQc0vHR2Z49xatKa/DBUZZQbNy47MtBhBbpO6DD3XI25K9TXwJl6xm7jbW2QK5oP75AYq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ljnbP8MA; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-70936061d0dso5133869a34.2
        for <linux-wireless@vger.kernel.org>; Thu, 01 Aug 2024 22:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722575384; x=1723180184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rq+c3N3L/d6kGtbA/DP2X2zUDS6cgLKqPw9tuzDnkSU=;
        b=ljnbP8MA0DDGUpWNxmztuxfG+rFLc57l0OPLVvuOTkXgE26QBZUP7Ktc2HM9UhTPKz
         wAzi35G0zEhzRuDQ0A6oR8xu9+/d9ML52xVS9AbEsyUhsP/OtQMWFbh+KgOhkYRjepp6
         o7tZzOnEwqQBL2mtWghy3jln/BZjpTuP8CsVS8QDf6IrzTaidUUSsbpJo6gEtLkTqAzQ
         Cynv+qwm9e6UrVgG1uaXCmVtV+UDISd3uB/DgQNQLmvBwyAv3WHJzmopnF3lJyGuBQx2
         cKIt0ZptUq92yL+aoDO5xWXuvgMTA6E4hJS/lp/Voyfxbvx0vcreBct3cKPCLwQKz+a2
         of2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722575384; x=1723180184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rq+c3N3L/d6kGtbA/DP2X2zUDS6cgLKqPw9tuzDnkSU=;
        b=K+B7+ll3m31euRX+cnUV8wq0kPqhJRtHN9MASzEtVlRGm3f/jESKxsG0Z+do+b4Eg+
         +EN2tpJZd8dyHlev5k9kmgMH0daNxLL3L5JnrAAcuUb/MLp20TqUKUxgLsfg7FsA0OIy
         b22vxlf2OKDIFuaEixRawm0E5DaIhrVcaGJCTtCjYXeY6gDpIz1xY9jPMZ89lPRjP1Wv
         nkgiCY77NHUZercuFY4rTZfDFSWKBnGqq0D/tKTCCSywtlYYGAIa2Id/8dc4b5bF/gCk
         H75IFYxMwA7M1P64RnTxYhhXr67HsodkvTBmlUEzj1D6KkO2Mq7NFjXFUSzUY6AKjNRq
         6BHg==
X-Forwarded-Encrypted: i=1; AJvYcCWjXH5A9n3Z0dJLkc9SNDxeBt6mXzRC2QVP2y9giZMsOuPwWNd2Crn5NDdiJxL8REy0RIc4fxd0ehOV7KBEe81YI5X9hk2X5W68NkoPh+g=
X-Gm-Message-State: AOJu0YyjoF5pPyZ5q7aFFmHuzhOttt6ElVESub0Qg2FaHxFCwY8VvL0V
	LnZwkTx0JCZ7v8ScQju8UfJMuZqeM7BRzndiP/mHMYYuIzvl6x4RTnp1+Ty/QWc=
X-Google-Smtp-Source: AGHT+IFHMM12oDUl0en2AKNNRADDpJwfvQEZZbY8zm3USIXwUYHAZj/AB+5quKsspn7TfJuQuxr78g==
X-Received: by 2002:a05:6830:280a:b0:707:1794:6f9c with SMTP id 46e09a7af769-709b996085dmr2033716a34.22.1722575383748;
        Thu, 01 Aug 2024 22:09:43 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:920b:58f5:7792:ff2c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70a31ec3713sm338827a34.44.2024.08.01.22.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 22:09:43 -0700 (PDT)
Date: Fri, 2 Aug 2024 00:09:35 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: miriam.rachel.korenblit@intel.com, kvalo@kernel.org,
	johannes.berg@intel.com, gregory.greenman@intel.com,
	benjamin.berg@intel.com, daniel.gabay@intel.com,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] wifi: iwlwifi: mvm: fix an error code in
 iwl_mvm_alloc_sta_after_restart()
Message-ID: <575625da-60bc-4444-a5f3-a7acf925f1e5@suswa.mountain>
References: <20240802042740.1567091-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802042740.1567091-1-make24@iscas.ac.cn>

The Subject says RESEND but doesn't explain why you are resending.
You probably meant v2, but again it needs an explanation.

On Fri, Aug 02, 2024 at 12:27:40PM +0800, Ma Ke wrote:
> This error path should return -EINVAL instead of success.

Why do you feel that way?  Have you tested it?  What is the user visible
effect of this bug?

I slightly feel hypocritical because I have send lots of commit messages
with exactly this commit message.  The difference is that I only send
really easy patches where it's obvious what the intent was.  A normal
kernel developer wouldn't need to leave their email client or view any
outside information to see that my patch is correct.  If a patch is not
dead easy, I normally just report it.  (Sometimes I report dead easy
bugs as well because I am lazy and maybe it's the end of my work day
or whatever).

This patch on the other hand is more subtle and it's not clear why the
continue statements changed into returns.

regards,
dan carpenter


