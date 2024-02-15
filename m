Return-Path: <linux-wireless+bounces-3620-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 096E3856114
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 12:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37CA292A88
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 11:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7875D66B2D;
	Thu, 15 Feb 2024 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zr/v0c87"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B9917581
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995486; cv=none; b=kcCJRLD3LPJzd9pp3/x8BJ1txUw9bcoFA8h58Sa2yb3OhdO6//CTNQbNfqnUeee4CROuuvxuSFNlSbPf2PElzmwO25CbKT7f7yjM1uXVEH3zIIfzblttIOPcWuy9qzgZdAfcHd8AjfvnorawkOy5hd+R4EFHnr+JLAFBHZYWbIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995486; c=relaxed/simple;
	bh=re/T8QH2A4g4shF9CTVUxLN6v2HsUVqXlDbxQI+hYlA=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=bN/2P67oWc6i/e/BsxfFb/mr8yK8zoP+EGrXz5dxnQMbazzYZ54YEhaR46F7IXnEtYFVUc13pjYjRQtEENtq2ZnM2DjgKJ1htag3nea9uFByytmiPnpg+2SoTJ0+rKOnFidO/L9vMdGyxF+cTfji/eDQkaecu7d1A0JFJkHVMjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zr/v0c87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E650EC433F1;
	Thu, 15 Feb 2024 11:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707995485;
	bh=re/T8QH2A4g4shF9CTVUxLN6v2HsUVqXlDbxQI+hYlA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Zr/v0c87UmvZumweTqct/U4SkMRrpWDI6bmeRzaLmH40xeMa9xG0aNpdsBVpjQkqH
	 p5dhRbnt8STLbRr4kbavrWEuWP6rF+HLYuUZmDdfJWWk5RK9nMZYhqXQTjkbtnQWFy
	 PWOz+9H0wYOAmkJdaDSDyyQJuH/exwGFNKv19pPRGz0e5USDtCrJHKb9BDTXWyUy8o
	 Hnby6cLQi3o4NQvzgFnMv4e5w9j1hK0LJjVVWUkMqXsKJXGen02nI7weu3oqW34Don
	 r/72Uz0Tdc9rVsQ1XzC37742EBMLfos252dM7Vdm1ZnaIKDzYSEyI3l5Z0GbJ74CAh
	 d3rlLlaP1KOcw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtlwifi: rtl_usb: Store the endpoint addresses
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <7b6a602a-6101-4bab-958d-bcff4d565b40@gmail.com>
References: <7b6a602a-6101-4bab-958d-bcff4d565b40@gmail.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>, Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170799548274.3764215.15224915088048661970.kvalo@kernel.org>
Date: Thu, 15 Feb 2024 11:11:24 +0000 (UTC)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> And use the stored addresses in rtl8192cu instead of hardcoding them.
> 
> This is what the vendor drivers do.
> 
> Perhaps this is not strictly necessary for RTL8192CU devices. However,
> the dual mac version of RTL8192DU has two USB interfaces, each with its
> own set of endpoints. Hardcoding their addresses in the upcoming
> rtl8192du driver would require making some assumptions which I'm not
> qualified to make.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

42ffccd0a36e wifi: rtlwifi: rtl_usb: Store the endpoint addresses

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/7b6a602a-6101-4bab-958d-bcff4d565b40@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


