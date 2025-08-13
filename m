Return-Path: <linux-wireless+bounces-26366-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA415B24BBB
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 16:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B581AA67B8
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 14:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FD22EA74B;
	Wed, 13 Aug 2025 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHlZ6nh3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963582ED14F
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755094644; cv=none; b=q48clO+ozAiD/LZc2M7PzjAUwwPfNXUIYcVArX4vovcgwFMQD2tWcq6NHcp6Y6oKXxXdZHb4408PdUM5A24m/dObjHxz08Ki0n7sGlHOF7zEeGYp88m5QRl4uqxu3SObA0vsSc2ewh7Dv0xHmwRFycbUDAO3U15eoDWeL8wF95c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755094644; c=relaxed/simple;
	bh=gDv6k/cnVGC+5pFIfduOvzEvsIzZnvrVOea6R+TSr5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sA71ioi0CqyiqKlUhLuvlbMrayLyeVFklAJW+X+XtcoSpaYJsjlS2v+PC9UJ3u6oEuaNkb1fhndsk4UqT1b63f+DGWEKC86AgGBxpAi7482CHi7GZc+w0aOZiPzjjwFtq9OxkJ81QGNCNQx1rYl4PhBejM+p+7gKzwNfuIjWPrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EHlZ6nh3; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b790dbb112so4082349f8f.3
        for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755094641; x=1755699441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1gxZeZj9Dcst0lTsMevYg/T988h0HVKmw8rmMSy1LdM=;
        b=EHlZ6nh3CsWx+3VQQeijLdRwIIK6Dguvs/Vsvpslqo2bWFQnr1gc/dbKBrgYIw7PPK
         1Te+kNcVBDt8MbRlP4hyxTQNX5KJD8iwI63WXp5+xNvpJ2sOiyclQnyUAJnwe2KQ4vRe
         h8dfR6nKbnkbTY2WF6L0zORdPb5syjdCUb9RPJhgQrLsMACDAbhHQuwOWidtER3nB0oA
         YAzALgTWLDIn4N0o5Ud6EESfn9gQ86/1AateuipbLTlJkbIHykbQb4okwR4UEawmgdCk
         F2Zk0asAPhTmzEWUa4bb6232SJ4+pxFTd178QDArnf3LrxUl9Dk8/1xOdb/5lCgL0G7J
         Qgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755094641; x=1755699441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gxZeZj9Dcst0lTsMevYg/T988h0HVKmw8rmMSy1LdM=;
        b=opYu6cnNNvFMRl7GH6iQhZ7XK2gM5hEzNNwv9+71a5uqFImDmQsHQBo5QEJtaU2Pk+
         8nmHqNM8t/iprnDuXFJAYTMTcyTGrMkCfDyu93b9RT1Qn6IweN5dI9ceD51ykhfi1aMv
         /6Lij3f+eKd8xhupKPsuLTqQ7J613d45bixWRdwCUGiOX33gLN3okuDcc2MldNv8ofIB
         fgSiyu3xYrI4/zqPdWs4O7/xfPl5BseoQxvxTibY0Wvv5TQNq7BX0Oxyx4uqB8eN7zTa
         fqJMn8Qd0GdQI2Yys1DIibbdqHvYETwpUd7VzKnEoLmOHHIc29+ZRLOcnFBnja2kp7LS
         ZaUg==
X-Forwarded-Encrypted: i=1; AJvYcCWsK6O7ftIQUkBCsvMMcU3CBYVKujnH6NQ8ptIdXRuWncGgMy53N9hRSvW2fMJuXLia4Ir5KpThGtDOaxEI8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbtEEiUn+lx0ZAlsz8Q+rAz4bwnlRxtBQv0P+ynX7hjzn0CK0I
	ny/OxTBKq1ocFR6vID5NDVT8AcJbXTc5kex5V/W2axAhjHYD7U4YScTbsMmiNptvMCs=
X-Gm-Gg: ASbGncuXqkeBd9iVE5RdomZ1BazfmBVIokUXP++JsMx/+mhvvR4g3bzbcdP5JsvqYPW
	ZTmjGzIDFsUnOBBMyVX7902b1fQPpUn0jXlu4vA7bodLBspJj1K+6+cYDjPtCpQmpGIV99UjIxz
	QfmtJ85P1UIJNHFc8EOKHoYw89CDyjf9gctijLWH+pzDQ55bBENltMqjxA5Rhm1HPjF5Up5Tw5b
	5NoP9ExGIBcn5S1tHGPjdgYCXfxH3JpPzSXwSs+CqN1WfP832xUQHnNK3WyaBYCltfMjb6niYs/
	3e2GAc2WnALLAiLMOPSTN3jXyegQX9SX8M3adDZjj0/H96eC5BUbSIQaYciyw3mlCYIp3C1KFkG
	Z1JS9PvRuGgctUoDmSLGhWtS7p8ejeciPd6NVrgwceQkqxBTZ+YuCUg==
X-Google-Smtp-Source: AGHT+IFFIHDxH0gsvcBbrdg0jzQCZ8KJ5WFgRavMcUV7EUAlo72yyL5x+kSMwqYLcMH3lxjUWM8oPA==
X-Received: by 2002:a05:6000:4305:b0:3b7:7cb3:1124 with SMTP id ffacd0b85a97d-3b917d2af6dmr3043536f8f.11.1755094640701;
        Wed, 13 Aug 2025 07:17:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3ac158sm48762592f8f.4.2025.08.13.07.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 07:17:20 -0700 (PDT)
Date: Wed, 13 Aug 2025 12:25:27 +0300
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
	"open list:MARVELL MWIFIEX WIRELESS DRIVER" <linux-wireless@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] wifi: mwifiex: use vmalloc_array() to simplify code
Message-ID: <aJxaBzZYr4d5-XUv@stanley.mountain>
References: <20250812133226.258318-1-rongqianfeng@vivo.com>
 <20250812133226.258318-6-rongqianfeng@vivo.com>
 <aJtGSxkRztAsy92h@stanley.mountain>
 <e66eb22f-5565-4f33-b523-f93dc81a1210@vivo.com>
 <aJtQS-Tpzw90Hqtl@stanley.mountain>
 <c330d0f3-d3cd-4981-8bb5-3ff5761647dc@vivo.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c330d0f3-d3cd-4981-8bb5-3ff5761647dc@vivo.com>

On Wed, Aug 13, 2025 at 02:52:51PM +0800, Qianfeng Rong wrote:
> > 
> > I really think we should zero this memory, so lets allocate it
> > with kcalloc().
> I agree with you, I will try to do this in the next version.

Thanks.  When you resend it make sure to add a Fixes tag and CC stable.
Forgetting to zero the memory is a sort of security issue.

regards,
dan carpenter


