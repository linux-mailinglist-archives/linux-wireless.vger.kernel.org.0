Return-Path: <linux-wireless+bounces-27157-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6357CB4A84B
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 11:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619981B2433D
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 09:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38072C11E1;
	Tue,  9 Sep 2025 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="y8Zk7b1v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7BB28A701
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757410371; cv=none; b=ZG7GwSeKfEzAIFsvKzBcr6Ylp5mFCxNoEbvyCRNcLHtjQZIBcXXRJD2gm4lo+dzo7Y09rQJ/Vb0G7Be53hFu3bbOEN3B/x8o1G/UUtEyotyfdgYPinp4URqYXTUd2SGsCToH5fk38SMc4bh1AY+GcGozB7eAxOJqigIykuMeMT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757410371; c=relaxed/simple;
	bh=LkbEEqTdXJExevu9J/g6dBJwkBgqLTrx7XWOIr8dmOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJEzfOqHRW075X5q0WUa2ZC4ooH09Q8sX8WW6sUSXA42SOcWu86CZAMmjSxW3zrNfL9uGAYEaLLQ3zVtzSd4TF6b3zRnHOXBbmbG1zrYkI86idQOIXAWT5bYFqVweiHFtsBAIDmR5JrhuUedlRRTlMsd4ZqJXr4orLRqcP3/sP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=y8Zk7b1v; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32b6132e51dso4150609a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 09 Sep 2025 02:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1757410369; x=1758015169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XpCfatXwVH7G9Y3YBDssIDMamzzb45TLXrrtS0nmMZo=;
        b=y8Zk7b1v6IPffeKyti9veoW74xzWoZIEFSod1R/0qDy9Co7TngmJnwNnUwPtX3pOh9
         fGbO5WN6bTV5zxDWCorvKnW/3ihZF27eG9Vq5++58RBNrgUGgD6308oYRce1PNklWf7m
         w0ef1l9jzsvXd1QQCik6f1VGRJvng9Zx+dpmcanzJzsvBtv3Y67n8AzlCJlR8PQ5uksE
         fZyvvh4Guf45J5Mmu15UakFVHMd3ivBSua3oDViuakXhRZ1UGkcECCgY6AOO37hsVZIT
         cXlNCJpEaNzTbA4U6VIqWVUNrIsQfALJzDy4HL4G4tM7Tab/VndDLkSMN9qyEcj6GBw6
         RQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757410369; x=1758015169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpCfatXwVH7G9Y3YBDssIDMamzzb45TLXrrtS0nmMZo=;
        b=AIu8VHHZihsMAMU21Hz9qcPk9oBgid8xj+wY+7EPxuCOxvV/l+9tlseGmF1Mp+wdLb
         vYmJIQVMZCGsW+P+Cv9oBvPgKr/TKZ3PjPF+b77ZRtvilrADhH5hlZll6vesQgOk16Va
         FcQ22XJgkybhBGWQUdcoCwJ+NQNMpwJ/1ykw6fXtlTvhhe2lN5BRVEz8IGnxzCVbLQca
         AvlYeNzqecXh0UtuLR79S696KAWwDF8eXHY7haqbYi+EZVsBuhCHcLk4H+Ns4YW24//C
         +WEuXG1DUKJUg82jiae437E6XmBQro1cj9vWKj+JhpAuEi5PzctVHicZPQD8YAqhu/e3
         IRcw==
X-Gm-Message-State: AOJu0YyN4Yfv8pumxJgdlOlASaoxbzHYoUZ4a/Jy1dJk7h/Io3sYyGqR
	zohtsDAU1jDStdTKOJkJHV/F/9nilaMD4PERVD495A24ckt7zn5lJPUcjzqSwiEzXYA=
X-Gm-Gg: ASbGncvw1CCZvkeMbrHbn2aRV9FpltsP+c++E5NzbrCwGJ4y+J+uA7cPZ8v8NzrcjM8
	kY8Psa955Zhv0WKjEULYG8akP8cfJZp+t+ghkAgP9PUvl+KrUQd+MGOgQcUbfek7S9+VhHOkeB+
	kgcSWScZRxvhGzGCdy/x3wMR6qwfv4YNWcDlsjQvAsw/MlbyVn6F5BLPLEk84Sx3TP72X6+H6jv
	QhfofDSRgRecibp/kD69jm/ki+tCDVXjjGCmXv29SguNfMvVJlGkUJUVYIHkQTWME5xgY2SSc3d
	3CHEc9bUlm6YTIlyzmFRnAe7wbsvy6ZOJ5l0qL/Mbf/8IdfJkDDebT9/SE482ln7djE7aC9E30B
	7NqxpIUyxcUdKYH+mZA9ibHzm/NukFqauZfr5WK8HEMLbmnlzDyIP410jFnRT32XCTahr6ZKR9c
	k=
X-Google-Smtp-Source: AGHT+IFYUPz/MN5MXEPLnbhvrOHtOmbkE2kvawttlrKvvbcJHIO220LMtLvIje4BMFSY+kz6PTvyoA==
X-Received: by 2002:a17:90b:224c:b0:32b:6cf2:a2cf with SMTP id 98e67ed59e1d1-32d43f00752mr14412154a91.14.1757410369190;
        Tue, 09 Sep 2025 02:32:49 -0700 (PDT)
Received: from localhost ([60.227.224.187])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32da0eaaa6bsm2363861a91.29.2025.09.09.02.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:32:48 -0700 (PDT)
Date: Tue, 9 Sep 2025 19:32:44 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [RFC wireless-next 3/3] wifi: cfg80211: remove
 ieee80211_s1g_channel_width
Message-ID: <5d3wifowim5wbhmo7gppr4atnhzn4qmko5ndbd4s3bvndwtgip@fke25svz3wjc>
References: <20250909080758.1004956-1-lachlan.hodges@morsemicro.com>
 <20250909080758.1004956-4-lachlan.hodges@morsemicro.com>
 <6e9988588b74e2c7d9b1450ab9e3c2174b619d29.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e9988588b74e2c7d9b1450ab9e3c2174b619d29.camel@sipsolutions.net>

On Tue, Sep 09, 2025 at 10:52:05AM +0200, Johannes Berg wrote:
> On Tue, 2025-09-09 at 18:07 +1000, Lachlan Hodges wrote:
> > With the introduction of proper S1G channel flags, this function is no
> > longer user. Remove it.
> 
> Oh, so this is some "keep mac80211 working" trick?

Yea it was to make the bot work for the incremental builds. But that doesn't
matter now since we are keeping the flags (I did assume that would be the case,
probably should've just done that).

lachlan

