Return-Path: <linux-wireless+bounces-29306-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E09BC83384
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 04:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ACF7534C2BB
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 03:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3328A21FF5F;
	Tue, 25 Nov 2025 03:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="WKsemyVk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5582D33EC
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 03:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764041160; cv=none; b=csQ3igbknEIQsHwniMA3Wneirhx6QC4SXGDPtUnKdk5KP/kxa9tPCHGqC4ZX5QmO7dYtICT+Ky0CcFOvCPdsjYf3eu6VoQZuLklMXqEcrP5ZpyCz2AMJv+i+SIZBO188XmfbJqt/R1ubyS1dMNxApCyscobJF3WIe7xrnjF19Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764041160; c=relaxed/simple;
	bh=htvkxIKmteGd4Xbmm8GZui4VGPi1HD9Miu98KmHDgi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RW+4FzImKBTa6uiryhDVvWRlg1Q1V7sJ5OgO99T9XiY9KF9W7bf7wwLvfLLfAM6L5KmUGYJvzz/4QVFY0ETc3D8MpuOwhQ7q174ovxDB6eBLnUzpDPI2pe8dh7ybVWKxfzSxbE+0WLY8WDcU8LdZKcz/3KtokLZlGOSWYkWizB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=WKsemyVk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-297dd95ffe4so44211715ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 19:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1764041157; x=1764645957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SwF2OFU4/fylW/lLGaC68s05t33YPr8QJCw7Mhtdk4o=;
        b=WKsemyVk0YuYakW3znEmtOS2pHP5VGdVif2dY/CVzghLJaneKPfR7KccHrrLv29BFm
         Oqs9FlwmmOoaKgieKKWeEhnwcpaUw8YAgyqMO9EMpZzMmz8KjjNIqWd0XmxshMO2onIm
         AeqFPyTPByfa089h5/8yukNtqsbsybyxXE+L8fvl0hTi8toZORBQiIfVrVw6AC7O7eZd
         lT6uKbPT/EYdiCKbU8DK9rWJZUV/UT6D/tw14eMIBJxwwf4slvhyOjlOfyvZCnSbmt+t
         Vpce3hR1eOJ7uYh6eWoixirhxrvmxCOEVuK8/PayIY8HXhO9nXKOxq506TkYwflOWDaq
         u/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764041157; x=1764645957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwF2OFU4/fylW/lLGaC68s05t33YPr8QJCw7Mhtdk4o=;
        b=Rnra81SuOdgkqDoyhr+OP5h/Y9lSpVL9Uh978RGmd7iFnP/Jpwnn8N0nTaIZoyP1gQ
         6euuFbZ4ChPF1Ws69UAoL8x1530+1TOIYl/BpYZpdmA78Z2NDb1Mis9Ql6iv8WnNBPCw
         zEcVl7fnOfM1/LwIi0Vq+Dq5FtNgKBgkBLIJ5UzfBLiavgHmfPtPIvXKeMGquX9qL/i8
         q+O2Kk3XmjlSUFqnzR3cxecEaYYO9okgvl8suVm0gaSt64EBlv4WHZvx0OGMwPjA41Kt
         GidHKqGdEVbYvxDrgsbP0pjd+YqTAYE1hHjSlyMyKisRXqcLQyKJl3Vg95qfkMTVs3CO
         CqcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX03NGFjPhEgROg1C27T6w+GULhwazJl/jH6PtjiOsPQnFFkcUSX5uMG94INDnNypd5vFI9rCpoAZZkTFUvXw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx337IM2I2ieZZ97jgzJv6YAdPlHx1e/4eiVcgbR+KuaogtUtxt
	oZy9g86RZWxnpV5oph1xXvwAWqUPRf8T7BM3Ua/s9ZzDTPyQcFpHsowgEhTKfP3XcA==
X-Gm-Gg: ASbGncvWsU7K50vjhAxaZhw8oDQNHrtHTfledJ19ouh9Nmex792QOQUr1tWj8VjeICf
	r5LFadQnnL+iuy/Te3nYL5NDRrA0RYXLXp1R1SLU3xk3ESF0aDfrP3cAvc+KS+uqCKcSpEA8obB
	oimL6AiRmV0Karld79k0crLPzqRxejGehpN0dHZdTEFjSxvMazot7AoIl5UD7wnNklrg41hmNO4
	7sJoEYxluRR5Co1jsazre6pJBd4HXbOs8RIU3zR3vCSjOZ2sBOsNl0Fs+r2KKFilSgWa318FxzX
	ohvxPopqpQPGHNnsvzi5uaS11AQOdkauvz6XKRBxnbW91vWamEHc9Yvo5LWFGcXbPsiaIhsiNbf
	3Q/ol1Hq5xHwQfOTsyCel5WRlAXcP7BgjElgZNdZj29OHiEkASxpnz10Zg6HByPsW7bhMH8CU0o
	PtBgVMxXFBRpenLofUiKelkZg=
X-Google-Smtp-Source: AGHT+IE9S5LWpBeMXGWWrfhpGLlBUyLKp1qvmlBKRJ393bfVJoUlf3l0yBUV/9aAeS3TPdQ/y0TAgw==
X-Received: by 2002:a17:903:2a90:b0:295:2d76:72fe with SMTP id d9443c01a7336-29bab1949f0mr15038605ad.45.1764041157549;
        Mon, 24 Nov 2025 19:25:57 -0800 (PST)
Received: from localhost ([14.143.244.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b13e279sm148369135ad.41.2025.11.24.19.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 19:25:56 -0800 (PST)
Date: Tue, 25 Nov 2025 08:55:49 +0530
From: Ria Thomas <ria.thomas@morsemicro.com>
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, lachlan.hodges@morsemicro.com,
	pradeep.reddy@morsemicro.com, simon@morsemicro.com
Subject: Re: [PATCH wireless] wifi: mac80211: correct FILS status codes
Message-ID: <20251125032549.vqa75pgvbee25ycv@1207>
References: <20251124061111.3627341-1-ria.thomas@morsemicro.com>
 <8600724587814a992d649ce8feb72c4a3d20c8c0.camel@sipsolutions.net>
 <bc5a35f8-171c-4558-95f9-142e2344b02e@freebox.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc5a35f8-171c-4558-95f9-142e2344b02e@freebox.fr>

On Mon, Nov 24, 2025 at 01:44:00PM +0100, Pablo MARTIN-GOMEZ wrote:
> On 24/11/2025 12:58, Johannes Berg wrote:
> > On Mon, 2025-11-24 at 11:41 +0530, Ria Thomas wrote:
> > > The FILS status codes are set to 108/109, but the IEEE 802.11-2020
> > > spec defines them as 112/113. Update the enum so it matches the
> > > specification and keeps mac80211 consistent with standard values.
> > > 
> > > Fixes: a3caf7440ded ("wifi: mac80211: add corrected FILS status codes")
> > What?
> > 
> > johannes
> > 
> The SHA is correct, but the commit message should be "cfg80211: Add support
> for FILS shared key authentication offload"
> 
> Pablo MG
>
Thanks for the review johanned and Pablo. Corrected and resubmitted

Ria

