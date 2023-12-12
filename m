Return-Path: <linux-wireless+bounces-702-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2880B80F11F
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 16:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF72E281489
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 15:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E16975424;
	Tue, 12 Dec 2023 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlewShFq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23875745E7
	for <linux-wireless@vger.kernel.org>; Tue, 12 Dec 2023 15:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947BFC433C8;
	Tue, 12 Dec 2023 15:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702395237;
	bh=SmtuEPtz2gzeGWshtG4uyVitXKymgOX+I4Y5KbfxugY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=rlewShFqcuUl6vDGpo3zWkQ7SBnDE5lCbYdC7i2VNcygpJjq0aHvF6ZhnKu54uz3m
	 OjD0cq/NZ2Ogknuk26z7NB559boqbVAwrNRRz1LYZIXaLDOv5GOoGwMVepFM65Q2Gf
	 olf39Qh/K/raIGyWG5FfBzhorsycp0xTgWw2x6EO7wn7ziCF0G/I6/sD+J0hpDw/pr
	 SUzySXvY/eBRBWqxUq+PLMtoUP8jz6KBiyx3q7J1pm/6zZtBqdds3f2zVb05DasPXX
	 L+BiD+TnVM4yaBzxKyXShsXoVE67q4Kni5mkSONf4nwfEIzWg+kxffa7Gcvsn9fSf2
	 Ziqz3wKZX7Omw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [v2] wifi: wfx: fix possible NULL pointer dereference in
 wfx_set_mfp_ap()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231204171130.141394-1-dmantipov@yandex.ru>
References: <20231204171130.141394-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: =?utf-8?b?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
 linux-wireless@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170239523486.306086.11081054761735542992.kvalo@kernel.org>
Date: Tue, 12 Dec 2023 15:33:56 +0000 (UTC)

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Since 'ieee80211_beacon_get()' can return NULL, 'wfx_set_mfp_ap()'
> should check the return value before examining skb data. So convert
> the latter to return an appropriate error code and propagate it to
> return from 'wfx_start_ap()' as well. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Tested-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
> Acked-by: Jérôme Pouiller <jerome.pouiller@silabs.com>

Patch applied to wireless-next.git, thanks.

fe0a7776d4d1 wifi: wfx: fix possible NULL pointer dereference in wfx_set_mfp_ap()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231204171130.141394-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


