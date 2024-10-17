Return-Path: <linux-wireless+bounces-14161-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27BA9A2982
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 18:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30AAC1C27CAC
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 16:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02481DF969;
	Thu, 17 Oct 2024 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8ykIPTN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C45F1DF963
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183719; cv=none; b=D2TWqyFyyRiTs8LjBlvrCD5aH//JHYjzl7E/7r66NtDsaW+mT90YznYxiC+WQ47jf1K7cIzcI2/jhqXA7+FJNpT1Xbe9jVscmjeNYfLNI7OoJg28UjEKS2KATeSyrSBipqpTAxOaewgvPbd4UEmiPvRKAmnt2n5mvaQErCevx64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183719; c=relaxed/simple;
	bh=hcYT01pKLpBZQ5GmZQFQAkEg785xPs5WuCIRK6z4FLk=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=fWZEMQVhp+9JQJdyeN9QX4jQ+46mi9cCZ3KHDPSMkThK1uwF+9B72QLgM4XeblcvzouAR/AywTmL10ZlJxbqdMC6lcdXqdjHWt/ftrUsh/mkNDT302+Yo3WwLN8tWkd4JhPr23lN8JZrzeV/ikfAoxCZHQusFpMqSH2lM+r3kFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8ykIPTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475C6C4CECD;
	Thu, 17 Oct 2024 16:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183719;
	bh=hcYT01pKLpBZQ5GmZQFQAkEg785xPs5WuCIRK6z4FLk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=H8ykIPTNPogagKrwXtdbVhGLpvv3oOS5PgYzXA90EBQQIqbL6R+oSHftbqJEMHNPU
	 2cnNePME4dfnMnLfR79qz910X08U4xMMIy1qLsdng6kfsEXHi3tVgxxMyduBdqYO9N
	 lDJvYx/mBcO9PvtppPwOpiJeEV5eiuBJMWPzkrQsnCwHkoByLZefgFtgPFwQKR0z8I
	 09OUkm+Juko1T8f9P/Hi9rCze3DoI0/+xpjSc4oH1c+ozbRsLwWiPMvNOjiOBInzUh
	 UN3Qykj3uW555CMSrEAI35zQ+RCyPX972Mtuc/GZusuoAZ+hrZ30SSf07jmrU0ez7y
	 jrhhcz9wlHA7g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [1/2] wifi: mwifiex: cleanup struct mwifiex_auto_tdls_peer
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240927084317.96687-1-dmantipov@yandex.ru>
References: <20240927084317.96687-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Brian Norris <briannorris@chromium.org>, linux-wireless@vger.kernel.org,
 Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172918371669.970100.4257266161703633530.kvalo@kernel.org>
Date: Thu, 17 Oct 2024 16:48:38 +0000 (UTC)

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Remove set but otherwise unused 'do_setup' member of
> 'struct mwifiex_auto_tdls_peer'. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

2 patches applied to wireless-next.git, thanks.

d0847e16ca2a wifi: mwifiex: cleanup struct mwifiex_auto_tdls_peer
6dc944577254 wifi: mwifiex: cleanup struct mwifiex_private

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240927084317.96687-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


