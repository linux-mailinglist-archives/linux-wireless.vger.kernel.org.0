Return-Path: <linux-wireless+bounces-9871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8704A9243B0
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 18:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9D31F26480
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 16:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8651BE23D;
	Tue,  2 Jul 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ngj9Vrie"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77BE1BD4F8
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938282; cv=none; b=qL/+BFwdFdmkxOYadvX8battfnXqjNF2g+h5m7vIpThX0atszRMAIDc8sKiF6sHo+2oMtjf/gvTAwLmc/jy9IO6F/a/ILIWSkhtqRgwPsydiUL+M4Ezw0R+t6yIT8HbveqrOcdxDd6kvca0Vt5/7ZgIALs575Kg203tlgb0kpEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938282; c=relaxed/simple;
	bh=Td/mymmjXx2bhoBfX42+S3grkOQA58fYkvzmlYiSbRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEE4VoaPOKrwAJ98tOoJAynrJZ89oBTf9RR1RXiN1OOPrQNKEjs/7L9PgkRGbey0WvQx/QrAqpqWjz8S/9z5suEZ5xuGg8MP+WJdGc9bHU2cRLj/SHTv/nDirQXlTb8nwxP6dZY5OHu8/E+BXkxc2n1n8C5cvZ05QnRrPzfr7yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ngj9Vrie; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6f855b2499cso2620396a34.1
        for <linux-wireless@vger.kernel.org>; Tue, 02 Jul 2024 09:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719938280; x=1720543080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fCJPO8HJZKPLtkJRQZbJmZwwdF765WINU9lgdrr+c8s=;
        b=ngj9VriefIIZnaiRKRUI6yetRGDTgYowup8IIcIVxYc3872q1XUVuM659wk6wIAa2L
         rIb95dfn3v+0B7jkPxBRAXzOIOehrP2N7FpfHCzPUd1rN+m9xI9fD5P0i6zD+0ES8ogp
         A843ts2ZabmdnrgiJTszeTqtMPDeWXLlWjSu0cIkcgLiHhMqr2tslWTsayOO6k7Q2TEP
         J3dKJVxhBVSfy/6x5FoSxu+Zk8F4vYSJnkGxpYsf20WzBFb+aRqOnBeu2uLApVmCWBfO
         48oovOC2RzHUazreSstN2tdU+9aInp0kOLbFTboA0+MKXaY71qab5kjo/1fOHcMwVt30
         /VHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719938280; x=1720543080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCJPO8HJZKPLtkJRQZbJmZwwdF765WINU9lgdrr+c8s=;
        b=N7ctyZCQEEikLCgKUDlQQI0xDma7EdR4xKPuhiAWssFxsfzHDELuZVXkly/iTzVX0z
         c65EPT+90mPFihHRWE1V2s62mIkDB5qScj0LM0q+DV6Y8vWw2pjMEfuEdxOO8FdyoM2K
         RR0E2ePutaDPwtnJQAG4H5Yb5wTjgmmN/OCr+yQ5+A26XS6sTaWNZdqCBGPI2OYT4D6K
         /ZOsCrfpy+d6xqOv7/e8455VFiiZ+yfta3BOip6CKjKM0fR448LyurgitHaSm78gaEw4
         ccXfAWGszSAOWm4ke0Sj/TMfbQDFa8zS6hRkPi1CNsOfNHBK/XIi0FRJ+stoNfFlx72O
         GqhA==
X-Forwarded-Encrypted: i=1; AJvYcCWyM6YMQPAiI2yflUVvCu2DSbkVvApQa2oWXn/aGEJJ+vKuw7LnRfWLnRoh5uMv1xxOsaVxjAUMO8GqY8xLVlMogjzJG265vv1HF8bOfPQ=
X-Gm-Message-State: AOJu0YxKHLe+7HjP1P4RvX3I8V2bbvdUDUuCpEIFsI+yqI0qoCGMnL3r
	8aVfRmsFmRkdk+2f0lRlnsP1FD+jS1JbbDhYAPCHlD2SQeOWXmtCzRK1tcadRoM=
X-Google-Smtp-Source: AGHT+IEGT5Dx+bmDID+3tLY4yH/uWp/+sLbhF7QkmdiL3UCJgcDeNDsdEM0dT4hvHy6ajkiiNDK8eA==
X-Received: by 2002:a05:6830:148a:b0:702:1dd5:da47 with SMTP id 46e09a7af769-7021dd5de6dmr4587972a34.0.1719938279693;
        Tue, 02 Jul 2024 09:37:59 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:a6f1:b7be:4c8c:bf62])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b3679asm1666064a34.67.2024.07.02.09.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 09:37:59 -0700 (PDT)
Date: Tue, 2 Jul 2024 18:37:57 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>, Su Hui <suhui@nfschina.com>,
	johannes.berg@intel.com, kees@kernel.org, a@bayrepo.ru,
	marcan@marcan.st, quic_alokad@quicinc.com, zyytlz.wz@163.com,
	petr.tesarik.ext@huawei.com, duoming@zju.edu.cn,
	colin.i.king@gmail.com, frankyl@broadcom.com, meuleman@broadcom.com,
	phaber@broadcom.com, linville@tuxdriver.com,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH wireless 1/9]  wifi: cfg80211: avoid garbage value of
 'io_type' in  brcmf_cfg80211_attach()
Message-ID: <b74d94f1-ea0e-4a1e-bc4a-7180dd25ee85@suswa.mountain>
References: <20240702122450.2213833-1-suhui@nfschina.com>
 <20240702122450.2213833-2-suhui@nfschina.com>
 <ba67020a-04bb-46b8-bc05-751684f71e8a@suswa.mountain>
 <19073fcc9e8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <878qyjg6cv.fsf@kernel.org>
 <3071fd19-5cc7-440a-8184-3aeeb81c96e0@suswa.mountain>
 <19074452940.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19074452940.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>

On Tue, Jul 02, 2024 at 06:26:49PM +0200, Arend Van Spriel wrote:
> On July 2, 2024 5:37:10 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> > On Tue, Jul 02, 2024 at 06:29:20PM +0300, Kalle Valo wrote:
> > > Arend Van Spriel <arend.vanspriel@broadcom.com> writes:
> > > 
> > > > On July 2, 2024 3:57:27 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > > > 
> > > > > On Tue, Jul 02, 2024 at 08:24:44PM +0800, Su Hui wrote:
> > > > > > brcmf_fil_cmd_int_get() reads the value of 'io_type' and passes it to
> > > > > > brcmf_fil_cmd_data_get(). Initialize 'io_type' to avoid garbage value.
> > > > > 
> > > > > Since you're going to be resending anyway, please delete the space char
> > > > > from the start of the line.
> > > > > 
> > > > > It's weird that brcmf_fil_cmd_data_get() uses the uninitialized data.
> > > > > It looks like it just goes to great lengths to preserve the original
> > > > > data in io_type...  So it likely is harmless enough but still a strange
> > > > > and complicated way write a no-op.
> > > > 
> > > > Not sure if it helps, but I tried to explain the reason in response to
> > > > patch 0 (cover letter).
> > > 
> > > Would it make more sense to have just one patch? It's the same issue
> > > anyway.
> > 
> > The Fixes tags are different though.  I'd probably leave them as
> > separate patches just because of that.
> 
> Depending how you look at the problem those tags are wrong.

Tags are often unfair in that way where you could blame different
commits and you have to pick one.  We end up picking the practical
commit instead of the most guilty commit.

Like if you do a partial or incorrect fix normally you'll be blamed
instead of the original patch which has no fix at all.  It works because
if the backporter hasn't tried to backport the partial fix, they don't
care about the complete fix either.

regards,
dan carpenter


