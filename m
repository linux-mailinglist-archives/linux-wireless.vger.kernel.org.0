Return-Path: <linux-wireless+bounces-23539-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B7AACBF8C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 07:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB3F188FF5B
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 05:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF5C1519BC;
	Tue,  3 Jun 2025 05:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="FVJJIbgr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0274A2C326F
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 05:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748928415; cv=none; b=LrKODznpvPUDjXHtoQN7M+1CibA5wVzv9TVhSlD1J+pWIJ40g0+EMswYaagm5elLy1lov9bVqoDFkMB2pyLQ4Jq+pxcn+aWW+oio1b69rTodwo5BDFLOY7Rx1rVnj9z/oSvr5uwjDx5njOowvDAQadq2CPT1ST/IqlhgfUWpWTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748928415; c=relaxed/simple;
	bh=Io3VknBkl0VG5ofoSu5aNPLgmGMCy2yWbisn+kbcQuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slAKkU/IBC1XFYCjgVk+I+CHj1P1wdqxszF7VfUP1cy0xHDNB0C6+hN0uizHWaLVEeDS/yX0UpChEWqW2uem7WY8/vo+0FPWK2mMzdeh7vF9DQUMMa10c7kXunqv7W+0ssv7YEfvSuHT6yYwk8l+GdRX4ImRURNemPI2VZdYLg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=FVJJIbgr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2347012f81fso64470295ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 02 Jun 2025 22:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1748928413; x=1749533213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Io3VknBkl0VG5ofoSu5aNPLgmGMCy2yWbisn+kbcQuA=;
        b=FVJJIbgrVr9KKpvJ8S5Je8hwCaGSBWs9s5NZVNdHMu3atkcnpKpMDCTO5a0W0Mq8zX
         8uvSFL5Fnq06UQFXcSKGyOvDPKs+vkIxhK3HzCLFqUvJKGoBR0qnURFoexd5DlE7isQ3
         LSJA+Oo5Sb+vdC6oXMllz0kXHZ6/LRpjP06E0PAdDfkhTQoj0mgJgJMFZeLmkPLqoKUV
         L5I5ODC+k9x7IcW918qMdJJE7K9FfJ1pmgHAqBM/xfZZ3SIKvM9C8kvWLw2pr+srsfyo
         avgof0liy+X214Bqoy8jnug7mvQoZIqcmTTFyXrh95W5iR5uHdZoMGqKTljuHCU53J6Y
         iGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748928413; x=1749533213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Io3VknBkl0VG5ofoSu5aNPLgmGMCy2yWbisn+kbcQuA=;
        b=I8tM6sQ0SSw6Psw5EhjmoyNKmzo1nmjp4916XSQUlEuz4JdRw+xgQOc0SYvKMdCjAO
         G6TLCP0ydyEIUHDoq16v1ffBvW+hCYs8QbxriXE5Qr0vLxwQ7j/USM4MSZA3iFtbJx0B
         ll+nNNDYJ639eQblCMq5R1AtM8IfnjROIKCa4rg3nSqzjP2JLBRgjwsTngH4Z5RfdnYI
         lWrihaqDz2bFfFZx8VzWrqDq7fGDOyN66rHlFMj7dIJW3Y1qmTzNLnJIIC9sHbRIxteF
         bweLX/i3UacYFYFk+U3BZ9RHYIl4AK2Yc0Jp6SV6MZ83OEr67x+1Y+O0IK9xKBKdee9H
         54Mg==
X-Gm-Message-State: AOJu0YwcmNCjVPfj6OI1k8XrEWM9PW+REy4TClqstEEWY6bNRrPAaoCX
	sXRoAvyo24yCJIL83W7iSC4DnU5pEhac+fjaIwAIljB9iZwSRdZXxgqUq0LcUCewXYk=
X-Gm-Gg: ASbGncuE/IP4F1tJQdufYw74uNKbexPTo3PMtr3S7tCgw7al3VetHDZHf3QiEQVl+7b
	8YHcOuwfdhdqOwYuazlyPSdYeCqUuogLetsOQN9iQEVQYvLac01EDN4SoJ/9AQmBtm8hiro6Il4
	FBU2V01IrG6HKdMz0Guk8oOEh4iKHm4MZqnj4pYDMUoiaia1I/nE/bO/SgJcyLOetYTPI8GGYyx
	/oz7RKHlz7ZqixPOGfnjRraUVZADeWjf+g7E1sHIbsEpcHkpyzhZ8+38WlWGCA7zamB7L0hn3dz
	D24uWSenfp1yW2e1L85eVG08piCB2pXwqGMI2XUN3OTSN3AEWKgYPvSI/38KUu3fp0f3sO4g6gz
	n6QiSQ5N/3uP5OkjHCxVJdWbOuDU=
X-Google-Smtp-Source: AGHT+IGeRn6whNrELde2uf6yC86CvwoZF6+Qd1UiqfgZyLtuPUgE+fE1wCs6c/aoz45OK6lGo0+KzQ==
X-Received: by 2002:a17:902:e94d:b0:235:5a9:9769 with SMTP id d9443c01a7336-235395a1182mr205343105ad.25.1748928413170;
        Mon, 02 Jun 2025 22:26:53 -0700 (PDT)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb35e24sm5565234a12.35.2025.06.02.22.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 22:26:52 -0700 (PDT)
Date: Tue, 3 Jun 2025 15:26:49 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [PATCH wireless-next] wifi: mac80211: correctly parse S1G beacon
 optional elements
Message-ID: <p36ch2dri2jqarkvthxwyl27slbbedesr5caroc425an3azx72@kstyfawelp3b>
References: <20250602053521.410650-1-lachlan.hodges@morsemicro.com>
 <0ad998b5ecd0c1d6521441fd06a1bc7e1a93ddf0.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ad998b5ecd0c1d6521441fd06a1bc7e1a93ddf0.camel@sipsolutions.net>

On Mon, Jun 02, 2025 at 10:27:53AM +0200, Johannes Berg wrote:
> >
> > Fixes: 9eaffe5078ca ("cfg80211: convert S1G beacon to scan results")
>
> Should it really be wireless-next rather than wireless with this? We're
> still even in the merge window, so seems entirely appropriate to put it
> into wireless instead, even if the bug is old, rather than wait months
> for it to release?
>
> It also seems you should split this to cfg80211 and mac80211, if
> possible, and have two different Fixes: lines? The cfg80211 part this
> has might fix the above, but for the mac80211 part that doesn't seem
> plausible?
>

Thanks for the quick reply! We don't think it's possible to split the
patches without breaking the build between the two so have opted to
keep it as a single patch. In addition I've included the two Fixes:
lines that reference the original changes.

lachlan

