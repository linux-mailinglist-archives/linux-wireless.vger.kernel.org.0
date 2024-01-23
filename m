Return-Path: <linux-wireless+bounces-2387-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D1C839496
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 17:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351E41F265BB
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 16:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930866351E;
	Tue, 23 Jan 2024 16:25:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06BA62A0A;
	Tue, 23 Jan 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027134; cv=none; b=qV9PwytT3ltFqSfOpE0apgVjbMTod/5GCHkLqSNE2500rMrFEwwtHKVZAqChVPsPZk/69U2jScB3olYXEqiFjWH3WLNK/torU23m0vFOFZSzFrP+CWvuh5/CFcj633RTIxSWjTYBjkjAyz4J5oW2mS4miLlGNEp9rj8Lwq0UvNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027134; c=relaxed/simple;
	bh=uwUEjcgrbY8WTTyfrrh0dyrajUMf7SmzZkktsL+CQ+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uE/721hhl8InftvCarU26UHW9DMKgrcbRiA7aEnyASyVSKsb8TtE42/uum8rxee2ekWo9XkrhOqfZFpwfDm9e0lvjQCva9FB/oPDks4Y58ib1juM3HKZnelzINXzUFDDhEZap4gm5zEcB/t05WH9hx/ZT5M/m/vscuatoMOfpC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cf0e9f76b4so11445171fa.1;
        Tue, 23 Jan 2024 08:25:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706027131; x=1706631931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ci2mE3KtOOGm7+F76P6ABI6GsSgvZGpzoB6ufq0O5A8=;
        b=itToBaonhnlQQnO4+70g0sipIFsFf0RBheGc6zMRDYEaMLpQH8u57TdIXLyYnkNJJW
         oSCkjL2UhoEEtuu32mAAM0CT/7SSVyVxycB7T8G3HXDmbpeSpfZw/XkPqkWDIoDULcgk
         ZUvhCjIt/loQ5OATpvRfWH3y9xHNFhHQJAJlhegBveXVf/QUbzoj4XbKbRanlsMbVU9c
         /JB8IXROKYeEBl5TO3x2q0XyFTr+lkaFdJzDxG1uP5CQrjoHVtKRFnjQGgAi3FI8wbhy
         Q6wAzN/G/QgD5JdHii6BvJyh3VWROErWkZb5h58yyBbEuENl6+uPAa/4AqYEXeXaaHkE
         7yEw==
X-Gm-Message-State: AOJu0YwcqaVYXoOBzjPYHwpjRauXIemCTik9X7VfdWmXiBCnNdpJS272
	c73zDzrP1pCD2nX2ab7nRKcWHswXcoYcf/ff7pQvAWoMVlb485m7
X-Google-Smtp-Source: AGHT+IG6JCSRPa4ZKUf1WSa2gtoifg+kf/4XZSWZod7NK+JwGzpLXAejBOUuk7WA354rXov6VK0a2w==
X-Received: by 2002:ac2:5f06:0:b0:50f:f9b9:f542 with SMTP id 6-20020ac25f06000000b0050ff9b9f542mr811243lfq.7.1706027130479;
        Tue, 23 Jan 2024 08:25:30 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-009.fbsv.net. [2a03:2880:31ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id vw13-20020a170907a70d00b00a2e92247a1fsm8355051ejc.62.2024.01.23.08.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 08:25:30 -0800 (PST)
Date: Tue, 23 Jan 2024 08:25:28 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, abeni@redhat.com, edumazet@google.com,
	dsahern@kernel.org, weiwan@google.com,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next 00/22] Fix MODULE_DESCRIPTION() for net (p2)
Message-ID: <Za/oeIjnMoqqp4Tt@gmail.com>
References: <20240122184543.2501493-1-leitao@debian.org>
 <20240122105708.52d33fa0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122105708.52d33fa0@kernel.org>

On Mon, Jan 22, 2024 at 10:57:08AM -0800, Jakub Kicinski wrote:
> On Mon, 22 Jan 2024 10:45:21 -0800 Breno Leitao wrote:
> >   net: fill in MODULE_DESCRIPTION()s for Broadcom WLAN
> >   net: fill in MODULE_DESCRIPTION()s for wlcore
> >   net: fill in MODULE_DESCRIPTION()s for wl1251 and wl12xx
> 
> Thanks for making progress on these!
> 
> When you repost:
>  - please send these 3 to linux-wireless as a separate series
>  - make sure mailing lists are CCed on the cover letter
>    (yes, get_maintainer is embarrassingly bad at its job)
>  - please send 10 at-a-time, it's probably a good tradeoff
>    between series size and reposting risk
>  - please target net, I hope I convinced Paolo that it's okay :)

Sure. I will split this series in 3 and target `net`.

I suppose it is OK to send the patchsets in parallel, instead of waiting
for the first patchset to be reviewed/accepted before sending the second
part. Is this correct?

Thanks!

