Return-Path: <linux-wireless+bounces-24260-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 760F9ADFB8B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 05:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01B716E678
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 03:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96023221FD3;
	Thu, 19 Jun 2025 03:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hvNgNHM1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B507189919
	for <linux-wireless@vger.kernel.org>; Thu, 19 Jun 2025 03:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750302069; cv=none; b=Uy1Dg2daHkYDULeV/9rdp2Z0oTiQbNGuCFtxpCSzZNXZB6Djj3S67CcX6oZfTBJGlMNi8bqrTM24CgRA9IPGB/ispiUa2cJw/4orueuex2PmN2ob6vENJxb76+2S7sVGbhJEyLpJE5MW7XtO+o0GneIZmXltHXIDmAosBLvYoEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750302069; c=relaxed/simple;
	bh=12gjNwoYH6hAN6AHnzBSZ9IBX5+mwN3Qz0UIR7b4MC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWFuzbO+FGqkGvlFzjsxtREGAhXBT6IhOyiykhIo2heQjNUn0WW92TmVh63vLebJUYFYdRRmYJIwpHjy6tAuPq5xU5wlNffACu9HeAgH/rJuYTfUsk7M6bjB7SL8ZRyTywYEq1SOorGmV6VqO9qZIZulh4jRVtcm9gYEtCzkcBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hvNgNHM1; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-313a001d781so162564a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 20:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750302067; x=1750906867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cnfPabQqBz/ZwwVEOEty3CuDrAiHGUPnLiwc5VP0zZs=;
        b=hvNgNHM1qxKEnuqXBgRRRQqWMdVSHAmzEw3wWLDNRLXWLGYzOuXYb9lgcXWrwgavc1
         msEFsUvcAdHuK85M2zk+7W8WfZlMJh5psf0vinWkloNoeZvhZljFssspvZ5IM1cmq5+m
         Q0JOwG2Apd9a18rG3wVjUThsaESDpaUiX4TDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750302067; x=1750906867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnfPabQqBz/ZwwVEOEty3CuDrAiHGUPnLiwc5VP0zZs=;
        b=QHWFOvJo21DjLmhcFGs1TaTupNh1kAIN5AlL7nz59RIqS5XdwR9xit/hXG0H4JSDdY
         IrQc678Tsi/nWin95pA+K3jfbXmVjcZc6TbNkr214cevkXF+PSI1bqmFxXQ2T8NhE7gW
         P/A72uudaoUYt7Hp/p1lV/r80pyKLg9244Kel2q09JU4S4s2n4/+0Y9Pp3h/AQqhD/SC
         q74kc/gB0KWqGKkDvvVfqyYdOl+13YClwHA/tey2X1JjWTlZYgB+toYIshJ2q4DpjFQx
         ifUrn4D2gUAuFbWHeOPwBdcmiaWpLBbPQGtG6QedyjPk7Dc4fIKUjJCzQt4cdn/v28IF
         /u9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUb1z5F7rdLsEvw29A1PV5k3LySXjFc8jhfeMTXVB3YFKKGn2Nvfz3NswM/QnLqX9EWmfsxpqMyHVVTNyTVQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgS/hpnroRPz7Ody1RObV/huNQy/xPnhzp1Y08gpLmt82xSiex
	rSny6afiCpiP+ZCZ7Evol5qEGPhmbi2IGorHV935VrwJH0TqkAIXMOei1utZnpvhCA==
X-Gm-Gg: ASbGncte51wbfLkXbSGLoThtEKlJCBFTU47EvLGzjSVr6cBxCQ+uV9dQqQ0bngEhXwn
	CNXW0oiodDv59hcj8oii3yryydp1UcCSO0GYKCXl1viAIJYyhyQMUiBLiKfjmfWhMVZE+U5nl1H
	Ok4ZcQFp9u3Dt9gTtICM3gtEEChzCZbNWJIrFH2DcG5tSkRMgyTLeouysTsunUH9brBTwA5T+UE
	KmPmmrQ3oWbh+VwJGP/eWpqzN/XQjLW86dsxiJSry1WzLG4Hq8LpuLl+uXGTLfw2QoVNRJfQUSx
	eLgQfBEYhWETpMaEbp3ZKC415z5RIG3oaQp7jXWDSHXOyihWcm1H+w4Gk4OHk80w2A==
X-Google-Smtp-Source: AGHT+IEM7nAOf6NgL5UzOu5mBdnBTlvzxMMg9oOfTzsT/78xvmOxaCy1R8U5WMF9AfzgN56JsY7oYQ==
X-Received: by 2002:a17:90b:1c04:b0:312:f2ee:a895 with SMTP id 98e67ed59e1d1-313f1e1a908mr25449839a91.31.1750302067269;
        Wed, 18 Jun 2025 20:01:07 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:7cb6:ce70:9b77:ed3b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a226dedsm1017779a91.5.2025.06.18.20.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 20:01:06 -0700 (PDT)
Date: Thu, 19 Jun 2025 12:01:02 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, 
	Baochen Qiang <quic_bqiang@quicinc.com>, linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3] wifi: ath11k: clear initialized flag for deinit-ed
 srng lists
Message-ID: <37vwemsh2v5pweyrw5yxiesz5ktwrp7lfvrej2i4xa3skaxrhr@f7iaggiztmmw>
References: <20250612084551.702803-1-senozhatsky@chromium.org>
 <xgypo7y24oxfe57psg6bdzrmvmahx7swb2ifjxqmpteagsdonw@ubrubygzpbyo>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xgypo7y24oxfe57psg6bdzrmvmahx7swb2ifjxqmpteagsdonw@ubrubygzpbyo>

On (25/06/19 11:53), Sergey Senozhatsky wrote:
> 
> If you are        with this, can you please pick it up?
             ^^^ fine

