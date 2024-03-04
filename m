Return-Path: <linux-wireless+bounces-4357-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39270870B7F
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 21:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79B54B211BE
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 20:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425E57A15C;
	Mon,  4 Mar 2024 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYex9yes"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08BC4AEF9
	for <linux-wireless@vger.kernel.org>; Mon,  4 Mar 2024 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583918; cv=none; b=h4EiBZGMd1YTECRwU+z+TETjZuGzG4eHYfEOFtEcUAGBVEWwIrK0QeNdXanWbdJplZmRnGrN9gvwuPXyW3lNq5T23EJWUNmhEEZDNclSYtyKjO3RMf5u1oQeEiqQ+YykOa/rbddmB5X6cobGJp6cQYtqF8iBqjSV/HLMq3aGEqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583918; c=relaxed/simple;
	bh=KG+rBZ9Y8sUA2mzDLcHSIfttACEMfxFlb8QhvQWelNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZL/RuaWh5QSDTZvxCprZl24fpTkaXSRjM7ldseHWSmuaGVXlpr1TCppNQl7lgtvE6PWQZ/03E01y4kh7FJLaQsLA7sV4tbtGHWp+ralMOkkIIXzvrKjHdnwJ1ydUB5OArF7bqAgg6RZksky6HbbuX560TiRANUwx6QaGmW9hKgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYex9yes; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso5138040276.3
        for <linux-wireless@vger.kernel.org>; Mon, 04 Mar 2024 12:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709583916; x=1710188716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KG+rBZ9Y8sUA2mzDLcHSIfttACEMfxFlb8QhvQWelNE=;
        b=UYex9yes0NuyT4PCUwKJImkwZ8g1SEd1dam1mMwxHaVX5ZQ4AWt8KkHAf+Pr6MMDb1
         rCYrXY5kmT+InL6ZcnRFGBykpdfaXCSeih/9z+Gb5QegJ251tM7IqktDvRmw4OYPFLRi
         aO56ocMfNfvmG555/OCHnxHw4wN0I+McMARL5nnY35xpmwgqM6Ua3wU6J3NUsc3+flJz
         VwrrbJvft7B7ZjrQQkuZ+DyCFGSjv+nqTWRZPXrQ7qNB7j99oA6EaDJYDtgKgg4VZYMa
         oGrK5Og6/YCjb+fsdDj3+pFc/4pO5rtcdcfyg/bH6cWEv6TWHGMr9fuxtnG3Cg6DIb+V
         qrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709583916; x=1710188716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KG+rBZ9Y8sUA2mzDLcHSIfttACEMfxFlb8QhvQWelNE=;
        b=pcHF4FE0yYj+sRpO2WOA9V/BP9dZ9tX75V1A9xWjZgvxvdXSTn08q98aualX35ge7C
         J4LsVAr33BseeFN9+RYpXW0xnVW9cP5kwMSXz4zKxoMbuIxuvqUuyeu7qMU04v0N8nl8
         Q3oisp+RGL33bUDzLRVFLe0Ahr+jYaN665WCf/FEp4yfeYv2u7anJIJJZ/S7XaHTGtc7
         yrAeuij54HdF/L9xya3xvOY2R6wI7gE5+5m4EJOEVnL+Gi3uOty1TsBmb89E4H1LntEP
         4RQ+lMzWYN3fqt7yRV42MjkAF2BGGfikWucoNx3QdH3JWm06ZiB+ZpnVHgRHxtRxnJAh
         8L/w==
X-Forwarded-Encrypted: i=1; AJvYcCUK/fMiCyq3LLXNmnlRvqJ//eQ1BmuNhFhKWUgWUwLFPfFfOf9NH5aj3vR5FLmXEIQpz4jlUbdOrWoKg+WLpqq/2JT/yA7cctySOhGnAiM=
X-Gm-Message-State: AOJu0YwBTf5ywgeN6BS6h0nEEo0H2HPRRbgaJKvHWoel5nuZ4fAGxwt5
	zjth0fbtrZYqGNhqSKOyED7A3QDjeF1JyVSVlkEaqpDKuH0QHumhSxdprTTetZWciH8egqID5aW
	mDJcrYpCnCxofBNpFfPrDZy9M5CE5SIu3x+Lk6P/H
X-Google-Smtp-Source: AGHT+IGa/DuoW3QUIThVvVjLVN0ys0SFBKCFqH67IgjBrVaRAAKewbfmUiu3V1N0c3bz0YkTw/Kd6FXVZBg/0Buq874=
X-Received: by 2002:a25:9902:0:b0:dcc:9e88:b1b with SMTP id
 z2-20020a259902000000b00dcc9e880b1bmr7173283ybn.37.1709583915748; Mon, 04 Mar
 2024 12:25:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACDmYyeipzNzeBoXQEtsXRu9uHUuteZ1ymJZZ-GsM=zhT19trg@mail.gmail.com>
 <4370a021c6870c58fb15718ee9e4ce8d675b3e3a.camel@sipsolutions.net> <b2e33f0d-e13c-4bc0-befd-dd6a0412cb60@quicinc.com>
In-Reply-To: <b2e33f0d-e13c-4bc0-befd-dd6a0412cb60@quicinc.com>
From: Isaev Ruslan <legale.legale@gmail.com>
Date: Mon, 4 Mar 2024 23:25:06 +0300
Message-ID: <CACDmYydiooRW7cPYzJyQAV1+qw+4Ai7gJv1yj2PK8YxYZh-AtQ@mail.gmail.com>
Subject: Re: [PATCH] iw: Add JSON output options to 'iw' for scan results
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 23:16, Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>
> On 3/4/2024 11:00 AM, Johannes Berg wrote:
> >>
> >> If these changes prove valuable, I am prepared to continue working on
> >> extending JSON output support throughout the tool.
> >> Feedback is welcome and appreciated.
> >>
> >
> > I'd prefer to look at it unmangled - can you resend it with whitespace
> > preserving tools please?
>
> And version your submissions as well.

Sorry. This is v5.19 branch
>

