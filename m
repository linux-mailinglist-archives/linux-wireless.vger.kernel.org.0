Return-Path: <linux-wireless+bounces-2153-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 309E88315E9
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 10:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61FC284B1A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 09:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6571F61A;
	Thu, 18 Jan 2024 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilgCEJMP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C94E1F612
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705570383; cv=none; b=euz3ng380ntjfYaIj1y8RNnyRAb0IvgFYpp/lo+EI7POJLKnOJfFp9TmXN32GpprFubP8MHrvAAnDVyaxVyxIZdk89yWzoaQ3r58+SAosTII5bY13s7WtkFx1jG9Xl3yoSeNWCvxgUmEX76c754qAbkxlq/kPTYRHZRVNiYPbng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705570383; c=relaxed/simple;
	bh=0ACunoRTQeM+3VFKPQhuxzpSFvELTIsVlx3RGwY5SL4=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=b2WP6UQeDRbWfrumfhY0yktPooPuPfW8DxO1O8fWkXoOic+AgMPLQR48wwc4ZIXRgQEYz2KxSJpfE3QzDLin68ggItn2wrNsdbGmxauGFsQ1yZpkNL6ETZrc877R9g4Ebxfu/tTSoQSjVG3r6QBFq8Z4HPKep9HStZMaq6kXj6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilgCEJMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FA3C433C7;
	Thu, 18 Jan 2024 09:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705570382;
	bh=0ACunoRTQeM+3VFKPQhuxzpSFvELTIsVlx3RGwY5SL4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ilgCEJMPeAzuxmrCF1DgK1sF2851fnqHbFtGGdk0vwGHHXWhIdqtdacSVdoXJ6LDC
	 Cgs09CjJOSi2Z798fEtb0tEyB/F4HxV+MlMiZZU2tdrD1MxngTsoJbo9Wwyp9TVUeG
	 xDQuzJ3oKelZfT3tV6coEDaRcH3FXydOMWMZdPxYZRxXrwKJ1T0zxkaZxy6pcpI6Zl
	 XVlcZ3x+GMF3YMRlqj+85aVVCeFG5hOUIRglPqM696+4RzfwnMDQHKtpzRgdmzGHmh
	 KM9R6w7JdOzW42uqsfGo+xg4uTt7Xd/dW3lFJPTLb59z7fQt0RCab3Nzd0v/K2Uw3P
	 +LCnmet5orymQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw88: use kstrtoX_from_user() in debugfs handlers
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240110132930.438828-1-dmantipov@yandex.ru>
References: <20240110132930.438828-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
 Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170557037964.2797779.6273012892306957351.kvalo@kernel.org>
Date: Thu, 18 Jan 2024 09:33:01 +0000 (UTC)

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> When 'sscanf()' is not needed to scan an input, prefer common
> 'kstrtoX_from_user()' over 'rtw_debugfs_copy_from_user()' with
> following 'kstrtoX()'. Minor adjustments, compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

23b8330156e5 wifi: rtw88: use kstrtoX_from_user() in debugfs handlers

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240110132930.438828-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


