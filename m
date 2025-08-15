Return-Path: <linux-wireless+bounces-26397-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 217D9B27860
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 07:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B71A7BF13B
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 05:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9022D23BF9B;
	Fri, 15 Aug 2025 05:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xtuuhoFu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70EB23ABAF
	for <linux-wireless@vger.kernel.org>; Fri, 15 Aug 2025 05:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235401; cv=none; b=TtAoH+875rHTwNEFQ4CLKCtKNmVb33ntmnaK2nBndYe8TSk8fmB51aN71UZsYfk5dneRE33ic0S5/ts05GeA4WffU20U9Tu32gCaIyfI6czS1qAB1u3jJ7FdDxCoie9sWK/kzd0JI1ndeIQlukolrGazUZKdcIewF/d8AlJ3efI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235401; c=relaxed/simple;
	bh=V8Ueiz1xSXHXEvy644YzyjPt8VCpS+xcVARVvP0U8mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huXILgwiuwQHqszHZNQ+5ZAAKQXv9lyDw3ZK51l+H8V6uKVVxlqDDmB38VFACwMnxa6PkuXkz6408Vuy/EqecbrhJaGAzcV/JuLSYTfiDGOJnWuxgbD+ZHNMC83wLGn0MZDTTRPOgR4L0jylZFkGroUKFfqKzrht1X3eEn2j2W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xtuuhoFu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1ac7c066so9446935e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 14 Aug 2025 22:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755235398; x=1755840198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLn6FEN7TpsXc1h2u3bLPPOQktvvlCLchBVsgnE1xvM=;
        b=xtuuhoFuSK0LVpxWBSNYcavSVu3GYNnd74SrfkD2wQjKhlAsrHl+pVUSbaCdBgtNDr
         YKfdKFrzGBw2wmODl/ibp+ilud4hPWrTdrB49mpoQVxwo8mbgyMVFzIf46PvM19KvUsk
         hhDWVFIv6HhHc+6V3F9S/XdGoz2dhOl9hzbuMLPQZhzbvUKeqRoADnAgDWzLImTGvex+
         7zkoMfeCu5gbb2XUaylN3HAHGv3dRkHEguRf3ChLw0HsHKh10eS81OSD8MyX6yjl/Qpz
         1m5OJ6Bp0idmKRfQtzV6rwlHJ+KjR3xltHghPt4Wdu1YgHAj57jkCqzoK/0YVHLl8y7n
         9Liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755235398; x=1755840198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLn6FEN7TpsXc1h2u3bLPPOQktvvlCLchBVsgnE1xvM=;
        b=o5lnKhbUty0Oi1kWrr8/FsC9fwiATG3O5ruJOkWUZJfwJ4YmHXOK4zmUxTUDx5X6kB
         sS9Dlev8xhjFBrW/5eDE7Ndy/j2qOTwdzromsZgmIn653Z2iRcoXWn2pytZTOwMMaO44
         ikiM/jcGh1cFO+uSUqx6gAaTgPNa/hZ3QhIurLvQBLoP1tj3ykeJXUd3HQylhInMXN5q
         Rmn3nJbE9cnMp+ewQbZlB5uEKX/cwQ/CqleSPf+Ggkoj/osuGia8DydEk4IE95Zd28jQ
         FgxnJcKV49Y7pXrrc0flODb4mBgI1iZwutFbfXkDzkWhAIV8mStYt4ZPmszU8RV6aoMZ
         xp0w==
X-Forwarded-Encrypted: i=1; AJvYcCVxdgGnNtkLpSmpd7BRtIfZQLMatgZHw4s74gWCbmAxUpi7YzVpbrvQc4Esrt1js+JIgWgAYgzraq7QAa6OKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIKxiGjBTLfw6hJPQMj2HipxjfLvnqGBROfoxACnNAFS3cwgFi
	yFwD9w3WjwlttpUhxir+7M4r64W57aXGtjAFucRIO01Tr5uUbB8pk5QcerKrigNAgDQ=
X-Gm-Gg: ASbGnculY8vLmtmGzO9Ei+ggsdo2EJtAEuV+lqBoyGEd/U/XLI8jRtmyrc5jhCBJli3
	i7Yikgz+ni/W+2aFvlLTysLQx61lnoI3NmrqFYU62r68u+6tmtRQ8RHcy9CMEcYjGPytCuBrSI9
	Yx59klMsC6eYB3KqKdx/VnihEw0erfym19KGAAqjy2BNQZr9idYYac0QET71OUV4dECjiYiF91v
	O2lDyu+fOXDuXCofD8KNlqgavjrK3bHwrftd6XA8kTeBf/hKp1ahprT3tEt/o6qoVuZXSbH99LU
	IQSfTu8WmqG+8fXDfHs88bJEsD0zjt7TXiSZ4RIxJJetuqq43xe1ccm+P21R4/TsYRtSQs9nce5
	jn5cA2qvPSjxMBzSj5GH+ANXsDrv864hemY+z+UdIN0u6WJYc/SfCEw==
X-Google-Smtp-Source: AGHT+IGFNhJOx/G+JoNt5kMjzVx46v4txqtKecbS9qJlHx4GlX6Evp2HRHELTQibK/pD8aO0fgDabg==
X-Received: by 2002:a05:600c:6095:b0:458:6f13:aa4a with SMTP id 5b1f17b1804b1-45a1b66e4b5mr46968775e9.6.1755235398079;
        Thu, 14 Aug 2025 22:23:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3bb5d089e07sm678141f8f.0.2025.08.14.22.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:23:17 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:23:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Rameshkumar Sundaram <quic_ramess@quicinc.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Bert Karwatzki <spasswolf@web.de>, Jeff Chen <jeff.chen_1@nxp.con>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"John W. Linville" <linville@tuxdriver.com>,
	Cathy Luo <cluo@marvell.com>, Xinmin Hu <huxm@marvell.com>,
	Avinash Patil <patila@marvell.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] wifi: mwifiex: Initialize the chan_stats array to zero
Message-ID: <aJ7EQZFT4rx2Tnj_@stanley.mountain>
References: <20250815023055.477719-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815023055.477719-1-rongqianfeng@vivo.com>

On Fri, Aug 15, 2025 at 10:30:50AM +0800, Qianfeng Rong wrote:
> The adapter->chan_stats[] array is initialized in
> mwifiex_init_channel_scan_gap() with vmalloc(), which doesn't zero out
> memory.  The array is filled in mwifiex_update_chan_statistics()
> and then the user can query the data in mwifiex_cfg80211_dump_survey().
> 
> There are two potential issues here.  What if the user calls
> mwifiex_cfg80211_dump_survey() before the data has been filled in.
> Also the mwifiex_update_chan_statistics() function doesn't necessarily
> initialize the whole array.  Since the array was not initialized at
> the start that could result in an information leak.
> 
> Also this array is pretty small.  It's a maximum of 900 bytes so it's
> more appropriate to use kcalloc() instead vmalloc().
> 
> Cc: stable@vger.kernel.org
> Fixes: bf35443314ac ("mwifiex: channel statistics support for mwifiex")
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---

Thanks so much!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


