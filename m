Return-Path: <linux-wireless+bounces-7940-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E458CBD5A
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 10:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7CAC1C2025F
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 08:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8D97E776;
	Wed, 22 May 2024 08:55:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BD346522;
	Wed, 22 May 2024 08:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716368141; cv=none; b=sPTHUXgbKGlxe/7qpLLpjnkHu4A0R3mmLZFxgOyv9DF/bODEeGg5gfirSsCcINeSClKvFkHXeeNF2ETLUfuSMrSZwC6N3cA+pIfRre8SKxTb6lHVIQDnLzMoUNb3xc0C3bYbATyWxzYFWn2fhDe4eYgdQ4xYMROwEoerr5e85EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716368141; c=relaxed/simple;
	bh=iWxRNOoqlA4B9l8RxZ8dXMccrb9P5UxJI0CIiL+rYoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoKE6os62GOfKhUbtkMvhW+orbf4/kVCkEfIAUmanFDBhcR2dRVrg1yyve6jRkALUltcAhIYrN3JpGkVAwVq4LvsR+OXVb7pzzgsTy4WvZLcgRKwbcof938EOnOanDJWpb/XwGSmCZm4ZMflz8iLktcN5ya6OD9qu1ztpEtAPIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e1f3462caso10366996a12.3;
        Wed, 22 May 2024 01:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716368139; x=1716972939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWxRNOoqlA4B9l8RxZ8dXMccrb9P5UxJI0CIiL+rYoE=;
        b=GvI+bWrtnqbaXu3gwztZNpK6gCwcrmaLIEMlUYuYNG1bQGy1IOvNZnV9hQl5j4I3Sr
         4WY7R1dTtLZDHcGwXJT8l2j8ajuAVPR77FM6FczI8aZpNVWOk5nC3szG647BxJo2DW6K
         lPngm0guC0ZWMtmThEEsjIV82X4tt0HIOkRUwwJEHEmZG0ai724plhwOJcQiQjFoJ3PF
         cBbIxDjt8mtru8Puyn3b2oDQTqykw2WVQu4eFoNP09H3kH20FPp+0pdvYyRdJpNHutR6
         8xKkvCw5SRlCx8MvXg39ih4+mKOPyorYDTDS4n18PwlgcM+vNw9l4IgV9yR1EoKuinUA
         NY1A==
X-Forwarded-Encrypted: i=1; AJvYcCWwdT6HpYjsfBCe+SlXCEYvANNDdbOZeSHNOvT4FKAeoZR7D2QN8d0r58IKaga5QNbFFx1uNAeTsVzbSqyT3vHlX3niHdCl0+AImGxUKZROK8HBShFwVthF0kYOnGJPsvzwAWm6JKtgJGOdAGw=
X-Gm-Message-State: AOJu0YwDZHDU+/AI8Vtq5eQQ49dlJMUNKSLeP+GXhfgszT+y3JjA3FYA
	jyoA4QX2RXxrM+AkqKL4NJFYNtFz98ZH6KSNak1MBqMZnY1ez7KT
X-Google-Smtp-Source: AGHT+IGxiQ6bn8qgjERKxdFhyBYHp7N7U2YloEfTv+RcPaRDM8k4WLdgo4je9Mx8sJk96xj9bI3A1w==
X-Received: by 2002:a17:906:16cc:b0:a5a:15b6:25ab with SMTP id a640c23a62f3a-a6228160d30mr75838166b.61.1716368138553;
        Wed, 22 May 2024 01:55:38 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17922159sm1756296666b.97.2024.05.22.01.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:55:38 -0700 (PDT)
Date: Wed, 22 May 2024 01:55:36 -0700
From: Breno Leitao <leitao@debian.org>
To: michael.nemanov@ti.com
Cc: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sabeeh Khan <sabeeh-khan@ti.com>
Subject: Re: [PATCH 09/17] Add rx.c, rx.h
Message-ID: <Zk2zCEhs9dDmOoMt@gmail.com>
References: <20240521171841.884576-1-michael.nemanov@ti.com>
 <20240521171841.884576-10-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521171841.884576-10-michael.nemanov@ti.com>

Hello Michael,

On Tue, May 21, 2024 at 08:18:33PM +0300, michael.nemanov@ti.com wrote:
> diff --git a/drivers/net/wireless/ti/cc33xx/rx.c b/drivers/net/wireless/ti/cc33xx/rx.c
> new file mode 100644
> index 000000000000..038b356f50a2
> --- /dev/null
> +++ b/drivers/net/wireless/ti/cc33xx/rx.c

> +
> +int cc33xx_rx_filter_clear_all(struct cc33xx *cc) {}

You probably want to return an integer in this function here.

