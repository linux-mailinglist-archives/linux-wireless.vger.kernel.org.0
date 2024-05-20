Return-Path: <linux-wireless+bounces-7833-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318618C98B6
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 07:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A629B21FD1
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 05:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F31A125B9;
	Mon, 20 May 2024 05:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Om4CjROx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5799DDDA3
	for <linux-wireless@vger.kernel.org>; Mon, 20 May 2024 05:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716181567; cv=none; b=eeef87eYFBUKYNH0rP0kILm4Ir+s/rVf00wd5IWVbVnfaiumx1gbyj/My9WKQto1EALhAYoqOC32qdONM8OHu1FdS3BvnSgWYx6e2czUfJUyjLZrYF8iCGL8OKCggQOqf0Swv7lxYHzeu1RkNTeTEddt7d0Yh2cPR235SyAp8fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716181567; c=relaxed/simple;
	bh=DZpNSz7H9sLfnXQ7oPyvpDvCfzqOXTr0elDJgRY3kGE=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=StI98JmmuQSRoxoT+c0tkqrbMHtd7ffjwnqkzsIT6CH/LOZEPbl9I+hnkDUz8yAj/4YxlyuGqrs81+n6HPuQjyMUEbcQSY8UxcjoTjjaNKtjbIuDax/sF4PaZSl0oD7OYjdXa3l/ez67kdqAchNcK/gZVemSib6VahAq5FY60iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Om4CjROx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE74C2BD10;
	Mon, 20 May 2024 05:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716181566;
	bh=DZpNSz7H9sLfnXQ7oPyvpDvCfzqOXTr0elDJgRY3kGE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Om4CjROx1SgUV6g4UnFCY8r52TxwMPUQuEHb1Zp/nrEnpGY0uixe3frkVnSkeBk9p
	 IM562KWHejYL2uf5Tv3bKJlxV4yzaAtKt/7pu4/zpw0bnhs7LvQPRm40I//wLgw0IP
	 lO9AhUn2Wu5eu4SpvF7y6H5uiaoEbsEFViAbEHpDCPzPV7wS6hlA4JTPYNTD40GzOL
	 EUbU/f7QLIHFhONo3CPsP9Z13A+t7dhm6PIcxR/45KLHyK2FhNREXAypmgpu6LQ+Ng
	 iJGovgWGhWOkyhRUGKoRsjHLUMOo5MzFLJp297M4nJZ2Izw0B7Zx4mhx5OzlDfwG8z
	 39StsCAGtVTow==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: rt2x00: remove unused delayed work data from link
 description
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240515152824.143537-1-dmantipov@yandex.ru>
References: <20240515152824.143537-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, linux-wireless@vger.kernel.org,
 Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171618156392.3599597.3211233250865490379.kvalo@kernel.org>
Date: Mon, 20 May 2024 05:06:05 +0000 (UTC)

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Remove unused 'agc_work' and 'vco_work' members of 'struct link'.
> This follows commit d96324703ffa ("rt2x00: merge agc and vco works
> with link tuner") where AGC and VCO calibration code was completely
> redesigned. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless-next.git, thanks.

2785ea9673a7 wifi: rt2x00: remove unused delayed work data from link description

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240515152824.143537-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


