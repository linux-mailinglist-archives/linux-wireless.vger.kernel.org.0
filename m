Return-Path: <linux-wireless+bounces-26562-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BBFB328BD
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Aug 2025 15:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A019E21C3
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Aug 2025 13:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECB81487F4;
	Sat, 23 Aug 2025 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="yxG6XPw5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0261112C544
	for <linux-wireless@vger.kernel.org>; Sat, 23 Aug 2025 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755954945; cv=none; b=j5skayN5JPpslohd59qXNE7JtgTmLbhv1c6lLLHLKanycsj+EMTa4epY2c8yhmN9d7rk2lmePEOk4STw+0rgD9PJ0B1nsWnq7+Hn56sE76n4AY5hyRLSLX4OgYBmd1s8LIfUpuvJuWkezWkzRsCmkODEVFnlfTO0bbxEW1zl3Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755954945; c=relaxed/simple;
	bh=6NyYMyP1/ZUKZvI7PKO3tLR+lrmA9BTu7vd9AYTmlOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0bkEQ4+ClTEm3DuBglhW1bsYQrtSY9Y5xZIEiUrRnepFBv478r7BX1/BWMX6qggrisC0BcPFg+HZWhZ+qchZOeYjgpH2IwF0EzFsYiDvoG+AZ0DbbQ1Q0uGy4uSv8qfJO4rM2mBCtA4wcCjNSNJbUJDI/pE/fXVVBCpPuoclZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=yxG6XPw5; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso2543600a12.3
        for <linux-wireless@vger.kernel.org>; Sat, 23 Aug 2025 06:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1755954942; x=1756559742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6NyYMyP1/ZUKZvI7PKO3tLR+lrmA9BTu7vd9AYTmlOA=;
        b=yxG6XPw5KB4MZ68ns/8XxcskRZ3PIQ/NCG9caGY+f/qeGPX/bqBm0K+abhJ6XSwuL+
         y+pV0hCMFV6Rz60P6t4vFMP77u5m0bkRLr30ImzjJVtWiy9fQjrmEeR6Pq2op9MuzTaz
         sPiVWYKUwWofhfIooBVSTCjJ6RysBSQTq2s1KLXjwGChUfXAHWcwFwAPtOkZ6olR0YC8
         d+JWVsl47DaWKdH/Y6rBIBpcXInMvRYNsDJspBMcfx2oqRMuCEMSJYzyd3yAQqxcGaBo
         wLNlx/oV9brqNZstCp9G29AkAxmDzbmozLWFq9/cQwFjbsbcn/tAEDvKau72VdD8pDV5
         0lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755954942; x=1756559742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NyYMyP1/ZUKZvI7PKO3tLR+lrmA9BTu7vd9AYTmlOA=;
        b=bhRTSrdj/cDc+PZSmnLlsZ+1wogfHa9i0qKwaz3RqEB33QNd66m1PpXg8lt9/xJwoc
         vyfhj+OZnFEPabkBVLSHeQD6BqVn/BWrq6OhHrV9N4yJteeQn26Pt5F01Vt4he70tL31
         29xNXrC9qjEphpo+S61TOKgvV8qkIMenvC8LQMu6QWQ1+F7G30eqk9/UxotVZGRsPRzJ
         1SNg218JTnCJxGUWbBXslbZYczBqy7Xj3YQFwvxJwrn4IJ8oHZQa6826Jor3vmt8ZINv
         jYV15ftHZjUaT60m5uiC2hgOJboDdsqFyNNGsBMLtxkOgRxH2O20MgQr3arOnQZsfCTd
         LfqA==
X-Gm-Message-State: AOJu0YwJMNUS43bGxn+ZUTSc3QESWz1j+ftyEW5A5qXPS014+xtPijVR
	2saTpj9+yHiJOWlgEBECL9noZlcaZ1GLTCGWQ8eQN61ZA3tDR3nldtkwRoBCblX81uE=
X-Gm-Gg: ASbGncufwa90feOPZMCepsBvF3eJVphOMSJQgBXOuS7W7TemZ8gSQwMpAfueehGKUC4
	G/NF0faIjCgcWvHLTc7nUFttYk1QdJow51Uj+qY57o3BVqMmXUiI8WNUxVzvD1ocDkIVyK4hSPX
	OEN+lWEbpiT22kk14SSofLlethMZSu9cl+cfTGLIiUFxjmGm6kAh+DO5Yi/2lZkMxSaO4hSF9G9
	tHOQc4EGl9tOJ/lm7WBK7o/hJ9XpCdHCRvxWxIfWbLYQpZ19BGI3tAaQ776fUKzdGrsoPW2AVDQ
	ZI4RGtcAv2eyjISw9umdvAh3B2eI7npYxj2LAvyDnOmKgALrMTcNlOWWT/nb61oik3lqc+Jtd3u
	FLjHLlvvJHU0Oz9MSsiGSUN2YKEJY/jHHaMaKmNYPe1xnbxnpfiQzohXUhe0QwJ0U
X-Google-Smtp-Source: AGHT+IG0+Y9HG4ymjVCH6uBniuc0LoAzkczcgwiu1WwZ8TSEPgB5TzYWX4jaqNQ6esUMmtQFfNW8Lw==
X-Received: by 2002:a17:902:ecc6:b0:243:485:26a5 with SMTP id d9443c01a7336-2462eeb70abmr88125645ad.34.1755954942105;
        Sat, 23 Aug 2025 06:15:42 -0700 (PDT)
Received: from localhost ([60.227.224.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687a582dsm22247255ad.36.2025.08.23.06.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 06:15:41 -0700 (PDT)
Date: Sat, 23 Aug 2025 23:15:39 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [PATCH wireless] wifi: mac80211: increase scan_ies_len for S1G
Message-ID: <3j7kkqznavkxt23iopacl626xkppzcitiactxz43axqorucrvu@6gaixffy7zaj>
References: <20250822062020.904196-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822062020.904196-1-lachlan.hodges@morsemicro.com>

On Fri, Aug 22, 2025 at 04:20:20PM +1000, Lachlan Hodges wrote:
> The bot will complain about no Fixes: line, but I think it is
> technically a bug since it will WARN.. ultimately depends
> what you think.

Maybe some more clarification would be good... While I guess
its probably not a traditional bug, rather something that was
missed when the initial S1G work was done, I feel it should
go in wireless. As mentioned obviously you will have the final
say and I'm not too fussed with either tree.

As for the Fixes:, there isn't really a single commit we can
point towards, as no work was done to explicitly enable
S1G scanning, the commit that added the type maybe but that
doesn't really make sense since that commit on its own isnt
"wrong". There were a few commits on the receive side, but again
I can't really see any commit(s) to point towards.

lachlan

