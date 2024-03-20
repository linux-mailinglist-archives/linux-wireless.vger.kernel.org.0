Return-Path: <linux-wireless+bounces-5040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE618818EB
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF92BB21D85
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BFE85936;
	Wed, 20 Mar 2024 21:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oxrk86Pw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6884C85295
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710968800; cv=none; b=tbT+UQl1ilyLD/pWF1pqQD6KfMpVDbFVUthPZnjPH+HFUDY4nDN9UNrIQudeB761eoSIqu04J3vQXSLH68LW4ciDyV3d69L4oD1wgGhA4GktmfRsRgMaZ2R3IaZLr9hQaIhhcVPiDtTFUUYW7h6RZmngWPCk6F3ElCy6YzfufoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710968800; c=relaxed/simple;
	bh=xHT2mJUikQBWxwfcnyuehvD0idGqcSySVCcH2lBZWSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTHQHoQd/MLOVe6nb62RVMbBgW6gmXcehJKBr/pxrPj3jFJkO4WvioUusBvYdNpmR6U3WajZgqVLVnjguok8xb1FMKcgQ9y78haiL11UG4yvgo58nNSiYhgHhUE6mdiwZ2NXIEbZv6b6gOsEuDSNkR5c8GiV6qEH2Ad1lgZKddg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Oxrk86Pw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e04ac4209eso2155245ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 14:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710968798; x=1711573598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z8OHmSo8mnldqqxe1ApYKcq7AJyQHeRjSnZYaTYyZgI=;
        b=Oxrk86Pw1FP4yOgpCREIxSj4VJ3EeylJQSkxZn6O7j2sG9qbfW1/gmIbyaXGczcehn
         WtxkHz1vGHWA+oD+tjSz34rZe9n96f54bjf43vWbnyrBXjQRvSkLi2jQUB0FmRBtf8Az
         4PEcV03yywFPKRUf+MMWxZBeXNrjqNaxsyYHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710968798; x=1711573598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8OHmSo8mnldqqxe1ApYKcq7AJyQHeRjSnZYaTYyZgI=;
        b=wHozwlJyF69sG2kS+SmYEuFjMxCacvXHhA5nq4tpJxgb1QBE/nxuDnispQRncw0C5I
         GE6HLJVFq/e2uu9cJQAQ7FWUg2WV7shLFe88nhcXF1MzrO4grAQGjyAmXY2XueVN8uWw
         nQ4+JPsT+xVkp+qQA89vk8hN6mAL+OKg8na0sI0jFEtWDpwVj9cIFtUMysdxKuZCKYxz
         e92qa5kLT6iZwkiBYPNzWKB9cQqG96d6Nv+15dL4scpcFS8TcMn3cEcOULrAqX/R4Mre
         KdEEEl0WFZlBL/hjVk8B1nfUVzaYKK7ADcFhCoqA9cM5Xy187JqibEK81V4V1PFCyE+Q
         L6jQ==
X-Forwarded-Encrypted: i=1; AJvYcCX42qDN9h/6MjHutJjYH1I4nNHPVq9PLukueIbUcV0abT8mYrvfTHkSfbrZ6Hbob5ITrvFyyuq4IHY9JYi0KREEtzRlkOdTQPDuyfe6sm8=
X-Gm-Message-State: AOJu0Yyj19vjPUGp38yBE3kfYxk13Q9/2WQWSWb3MsPmeJ5PinImRKwq
	mJ9wK5D5I6lSrXBysLW0mnFpR49oAd7Tpxzm4I3s3S29+e/sgwyPzCU0MC7/QQ==
X-Google-Smtp-Source: AGHT+IEnM+E+5cJ8PZohe3BjkCVeINoIlu7tNP0iTAAE/cwQX3VrPVEvBUjOnOy2qN9MeSySn63+Rw==
X-Received: by 2002:a17:902:ea92:b0:1dd:a134:5699 with SMTP id x18-20020a170902ea9200b001dda1345699mr18366782plb.28.1710968798579;
        Wed, 20 Mar 2024 14:06:38 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:8598:2b3d:6e11:4163])
        by smtp.gmail.com with UTF8SMTPSA id u16-20020a170902e5d000b001e00ae60396sm8276018plf.91.2024.03.20.14.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 14:06:37 -0700 (PDT)
Date: Wed, 20 Mar 2024 14:06:36 -0700
From: Brian Norris <briannorris@chromium.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>, tsung-hsien.hsieh@nxp.com,
	rafael.beims@toradex.com,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host mlme
Message-ID: <ZftP3EKiQFra5fPw@google.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
 <20240315094927.GA6624@francesco-nb>
 <ZfTg1xKT-Mxmpf9w@google.com>
 <20240318112830.GA9565@francesco-nb>
 <87r0g6bje4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0g6bje4.fsf@kernel.org>

On Tue, Mar 19, 2024 at 12:33:55PM +0200, Kalle Valo wrote:
> Francesco Dolcini <francesco@dolcini.it> writes:
> > Brian/Kalle, would be ok for you to add myself as reviewer for mwifiex?
> > The patch flow on the driver is pretty limited, but I care about it
> > and I am happy to help out if needed (and I have some hardware available
> > for testing).
> >
> > If you agree I'll send a patch to the MAINTAINERS file.
> 
> At least from my point of view that sounds like a good idea, you have
> provided good review comments for this driver. But let's wait what Brian
> says.

That's totally fine with me.

