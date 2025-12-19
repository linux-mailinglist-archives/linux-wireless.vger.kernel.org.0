Return-Path: <linux-wireless+bounces-29918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE54BCCEC59
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 08:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACE57300B983
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 07:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CD91BC4E;
	Fri, 19 Dec 2025 07:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dErF45BK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3463921B9C1
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 07:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766128691; cv=none; b=sjq0V9+a5cCdi1eoiYGNqdPAgPwWj2X59PCw0TGVxxxrtHwQ6B2/9exKJpjQXjZfFgf6jLQVuzz2IB2PKz9pKBXr1aOpRc5JkV2sSXm63rBKbyYCuusfOkfVZwf6Ij76eRk63V2IiCAg0EE0tcBd6/L1CeUklojmvo2WrXpyFFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766128691; c=relaxed/simple;
	bh=5/RImDALJ/bJnj1aFQj7+EQfhe0IUVas2d8D9eXi3Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRl/xJ5LdUy0dLqasuBRkXbZuD54uPbyDsMIi4hH21DjwoCI0D4Q9UqLC2F5aS0gyL+YQ5ij+RxO3O9vPFBEkdPmg8ujkn4YpQOLcUfeqm6f5iVE/Hst3Tt7gtJSdj/Qf2EvUvlRo+wrvdvfSE+PZ6XHYItSqQqKBuEFIlWiMMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dErF45BK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso14433715e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 23:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766128686; x=1766733486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GGi0+4XwarEQLJCKZ/PM5SfQts1Wwz+1Rb9EcnA7f2A=;
        b=dErF45BKBATpShpUwpgRwfIkPqtagKQLyJ6sK1PUfU7LFssbG9VkWA8Hm8QzA5tzT1
         g2b+9J96EN74YZToI/0sGl/yiFmQq6bRjI7AMjZkdCPlniCLfu7kG3GsWCImdrou7Ajo
         Wau/Zz/Zj+4Sclpz3xnKy9f7ctl5SFec2ysAf1t6qlHlHF2gly4nFlMNl/J2IBNGd8nu
         5LnY+EvLh8ZlSRTmj+/Whmt8gEgF7dEfcsnuWK8Shp6agCW2SIiu797Em19Te34ZSffx
         raPPBOF2AoPvU60+iwziBIpGwF0tr4OVA3QDSN9tyacxfVKM0M7sCKbrZs2PHe5gyEl3
         a/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766128686; x=1766733486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGi0+4XwarEQLJCKZ/PM5SfQts1Wwz+1Rb9EcnA7f2A=;
        b=sXR39E1ZN+oe5oACo7q7vlf2BxeRjpEXIOWAmCE/EflMvYH5aducuIi3rehcbfcKQY
         b3n95tFDNf1+dqqf2/3U/gGzN/eSpfu26fSPHSzUK5rfksD7+t9/JBWy/dZzimJG9Rm5
         vlCR564Y/ptkcCavvKvGb7SMk/pACC7YFhUOWKM7ooCuDDGMN1muzfhgVsH5NOGVBnGz
         EDxn7QplEjc3k6o/G77feN4Nw+4TFcYCW9QRk8TqPM2JOjxc4LEOnDwz/eCb3glkbxP6
         r1/6boG6/KMe+Ax0QjgsQ4UhSc+eiZYnKCJ+kntacod4cZ/Xi8Csq0RiAgdnaHnkd6ei
         CDjw==
X-Forwarded-Encrypted: i=1; AJvYcCUMo5qsLAV98gBqBqOSFPdj71nJun17o1cD8tEYkKWXOAdUG8tTT0Hhvm+LU+1RAVQKWTLW7P9i1AHviSJkgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFDQ+Uci9UtkDM4hkk/xRYftQftz4tm7u2UcvfjYEQjHYWmeQv
	Fjq6g1l4XEat075bf1Y8jY6WDtMXk1N7ofo3jf0vixeR6wxxeKz4vIs12lD/O5+e+ys=
X-Gm-Gg: AY/fxX5ilmCndZuXODniJ/jmbQEIwvMd1l0FPg3j2sidBlX4h+079jgAVJk7cixnI33
	tim6igR8lFpbjYvcjUC1MDDBsdj6Qg0s5Jybl/gqy0noEoZvgmU+10hgZ+2rvxdqTWQvt0ltBTM
	vycBmnIs81ytO6SEeq/3EO4N9LFfiF+xmujn8zNs3V1DsAGMOzkrIAx0T/E513/QuLxERPYkwTM
	kULnUgmCalurqN+BqTKvdsmlnRHoG7tNNHwvVaeGvwZL7tkk00y9Zz313X6t8rffAWB5GpHjxvY
	2xz+ml+GfbdsMiny56cQ/g3lBzSscnoPWe/Soj26onF4/jQt2rUngWFDwddmzRZtOKvqEZhiVJj
	WvES5tKmhq6cvN7ubSRz/1iQvZ0OgtlU7STWl6XjEWmLveqZK68VGspAGN7TKHGp8T+q5ARh49U
	JhTHMkRDaL5V+BSQwb
X-Google-Smtp-Source: AGHT+IEPtSP5+uO01zb0W8AboVxHyk9kN/vEkm/zI5MrHcwM8lX/OZgS/xyLBiTOscvkxfHoz2ZkNQ==
X-Received: by 2002:a5d:5847:0:b0:430:fbad:687a with SMTP id ffacd0b85a97d-4324e4c0d28mr1833506f8f.13.1766128686294;
        Thu, 18 Dec 2025 23:18:06 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aef7sm3352767f8f.7.2025.12.18.23.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 23:18:05 -0800 (PST)
Date: Fri, 19 Dec 2025 10:18:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Cc: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>,
	Jeff Johnson <jjohnson@kernel.org>,
	Ripan Deuri <quic_rdeuri@quicinc.com>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] wifi: ath12k: clean up on error in ath12k_dp_setup()
Message-ID: <aUT8KrV36wF8ITIK@stanley.mountain>
References: <aUOw1J0TU4VgeXj6@stanley.mountain>
 <1fa108fc-a06d-a9cf-a56a-c905e4982b41@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fa108fc-a06d-a9cf-a56a-c905e4982b41@oss.qualcomm.com>

On Fri, Dec 19, 2025 at 10:54:03AM +0530, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 12/18/2025 1:14 PM, Dan Carpenter wrote:
> > Destroy the rhash_tbl before returning the error code.
> > 
> > Fixes: a88cf5f71adf ("wifi: ath12k: Add hash table for ath12k_dp_link_peer")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> nit: The next branch in ath is actually ath-next.

I'm working with over 400 different branches, right?  I can't keep track
of them all so I just put "next" if it's in linux-next and leave it
blanke if it's in Linus's tree.  It's automated.

regards,
dan carpenter

