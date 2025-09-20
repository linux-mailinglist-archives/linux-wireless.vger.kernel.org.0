Return-Path: <linux-wireless+bounces-27532-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52392B8BB78
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 02:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 050177A7F95
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 00:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BFE154BE2;
	Sat, 20 Sep 2025 00:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="FNi1FCq4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B78189
	for <linux-wireless@vger.kernel.org>; Sat, 20 Sep 2025 00:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329915; cv=none; b=ZpVdTSZgNAHnuylux0rt9epLHK0l+yu84nBGwo3tpCzcxwU3U5pY936TVkvDgXlEBBOZ4wmQWXG+Sv4lc3HMMGlrTi6Dbbxqnyp0siHvyMUDQK+0H8UeJNNSlHC0XURUEudIVfmu9ZuECfZ6X45F1zhMqgq3REuCec2R3kcV23U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329915; c=relaxed/simple;
	bh=dOqoqBQvbMgBO4q9qTvkjSGSTfIfocM3zwJcwNNZoU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUWMmUVGsZL1iZy7nXeQWJE992wQn7irGSU/UF4P5Gvge8rf8eSHn6WJMMCbsiM/pnWloTtY4Sxo9U3p19GfZ/t2KhzTtPd1wVTaU3wxE2TZjeFDGGVKoYczTV9/h2vUi051XgU4DXMtI6MTu6/FlundahHtzhepzsXyHjSRAO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=FNi1FCq4; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b523fb676efso2384649a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 17:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1758329912; x=1758934712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dOqoqBQvbMgBO4q9qTvkjSGSTfIfocM3zwJcwNNZoU4=;
        b=FNi1FCq4+mL7fJe2ZjUvk8ZfowQUgT8NvXGsH/3N9V9eSdtNqPaiP8zR2z+/g+rsSq
         9I1k4Gyad3JyGODm+hCGwaqHrRsI5Xm5AjqHz25QcU8gwRlPZrNDlOKHHW8MwOGySFlu
         0vuVdQVkJLsobGqbaX7ISwAOivvCpu8VrEZbiB1ImqvVjuKW8HJWwN98lT2yjCY1L6rI
         QC/yU4WHsKWQ5O0pOFF4Yat7e2LV47UoZ1dZf2QtzS2O60ONPzmPEeKopV5oYQcOJ46S
         YbvMEAD+vx4krqF4KqkFJZ1fZl6/JrVQrLg+9i7qr4L3bSYXmvbwZZPrq3QTPdocJ92x
         zQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758329912; x=1758934712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOqoqBQvbMgBO4q9qTvkjSGSTfIfocM3zwJcwNNZoU4=;
        b=Qc+GAIeDP8B3kFuIXhjNxJmd8ov9IsUth5fKtiT7gBUZ57UFg+8D5jFQ3yrzBIoOL+
         eSgqrXNXwlY2jFhf5vwk2w52dUUTZhe7DojsCLBaKTG5Fb0Lq5GHvK+wzuT0FOKWyRrz
         Mx4GoIu00Xxl5G3hyvakyr99YNe5DsgrMIWfT87Z+1V8OxG3jWqYoA7gEfCRHA5DAmDj
         hEufD5HijgiAhj3LGls0IimhqpkdLtRpjEhAhFVXzsuco6SIv6F/wq0EYtq1KrZqxiYk
         h3c/Qt2dZX5UXKDk2NpkkMkZ5OhEL2UtHB8c0o3hZUbYr16YPoKAveYW9CcCwVdy4N98
         FUAw==
X-Gm-Message-State: AOJu0YzQM0usQxRrjLtqJViv/keoOifQOtxxZnA+vfFvuEEPtXhCIUfU
	kp0Ah1121bIeowEIkanqS8kw0lF6dQKDmiIBQnd+vFmzzMjV45yDlxlv5Dwxcmesz18=
X-Gm-Gg: ASbGncuxvVlMuANb2Nt2zzVF+JO28wJlRSGFKXQaKFP6qN4hKQiWlsrnA3131dkgIJj
	N96Xsos1BQ7yczwfadXaIjYErbohFLKvbvPmT6c6h7ShbQ1ojdmJtkSTsFaiZOLTvQSAoWAWc8x
	ws0umiP3ULuyMcs+oRKrDF4YKijcdp98FeR4LEPOze1gq3QlI59qjBvbHLxPVYTAmzCyL+EYa2j
	IyVdpr49u2MWJyJvJgtZrew/sAz9qG3UtFc7bLfpkb3rbMFq6/rOI81svDVq0v8Rji1uTphWzrw
	HHtXIgCR9s0X4TJ1W2ZSg3l/MZ7GGoYrUzeSWj0hcF/7o8aJ2dljLhf7sa9ur3zI05JuNXg+vz5
	rkde0QnOerceEpDoNnqKgni5/4A5HNQCz
X-Google-Smtp-Source: AGHT+IF8hGb7VOtneyeqaUn1qvHg90zu6fwDfc1BfmAwe44m8/vfZkBKCkKh1QZJFjMYCyZkjgJTZA==
X-Received: by 2002:a17:902:dac2:b0:246:4077:4563 with SMTP id d9443c01a7336-269ba4eede8mr62771295ad.34.1758329912555;
        Fri, 19 Sep 2025 17:58:32 -0700 (PDT)
Received: from localhost ([60.227.224.187])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed26a4e5csm9585924a91.8.2025.09.19.17.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 17:58:32 -0700 (PDT)
Date: Sat, 20 Sep 2025 10:58:27 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, 
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH wireless-next] wifi: cfg80211: remove
 IEEE80211_CHAN_{1,2,4,8,16}MHZ flags
Message-ID: <pz6rm2z54rdhst2fksjcj62gqprpagtmnkk5aggu7qzse7qsgi@r3pruqjdh77d>
References: <20250919122325.f0abcf092b9b.I04478fde87a79c7909f1cc4249430deaf71e8bd0@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919122325.f0abcf092b9b.I04478fde87a79c7909f1cc4249430deaf71e8bd0@changeid>

On Fri, Sep 19, 2025 at 12:23:25PM +0200, Johannes Berg wrote:
> These were used by S1G for older chandef representation, but
> are no longer needed. Clean them up, even if we can't drop
> them from the userspace API entirely.

Thanks for removing these, probably should have done it as part
of my patchset.. Looks much better now.

lachlan

