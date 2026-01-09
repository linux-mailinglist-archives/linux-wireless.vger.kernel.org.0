Return-Path: <linux-wireless+bounces-30588-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A18D070D8
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 05:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B39F301988E
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 04:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2A850096B;
	Fri,  9 Jan 2026 04:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="n9ggVEZZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AACD500960
	for <linux-wireless@vger.kernel.org>; Fri,  9 Jan 2026 04:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767931246; cv=none; b=j4zCmFhJripaWnOK4ab+TcIr7j5rMZZkBAu+q/XaigpXlqrxzMcfC/JnyiQVFovuDAfJ3MtQq00CoONC6lhmnMdK9PVYRtu/p5f3OKb9L/vrZ7Pmc7Rd8s7PWrJw4hj3piV6LWbuyOwmWdhmT464ujOARDfDb1ROhwFsiLN9E7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767931246; c=relaxed/simple;
	bh=4mhSdbI0IqudR7Ay7ngXNn5oWkCq2zx9BXqq21uRx1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYMC6T46AefJcWvVLbVh6hs1s+XQGzmcqS8P37Xk2HF9XOgbKPlOtuMOnEK9iG8MghJC1lXc/KQ764mdbOBratJK14+H/CHmq8+77dzrd+YsnMJnV7cOcQaNe9BrycbyBeWtGbkdPuaa+FAgLNbujnuHDUA4/PeOQGOmg8puAKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=n9ggVEZZ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c565b888dso3315747a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 08 Jan 2026 20:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1767931244; x=1768536044; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gsiXpYbTmQaIHatVTcxQ+qbLHA99To4rU7ZdKG3z8VU=;
        b=n9ggVEZZlyCbBAqnSVAGdVoNuhDQ8piGm2qPlxSli7iv3+zzhOhxDwGHcdAqHfShxj
         /8Zu+kiQtKFBokUTVXkl0AaJRicEg7DsaRQnGrnceO+ThSDU+0qXKPJLCO+wa0Lkk2ob
         hixILyo3NssLrIuoSMa5ZMUtuOPcQ7TYGrP8JcHZYWh5qB5+zmQ49xkfw2bneCcCX4g1
         UVlORPEZl4HHkvsi7WIehAIgwmgFZGZy44ldvfV1pyQYE0zf/cAEHYnf1l0lmqOjBBtY
         22nxRsvSNL7BIeUCmKrQSMt+Jxz0r8wkxHVl41sAL8fh6fJFidDLCJrM87XwhQQY8M9Y
         bvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767931244; x=1768536044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gsiXpYbTmQaIHatVTcxQ+qbLHA99To4rU7ZdKG3z8VU=;
        b=mr9QiZ5HYErl+ITgAJ46TFkPmQzF8/dOVvp+oqMPZI7Ag/LFy7bS8prnklqcgorpie
         OZCMGVIJuDGkoyJnhdwhIxN5icKlqMk4haZcQrPGfOTKANcNWe1xld4wFEW+gAZhS1hp
         Fp8xkGC2aiYqjRFBoCxbJ5yG+qnIxHWg4h98g+D8NiMeGy3bnheiyqedCyJ7vp4gFGFn
         X33+t48N9nRKCbgV7OfokMe9rWxRg5aWlMB453njReADDnfIlGYbzhklKksYIDCL9GxI
         KuBqMe0/lR9IBkx0b+IXp92fSIkLSY+dXIaGXjl7m2blbmCk3KalgRFWZb2BmeigzB0b
         OWDQ==
X-Gm-Message-State: AOJu0YzgAViQBPPIKDRoSq+seCGik44unGl5d+yj7Gxfz+xNHpZZjpjE
	29KVrMSnMQILPTbKPekxKh0YKxi2Vm9GrV7yKxN36l3LcJAqhwTYbvO4eVJHz2CPNA==
X-Gm-Gg: AY/fxX43/6RVCEUBGX5ubuKguXGtzwFzgZFJPFY/YZB9oWiES+r/A6XaVoHq1flH6PQ
	H2+TV0gVzjMf7xxX/erUrHJyqzzEJrDhj/sADONO3Ffto1olub+mpGMOtUPzl0giK3fOHK++2tH
	yMjrOf5yLZkIKjHeQk4D8szv3bb2aMTTCdOl4H6TrnAkmcrLXrcHB1D+3/sDeGmCiXusDinLhXE
	PMxWduGBL9vIgd22YKWGhuhjQLsRbgwolkVjgrHFONJ0Iw2KzeuHQUpSpb0gt7TG3VSMuaT78Ec
	h2WIbiy9O4uPxv9hSxzbKhsgYILSuEqp5Iq9nnWXubxlFXZBPzILmWLXbK/uPLIt1zhCnwlJxMx
	MthCl2IgMjw6qadKavhV81RVTC4oJ1DO+Ar39QaIz3KEC9j2PjX3G7sm6i2k23mUwLpmuNfyT5h
	x/t7Y965AgvKvr
X-Google-Smtp-Source: AGHT+IEwgv0j7kQeJD6esmfX5kZFPY8icfEHzSqEZJwNyYaQxGoCUxpvuKFD+q4BDp3exV5j47/pbg==
X-Received: by 2002:a17:90b:1f8e:b0:341:8ac7:24d3 with SMTP id 98e67ed59e1d1-34f68c7ff8emr7536837a91.34.1767931244456;
        Thu, 08 Jan 2026 20:00:44 -0800 (PST)
Received: from localhost ([14.143.244.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f6b0dc3f9sm2342178a91.4.2026.01.08.20.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 20:00:44 -0800 (PST)
Date: Fri, 9 Jan 2026 09:30:41 +0530
From: Ria Thomas <ria.thomas@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, lachlan.hodges@morsemicro.com,
	arien.judge@morsemicro.com, pradeep.reddy@morsemicro.com,
	simon@morsemicro.com
Subject: Re: [PATCH wireless-next v2 1/3] wifi: cfg80211: Add support for S1G
 Response Indication Configuration
Message-ID: <20260109040041.tnk7e6uewo24u3tr@1207>
References: <20251209062424.3926297-1-ria.thomas@morsemicro.com>
 <20251209062424.3926297-2-ria.thomas@morsemicro.com>
 <9eb13765529bac88337ab2fd1a13769fa4519f52.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9eb13765529bac88337ab2fd1a13769fa4519f52.camel@sipsolutions.net>

On Thu, Jan 08, 2026 at 01:27:44PM +0100, Johannes Berg wrote:
> On Tue, 2025-12-09 at 11:54 +0530, Ria Thomas wrote:
> > In S1G, a STA distributes a Response Indication (RI) to protect the
> > frame expected at SIFS after the eliciting frame. Introduce a
> > userspace configurable selector for the expected response frame
> > type (i.e., Block Ack, NDP, or no response) after transmitting
> > certain S1G frames.
> 
> 
> > +	int	(*set_s1g_ri)(struct wiphy *wiphy, struct net_device *dev,
> > +			      u8 val);
> 
> I'm generally not very happy with state that simply "exists" at the
> interface level. The documentation doesn't indicate anything, but the
> implementation in mac80211 just treats it as such.
> 
> Does it really _need_ to be that way for any reason, rather than being a
> setting that is, say, part of the association and/or AP setup?
> 
> johannes

The WFA HaLow test plan includes explicit test cases that require
configuring the Response Indication on both the AP and the STA.
In these scenarios, the Response Indication is not negotiated as
part of association, but is instead set dynamically after the
association has been established.

As a result, the Response Indication needs to be configurable at
runtime from userspace and applied to the driver/firmware
independently of association or AP setup. This requirement
motivated the introduction of a userspace‑configurable selector
that updates the Response Indicationstate on an already active
interface.

If there is a preferred way to better scope this configuration while
still supporting post‑association updates mandated by the WFA test plan,
I am happy to explore that.

Ria

