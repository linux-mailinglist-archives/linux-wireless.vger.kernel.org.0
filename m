Return-Path: <linux-wireless+bounces-21799-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD385A95A16
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 02:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9B117402B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 00:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F6827466;
	Tue, 22 Apr 2025 00:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="El5h6H5O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1FA2F2E
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 00:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745281050; cv=none; b=D4FwrBbUtpLpR/xF30WirBLhJr9AfzqWE3eZQ4ogx36LuXgVdb8MInnge7T56OsAe17djW66blej4w1k+lO8WXeT977uFv/QqPsyETnK7XFJpiobuxAaK+QbdgoDmq9uFtTE4JtI+v56GviGAXJON5Xju9q49EhSGCUK/fZGwek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745281050; c=relaxed/simple;
	bh=HrgLJwttLL1sQEMe1Kl7T/hru2XImN4ykMYg2UEJwPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDm/tfYOndYVJl9xSvIkLDKoWK25UcDsiOXHaEdNnMV4NIls2kioh4zF7rsPeXyt9lXpuk0Lp6W/hNiNcfbpQWDcYmM93/buHnXHlcQOqE5m8QqT9oMB33MViuvUs/ODqcf9Q4Bgrn3MW2/1lNtbafvMM1bO0VCpQP/fCmzbcnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=El5h6H5O; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-225df540edcso55810045ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 17:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1745281048; x=1745885848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HrgLJwttLL1sQEMe1Kl7T/hru2XImN4ykMYg2UEJwPQ=;
        b=El5h6H5OppANaA3usiBJ1poh/2kRTJRPImA/dS702evVdR1RQgMlocsYtSdCamtxyy
         F/Vbx/Yg6R5daFVtRQsFfjCs12NzD9KFcBVJ59jynmeTAKzcLpJin/E2m5KVT/qUfpFS
         2pRXgqkghSrQxVqofN3zce0trG/S2aQPzqzQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745281048; x=1745885848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrgLJwttLL1sQEMe1Kl7T/hru2XImN4ykMYg2UEJwPQ=;
        b=vutcLCd1Xub/DTLvPUpgA2/rUyU41syzdKwFYh7VkmIW1qIhCIZqn6Ar7a7jVQiPYJ
         vcTBGkzNoL1f2C/3nTKrs74PnjYbIpGrH0BFOW23Z+7TQIOJmqqv0hVM5XsGBj81Xxh8
         xYRuAWZoSypwtcwBXHIBokWK/WKNDYuxyonBTHNaKCrlYCnD9+UA4HPVMD+9lljyokQx
         7sgJvBY88CUUt3dw3m2tavvXFNGtdmjEa1tLde1l2WZxZbifSb2NE5l2a5DHi3euHRTR
         M6+qs2kW++s353u7WzrJ8kH8DhwBH/IfVXdsiz9XnhJlcqcK8wF8sRovifMn9ldIKgRQ
         bDlw==
X-Forwarded-Encrypted: i=1; AJvYcCVXe/cjTO0LLI8NgpChscyXEbKaNO6U0LQP8ODkusaVObG10Ne+WBQ5huG8G79B6RVee2vcE1fhxb6efrrVKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVq2566/BqQ+tEIE/0T4Q6utkxW9bG3QB99gSg2nC7+GAZV/I5
	0gUtamXFsXY2H7NL9+6w/ywMs7vpyekATIgilOX7+96NyN/rvEorZrnxxpGdx+PO4oZBZTRKVPQ
	=
X-Gm-Gg: ASbGncsD0gSzmRgojX590HG7kz6yBDiuo7Uyzg1WzTBN+0Dj7OIDya23hqoyPj5NNbS
	QVBWj8wkG228bdTpc5IAYP5+xHG4fOoIZjUxfWMKCgN+g+NJ6GE5VVmsQ7LlaUHIKqrkUrhU1rn
	J8Ooj14x7OspujBKS0HI649oA9wYZQiqcADbeLrHp8O5DmzTNw7dRWX0Xm2ZV8QtM24sjGd6Jle
	AD1DXLmSBhxljtQPeQIf/nG7RVJ5yA+0xRP9iDy5tUdE8gDMrxYfFGGgb7/TazwodL5NNpnO8Sk
	4fq8sHdkyxAnsDelerea7y4rSpyhdlUs05QCiVGh8mOykOtv8t5/YFqWCRILctNJM3e5ESiMqEz
	SoohQRt1SF6nFnA==
X-Google-Smtp-Source: AGHT+IEYFWReFAeCQ2q7RxoZidDwt2MsEQV2j+m9bpwLJfJPIe79c6ErF+J0K3gyQ4wc/dODZ9PncA==
X-Received: by 2002:a17:903:1aab:b0:223:607c:1d99 with SMTP id d9443c01a7336-22c53993b51mr221907275ad.0.1745281047858;
        Mon, 21 Apr 2025 17:17:27 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:a29d:cdf7:a2a6:e200])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50fdba54sm71544675ad.233.2025.04.21.17.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 17:17:27 -0700 (PDT)
Date: Mon, 21 Apr 2025 17:17:25 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 0/4] wifi: mwifiex: drop asynchronous init waiting code
Message-ID: <aAbgFZqOF_HizS98@google.com>
References: <20250410-mwifiex-drop-asynchronous-init-v1-0-6a212fa9185e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-mwifiex-drop-asynchronous-init-v1-0-6a212fa9185e@pengutronix.de>

On Thu, Apr 10, 2025 at 12:28:42PM +0200, Sascha Hauer wrote:
> This is a spin-off from my mwifiex cleanup series. I have split the
> original single patch into a series which hopefully makes the changes
> easier to follow and verify.

Thanks. The split series is indeed easier to process. (It doesn't help
that the original code you're cleaning up is such a spaghetti mess.)

With the squashed fixup you noted in patch 3, this series looks good to
me:

Acked-by: Brian Norris <briannorris@chromium.org>

