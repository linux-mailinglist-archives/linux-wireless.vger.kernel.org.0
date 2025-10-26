Return-Path: <linux-wireless+bounces-28275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81BDC0A22A
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Oct 2025 04:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D933AA941
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Oct 2025 03:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747351E1E1C;
	Sun, 26 Oct 2025 03:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="EE0teduE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7271A314F
	for <linux-wireless@vger.kernel.org>; Sun, 26 Oct 2025 03:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761449042; cv=none; b=E5NNK2P1tGI21nRUjsOaypc/Ft8PNF0qQrVaFIrnrg/LdQi/Sk9N1ctWXWUia10r8YzMvo6YGjnDlGim9DL+R/tfJlZeCcdl2MEsvgD8obukeD+xrhmcbCIk3OtSeA5S9+sGHjd1SjRIQwoxJ3M4ZWTZK4/gJkcmI56eREz6zX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761449042; c=relaxed/simple;
	bh=bueBfTECE+wyjvffCJWaKFPOaYzuvYedLe0na1Ra2j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sbgx0TZ6CTo8CMAQyi/DbBfdc/IFtVwfLBBvt5zzNlkvbKfg80IQQ1y6UEV6YOSN6KC9/3zxEnNntKnZtU/sDp6z4aiJgqkCZxmXm/j2Ynfqb5oFcYkKOMHhaXFIPwHad0uDuZ/YNr/rXtD6JrzOlHWldbzDJv2/k6PWTXgrSQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=EE0teduE; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-339e71ccf48so4466607a91.3
        for <linux-wireless@vger.kernel.org>; Sat, 25 Oct 2025 20:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1761449040; x=1762053840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d7im5kNRiOdk+Jyo+cdutLIE/HJaHEyQyI3+hJyiygc=;
        b=EE0teduEijq+jXYU3a1BA2t7s/btVQsnrLbsNlquDyE9WRAsN5WiWuyOwOvzu/66MW
         9URTv4EUh9Q1CqJDHT+uA3HSnfK3h2mppGnfudVxGpYN3okRwaQMb97NGreLVlXBB+VX
         tAj95wzztCKj2Mz9fBXRJfez3B6cEx/8VRMNm0otq6TrSy355w6p+77/Jksk36ymrnu+
         +FkxOZLXhBdkuGU3rKiUBRxbmc2ejEoUdTKp2zZwJQn5u9lK502OJOBnDtxpY4631fiO
         hFqiPGGag544pBDJkXmA8uAIWb5i0oMRh46DWqddbXZflJGljFxLy0jukhrcUvuV3A/B
         Ysgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761449040; x=1762053840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7im5kNRiOdk+Jyo+cdutLIE/HJaHEyQyI3+hJyiygc=;
        b=ZKclNjkzw/mmnGgES7VjMM8tAOIuUYv5jS9lndGMJ/3I21C9WKkr7lMHQbcTMb0veU
         ZHwMfMyo0y0j75eGX3kiyh7NlzUpuihnLiFVFXOC9O4qGx9xLRjnGPB7vbXerFf7hcY+
         Iv6wHbGaEVtplzaQInInlZHqVPvjRjDB5BBg3de4QC5hAv2WknUoFLHCrxGWg9BoaT51
         8IZhMb+oELT8Vk84E3wgprSmAG9UhOP3M3voKSTbmKp2lOI95fgTnYpOr03WxxWgTEye
         4q1HMOp1Fw1l706yqNOd9MSL+9EpRF0ppHolQwFdFiD4UgFRxVPsqMvJWVKKVMyZyVKa
         mBdg==
X-Forwarded-Encrypted: i=1; AJvYcCX67DFsnTHflK+KPmR+Gsq3b4iYgTixSK8h+lNEV4v1eX8E/Q/j2cs+A0VoC7PmW3EMU074bNE4YWQkEigbMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyARYOYrxKlcVzuN5BqDCeuNTOGdMg/jsypsMKmb4vCa0yX2Qh/
	2L96yKzVy5risBhZ53auBH0mc1W+rD6j6rXOHlvQH0qEaeMcknrq43axNX7tHmx0xV0=
X-Gm-Gg: ASbGncvnPvD+VzgyIL1RuA7QUNS95s8qZQQQVkT0UR8jDXosUMZUwjOtX7xwYWET9Dz
	4S970tNTxng5BOlVXnWiuQlpVuKfBQCl73S4RgmKqb2LzCW74S1YMNkxorGD7dLO+iY2eXWJjuu
	OIys3ki6oAHyLIKIntuDStYRzf70CNv/RiAkxKN7bzhbFOt7ImbSNvqhbTVPb4D9RsotvrSSnux
	HE9pW/5SkSpHiYg90FVRVNGa9rNdKahH5foB1TNcTML1KmDfKxTTNmyAGRGV1+owugTkymlo9Mj
	szcRE5KV/mWmqqwYia7nVvV6oGqPcQ7ZlDT6w7xKFqFTeQ7dAv036UgSyyXzm9hhCth7lMwr1SJ
	ME4ntDd/zq+kmI9z5ObMCuCxBBgDT7UkgwuNxv3mxkaIMaUROSjhkVnIpY9jqgv0Tm5d1zsD9/7
	U2JGI2JKUzmzgGKx5KkB/kapD9li3IJANOaWqfRDl/Nv5J3yVuFEBrOesBFwR/HxM=
X-Google-Smtp-Source: AGHT+IHq6wi7kD2Qrjii5aVezO6yzzAevLnvO8Q0TJGlZuunxWrS78THpTzzvJcj4iyYm6SADJp1Yg==
X-Received: by 2002:a17:90b:58b0:b0:33f:ebc2:644 with SMTP id 98e67ed59e1d1-33febc207abmr4170223a91.12.1761449040110;
        Sat, 25 Oct 2025 20:24:00 -0700 (PDT)
Received: from localhost ([60.227.210.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712d7cdf28sm3342523a12.31.2025.10.25.20.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 20:23:59 -0700 (PDT)
Date: Sun, 26 Oct 2025 14:23:56 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev, 
	stable@vger.kernel.org, Arien Judge <arien.judge@morsemicro.com>, 
	chunkeey@googlemail.com, pkshih@realtek.com, alexander.deucher@amd.com, 
	alexandre.f.demers@gmail.com, tglx@linutronix.de, namcao@linutronix.de, bhelgaas@google.com, 
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.17-6.12] wifi: mac80211: support parsing S1G
 TIM PVB
Message-ID: <ipjmlu4muicsgnm7kbkmp5pbcvjyjobne4zo4p4cjxv45la6cy@clmzwkjamyi7>
References: <20251025160905.3857885-1-sashal@kernel.org>
 <20251025160905.3857885-99-sashal@kernel.org>
 <72966d6ccecfcf51f741ca8243e446a0aaa9b5c1.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72966d6ccecfcf51f741ca8243e446a0aaa9b5c1.camel@sipsolutions.net>

On Sat, Oct 25, 2025 at 08:36:04PM +0200, Johannes Berg wrote:
> On Sat, 2025-10-25 at 11:55 -0400, Sasha Levin wrote:
> > 
> > LLM Generated explanations, may be completely bogus:
> > 
> > YES
> > 
> > - Fixes a real functional gap for S1G (802.11ah):
> 
> I guess, but ... there's no real driver for this, only hwsim, so there
> isn't really all that much point.

This also only includes the decoding side.. so mac80211 would be able to
decode the S1G TIM but not encode it ? Additionally there's _many_ functional
gaps pre 6.17 so I agree that this probably isn't a good candidate.

lachlan

