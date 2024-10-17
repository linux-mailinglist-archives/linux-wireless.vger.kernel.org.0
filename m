Return-Path: <linux-wireless+bounces-14167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DE79A2990
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 18:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4F91F21893
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 16:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155FB1DF754;
	Thu, 17 Oct 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gs6wF29A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39AE1DF744;
	Thu, 17 Oct 2024 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183849; cv=none; b=IITRZY4fExentd9/p6B4HDSL5T1crWz6rVOIWkIniO6PP1yb7N1Lj3m9fTTEqEJyuiuUJKYAamdA/XQjx1RmhlvuEIAOGOh/8qQSZR14kclzApHunp8+HRSv9MStqsu2LFBxMng0X340N/5QR4/33us34PAB58lvTDzKONttvtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183849; c=relaxed/simple;
	bh=b0ty3X291n2qYnFhJOJy3qwDfWwIPZtePa+YTcMG2d8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=u4r3XnbF7eODAMAQoJZwx+ZShG127ajhR00ctjgvJslM5yGH75Dgq3hYrSevWAASBZcLWtmMbqtlS3owCsaHaFnv2yCMMoq2kS63FZcL+/mFZuq/xOgJ7K5rWdoYRucqtpezWhZdS1ElHyRycNmGKmGwD+1kswyN1VVnLQy2txg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gs6wF29A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C20C4CEC3;
	Thu, 17 Oct 2024 16:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183848;
	bh=b0ty3X291n2qYnFhJOJy3qwDfWwIPZtePa+YTcMG2d8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Gs6wF29AUiGlzWagB/JawbaoPM3W9fSlJcoRPPLhCgBB/0cjoeaU8TxbGdSbE1WHb
	 5kHhnII+ELuK4sy4qNa8oTTXPKKBlMuvG51Lkjlw7ECdyoKvd/719dZNpNLg/dIuLy
	 OZlim2nMqq0leZOUCj/ltIV/zDEIgR4M8NcEBjG7JertujlOWu5lnVnCgNICaa0OSY
	 zUH4CSWZeyh/Q22lffLz82aaIW82EMpJgwWOLNVQUu4KrfD8KdqJjJ+POzrWTLyC7e
	 5T5DIYFVGvVpBPHleWGf4AQMAj3IV1PeeTwjEUDG61tHRagvlZ+5Xv0kgo2ZnxOwYx
	 kHjrx2HMoZzhw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: cw1200: Remove unused cw1200_queue_requeue_all()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241012203852.229151-1-linux@treblig.org>
References: <20241012203852.229151-1-linux@treblig.org>
To: linux@treblig.org
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Dr. David Alan Gilbert" <linux@treblig.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172918384627.970100.15604001750511236100.kvalo@kernel.org>
Date: Thu, 17 Oct 2024 16:50:47 +0000 (UTC)

linux@treblig.org wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> cw1200_queue_requeue_all() has been unused since it was added in 2013 by commit
> a910e4a94f69 ("cw1200: add driver for the ST-E CW1100 & CW1200 WLAN chipsets")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Patch applied to wireless-next.git, thanks.

b2d23b83d8d0 wifi: cw1200: Remove unused cw1200_queue_requeue_all()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241012203852.229151-1-linux@treblig.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


