Return-Path: <linux-wireless+bounces-29333-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10009C8485E
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 11:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365253A33C8
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 10:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9392DAFBB;
	Tue, 25 Nov 2025 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="NaB7mdo8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56663D271
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764067179; cv=none; b=bhLV3EkeChhiEqwJQUzKWHeJX22HxHnojAISxGBOJdE83aBSeDHF0iKEd15LdyWeKe3mHcLI7IfExdwCCi8XiAgKzlkj4zUar5bmqfQj1+Ca9VaKAh0qSwdewRPLX4ib8DIOTTEDFkIgGTmNgjfF5ynJ7VvL7XrJ3nD4Mj7clOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764067179; c=relaxed/simple;
	bh=NEEMoglKRsfz0oJWDkL23FNBBYrCY1DMRD4PltKm0os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odPgo6nU4ti9zto+/8IqogKImQX8EqwdAjRUnyFDwexm0c+IEaWMwd6zHC2ga2wOckC2fQYz7jKZZQ90yPpxPG9Lj+Wons7mSeLpC334BpMrJKkZJEQpvp1EIMftOGdDkh8/UK0bLTbRsNm/hb1eqlCX0+Ao/5HNOX5K4LD7LDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=NaB7mdo8; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7bb3092e4d7so5747673b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 02:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1764067176; x=1764671976; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q8lYRm1swH2UOGfUFq9vSemOOFQnKojhJpDz42z64P8=;
        b=NaB7mdo8r4djR54i0JitRY6WzfPU+yU/5atoJEpY2DcWKrTfdHW7AsREBADfSaiJw2
         5Vox3JjDK48SX+D+Pvr5Zo/mGYxtreqzoyzam6OJoK56+LHI4xDEziE45o1ryH98K91K
         icNlltOihISnmbRklqJJnVA0r6J/b9KFL0S4qVyLsLzg9XjfZby0PUGsMZO5GW4Vcq1K
         VpZ17Zr4g2VOCf7ybOgz94/qRG2/A5etzPuGLxylLIweiLdMPm+E1zDLra8o7UGcdxm3
         e1bTPdYYJ708uAOEaK5yB6G0uUcsKaURmGF6IDjPJE2iW9uodd6R/KDH+e1taB88gtsO
         Ti/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764067177; x=1764671977;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8lYRm1swH2UOGfUFq9vSemOOFQnKojhJpDz42z64P8=;
        b=txedu12H9TE65SPy7AEM0KOk5Ze7m6LTT39HN6fVAdkzyJAu6fpmRZWh/LQi/TzsLi
         NRSI+MYU4zdXyYrC7aKhVkgc+Z7Zew+jVg15dJF29w82FyraNqqrcrcNkplAPtcw7qXb
         vqrGnq7jlaSc4IandOQedcQzfx0nUIoYwtGH8t5DcLUShjKD51U9Llg3Pdx1zzR5OuST
         nvIq+dD4mpoXMXJpGcQSncEfT+bIjr2f4MnUHplwDbAK7sKGNY5mLzNa9jreI5B8RALb
         dAYipMFLp3RhdLCFrtBanFgr5MRsy5jR04aD0Mkh+baERhMhyOY8xuEU/xF6/+TLNc4p
         eXJw==
X-Forwarded-Encrypted: i=1; AJvYcCWzHAlNOnThXircMmQiRAjSyXmAF9gBFsqdYz14qJNWEfpwpw1VqK/iA1W0dhZU4IdlBl2/ufXSsCzmhU5Y1g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+un08cSY3qovl44xwttCFgKL97UA8AY+nYe2AKTOn4uK6D30Q
	hRV3vcJEfBwscILAnHxCKzforuA+P8syVLyDDZnZ1TMkWiwEkdj/c7tSmU1KpPyz2g==
X-Gm-Gg: ASbGnctk+EkNMfuLf0YyEBKRg0QWR5X0/+jzTZEZWf9Zp9PleVrLmALsuUI4VIpSWmP
	8mOdJUNaEq0Z2nAFJe3w/vugZY/DT8A+j4v9uM4CC4KuLfU7ODXEN1QbK9exmsHhhylponUFloX
	AU2w80BjyYZ+I4wcYwnIvAgytK1YU86n7Fleokya0rzUGmy8kfFJbtuPQG9d/06tEsPdulJcCV9
	tQkERIYUYx8HxvEUq377tePrLmFgYvivTmGFXpTWmrS9Y3hrweZwybtBPUNZzpueBbPe4QWSLlI
	d4UPL3ABXrZGFXRkufYSMNZ02ZVekHHe/2g4e52xxOBRYN7yMZxd/zhYO9liDzfyG/hBJ18lYdM
	XpHzAeabhQQPgWN3ZiWHD3j3DnD5BF6MeEg89uDB5lcYDkEryXZxGB9z5W+pYo6QBGEg687t4Kx
	TR4hc43JiI1yn5
X-Google-Smtp-Source: AGHT+IGBE99MfdXHzqqI6QAVY9S7soFAkyTPqs0MZ/TCF10KwX+iJglJo2rt//y08rCM+EuzwduBrg==
X-Received: by 2002:a05:6a20:7f86:b0:351:d6ff:dcf5 with SMTP id adf61e73a8af0-3614ed94b7dmr14982718637.34.1764067176644;
        Tue, 25 Nov 2025 02:39:36 -0800 (PST)
Received: from localhost ([14.143.244.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75dfed8f6sm15926891a12.2.2025.11.25.02.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 02:39:36 -0800 (PST)
Date: Tue, 25 Nov 2025 16:09:29 +0530
From: Ria Thomas <ria.thomas@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org, lachlan.hodges@morsemicro.com,
	pradeep.reddy@morsemicro.com, simon@morsemicro.com
Subject: Re: [PATCH v2] wifi: mac80211: correct FILS status codes
Message-ID: <20251125103929.g7biphcys3d52dhi@1207>
References: <20251124061111.3627341-1-ria.thomas@morsemicro.com>
 <20251124125637.3936154-1-ria.thomas@morsemicro.com>
 <29ebeb55-1528-42b0-a692-11f20097fca8@oss.qualcomm.com>
 <20251125033915.3m2uczkde2nqcoya@1207>
 <41f2d55eb0921a95db6a3445800df67dfe99e7ee.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41f2d55eb0921a95db6a3445800df67dfe99e7ee.camel@sipsolutions.net>

On Tue, Nov 25, 2025 at 10:30:37AM +0100, Johannes Berg wrote:
> 
> I did apply this now, but I do wonder if we're better off just removing
> unused values? We don't (even pretend to) maintain a full definition of
> everything 802.11 in the kernel, and don't need to either?
> 
> johannes

Thanks for applying.
For context, I’m not using these status codes directly today. The change was
mainly to unblock the enum space for upcoming NDP work. This adjustment was necessary
to remove a dependency blocker in my series.

I’m fine with removing unused values altogether. If you prefer, I can follow up with a
cleanup patch that drops unused codes and adds a brief comment noting the list isn’t
exhaustive and new codes should be added on demand.

Ria

