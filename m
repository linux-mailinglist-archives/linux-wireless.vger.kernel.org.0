Return-Path: <linux-wireless+bounces-20815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B7CA70D0A
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 23:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184593BDF5D
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 22:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773BA26A0CA;
	Tue, 25 Mar 2025 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GQhYK1hd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89CB26A0BE
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742942427; cv=none; b=jIfSOAMv2me4qzpFZLcd4hfmfGyPdY7zXRE2XGBpSJ/gMis8w7N74/2CdXmdfqvxTNvQ8LJQ0ND543pKN78/Rqk/wA7vGGkXAFXgeSpNpP8Voh5hQVPyOVOPJov40JEb5zhsqPcGIP0OEqZ8XYIxt3zAgXsSmH/a0Gi8eqQYGWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742942427; c=relaxed/simple;
	bh=pQ4UoyDlpkHuiZgOcYbiP4Xig7yGzQ3Q2/+D3ehiXNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fmucd1QU/yesErwkkPzpiT71mk6EVq4MvlX1mZ5bWBIoSXNgyXfazDM2PoP7VMsaouHgAcui6rhPq5vq1AtQJBbad5dqG5/gR54adrqDmG5vWbXJKUylp02zsAeepjNpcVzW9b1y5cAPYBA6kfhi5OaIrVYAndqbBrv2OVcx+Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GQhYK1hd; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-301302a328bso11686193a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 15:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742942425; x=1743547225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQ0mQOw62tpJtHtq3bDP+LhjKb7VU3twZUif4e7fNdo=;
        b=GQhYK1hdsQPc38IdJ6AIvyattcUJJLw0K6nefnDPT46rZvc/BQs5h3hF377S31XDhK
         3KxXg8htAQA1HPmJufoEETmGqsFahje/CjWGlEbF4b/fDpuKuDmG1pbmxk6XsG0vP9Bb
         CU5VaaihLJgMKAFvhoL9BnTJAawhZOR5+Kd5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742942425; x=1743547225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQ0mQOw62tpJtHtq3bDP+LhjKb7VU3twZUif4e7fNdo=;
        b=Yggh7BXUh3ZlRlyeeU/euv2NSo+8JnXUZapqGaQv0MCxuInRNAGO3+u5LpIsrhLLAF
         vyumtwR2gjbBKfhx47eTXAl5Qs2dBTO/gMkfb9cvHk5UlbMHyL9JsmzIRNdBGw8E1Ul8
         jGnH2T05PANXj3RJLLplTn1RFggiVHFy+32PCCmfv6VmAAGvaMBMb7an5guwkb37bAX7
         PO0T6JoJt8Fb+Xd+4+PEVDY3qXI6kcxDsJafq6NmxbOgArf+ffRIYpLm7rVsXz+Sqxdc
         Wu52nWqpOGybAjTyWoSuKOP0m5kWweBU2E1x2es1xA2rt+vN/L1zUKdw9faa02dQvGH2
         jxdw==
X-Forwarded-Encrypted: i=1; AJvYcCUk4oq/hMbbPCgZ3nYkwGA+M2BY+bZVL/MMKBuXc5DYvkzaCWHpsGe+hfgKekybdJ8+h9C6my99/IRSHajD0g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yznzpm5GXIQszRcXWr9m66ISq8AnUU4Vq052q7kT/QoCr4tkgWj
	V3a7s2bUUPEtO4W29bvgYU2ZApr9scXFp7lew2dneMFmkTMeHKsZjF3SQ+urSQ==
X-Gm-Gg: ASbGnctPF/D4G5qdqzz6MgKtE+ZL2upmgkY8czxntiftYzK06BXzJMw0obaDHnOtLUX
	h5zS7RG2TZvqMPeVDCDt1ypneROP3faTiJ+qflsLeKjjg2oHz1GLvQFwKGzXyD5MAn36GtJavtE
	Gd40jT2xVsJRUgj+pBnichaOERaeazaSij6AW1eKa9MceRhPXLJxkWorlq5URhfFoniCFn6oZE1
	OKYqq1UyY+LCMCkq4QZOUoOaji9ZmlHKPptIpRcFG87TtC2Hb/Bjq5s4ykHr8vC7oOpELB57uzn
	2zo+JVqzTuwO8ne05mg0gs8PuNYzpObMwV6j1JFcsHkdz5mrAh9wbTSec5EShXyVNc0e6VmbWFP
	rl9WQuBM=
X-Google-Smtp-Source: AGHT+IFnMbdSPWJg/PZpthIfsM4Byyr22hmvQEezyxPZc4t6JJRig3bNhZIvvWZylXPImyBG3wYAXA==
X-Received: by 2002:a17:90b:4d07:b0:2ff:69d4:6fe2 with SMTP id 98e67ed59e1d1-3030fe9c932mr32753804a91.16.1742942424766;
        Tue, 25 Mar 2025 15:40:24 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:b885:47c3:6268:77fb])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-301bf61b525sm14937020a91.35.2025.03.25.15.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 15:40:24 -0700 (PDT)
Date: Tue, 25 Mar 2025 15:40:22 -0700
From: Brian Norris <briannorris@chromium.org>
To: Kees Cook <kees@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Allison Randal <allison@lohutok.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Add __nonstring annotations for
 unterminated strings
Message-ID: <Z-Mw1gvbkBQ1fZ7y@google.com>
References: <20250310222332.work.202-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310222332.work.202-kees@kernel.org>

On Mon, Mar 10, 2025 at 03:23:32PM -0700, Kees Cook wrote:
> When a character array without a terminating NUL character has a static
> initializer, GCC 15's -Wunterminated-string-initialization will only
> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> with __nonstring to and correctly identify the char array as "not a C
> string" and thereby eliminate the warning.
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Francesco Dolcini <francesco@dolcini.it>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Kees Cook <kees@kernel.org>

This code is kinda weird, because only 2 bytes actually end up used, and
yet we explicitly initialize it with 3 non-NUL bytes.

This solutions seems fine though, as it is indeed not a C string and
does not desire nor rely on a NUL byte:

Acked-by: Brian Norris <briannorris@chromium.org>

Looks like Johannes already applied it anyway.

