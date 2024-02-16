Return-Path: <linux-wireless+bounces-3714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AAD858823
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 22:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30681F23499
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 21:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB323146904;
	Fri, 16 Feb 2024 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d/Z+i0Gs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88230146900
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119753; cv=none; b=IOS9CkWFCThVGam1GQc9uT6xulT8gRIwC9aZuwikhbBaTsX0ijau2YQ1xwdwSuj5o4eKdaitgR4+qWZydNcHrUZTryHSK/SV4bSRjQsTsFB+COuro9PVtfdQ3t89YKyEy1m0VRVKHd5fPk5eGF2Psk0KarZYwzaLOf0P4c/wSAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119753; c=relaxed/simple;
	bh=4c3eMKTWbi+wcF5n+RJsW+tkHhjsCNbcJlVT2UgwhH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/noHfbefNTjKhkPMG3mKEr/+AJVd54ftQxS8CozDlMeEuG9nMmxsew+sYB1+m1AoKe4SSo4qMnLX0xmDBU/DzXJ900rtS6OdMcuGrqj56mlYHU3t8BBkpFWmZCt4PxJGu/9IWNf9mQ21c8Rlyk9jGzGpWIhCDDYqSGo+OH5ps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d/Z+i0Gs; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5dc949f998fso1769465a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 13:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708119751; x=1708724551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmqvLalSTvjyY0hPo1vwRpJX0mbABPaN9LQ6zaR4OAw=;
        b=d/Z+i0GsxaluQ09Eag9Jx/VRbvIGgYqk5+TPqboE7vd2kcAWt6lWhgcIc/4QNYWYXe
         uqFdfxjbZ0k9GvgePThKtazLI/P6K/n/ViTz7n5Itqt6D33I5vVZ6K+WX8Y/bThvkOcM
         GZ5BrfacAeH+5+j4IKuYE90L+Hu0CbaEGetKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708119751; x=1708724551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmqvLalSTvjyY0hPo1vwRpJX0mbABPaN9LQ6zaR4OAw=;
        b=lfL1rdHJz/PTDFoe9g6IYdg4PwxlQt70NQFcyKDSoshyYgCTWSFZWuSC1Xq8RqWpd1
         ny/JRxi4/9wjI5qe1AlAgNT7tf2R4POx6IXs3lC1g9QvHBbmjgesQ5TeaWNy90tfVBhV
         XDYyOX1Uou3pPWldXmv9iuGUTzYfgVSk8AnsYO9YD1LK2CR6QuUDepLlNXn0yFy6azA2
         xDVOe7U/O3FQwY7LMx0gtDhr2ripsf7HyVfpLSuNo1rlrfOz6TX/nXq+H0pah+BkU6D0
         0E1A01s85+2p7PGq4cpMoFb9WJjzTvXCJn5+2ksPi0iGWreaWUYzUwH0lR4E2icwF1Kj
         tMEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVKQzj0isbFdPusu6sSwPtnVQZwzPXOMqggh7whfHfG4rTC1WhNpjdB3kDxRYV8iqPGL7+wMg0iNJzawBToZdc5rDrnVSvln1fg3v8uB4=
X-Gm-Message-State: AOJu0Yx2IorY+QFS5O/uO8JCss95MloX8GvqNkvB6a8XcAzhexOtwdgd
	WhVPX6CYq4xYu+LvC2kIJAVeeUCGLtrShAx1pKLslvXVDvaa0uPRa3BtUWfLdA==
X-Google-Smtp-Source: AGHT+IEXIq2vlhY0MRi3dbghbU5hzq6K5TiA/bjopoX0NzcTaYWwUJfK3zWU4HYBShZXvZGvCuUPfg==
X-Received: by 2002:a17:90a:b902:b0:299:24ae:7ed9 with SMTP id p2-20020a17090ab90200b0029924ae7ed9mr5316353pjr.36.1708119750822;
        Fri, 16 Feb 2024 13:42:30 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id cz15-20020a17090ad44f00b0029703476e9bsm453747pjb.44.2024.02.16.13.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 13:42:30 -0800 (PST)
Date: Fri, 16 Feb 2024 13:42:29 -0800
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: brcmfmac: fweh: Fix boot crash on Raspberry
 Pi 4
Message-ID: <202402161341.AC45AC7@keescook>
References: <Zc+3PFCUvLoVlpg8@neat>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc+3PFCUvLoVlpg8@neat>

On Fri, Feb 16, 2024 at 01:27:56PM -0600, Gustavo A. R. Silva wrote:
> Fix boot crash on Raspberry Pi by moving the update to `event->datalen`
> before data is copied into flexible-array member `data` via `memcpy()`.
> 
> Flexible-array member `data` was annotated with `__counted_by(datalen)`
> in commit 62d19b358088 ("wifi: brcmfmac: fweh: Add __counted_by for
> struct brcmf_fweh_queue_item and use struct_size()"). The intention of
> this is to gain visibility into the size of `data` at run-time through
> its _counter_ (in this case `datalen`), and with this have its accesses
> bounds-checked at run-time via CONFIG_FORTIFY_SOURCE and
> CONFIG_UBSAN_BOUNDS.
> 
> To effectively accomplish the above, we shall update the counter
> (`datalen`), before the first access to the flexible array (`data`),
> which was also done in the mentioned commit.
> 
> However, commit edec42821911 ("wifi: brcmfmac: allow per-vendor event
> handling") inadvertently caused a buffer overflow, detected by
> FORTIFY_SOURCE. It moved the `event->datalen = datalen;` update to after
> the first `data` access, at which point `event->datalen` was not yet
> updated from zero (after calling `kzalloc()`), leading to the overflow
> issue.
> 
> This fix repositions the `event->datalen = datalen;` update before
> accessing `data`, restoring the intended buffer overflow protection. :)
> 
> Fixes: edec42821911 ("wifi: brcmfmac: allow per-vendor event handling")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://gist.github.com/nathanchance/e22f681f3bfc467f15cdf6605021aaa6
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Yup, this looks correct. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

