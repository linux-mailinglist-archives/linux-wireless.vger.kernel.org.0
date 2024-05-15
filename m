Return-Path: <linux-wireless+bounces-7716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B13E18C6CAC
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 21:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513E51F2192E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 19:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B832159568;
	Wed, 15 May 2024 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DwXOaEWw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E86A1591FD
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715800576; cv=none; b=EE5FAHKmDh7r6wgWzKqreNtZUxv7IkBtlPMjrAy+6DTdnlztjZrQXB/ID0iqS4ANBpefVh0JPwqC8Gu6UPMnWtxlWPhT4pEz37cwS7vzPkhqd5IRJmriOhtnL0ihEhRIpgGIOlAGJFEAUsZs0o+zkD+6XXlPe3ePezxSSUVSyD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715800576; c=relaxed/simple;
	bh=FP5LyQsEGquqKItcS87RpeQ08Gmx+s5LG2B/J1Ts8Iw=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGccvT2+EvzvSXQdpts5NcK6l/TMz1XBctS5+1DpJzeNcwi5vTfGP/7nXVc/hhhj6EnINYsA/EOZ4dAZlaxZQCAgNI8ATKXKq4b6cshRaz1MvU1j1T2OZtHbVXdL+dbWd5L1xdn5FS267l9c9dczHerEFaTmppkJWK1SMDC2rPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DwXOaEWw; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-df1cfa7f124so1133289276.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 12:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715800574; x=1716405374; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FP5LyQsEGquqKItcS87RpeQ08Gmx+s5LG2B/J1Ts8Iw=;
        b=DwXOaEWwek0SnPySO1ARVc0A/4OgrkGiKRT5mcLRlWNxBKGu93kvckwdGoev7VXqes
         8oP0wLbVNorcM7UTp5kFPZa+XHNMpTbKO8gCHBsFl1m9nbc0iln2Gz4tJdmEwV1i7nK/
         1YYuF5S2eQ7VOUG9MD8cQooIgx5qll6LjsBPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715800574; x=1716405374;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FP5LyQsEGquqKItcS87RpeQ08Gmx+s5LG2B/J1Ts8Iw=;
        b=wYYf4VQWqcU1yYTZx+zJcCG6pjKJRlFl37F7YuqTgFUduzfD7i7+TA89xgZPN0NkCI
         42yMhGeq9iNf3vKIaddIUGyqfyG5XDItXZeCvcAthVNY/Il1TeLSme0qLbak/N8k9Fzh
         xk18Ltl5IksJ+eeMyPtR8sVmQIygrrkHkuG3YKIuZuxvL7S4ioIf/QIe7DHpdw1Yg7DL
         y3bfXUwspvBqgnaeX9ltsrOvHNy1QsG1tYjayuGJB+i8pwaJn9Gy64DPC52hv91AKTz3
         ClG3lRd420PQB/KxQ7Ue4hOFiquM+1rNzrN/z6c6ieSsHxhkcx9uMxHXjzC2i1VZc4b7
         Fdmg==
X-Gm-Message-State: AOJu0YwokecXYsXsBoaoCqq1DfhTXM0muxvSGhUb7E5Ov2Kh/ZjnQynb
	EHGmU4QEXzaMoc5mfSMdnYyc3FQ8Z9mxGZyL8SrTXS7ho9zqey8oMB7Cef8o3csh5fe7cdhtiT/
	TKbup9UwPNt6YTU/+muZ06SDLM9v5ynoj5QtV
X-Google-Smtp-Source: AGHT+IEZFVp0/9J3vEYY3DeetifpNlyI7Reu7bida3ovANfhBvDsm0gF8xGPrJXaQaXknjiNqesUsWMhYeDWThoRIkM=
X-Received: by 2002:a25:6b41:0:b0:de5:568a:9a9 with SMTP id
 3f1490d57ef6-dee4f2f7f74mr14602381276.38.1715800572793; Wed, 15 May 2024
 12:16:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 May 2024 12:16:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240511-ath10k-snoc-dep-v1-1-9666e3af5c27@linaro.org>
References: <20240511-ath10k-snoc-dep-v1-1-9666e3af5c27@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 15 May 2024 12:16:11 -0700
Message-ID: <CAE-0n52ptoRRQEL1G9vTZ7ExemrUSmV2Km=uts_E7wBeoz_GcA@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath10k: fix QCOM_RPROC_COMMON dependency
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Rakesh Pillai <quic_pillair@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-05-11 03:49:59)
> If ath10k_snoc is built-in, while Qualcomm remoteprocs are built as
> modules, compilation fails with:
>
> /usr/bin/aarch64-linux-gnu-ld: drivers/net/wireless/ath/ath10k/snoc.o: in function `ath10k_modem_init':
> drivers/net/wireless/ath/ath10k/snoc.c:1534: undefined reference to `qcom_register_ssr_notifier'
> /usr/bin/aarch64-linux-gnu-ld: drivers/net/wireless/ath/ath10k/snoc.o: in function `ath10k_modem_deinit':
> drivers/net/wireless/ath/ath10k/snoc.c:1551: undefined reference to `qcom_unregister_ssr_notifier'
>
> Add corresponding dependency to ATH10K_SNOC Kconfig entry so that it's
> built as module if QCOM_RPROC_COMMON is built as module too.
>
> Fixes: 747ff7d3d742 ("ath10k: Don't always treat modem stop events as crashes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

