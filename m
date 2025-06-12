Return-Path: <linux-wireless+bounces-24074-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FADAD719C
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 15:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A64F7B0105
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 13:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A454424DCF1;
	Thu, 12 Jun 2025 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M/f+iwqn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45CB53365
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734260; cv=none; b=cCmEDyoK9JeYCVbXOZFF6Ft/LdLSwFGtwEUYnAFRzznTudcxnFkq0+jbj+sGp4bijH2rbgEhdBHHhToVKxW5cO+OXv6u+f/KdwvKhW6QQJG610JCvhg0G2NP1VT4CbGiZfJHctlFxoeFxbW3dqc8xAFglrC/so5vfImdoD7qp9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734260; c=relaxed/simple;
	bh=I2l+YRHKLjqKbe16A3AeFOK21pur651z3E7JS1zKf0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQpCcTXJDZJi/lAt9nfb5SBnlg7PX190fyoFiIFtpT7OgJ0XEG/h4cIOoE9BHmY+zwcv8Pse0un2ZpYRi/SRCNrRt/hJAICWZ9faJP+58jXZbG460CVwIU4S3WUJJwJr2q3mGlvVxgZPWuwiBLI1FEfkry0mmTgC0hHqd+xLsb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M/f+iwqn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so8390755e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 06:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749734256; x=1750339056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cM18rYl4OkBhTprKN8RdLn8jnxpvdseiRESNUfJz/xQ=;
        b=M/f+iwqnzic29XSZvPzUl7Kb69pl/EXqCIhzuMZ6gHVoX8kHxs/OsWHs71doMpnu+T
         Knt8yLBV8ELAE1P1CMFHUwg3+fat8zyvwJxP3HtYXYZ7d9dWaJAU7PrcGIGwzXYOXo7t
         hRMLcyvdlmeJ4eVUPyyhcf/GL380KInVsoISjDaMaWakVXZcpZnYk4BPMPelaiQJ0za0
         8gR6Hh0Ux9tfnoYibJZmN5HlUa+jb0iGp7Fv3FfvyV0pmksLGeBZVNijVmGLvf/ZogKC
         PNOr3sWQlLnpek/E4HIsOVHY0oFOrRvwnrMpUJMHhM982Y1kZefwzeSY60v1a4D6D7a7
         k3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749734256; x=1750339056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cM18rYl4OkBhTprKN8RdLn8jnxpvdseiRESNUfJz/xQ=;
        b=NRiXyr0VvQ98KGJ4jFMFL5bF4uTPs2h8s2q0R3tf7sep8Y3TQuOP4DQ9Nsg4wyD3Tw
         GemWXA/JzVUBqPpJDHM1SLHeKU0Igwj55xEF8UPytRPpGAUjXhRBhowOGv4B62HBvvmV
         yrqeLUlvZ5ZFY0InPJYMVLAv7sBTLZEe3+qgGGV+0Xa11ebpSy0gG+zFyKzn1aaxEiUj
         dFLX/U/aJj+Q2bSv6Hns9tgUfLBG5iHeRazaw3ULnZ/pwZi0r1sg59R61Ziz3Kojo1En
         wefcZRkJc+EtZ+Rsdxg6QEYoBuRJjXGchPwzEDkOlk0yrJ5t1ZmT1OG0WhlJOXlTjtE3
         GDqg==
X-Forwarded-Encrypted: i=1; AJvYcCUhNo4PgFA48maJ7kcj+D/z2yH93wCCcCBwe7+bXtx7Ve01pZsbpqR/epyhoIc5Y/kBDcqYtLvvh7d/KAMkgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxI0nKnJI/BwOpEP66znL+MSL2RCzGa6n4OotWF6SfKqGY7Fw0I
	mUMNVFhs5AODD8vxJE159DCojHJXAjYaiIYJN4yUVmrFvn2RcESTXYePQ2LzHcN28Us=
X-Gm-Gg: ASbGncudfG1iwjWm0pDwVSvVehKLIIFt8lcRBfH7HJANrqYIMFrBvxwOdsUGlSLfLi5
	+xWiRmDeq3Yy76OxtqV3iwkl6o9xmihwB30xcVmBZdOqEbpHdASf+eW04fU0xhq0zdqEBPXu5kF
	fsJmvx8g3f6MXppfmSp99jRf4xi37EV5DuABb54aH3kNfdB3VWA6/iovmp5nJSC1Cm37ju2bets
	8/WjTw/pdEvRUVy5MeZgD6TRXLX5b4/vWM58meqF3zJdP1BqjH25cCXTxdZj6BVdbEs4Vtifl3B
	MRsFMjhUPNa6OHxKWqzvRp8/fDjDRqovrabTGxoA2Y5kLoQykHSG2axws6bADbZfbKY=
X-Google-Smtp-Source: AGHT+IG7QeuR23ipMSQIY1OjE0Q56fCutzIBHYYbG/VZ6MUHiq7Srr7842KzuwhR16Y3GRED6OV1DQ==
X-Received: by 2002:a05:600c:1d0d:b0:43c:fe15:41cb with SMTP id 5b1f17b1804b1-4532d2f4efemr29273255e9.15.1749734255932;
        Thu, 12 Jun 2025 06:17:35 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4532e13c187sm20888895e9.23.2025.06.12.06.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 06:17:35 -0700 (PDT)
Date: Thu, 12 Jun 2025 16:17:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: miriam.rachel.korenblit@intel.com, arnd@arndb.de,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] wifi: iwlwifi: pcie: ensure RX_QUEUE_CB_SIZE fits
 bitfield for gcc-8|9
Message-ID: <aErTa9ews06Ry8QJ@stanley.mountain>
References: <20250612130719.3878754-1-anders.roxell@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612130719.3878754-1-anders.roxell@linaro.org>

On Thu, Jun 12, 2025 at 03:07:19PM +0200, Anders Roxell wrote:
> GCC-8 and GCC-9 emits a hard error when the value passed to
> `u32_encode_bits()`. These versions somehow think that
> RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)) is an out of bounds
> constant.  Open code this calculation using FIELD_PREP() to avoid this
> compile error.
> 
> error: call to '__field_overflow' declared with attribute error: value
> doesn't fit into mask
> 
> Fixes: b8eee90f0ba5 ("wifi: iwlwifi: cfg: unify num_rbds config")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/all/CA+G9fYssasMnOE36xLH5m7ky4fKxbzN7kX5mEE7icnuu+0hGuQ@mail.gmail.com/
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


