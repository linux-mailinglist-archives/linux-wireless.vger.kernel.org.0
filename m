Return-Path: <linux-wireless+bounces-3784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E0085A8BD
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 17:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A539286A56
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 16:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943E23B786;
	Mon, 19 Feb 2024 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2d07rAs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708D637704
	for <linux-wireless@vger.kernel.org>; Mon, 19 Feb 2024 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359677; cv=none; b=Pco1CaICdUScMku4Gv2YBfy6xqmQBF1gm1E2yPY9prnImYfgRx1QoDukRL6AQ/o5SrpJIcLiOWXsgdiy9YB42qC4YqzZ8tw62Vbicn1ghRmK3j0yRw0FQNY1PBhj2GBoMc+r8Gy+FEhn37AdZMXoe2qI6MzAVk7WxqsqVRonNYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359677; c=relaxed/simple;
	bh=gpuLep6CZjZ5VjyOJZ4AIBcRf6WszJ9Jx0LmSMYuNd0=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=mohDiQuSCpuF2zfdUee7zC+mse3zVoLyw5xKgfd4hnTVHIuTqsnRfzwk0SFI33BiwpImQnbb9U5t/T6wZgVO8jkexvmt9XhJP5PcPA2at9hWStmiy4pY7tr56QCAkoTINXtEpgqaWp7dQixvnZfRnVQA+0D50AuCDS+RrzrjqlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2d07rAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB10C433F1;
	Mon, 19 Feb 2024 16:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708359677;
	bh=gpuLep6CZjZ5VjyOJZ4AIBcRf6WszJ9Jx0LmSMYuNd0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=L2d07rAs8T1GYq71AXzza0Hyp0VsqxGVlEp3a660bwjyHzhQLbtjuJvI2iZA7KB7x
	 6ZyYyUy0ANkHlABq4UceVpMoQBDf8+JJgqPfjkGk0j9d6DtgKcdhrXyuvmwMTqOvPX
	 /UXAw2J/PcM3q7TnuspOCRWLMBxTtqa0UyvPd3Tgqn83m03/HMvOE9SkdUjgDT06bD
	 PSp5joqOGD1Pcp4vqGWHjSP3XjYGt0Sgol3y5ooeRIOAkNRtFHUnb+7q8sCtmVXyAQ
	 UTtuB3kr5dT5aGfCEOr9T7N445FrE7cSSxkljeGhYhNzEQ3Qky9MwnxivPQprb1+Vg
	 Rcuk+nW4yNoVw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: rtw89: 8922a: add set_channel MAC part
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240215055741.14148-2-pkshih@realtek.com>
References: <20240215055741.14148-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170835967485.848163.7918131868382662979.kvalo@kernel.org>
Date: Mon, 19 Feb 2024 16:21:16 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> To set channel, add a function to get TXSB (TX subband) that is hardware
> index to indicate primary channel. Then, configure band, channel,
> bandwidth and TXSB via registers.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-next.git, thanks.

ca1e11638893 wifi: rtw89: 8922a: add set_channel MAC part
f59cb1a03098 wifi: rtw89: 8922a: add set_channel BB part
2c681cbf6c3a wifi: rtw89: 8922a: add set_channel RF part
03830bb909a0 wifi: rtw89: 8922a: add helper of set_channel

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240215055741.14148-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


