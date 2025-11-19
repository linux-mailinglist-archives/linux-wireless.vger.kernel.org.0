Return-Path: <linux-wireless+bounces-29118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA13BC6CC19
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 05:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84B954E8512
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 04:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF29F3054CC;
	Wed, 19 Nov 2025 04:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="dtZavdKc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04CE1E98EF
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 04:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763527008; cv=none; b=Y308tmkmYVGZcGY+woR6l/fvl0qBFs/aJIqzNmlwS92j2PSSwm+Xb5TMtwfLPafuZ1H81fr04VVMUn8BxPN1W0YAHCKOwQjgwULmll9Kvk3ftFlHeTg3zTon3asV7L9JT32Utz56JRZisMkFNt9gWlrDDlwqVDqUUJaaNRueYdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763527008; c=relaxed/simple;
	bh=zZ6Qrgq9gzCDGyW1Gh7kSZvtFakLZ36UgJH9PlqdG6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaFtKyRnHAlWtswuslz5+dtwaYBeDdl92BEaT1AHmMV2CM9EvwIfAC1wHTR+inA6rYEoPNy8d30EZXabC4OsVa4EJhKDlgeAylRfC8US7GB5czIhdnSrco9V0AinRn0/DphlxOqvGc1LGkpljFil85TQM6Ls+HQ1B7JcVGCQOJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=dtZavdKc; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-298144fb9bcso66159425ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 20:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1763527005; x=1764131805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f3kzyI2xZDpof4CAKHtAy/jPjf6L1BRnkv3kMrjz9Gk=;
        b=dtZavdKc9zEh3CmRK5koPwL6Nfv13W8fI2/GPuG4ttB2X6XHIjfdqs6dEUeQ/5YO/6
         0CTJUBMpODiuBtppLkuiKnNnd3UAvTMF+G0ucGPth3Lqk8OMEXI+mc2UKqu0WHx+NDMO
         e4vbv4Gi4gQWkqapoIAH7YX8pvOnnsUtUtbCfUY//97roFMLMfo1FwjNMQG857sMSZUV
         XLDvP+8QTn+binCkMUaN6M9DlgUUjqUU2Xmd0wrah0et9zLVhi7BKFiY6XjtEBsUQc27
         JyA4BTDajlN06CuIXuAHRxdLroz/5xHJyjbawT7WQ3gcrJuW2/f7D5PwcupExuq/OOG3
         gTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763527005; x=1764131805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3kzyI2xZDpof4CAKHtAy/jPjf6L1BRnkv3kMrjz9Gk=;
        b=BPIBCjWNThFhueDsCfCC97rkEFm7kFA5/YCL+ZngYucexpJarIdv/R3BBiQWeIUG8e
         9wxDNFnjLRTq0V5z8n7tS734F5oFHdRtPxfsn/IR3G+JMCHuAOSdVUs3XSjvpzOkBbVs
         fcWTNn+CayFXtORM3NfBQuGCKSaycxz0MhYLF7fuzeUXrG+v4wzz04k+hb2LoOHc4eHm
         0f8MLPdPPpXJw4UpFp9Dqm0cW/8w/PMl8j/s9JwjXiz4rIdFWwgKgvUXPs1tlYTjuCTE
         bfFFz9NcvQR3pnS38Xb3Hi1viOVSi7B6D+YpDY8e3Up/4gZpU+wylTEIiVhTJUd38Mba
         m84g==
X-Gm-Message-State: AOJu0YycaLT7fAbgjZRJrlGlwRNIaf9JGq7+986i7ttecVc1tbLnwe0f
	IdhwnCGjwKmcvedInJ5JQWpfA4wH/SEfoDZXcnzjoB3OMH4szwCvvXnuvR9ctZTEJvA=
X-Gm-Gg: ASbGnctFYRdURE4rfRhwP3S0iYgAB/qrV3nCqDmZ2waPKhL0ocwKIr4bDETLl/H3GNR
	TtgMQJrAaZq+2FfNm9wPm7GqsMjQhv9GPz1srX5x0g+0rds9Z6MA5PXL1k0GRDAwSV2++puHh/C
	Rvrv32wtJmPZk8KC79+iWuoYPZJK5se05lbEL6MMo+jTzv+8NhprCZHdD9PAESDvN5r+0tdGYqo
	5KoReBQptw6EdH62xxeVt7/fmY545C0COpyW/G6mKvuQGs1xx2aYwaatXCjy4FVGKt8DXG4I7ru
	JjBf9Z8yY+OcQ8iMIi3iJOkNV+cqU3th5Urvkpbm1XttJ9BlPoM8pYi5HZ6BmkvarZBEV5ceLNA
	h/0T8lGwL7b4kBB+M/CMc0zlhwEp7VpF8d2Q7zvdygrz7Og72D0+v89zjckLHyV/wVZG6rRzir5
	MR0J+hSEU2TCQct2XTd03zxU7tuJ92WnrsnfOmYMtzQP9HhqPsAndmOI/PgsVMTAfnS1QC2aFjT
	oonqW3P0sKhDMU3FKiOsal9OvylDvXn
X-Google-Smtp-Source: AGHT+IECV3IaqRSf23gtM/OTSU2BqpMbHRUmup/t8zznQlt9phzpABscFNYuhNm8RgRqDtIcCust1w==
X-Received: by 2002:a17:902:ce88:b0:295:2d76:72fe with SMTP id d9443c01a7336-2986a74af25mr227091575ad.45.1763527005136;
        Tue, 18 Nov 2025 20:36:45 -0800 (PST)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bebe1sm187943545ad.82.2025.11.18.20.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 20:36:44 -0800 (PST)
Date: Wed, 19 Nov 2025 15:36:42 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [PATCH wireless-next v2 0/3] wifi: correctly represent S1G
 channels
Message-ID: <lf22zjgof4ysu4v3blfbt3kv54l75rdbw3pecknlmlq6kmokha@a64bzx2dtrdr>
References: <20250918051913.500781-1-lachlan.hodges@morsemicro.com>
 <5ec4190eb06c2b3763b8eb9d114a200d07437c11.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ec4190eb06c2b3763b8eb9d114a200d07437c11.camel@sipsolutions.net>

On Tue, Nov 18, 2025 at 05:31:19PM +0100, Johannes Berg wrote:
> Hi Lachlan,

Hi Johannes

> On Thu, 2025-09-18 at 15:19 +1000, Lachlan Hodges wrote:
> > This patchset correctly supports S1G channels within cfg80211 and mac80211.
> > Preliminary discussion can be found in [1] and the v1 RFC can be found in [2].
> 
> I was just looking at chandef stuff for NPCA (see the other thread), and
> noticed that S1G isn't really (fully) represented in
> 
>  - cfg80211_chandef_identical()

Yep can fix this. I actually do recall having this on my TODO as part of this
patchset but must have forgotten.

>  - _cfg80211_chandef_compatible() (not sure about this regarding primary 2mhz)

This looks to require a similar S1G specific path like we did within
_cfg80211_chandef_usable(). Also zooming out a bit, may need some adjustments
within _ieee80211_change_chanctx(). Additionally would be good to extend the
unit tests for this.

I will do some more research and testing here.

>  - nl80211_send_chandef()

Added to list. Also some wider channel switching logic may be reviewed,
though probably only once a an S1G driver is available upstream (hopefully
soon :-))

Will get these done soon, thanks for the reminder.

lachlan

