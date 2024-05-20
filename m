Return-Path: <linux-wireless+bounces-7842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AAE8C9CB0
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 13:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2B31F21BAF
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 11:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF39247F7A;
	Mon, 20 May 2024 11:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fETqUVCP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EB42744A;
	Mon, 20 May 2024 11:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716206033; cv=none; b=PcqQqjZdddnYgLzJBuqGiSuEqpet1ObGjYE/nwu9djhIzRETagSvXxdLKg4sFjCZtumjdVg3l5KEEYF+Uk8Dncc3vrAMKjOMDuaiZPMBMidku8SWWmZQR0kNeFl2uaNzjqHWJstKeIpD4j01pr+fyglR6OeG/tkCakYypFR9LdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716206033; c=relaxed/simple;
	bh=2WwHBbsRsDH0dHOTZXtm084FWAB/MmhOE+E7Q3OpKjs=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=b7Q6wWf2SSnN/GyBEY8F2EXy5EbYeDVd9nsM4wJR+TUNigOPJRGJg9hRw0DD143R+Km96XIoONl0o6pHebWQJ0J6mDrlDyYEfR/6Y5oS3G8XvquHPvGUsjrHOjLEfyPmITGYUd638v5pHSStM+WrojYhY9Hw/4fCSkfprCFmvkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fETqUVCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585C4C32786;
	Mon, 20 May 2024 11:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716206033;
	bh=2WwHBbsRsDH0dHOTZXtm084FWAB/MmhOE+E7Q3OpKjs=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=fETqUVCPRuxgPfRzBudNAVaSdOqbxPlZfQlxuTvVBHVaa1dcu8pLOoCY1ZA3U0DBu
	 w7Gp1mhLekdmLP9UsT4dXD3YSHmSA8XD8GT0qTyzcfSOeC3L/m+L8QgORrherbCGFN
	 TVcVE14YFlQ+pr59tR6z5tjhF2MiRZbdWFdOUiCL6v0xvtDEMLcGfCu8I1SvRlc521
	 5pcoIpFJPwDFsiny3XgqIAuQs0oRZOPu91GbyszpI6ypnbSZPNk4bhl1i73cDA+NP2
	 pCRyyYevtGZO4wlM+KDUN1tf3SM9HdNx/5evmynHsjLJT8ANMJwJAhwLC2pyOhNkX6
	 /+pRS7xnOQVPw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath10k: fix QCOM_RPROC_COMMON dependency
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240511-ath10k-snoc-dep-v1-1-9666e3af5c27@linaro.org>
References: <20240511-ath10k-snoc-dep-v1-1-9666e3af5c27@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, Stephen Boyd <swboyd@chromium.org>,
 Rakesh Pillai <quic_pillair@quicinc.com>, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171620602925.3753090.14163848910895303019.kvalo@kernel.org>
Date: Mon, 20 May 2024 11:53:51 +0000 (UTC)

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

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
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-current branch of ath.git, thanks.

21ae74e1bf18 wifi: ath10k: fix QCOM_RPROC_COMMON dependency

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240511-ath10k-snoc-dep-v1-1-9666e3af5c27@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


