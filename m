Return-Path: <linux-wireless+bounces-31014-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 350A0D3C4E6
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 11:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 52EE3564CE8
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 10:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9E837BE86;
	Tue, 20 Jan 2026 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="ecJ8AZ0C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3E633F384
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903691; cv=none; b=A2hGDuyspSbmOXEX8YOcGyZG5yWiKH9JCVZuBBJvESq1Np9qqH25A+LUoNKl+iSgMdzinN3SuI3rGwn59O6dWhEjFDJtZZZ6O0gmMqGorPXyMI++shqnN6bqmK/koUW6hdW0J3GvIwEanHUO9RkQV1VLsM4Vh5y537I1hh2bGbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903691; c=relaxed/simple;
	bh=tpHNQfw3RId2zcyVn54cQMBjPjFMccMqF2d1zPEkt8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfoIuE6QXk3/tL4AeKobp/4Jofr5GoXlqh7NjkUAIbHL4UOvseIMI1IgJeItYJzdPHVniEAejB7B6y+C5bQ/9j0o6ZqxM60dr/0Veb9AZPSCOcnnPwTo7M+SS/1fjRbhugdxJvGgHuxZXKX5S9o8tK2iT6OHZr6uX1fVdA/TOn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=ecJ8AZ0C; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34f634dbfd6so3981120a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 02:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1768903688; x=1769508488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+o2/1LEokKRrDMV8iJu441JuTohScvr4ZNAhL0SPcv0=;
        b=ecJ8AZ0Cf6uVhZZ25ix1fCgLy/sKjYmiukIUByWMQXGfIu873XUfKLEMaS6oI0W9da
         /gAElzxWme2XAoPkDxEJDgHIctlZp1BLdP3TjVLsPYOBkSLAnX7Sgb1NFbIksRN9akvV
         lMqm2AHiZIb7vr6+DEX7yH3uNj+S1kSJ3yOqwbajErYChG56GJ65Q6DV20JWLgwUgojo
         3eQgzD7BkDSInG9z9JKAamp6pzhhX+eKH8aSl15myM3cp+pAC1kXV7eZAcy1wyHYibYD
         coYI+2Lef+kRV4BgnLjH4n2+TZfHeX2/EdFQKa9SPhLHiurco2LYkDnyCjYHPGrupbSS
         fYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768903688; x=1769508488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+o2/1LEokKRrDMV8iJu441JuTohScvr4ZNAhL0SPcv0=;
        b=H/z98OS6ayrA+lAHyLU4Oq7zA5vAqQtL/qISJUREodFp4pnEIpCeZkywVNv7N36XFj
         aoM9BZeIXRbRMYN1ZSoY+PDjXHWjgxbTeIUGJFGC9Vy1AqQ3RTxOA0WeRml6lvnbC2Ug
         4VYMxHN6SWom169rVjInH9ezVNIkkUmyn2Mit21SAC1/uZ64jIdWC/qhqeFoDn0x3BYG
         sOubxcsNuNNPErabvu7aIR8NvSQMrxU0hL4pFJcXkwtGdUkA4O2f99wY10QmvkPxMiw9
         tctNWrxG+7NjFS5rWSTcMHaUbo4nPJWTC/Z7NSxLaxtxY3mKvWybbN4oLiCqD97xjKpZ
         ErjA==
X-Gm-Message-State: AOJu0YxSqda/3ZiL1C0/YheAOvWo6yzu9qc58Ehl07vqK4gX33xnXq/i
	1BMCk11bY9KYadxETg32rJ24OsW147CIdmWTpS19dYp2aYuUGk97+ozIT22UD96tPJI=
X-Gm-Gg: AZuq6aLE7umNnTpE8XXZ7lZxPqsk3wM4XhZvkSAVgwdSZHXl754aLz9F3k99HE2JGx8
	A2HjTMzox5z7p+viKkxXnukLgQKZN/EfQKDOI7SgopAL8NyqX3t2cOcFeAnTTfEDU2WjmNoJxUS
	1Uu/yGWBVc31A/WrJ0EdhINJOa3RtWQh9yLBibuNP/89pYyJi4oX29IdEEccSgO4pmR7dzSR/Va
	z+3Ba8B/02r82/0qAFEdpRYMD/rHUYCJUmE4bjusjC1kZJq0fZVye3acsTNHxATNyYwWWyD3z1j
	2AekB08uj0P45koayuKV3YMcItuI3S8DzG6kfeHE8uv+fvy/0a/OJZOuqvLc4qZzWpFPNE5QaMi
	QoAYEwCqxWQwURREaUVwB7vu9rFp8nDUjUi7I5QG+tc5lT4Gr+9MLiAPv1tmHXlnnYJtiflaciO
	woSRmTJFQAnyrcvX0ZT0YgWRaIbHQbJeHFMKPBpOjKivOYPhXKyUoG
X-Received: by 2002:a17:90b:4b10:b0:34c:f8e6:5ec1 with SMTP id 98e67ed59e1d1-352c40de54amr1411344a91.35.1768903688367;
        Tue, 20 Jan 2026 02:08:08 -0800 (PST)
Received: from localhost ([60.227.235.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10be07fsm11685033b3a.20.2026.01.20.02.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 02:08:07 -0800 (PST)
Date: Tue, 20 Jan 2026 21:08:04 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [PATCH wireless-next] wifi: cfg80211: don't apply HT flags to
 S1G channels
Message-ID: <bgywcdzsxxgnldbijv2mu6oawojxcsuxasthjh63w5izm7w5ob@gw4bt33dlkc5>
References: <20260113030934.18726-1-lachlan.hodges@morsemicro.com>
 <csqd3cp5twlhfsrkrppe25q2xby6wb37fhtxfrzgffjzoww2hw@xcixpwzlxzmi>
 <14bc5d3362b071c7c7a6a64724d5b354c173a501.camel@sipsolutions.net>
 <tyreg7kb5ownpgrbcwo72rk5tevk6jpzbthtlqr5z5zykvhaji@wpybm6oversy>
 <4dd2558fc13dd974bf551653b3db9c70feed73fe.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dd2558fc13dd974bf551653b3db9c70feed73fe.camel@sipsolutions.net>

> > channel=165
> > 
> > vht_oper_centr_freq_seg0_idx=171
> 
> > This is the result of selecting mode AX, channel 165 with a width of 80MHz.
> 
> Well, I guess that could be done in some countries, U-NII-4 goes up to
> channel 177 inclusive? But not for Australia which only has up to 173
> (according to Wikipedia, maybe it's changing, I didn't check better
> sources now.)

Yea should've clarified that earlier.. kind of an important detail ^.^

> I don't think hwsim will get too many wifi8 changes, but yeah there are
> a lot of things brewing now. Seems you (mostly?) got just ahead of it
> though, so it shouldn't be much of an issue, I'd think.

Yea I think we picked a good time to get the major stuff in, now I suppose
it's just a driver .. and the fun challenge of getting S1G into hostapd ._.

lachlan

