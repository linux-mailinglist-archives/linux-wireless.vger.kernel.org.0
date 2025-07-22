Return-Path: <linux-wireless+bounces-25801-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91434B0D2BF
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 09:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A544018928D2
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 07:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDACA2882C6;
	Tue, 22 Jul 2025 07:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="Z/EBCUvN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFD72C3263
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 07:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753168975; cv=none; b=MOwEfTroHiB9ESzKmZRTyEXsXph8Y+NCqHBtvh0Ih6o3/woNK9o9Y2OAsc96gFqdwfW53qX4IOm0o5YGlr51z4O9IfWRmAuIbq3xFnW4aNPj+BA8vCmMLLjnc44MDlvO8yvPgaQlA/bbS+9jirx0blZvFDNSQnqpfhPa1Yg3730=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753168975; c=relaxed/simple;
	bh=mcXRABwWqNZdmXJjbCICqzNRy8yXLXDRxfl9gZqqmcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXh3UPQIyYkcMPN+UNJvwsAcoHZQKS4nPsqedmQCB/WAl/pC3LAYeQNst8qXhbp91fNJHyLPwHBGSWuw0cuOIoz3LtOTA57Ue4FUpaP9I3MqdbShpHfZF0JUIdCtDQf3CYDb+lg/9IvBHdoav1adlrLQ8MfkZru6f5UtOUNcnCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=Z/EBCUvN; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-749248d06faso4353511b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 00:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1753168973; x=1753773773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TKT5yJs46uSUfIVt1WFlhCi21/brUWvHx1tRUNB4IoM=;
        b=Z/EBCUvNDqQ0LC+o43fwOtU+YePEkKwTJHZM44/QSs1oguSum+tOmKvxG9njQxJmP+
         5MtKJQbrkiUd/+tqP84gIqDdIBBqAUj3ogAt2+oSP0YqlP6eti8gw2NU6mUQMwbySoPf
         Qk3Q9hDYNkqHylJwiyX/Gmvr4CbWla9sqnHj8QGCxJM4ZO9pP5xfqWaXRb/50OpBbwqy
         UY50bOP6avqQnxIGn8gVo9zqR3ZquqSXpmXaQqpcJhf20ka95xu7Eib2EVw0GVTZsGc5
         +y6V7P2c2HLBLwH15/GodIq2Fse3Fn4PZSpVZBakag2VfWDuglEinpka/B//e5g/EGJh
         7svA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753168973; x=1753773773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKT5yJs46uSUfIVt1WFlhCi21/brUWvHx1tRUNB4IoM=;
        b=SacxP/x8n0UaC0uMJKi6ch2uBoUvxA6EFFvJasHK1QdxyLxirMjfy0xHP1mOT5vN3H
         4uGZzgEPXWwNL1wqbQuUCa4eNjVRGOviOy7X9RVZAvB47G2IkwZjKF3Gh2UgTez8Mexs
         zf8/VKi+vVEKd7X+eJ6GnXJrI+V0t00Fs3vF/a40IMG5duXinHrWDAT64PvuEoQijdjE
         0tXtDPagjLXQU70gwtsIJR3dbiVeK7a3AAf5tCvH/y5b3M9ePVX6k1fLNiVGZhh2df0z
         I3IHgFCghXw2LsY/jekMlfFl5xSb5JtVIHViAHnFM3c1Vqor8LpQZmzAMsGspSyQj4ye
         Y+Hw==
X-Gm-Message-State: AOJu0YxnTrl3FaImXAH8lj8FpxST/DFFf+N+eSI9h/vm2m2kHxeGV65r
	eIrFG9tJ26kREJG+9VrxfORCV/M9/bzaDXjgewHDoaDR+N8LoFN+M3+cVzYadHponis=
X-Gm-Gg: ASbGncvzL4+ay0b8CuodpOJ9K1hMQxg7GG58fUojAUKQzFAg8myOr7Hp9sFBvkelchv
	pmsdfoKQfdO4xm0vhBsd+QkaPet6+oNUZ28yXxacyvQCntxXQINJrzfAtzIJhHM7O/f4Oy+7xp4
	TI2k38uJ2D/z7zgkgLEVUdmBFJ64o22u2sPj2TN2unJbLbcBmgMTi3Y0TH7qlhc5KRDzG4bUj1C
	bzhL1vUAh3g8Dhaevbc0jD8wZgRGmABBsMut1zSR7jAs0r//e7eu7dRgX6fAxoQmuvBM+oyd2wL
	cOzvsQJ2rnTXYPLLiiaQ+gU9iKj6uJUz1UWG5rylEuXN2cF/7KOvcIWwZda/rOmwSHuoNG4QJZD
	lQoqqbYCJ9a+c7wwlixxvHa6rOSTBNvAVG5Rto9X9KuE7+4V+kAqOLgvogTmFR71zr9bA/Q1IWw
	==
X-Google-Smtp-Source: AGHT+IEQTrLvcE6O3AyIeXGrJSZY6G3IYhLbvU9LLdae60eyat+AQUbKerkY8pP6/pLAQO1d73irhA==
X-Received: by 2002:a05:6a20:1583:b0:231:a5f3:4d0c with SMTP id adf61e73a8af0-2390dc2dc9emr26107276637.26.1753168973279;
        Tue, 22 Jul 2025 00:22:53 -0700 (PDT)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c8eb0e98sm7032068b3a.66.2025.07.22.00.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:22:52 -0700 (PDT)
Date: Tue, 22 Jul 2025 17:22:49 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [wireless-next 0/2] wifi: support S1G TIM encoding
Message-ID: <tx3gim4qbf6qmwd4u6kqspzu7n37cih42elgbnwedxogvpkxcn@vmzo7fiyrshw>
References: <20250722071642.875875-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722071642.875875-1-lachlan.hodges@morsemicro.com>

On Tue, Jul 22, 2025 at 05:16:38PM +1000, Lachlan Hodges wrote:
> (1) I've run hwsim tests and (obviously) tested the S1G power save path,
>     but the 2 hwsim power save tests only check multicast traffic and
>     even then only 1 sta. So would be good for someone to confirm that this
>     hasn't broken non-S1G tim encoding. Even though it's only code being
>     shuffled around, that wouldn't be ideal :)

Something I forgot to mention (my file didn't save ._.) is that I aim to get
some S1G hwsim tests up and running soon as S1G is almost fully functional
within mac80211 (1 maybe 2 more patchsets left) such that there is some
standardised testing utilising hwsim.

lachlan

