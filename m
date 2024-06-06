Return-Path: <linux-wireless+bounces-8609-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB7D8FE66A
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 14:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D3B91C21BF9
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 12:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FA61953A4;
	Thu,  6 Jun 2024 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rd3k/4so"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9871850B6;
	Thu,  6 Jun 2024 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717676750; cv=none; b=dNvNsymGWcgzdE+wwYBA7hoi0mJNyAf2PJm40P09X0GGeCP8SHSHnKvjsENToiXhYDzVwTiQ/iT6dxmT3xFigzZS3dvZVpiyNwpmWo93QglaOGAtBf3JlAOEPMGjnG8FahEOT4GT+AQ1+GMrnHIrwaGDcvtYV8OXUZz0KAiZ4hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717676750; c=relaxed/simple;
	bh=wgd4kfrcWkWlc37FzWLwuwUZ9luHqwOKGupkLFnyxnA=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=gDOEsG6O/Our14b5jsk3FVP12wJP6pTDta+cexmX/xeovxI42UdyxLENIbYeWZa2359C3CpjvUqJFL3n1mZ+/gUQ9fwySRknX263ZMsLSPpUKBIFSTv295vafm9FPycIMS8YYkGEpojBklcxuC6RPIoB9Gk6ngGnM6pXr/nUbdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rd3k/4so; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A66C2BD10;
	Thu,  6 Jun 2024 12:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717676750;
	bh=wgd4kfrcWkWlc37FzWLwuwUZ9luHqwOKGupkLFnyxnA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=rd3k/4soY84XBPxYHxK9Dz1shg5zYyyuHC+SNsSH/RCjWBEnDodIq9hpwiGjP1DWX
	 uBkECGZenqatYskpINab+c78XJv1VmdLzegw8HzKBgd7WlPmkmo8Odd2bdJZUblF2G
	 sIWFR/jSWJR9hNhi0n1X0eECiL9nXMNmdIqllwq/3ibXqbdONWV4oYDQe244NvAsWg
	 AIAEAG7uq5CuPeSMsEeZFxVzTqx8VMxNR7B9XPL5ROiB9EHvTDCyGpX4NicKuiGMfJ
	 Z1Cs8BAKf6dfC2dbWr9zYYrwUrO+q+ww2zjQNt2j7p/CtnB6Ozxkej++eHMV6l2Vy7
	 /D7tPZ2mJspXw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: mwifiex: increase max_num_akm_suites
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240530130156.1651174-1-s.hauer@pengutronix.de>
References: <20240530130156.1651174-1-s.hauer@pengutronix.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>, David Lin <yu-hao.lin@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171767674666.2401308.2539321240473169281.kvalo@kernel.org>
Date: Thu,  6 Jun 2024 12:25:48 +0000 (UTC)

Sascha Hauer <s.hauer@pengutronix.de> wrote:

> The maximum number of AKM suites will be set to two if not specified by
> the driver. Set it to CFG80211_MAX_NUM_AKM_SUITES to let userspace
> specify up to ten AKM suites in the akm_suites array.
> 
> Without only the first two AKM suites will be used, further ones are
> ignored.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

I assume you that you have also tested this on a real device, right?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240530130156.1651174-1-s.hauer@pengutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


