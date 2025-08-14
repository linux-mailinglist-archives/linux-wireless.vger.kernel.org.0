Return-Path: <linux-wireless+bounces-26388-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D605B26A3B
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Aug 2025 16:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86C656287D
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Aug 2025 14:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34744216605;
	Thu, 14 Aug 2025 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WPbVbgvx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543B81F9F7A
	for <linux-wireless@vger.kernel.org>; Thu, 14 Aug 2025 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183044; cv=none; b=BZ04HOkrrKLPd7vASuj0hk2iWDJUyypw1Ku/cJOcyELQkWpxQ6TqgwBBFGWJeJANoEQzcas5WwSxwiHlG4ln1f9R3vdTKY7xbKYB1VBBgzZVQ2rIZJPLY8WdQRN/IlQvSvgl7dNeW8b44VjrVbZAIu6wzUdoesk/IrlB6FSfoSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183044; c=relaxed/simple;
	bh=zMKLfvYxyHlXKU2+2xgv7Jd1haLqSPUF1RejGOjP6zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3OZ8jxihZfaY9ElShxoeWwanV/JSBghhJnbvWDxZ3fsRmADUvogZ7o9klmHApilZEkS6NnlS91PApuEPs+YkSnkjm6vEKzFfuU7CuiIrxpa4nCVZ9SwKlysLRa3g/HKibaHGk9X/gzScohQ1aKJyI0pqGFXwCSOmLM94TrWsFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WPbVbgvx; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9df0bffc3so601059f8f.1
        for <linux-wireless@vger.kernel.org>; Thu, 14 Aug 2025 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755183041; x=1755787841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0vGIESpwE6sjQpjPwI0fN8WHW6LSr9CktyCHEaHrsyg=;
        b=WPbVbgvx1xhELTZHmnwkJCRlOuRV6h8r96yaxiBpdmDM4UZjwVovjsWGEK692DkXsw
         F/xyIs10St9AOB21NhiV9zAupBkslF5htHIpavw3KyDb8JhEp6t7cjORWay4as/1JSAP
         aX9lNLgB7UDK7gWLQgyze2CSpxBZtN/sCIF9zU2cvYFfodqJXiygAX81UfQ/MVuXmsWm
         VBzDHuqejkJOF2shbxXmfV3s8CgBZO3e/LhnQh5sx28Ke/m0cjzMv+m5I/mHUgqx2Tru
         GNveNx2ei1LQfmuBbU/Hpb7wzMMyl8z3c5Nv2B0ByXb+lK11utsBWUFUF41xEF7tX4T1
         Azqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755183041; x=1755787841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vGIESpwE6sjQpjPwI0fN8WHW6LSr9CktyCHEaHrsyg=;
        b=NPh+mLMsl3EGHoO972sz9t1oNI4lToIDBRiSh+mtR9Ovazmcp+j28UyiY5us2qZP03
         I44IJdnVtmHuP06mDEX3ZhO21geVz75i18jVoXIDem/9sHu0KsqxUnOnLAWwwq6OSvDw
         VFnkhj5ZMpuLo9oaZ0TwpN+8NqslXrIkyajL9112BiJZOnbx7z9GSVAtriugr0UVEqm9
         Y2zbgb5ULBToyA2dd4XFAtuHgw4p1b2JWQtbpkE861zusQTAQQtFr+sF70dQTpP+rSmK
         l1jvBRLHNXGKAm9v+vfSV5Oy6vmbyA3OT24GxwnFikYV6AbY2iLjFUk63XqIL1oEakyr
         KoPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG8kbJxCu6TssrEAUvuljdcWEmmXUPgWPwYZfX4lkWimuAav3CaRVWIMcxnmfzqOP+nrU9H56ew1O46i+b+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf2GrwY/A2w+tMxmxKsMSCf2YdaupF24uKa2J4QIHzX00DhB3y
	XBftBzyTlbmfyDWHU3l/KUgJeAdERC4VmHYcflLQItJOGxV9kWUxQh/XhlKtT5AW3NA=
X-Gm-Gg: ASbGncsRFpzRWarpQsFmldBC3sPlML6WSCGyv027BbQ6n9LCKNZs/K7tRAiS0gAEQkQ
	IcjTl4EBWfsyyKyFJFR3hhI5ROXOQMoZoFM3vo8G7ngV4gXuM/yVdtLkOdVBB8OJIYmZoTswhjR
	EzQkSOYZVqKyudtvlmZDP0e/czucQYQt6KpP5zB/ZsTDu2WN2ATRkgocaKuYSH1ReusFNXFz8uQ
	WrT6mY1krkrffpIJGi8fJu6fcAApVJ+qYAsChfVe5oqsLTAYeE0WkTI1Xf9SbyQxkbjSjJPCdyf
	iGhESOsEQ/nDHB22uFP/rqusJS9RAbtN55Gbh+smHWTrcnqi3oidvcMj5t8ZrhB947TPL57HD0Y
	7LeN+IR51a9rKYu8f/w4eH8T63VA=
X-Google-Smtp-Source: AGHT+IHh3EzdCyG/NhBNbMq/qJ6rj0vlsxozGvF3nkk+UdR4z/kGz0s6cc9K0QXKutX0yGrJTiEEog==
X-Received: by 2002:a05:6000:230a:b0:3b9:10af:59f2 with SMTP id ffacd0b85a97d-3b9edf34a5bmr2739927f8f.28.1755183040605;
        Thu, 14 Aug 2025 07:50:40 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b9132f00ecsm8850096f8f.24.2025.08.14.07.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:50:40 -0700 (PDT)
Date: Thu, 14 Aug 2025 17:50:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Rameshkumar Sundaram <quic_ramess@quicinc.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jeff Chen <jeff.chen_1@nxp.con>, Bert Karwatzki <spasswolf@web.de>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Cathy Luo <cluo@marvell.com>, Xinmin Hu <huxm@marvell.com>,
	Avinash Patil <patila@marvell.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: mwifiex: use kcalloc to apply for chan_stats
Message-ID: <aJ33vFdOfMRDbpls@stanley.mountain>
References: <20250814131536.231945-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814131536.231945-1-rongqianfeng@vivo.com>

On Thu, Aug 14, 2025 at 09:15:31PM +0800, Qianfeng Rong wrote:
> Use kcalloc to allocate 'adapter->chan_stats' memory (max 900 bytes)
> instead of vmalloc for efficiency and zero-initialize it for security
> per Dan Carpenter's suggestion.
> 

This patch is okay, but lets re-write the commit message:

Subject: wifi: mwifiex: Initialize the chan_stats array to zero

The adapter->chan_stats[] array is initialized in
mwifiex_init_channel_scan_gap() with vmalloc(), which doesn't zero out
memory.  The array is filled in mwifiex_update_chan_statistics()
and then the user can query the data in mwifiex_cfg80211_dump_survey().

There are two potential issues here.  What if the user calls
mwifiex_cfg80211_dump_survey() before the data has been filled in.
Also the mwifiex_update_chan_statistics() function doesn't necessarily
initialize the whole array.  Since the array was not initialized at
the start that could result in an information leak.

Also this array is pretty small.  It's a maximum of 900 bytes so it's
more appropriate to use kcalloc() instead vmalloc().

regards,
dan carpenter


