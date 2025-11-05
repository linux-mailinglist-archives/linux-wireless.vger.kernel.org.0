Return-Path: <linux-wireless+bounces-28616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8B4C363AB
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 16:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6023621D31
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 14:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C292F32D7C7;
	Wed,  5 Nov 2025 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mtPOEdY5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D998F248F57
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354465; cv=none; b=LI0g8vRJjweh52Q729smeV6rTapdVDPNvWwqVtnxM85kt/A94BEO8E8G0uuyAQDCSVf/+wuSLNr3sCxlGWgElMtz7hhh5s0o387oU6NuqWlX6JLI43snsJzoPw/aOwWcWh2buKgMBl+rgK5f1OJPDf2fMiW2HoLscPN9JHZ4arI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354465; c=relaxed/simple;
	bh=9PR9Ui8ToTKXxDFeyWEbNhS/TV+0W0qENUAbZTNpHkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIhRBHID9MI+xpOt2YTDb+18K9KEU/dNftzm35YOhZ78aZiId2v4WhpjRIML0CrjNQppJDApzS1RHdkOP8Gtx8OuR4d/LLvf5//7YD2/XRKeMC/0hRcPtoYLPcdx0e3En9NgCK3v3NBssY1B4NwjYwlhWy8NMH9EzXEI0a0bx+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mtPOEdY5; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6409e985505so6853475a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 05 Nov 2025 06:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762354462; x=1762959262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rso48ZLUTdUYb/Ey0UMY/9I863vsAkEssUt/OOSP5Kw=;
        b=mtPOEdY5WrA+l6F9pJVWZLxJYaYdcKJmW7ejXOLSsbQKdEZ8b8MvBZacDazpIREqn7
         eeAEJf0+kDBo08qmJD+dnw6ogkc4U8pph8GkPHwzRQj/CLbFyXn11p7RfgH5aBxTDUlu
         vEXp8VvGGQ+sa30j5uvkB5MtMMRUXhjU5EuLn+IE6NOCtw8JApJLfML6Zkp93rfyupiv
         Uo4h+bQE+qBcUFpTwChc3hTvp2KWT2OLtJklrV6n0TVvopS0F/hw2VwsvPNZU2U2drj/
         V5UUD9NPuN/1p/jFQHiwbRAXhR7mhcKSOPIEne+cbzmDZ9Ei8W2e0sUyL8kjjM3cJAkY
         L50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762354462; x=1762959262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rso48ZLUTdUYb/Ey0UMY/9I863vsAkEssUt/OOSP5Kw=;
        b=Th30t+Ih+NC+QGqiWiWx84ssWqF1iihrLB6+u56Pi5Uq7IRXYRDj9ZIVBBZ5pVPheQ
         nXnLR8J0t+h0o8yqF6hTAcGay3KUbVii6lgx50kPrANttqCEzukCL8dS2RqMhsCcEur/
         NAwcCJ/LniP65kdOOLXC8Fn4M7JaHlsmUjzORTnlQ54ddJkJoqzgl66n+vNjGf89cRin
         R0u01WG/MJx5s+Qiu5KOIU+PjySHX45i5QxE8I8VJ79se1rj75C5aUYU9Jo4dZ9P40QO
         xOjSViWCU1egamZu/hAboO+CaW5mSuCM5I54QrbuK2wkAdo/ez0hAsRSlR63G4rT5Cwa
         30Kg==
X-Forwarded-Encrypted: i=1; AJvYcCV2sGAcjZMqu7tVipGQCUJeutFB+H29C590180PPJbUMa5fsTY2udy/ydaoj9qvZPifJXYGQK2geg7WqlvdzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlZz7/wZ0wgMKm8vNLmvTPE9hn29z1TjVACCcSq3Fj7Tr1Ex37
	xmX6Nc3Ywu8iQ1+XwgZIW+JpEGGeh+TeT/DNL1hdGY26AyfWvPn5jH3Dg2ImHpavzvw=
X-Gm-Gg: ASbGncsyA+0idlESNwTYXIzOs2TeKgnodfM8Ju9N1T3ziAqYdIghL2nj3q1s/RCfRZN
	oMP6ZrpkEvRO0+Qxg/FkOxQA5GM8XnAfvbeUtDWcbzfWspBCG7PJhBbTsfz8sPcgAeofVASMXKN
	5eJpLpfzTSHs/x3b5QzQQm/eV0b0vpdwo7AL/BorAYgsnYCWcI8gvAK0k9blvRgMuEkzypvotf7
	lCtx5Q1qwPPBbDukx7weH9OqcLVAA2IL1/gJGicbmMKiIs87AfEE327PXlkWllNzh7bHndwfdPN
	KDjIiQF5M4epK6EUNrHzZsre7IQkpOWsPH18cRFvkJD97OyzMgxcVomim5YQ/5o5cguMTX4jlI2
	THEDO18XW/H3Yehg2H00x6j72vJefTssZhWrTBWSLx/DEAc8zj6M1MllmK6o0OveAbP+6wf2ULb
	Pwqm7y61hqOCfWgi26Apt4FIU=
X-Google-Smtp-Source: AGHT+IE9D6VKvyalRSJfPC3AIpQXjSXQIzyul0MgV+vBwHPjqR1hb6Z5sp0y8RViBXTUBYLh7S3xVw==
X-Received: by 2002:a17:907:d649:b0:b71:5079:9702 with SMTP id a640c23a62f3a-b7265298431mr364006466b.21.1762354462083;
        Wed, 05 Nov 2025 06:54:22 -0800 (PST)
Received: from localhost ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b724034ade7sm507488066b.69.2025.11.05.06.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:54:21 -0800 (PST)
Date: Wed, 5 Nov 2025 17:54:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] rtlwifi: rtl8188ee: remove an accidental '-' character
Message-ID: <5c992936-4e7b-4c0a-abfc-0ec0fb9ef9fd@suswa.mountain>
References: <aQSz3KnK4wFIJoe3@stanley.mountain>
 <8d6962531a9545fd8279fbc7cd04340c@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d6962531a9545fd8279fbc7cd04340c@realtek.com>

On Mon, Nov 03, 2025 at 01:17:07AM +0000, Ping-Ke Shih wrote:
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > Sent: Friday, October 31, 2025 9:04 PM
> > The "->allstasleep" variable is a 1 bit bitfield.  It can only be
> > 0 or 1.  This "= -1" assignement was supposed to be "= 1".  This
> > doesn't change how the code works, it's just a cleanup.
> 
> Yes, this patch doesn't change logic at all. However, it looks like existing
> code is wrong, since other places in the same pattern in this driver set to 0.
> More, I check vendor driver which also sets this value to 0.
> 

Ah.  Good.  Thanks.

Could you send that patch and give me a Reported-by tag?

regards,
dan carpenter


