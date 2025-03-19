Return-Path: <linux-wireless+bounces-20525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB63AA682AC
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 02:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52146421945
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 01:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2341A920;
	Wed, 19 Mar 2025 01:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HJzbM3uu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2EE29A0
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 01:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742346867; cv=none; b=qz2yGyuSluwKImx0hWAjXNqC5xwEIkJ8foYlMBcJRptpkGR4khw9NQbl1PoBia4/TOx4r+NnaQo0MmBm3/wNNluuR7vxMKCMFz4xryIGuVqaPW2TNm6gaR0ahbbKYLdB9zmbLZd/prTmTteMqVbHOGWGTb4ct8etvqEbX8TXqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742346867; c=relaxed/simple;
	bh=CswRwcr6BInH0rC2zUiXNzcGBmmuixvamxGDYImMcFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgYTCleOMXCHR9Dd7U1yWH3qDQmwHPtoDb6sQu4q2y/w6nYQG9mnaNKstcvVcGx5XsIVJAfqawwULRglQauKzW8OfzYKGWOVcQvzBSj7Td5QQVzgiWKUw+OhkUiTab3cEoIxcsEOgwCzNR8XFr5N1/KMqdhpYAZTQGSmCY7hum8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HJzbM3uu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225fbdfc17dso58604905ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 18:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742346865; x=1742951665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uGrzJ1UuShQeE0bIlKrHo2bnT+e+KyM1SECLLJdxup0=;
        b=HJzbM3uu3mOafxhhW4DGvZv/aIqkjDVSflvDnjv6UNT2OnkCn/GfASj84XexDg0UvB
         tyUrO2gZjahk7qReVD5SiMiiD6ze2OI8J8SvVXuNb6bR3o21zNQNGBAI7QDqiz66uRhC
         VUNdNsikIK8kwGBVmBy8Swb/BupSIS+prnUQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742346865; x=1742951665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGrzJ1UuShQeE0bIlKrHo2bnT+e+KyM1SECLLJdxup0=;
        b=DEC7s22FL+S2zZ++h6ZD7BKDG/+PPkvSUdRY0aib4MYLKW3qp/vhTBtcwZGLDy54fx
         10HkLFIgW9IfMVd13usvYJ4Wd5AV7gyD1g2YM+Pemx6kgAEMwB6Be0GwQhX92tsFo8lf
         S4pz9XFqurCw1D0GyDxGvxFR3+nU9qyODtmgNgSLLejMJULRvbdHcubqu9rhBwq3GGTU
         E32X+TfG6M1XUy7KST0jYJugw9ReJaD8zth9K/cKWrCNFhjk+BwgH8k7m5kEq/GYo5w0
         l+lpHl2TWaAIcZR/plvawusuujyzOIxlAAqPmlE1TxriDq+WyghlN9aSKUmLmphPcA6s
         uvnA==
X-Forwarded-Encrypted: i=1; AJvYcCUtmyTp+4D/NtdCRPOWm5HvDvOto4dwLli5zvsUwCZBUqQQTLlG7W5NRkXButJ9sZQq+bzh04jDFSeDOMzFjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YymON3zqRWgppfxntrlcnllfZaP+XwXWUjzr/O+DBago64ANMNh
	i9hF89CEdxqwltB8+cnuIphnqYKyAR2+FFENps2x2lD6GAagJLI14hQlRHD7jw==
X-Gm-Gg: ASbGncsW4xSgS9jUu8q1Bv2zCd01vSRz6Pg4dSMpg+WgTiQsLHbmIe9qRb5GCkSyK21
	tCCOhQBFAyezrkBAaTQaOsSq2eXLOXNeN6Db5Xu/79xzgwOxp0f6TCUn8fAq4QCJIbOQb/kMdoQ
	LgRE28T+D9QlUg4Ch30txmRqXDKZUki5x7kn4xrGg/cB0F05RERw8j+WYePeUbne/tBoW9Qc+mM
	qEvP65oP/owb0LJ6Fyd8r0alSbXPqYhajqw6xplXePA/w6+KDL5sgOf4aQGcFFTQSVTEjvdY2kQ
	jRlxnYpnTvm45A9r+J8v03rCiQBIH78KbeEjVhy9L5RdG7bRg/nNSLwmAT7QHupFnV7HWTvn+nB
	yr5KWsnw=
X-Google-Smtp-Source: AGHT+IE2r4+WyvklTVYEM/9BkxUcBJdI34MNjXHXsEpIaA86ul85ljErrDO4kXiJnDAlxKXbr1mF3w==
X-Received: by 2002:a17:902:e950:b0:224:1af1:87f4 with SMTP id d9443c01a7336-22649938840mr13243735ad.22.1742346865550;
        Tue, 18 Mar 2025 18:14:25 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:cd95:bdc6:b8b6:b80b])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6bbfb4fsm101883725ad.208.2025.03.18.18.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 18:14:24 -0700 (PDT)
Date: Tue, 18 Mar 2025 18:14:23 -0700
From: Brian Norris <briannorris@chromium.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-wireless@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>,
	Francesco Dolcini <francesco@dolcini.it>, kernel@pengutronix.de
Subject: Re: Future of mwifiex driver
Message-ID: <Z9oabwPsFJEJKaAD@google.com>
References: <Z8WM9jn1QFscWZBQ@pengutronix.de>
 <Z8ZbJYmxgnvd7Q1O@google.com>
 <2587f323fe19b33d2e9ec49bdc3979f71b9c0ba0.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2587f323fe19b33d2e9ec49bdc3979f71b9c0ba0.camel@sipsolutions.net>

On Fri, Mar 07, 2025 at 09:48:13AM +0100, Johannes Berg wrote:
> But copying an old crappy driver for the sake of "we don't want to
> maintain an old crappy driver" is a really bad argument to make?!

Is that the argument? Honest question. It's not really clear to me.

From
https://lore.kernel.org/all/20240930063701.2566520-1-yu-hao.lin@nxp.com/:

> [1] We had considered adding IW61x to mwifiex, however due to FW
>     architecture, host command interface and supported features are
>     significantly different, doing this on mwifiex will carry a lot of
>     burdens. The effort of making sure no regression is also a huge effort.
>     We must create a new driver nxpwifi. Subsequent NXP chipsets will be
>     added and sustained on nxpwifi only.

That sounds like you noted one of their reasons ("making sure no
regression is also a huge effort"), but they also claim the FW
architecture and host command interface is significantly different. I
don't recall seeing a proper discussion of that -- although Sascha seems
to claim [1] it wasn't that hard for him to support iw61x via mwifiex.

Brian

[1] https://lore.kernel.org/all/Z8rGDTjkwKAVaREL@pengutronix.de/

