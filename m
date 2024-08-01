Return-Path: <linux-wireless+bounces-10819-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E28F944EA5
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 16:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70D91F22377
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 14:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE621A721D;
	Thu,  1 Aug 2024 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKaEZ8sB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97CD1A57D4
	for <linux-wireless@vger.kernel.org>; Thu,  1 Aug 2024 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524391; cv=none; b=fAHIVoMGhIHrfITHibWFfjw3pBzO76CCk1zwALn/cfujpk4Hjm3GwQV/ofcEVsQkzjP8T+ybv/aezrIYG0lxzUK3jUdjtr1LS7NLhxoaKR7siZq4nDW8xNph8iT4IvDDUm8m1nbPP6kjc3E3pO7Zq0o5KCNem+pK3v+GaS2EJt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524391; c=relaxed/simple;
	bh=wpL4CMyLi8WCjSI0Y3VNSmgZ34rywAFS858yBI8onb8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=GZETJL/lbpzZU78ik6U3XQDa0k8dNLcMYZUOvqcqy3zc6hdCeugw20QmY3En2bbQRjflxky85GPTEIXo/WjhYqPcPWxQPTzs5e64TVXJABSLg7r6WtJjgW1lt2l6Ya6lnF7GQit8Y/5TuwV/KOsKcv54msigJsSTg0C+nQiv5OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKaEZ8sB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA785C4AF0B;
	Thu,  1 Aug 2024 14:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722524391;
	bh=wpL4CMyLi8WCjSI0Y3VNSmgZ34rywAFS858yBI8onb8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=iKaEZ8sBjRf9SlFW+UmrV0xtW2v1Cixfdal/A70O90hHFyPLbqcpBveucnwYUvsei
	 Qb+JzXq4hOScyz0bqvLxnrS3OPvbe48R7SEhW0c97aLXt/osLMm8t2S066RJJln1Lj
	 gQN733m+1zSgLgabeH4y0cfuJ0UopUnQwG/JgZGhhoYIcE2ZXAjsPY8w2GW6k4Q4vg
	 XY/F3aXp8HCJo6mGcdIHuEJAmPSvsuFPZ0LmhT3JKECn/uzwKc29OEYOnwQ9kFOMy/
	 47fT62gVAIkOEedDdY1kT+1nroKp61pVmc9IBAFk7/rHbCLHWi/TlJqH293bpSAN/E
	 xougqe7H1+IvQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: ath9k: fix possible integer overflow in
 ath9k_get_et_stats()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240725111743.14422-1-d.kandybka@gmail.com>
References: <20240725111743.14422-1-d.kandybka@gmail.com>
To: Dmitry Kandybka <d.kandybka@gmail.com>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 linux-wireless@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172252438879.2450489.7181636576131516547.kvalo@kernel.org>
Date: Thu,  1 Aug 2024 14:59:50 +0000 (UTC)

Dmitry Kandybka <d.kandybka@gmail.com> wrote:

> In 'ath9k_get_et_stats()', promote TX stats counters to 'u64'
> to avoid possible integer overflow. Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

3f66f2670309 wifi: ath9k: fix possible integer overflow in ath9k_get_et_stats()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240725111743.14422-1-d.kandybka@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


